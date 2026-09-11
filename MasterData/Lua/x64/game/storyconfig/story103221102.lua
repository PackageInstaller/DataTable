return {
	Play322112001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322112001
		arg_1_1.duration_ = 3.33

		local var_1_0 = {
			zh = 3.333,
			ja = 3.066
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
				arg_1_0:Play322112002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.MS2206 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2206")
				var_4_0.name = "MS2206"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.MS2206 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.MS2206

				arg_1_1.bgs_.MS2206.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "MS2206" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_stone_l19f", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			local var_4_16 = arg_1_1.bgs_.MS2206.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosMS2206 = var_4_16.localPosition
			end

			local var_4_17 = 2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_17 then
				var_4_16.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosMS2206, Vector3.New(0, 3, 0), (arg_1_1.time_ - 0) / var_4_17)
			end

			if arg_1_1.time_ >= 0 + var_4_17 and arg_1_1.time_ < 0 + var_4_17 + arg_4_0 then
				var_4_16.localPosition = Vector3.New(0, 3, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 2
			local var_4_19 = 0.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_21 = arg_1_1:GetWordFromCfg(322112001)
				local var_4_22 = arg_1_1:FormatText(var_4_21.content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 5 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 5)

				if (5 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 5)) > 0 and var_4_19 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_18 = var_4_18 + 0.3

					if var_4_24 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112001", "story_v_out_322112.awb") ~= 0 then
					local var_4_25 = manager.audio:GetVoiceLength("story_v_out_322112", "322112001", "story_v_out_322112.awb") / 1000

					if var_4_25 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_18
					end

					if var_4_21.prefab_name ~= "" and arg_1_1.actors_[var_4_21.prefab_name] ~= nil then
						local var_4_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_21.prefab_name].transform, "story_v_out_322112", "322112001", "story_v_out_322112.awb")

						arg_1_1:RecordAudio("322112001", var_4_26)
						arg_1_1:RecordAudio("322112001", var_4_26)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322112", "322112001", "story_v_out_322112.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322112", "322112001", "story_v_out_322112.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_27 = var_4_18 + 0.3
			local var_4_28 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_28 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_27) / var_4_28

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_27 + var_4_28 and arg_1_1.time_ < var_4_27 + var_4_28 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2206",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 2.5, 0),
					endPos = Vector3.New(0, 3, 0),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322112002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322112002
		arg_9_1.duration_ = 9.6

		local var_9_0 = {
			zh = 9,
			ja = 9.6
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
				arg_9_0:Play322112003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.9

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(322112002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 36 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 36)

				if (36 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 36)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112002", "story_v_out_322112.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112002", "story_v_out_322112.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_322112", "322112002", "story_v_out_322112.awb")

						arg_9_1:RecordAudio("322112002", var_12_6)
						arg_9_1:RecordAudio("322112002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_322112", "322112002", "story_v_out_322112.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_322112", "322112002", "story_v_out_322112.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play322112003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322112003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play322112004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 1 < arg_13_1.time_ and arg_13_1.time_ <= 1 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_145", "se_story_145_summon_laser2", "")
			end

			local var_16_1 = manager.ui.mainCamera.transform

			if 1 < arg_13_1.time_ and arg_13_1.time_ <= 1 + arg_16_0 then
				arg_13_1.var_.shakeOldPos = var_16_1.localPosition
			end

			local var_16_2 = 0.266666666666667

			if 1 <= arg_13_1.time_ and arg_13_1.time_ < 1 + var_16_2 then
				local var_16_3, var_16_4 = math.modf((arg_13_1.time_ - 1) / 0.066)

				var_16_1.localPosition = Vector3.New(var_16_4 * 0.13, var_16_4 * 0.13, var_16_4 * 0.13) + arg_13_1.var_.shakeOldPos
			end

			if arg_13_1.time_ >= 1 + var_16_2 and arg_13_1.time_ < 1 + var_16_2 + arg_16_0 then
				var_16_1.localPosition = arg_13_1.var_.shakeOldPos
			end

			local var_16_5 = 0
			local var_16_6 = 1.775

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(322112003).content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 71 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_7) / 71)

				if (71 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_7) / 71)) > 0 and var_16_6 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_6, arg_13_1.talkMaxDuration)

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_5) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_5 + var_16_10 and arg_13_1.time_ < var_16_5 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play322112004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322112004
		arg_17_1.duration_ = 5.33

		local var_17_0 = {
			zh = 3.7,
			ja = 5.333
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
				arg_17_0:Play322112005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.5

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(322112004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 20 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 20)

				if (20 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 20)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112004", "story_v_out_322112.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112004", "story_v_out_322112.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_322112", "322112004", "story_v_out_322112.awb")

						arg_17_1:RecordAudio("322112004", var_20_6)
						arg_17_1:RecordAudio("322112004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_322112", "322112004", "story_v_out_322112.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_322112", "322112004", "story_v_out_322112.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play322112005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322112005
		arg_21_1.duration_ = 4.93

		local var_21_0 = {
			zh = 2.933,
			ja = 4.933
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
				arg_21_0:Play322112006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.4

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(322112005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 16 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 16)

				if (16 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 16)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112005", "story_v_out_322112.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112005", "story_v_out_322112.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_322112", "322112005", "story_v_out_322112.awb")

						arg_21_1:RecordAudio("322112005", var_24_6)
						arg_21_1:RecordAudio("322112005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_322112", "322112005", "story_v_out_322112.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_322112", "322112005", "story_v_out_322112.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play322112006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322112006
		arg_25_1.duration_ = 7.03

		local var_25_0 = {
			zh = 4.5,
			ja = 7.033
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
				arg_25_0:Play322112007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.4

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(322112006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 16 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 16)

				if (16 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 16)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112006", "story_v_out_322112.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112006", "story_v_out_322112.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_322112", "322112006", "story_v_out_322112.awb")

						arg_25_1:RecordAudio("322112006", var_28_6)
						arg_25_1:RecordAudio("322112006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322112", "322112006", "story_v_out_322112.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322112", "322112006", "story_v_out_322112.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play322112007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322112007
		arg_29_1.duration_ = 2.27

		local var_29_0 = {
			zh = 1.266,
			ja = 2.266
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
				arg_29_0:Play322112008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.075

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(322112007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 3 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 3)

				if (3 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 3)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112007", "story_v_out_322112.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112007", "story_v_out_322112.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_322112", "322112007", "story_v_out_322112.awb")

						arg_29_1:RecordAudio("322112007", var_32_6)
						arg_29_1:RecordAudio("322112007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322112", "322112007", "story_v_out_322112.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322112", "322112007", "story_v_out_322112.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play322112008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322112008
		arg_33_1.duration_ = 5.77

		local var_33_0 = {
			zh = 2.233,
			ja = 5.766
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
				arg_33_0:Play322112009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.25

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(322112008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 10 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 10)

				if (10 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 10)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112008", "story_v_out_322112.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112008", "story_v_out_322112.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_322112", "322112008", "story_v_out_322112.awb")

						arg_33_1:RecordAudio("322112008", var_36_6)
						arg_33_1:RecordAudio("322112008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_322112", "322112008", "story_v_out_322112.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_322112", "322112008", "story_v_out_322112.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play322112009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322112009
		arg_37_1.duration_ = 9.5

		local var_37_0 = {
			zh = 7.1,
			ja = 9.5
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
				arg_37_0:Play322112010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.725

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(322112009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 29 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 29)

				if (29 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 29)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112009", "story_v_out_322112.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112009", "story_v_out_322112.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_322112", "322112009", "story_v_out_322112.awb")

						arg_37_1:RecordAudio("322112009", var_40_6)
						arg_37_1:RecordAudio("322112009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322112", "322112009", "story_v_out_322112.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322112", "322112009", "story_v_out_322112.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play322112010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322112010
		arg_41_1.duration_ = 7.7

		local var_41_0 = {
			zh = 4.466,
			ja = 7.7
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
				arg_41_0:Play322112011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.425

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_41_1.callingController_:SetSelectedState("calling")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(322112010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 17 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 17)

				if (17 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 17)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112010", "story_v_out_322112.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112010", "story_v_out_322112.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_322112", "322112010", "story_v_out_322112.awb")

						arg_41_1:RecordAudio("322112010", var_44_6)
						arg_41_1:RecordAudio("322112010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322112", "322112010", "story_v_out_322112.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322112", "322112010", "story_v_out_322112.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play322112011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322112011
		arg_45_1.duration_ = 2.77

		local var_45_0 = {
			zh = 1.6,
			ja = 2.766
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
				arg_45_0:Play322112012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.2

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_45_1.callingController_:SetSelectedState("calling")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(322112011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 8 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 8)

				if (8 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 8)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112011", "story_v_out_322112.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112011", "story_v_out_322112.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_322112", "322112011", "story_v_out_322112.awb")

						arg_45_1:RecordAudio("322112011", var_48_6)
						arg_45_1:RecordAudio("322112011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_322112", "322112011", "story_v_out_322112.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_322112", "322112011", "story_v_out_322112.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play322112012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322112012
		arg_49_1.duration_ = 10.6

		local var_49_0 = {
			zh = 5.666,
			ja = 10.6
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
				arg_49_0:Play322112013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.675

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(322112012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 27 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 27)

				if (27 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 27)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112012", "story_v_out_322112.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112012", "story_v_out_322112.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_322112", "322112012", "story_v_out_322112.awb")

						arg_49_1:RecordAudio("322112012", var_52_6)
						arg_49_1:RecordAudio("322112012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322112", "322112012", "story_v_out_322112.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322112", "322112012", "story_v_out_322112.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play322112013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322112013
		arg_53_1.duration_ = 5.83

		local var_53_0 = {
			zh = 5.833,
			ja = 5.8
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
				arg_53_0:Play322112014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.5

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(322112013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 20 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 20)

				if (20 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 20)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112013", "story_v_out_322112.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112013", "story_v_out_322112.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_322112", "322112013", "story_v_out_322112.awb")

						arg_53_1:RecordAudio("322112013", var_56_6)
						arg_53_1:RecordAudio("322112013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322112", "322112013", "story_v_out_322112.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322112", "322112013", "story_v_out_322112.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play322112014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322112014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play322112015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 1.375

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(322112014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 55 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 55)

				if (55 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 55)) > 0 and var_60_0 < var_60_3 then
					arg_57_1.talkMaxDuration = var_60_3

					if var_60_3 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_3 + 0
					end
				end

				arg_57_1.text_.text = var_60_1
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_4 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_4

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play322112015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322112015
		arg_61_1.duration_ = 3.12

		local var_61_0 = {
			zh = 1.083,
			ja = 3.116
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
				arg_61_0:Play322112016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			if arg_61_1.time_ >= 0 + 0.233333333333333 and arg_61_1.time_ < 0 + 0.233333333333333 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			local var_64_0 = arg_61_1.bgs_.MS2206.transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPosMS2206 = var_64_0.localPosition
			end

			local var_64_1 = 0.366666666666667

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPosMS2206, Vector3.New(0, 1, 10), (arg_61_1.time_ - 0) / var_64_1)
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_2 = 0.05
			local var_64_3 = 0.05

			if 0.05 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_4 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_4:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_5 = arg_61_1:GetWordFromCfg(322112015)
				local var_64_6 = arg_61_1:FormatText(var_64_5.content)

				arg_61_1.text_.text = var_64_6

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_8 = 2 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_6) / 2)

				if (2 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_6) / 2)) > 0 and var_64_3 < var_64_8 then
					arg_61_1.talkMaxDuration = var_64_8
					var_64_2 = var_64_2 + 0.3

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_6
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112015", "story_v_out_322112.awb") ~= 0 then
					local var_64_9 = manager.audio:GetVoiceLength("story_v_out_322112", "322112015", "story_v_out_322112.awb") / 1000

					if var_64_9 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_2
					end

					if var_64_5.prefab_name ~= "" and arg_61_1.actors_[var_64_5.prefab_name] ~= nil then
						local var_64_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_5.prefab_name].transform, "story_v_out_322112", "322112015", "story_v_out_322112.awb")

						arg_61_1:RecordAudio("322112015", var_64_10)
						arg_61_1:RecordAudio("322112015", var_64_10)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322112", "322112015", "story_v_out_322112.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322112", "322112015", "story_v_out_322112.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_11 = var_64_2 + 0.3
			local var_64_12 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_11 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_11) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_11 + var_64_12 and arg_61_1.time_ < var_64_11 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2206",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.366666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 3, 0),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play322112016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 322112016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play322112017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.925

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(322112016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 37 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 37)

				if (37 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 37)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play322112017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322112017
		arg_71_1.duration_ = 9

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play322112018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if arg_71_1.bgs_.ST2102a == nil then
				local var_74_0 = Object.Instantiate(arg_71_1.paintGo_)

				var_74_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2102a")
				var_74_0.name = "ST2102a"
				var_74_0.transform.parent = arg_71_1.stage_.transform
				var_74_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.bgs_.ST2102a = var_74_0
			end

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= 2 + arg_74_0 then
				local var_74_1 = arg_71_1.bgs_.ST2102a

				arg_71_1.bgs_.ST2102a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_74_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_2 = var_74_1:GetComponent("SpriteRenderer")

				if var_74_2 and var_74_2.sprite then
					local var_74_3 = 2 * (var_74_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_74_1.transform.localScale = Vector3.New(var_74_3 / var_74_2.sprite.bounds.size.y < var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x and var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x or var_74_3 / var_74_2.sprite.bounds.size.y, var_74_3 / var_74_2.sprite.bounds.size.y < var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x and var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x or var_74_3 / var_74_2.sprite.bounds.size.y, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "ST2102a" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_4 = 4

			if 4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.allBtn_.enabled = false
			end

			if arg_71_1.time_ >= var_74_4 + 0.3 and arg_71_1.time_ < var_74_4 + 0.3 + arg_74_0 then
				arg_71_1.allBtn_.enabled = true
			end

			local var_74_5 = 0

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_6 = 2

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_6 then
				local var_74_7 = Color.New(0, 0, 0)

				var_74_7.a = Mathf.Lerp(0, 1, (arg_71_1.time_ - var_74_5) / var_74_6)
				arg_71_1.mask_.color = var_74_7
			end

			if arg_71_1.time_ >= var_74_5 + var_74_6 and arg_71_1.time_ < var_74_5 + var_74_6 + arg_74_0 then
				local var_74_8 = Color.New(0, 0, 0)

				var_74_8.a = 1
				arg_71_1.mask_.color = var_74_8
			end

			local var_74_9 = 2

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_10 = 2

			if var_74_9 <= arg_71_1.time_ and arg_71_1.time_ < var_74_9 + var_74_10 then
				local var_74_11 = Color.New(0, 0, 0)

				var_74_11.a = Mathf.Lerp(1, 0, (arg_71_1.time_ - var_74_9) / var_74_10)
				arg_71_1.mask_.color = var_74_11
			end

			if arg_71_1.time_ >= var_74_9 + var_74_10 and arg_71_1.time_ < var_74_9 + var_74_10 + arg_74_0 then
				local var_74_12 = Color.New(0, 0, 0)

				arg_71_1.mask_.enabled = false
				var_74_12.a = 0
				arg_71_1.mask_.color = var_74_12
			end

			if 0.166666666666667 < arg_71_1.time_ and arg_71_1.time_ <= 0.166666666666667 + arg_74_0 then
				arg_71_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_stone_l19f", "")
			end

			if 1.53333333333333 < arg_71_1.time_ and arg_71_1.time_ <= 1.53333333333333 + arg_74_0 then
				arg_71_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 1.53333333333333 < arg_71_1.time_ and arg_71_1.time_ <= 1.53333333333333 + arg_74_0 then
				arg_71_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_74_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_18 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_18

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_18
						arg_71_1.bgmTxt2_.text = var_74_18
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.500666666666667 < arg_71_1.time_ and arg_71_1.time_ <= 0.500666666666667 + arg_74_0 then
				arg_71_1:AudioAction("play", "music", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard.awb")

				local var_74_21 = manager.audio:GetAudioName("bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard")

				if "" ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_21 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_21

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_21
						arg_71_1.bgmTxt2_.text = var_74_21
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_22 = 4
			local var_74_23 = 1.025

			if 4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_22 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_24 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_24:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_71_1.dialogCg_.alpha = arg_77_0
				end))
				var_74_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_25 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(322112017).content)

				arg_71_1.text_.text = var_74_25

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_27 = 41 <= 0 and var_74_23 or var_74_23 * (utf8.len(var_74_25) / 41)

				if (41 <= 0 and var_74_23 or var_74_23 * (utf8.len(var_74_25) / 41)) > 0 and var_74_23 < var_74_27 then
					arg_71_1.talkMaxDuration = var_74_27
					var_74_22 = var_74_22 + 0.3

					if var_74_27 + var_74_22 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_27 + var_74_22
					end
				end

				arg_71_1.text_.text = var_74_25
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_28 = var_74_22 + 0.3
			local var_74_29 = math.max(var_74_23, arg_71_1.talkMaxDuration)

			if var_74_22 + 0.3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_28 + var_74_29 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_28) / var_74_29

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_28 + var_74_29 and arg_71_1.time_ < var_74_28 + var_74_29 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play322112018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 322112018
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play322112019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0.5 < arg_79_1.time_ and arg_79_1.time_ <= 0.5 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_walk", "")
			end

			local var_82_1 = 0
			local var_82_2 = 1.15

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(322112018).content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 46 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 46)

				if (46 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 46)) > 0 and var_82_2 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_6 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_6 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_6

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_6 and arg_79_1.time_ < var_82_1 + var_82_6 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play322112019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 322112019
		arg_83_1.duration_ = 5.63

		local var_83_0 = {
			zh = 3.4,
			ja = 5.633
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
				arg_83_0:Play322112020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.4

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_1 = arg_83_1:GetWordFromCfg(322112019)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 16 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 16)

				if (16 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 16)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112019", "story_v_out_322112.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112019", "story_v_out_322112.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_322112", "322112019", "story_v_out_322112.awb")

						arg_83_1:RecordAudio("322112019", var_86_6)
						arg_83_1:RecordAudio("322112019", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_322112", "322112019", "story_v_out_322112.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_322112", "322112019", "story_v_out_322112.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play322112020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 322112020
		arg_87_1.duration_ = 10.73

		local var_87_0 = {
			zh = 7.433,
			ja = 10.733
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
				arg_87_0:Play322112021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if arg_87_1.actors_["10049ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10049ui_story"))) then
				local var_90_0 = Object.Instantiate(Asset.Load("Char/" .. "10049ui_story"), arg_87_1.stage_.transform)

				var_90_0.name = "10049ui_story"
				var_90_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["10049ui_story"] = var_90_0

				local var_90_1 = var_90_0:GetComponentInChildren(typeof(CharacterEffect))

				var_90_1.enabled = true

				local var_90_2 = GameObjectTools.GetOrAddComponent(var_90_0, typeof(DynamicBoneHelper))

				if var_90_2 then
					var_90_2:EnableDynamicBone(false)
				end

				arg_87_1:ShowWeapon(var_90_1.transform, false)

				arg_87_1.var_["10049ui_story" .. "Animator"] = var_90_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_87_1.var_["10049ui_story" .. "Animator"].applyRootMotion = true
				arg_87_1.var_["10049ui_story" .. "LipSync"] = var_90_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_90_3 = arg_87_1.actors_["10049ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10049ui_story = var_90_3.localPosition

				local var_90_4 = GameObjectTools.GetOrAddComponent(var_90_3.gameObject, typeof(DynamicBoneHelper))

				if var_90_4 then
					var_90_4:EnableDynamicBone(false)
				end
			end

			local var_90_5 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_5 then
				var_90_3.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10049ui_story, Vector3.New(0, -1.13, -6), (arg_87_1.time_ - 0) / var_90_5)
				var_90_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_3.position).x, (manager.ui.mainCamera.transform.position - var_90_3.position).y, (manager.ui.mainCamera.transform.position - var_90_3.position).z)
				var_90_3.localEulerAngles.z = 0
				var_90_3.localEulerAngles.x = 0
				var_90_3.localEulerAngles = var_90_3.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_5 and arg_87_1.time_ < 0 + var_90_5 + arg_90_0 then
				var_90_3.localPosition = Vector3.New(0, -1.13, -6)
				var_90_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_3.position).x, (manager.ui.mainCamera.transform.position - var_90_3.position).y, (manager.ui.mainCamera.transform.position - var_90_3.position).z)
				var_90_3.localEulerAngles.z = 0
				var_90_3.localEulerAngles.x = 0
				var_90_3.localEulerAngles = var_90_3.localEulerAngles

				local var_90_6 = GameObjectTools.GetOrAddComponent(var_90_3.gameObject, typeof(DynamicBoneHelper))

				if var_90_6 then
					var_90_6:EnableDynamicBone(true)
				end
			end

			local var_90_7 = arg_87_1.actors_["10049ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_7) and arg_87_1.var_.characterEffect10049ui_story == nil then
				arg_87_1.var_.characterEffect10049ui_story = var_90_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_8 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_8 and not isNil(var_90_7) then
				if arg_87_1.var_.characterEffect10049ui_story and not isNil(var_90_7) then
					arg_87_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_8 and arg_87_1.time_ < 0 + var_90_8 + arg_90_0 and not isNil(var_90_7) and arg_87_1.var_.characterEffect10049ui_story then
				arg_87_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action1_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				if not isNil(arg_87_1.actors_["10049ui_story"]) then
					local var_90_10 = GameObjectTools.GetOrAddComponent(arg_87_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_90_10 then
						var_90_10:EnableDynamicBone(true)
					end
				end
			end

			local var_90_11 = 0
			local var_90_12 = 0.7

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_11 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_13 = arg_87_1:GetWordFromCfg(322112020)
				local var_90_14 = arg_87_1:FormatText(var_90_13.content)

				arg_87_1.text_.text = var_90_14

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_16 = 28 <= 0 and var_90_12 or var_90_12 * (utf8.len(var_90_14) / 28)

				if (28 <= 0 and var_90_12 or var_90_12 * (utf8.len(var_90_14) / 28)) > 0 and var_90_12 < var_90_16 then
					arg_87_1.talkMaxDuration = var_90_16

					if var_90_16 + var_90_11 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_16 + var_90_11
					end
				end

				arg_87_1.text_.text = var_90_14
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112020", "story_v_out_322112.awb") ~= 0 then
					local var_90_17 = manager.audio:GetVoiceLength("story_v_out_322112", "322112020", "story_v_out_322112.awb") / 1000

					if var_90_17 + var_90_11 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_17 + var_90_11
					end

					if var_90_13.prefab_name ~= "" and arg_87_1.actors_[var_90_13.prefab_name] ~= nil then
						local var_90_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_13.prefab_name].transform, "story_v_out_322112", "322112020", "story_v_out_322112.awb")

						arg_87_1:RecordAudio("322112020", var_90_18)
						arg_87_1:RecordAudio("322112020", var_90_18)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_322112", "322112020", "story_v_out_322112.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_322112", "322112020", "story_v_out_322112.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_19 = math.max(var_90_12, arg_87_1.talkMaxDuration)

			if var_90_11 <= arg_87_1.time_ and arg_87_1.time_ < var_90_11 + var_90_19 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_11) / var_90_19

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_11 + var_90_19 and arg_87_1.time_ < var_90_11 + var_90_19 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play322112021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 322112021
		arg_91_1.duration_ = 6.4

		local var_91_0 = {
			zh = 5.666,
			ja = 6.4
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
				arg_91_0:Play322112022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["10049ui_story"]) and arg_91_1.var_.characterEffect10049ui_story == nil then
				arg_91_1.var_.characterEffect10049ui_story = arg_91_1.actors_["10049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["10049ui_story"]) then
				if arg_91_1.var_.characterEffect10049ui_story and not isNil(arg_91_1.actors_["10049ui_story"]) then
					arg_91_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_91_1.var_.characterEffect10049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_0)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["10049ui_story"]) and arg_91_1.var_.characterEffect10049ui_story then
				arg_91_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_91_1.var_.characterEffect10049ui_story.fillRatio = 0.5
			end

			local var_94_1 = 0
			local var_94_2 = 0.7

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(322112021)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_6 = 28 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_4) / 28)

				if (28 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_4) / 28)) > 0 and var_94_2 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112021", "story_v_out_322112.awb") ~= 0 then
					local var_94_7 = manager.audio:GetVoiceLength("story_v_out_322112", "322112021", "story_v_out_322112.awb") / 1000

					if var_94_7 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_1
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_322112", "322112021", "story_v_out_322112.awb")

						arg_91_1:RecordAudio("322112021", var_94_8)
						arg_91_1:RecordAudio("322112021", var_94_8)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_322112", "322112021", "story_v_out_322112.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_322112", "322112021", "story_v_out_322112.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_9 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_9 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_9

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_9 and arg_91_1.time_ < var_94_1 + var_94_9 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play322112022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 322112022
		arg_95_1.duration_ = 4.4

		local var_95_0 = {
			zh = 2.266,
			ja = 4.4
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
				arg_95_0:Play322112023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10049ui_story = arg_95_1.actors_["10049ui_story"].transform.localPosition

				local var_98_0 = GameObjectTools.GetOrAddComponent(arg_95_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_98_0 then
					var_98_0:EnableDynamicBone(false)
				end
			end

			local var_98_1 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 then
				arg_95_1.actors_["10049ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10049ui_story, Vector3.New(0, -1.13, -6), (arg_95_1.time_ - 0) / var_98_1)
				arg_95_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10049ui_story"].transform.position).z)
				arg_95_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10049ui_story"].transform.localEulerAngles = arg_95_1.actors_["10049ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 then
				arg_95_1.actors_["10049ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6)
				arg_95_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10049ui_story"].transform.position).z)
				arg_95_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10049ui_story"].transform.localEulerAngles = arg_95_1.actors_["10049ui_story"].transform.localEulerAngles

				local var_98_2 = GameObjectTools.GetOrAddComponent(arg_95_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_98_2 then
					var_98_2:EnableDynamicBone(true)
				end
			end

			local var_98_3 = arg_95_1.actors_["10049ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_3) and arg_95_1.var_.characterEffect10049ui_story == nil then
				arg_95_1.var_.characterEffect10049ui_story = var_98_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_4 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 and not isNil(var_98_3) then
				if arg_95_1.var_.characterEffect10049ui_story and not isNil(var_98_3) then
					arg_95_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 and not isNil(var_98_3) and arg_95_1.var_.characterEffect10049ui_story then
				arg_95_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action1_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				if not isNil(arg_95_1.actors_["10049ui_story"]) then
					local var_98_6 = GameObjectTools.GetOrAddComponent(arg_95_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_98_6 then
						var_98_6:EnableDynamicBone(true)
					end
				end
			end

			local var_98_7 = 0
			local var_98_8 = 0.2

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_7 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_9 = arg_95_1:GetWordFromCfg(322112022)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_12 = 8 <= 0 and var_98_8 or var_98_8 * (utf8.len(var_98_10) / 8)

				if (8 <= 0 and var_98_8 or var_98_8 * (utf8.len(var_98_10) / 8)) > 0 and var_98_8 < var_98_12 then
					arg_95_1.talkMaxDuration = var_98_12

					if var_98_12 + var_98_7 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_12 + var_98_7
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112022", "story_v_out_322112.awb") ~= 0 then
					local var_98_13 = manager.audio:GetVoiceLength("story_v_out_322112", "322112022", "story_v_out_322112.awb") / 1000

					if var_98_13 + var_98_7 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_7
					end

					if var_98_9.prefab_name ~= "" and arg_95_1.actors_[var_98_9.prefab_name] ~= nil then
						local var_98_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_9.prefab_name].transform, "story_v_out_322112", "322112022", "story_v_out_322112.awb")

						arg_95_1:RecordAudio("322112022", var_98_14)
						arg_95_1:RecordAudio("322112022", var_98_14)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_322112", "322112022", "story_v_out_322112.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_322112", "322112022", "story_v_out_322112.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_15 = math.max(var_98_8, arg_95_1.talkMaxDuration)

			if var_98_7 <= arg_95_1.time_ and arg_95_1.time_ < var_98_7 + var_98_15 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_7) / var_98_15

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_7 + var_98_15 and arg_95_1.time_ < var_98_7 + var_98_15 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play322112023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 322112023
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play322112024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10049ui_story = arg_99_1.actors_["10049ui_story"].transform.localPosition

				local var_102_0 = GameObjectTools.GetOrAddComponent(arg_99_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_102_0 then
					var_102_0:EnableDynamicBone(false)
				end
			end

			local var_102_1 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_1 then
				arg_99_1.actors_["10049ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10049ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_1)
				arg_99_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10049ui_story"].transform.position).z)
				arg_99_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10049ui_story"].transform.localEulerAngles = arg_99_1.actors_["10049ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_1 and arg_99_1.time_ < 0 + var_102_1 + arg_102_0 then
				arg_99_1.actors_["10049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10049ui_story"].transform.position).z)
				arg_99_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10049ui_story"].transform.localEulerAngles = arg_99_1.actors_["10049ui_story"].transform.localEulerAngles

				local var_102_2 = GameObjectTools.GetOrAddComponent(arg_99_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_102_2 then
					var_102_2:EnableDynamicBone(true)
				end
			end

			local var_102_3 = 0
			local var_102_4 = 0.725

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_5 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(322112023).content)

				arg_99_1.text_.text = var_102_5

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_7 = 29 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 29)

				if (29 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 29)) > 0 and var_102_4 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_3 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_3
					end
				end

				arg_99_1.text_.text = var_102_5
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_4, arg_99_1.talkMaxDuration)

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_3) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_3 + var_102_8 and arg_99_1.time_ < var_102_3 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play322112024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 322112024
		arg_103_1.duration_ = 7.5

		local var_103_0 = {
			zh = 5.8,
			ja = 7.5
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
				arg_103_0:Play322112025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.75

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_1 = arg_103_1:GetWordFromCfg(322112024)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 30 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 30)

				if (30 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 30)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112024", "story_v_out_322112.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112024", "story_v_out_322112.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_out_322112", "322112024", "story_v_out_322112.awb")

						arg_103_1:RecordAudio("322112024", var_106_6)
						arg_103_1:RecordAudio("322112024", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_322112", "322112024", "story_v_out_322112.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_322112", "322112024", "story_v_out_322112.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play322112025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 322112025
		arg_107_1.duration_ = 7.37

		local var_107_0 = {
			zh = 7.366,
			ja = 6.966
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
				arg_107_0:Play322112026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10049ui_story = arg_107_1.actors_["10049ui_story"].transform.localPosition

				local var_110_0 = GameObjectTools.GetOrAddComponent(arg_107_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_110_0 then
					var_110_0:EnableDynamicBone(false)
				end
			end

			local var_110_1 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 then
				arg_107_1.actors_["10049ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10049ui_story, Vector3.New(0, -1.13, -6), (arg_107_1.time_ - 0) / var_110_1)
				arg_107_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10049ui_story"].transform.position).z)
				arg_107_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["10049ui_story"].transform.localEulerAngles = arg_107_1.actors_["10049ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 then
				arg_107_1.actors_["10049ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6)
				arg_107_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10049ui_story"].transform.position).z)
				arg_107_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["10049ui_story"].transform.localEulerAngles = arg_107_1.actors_["10049ui_story"].transform.localEulerAngles

				local var_110_2 = GameObjectTools.GetOrAddComponent(arg_107_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_110_2 then
					var_110_2:EnableDynamicBone(true)
				end
			end

			local var_110_3 = arg_107_1.actors_["10049ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_3) and arg_107_1.var_.characterEffect10049ui_story == nil then
				arg_107_1.var_.characterEffect10049ui_story = var_110_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_4 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 and not isNil(var_110_3) then
				if arg_107_1.var_.characterEffect10049ui_story and not isNil(var_110_3) then
					arg_107_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 and not isNil(var_110_3) and arg_107_1.var_.characterEffect10049ui_story then
				arg_107_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action3_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				if not isNil(arg_107_1.actors_["10049ui_story"]) then
					local var_110_6 = GameObjectTools.GetOrAddComponent(arg_107_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_110_6 then
						var_110_6:EnableDynamicBone(true)
					end
				end
			end

			local var_110_7 = 0
			local var_110_8 = 0.775

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_7 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_9 = arg_107_1:GetWordFromCfg(322112025)
				local var_110_10 = arg_107_1:FormatText(var_110_9.content)

				arg_107_1.text_.text = var_110_10

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_12 = 31 <= 0 and var_110_8 or var_110_8 * (utf8.len(var_110_10) / 31)

				if (31 <= 0 and var_110_8 or var_110_8 * (utf8.len(var_110_10) / 31)) > 0 and var_110_8 < var_110_12 then
					arg_107_1.talkMaxDuration = var_110_12

					if var_110_12 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_12 + var_110_7
					end
				end

				arg_107_1.text_.text = var_110_10
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112025", "story_v_out_322112.awb") ~= 0 then
					local var_110_13 = manager.audio:GetVoiceLength("story_v_out_322112", "322112025", "story_v_out_322112.awb") / 1000

					if var_110_13 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_7
					end

					if var_110_9.prefab_name ~= "" and arg_107_1.actors_[var_110_9.prefab_name] ~= nil then
						local var_110_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_9.prefab_name].transform, "story_v_out_322112", "322112025", "story_v_out_322112.awb")

						arg_107_1:RecordAudio("322112025", var_110_14)
						arg_107_1:RecordAudio("322112025", var_110_14)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_322112", "322112025", "story_v_out_322112.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_322112", "322112025", "story_v_out_322112.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_15 = math.max(var_110_8, arg_107_1.talkMaxDuration)

			if var_110_7 <= arg_107_1.time_ and arg_107_1.time_ < var_110_7 + var_110_15 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_7) / var_110_15

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_7 + var_110_15 and arg_107_1.time_ < var_110_7 + var_110_15 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play322112026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 322112026
		arg_111_1.duration_ = 10.97

		local var_111_0 = {
			zh = 8.033,
			ja = 10.966
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
				arg_111_0:Play322112027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.85

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:GetWordFromCfg(322112026)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 34 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 34)

				if (34 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 34)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112026", "story_v_out_322112.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112026", "story_v_out_322112.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_322112", "322112026", "story_v_out_322112.awb")

						arg_111_1:RecordAudio("322112026", var_114_6)
						arg_111_1:RecordAudio("322112026", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_322112", "322112026", "story_v_out_322112.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_322112", "322112026", "story_v_out_322112.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play322112027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 322112027
		arg_115_1.duration_ = 7.2

		local var_115_0 = {
			zh = 7.2,
			ja = 6.666
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
				arg_115_0:Play322112028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.6

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:GetWordFromCfg(322112027)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 24 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 24)

				if (24 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 24)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112027", "story_v_out_322112.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112027", "story_v_out_322112.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_322112", "322112027", "story_v_out_322112.awb")

						arg_115_1:RecordAudio("322112027", var_118_6)
						arg_115_1:RecordAudio("322112027", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_322112", "322112027", "story_v_out_322112.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_322112", "322112027", "story_v_out_322112.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play322112028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 322112028
		arg_119_1.duration_ = 11.6

		local var_119_0 = {
			zh = 10.2,
			ja = 11.6
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
				arg_119_0:Play322112029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.975

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:GetWordFromCfg(322112028)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 39 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 39)

				if (39 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 39)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112028", "story_v_out_322112.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112028", "story_v_out_322112.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_322112", "322112028", "story_v_out_322112.awb")

						arg_119_1:RecordAudio("322112028", var_122_6)
						arg_119_1:RecordAudio("322112028", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_322112", "322112028", "story_v_out_322112.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_322112", "322112028", "story_v_out_322112.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play322112029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 322112029
		arg_123_1.duration_ = 5.7

		local var_123_0 = {
			zh = 5.7,
			ja = 5.466
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
				arg_123_0:Play322112030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action3_2")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				if not isNil(arg_123_1.actors_["10049ui_story"]) then
					local var_126_0 = GameObjectTools.GetOrAddComponent(arg_123_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_126_0 then
						var_126_0:EnableDynamicBone(true)
					end
				end
			end

			local var_126_1 = 0
			local var_126_2 = 0.5

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:GetWordFromCfg(322112029)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_6 = 20 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_4) / 20)

				if (20 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_4) / 20)) > 0 and var_126_2 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112029", "story_v_out_322112.awb") ~= 0 then
					local var_126_7 = manager.audio:GetVoiceLength("story_v_out_322112", "322112029", "story_v_out_322112.awb") / 1000

					if var_126_7 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_1
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_322112", "322112029", "story_v_out_322112.awb")

						arg_123_1:RecordAudio("322112029", var_126_8)
						arg_123_1:RecordAudio("322112029", var_126_8)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_322112", "322112029", "story_v_out_322112.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_322112", "322112029", "story_v_out_322112.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_9 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_9 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_9

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_9 and arg_123_1.time_ < var_126_1 + var_126_9 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play322112030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 322112030
		arg_127_1.duration_ = 9

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play322112031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.bgs_.L14f == nil then
				local var_130_0 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L14f")
				var_130_0.name = "L14f"
				var_130_0.transform.parent = arg_127_1.stage_.transform
				var_130_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_.L14f = var_130_0
			end

			if 1.999999999999 < arg_127_1.time_ and arg_127_1.time_ <= 1.999999999999 + arg_130_0 then
				local var_130_1 = arg_127_1.bgs_.L14f

				arg_127_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_130_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_2 = var_130_1:GetComponent("SpriteRenderer")

				if var_130_2 and var_130_2.sprite then
					local var_130_3 = 2 * (var_130_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_130_1.transform.localScale = Vector3.New(var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "L14f" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_4 = 4

			if 4 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			if arg_127_1.time_ >= var_130_4 + 0.3 and arg_127_1.time_ < var_130_4 + 0.3 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end

			local var_130_5 = 0

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_6 = 2

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_6 then
				local var_130_7 = Color.New(0, 0, 0)

				var_130_7.a = Mathf.Lerp(0, 1, (arg_127_1.time_ - var_130_5) / var_130_6)
				arg_127_1.mask_.color = var_130_7
			end

			if arg_127_1.time_ >= var_130_5 + var_130_6 and arg_127_1.time_ < var_130_5 + var_130_6 + arg_130_0 then
				local var_130_8 = Color.New(0, 0, 0)

				var_130_8.a = 1
				arg_127_1.mask_.color = var_130_8
			end

			local var_130_9 = 2

			if 2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_10 = 2

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_10 then
				local var_130_11 = Color.New(0, 0, 0)

				var_130_11.a = Mathf.Lerp(1, 0, (arg_127_1.time_ - var_130_9) / var_130_10)
				arg_127_1.mask_.color = var_130_11
			end

			if arg_127_1.time_ >= var_130_9 + var_130_10 and arg_127_1.time_ < var_130_9 + var_130_10 + arg_130_0 then
				local var_130_12 = Color.New(0, 0, 0)

				arg_127_1.mask_.enabled = false
				var_130_12.a = 0
				arg_127_1.mask_.color = var_130_12
			end

			local var_130_13 = arg_127_1.actors_["10049ui_story"].transform

			if 1.999999999999 < arg_127_1.time_ and arg_127_1.time_ <= 1.999999999999 + arg_130_0 then
				arg_127_1.var_.moveOldPos10049ui_story = var_130_13.localPosition

				local var_130_14 = GameObjectTools.GetOrAddComponent(var_130_13.gameObject, typeof(DynamicBoneHelper))

				if var_130_14 then
					var_130_14:EnableDynamicBone(false)
				end
			end

			local var_130_15 = 0.001

			if 1.999999999999 <= arg_127_1.time_ and arg_127_1.time_ < 1.999999999999 + var_130_15 then
				var_130_13.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10049ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 1.999999999999) / var_130_15)
				var_130_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_13.position).x, (manager.ui.mainCamera.transform.position - var_130_13.position).y, (manager.ui.mainCamera.transform.position - var_130_13.position).z)
				var_130_13.localEulerAngles.z = 0
				var_130_13.localEulerAngles.x = 0
				var_130_13.localEulerAngles = var_130_13.localEulerAngles
			end

			if arg_127_1.time_ >= 1.999999999999 + var_130_15 and arg_127_1.time_ < 1.999999999999 + var_130_15 + arg_130_0 then
				var_130_13.localPosition = Vector3.New(0, 100, 0)
				var_130_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_13.position).x, (manager.ui.mainCamera.transform.position - var_130_13.position).y, (manager.ui.mainCamera.transform.position - var_130_13.position).z)
				var_130_13.localEulerAngles.z = 0
				var_130_13.localEulerAngles.x = 0
				var_130_13.localEulerAngles = var_130_13.localEulerAngles

				local var_130_16 = GameObjectTools.GetOrAddComponent(var_130_13.gameObject, typeof(DynamicBoneHelper))

				if var_130_16 then
					var_130_16:EnableDynamicBone(true)
				end
			end

			local var_130_17 = arg_127_1.actors_["10049ui_story"]

			if 1.999999999999 < arg_127_1.time_ and arg_127_1.time_ <= 1.999999999999 + arg_130_0 and not isNil(var_130_17) and arg_127_1.var_.characterEffect10049ui_story == nil then
				arg_127_1.var_.characterEffect10049ui_story = var_130_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_18 = 0.200000002980232

			if 1.999999999999 <= arg_127_1.time_ and arg_127_1.time_ < 1.999999999999 + var_130_18 and not isNil(var_130_17) then
				if arg_127_1.var_.characterEffect10049ui_story and not isNil(var_130_17) then
					arg_127_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 1.999999999999) / var_130_18)
				end
			end

			if arg_127_1.time_ >= 1.999999999999 + var_130_18 and arg_127_1.time_ < 1.999999999999 + var_130_18 + arg_130_0 and not isNil(var_130_17) and arg_127_1.var_.characterEffect10049ui_story then
				arg_127_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10049ui_story.fillRatio = 0.5
			end

			if 1.6 < arg_127_1.time_ and arg_127_1.time_ <= 1.6 + arg_130_0 then
				arg_127_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 0.1 < arg_127_1.time_ and arg_127_1.time_ <= 0.1 + arg_130_0 then
				arg_127_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0.1 < arg_127_1.time_ and arg_127_1.time_ <= 0.1 + arg_130_0 then
				arg_127_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 0.1 < arg_127_1.time_ and arg_127_1.time_ <= 0.1 + arg_130_0 then
				arg_127_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_130_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_127_1.bgmTxt_.text ~= var_130_24 and arg_127_1.bgmTxt_.text ~= "" then
						if arg_127_1.bgmTxt2_.text ~= "" then
							arg_127_1.bgmTxt_.text = arg_127_1.bgmTxt2_.text
						end

						arg_127_1.bgmTxt2_.text = var_130_24

						arg_127_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_127_1.bgmTxt_.text = var_130_24
						arg_127_1.bgmTxt2_.text = var_130_24
					end

					if arg_127_1.bgmTimer then
						arg_127_1.bgmTimer:Stop()

						arg_127_1.bgmTimer = nil
					end

					if arg_127_1.settingData.show_music_name == 1 then
						arg_127_1.musicController:SetSelectedState("show")
						arg_127_1.musicAnimator_:Play("open", 0, 0)

						if arg_127_1.settingData.music_time ~= 0 then
							arg_127_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_127_1.settingData.music_time), function()
								if arg_127_1 == nil or isNil(arg_127_1.bgmTxt_) then
									return
								end

								arg_127_1.musicController:SetSelectedState("hide")
								arg_127_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.6 < arg_127_1.time_ and arg_127_1.time_ <= 1.6 + arg_130_0 then
				arg_127_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

				local var_130_27 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

				if "" ~= "" then
					if arg_127_1.bgmTxt_.text ~= var_130_27 and arg_127_1.bgmTxt_.text ~= "" then
						if arg_127_1.bgmTxt2_.text ~= "" then
							arg_127_1.bgmTxt_.text = arg_127_1.bgmTxt2_.text
						end

						arg_127_1.bgmTxt2_.text = var_130_27

						arg_127_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_127_1.bgmTxt_.text = var_130_27
						arg_127_1.bgmTxt2_.text = var_130_27
					end

					if arg_127_1.bgmTimer then
						arg_127_1.bgmTimer:Stop()

						arg_127_1.bgmTimer = nil
					end

					if arg_127_1.settingData.show_music_name == 1 then
						arg_127_1.musicController:SetSelectedState("show")
						arg_127_1.musicAnimator_:Play("open", 0, 0)

						if arg_127_1.settingData.music_time ~= 0 then
							arg_127_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_127_1.settingData.music_time), function()
								if arg_127_1 == nil or isNil(arg_127_1.bgmTxt_) then
									return
								end

								arg_127_1.musicController:SetSelectedState("hide")
								arg_127_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_28 = 3.999999999999
			local var_130_29 = 1.3

			if 3.999999999999 < arg_127_1.time_ and arg_127_1.time_ <= var_130_28 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_30 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_30:setOnUpdate(LuaHelper.FloatAction(function(arg_133_0)
					arg_127_1.dialogCg_.alpha = arg_133_0
				end))
				var_130_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_31 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(322112030).content)

				arg_127_1.text_.text = var_130_31

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_33 = 52 <= 0 and var_130_29 or var_130_29 * (utf8.len(var_130_31) / 52)

				if (52 <= 0 and var_130_29 or var_130_29 * (utf8.len(var_130_31) / 52)) > 0 and var_130_29 < var_130_33 then
					arg_127_1.talkMaxDuration = var_130_33
					var_130_28 = var_130_28 + 0.3

					if var_130_33 + var_130_28 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_33 + var_130_28
					end
				end

				arg_127_1.text_.text = var_130_31
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_34 = var_130_28 + 0.3
			local var_130_35 = math.max(var_130_29, arg_127_1.talkMaxDuration)

			if var_130_28 + 0.3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_34 + var_130_35 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_34) / var_130_35

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_34 + var_130_35 and arg_127_1.time_ < var_130_34 + var_130_35 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play322112031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 322112031
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play322112032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.475

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(322112031).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 19 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 19)

				if (19 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 19)) > 0 and var_138_0 < var_138_3 then
					arg_135_1.talkMaxDuration = var_138_3

					if var_138_3 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_3 + 0
					end
				end

				arg_135_1.text_.text = var_138_1
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_4 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_4

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play322112032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 322112032
		arg_139_1.duration_ = 6.73

		local var_139_0 = {
			zh = 6.033,
			ja = 6.733
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
				arg_139_0:Play322112033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if arg_139_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_142_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_139_1.stage_.transform)

				var_142_0.name = "1284ui_story"
				var_142_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["1284ui_story"] = var_142_0

				local var_142_1 = var_142_0:GetComponentInChildren(typeof(CharacterEffect))

				var_142_1.enabled = true

				local var_142_2 = GameObjectTools.GetOrAddComponent(var_142_0, typeof(DynamicBoneHelper))

				if var_142_2 then
					var_142_2:EnableDynamicBone(false)
				end

				arg_139_1:ShowWeapon(var_142_1.transform, false)

				arg_139_1.var_["1284ui_story" .. "Animator"] = var_142_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_139_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_139_1.var_["1284ui_story" .. "LipSync"] = var_142_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_142_3 = arg_139_1.actors_["1284ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1284ui_story = var_142_3.localPosition
			end

			local var_142_4 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_3.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_139_1.time_ - 0) / var_142_4)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_3.localPosition = Vector3.New(0, -0.985, -6.22)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			local var_142_5 = arg_139_1.actors_["1284ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect1284ui_story == nil then
				arg_139_1.var_.characterEffect1284ui_story = var_142_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_6 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_6 and not isNil(var_142_5) then
				if arg_139_1.var_.characterEffect1284ui_story and not isNil(var_142_5) then
					arg_139_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_6 and arg_139_1.time_ < 0 + var_142_6 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect1284ui_story then
				arg_139_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_142_8 = 0
			local var_142_9 = 0.65

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(322112032)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 26 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 26)

				if (26 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 26)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112032", "story_v_out_322112.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_322112", "322112032", "story_v_out_322112.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_322112", "322112032", "story_v_out_322112.awb")

						arg_139_1:RecordAudio("322112032", var_142_15)
						arg_139_1:RecordAudio("322112032", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_322112", "322112032", "story_v_out_322112.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_322112", "322112032", "story_v_out_322112.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_16 and arg_139_1.time_ < var_142_8 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play322112033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 322112033
		arg_143_1.duration_ = 7.13

		local var_143_0 = {
			zh = 6.3,
			ja = 7.133
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
				arg_143_0:Play322112034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_146_0 = 0
			local var_146_1 = 0.525

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_2 = arg_143_1:GetWordFromCfg(322112033)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 21 <= 0 and var_146_1 or var_146_1 * (utf8.len(var_146_3) / 21)

				if (21 <= 0 and var_146_1 or var_146_1 * (utf8.len(var_146_3) / 21)) > 0 and var_146_1 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112033", "story_v_out_322112.awb") ~= 0 then
					local var_146_6 = manager.audio:GetVoiceLength("story_v_out_322112", "322112033", "story_v_out_322112.awb") / 1000

					if var_146_6 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_0
					end

					if var_146_2.prefab_name ~= "" and arg_143_1.actors_[var_146_2.prefab_name] ~= nil then
						local var_146_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_2.prefab_name].transform, "story_v_out_322112", "322112033", "story_v_out_322112.awb")

						arg_143_1:RecordAudio("322112033", var_146_7)
						arg_143_1:RecordAudio("322112033", var_146_7)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_322112", "322112033", "story_v_out_322112.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_322112", "322112033", "story_v_out_322112.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_8 and arg_143_1.time_ < var_146_0 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play322112034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 322112034
		arg_147_1.duration_ = 1

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"

			SetActive(arg_147_1.choicesGo_, true)

			for iter_148_0, iter_148_1 in ipairs(arg_147_1.choices_) do
				SetActive(iter_148_1.go, iter_148_0 <= 2)
			end

			arg_147_1.choices_[1].txt.text = arg_147_1:FormatText(StoryChoiceCfg[1412].name)
			arg_147_1.choices_[2].txt.text = arg_147_1:FormatText(StoryChoiceCfg[1413].name)
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play322112035(arg_147_1)
			end

			if arg_149_0 == 2 then
				arg_147_0:Play322112037(arg_147_1)
			end

			arg_147_1:RecordChoiceLog(322112034, 1412, 1413)
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1284ui_story"]) and arg_147_1.var_.characterEffect1284ui_story == nil then
				arg_147_1.var_.characterEffect1284ui_story = arg_147_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1284ui_story"]) then
				if arg_147_1.var_.characterEffect1284ui_story and not isNil(arg_147_1.actors_["1284ui_story"]) then
					arg_147_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1284ui_story"]) and arg_147_1.var_.characterEffect1284ui_story then
				arg_147_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			if arg_147_1.time_ >= var_150_1 + 0.6 and arg_147_1.time_ < var_150_1 + 0.6 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play322112035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 322112035
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play322112036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.525

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(322112035).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 21 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 21)

				if (21 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 21)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play322112036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 322112036
		arg_155_1.duration_ = 3.6

		local var_155_0 = {
			zh = 2.333,
			ja = 3.6
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
				arg_155_0:Play322112039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1284ui_story"]) and arg_155_1.var_.characterEffect1284ui_story == nil then
				arg_155_1.var_.characterEffect1284ui_story = arg_155_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1284ui_story"]) then
				if arg_155_1.var_.characterEffect1284ui_story and not isNil(arg_155_1.actors_["1284ui_story"]) then
					arg_155_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1284ui_story"]) and arg_155_1.var_.characterEffect1284ui_story then
				arg_155_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284actionlink/1284action423")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_158_2 = 0
			local var_158_3 = 0.2

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(322112036)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 8 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 8)

				if (8 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 8)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112036", "story_v_out_322112.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_322112", "322112036", "story_v_out_322112.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_out_322112", "322112036", "story_v_out_322112.awb")

						arg_155_1:RecordAudio("322112036", var_158_9)
						arg_155_1:RecordAudio("322112036", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_322112", "322112036", "story_v_out_322112.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_322112", "322112036", "story_v_out_322112.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_10 and arg_155_1.time_ < var_158_2 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play322112039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 322112039
		arg_159_1.duration_ = 2.83

		local var_159_0 = {
			zh = 2.766,
			ja = 2.833
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
				arg_159_0:Play322112040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_2")
			end

			local var_162_0 = arg_159_1.actors_["1284ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1284ui_story == nil then
				arg_159_1.var_.characterEffect1284ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_1 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 and not isNil(var_162_0) then
				if arg_159_1.var_.characterEffect1284ui_story and not isNil(var_162_0) then
					arg_159_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1284ui_story then
				arg_159_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_162_3 = 0
			local var_162_4 = 0.325

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_3 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_5 = arg_159_1:GetWordFromCfg(322112039)
				local var_162_6 = arg_159_1:FormatText(var_162_5.content)

				arg_159_1.text_.text = var_162_6

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_8 = 13 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_6) / 13)

				if (13 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_6) / 13)) > 0 and var_162_4 < var_162_8 then
					arg_159_1.talkMaxDuration = var_162_8

					if var_162_8 + var_162_3 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_3
					end
				end

				arg_159_1.text_.text = var_162_6
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112039", "story_v_out_322112.awb") ~= 0 then
					local var_162_9 = manager.audio:GetVoiceLength("story_v_out_322112", "322112039", "story_v_out_322112.awb") / 1000

					if var_162_9 + var_162_3 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_3
					end

					if var_162_5.prefab_name ~= "" and arg_159_1.actors_[var_162_5.prefab_name] ~= nil then
						local var_162_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_5.prefab_name].transform, "story_v_out_322112", "322112039", "story_v_out_322112.awb")

						arg_159_1:RecordAudio("322112039", var_162_10)
						arg_159_1:RecordAudio("322112039", var_162_10)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_322112", "322112039", "story_v_out_322112.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_322112", "322112039", "story_v_out_322112.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_11 = math.max(var_162_4, arg_159_1.talkMaxDuration)

			if var_162_3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_3 + var_162_11 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_3) / var_162_11

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_3 + var_162_11 and arg_159_1.time_ < var_162_3 + var_162_11 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play322112040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 322112040
		arg_163_1.duration_ = 3

		local var_163_0 = {
			zh = 1.999999999999,
			ja = 3
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
				arg_163_0:Play322112041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if arg_163_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_166_0 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_163_1.stage_.transform)

				var_166_0.name = "1211ui_story"
				var_166_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_["1211ui_story"] = var_166_0

				local var_166_1 = var_166_0:GetComponentInChildren(typeof(CharacterEffect))

				var_166_1.enabled = true

				local var_166_2 = GameObjectTools.GetOrAddComponent(var_166_0, typeof(DynamicBoneHelper))

				if var_166_2 then
					var_166_2:EnableDynamicBone(false)
				end

				arg_163_1:ShowWeapon(var_166_1.transform, false)

				arg_163_1.var_["1211ui_story" .. "Animator"] = var_166_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_163_1.var_["1211ui_story" .. "Animator"].applyRootMotion = true
				arg_163_1.var_["1211ui_story" .. "LipSync"] = var_166_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_166_3 = arg_163_1.actors_["1211ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1211ui_story = var_166_3.localPosition
			end

			local var_166_4 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				var_166_3.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_163_1.time_ - 0) / var_166_4)
				var_166_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_3.position).x, (manager.ui.mainCamera.transform.position - var_166_3.position).y, (manager.ui.mainCamera.transform.position - var_166_3.position).z)
				var_166_3.localEulerAngles.z = 0
				var_166_3.localEulerAngles.x = 0
				var_166_3.localEulerAngles = var_166_3.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				var_166_3.localPosition = Vector3.New(0.7, -0.67, -6.07)
				var_166_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_3.position).x, (manager.ui.mainCamera.transform.position - var_166_3.position).y, (manager.ui.mainCamera.transform.position - var_166_3.position).z)
				var_166_3.localEulerAngles.z = 0
				var_166_3.localEulerAngles.x = 0
				var_166_3.localEulerAngles = var_166_3.localEulerAngles
			end

			local var_166_5 = arg_163_1.actors_["1284ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1284ui_story = var_166_5.localPosition
			end

			local var_166_6 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_6 then
				var_166_5.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_163_1.time_ - 0) / var_166_6)
				var_166_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_5.position).x, (manager.ui.mainCamera.transform.position - var_166_5.position).y, (manager.ui.mainCamera.transform.position - var_166_5.position).z)
				var_166_5.localEulerAngles.z = 0
				var_166_5.localEulerAngles.x = 0
				var_166_5.localEulerAngles = var_166_5.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_6 and arg_163_1.time_ < 0 + var_166_6 + arg_166_0 then
				var_166_5.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				var_166_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_5.position).x, (manager.ui.mainCamera.transform.position - var_166_5.position).y, (manager.ui.mainCamera.transform.position - var_166_5.position).z)
				var_166_5.localEulerAngles.z = 0
				var_166_5.localEulerAngles.x = 0
				var_166_5.localEulerAngles = var_166_5.localEulerAngles
			end

			local var_166_7 = arg_163_1.actors_["1211ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.characterEffect1211ui_story == nil then
				arg_163_1.var_.characterEffect1211ui_story = var_166_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_8 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_8 and not isNil(var_166_7) then
				if arg_163_1.var_.characterEffect1211ui_story and not isNil(var_166_7) then
					arg_163_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_8 and arg_163_1.time_ < 0 + var_166_8 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.characterEffect1211ui_story then
				arg_163_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_166_10 = arg_163_1.actors_["1284ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_10) and arg_163_1.var_.characterEffect1284ui_story == nil then
				arg_163_1.var_.characterEffect1284ui_story = var_166_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_11 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_11 and not isNil(var_166_10) then
				if arg_163_1.var_.characterEffect1284ui_story and not isNil(var_166_10) then
					arg_163_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_11)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_11 and arg_163_1.time_ < 0 + var_166_11 + arg_166_0 and not isNil(var_166_10) and arg_163_1.var_.characterEffect1284ui_story then
				arg_163_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_166_12 = 0
			local var_166_13 = 0.2

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_14 = arg_163_1:GetWordFromCfg(322112040)
				local var_166_15 = arg_163_1:FormatText(var_166_14.content)

				arg_163_1.text_.text = var_166_15

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_17 = 8 <= 0 and var_166_13 or var_166_13 * (utf8.len(var_166_15) / 8)

				if (8 <= 0 and var_166_13 or var_166_13 * (utf8.len(var_166_15) / 8)) > 0 and var_166_13 < var_166_17 then
					arg_163_1.talkMaxDuration = var_166_17

					if var_166_17 + var_166_12 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_17 + var_166_12
					end
				end

				arg_163_1.text_.text = var_166_15
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112040", "story_v_out_322112.awb") ~= 0 then
					local var_166_18 = manager.audio:GetVoiceLength("story_v_out_322112", "322112040", "story_v_out_322112.awb") / 1000

					if var_166_18 + var_166_12 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_18 + var_166_12
					end

					if var_166_14.prefab_name ~= "" and arg_163_1.actors_[var_166_14.prefab_name] ~= nil then
						local var_166_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_14.prefab_name].transform, "story_v_out_322112", "322112040", "story_v_out_322112.awb")

						arg_163_1:RecordAudio("322112040", var_166_19)
						arg_163_1:RecordAudio("322112040", var_166_19)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_322112", "322112040", "story_v_out_322112.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_322112", "322112040", "story_v_out_322112.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_20 = math.max(var_166_13, arg_163_1.talkMaxDuration)

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_20 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_12) / var_166_20

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_12 + var_166_20 and arg_163_1.time_ < var_166_12 + var_166_20 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play322112041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 322112041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play322112042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1284ui_story = arg_167_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1284ui_story"].transform.position).z)
				arg_167_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1284ui_story"].transform.localEulerAngles = arg_167_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1284ui_story"].transform.position).z)
				arg_167_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1284ui_story"].transform.localEulerAngles = arg_167_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1211ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1211ui_story = var_170_1.localPosition
			end

			local var_170_2 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 then
				var_170_1.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_2)
				var_170_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_1.position).x, (manager.ui.mainCamera.transform.position - var_170_1.position).y, (manager.ui.mainCamera.transform.position - var_170_1.position).z)
				var_170_1.localEulerAngles.z = 0
				var_170_1.localEulerAngles.x = 0
				var_170_1.localEulerAngles = var_170_1.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 then
				var_170_1.localPosition = Vector3.New(0, 100, 0)
				var_170_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_1.position).x, (manager.ui.mainCamera.transform.position - var_170_1.position).y, (manager.ui.mainCamera.transform.position - var_170_1.position).z)
				var_170_1.localEulerAngles.z = 0
				var_170_1.localEulerAngles.x = 0
				var_170_1.localEulerAngles = var_170_1.localEulerAngles
			end

			local var_170_3 = arg_167_1.actors_["1211ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_3) and arg_167_1.var_.characterEffect1211ui_story == nil then
				arg_167_1.var_.characterEffect1211ui_story = var_170_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_4 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 and not isNil(var_170_3) then
				if arg_167_1.var_.characterEffect1211ui_story and not isNil(var_170_3) then
					arg_167_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_4)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 and not isNil(var_170_3) and arg_167_1.var_.characterEffect1211ui_story then
				arg_167_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_170_5 = 0
			local var_170_6 = 1.1

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_7 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(322112041).content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 44 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_7) / 44)

				if (44 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_7) / 44)) > 0 and var_170_6 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_5
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_6, arg_167_1.talkMaxDuration)

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_5) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_5 + var_170_10 and arg_167_1.time_ < var_170_5 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play322112042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 322112042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play322112043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 1.85

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(322112042).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 74 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 74)

				if (74 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 74)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play322112043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 322112043
		arg_175_1.duration_ = 2.27

		local var_175_0 = {
			zh = 1.999999999999,
			ja = 2.266
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
				arg_175_0:Play322112044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if arg_175_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_178_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_175_1.stage_.transform)

				var_178_0.name = "10104ui_story"
				var_178_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.actors_["10104ui_story"] = var_178_0

				local var_178_1 = var_178_0:GetComponentInChildren(typeof(CharacterEffect))

				var_178_1.enabled = true

				local var_178_2 = GameObjectTools.GetOrAddComponent(var_178_0, typeof(DynamicBoneHelper))

				if var_178_2 then
					var_178_2:EnableDynamicBone(false)
				end

				arg_175_1:ShowWeapon(var_178_1.transform, false)

				arg_175_1.var_["10104ui_story" .. "Animator"] = var_178_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_175_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_175_1.var_["10104ui_story" .. "LipSync"] = var_178_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_178_3 = arg_175_1.actors_["10104ui_story"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10104ui_story = var_178_3.localPosition
			end

			local var_178_4 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				var_178_3.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_175_1.time_ - 0) / var_178_4)
				var_178_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_3.position).x, (manager.ui.mainCamera.transform.position - var_178_3.position).y, (manager.ui.mainCamera.transform.position - var_178_3.position).z)
				var_178_3.localEulerAngles.z = 0
				var_178_3.localEulerAngles.x = 0
				var_178_3.localEulerAngles = var_178_3.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				var_178_3.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_178_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_3.position).x, (manager.ui.mainCamera.transform.position - var_178_3.position).y, (manager.ui.mainCamera.transform.position - var_178_3.position).z)
				var_178_3.localEulerAngles.z = 0
				var_178_3.localEulerAngles.x = 0
				var_178_3.localEulerAngles = var_178_3.localEulerAngles
			end

			local var_178_5 = arg_175_1.actors_["10104ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.characterEffect10104ui_story == nil then
				arg_175_1.var_.characterEffect10104ui_story = var_178_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_6 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_6 and not isNil(var_178_5) then
				if arg_175_1.var_.characterEffect10104ui_story and not isNil(var_178_5) then
					arg_175_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_6 and arg_175_1.time_ < 0 + var_178_6 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.characterEffect10104ui_story then
				arg_175_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_178_8 = 0
			local var_178_9 = 0.2

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_10 = arg_175_1:GetWordFromCfg(322112043)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 8 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 8)

				if (8 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 8)) > 0 and var_178_9 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_8
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112043", "story_v_out_322112.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_322112", "322112043", "story_v_out_322112.awb") / 1000

					if var_178_14 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_8
					end

					if var_178_10.prefab_name ~= "" and arg_175_1.actors_[var_178_10.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_10.prefab_name].transform, "story_v_out_322112", "322112043", "story_v_out_322112.awb")

						arg_175_1:RecordAudio("322112043", var_178_15)
						arg_175_1:RecordAudio("322112043", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_322112", "322112043", "story_v_out_322112.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_322112", "322112043", "story_v_out_322112.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_9, arg_175_1.talkMaxDuration)

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_8) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_8 + var_178_16 and arg_175_1.time_ < var_178_8 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play322112044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 322112044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play322112045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["10104ui_story"]) and arg_179_1.var_.characterEffect10104ui_story == nil then
				arg_179_1.var_.characterEffect10104ui_story = arg_179_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["10104ui_story"]) then
				if arg_179_1.var_.characterEffect10104ui_story and not isNil(arg_179_1.actors_["10104ui_story"]) then
					arg_179_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_0)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["10104ui_story"]) and arg_179_1.var_.characterEffect10104ui_story then
				arg_179_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_182_1 = 0
			local var_182_2 = 0.325

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(322112044).content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 13 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 13)

				if (13 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 13)) > 0 and var_182_2 < var_182_5 then
					arg_179_1.talkMaxDuration = var_182_5

					if var_182_5 + var_182_1 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + var_182_1
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_6 = math.max(var_182_2, arg_179_1.talkMaxDuration)

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_6 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_1) / var_182_6

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_1 + var_182_6 and arg_179_1.time_ < var_182_1 + var_182_6 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play322112045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 322112045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play322112046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10104ui_story = arg_183_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).z)
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles = arg_183_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).z)
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles = arg_183_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_186_1 = 0
			local var_186_2 = 1.1

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(322112045).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 44 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 44)

				if (44 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 44)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play322112046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 322112046
		arg_187_1.duration_ = 15

		local var_187_0 = {
			zh = 9.733,
			ja = 15
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
				arg_187_0:Play322112047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10104ui_story = arg_187_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10104ui_story"].transform.position).z)
				arg_187_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["10104ui_story"].transform.localEulerAngles = arg_187_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_187_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10104ui_story"].transform.position).z)
				arg_187_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["10104ui_story"].transform.localEulerAngles = arg_187_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["10104ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect10104ui_story == nil then
				arg_187_1.var_.characterEffect10104ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect10104ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect10104ui_story then
				arg_187_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_190_4 = 0
			local var_190_5 = 1.2

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(322112046)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 48 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 48)

				if (48 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 48)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112046", "story_v_out_322112.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_322112", "322112046", "story_v_out_322112.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_out_322112", "322112046", "story_v_out_322112.awb")

						arg_187_1:RecordAudio("322112046", var_190_11)
						arg_187_1:RecordAudio("322112046", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_322112", "322112046", "story_v_out_322112.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_322112", "322112046", "story_v_out_322112.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_12 and arg_187_1.time_ < var_190_4 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play322112047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 322112047
		arg_191_1.duration_ = 6.8

		local var_191_0 = {
			zh = 5.5,
			ja = 6.8
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
				arg_191_0:Play322112048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10104ui_story = arg_191_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10104ui_story"].transform.position).z)
				arg_191_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10104ui_story"].transform.localEulerAngles = arg_191_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_191_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10104ui_story"].transform.position).z)
				arg_191_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10104ui_story"].transform.localEulerAngles = arg_191_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_194_1 = 0
			local var_194_2 = 0.65

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:GetWordFromCfg(322112047)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_6 = 26 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_4) / 26)

				if (26 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_4) / 26)) > 0 and var_194_2 < var_194_6 then
					arg_191_1.talkMaxDuration = var_194_6

					if var_194_6 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112047", "story_v_out_322112.awb") ~= 0 then
					local var_194_7 = manager.audio:GetVoiceLength("story_v_out_322112", "322112047", "story_v_out_322112.awb") / 1000

					if var_194_7 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_1
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_322112", "322112047", "story_v_out_322112.awb")

						arg_191_1:RecordAudio("322112047", var_194_8)
						arg_191_1:RecordAudio("322112047", var_194_8)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_322112", "322112047", "story_v_out_322112.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_322112", "322112047", "story_v_out_322112.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_9 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_9 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_9

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_9 and arg_191_1.time_ < var_194_1 + var_194_9 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play322112048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 322112048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play322112049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["10104ui_story"]) and arg_195_1.var_.characterEffect10104ui_story == nil then
				arg_195_1.var_.characterEffect10104ui_story = arg_195_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["10104ui_story"]) then
				if arg_195_1.var_.characterEffect10104ui_story and not isNil(arg_195_1.actors_["10104ui_story"]) then
					arg_195_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["10104ui_story"]) and arg_195_1.var_.characterEffect10104ui_story then
				arg_195_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.275

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(322112048).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 11 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 11)

				if (11 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 11)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play322112049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 322112049
		arg_199_1.duration_ = 3.4

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play322112050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10104ui_story = arg_199_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10104ui_story"].transform.position).z)
				arg_199_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["10104ui_story"].transform.localEulerAngles = arg_199_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_199_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10104ui_story"].transform.position).z)
				arg_199_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["10104ui_story"].transform.localEulerAngles = arg_199_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["10104ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect10104ui_story == nil then
				arg_199_1.var_.characterEffect10104ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect10104ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect10104ui_story then
				arg_199_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_202_4 = 0
			local var_202_5 = 0.325

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(322112049)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 13 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 13)

				if (13 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 13)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112049", "story_v_out_322112.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_out_322112", "322112049", "story_v_out_322112.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_out_322112", "322112049", "story_v_out_322112.awb")

						arg_199_1:RecordAudio("322112049", var_202_11)
						arg_199_1:RecordAudio("322112049", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_322112", "322112049", "story_v_out_322112.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_322112", "322112049", "story_v_out_322112.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play322112050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 322112050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play322112051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos10104ui_story = arg_203_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10104ui_story"].transform.position).z)
				arg_203_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["10104ui_story"].transform.localEulerAngles = arg_203_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10104ui_story"].transform.position).z)
				arg_203_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["10104ui_story"].transform.localEulerAngles = arg_203_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["10104ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect10104ui_story == nil then
				arg_203_1.var_.characterEffect10104ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect10104ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_2)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect10104ui_story then
				arg_203_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0.499999999999 < arg_203_1.time_ and arg_203_1.time_ <= 0.499999999999 + arg_206_0 then
				arg_203_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_walk02", "")
			end

			local var_206_4 = 0
			local var_206_5 = 1.2

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(322112050).content)

				arg_203_1.text_.text = var_206_6

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_8 = 48 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_6) / 48)

				if (48 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_6) / 48)) > 0 and var_206_5 < var_206_8 then
					arg_203_1.talkMaxDuration = var_206_8

					if var_206_8 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_6
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_9 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_9 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_9

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_9 and arg_203_1.time_ < var_206_4 + var_206_9 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play322112051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 322112051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play322112052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 1.025

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(322112051).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 41 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 41)

				if (41 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 41)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play322112052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 322112052
		arg_211_1.duration_ = 6.67

		local var_211_0 = {
			zh = 4.633,
			ja = 6.666
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
				arg_211_0:Play322112053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10104ui_story = arg_211_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10104ui_story"].transform.position).z)
				arg_211_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["10104ui_story"].transform.localEulerAngles = arg_211_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_211_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10104ui_story"].transform.position).z)
				arg_211_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["10104ui_story"].transform.localEulerAngles = arg_211_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["10104ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect10104ui_story == nil then
				arg_211_1.var_.characterEffect10104ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect10104ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect10104ui_story then
				arg_211_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_214_4 = 0
			local var_214_5 = 0.575

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(322112052)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 23 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 23)

				if (23 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 23)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112052", "story_v_out_322112.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_out_322112", "322112052", "story_v_out_322112.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_out_322112", "322112052", "story_v_out_322112.awb")

						arg_211_1:RecordAudio("322112052", var_214_11)
						arg_211_1:RecordAudio("322112052", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_322112", "322112052", "story_v_out_322112.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_322112", "322112052", "story_v_out_322112.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_12 and arg_211_1.time_ < var_214_4 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play322112053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 322112053
		arg_215_1.duration_ = 11.07

		local var_215_0 = {
			zh = 8,
			ja = 11.066
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
				arg_215_0:Play322112054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_218_0 = 0
			local var_218_1 = 0.95

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(322112053)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 38 <= 0 and var_218_1 or var_218_1 * (utf8.len(var_218_3) / 38)

				if (38 <= 0 and var_218_1 or var_218_1 * (utf8.len(var_218_3) / 38)) > 0 and var_218_1 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112053", "story_v_out_322112.awb") ~= 0 then
					local var_218_6 = manager.audio:GetVoiceLength("story_v_out_322112", "322112053", "story_v_out_322112.awb") / 1000

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end

					if var_218_2.prefab_name ~= "" and arg_215_1.actors_[var_218_2.prefab_name] ~= nil then
						local var_218_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_2.prefab_name].transform, "story_v_out_322112", "322112053", "story_v_out_322112.awb")

						arg_215_1:RecordAudio("322112053", var_218_7)
						arg_215_1:RecordAudio("322112053", var_218_7)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_322112", "322112053", "story_v_out_322112.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_322112", "322112053", "story_v_out_322112.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_8 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_8 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_8

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_8 and arg_215_1.time_ < var_218_0 + var_218_8 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play322112054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 322112054
		arg_219_1.duration_ = 14.93

		local var_219_0 = {
			zh = 9.233,
			ja = 14.933
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
				arg_219_0:Play322112055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 1.125

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:GetWordFromCfg(322112054)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 45 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 45)

				if (45 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 45)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112054", "story_v_out_322112.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112054", "story_v_out_322112.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_322112", "322112054", "story_v_out_322112.awb")

						arg_219_1:RecordAudio("322112054", var_222_6)
						arg_219_1:RecordAudio("322112054", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_322112", "322112054", "story_v_out_322112.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_322112", "322112054", "story_v_out_322112.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play322112055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 322112055
		arg_223_1.duration_ = 4.4

		local var_223_0 = {
			zh = 2.566,
			ja = 4.4
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
				arg_223_0:Play322112056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action5_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_226_0 = 0
			local var_226_1 = 0.275

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_2 = arg_223_1:GetWordFromCfg(322112055)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 11 <= 0 and var_226_1 or var_226_1 * (utf8.len(var_226_3) / 11)

				if (11 <= 0 and var_226_1 or var_226_1 * (utf8.len(var_226_3) / 11)) > 0 and var_226_1 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112055", "story_v_out_322112.awb") ~= 0 then
					local var_226_6 = manager.audio:GetVoiceLength("story_v_out_322112", "322112055", "story_v_out_322112.awb") / 1000

					if var_226_6 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_0
					end

					if var_226_2.prefab_name ~= "" and arg_223_1.actors_[var_226_2.prefab_name] ~= nil then
						local var_226_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_2.prefab_name].transform, "story_v_out_322112", "322112055", "story_v_out_322112.awb")

						arg_223_1:RecordAudio("322112055", var_226_7)
						arg_223_1:RecordAudio("322112055", var_226_7)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_322112", "322112055", "story_v_out_322112.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_322112", "322112055", "story_v_out_322112.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_8 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_8 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_8

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_8 and arg_223_1.time_ < var_226_0 + var_226_8 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play322112056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 322112056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play322112057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["10104ui_story"]) and arg_227_1.var_.characterEffect10104ui_story == nil then
				arg_227_1.var_.characterEffect10104ui_story = arg_227_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["10104ui_story"]) then
				if arg_227_1.var_.characterEffect10104ui_story and not isNil(arg_227_1.actors_["10104ui_story"]) then
					arg_227_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_227_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["10104ui_story"]) and arg_227_1.var_.characterEffect10104ui_story then
				arg_227_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_227_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_230_1 = 0
			local var_230_2 = 0.7

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(322112056).content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 28 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 28)

				if (28 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 28)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_6 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_6 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_6

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_6 and arg_227_1.time_ < var_230_1 + var_230_6 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play322112057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 322112057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play322112058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10104ui_story = arg_231_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10104ui_story"].transform.position).z)
				arg_231_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["10104ui_story"].transform.localEulerAngles = arg_231_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10104ui_story"].transform.position).z)
				arg_231_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["10104ui_story"].transform.localEulerAngles = arg_231_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_234_1 = 0
			local var_234_2 = 1.3

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(322112057).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 52 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 52)

				if (52 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 52)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_6 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_6 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_6

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_6 and arg_231_1.time_ < var_234_1 + var_234_6 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play322112058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 322112058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play322112059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.9

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(322112058).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 36 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 36)

				if (36 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 36)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play322112059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 322112059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play322112060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 1.525

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(322112059).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 61 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 61)

				if (61 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 61)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play322112060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 322112060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play322112061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.6

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(322112060).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 24 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 24)

				if (24 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 24)) > 0 and var_246_0 < var_246_3 then
					arg_243_1.talkMaxDuration = var_246_3

					if var_246_3 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_3 + 0
					end
				end

				arg_243_1.text_.text = var_246_1
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_4 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_4

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play322112061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 322112061
		arg_247_1.duration_ = 4.9

		local var_247_0 = {
			zh = 1.999999999999,
			ja = 4.9
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
				arg_247_0:Play322112062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10104ui_story = arg_247_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10104ui_story"].transform.position).z)
				arg_247_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["10104ui_story"].transform.localEulerAngles = arg_247_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_247_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10104ui_story"].transform.position).z)
				arg_247_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["10104ui_story"].transform.localEulerAngles = arg_247_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["10104ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect10104ui_story == nil then
				arg_247_1.var_.characterEffect10104ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect10104ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect10104ui_story then
				arg_247_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_250_4 = 0
			local var_250_5 = 0.3

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_6 = arg_247_1:GetWordFromCfg(322112061)
				local var_250_7 = arg_247_1:FormatText(var_250_6.content)

				arg_247_1.text_.text = var_250_7

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_9 = 12 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 12)

				if (12 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 12)) > 0 and var_250_5 < var_250_9 then
					arg_247_1.talkMaxDuration = var_250_9

					if var_250_9 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_7
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112061", "story_v_out_322112.awb") ~= 0 then
					local var_250_10 = manager.audio:GetVoiceLength("story_v_out_322112", "322112061", "story_v_out_322112.awb") / 1000

					if var_250_10 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_4
					end

					if var_250_6.prefab_name ~= "" and arg_247_1.actors_[var_250_6.prefab_name] ~= nil then
						local var_250_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_6.prefab_name].transform, "story_v_out_322112", "322112061", "story_v_out_322112.awb")

						arg_247_1:RecordAudio("322112061", var_250_11)
						arg_247_1:RecordAudio("322112061", var_250_11)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_322112", "322112061", "story_v_out_322112.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_322112", "322112061", "story_v_out_322112.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_12 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_12 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_12

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_12 and arg_247_1.time_ < var_250_4 + var_250_12 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play322112062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 322112062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play322112063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos10104ui_story = arg_251_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10104ui_story"].transform.position).z)
				arg_251_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["10104ui_story"].transform.localEulerAngles = arg_251_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_251_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10104ui_story"].transform.position).z)
				arg_251_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["10104ui_story"].transform.localEulerAngles = arg_251_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["10104ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect10104ui_story == nil then
				arg_251_1.var_.characterEffect10104ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect10104ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_251_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_2)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect10104ui_story then
				arg_251_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_251_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0.666666666666667 < arg_251_1.time_ and arg_251_1.time_ <= 0.666666666666667 + arg_254_0 then
				arg_251_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_clap", "")
			end

			local var_254_4 = 0
			local var_254_5 = 1.05

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_4 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_6 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(322112062).content)

				arg_251_1.text_.text = var_254_6

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_8 = 42 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_6) / 42)

				if (42 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_6) / 42)) > 0 and var_254_5 < var_254_8 then
					arg_251_1.talkMaxDuration = var_254_8

					if var_254_8 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_4
					end
				end

				arg_251_1.text_.text = var_254_6
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_9 = math.max(var_254_5, arg_251_1.talkMaxDuration)

			if var_254_4 <= arg_251_1.time_ and arg_251_1.time_ < var_254_4 + var_254_9 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_4) / var_254_9

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_4 + var_254_9 and arg_251_1.time_ < var_254_4 + var_254_9 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play322112063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 322112063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play322112064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 2 < arg_255_1.time_ and arg_255_1.time_ <= 2 + arg_258_0 then
				arg_255_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_258_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_255_1.bgmTxt_.text ~= var_258_2 and arg_255_1.bgmTxt_.text ~= "" then
						if arg_255_1.bgmTxt2_.text ~= "" then
							arg_255_1.bgmTxt_.text = arg_255_1.bgmTxt2_.text
						end

						arg_255_1.bgmTxt2_.text = var_258_2

						arg_255_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_255_1.bgmTxt_.text = var_258_2
						arg_255_1.bgmTxt2_.text = var_258_2
					end

					if arg_255_1.bgmTimer then
						arg_255_1.bgmTimer:Stop()

						arg_255_1.bgmTimer = nil
					end

					if arg_255_1.settingData.show_music_name == 1 then
						arg_255_1.musicController:SetSelectedState("show")
						arg_255_1.musicAnimator_:Play("open", 0, 0)

						if arg_255_1.settingData.music_time ~= 0 then
							arg_255_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_255_1.settingData.music_time), function()
								if arg_255_1 == nil or isNil(arg_255_1.bgmTxt_) then
									return
								end

								arg_255_1.musicController:SetSelectedState("hide")
								arg_255_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_258_3 = 0
			local var_258_4 = 1.325

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_3 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_5 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(322112063).content)

				arg_255_1.text_.text = var_258_5

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_7 = 53 <= 0 and var_258_4 or var_258_4 * (utf8.len(var_258_5) / 53)

				if (53 <= 0 and var_258_4 or var_258_4 * (utf8.len(var_258_5) / 53)) > 0 and var_258_4 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_3 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_3
					end
				end

				arg_255_1.text_.text = var_258_5
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_8 = math.max(var_258_4, arg_255_1.talkMaxDuration)

			if var_258_3 <= arg_255_1.time_ and arg_255_1.time_ < var_258_3 + var_258_8 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_3) / var_258_8

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_3 + var_258_8 and arg_255_1.time_ < var_258_3 + var_258_8 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play322112064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 322112064
		arg_260_1.duration_ = 13.2

		local var_260_0 = {
			zh = 12.633,
			ja = 13.2
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
				arg_260_0:Play322112065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 2 < arg_260_1.time_ and arg_260_1.time_ <= 2 + arg_263_0 then
				local var_263_0 = arg_260_1.bgs_.ST2102a

				arg_260_1.bgs_.ST2102a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_263_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_263_1 = var_263_0:GetComponent("SpriteRenderer")

				if var_263_1 and var_263_1.sprite then
					local var_263_2 = 2 * (var_263_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_263_0.transform.localScale = Vector3.New(var_263_2 / var_263_1.sprite.bounds.size.y < var_263_2 * manager.ui.mainCameraCom_.aspect / var_263_1.sprite.bounds.size.x and var_263_2 * manager.ui.mainCameraCom_.aspect / var_263_1.sprite.bounds.size.x or var_263_2 / var_263_1.sprite.bounds.size.y, var_263_2 / var_263_1.sprite.bounds.size.y < var_263_2 * manager.ui.mainCameraCom_.aspect / var_263_1.sprite.bounds.size.x and var_263_2 * manager.ui.mainCameraCom_.aspect / var_263_1.sprite.bounds.size.x or var_263_2 / var_263_1.sprite.bounds.size.y, 0)
				end

				for iter_263_0, iter_263_1 in pairs(arg_260_1.bgs_) do
					if iter_263_0 ~= "ST2102a" then
						iter_263_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_263_3 = 4

			if 4 < arg_260_1.time_ and arg_260_1.time_ <= var_263_3 + arg_263_0 then
				arg_260_1.allBtn_.enabled = false
			end

			if arg_260_1.time_ >= var_263_3 + 0.3 and arg_260_1.time_ < var_263_3 + 0.3 + arg_263_0 then
				arg_260_1.allBtn_.enabled = true
			end

			local var_263_4 = 0

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_4 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_5 = 2

			if var_263_4 <= arg_260_1.time_ and arg_260_1.time_ < var_263_4 + var_263_5 then
				local var_263_6 = Color.New(0, 0, 0)

				var_263_6.a = Mathf.Lerp(0, 1, (arg_260_1.time_ - var_263_4) / var_263_5)
				arg_260_1.mask_.color = var_263_6
			end

			if arg_260_1.time_ >= var_263_4 + var_263_5 and arg_260_1.time_ < var_263_4 + var_263_5 + arg_263_0 then
				local var_263_7 = Color.New(0, 0, 0)

				var_263_7.a = 1
				arg_260_1.mask_.color = var_263_7
			end

			local var_263_8 = 2

			if 2 < arg_260_1.time_ and arg_260_1.time_ <= var_263_8 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_9 = 2

			if var_263_8 <= arg_260_1.time_ and arg_260_1.time_ < var_263_8 + var_263_9 then
				local var_263_10 = Color.New(0, 0, 0)

				var_263_10.a = Mathf.Lerp(1, 0, (arg_260_1.time_ - var_263_8) / var_263_9)
				arg_260_1.mask_.color = var_263_10
			end

			if arg_260_1.time_ >= var_263_8 + var_263_9 and arg_260_1.time_ < var_263_8 + var_263_9 + arg_263_0 then
				local var_263_11 = Color.New(0, 0, 0)

				arg_260_1.mask_.enabled = false
				var_263_11.a = 0
				arg_260_1.mask_.color = var_263_11
			end

			if 0.166666666666667 < arg_260_1.time_ and arg_260_1.time_ <= 0.166666666666667 + arg_263_0 then
				arg_260_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 1.46666666666667 < arg_260_1.time_ and arg_260_1.time_ <= 1.46666666666667 + arg_263_0 then
				arg_260_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 1.46666666666667 < arg_260_1.time_ and arg_260_1.time_ <= 1.46666666666667 + arg_263_0 then
				arg_260_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_263_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_260_1.bgmTxt_.text ~= var_263_17 and arg_260_1.bgmTxt_.text ~= "" then
						if arg_260_1.bgmTxt2_.text ~= "" then
							arg_260_1.bgmTxt_.text = arg_260_1.bgmTxt2_.text
						end

						arg_260_1.bgmTxt2_.text = var_263_17

						arg_260_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_260_1.bgmTxt_.text = var_263_17
						arg_260_1.bgmTxt2_.text = var_263_17
					end

					if arg_260_1.bgmTimer then
						arg_260_1.bgmTimer:Stop()

						arg_260_1.bgmTimer = nil
					end

					if arg_260_1.settingData.show_music_name == 1 then
						arg_260_1.musicController:SetSelectedState("show")
						arg_260_1.musicAnimator_:Play("open", 0, 0)

						if arg_260_1.settingData.music_time ~= 0 then
							arg_260_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_260_1.settingData.music_time), function()
								if arg_260_1 == nil or isNil(arg_260_1.bgmTxt_) then
									return
								end

								arg_260_1.musicController:SetSelectedState("hide")
								arg_260_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.46666666666667 < arg_260_1.time_ and arg_260_1.time_ <= 1.46666666666667 + arg_263_0 then
				arg_260_1:AudioAction("play", "music", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard.awb")

				local var_263_20 = manager.audio:GetAudioName("bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard")

				if "" ~= "" then
					if arg_260_1.bgmTxt_.text ~= var_263_20 and arg_260_1.bgmTxt_.text ~= "" then
						if arg_260_1.bgmTxt2_.text ~= "" then
							arg_260_1.bgmTxt_.text = arg_260_1.bgmTxt2_.text
						end

						arg_260_1.bgmTxt2_.text = var_263_20

						arg_260_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_260_1.bgmTxt_.text = var_263_20
						arg_260_1.bgmTxt2_.text = var_263_20
					end

					if arg_260_1.bgmTimer then
						arg_260_1.bgmTimer:Stop()

						arg_260_1.bgmTimer = nil
					end

					if arg_260_1.settingData.show_music_name == 1 then
						arg_260_1.musicController:SetSelectedState("show")
						arg_260_1.musicAnimator_:Play("open", 0, 0)

						if arg_260_1.settingData.music_time ~= 0 then
							arg_260_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_260_1.settingData.music_time), function()
								if arg_260_1 == nil or isNil(arg_260_1.bgmTxt_) then
									return
								end

								arg_260_1.musicController:SetSelectedState("hide")
								arg_260_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_260_1.frameCnt_ <= 1 then
				arg_260_1.dialog_:SetActive(false)
			end

			local var_263_21 = 4
			local var_263_22 = 1.15

			if 4 < arg_260_1.time_ and arg_260_1.time_ <= var_263_21 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				arg_260_1.dialog_:SetActive(true)

				arg_260_1.dialogCg_.alpha = 0

				local var_263_23 = LeanTween.value(arg_260_1.dialog_, 0, 1, 0.3)

				var_263_23:setOnUpdate(LuaHelper.FloatAction(function(arg_266_0)
					arg_260_1.dialogCg_.alpha = arg_266_0
				end))
				var_263_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_260_1.dialog_)
					var_263_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_260_1.duration_ = arg_260_1.duration_ + 0.3

				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_24 = arg_260_1:GetWordFromCfg(322112064)
				local var_263_25 = arg_260_1:FormatText(var_263_24.content)

				arg_260_1.text_.text = var_263_25

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_27 = 46 <= 0 and var_263_22 or var_263_22 * (utf8.len(var_263_25) / 46)

				if (46 <= 0 and var_263_22 or var_263_22 * (utf8.len(var_263_25) / 46)) > 0 and var_263_22 < var_263_27 then
					arg_260_1.talkMaxDuration = var_263_27
					var_263_21 = var_263_21 + 0.3

					if var_263_27 + var_263_21 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_27 + var_263_21
					end
				end

				arg_260_1.text_.text = var_263_25
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112064", "story_v_out_322112.awb") ~= 0 then
					local var_263_28 = manager.audio:GetVoiceLength("story_v_out_322112", "322112064", "story_v_out_322112.awb") / 1000

					if var_263_28 + var_263_21 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_28 + var_263_21
					end

					if var_263_24.prefab_name ~= "" and arg_260_1.actors_[var_263_24.prefab_name] ~= nil then
						local var_263_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_24.prefab_name].transform, "story_v_out_322112", "322112064", "story_v_out_322112.awb")

						arg_260_1:RecordAudio("322112064", var_263_29)
						arg_260_1:RecordAudio("322112064", var_263_29)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_322112", "322112064", "story_v_out_322112.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_322112", "322112064", "story_v_out_322112.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_30 = var_263_21 + 0.3
			local var_263_31 = math.max(var_263_22, arg_260_1.talkMaxDuration)

			if var_263_21 + 0.3 <= arg_260_1.time_ and arg_260_1.time_ < var_263_30 + var_263_31 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_30) / var_263_31

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_30 + var_263_31 and arg_260_1.time_ < var_263_30 + var_263_31 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play322112065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 322112065
		arg_268_1.duration_ = 8.27

		local var_268_0 = {
			zh = 6.9,
			ja = 8.266
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play322112066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0.85

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_1 = arg_268_1:GetWordFromCfg(322112065)
				local var_271_2 = arg_268_1:FormatText(var_271_1.content)

				arg_268_1.text_.text = var_271_2

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_4 = 34 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 34)

				if (34 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 34)) > 0 and var_271_0 < var_271_4 then
					arg_268_1.talkMaxDuration = var_271_4

					if var_271_4 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_4 + 0
					end
				end

				arg_268_1.text_.text = var_271_2
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112065", "story_v_out_322112.awb") ~= 0 then
					local var_271_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112065", "story_v_out_322112.awb") / 1000

					if var_271_5 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + 0
					end

					if var_271_1.prefab_name ~= "" and arg_268_1.actors_[var_271_1.prefab_name] ~= nil then
						local var_271_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_1.prefab_name].transform, "story_v_out_322112", "322112065", "story_v_out_322112.awb")

						arg_268_1:RecordAudio("322112065", var_271_6)
						arg_268_1:RecordAudio("322112065", var_271_6)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_322112", "322112065", "story_v_out_322112.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_322112", "322112065", "story_v_out_322112.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_7 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_7 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_7

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_7 and arg_268_1.time_ < 0 + var_271_7 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play322112066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 322112066
		arg_272_1.duration_ = 5.4

		local var_272_0 = {
			zh = 5.4,
			ja = 4.133
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
				arg_272_0:Play322112067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos10049ui_story = arg_272_1.actors_["10049ui_story"].transform.localPosition

				local var_275_0 = GameObjectTools.GetOrAddComponent(arg_272_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_275_0 then
					var_275_0:EnableDynamicBone(false)
				end
			end

			local var_275_1 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_1 then
				arg_272_1.actors_["10049ui_story"].transform.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos10049ui_story, Vector3.New(0, -1.13, -6), (arg_272_1.time_ - 0) / var_275_1)
				arg_272_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["10049ui_story"].transform.position).z)
				arg_272_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["10049ui_story"].transform.localEulerAngles = arg_272_1.actors_["10049ui_story"].transform.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_1 and arg_272_1.time_ < 0 + var_275_1 + arg_275_0 then
				arg_272_1.actors_["10049ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6)
				arg_272_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["10049ui_story"].transform.position).z)
				arg_272_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["10049ui_story"].transform.localEulerAngles = arg_272_1.actors_["10049ui_story"].transform.localEulerAngles

				local var_275_2 = GameObjectTools.GetOrAddComponent(arg_272_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_275_2 then
					var_275_2:EnableDynamicBone(true)
				end
			end

			local var_275_3 = arg_272_1.actors_["10049ui_story"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_3) and arg_272_1.var_.characterEffect10049ui_story == nil then
				arg_272_1.var_.characterEffect10049ui_story = var_275_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_4 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_4 and not isNil(var_275_3) then
				if arg_272_1.var_.characterEffect10049ui_story and not isNil(var_275_3) then
					arg_272_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_4 and arg_272_1.time_ < 0 + var_275_4 + arg_275_0 and not isNil(var_275_3) and arg_272_1.var_.characterEffect10049ui_story then
				arg_272_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action1_1")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				if not isNil(arg_272_1.actors_["10049ui_story"]) then
					local var_275_6 = GameObjectTools.GetOrAddComponent(arg_272_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_275_6 then
						var_275_6:EnableDynamicBone(true)
					end
				end
			end

			local var_275_7 = 0
			local var_275_8 = 0.525

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_7 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_9 = arg_272_1:GetWordFromCfg(322112066)
				local var_275_10 = arg_272_1:FormatText(var_275_9.content)

				arg_272_1.text_.text = var_275_10

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_12 = 21 <= 0 and var_275_8 or var_275_8 * (utf8.len(var_275_10) / 21)

				if (21 <= 0 and var_275_8 or var_275_8 * (utf8.len(var_275_10) / 21)) > 0 and var_275_8 < var_275_12 then
					arg_272_1.talkMaxDuration = var_275_12

					if var_275_12 + var_275_7 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_12 + var_275_7
					end
				end

				arg_272_1.text_.text = var_275_10
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112066", "story_v_out_322112.awb") ~= 0 then
					local var_275_13 = manager.audio:GetVoiceLength("story_v_out_322112", "322112066", "story_v_out_322112.awb") / 1000

					if var_275_13 + var_275_7 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_13 + var_275_7
					end

					if var_275_9.prefab_name ~= "" and arg_272_1.actors_[var_275_9.prefab_name] ~= nil then
						local var_275_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_9.prefab_name].transform, "story_v_out_322112", "322112066", "story_v_out_322112.awb")

						arg_272_1:RecordAudio("322112066", var_275_14)
						arg_272_1:RecordAudio("322112066", var_275_14)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_322112", "322112066", "story_v_out_322112.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_322112", "322112066", "story_v_out_322112.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_15 = math.max(var_275_8, arg_272_1.talkMaxDuration)

			if var_275_7 <= arg_272_1.time_ and arg_272_1.time_ < var_275_7 + var_275_15 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_7) / var_275_15

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_7 + var_275_15 and arg_272_1.time_ < var_275_7 + var_275_15 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play322112067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 322112067
		arg_276_1.duration_ = 6.7

		local var_276_0 = {
			zh = 6.4,
			ja = 6.7
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
				arg_276_0:Play322112068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0.5

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_1 = arg_276_1:GetWordFromCfg(322112067)
				local var_279_2 = arg_276_1:FormatText(var_279_1.content)

				arg_276_1.text_.text = var_279_2

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_4 = 20 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 20)

				if (20 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 20)) > 0 and var_279_0 < var_279_4 then
					arg_276_1.talkMaxDuration = var_279_4

					if var_279_4 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_4 + 0
					end
				end

				arg_276_1.text_.text = var_279_2
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112067", "story_v_out_322112.awb") ~= 0 then
					local var_279_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112067", "story_v_out_322112.awb") / 1000

					if var_279_5 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + 0
					end

					if var_279_1.prefab_name ~= "" and arg_276_1.actors_[var_279_1.prefab_name] ~= nil then
						local var_279_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_1.prefab_name].transform, "story_v_out_322112", "322112067", "story_v_out_322112.awb")

						arg_276_1:RecordAudio("322112067", var_279_6)
						arg_276_1:RecordAudio("322112067", var_279_6)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_322112", "322112067", "story_v_out_322112.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_322112", "322112067", "story_v_out_322112.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_7 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_7 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_7

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_7 and arg_276_1.time_ < 0 + var_279_7 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play322112068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 322112068
		arg_280_1.duration_ = 2.23

		local var_280_0 = {
			zh = 1.566,
			ja = 2.233
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
				arg_280_0:Play322112069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["10049ui_story"]) and arg_280_1.var_.characterEffect10049ui_story == nil then
				arg_280_1.var_.characterEffect10049ui_story = arg_280_1.actors_["10049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["10049ui_story"]) then
				if arg_280_1.var_.characterEffect10049ui_story and not isNil(arg_280_1.actors_["10049ui_story"]) then
					arg_280_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_280_1.var_.characterEffect10049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 0) / var_283_0)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["10049ui_story"]) and arg_280_1.var_.characterEffect10049ui_story then
				arg_280_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_280_1.var_.characterEffect10049ui_story.fillRatio = 0.5
			end

			local var_283_1 = 0
			local var_283_2 = 0.15

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_3 = arg_280_1:GetWordFromCfg(322112068)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_6 = 6 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 6)

				if (6 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 6)) > 0 and var_283_2 < var_283_6 then
					arg_280_1.talkMaxDuration = var_283_6

					if var_283_6 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_1
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112068", "story_v_out_322112.awb") ~= 0 then
					local var_283_7 = manager.audio:GetVoiceLength("story_v_out_322112", "322112068", "story_v_out_322112.awb") / 1000

					if var_283_7 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_1
					end

					if var_283_3.prefab_name ~= "" and arg_280_1.actors_[var_283_3.prefab_name] ~= nil then
						local var_283_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_3.prefab_name].transform, "story_v_out_322112", "322112068", "story_v_out_322112.awb")

						arg_280_1:RecordAudio("322112068", var_283_8)
						arg_280_1:RecordAudio("322112068", var_283_8)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_322112", "322112068", "story_v_out_322112.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_322112", "322112068", "story_v_out_322112.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_9 = math.max(var_283_2, arg_280_1.talkMaxDuration)

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_9 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_1) / var_283_9

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_1 + var_283_9 and arg_280_1.time_ < var_283_1 + var_283_9 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play322112069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 322112069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play322112070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos10049ui_story = arg_284_1.actors_["10049ui_story"].transform.localPosition

				local var_287_0 = GameObjectTools.GetOrAddComponent(arg_284_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_287_0 then
					var_287_0:EnableDynamicBone(false)
				end
			end

			local var_287_1 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_1 then
				arg_284_1.actors_["10049ui_story"].transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10049ui_story, Vector3.New(0, 100, 0), (arg_284_1.time_ - 0) / var_287_1)
				arg_284_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["10049ui_story"].transform.position).z)
				arg_284_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["10049ui_story"].transform.localEulerAngles = arg_284_1.actors_["10049ui_story"].transform.localEulerAngles
			end

			if arg_284_1.time_ >= 0 + var_287_1 and arg_284_1.time_ < 0 + var_287_1 + arg_287_0 then
				arg_284_1.actors_["10049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_284_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["10049ui_story"].transform.position).z)
				arg_284_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["10049ui_story"].transform.localEulerAngles = arg_284_1.actors_["10049ui_story"].transform.localEulerAngles

				local var_287_2 = GameObjectTools.GetOrAddComponent(arg_284_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_287_2 then
					var_287_2:EnableDynamicBone(true)
				end
			end

			local var_287_3 = 0
			local var_287_4 = 1.275

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_3 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_5 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(322112069).content)

				arg_284_1.text_.text = var_287_5

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_7 = 51 <= 0 and var_287_4 or var_287_4 * (utf8.len(var_287_5) / 51)

				if (51 <= 0 and var_287_4 or var_287_4 * (utf8.len(var_287_5) / 51)) > 0 and var_287_4 < var_287_7 then
					arg_284_1.talkMaxDuration = var_287_7

					if var_287_7 + var_287_3 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_3
					end
				end

				arg_284_1.text_.text = var_287_5
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_8 = math.max(var_287_4, arg_284_1.talkMaxDuration)

			if var_287_3 <= arg_284_1.time_ and arg_284_1.time_ < var_287_3 + var_287_8 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_3) / var_287_8

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_3 + var_287_8 and arg_284_1.time_ < var_287_3 + var_287_8 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play322112070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 322112070
		arg_288_1.duration_ = 2.6

		local var_288_0 = {
			zh = 2.066,
			ja = 2.6
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
				arg_288_0:Play322112071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0.3

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_1 = arg_288_1:GetWordFromCfg(322112070)
				local var_291_2 = arg_288_1:FormatText(var_291_1.content)

				arg_288_1.text_.text = var_291_2

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_4 = 12 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 12)

				if (12 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 12)) > 0 and var_291_0 < var_291_4 then
					arg_288_1.talkMaxDuration = var_291_4

					if var_291_4 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_4 + 0
					end
				end

				arg_288_1.text_.text = var_291_2
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112070", "story_v_out_322112.awb") ~= 0 then
					local var_291_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112070", "story_v_out_322112.awb") / 1000

					if var_291_5 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + 0
					end

					if var_291_1.prefab_name ~= "" and arg_288_1.actors_[var_291_1.prefab_name] ~= nil then
						local var_291_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_1.prefab_name].transform, "story_v_out_322112", "322112070", "story_v_out_322112.awb")

						arg_288_1:RecordAudio("322112070", var_291_6)
						arg_288_1:RecordAudio("322112070", var_291_6)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_322112", "322112070", "story_v_out_322112.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_322112", "322112070", "story_v_out_322112.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_7 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_7 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_7

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_7 and arg_288_1.time_ < 0 + var_291_7 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play322112071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 322112071
		arg_292_1.duration_ = 8.5

		local var_292_0 = {
			zh = 7.7,
			ja = 8.5
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
				arg_292_0:Play322112072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos10049ui_story = arg_292_1.actors_["10049ui_story"].transform.localPosition

				local var_295_0 = GameObjectTools.GetOrAddComponent(arg_292_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_295_0 then
					var_295_0:EnableDynamicBone(false)
				end
			end

			local var_295_1 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_1 then
				arg_292_1.actors_["10049ui_story"].transform.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10049ui_story, Vector3.New(0, -1.13, -6), (arg_292_1.time_ - 0) / var_295_1)
				arg_292_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["10049ui_story"].transform.position).z)
				arg_292_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["10049ui_story"].transform.localEulerAngles = arg_292_1.actors_["10049ui_story"].transform.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_1 and arg_292_1.time_ < 0 + var_295_1 + arg_295_0 then
				arg_292_1.actors_["10049ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6)
				arg_292_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["10049ui_story"].transform.position).z)
				arg_292_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["10049ui_story"].transform.localEulerAngles = arg_292_1.actors_["10049ui_story"].transform.localEulerAngles

				local var_295_2 = GameObjectTools.GetOrAddComponent(arg_292_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_295_2 then
					var_295_2:EnableDynamicBone(true)
				end
			end

			local var_295_3 = arg_292_1.actors_["10049ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_3) and arg_292_1.var_.characterEffect10049ui_story == nil then
				arg_292_1.var_.characterEffect10049ui_story = var_295_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_4 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 and not isNil(var_295_3) then
				if arg_292_1.var_.characterEffect10049ui_story and not isNil(var_295_3) then
					arg_292_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 and not isNil(var_295_3) and arg_292_1.var_.characterEffect10049ui_story then
				arg_292_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action1_1")
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				if not isNil(arg_292_1.actors_["10049ui_story"]) then
					local var_295_6 = GameObjectTools.GetOrAddComponent(arg_292_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_295_6 then
						var_295_6:EnableDynamicBone(true)
					end
				end
			end

			local var_295_7 = 0
			local var_295_8 = 0.775

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_7 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_9 = arg_292_1:GetWordFromCfg(322112071)
				local var_295_10 = arg_292_1:FormatText(var_295_9.content)

				arg_292_1.text_.text = var_295_10

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_12 = 31 <= 0 and var_295_8 or var_295_8 * (utf8.len(var_295_10) / 31)

				if (31 <= 0 and var_295_8 or var_295_8 * (utf8.len(var_295_10) / 31)) > 0 and var_295_8 < var_295_12 then
					arg_292_1.talkMaxDuration = var_295_12

					if var_295_12 + var_295_7 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_12 + var_295_7
					end
				end

				arg_292_1.text_.text = var_295_10
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112071", "story_v_out_322112.awb") ~= 0 then
					local var_295_13 = manager.audio:GetVoiceLength("story_v_out_322112", "322112071", "story_v_out_322112.awb") / 1000

					if var_295_13 + var_295_7 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_13 + var_295_7
					end

					if var_295_9.prefab_name ~= "" and arg_292_1.actors_[var_295_9.prefab_name] ~= nil then
						local var_295_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_9.prefab_name].transform, "story_v_out_322112", "322112071", "story_v_out_322112.awb")

						arg_292_1:RecordAudio("322112071", var_295_14)
						arg_292_1:RecordAudio("322112071", var_295_14)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_322112", "322112071", "story_v_out_322112.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_322112", "322112071", "story_v_out_322112.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_15 = math.max(var_295_8, arg_292_1.talkMaxDuration)

			if var_295_7 <= arg_292_1.time_ and arg_292_1.time_ < var_295_7 + var_295_15 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_7) / var_295_15

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_7 + var_295_15 and arg_292_1.time_ < var_295_7 + var_295_15 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play322112072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 322112072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play322112073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos10049ui_story = arg_296_1.actors_["10049ui_story"].transform.localPosition

				local var_299_0 = GameObjectTools.GetOrAddComponent(arg_296_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_299_0 then
					var_299_0:EnableDynamicBone(false)
				end
			end

			local var_299_1 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_1 then
				arg_296_1.actors_["10049ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10049ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 0) / var_299_1)
				arg_296_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["10049ui_story"].transform.position).z)
				arg_296_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["10049ui_story"].transform.localEulerAngles = arg_296_1.actors_["10049ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_1 and arg_296_1.time_ < 0 + var_299_1 + arg_299_0 then
				arg_296_1.actors_["10049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["10049ui_story"].transform.position).z)
				arg_296_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["10049ui_story"].transform.localEulerAngles = arg_296_1.actors_["10049ui_story"].transform.localEulerAngles

				local var_299_2 = GameObjectTools.GetOrAddComponent(arg_296_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_299_2 then
					var_299_2:EnableDynamicBone(true)
				end
			end

			local var_299_3 = 0
			local var_299_4 = 1.05

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_3 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_5 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(322112072).content)

				arg_296_1.text_.text = var_299_5

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_7 = 42 <= 0 and var_299_4 or var_299_4 * (utf8.len(var_299_5) / 42)

				if (42 <= 0 and var_299_4 or var_299_4 * (utf8.len(var_299_5) / 42)) > 0 and var_299_4 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_3 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_3
					end
				end

				arg_296_1.text_.text = var_299_5
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_8 = math.max(var_299_4, arg_296_1.talkMaxDuration)

			if var_299_3 <= arg_296_1.time_ and arg_296_1.time_ < var_299_3 + var_299_8 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_3) / var_299_8

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_3 + var_299_8 and arg_296_1.time_ < var_299_3 + var_299_8 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play322112073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 322112073
		arg_300_1.duration_ = 8.77

		local var_300_0 = {
			zh = 8.166,
			ja = 8.766
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
				arg_300_0:Play322112074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos10049ui_story = arg_300_1.actors_["10049ui_story"].transform.localPosition

				local var_303_0 = GameObjectTools.GetOrAddComponent(arg_300_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_303_0 then
					var_303_0:EnableDynamicBone(false)
				end
			end

			local var_303_1 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_1 then
				arg_300_1.actors_["10049ui_story"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10049ui_story, Vector3.New(0, -1.13, -6), (arg_300_1.time_ - 0) / var_303_1)
				arg_300_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["10049ui_story"].transform.position).z)
				arg_300_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["10049ui_story"].transform.localEulerAngles = arg_300_1.actors_["10049ui_story"].transform.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_1 and arg_300_1.time_ < 0 + var_303_1 + arg_303_0 then
				arg_300_1.actors_["10049ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6)
				arg_300_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["10049ui_story"].transform.position).z)
				arg_300_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["10049ui_story"].transform.localEulerAngles = arg_300_1.actors_["10049ui_story"].transform.localEulerAngles

				local var_303_2 = GameObjectTools.GetOrAddComponent(arg_300_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_303_2 then
					var_303_2:EnableDynamicBone(true)
				end
			end

			local var_303_3 = arg_300_1.actors_["10049ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_3) and arg_300_1.var_.characterEffect10049ui_story == nil then
				arg_300_1.var_.characterEffect10049ui_story = var_303_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_4 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 and not isNil(var_303_3) then
				if arg_300_1.var_.characterEffect10049ui_story and not isNil(var_303_3) then
					arg_300_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 and not isNil(var_303_3) and arg_300_1.var_.characterEffect10049ui_story then
				arg_300_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action3_1")
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				if not isNil(arg_300_1.actors_["10049ui_story"]) then
					local var_303_6 = GameObjectTools.GetOrAddComponent(arg_300_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_303_6 then
						var_303_6:EnableDynamicBone(true)
					end
				end
			end

			local var_303_7 = 0
			local var_303_8 = 0.675

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_7 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_9 = arg_300_1:GetWordFromCfg(322112073)
				local var_303_10 = arg_300_1:FormatText(var_303_9.content)

				arg_300_1.text_.text = var_303_10

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_12 = 28 <= 0 and var_303_8 or var_303_8 * (utf8.len(var_303_10) / 28)

				if (28 <= 0 and var_303_8 or var_303_8 * (utf8.len(var_303_10) / 28)) > 0 and var_303_8 < var_303_12 then
					arg_300_1.talkMaxDuration = var_303_12

					if var_303_12 + var_303_7 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_12 + var_303_7
					end
				end

				arg_300_1.text_.text = var_303_10
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112073", "story_v_out_322112.awb") ~= 0 then
					local var_303_13 = manager.audio:GetVoiceLength("story_v_out_322112", "322112073", "story_v_out_322112.awb") / 1000

					if var_303_13 + var_303_7 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_13 + var_303_7
					end

					if var_303_9.prefab_name ~= "" and arg_300_1.actors_[var_303_9.prefab_name] ~= nil then
						local var_303_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_9.prefab_name].transform, "story_v_out_322112", "322112073", "story_v_out_322112.awb")

						arg_300_1:RecordAudio("322112073", var_303_14)
						arg_300_1:RecordAudio("322112073", var_303_14)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_322112", "322112073", "story_v_out_322112.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_322112", "322112073", "story_v_out_322112.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_15 = math.max(var_303_8, arg_300_1.talkMaxDuration)

			if var_303_7 <= arg_300_1.time_ and arg_300_1.time_ < var_303_7 + var_303_15 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_7) / var_303_15

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_7 + var_303_15 and arg_300_1.time_ < var_303_7 + var_303_15 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play322112074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 322112074
		arg_304_1.duration_ = 11.1

		local var_304_0 = {
			zh = 11.1,
			ja = 9.5
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
				arg_304_0:Play322112075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0.85

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_1 = arg_304_1:GetWordFromCfg(322112074)
				local var_307_2 = arg_304_1:FormatText(var_307_1.content)

				arg_304_1.text_.text = var_307_2

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 34 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 34)

				if (34 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 34)) > 0 and var_307_0 < var_307_4 then
					arg_304_1.talkMaxDuration = var_307_4

					if var_307_4 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_4 + 0
					end
				end

				arg_304_1.text_.text = var_307_2
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112074", "story_v_out_322112.awb") ~= 0 then
					local var_307_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112074", "story_v_out_322112.awb") / 1000

					if var_307_5 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + 0
					end

					if var_307_1.prefab_name ~= "" and arg_304_1.actors_[var_307_1.prefab_name] ~= nil then
						local var_307_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_1.prefab_name].transform, "story_v_out_322112", "322112074", "story_v_out_322112.awb")

						arg_304_1:RecordAudio("322112074", var_307_6)
						arg_304_1:RecordAudio("322112074", var_307_6)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_322112", "322112074", "story_v_out_322112.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_322112", "322112074", "story_v_out_322112.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_7 and arg_304_1.time_ < 0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play322112075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 322112075
		arg_308_1.duration_ = 14.53

		local var_308_0 = {
			zh = 14.533,
			ja = 12.933
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
				arg_308_0:Play322112076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action3_2")
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				if not isNil(arg_308_1.actors_["10049ui_story"]) then
					local var_311_0 = GameObjectTools.GetOrAddComponent(arg_308_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_311_0 then
						var_311_0:EnableDynamicBone(true)
					end
				end
			end

			local var_311_1 = 0
			local var_311_2 = 1.2

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_3 = arg_308_1:GetWordFromCfg(322112075)
				local var_311_4 = arg_308_1:FormatText(var_311_3.content)

				arg_308_1.text_.text = var_311_4

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_6 = 48 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_4) / 48)

				if (48 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_4) / 48)) > 0 and var_311_2 < var_311_6 then
					arg_308_1.talkMaxDuration = var_311_6

					if var_311_6 + var_311_1 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_6 + var_311_1
					end
				end

				arg_308_1.text_.text = var_311_4
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112075", "story_v_out_322112.awb") ~= 0 then
					local var_311_7 = manager.audio:GetVoiceLength("story_v_out_322112", "322112075", "story_v_out_322112.awb") / 1000

					if var_311_7 + var_311_1 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_7 + var_311_1
					end

					if var_311_3.prefab_name ~= "" and arg_308_1.actors_[var_311_3.prefab_name] ~= nil then
						local var_311_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_3.prefab_name].transform, "story_v_out_322112", "322112075", "story_v_out_322112.awb")

						arg_308_1:RecordAudio("322112075", var_311_8)
						arg_308_1:RecordAudio("322112075", var_311_8)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_322112", "322112075", "story_v_out_322112.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_322112", "322112075", "story_v_out_322112.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_9 = math.max(var_311_2, arg_308_1.talkMaxDuration)

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_9 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_1) / var_311_9

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_1 + var_311_9 and arg_308_1.time_ < var_311_1 + var_311_9 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play322112076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 322112076
		arg_312_1.duration_ = 9.27

		local var_312_0 = {
			zh = 5.666,
			ja = 9.266
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
				arg_312_0:Play322112077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["10049ui_story"]) and arg_312_1.var_.characterEffect10049ui_story == nil then
				arg_312_1.var_.characterEffect10049ui_story = arg_312_1.actors_["10049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_0 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["10049ui_story"]) then
				if arg_312_1.var_.characterEffect10049ui_story and not isNil(arg_312_1.actors_["10049ui_story"]) then
					arg_312_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_312_1.var_.characterEffect10049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_312_1.time_ - 0) / var_315_0)
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["10049ui_story"]) and arg_312_1.var_.characterEffect10049ui_story then
				arg_312_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_312_1.var_.characterEffect10049ui_story.fillRatio = 0.5
			end

			local var_315_1 = 0
			local var_315_2 = 0.725

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_3 = arg_312_1:GetWordFromCfg(322112076)
				local var_315_4 = arg_312_1:FormatText(var_315_3.content)

				arg_312_1.text_.text = var_315_4

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_6 = 29 <= 0 and var_315_2 or var_315_2 * (utf8.len(var_315_4) / 29)

				if (29 <= 0 and var_315_2 or var_315_2 * (utf8.len(var_315_4) / 29)) > 0 and var_315_2 < var_315_6 then
					arg_312_1.talkMaxDuration = var_315_6

					if var_315_6 + var_315_1 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_6 + var_315_1
					end
				end

				arg_312_1.text_.text = var_315_4
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112076", "story_v_out_322112.awb") ~= 0 then
					local var_315_7 = manager.audio:GetVoiceLength("story_v_out_322112", "322112076", "story_v_out_322112.awb") / 1000

					if var_315_7 + var_315_1 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_7 + var_315_1
					end

					if var_315_3.prefab_name ~= "" and arg_312_1.actors_[var_315_3.prefab_name] ~= nil then
						local var_315_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_3.prefab_name].transform, "story_v_out_322112", "322112076", "story_v_out_322112.awb")

						arg_312_1:RecordAudio("322112076", var_315_8)
						arg_312_1:RecordAudio("322112076", var_315_8)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_322112", "322112076", "story_v_out_322112.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_322112", "322112076", "story_v_out_322112.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_9 = math.max(var_315_2, arg_312_1.talkMaxDuration)

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_9 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_1) / var_315_9

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_1 + var_315_9 and arg_312_1.time_ < var_315_1 + var_315_9 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play322112077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 322112077
		arg_316_1.duration_ = 10.93

		local var_316_0 = {
			zh = 8.9,
			ja = 10.933
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
				arg_316_0:Play322112078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos10049ui_story = arg_316_1.actors_["10049ui_story"].transform.localPosition

				local var_319_0 = GameObjectTools.GetOrAddComponent(arg_316_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_319_0 then
					var_319_0:EnableDynamicBone(false)
				end
			end

			local var_319_1 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_1 then
				arg_316_1.actors_["10049ui_story"].transform.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10049ui_story, Vector3.New(0, -1.13, -6), (arg_316_1.time_ - 0) / var_319_1)
				arg_316_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["10049ui_story"].transform.position).z)
				arg_316_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["10049ui_story"].transform.localEulerAngles = arg_316_1.actors_["10049ui_story"].transform.localEulerAngles
			end

			if arg_316_1.time_ >= 0 + var_319_1 and arg_316_1.time_ < 0 + var_319_1 + arg_319_0 then
				arg_316_1.actors_["10049ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6)
				arg_316_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["10049ui_story"].transform.position).z)
				arg_316_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["10049ui_story"].transform.localEulerAngles = arg_316_1.actors_["10049ui_story"].transform.localEulerAngles

				local var_319_2 = GameObjectTools.GetOrAddComponent(arg_316_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_319_2 then
					var_319_2:EnableDynamicBone(true)
				end
			end

			local var_319_3 = arg_316_1.actors_["10049ui_story"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_3) and arg_316_1.var_.characterEffect10049ui_story == nil then
				arg_316_1.var_.characterEffect10049ui_story = var_319_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_4 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_4 and not isNil(var_319_3) then
				if arg_316_1.var_.characterEffect10049ui_story and not isNil(var_319_3) then
					arg_316_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= 0 + var_319_4 and arg_316_1.time_ < 0 + var_319_4 + arg_319_0 and not isNil(var_319_3) and arg_316_1.var_.characterEffect10049ui_story then
				arg_316_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action9_1")
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				if not isNil(arg_316_1.actors_["10049ui_story"]) then
					local var_319_6 = GameObjectTools.GetOrAddComponent(arg_316_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_319_6 then
						var_319_6:EnableDynamicBone(true)
					end
				end
			end

			local var_319_7 = 0
			local var_319_8 = 0.775

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_7 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_9 = arg_316_1:GetWordFromCfg(322112077)
				local var_319_10 = arg_316_1:FormatText(var_319_9.content)

				arg_316_1.text_.text = var_319_10

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_12 = 31 <= 0 and var_319_8 or var_319_8 * (utf8.len(var_319_10) / 31)

				if (31 <= 0 and var_319_8 or var_319_8 * (utf8.len(var_319_10) / 31)) > 0 and var_319_8 < var_319_12 then
					arg_316_1.talkMaxDuration = var_319_12

					if var_319_12 + var_319_7 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_12 + var_319_7
					end
				end

				arg_316_1.text_.text = var_319_10
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112077", "story_v_out_322112.awb") ~= 0 then
					local var_319_13 = manager.audio:GetVoiceLength("story_v_out_322112", "322112077", "story_v_out_322112.awb") / 1000

					if var_319_13 + var_319_7 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_7
					end

					if var_319_9.prefab_name ~= "" and arg_316_1.actors_[var_319_9.prefab_name] ~= nil then
						local var_319_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_9.prefab_name].transform, "story_v_out_322112", "322112077", "story_v_out_322112.awb")

						arg_316_1:RecordAudio("322112077", var_319_14)
						arg_316_1:RecordAudio("322112077", var_319_14)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_322112", "322112077", "story_v_out_322112.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_322112", "322112077", "story_v_out_322112.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_15 = math.max(var_319_8, arg_316_1.talkMaxDuration)

			if var_319_7 <= arg_316_1.time_ and arg_316_1.time_ < var_319_7 + var_319_15 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_7) / var_319_15

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_7 + var_319_15 and arg_316_1.time_ < var_319_7 + var_319_15 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play322112078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 322112078
		arg_320_1.duration_ = 15.4

		local var_320_0 = {
			zh = 9.2,
			ja = 15.4
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
				arg_320_0:Play322112079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.925

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_1 = arg_320_1:GetWordFromCfg(322112078)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 37 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 37)

				if (37 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 37)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112078", "story_v_out_322112.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112078", "story_v_out_322112.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_out_322112", "322112078", "story_v_out_322112.awb")

						arg_320_1:RecordAudio("322112078", var_323_6)
						arg_320_1:RecordAudio("322112078", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_322112", "322112078", "story_v_out_322112.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_322112", "322112078", "story_v_out_322112.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play322112079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 322112079
		arg_324_1.duration_ = 7.7

		local var_324_0 = {
			zh = 5.7,
			ja = 7.7
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
				arg_324_0:Play322112080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["10049ui_story"]) and arg_324_1.var_.characterEffect10049ui_story == nil then
				arg_324_1.var_.characterEffect10049ui_story = arg_324_1.actors_["10049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_0 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["10049ui_story"]) then
				if arg_324_1.var_.characterEffect10049ui_story and not isNil(arg_324_1.actors_["10049ui_story"]) then
					arg_324_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_324_1.var_.characterEffect10049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_324_1.time_ - 0) / var_327_0)
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["10049ui_story"]) and arg_324_1.var_.characterEffect10049ui_story then
				arg_324_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_324_1.var_.characterEffect10049ui_story.fillRatio = 0.5
			end

			local var_327_1 = 0
			local var_327_2 = 0.675

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_3 = arg_324_1:GetWordFromCfg(322112079)
				local var_327_4 = arg_324_1:FormatText(var_327_3.content)

				arg_324_1.text_.text = var_327_4

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_6 = 27 <= 0 and var_327_2 or var_327_2 * (utf8.len(var_327_4) / 27)

				if (27 <= 0 and var_327_2 or var_327_2 * (utf8.len(var_327_4) / 27)) > 0 and var_327_2 < var_327_6 then
					arg_324_1.talkMaxDuration = var_327_6

					if var_327_6 + var_327_1 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_6 + var_327_1
					end
				end

				arg_324_1.text_.text = var_327_4
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112079", "story_v_out_322112.awb") ~= 0 then
					local var_327_7 = manager.audio:GetVoiceLength("story_v_out_322112", "322112079", "story_v_out_322112.awb") / 1000

					if var_327_7 + var_327_1 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_1
					end

					if var_327_3.prefab_name ~= "" and arg_324_1.actors_[var_327_3.prefab_name] ~= nil then
						local var_327_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_3.prefab_name].transform, "story_v_out_322112", "322112079", "story_v_out_322112.awb")

						arg_324_1:RecordAudio("322112079", var_327_8)
						arg_324_1:RecordAudio("322112079", var_327_8)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_322112", "322112079", "story_v_out_322112.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_322112", "322112079", "story_v_out_322112.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_9 = math.max(var_327_2, arg_324_1.talkMaxDuration)

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_9 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_1) / var_327_9

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_1 + var_327_9 and arg_324_1.time_ < var_327_1 + var_327_9 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play322112080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 322112080
		arg_328_1.duration_ = 4.7

		local var_328_0 = {
			zh = 3.2,
			ja = 4.7
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
				arg_328_0:Play322112081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0.45

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_1 = arg_328_1:GetWordFromCfg(322112080)
				local var_331_2 = arg_328_1:FormatText(var_331_1.content)

				arg_328_1.text_.text = var_331_2

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_4 = 18 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_2) / 18)

				if (18 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_2) / 18)) > 0 and var_331_0 < var_331_4 then
					arg_328_1.talkMaxDuration = var_331_4

					if var_331_4 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_4 + 0
					end
				end

				arg_328_1.text_.text = var_331_2
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112080", "story_v_out_322112.awb") ~= 0 then
					local var_331_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112080", "story_v_out_322112.awb") / 1000

					if var_331_5 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_5 + 0
					end

					if var_331_1.prefab_name ~= "" and arg_328_1.actors_[var_331_1.prefab_name] ~= nil then
						local var_331_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_1.prefab_name].transform, "story_v_out_322112", "322112080", "story_v_out_322112.awb")

						arg_328_1:RecordAudio("322112080", var_331_6)
						arg_328_1:RecordAudio("322112080", var_331_6)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_322112", "322112080", "story_v_out_322112.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_322112", "322112080", "story_v_out_322112.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_7 = math.max(var_331_0, arg_328_1.talkMaxDuration)

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_7 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - 0) / var_331_7

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= 0 + var_331_7 and arg_328_1.time_ < 0 + var_331_7 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play322112081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 322112081
		arg_332_1.duration_ = 2.97

		local var_332_0 = {
			zh = 2.3,
			ja = 2.966
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
				arg_332_0:Play322112082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos10049ui_story = arg_332_1.actors_["10049ui_story"].transform.localPosition

				local var_335_0 = GameObjectTools.GetOrAddComponent(arg_332_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_335_0 then
					var_335_0:EnableDynamicBone(false)
				end
			end

			local var_335_1 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_1 then
				arg_332_1.actors_["10049ui_story"].transform.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10049ui_story, Vector3.New(0, -1.13, -6), (arg_332_1.time_ - 0) / var_335_1)
				arg_332_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10049ui_story"].transform.position).z)
				arg_332_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["10049ui_story"].transform.localEulerAngles = arg_332_1.actors_["10049ui_story"].transform.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_1 and arg_332_1.time_ < 0 + var_335_1 + arg_335_0 then
				arg_332_1.actors_["10049ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6)
				arg_332_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10049ui_story"].transform.position).z)
				arg_332_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["10049ui_story"].transform.localEulerAngles = arg_332_1.actors_["10049ui_story"].transform.localEulerAngles

				local var_335_2 = GameObjectTools.GetOrAddComponent(arg_332_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_335_2 then
					var_335_2:EnableDynamicBone(true)
				end
			end

			local var_335_3 = arg_332_1.actors_["10049ui_story"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_3) and arg_332_1.var_.characterEffect10049ui_story == nil then
				arg_332_1.var_.characterEffect10049ui_story = var_335_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_4 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_4 and not isNil(var_335_3) then
				if arg_332_1.var_.characterEffect10049ui_story and not isNil(var_335_3) then
					arg_332_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= 0 + var_335_4 and arg_332_1.time_ < 0 + var_335_4 + arg_335_0 and not isNil(var_335_3) and arg_332_1.var_.characterEffect10049ui_story then
				arg_332_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action9_2")
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				if not isNil(arg_332_1.actors_["10049ui_story"]) then
					local var_335_6 = GameObjectTools.GetOrAddComponent(arg_332_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_335_6 then
						var_335_6:EnableDynamicBone(true)
					end
				end
			end

			local var_335_7 = 0
			local var_335_8 = 0.125

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_7 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_9 = arg_332_1:GetWordFromCfg(322112081)
				local var_335_10 = arg_332_1:FormatText(var_335_9.content)

				arg_332_1.text_.text = var_335_10

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_12 = 5 <= 0 and var_335_8 or var_335_8 * (utf8.len(var_335_10) / 5)

				if (5 <= 0 and var_335_8 or var_335_8 * (utf8.len(var_335_10) / 5)) > 0 and var_335_8 < var_335_12 then
					arg_332_1.talkMaxDuration = var_335_12

					if var_335_12 + var_335_7 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_12 + var_335_7
					end
				end

				arg_332_1.text_.text = var_335_10
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112081", "story_v_out_322112.awb") ~= 0 then
					local var_335_13 = manager.audio:GetVoiceLength("story_v_out_322112", "322112081", "story_v_out_322112.awb") / 1000

					if var_335_13 + var_335_7 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_13 + var_335_7
					end

					if var_335_9.prefab_name ~= "" and arg_332_1.actors_[var_335_9.prefab_name] ~= nil then
						local var_335_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_9.prefab_name].transform, "story_v_out_322112", "322112081", "story_v_out_322112.awb")

						arg_332_1:RecordAudio("322112081", var_335_14)
						arg_332_1:RecordAudio("322112081", var_335_14)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_322112", "322112081", "story_v_out_322112.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_322112", "322112081", "story_v_out_322112.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_15 = math.max(var_335_8, arg_332_1.talkMaxDuration)

			if var_335_7 <= arg_332_1.time_ and arg_332_1.time_ < var_335_7 + var_335_15 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_7) / var_335_15

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_7 + var_335_15 and arg_332_1.time_ < var_335_7 + var_335_15 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play322112082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 322112082
		arg_336_1.duration_ = 13.53

		local var_336_0 = {
			zh = 10.3660000029802,
			ja = 13.5330000029802
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
				arg_336_0:Play322112083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 1.999999999999 < arg_336_1.time_ and arg_336_1.time_ <= 1.999999999999 + arg_339_0 then
				local var_339_0 = arg_336_1.bgs_.L14f

				arg_336_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_339_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_339_1 = var_339_0:GetComponent("SpriteRenderer")

				if var_339_1 and var_339_1.sprite then
					local var_339_2 = 2 * (var_339_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_339_0.transform.localScale = Vector3.New(var_339_2 / var_339_1.sprite.bounds.size.y < var_339_2 * manager.ui.mainCameraCom_.aspect / var_339_1.sprite.bounds.size.x and var_339_2 * manager.ui.mainCameraCom_.aspect / var_339_1.sprite.bounds.size.x or var_339_2 / var_339_1.sprite.bounds.size.y, var_339_2 / var_339_1.sprite.bounds.size.y < var_339_2 * manager.ui.mainCameraCom_.aspect / var_339_1.sprite.bounds.size.x and var_339_2 * manager.ui.mainCameraCom_.aspect / var_339_1.sprite.bounds.size.x or var_339_2 / var_339_1.sprite.bounds.size.y, 0)
				end

				for iter_339_0, iter_339_1 in pairs(arg_336_1.bgs_) do
					if iter_339_0 ~= "L14f" then
						iter_339_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_339_3 = 4.00000000298023

			if 4.00000000298023 < arg_336_1.time_ and arg_336_1.time_ <= var_339_3 + arg_339_0 then
				arg_336_1.allBtn_.enabled = false
			end

			if arg_336_1.time_ >= var_339_3 + 0.3 and arg_336_1.time_ < var_339_3 + 0.3 + arg_339_0 then
				arg_336_1.allBtn_.enabled = true
			end

			local var_339_4 = 0

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_4 + arg_339_0 then
				arg_336_1.mask_.enabled = true
				arg_336_1.mask_.raycastTarget = true

				arg_336_1:SetGaussion(false)
			end

			local var_339_5 = 2

			if var_339_4 <= arg_336_1.time_ and arg_336_1.time_ < var_339_4 + var_339_5 then
				local var_339_6 = Color.New(0, 0, 0)

				var_339_6.a = Mathf.Lerp(0, 1, (arg_336_1.time_ - var_339_4) / var_339_5)
				arg_336_1.mask_.color = var_339_6
			end

			if arg_336_1.time_ >= var_339_4 + var_339_5 and arg_336_1.time_ < var_339_4 + var_339_5 + arg_339_0 then
				local var_339_7 = Color.New(0, 0, 0)

				var_339_7.a = 1
				arg_336_1.mask_.color = var_339_7
			end

			local var_339_8 = 2

			if 2 < arg_336_1.time_ and arg_336_1.time_ <= var_339_8 + arg_339_0 then
				arg_336_1.mask_.enabled = true
				arg_336_1.mask_.raycastTarget = true

				arg_336_1:SetGaussion(false)
			end

			local var_339_9 = 2

			if var_339_8 <= arg_336_1.time_ and arg_336_1.time_ < var_339_8 + var_339_9 then
				local var_339_10 = Color.New(0, 0, 0)

				var_339_10.a = Mathf.Lerp(1, 0, (arg_336_1.time_ - var_339_8) / var_339_9)
				arg_336_1.mask_.color = var_339_10
			end

			if arg_336_1.time_ >= var_339_8 + var_339_9 and arg_336_1.time_ < var_339_8 + var_339_9 + arg_339_0 then
				local var_339_11 = Color.New(0, 0, 0)

				arg_336_1.mask_.enabled = false
				var_339_11.a = 0
				arg_336_1.mask_.color = var_339_11
			end

			local var_339_12 = arg_336_1.actors_["10049ui_story"].transform

			if 1.96599999815226 < arg_336_1.time_ and arg_336_1.time_ <= 1.96599999815226 + arg_339_0 then
				arg_336_1.var_.moveOldPos10049ui_story = var_339_12.localPosition

				local var_339_13 = GameObjectTools.GetOrAddComponent(var_339_12.gameObject, typeof(DynamicBoneHelper))

				if var_339_13 then
					var_339_13:EnableDynamicBone(false)
				end
			end

			local var_339_14 = 0.001

			if 1.96599999815226 <= arg_336_1.time_ and arg_336_1.time_ < 1.96599999815226 + var_339_14 then
				var_339_12.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos10049ui_story, Vector3.New(0, 100, 0), (arg_336_1.time_ - 1.96599999815226) / var_339_14)
				var_339_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_12.position).x, (manager.ui.mainCamera.transform.position - var_339_12.position).y, (manager.ui.mainCamera.transform.position - var_339_12.position).z)
				var_339_12.localEulerAngles.z = 0
				var_339_12.localEulerAngles.x = 0
				var_339_12.localEulerAngles = var_339_12.localEulerAngles
			end

			if arg_336_1.time_ >= 1.96599999815226 + var_339_14 and arg_336_1.time_ < 1.96599999815226 + var_339_14 + arg_339_0 then
				var_339_12.localPosition = Vector3.New(0, 100, 0)
				var_339_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_12.position).x, (manager.ui.mainCamera.transform.position - var_339_12.position).y, (manager.ui.mainCamera.transform.position - var_339_12.position).z)
				var_339_12.localEulerAngles.z = 0
				var_339_12.localEulerAngles.x = 0
				var_339_12.localEulerAngles = var_339_12.localEulerAngles

				local var_339_15 = GameObjectTools.GetOrAddComponent(var_339_12.gameObject, typeof(DynamicBoneHelper))

				if var_339_15 then
					var_339_15:EnableDynamicBone(true)
				end
			end

			local var_339_16 = arg_336_1.actors_["10104ui_story"].transform

			if 3.8 < arg_336_1.time_ and arg_336_1.time_ <= 3.8 + arg_339_0 then
				arg_336_1.var_.moveOldPos10104ui_story = var_339_16.localPosition
			end

			local var_339_17 = 0.001

			if 3.8 <= arg_336_1.time_ and arg_336_1.time_ < 3.8 + var_339_17 then
				var_339_16.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_336_1.time_ - 3.8) / var_339_17)
				var_339_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_16.position).x, (manager.ui.mainCamera.transform.position - var_339_16.position).y, (manager.ui.mainCamera.transform.position - var_339_16.position).z)
				var_339_16.localEulerAngles.z = 0
				var_339_16.localEulerAngles.x = 0
				var_339_16.localEulerAngles = var_339_16.localEulerAngles
			end

			if arg_336_1.time_ >= 3.8 + var_339_17 and arg_336_1.time_ < 3.8 + var_339_17 + arg_339_0 then
				var_339_16.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_339_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_16.position).x, (manager.ui.mainCamera.transform.position - var_339_16.position).y, (manager.ui.mainCamera.transform.position - var_339_16.position).z)
				var_339_16.localEulerAngles.z = 0
				var_339_16.localEulerAngles.x = 0
				var_339_16.localEulerAngles = var_339_16.localEulerAngles
			end

			local var_339_18 = arg_336_1.actors_["10104ui_story"]

			if 3.8 < arg_336_1.time_ and arg_336_1.time_ <= 3.8 + arg_339_0 and not isNil(var_339_18) and arg_336_1.var_.characterEffect10104ui_story == nil then
				arg_336_1.var_.characterEffect10104ui_story = var_339_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_19 = 0.200000002980232

			if 3.8 <= arg_336_1.time_ and arg_336_1.time_ < 3.8 + var_339_19 and not isNil(var_339_18) then
				if arg_336_1.var_.characterEffect10104ui_story and not isNil(var_339_18) then
					arg_336_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= 3.8 + var_339_19 and arg_336_1.time_ < 3.8 + var_339_19 + arg_339_0 and not isNil(var_339_18) and arg_336_1.var_.characterEffect10104ui_story then
				arg_336_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 3.8 < arg_336_1.time_ and arg_336_1.time_ <= 3.8 + arg_339_0 then
				arg_336_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 3.8 < arg_336_1.time_ and arg_336_1.time_ <= 3.8 + arg_339_0 then
				arg_336_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.2 < arg_336_1.time_ and arg_336_1.time_ <= 0.2 + arg_339_0 then
				arg_336_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0.2 < arg_336_1.time_ and arg_336_1.time_ <= 0.2 + arg_339_0 then
				arg_336_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 1.5 < arg_336_1.time_ and arg_336_1.time_ <= 1.5 + arg_339_0 then
				arg_336_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_339_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_336_1.bgmTxt_.text ~= var_339_26 and arg_336_1.bgmTxt_.text ~= "" then
						if arg_336_1.bgmTxt2_.text ~= "" then
							arg_336_1.bgmTxt_.text = arg_336_1.bgmTxt2_.text
						end

						arg_336_1.bgmTxt2_.text = var_339_26

						arg_336_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_336_1.bgmTxt_.text = var_339_26
						arg_336_1.bgmTxt2_.text = var_339_26
					end

					if arg_336_1.bgmTimer then
						arg_336_1.bgmTimer:Stop()

						arg_336_1.bgmTimer = nil
					end

					if arg_336_1.settingData.show_music_name == 1 then
						arg_336_1.musicController:SetSelectedState("show")
						arg_336_1.musicAnimator_:Play("open", 0, 0)

						if arg_336_1.settingData.music_time ~= 0 then
							arg_336_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_336_1.settingData.music_time), function()
								if arg_336_1 == nil or isNil(arg_336_1.bgmTxt_) then
									return
								end

								arg_336_1.musicController:SetSelectedState("hide")
								arg_336_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.5 < arg_336_1.time_ and arg_336_1.time_ <= 0.5 + arg_339_0 then
				arg_336_1:AudioAction("play", "music", "bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference.awb")

				local var_339_29 = manager.audio:GetAudioName("bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference")

				if "" ~= "" then
					if arg_336_1.bgmTxt_.text ~= var_339_29 and arg_336_1.bgmTxt_.text ~= "" then
						if arg_336_1.bgmTxt2_.text ~= "" then
							arg_336_1.bgmTxt_.text = arg_336_1.bgmTxt2_.text
						end

						arg_336_1.bgmTxt2_.text = var_339_29

						arg_336_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_336_1.bgmTxt_.text = var_339_29
						arg_336_1.bgmTxt2_.text = var_339_29
					end

					if arg_336_1.bgmTimer then
						arg_336_1.bgmTimer:Stop()

						arg_336_1.bgmTimer = nil
					end

					if arg_336_1.settingData.show_music_name == 1 then
						arg_336_1.musicController:SetSelectedState("show")
						arg_336_1.musicAnimator_:Play("open", 0, 0)

						if arg_336_1.settingData.music_time ~= 0 then
							arg_336_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_336_1.settingData.music_time), function()
								if arg_336_1 == nil or isNil(arg_336_1.bgmTxt_) then
									return
								end

								arg_336_1.musicController:SetSelectedState("hide")
								arg_336_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_336_1.frameCnt_ <= 1 then
				arg_336_1.dialog_:SetActive(false)
			end

			local var_339_30 = 4.00000000298023
			local var_339_31 = 0.95

			if 4.00000000298023 < arg_336_1.time_ and arg_336_1.time_ <= var_339_30 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0

				arg_336_1.dialog_:SetActive(true)

				arg_336_1.dialogCg_.alpha = 0

				local var_339_32 = LeanTween.value(arg_336_1.dialog_, 0, 1, 0.3)

				var_339_32:setOnUpdate(LuaHelper.FloatAction(function(arg_342_0)
					arg_336_1.dialogCg_.alpha = arg_342_0
				end))
				var_339_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_336_1.dialog_)
					var_339_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_336_1.duration_ = arg_336_1.duration_ + 0.3

				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_33 = arg_336_1:GetWordFromCfg(322112082)
				local var_339_34 = arg_336_1:FormatText(var_339_33.content)

				arg_336_1.text_.text = var_339_34

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_36 = 38 <= 0 and var_339_31 or var_339_31 * (utf8.len(var_339_34) / 38)

				if (38 <= 0 and var_339_31 or var_339_31 * (utf8.len(var_339_34) / 38)) > 0 and var_339_31 < var_339_36 then
					arg_336_1.talkMaxDuration = var_339_36
					var_339_30 = var_339_30 + 0.3

					if var_339_36 + var_339_30 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_36 + var_339_30
					end
				end

				arg_336_1.text_.text = var_339_34
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112082", "story_v_out_322112.awb") ~= 0 then
					local var_339_37 = manager.audio:GetVoiceLength("story_v_out_322112", "322112082", "story_v_out_322112.awb") / 1000

					if var_339_37 + var_339_30 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_37 + var_339_30
					end

					if var_339_33.prefab_name ~= "" and arg_336_1.actors_[var_339_33.prefab_name] ~= nil then
						local var_339_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_33.prefab_name].transform, "story_v_out_322112", "322112082", "story_v_out_322112.awb")

						arg_336_1:RecordAudio("322112082", var_339_38)
						arg_336_1:RecordAudio("322112082", var_339_38)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_322112", "322112082", "story_v_out_322112.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_322112", "322112082", "story_v_out_322112.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_39 = var_339_30 + 0.3
			local var_339_40 = math.max(var_339_31, arg_336_1.talkMaxDuration)

			if var_339_30 + 0.3 <= arg_336_1.time_ and arg_336_1.time_ < var_339_39 + var_339_40 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_39) / var_339_40

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_39 + var_339_40 and arg_336_1.time_ < var_339_39 + var_339_40 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play322112083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 322112083
		arg_344_1.duration_ = 5.13

		local var_344_0 = {
			zh = 3.533,
			ja = 5.133
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
				arg_344_0:Play322112084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(arg_344_1.actors_["10104ui_story"]) and arg_344_1.var_.characterEffect10104ui_story == nil then
				arg_344_1.var_.characterEffect10104ui_story = arg_344_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_0 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 and not isNil(arg_344_1.actors_["10104ui_story"]) then
				if arg_344_1.var_.characterEffect10104ui_story and not isNil(arg_344_1.actors_["10104ui_story"]) then
					arg_344_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_344_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_344_1.time_ - 0) / var_347_0)
				end
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 and not isNil(arg_344_1.actors_["10104ui_story"]) and arg_344_1.var_.characterEffect10104ui_story then
				arg_344_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_344_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_347_1 = 0
			local var_347_2 = 0.5

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_344_1.callingController_:SetSelectedState("calling")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_3 = arg_344_1:GetWordFromCfg(322112083)
				local var_347_4 = arg_344_1:FormatText(var_347_3.content)

				arg_344_1.text_.text = var_347_4

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_6 = 20 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_4) / 20)

				if (20 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_4) / 20)) > 0 and var_347_2 < var_347_6 then
					arg_344_1.talkMaxDuration = var_347_6

					if var_347_6 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_6 + var_347_1
					end
				end

				arg_344_1.text_.text = var_347_4
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112083", "story_v_out_322112.awb") ~= 0 then
					local var_347_7 = manager.audio:GetVoiceLength("story_v_out_322112", "322112083", "story_v_out_322112.awb") / 1000

					if var_347_7 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_1
					end

					if var_347_3.prefab_name ~= "" and arg_344_1.actors_[var_347_3.prefab_name] ~= nil then
						local var_347_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_3.prefab_name].transform, "story_v_out_322112", "322112083", "story_v_out_322112.awb")

						arg_344_1:RecordAudio("322112083", var_347_8)
						arg_344_1:RecordAudio("322112083", var_347_8)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_322112", "322112083", "story_v_out_322112.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_322112", "322112083", "story_v_out_322112.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_9 = math.max(var_347_2, arg_344_1.talkMaxDuration)

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_9 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_1) / var_347_9

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_1 + var_347_9 and arg_344_1.time_ < var_347_1 + var_347_9 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play322112084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 322112084
		arg_348_1.duration_ = 8.9

		local var_348_0 = {
			zh = 8,
			ja = 8.9
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
				arg_348_0:Play322112085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 1.175

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_348_1.callingController_:SetSelectedState("calling")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_1 = arg_348_1:GetWordFromCfg(322112084)
				local var_351_2 = arg_348_1:FormatText(var_351_1.content)

				arg_348_1.text_.text = var_351_2

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_4 = 47 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 47)

				if (47 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 47)) > 0 and var_351_0 < var_351_4 then
					arg_348_1.talkMaxDuration = var_351_4

					if var_351_4 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_4 + 0
					end
				end

				arg_348_1.text_.text = var_351_2
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112084", "story_v_out_322112.awb") ~= 0 then
					local var_351_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112084", "story_v_out_322112.awb") / 1000

					if var_351_5 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + 0
					end

					if var_351_1.prefab_name ~= "" and arg_348_1.actors_[var_351_1.prefab_name] ~= nil then
						local var_351_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_1.prefab_name].transform, "story_v_out_322112", "322112084", "story_v_out_322112.awb")

						arg_348_1:RecordAudio("322112084", var_351_6)
						arg_348_1:RecordAudio("322112084", var_351_6)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_322112", "322112084", "story_v_out_322112.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_322112", "322112084", "story_v_out_322112.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_7 and arg_348_1.time_ < 0 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play322112085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 322112085
		arg_352_1.duration_ = 10.5

		local var_352_0 = {
			zh = 8.566,
			ja = 10.5
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
				arg_352_0:Play322112086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0.925

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_352_1.callingController_:SetSelectedState("calling")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_1 = arg_352_1:GetWordFromCfg(322112085)
				local var_355_2 = arg_352_1:FormatText(var_355_1.content)

				arg_352_1.text_.text = var_355_2

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_4 = 37 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_2) / 37)

				if (37 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_2) / 37)) > 0 and var_355_0 < var_355_4 then
					arg_352_1.talkMaxDuration = var_355_4

					if var_355_4 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_4 + 0
					end
				end

				arg_352_1.text_.text = var_355_2
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112085", "story_v_out_322112.awb") ~= 0 then
					local var_355_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112085", "story_v_out_322112.awb") / 1000

					if var_355_5 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + 0
					end

					if var_355_1.prefab_name ~= "" and arg_352_1.actors_[var_355_1.prefab_name] ~= nil then
						local var_355_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_1.prefab_name].transform, "story_v_out_322112", "322112085", "story_v_out_322112.awb")

						arg_352_1:RecordAudio("322112085", var_355_6)
						arg_352_1:RecordAudio("322112085", var_355_6)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_322112", "322112085", "story_v_out_322112.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_322112", "322112085", "story_v_out_322112.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_7 = math.max(var_355_0, arg_352_1.talkMaxDuration)

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_7 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - 0) / var_355_7

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= 0 + var_355_7 and arg_352_1.time_ < 0 + var_355_7 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play322112086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 322112086
		arg_356_1.duration_ = 2

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play322112087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPos10104ui_story = arg_356_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_359_0 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 then
				arg_356_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_356_1.time_ - 0) / var_359_0)
				arg_356_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["10104ui_story"].transform.position).z)
				arg_356_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["10104ui_story"].transform.localEulerAngles = arg_356_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 then
				arg_356_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_356_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["10104ui_story"].transform.position).z)
				arg_356_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["10104ui_story"].transform.localEulerAngles = arg_356_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_359_1 = arg_356_1.actors_["10104ui_story"]

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(var_359_1) and arg_356_1.var_.characterEffect10104ui_story == nil then
				arg_356_1.var_.characterEffect10104ui_story = var_359_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.200000002980232

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_2 and not isNil(var_359_1) then
				if arg_356_1.var_.characterEffect10104ui_story and not isNil(var_359_1) then
					arg_356_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= 0 + var_359_2 and arg_356_1.time_ < 0 + var_359_2 + arg_359_0 and not isNil(var_359_1) and arg_356_1.var_.characterEffect10104ui_story then
				arg_356_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_359_4 = 0
			local var_359_5 = 0.1

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_4 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_6 = arg_356_1:GetWordFromCfg(322112086)
				local var_359_7 = arg_356_1:FormatText(var_359_6.content)

				arg_356_1.text_.text = var_359_7

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_9 = 4 <= 0 and var_359_5 or var_359_5 * (utf8.len(var_359_7) / 4)

				if (4 <= 0 and var_359_5 or var_359_5 * (utf8.len(var_359_7) / 4)) > 0 and var_359_5 < var_359_9 then
					arg_356_1.talkMaxDuration = var_359_9

					if var_359_9 + var_359_4 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_9 + var_359_4
					end
				end

				arg_356_1.text_.text = var_359_7
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112086", "story_v_out_322112.awb") ~= 0 then
					local var_359_10 = manager.audio:GetVoiceLength("story_v_out_322112", "322112086", "story_v_out_322112.awb") / 1000

					if var_359_10 + var_359_4 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_10 + var_359_4
					end

					if var_359_6.prefab_name ~= "" and arg_356_1.actors_[var_359_6.prefab_name] ~= nil then
						local var_359_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_6.prefab_name].transform, "story_v_out_322112", "322112086", "story_v_out_322112.awb")

						arg_356_1:RecordAudio("322112086", var_359_11)
						arg_356_1:RecordAudio("322112086", var_359_11)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_322112", "322112086", "story_v_out_322112.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_322112", "322112086", "story_v_out_322112.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_12 = math.max(var_359_5, arg_356_1.talkMaxDuration)

			if var_359_4 <= arg_356_1.time_ and arg_356_1.time_ < var_359_4 + var_359_12 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_4) / var_359_12

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_4 + var_359_12 and arg_356_1.time_ < var_359_4 + var_359_12 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play322112087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 322112087
		arg_360_1.duration_ = 2.17

		local var_360_0 = {
			zh = 2.166,
			ja = 1.9
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
				arg_360_0:Play322112088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(arg_360_1.actors_["10104ui_story"]) and arg_360_1.var_.characterEffect10104ui_story == nil then
				arg_360_1.var_.characterEffect10104ui_story = arg_360_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_0 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 and not isNil(arg_360_1.actors_["10104ui_story"]) then
				if arg_360_1.var_.characterEffect10104ui_story and not isNil(arg_360_1.actors_["10104ui_story"]) then
					arg_360_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_360_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_360_1.time_ - 0) / var_363_0)
				end
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 and not isNil(arg_360_1.actors_["10104ui_story"]) and arg_360_1.var_.characterEffect10104ui_story then
				arg_360_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_360_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_363_1 = 0
			local var_363_2 = 0.25

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_360_1.callingController_:SetSelectedState("calling")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_3 = arg_360_1:GetWordFromCfg(322112087)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_6 = 10 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_4) / 10)

				if (10 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_4) / 10)) > 0 and var_363_2 < var_363_6 then
					arg_360_1.talkMaxDuration = var_363_6

					if var_363_6 + var_363_1 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_6 + var_363_1
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112087", "story_v_out_322112.awb") ~= 0 then
					local var_363_7 = manager.audio:GetVoiceLength("story_v_out_322112", "322112087", "story_v_out_322112.awb") / 1000

					if var_363_7 + var_363_1 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_1
					end

					if var_363_3.prefab_name ~= "" and arg_360_1.actors_[var_363_3.prefab_name] ~= nil then
						local var_363_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_3.prefab_name].transform, "story_v_out_322112", "322112087", "story_v_out_322112.awb")

						arg_360_1:RecordAudio("322112087", var_363_8)
						arg_360_1:RecordAudio("322112087", var_363_8)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_322112", "322112087", "story_v_out_322112.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_322112", "322112087", "story_v_out_322112.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_9 = math.max(var_363_2, arg_360_1.talkMaxDuration)

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_9 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_1) / var_363_9

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_1 + var_363_9 and arg_360_1.time_ < var_363_1 + var_363_9 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play322112088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 322112088
		arg_364_1.duration_ = 4.87

		local var_364_0 = {
			zh = 4.566,
			ja = 4.866
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
				arg_364_0:Play322112089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.6

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_364_1.callingController_:SetSelectedState("calling")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_1 = arg_364_1:GetWordFromCfg(322112088)
				local var_367_2 = arg_364_1:FormatText(var_367_1.content)

				arg_364_1.text_.text = var_367_2

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_4 = 24 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 24)

				if (24 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 24)) > 0 and var_367_0 < var_367_4 then
					arg_364_1.talkMaxDuration = var_367_4

					if var_367_4 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_4 + 0
					end
				end

				arg_364_1.text_.text = var_367_2
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112088", "story_v_out_322112.awb") ~= 0 then
					local var_367_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112088", "story_v_out_322112.awb") / 1000

					if var_367_5 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + 0
					end

					if var_367_1.prefab_name ~= "" and arg_364_1.actors_[var_367_1.prefab_name] ~= nil then
						local var_367_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_1.prefab_name].transform, "story_v_out_322112", "322112088", "story_v_out_322112.awb")

						arg_364_1:RecordAudio("322112088", var_367_6)
						arg_364_1:RecordAudio("322112088", var_367_6)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_322112", "322112088", "story_v_out_322112.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_322112", "322112088", "story_v_out_322112.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_7 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_7 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_7

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_7 and arg_364_1.time_ < 0 + var_367_7 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play322112089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 322112089
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play322112090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos10104ui_story = arg_368_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_371_0 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 then
				arg_368_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_368_1.time_ - 0) / var_371_0)
				arg_368_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["10104ui_story"].transform.position).z)
				arg_368_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["10104ui_story"].transform.localEulerAngles = arg_368_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 then
				arg_368_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_368_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["10104ui_story"].transform.position).z)
				arg_368_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["10104ui_story"].transform.localEulerAngles = arg_368_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_371_1 = 0
			local var_371_2 = 1.325

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_3 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(322112089).content)

				arg_368_1.text_.text = var_371_3

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 53 <= 0 and var_371_2 or var_371_2 * (utf8.len(var_371_3) / 53)

				if (53 <= 0 and var_371_2 or var_371_2 * (utf8.len(var_371_3) / 53)) > 0 and var_371_2 < var_371_5 then
					arg_368_1.talkMaxDuration = var_371_5

					if var_371_5 + var_371_1 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + var_371_1
					end
				end

				arg_368_1.text_.text = var_371_3
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_6 = math.max(var_371_2, arg_368_1.talkMaxDuration)

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_6 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_1) / var_371_6

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_1 + var_371_6 and arg_368_1.time_ < var_371_1 + var_371_6 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play322112090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 322112090
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play322112091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 1.9

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_1 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(322112090).content)

				arg_372_1.text_.text = var_375_1

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_3 = 76 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_1) / 76)

				if (76 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_1) / 76)) > 0 and var_375_0 < var_375_3 then
					arg_372_1.talkMaxDuration = var_375_3

					if var_375_3 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_3 + 0
					end
				end

				arg_372_1.text_.text = var_375_1
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_4 = math.max(var_375_0, arg_372_1.talkMaxDuration)

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_4 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - 0) / var_375_4

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= 0 + var_375_4 and arg_372_1.time_ < 0 + var_375_4 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play322112091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 322112091
		arg_376_1.duration_ = 6.03

		local var_376_0 = {
			zh = 6.033,
			ja = 4.933
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play322112092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos10104ui_story = arg_376_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_379_0 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 then
				arg_376_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_376_1.time_ - 0) / var_379_0)
				arg_376_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["10104ui_story"].transform.position).z)
				arg_376_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["10104ui_story"].transform.localEulerAngles = arg_376_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 then
				arg_376_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_376_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["10104ui_story"].transform.position).z)
				arg_376_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["10104ui_story"].transform.localEulerAngles = arg_376_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_379_1 = arg_376_1.actors_["10104ui_story"]

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(var_379_1) and arg_376_1.var_.characterEffect10104ui_story == nil then
				arg_376_1.var_.characterEffect10104ui_story = var_379_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_2 and not isNil(var_379_1) then
				if arg_376_1.var_.characterEffect10104ui_story and not isNil(var_379_1) then
					arg_376_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= 0 + var_379_2 and arg_376_1.time_ < 0 + var_379_2 + arg_379_0 and not isNil(var_379_1) and arg_376_1.var_.characterEffect10104ui_story then
				arg_376_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action4_1")
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_379_4 = 0
			local var_379_5 = 0.575

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_4 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_6 = arg_376_1:GetWordFromCfg(322112091)
				local var_379_7 = arg_376_1:FormatText(var_379_6.content)

				arg_376_1.text_.text = var_379_7

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_9 = 23 <= 0 and var_379_5 or var_379_5 * (utf8.len(var_379_7) / 23)

				if (23 <= 0 and var_379_5 or var_379_5 * (utf8.len(var_379_7) / 23)) > 0 and var_379_5 < var_379_9 then
					arg_376_1.talkMaxDuration = var_379_9

					if var_379_9 + var_379_4 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_9 + var_379_4
					end
				end

				arg_376_1.text_.text = var_379_7
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112091", "story_v_out_322112.awb") ~= 0 then
					local var_379_10 = manager.audio:GetVoiceLength("story_v_out_322112", "322112091", "story_v_out_322112.awb") / 1000

					if var_379_10 + var_379_4 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_10 + var_379_4
					end

					if var_379_6.prefab_name ~= "" and arg_376_1.actors_[var_379_6.prefab_name] ~= nil then
						local var_379_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_6.prefab_name].transform, "story_v_out_322112", "322112091", "story_v_out_322112.awb")

						arg_376_1:RecordAudio("322112091", var_379_11)
						arg_376_1:RecordAudio("322112091", var_379_11)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_322112", "322112091", "story_v_out_322112.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_322112", "322112091", "story_v_out_322112.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_12 = math.max(var_379_5, arg_376_1.talkMaxDuration)

			if var_379_4 <= arg_376_1.time_ and arg_376_1.time_ < var_379_4 + var_379_12 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_4) / var_379_12

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_4 + var_379_12 and arg_376_1.time_ < var_379_4 + var_379_12 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play322112092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 322112092
		arg_380_1.duration_ = 2.07

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play322112093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["10104ui_story"]) and arg_380_1.var_.characterEffect10104ui_story == nil then
				arg_380_1.var_.characterEffect10104ui_story = arg_380_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_0 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["10104ui_story"]) then
				if arg_380_1.var_.characterEffect10104ui_story and not isNil(arg_380_1.actors_["10104ui_story"]) then
					arg_380_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_380_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_380_1.time_ - 0) / var_383_0)
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["10104ui_story"]) and arg_380_1.var_.characterEffect10104ui_story then
				arg_380_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_380_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_383_1 = 0
			local var_383_2 = 0.225

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_380_1.callingController_:SetSelectedState("calling")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_3 = arg_380_1:GetWordFromCfg(322112092)
				local var_383_4 = arg_380_1:FormatText(var_383_3.content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_6 = 9 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_4) / 9)

				if (9 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_4) / 9)) > 0 and var_383_2 < var_383_6 then
					arg_380_1.talkMaxDuration = var_383_6

					if var_383_6 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_6 + var_383_1
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112092", "story_v_out_322112.awb") ~= 0 then
					local var_383_7 = manager.audio:GetVoiceLength("story_v_out_322112", "322112092", "story_v_out_322112.awb") / 1000

					if var_383_7 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_7 + var_383_1
					end

					if var_383_3.prefab_name ~= "" and arg_380_1.actors_[var_383_3.prefab_name] ~= nil then
						local var_383_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_3.prefab_name].transform, "story_v_out_322112", "322112092", "story_v_out_322112.awb")

						arg_380_1:RecordAudio("322112092", var_383_8)
						arg_380_1:RecordAudio("322112092", var_383_8)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_322112", "322112092", "story_v_out_322112.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_322112", "322112092", "story_v_out_322112.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_9 = math.max(var_383_2, arg_380_1.talkMaxDuration)

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_9 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_1) / var_383_9

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_1 + var_383_9 and arg_380_1.time_ < var_383_1 + var_383_9 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play322112093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 322112093
		arg_384_1.duration_ = 2.33

		local var_384_0 = {
			zh = 1.533,
			ja = 2.333
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play322112094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0.15

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[1365].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_1 = arg_384_1:GetWordFromCfg(322112093)
				local var_387_2 = arg_384_1:FormatText(var_387_1.content)

				arg_384_1.text_.text = var_387_2

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_4 = 6 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 6)

				if (6 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 6)) > 0 and var_387_0 < var_387_4 then
					arg_384_1.talkMaxDuration = var_387_4

					if var_387_4 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_4 + 0
					end
				end

				arg_384_1.text_.text = var_387_2
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112093", "story_v_out_322112.awb") ~= 0 then
					local var_387_5 = manager.audio:GetVoiceLength("story_v_out_322112", "322112093", "story_v_out_322112.awb") / 1000

					if var_387_5 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + 0
					end

					if var_387_1.prefab_name ~= "" and arg_384_1.actors_[var_387_1.prefab_name] ~= nil then
						local var_387_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_1.prefab_name].transform, "story_v_out_322112", "322112093", "story_v_out_322112.awb")

						arg_384_1:RecordAudio("322112093", var_387_6)
						arg_384_1:RecordAudio("322112093", var_387_6)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_322112", "322112093", "story_v_out_322112.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_322112", "322112093", "story_v_out_322112.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_7 = math.max(var_387_0, arg_384_1.talkMaxDuration)

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_7 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - 0) / var_387_7

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= 0 + var_387_7 and arg_384_1.time_ < 0 + var_387_7 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play322112094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 322112094
		arg_388_1.duration_ = 4.03

		local var_388_0 = {
			zh = 2.4,
			ja = 4.033
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play322112095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos10104ui_story = arg_388_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_391_0 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 then
				arg_388_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_388_1.time_ - 0) / var_391_0)
				arg_388_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["10104ui_story"].transform.position).z)
				arg_388_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["10104ui_story"].transform.localEulerAngles = arg_388_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 then
				arg_388_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_388_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["10104ui_story"].transform.position).z)
				arg_388_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["10104ui_story"].transform.localEulerAngles = arg_388_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_391_1 = arg_388_1.actors_["10104ui_story"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_1) and arg_388_1.var_.characterEffect10104ui_story == nil then
				arg_388_1.var_.characterEffect10104ui_story = var_391_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_2 and not isNil(var_391_1) then
				if arg_388_1.var_.characterEffect10104ui_story and not isNil(var_391_1) then
					arg_388_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= 0 + var_391_2 and arg_388_1.time_ < 0 + var_391_2 + arg_391_0 and not isNil(var_391_1) and arg_388_1.var_.characterEffect10104ui_story then
				arg_388_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action4_2")
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_391_4 = 0
			local var_391_5 = 0.25

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_6 = arg_388_1:GetWordFromCfg(322112094)
				local var_391_7 = arg_388_1:FormatText(var_391_6.content)

				arg_388_1.text_.text = var_391_7

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_9 = 10 <= 0 and var_391_5 or var_391_5 * (utf8.len(var_391_7) / 10)

				if (10 <= 0 and var_391_5 or var_391_5 * (utf8.len(var_391_7) / 10)) > 0 and var_391_5 < var_391_9 then
					arg_388_1.talkMaxDuration = var_391_9

					if var_391_9 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_9 + var_391_4
					end
				end

				arg_388_1.text_.text = var_391_7
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112094", "story_v_out_322112.awb") ~= 0 then
					local var_391_10 = manager.audio:GetVoiceLength("story_v_out_322112", "322112094", "story_v_out_322112.awb") / 1000

					if var_391_10 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_10 + var_391_4
					end

					if var_391_6.prefab_name ~= "" and arg_388_1.actors_[var_391_6.prefab_name] ~= nil then
						local var_391_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_6.prefab_name].transform, "story_v_out_322112", "322112094", "story_v_out_322112.awb")

						arg_388_1:RecordAudio("322112094", var_391_11)
						arg_388_1:RecordAudio("322112094", var_391_11)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_322112", "322112094", "story_v_out_322112.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_322112", "322112094", "story_v_out_322112.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_12 = math.max(var_391_5, arg_388_1.talkMaxDuration)

			if var_391_4 <= arg_388_1.time_ and arg_388_1.time_ < var_391_4 + var_391_12 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_4) / var_391_12

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_4 + var_391_12 and arg_388_1.time_ < var_391_4 + var_391_12 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play322112095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 322112095
		arg_392_1.duration_ = 1.77

		local var_392_0 = {
			zh = 1.266,
			ja = 1.766
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play322112096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["10104ui_story"]) and arg_392_1.var_.characterEffect10104ui_story == nil then
				arg_392_1.var_.characterEffect10104ui_story = arg_392_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_0 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["10104ui_story"]) then
				if arg_392_1.var_.characterEffect10104ui_story and not isNil(arg_392_1.actors_["10104ui_story"]) then
					arg_392_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_392_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_392_1.time_ - 0) / var_395_0)
				end
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["10104ui_story"]) and arg_392_1.var_.characterEffect10104ui_story then
				arg_392_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_392_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_395_1 = 0
			local var_395_2 = 0.1

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[1365].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_3 = arg_392_1:GetWordFromCfg(322112095)
				local var_395_4 = arg_392_1:FormatText(var_395_3.content)

				arg_392_1.text_.text = var_395_4

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_6 = 4 <= 0 and var_395_2 or var_395_2 * (utf8.len(var_395_4) / 4)

				if (4 <= 0 and var_395_2 or var_395_2 * (utf8.len(var_395_4) / 4)) > 0 and var_395_2 < var_395_6 then
					arg_392_1.talkMaxDuration = var_395_6

					if var_395_6 + var_395_1 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_6 + var_395_1
					end
				end

				arg_392_1.text_.text = var_395_4
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112095", "story_v_out_322112.awb") ~= 0 then
					local var_395_7 = manager.audio:GetVoiceLength("story_v_out_322112", "322112095", "story_v_out_322112.awb") / 1000

					if var_395_7 + var_395_1 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_1
					end

					if var_395_3.prefab_name ~= "" and arg_392_1.actors_[var_395_3.prefab_name] ~= nil then
						local var_395_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_3.prefab_name].transform, "story_v_out_322112", "322112095", "story_v_out_322112.awb")

						arg_392_1:RecordAudio("322112095", var_395_8)
						arg_392_1:RecordAudio("322112095", var_395_8)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_322112", "322112095", "story_v_out_322112.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_322112", "322112095", "story_v_out_322112.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_9 = math.max(var_395_2, arg_392_1.talkMaxDuration)

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_9 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_1) / var_395_9

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_1 + var_395_9 and arg_392_1.time_ < var_395_1 + var_395_9 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play322112096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 322112096
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play322112097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.var_.moveOldPos10104ui_story = arg_396_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_399_0 = 0.001

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 then
				arg_396_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_396_1.time_ - 0) / var_399_0)
				arg_396_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_396_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["10104ui_story"].transform.position).z)
				arg_396_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_396_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_396_1.actors_["10104ui_story"].transform.localEulerAngles = arg_396_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 then
				arg_396_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_396_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_396_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["10104ui_story"].transform.position).z)
				arg_396_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_396_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_396_1.actors_["10104ui_story"].transform.localEulerAngles = arg_396_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_399_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_396_1.bgmTxt_.text ~= var_399_3 and arg_396_1.bgmTxt_.text ~= "" then
						if arg_396_1.bgmTxt2_.text ~= "" then
							arg_396_1.bgmTxt_.text = arg_396_1.bgmTxt2_.text
						end

						arg_396_1.bgmTxt2_.text = var_399_3

						arg_396_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_396_1.bgmTxt_.text = var_399_3
						arg_396_1.bgmTxt2_.text = var_399_3
					end

					if arg_396_1.bgmTimer then
						arg_396_1.bgmTimer:Stop()

						arg_396_1.bgmTimer = nil
					end

					if arg_396_1.settingData.show_music_name == 1 then
						arg_396_1.musicController:SetSelectedState("show")
						arg_396_1.musicAnimator_:Play("open", 0, 0)

						if arg_396_1.settingData.music_time ~= 0 then
							arg_396_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_396_1.settingData.music_time), function()
								if arg_396_1 == nil or isNil(arg_396_1.bgmTxt_) then
									return
								end

								arg_396_1.musicController:SetSelectedState("hide")
								arg_396_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_399_4 = 0
			local var_399_5 = 1.675

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_4 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_6 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(322112096).content)

				arg_396_1.text_.text = var_399_6

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_8 = 67 <= 0 and var_399_5 or var_399_5 * (utf8.len(var_399_6) / 67)

				if (67 <= 0 and var_399_5 or var_399_5 * (utf8.len(var_399_6) / 67)) > 0 and var_399_5 < var_399_8 then
					arg_396_1.talkMaxDuration = var_399_8

					if var_399_8 + var_399_4 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_8 + var_399_4
					end
				end

				arg_396_1.text_.text = var_399_6
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_9 = math.max(var_399_5, arg_396_1.talkMaxDuration)

			if var_399_4 <= arg_396_1.time_ and arg_396_1.time_ < var_399_4 + var_399_9 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_4) / var_399_9

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_4 + var_399_9 and arg_396_1.time_ < var_399_4 + var_399_9 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play322112097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 322112097
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play322112098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 1.05

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(322112097).content)

				arg_401_1.text_.text = var_404_1

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_3 = 42 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 42)

				if (42 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 42)) > 0 and var_404_0 < var_404_3 then
					arg_401_1.talkMaxDuration = var_404_3

					if var_404_3 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_3 + 0
					end
				end

				arg_401_1.text_.text = var_404_1
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_4 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_4 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_4

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_4 and arg_401_1.time_ < 0 + var_404_4 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play322112098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 322112098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play322112099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.975

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(322112098).content)

				arg_405_1.text_.text = var_408_1

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_3 = 39 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 39)

				if (39 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 39)) > 0 and var_408_0 < var_408_3 then
					arg_405_1.talkMaxDuration = var_408_3

					if var_408_3 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_3 + 0
					end
				end

				arg_405_1.text_.text = var_408_1
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_4 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_4

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play322112099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 322112099
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play322112100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				local var_412_0 = arg_409_1.var_.effect1022

				if not arg_409_1.var_.effect1022 then
					var_412_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dataflow"), manager.ui.mainCamera.transform)
					var_412_0.name = "1022"
					arg_409_1.var_.effect1022 = var_412_0
				else
					var_412_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_412_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_412_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.1 < arg_409_1.time_ and arg_409_1.time_ <= 0.1 + arg_412_0 then
				arg_409_1:AudioAction("play", "effect", "se_story_129", "se_story_129_information_magic", "")
			end

			local var_412_3 = 0
			local var_412_4 = 1.825

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_3 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_5 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(322112099).content)

				arg_409_1.text_.text = var_412_5

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_7 = 73 <= 0 and var_412_4 or var_412_4 * (utf8.len(var_412_5) / 73)

				if (73 <= 0 and var_412_4 or var_412_4 * (utf8.len(var_412_5) / 73)) > 0 and var_412_4 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_3 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_3
					end
				end

				arg_409_1.text_.text = var_412_5
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_8 = math.max(var_412_4, arg_409_1.talkMaxDuration)

			if var_412_3 <= arg_409_1.time_ and arg_409_1.time_ < var_412_3 + var_412_8 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_3) / var_412_8

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_3 + var_412_8 and arg_409_1.time_ < var_412_3 + var_412_8 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play322112100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 322112100
		arg_413_1.duration_ = 4

		local var_413_0 = {
			zh = 4,
			ja = 2.9
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play322112101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos10104ui_story = arg_413_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_416_0 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				arg_413_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_413_1.time_ - 0) / var_416_0)
				arg_413_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["10104ui_story"].transform.position).z)
				arg_413_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["10104ui_story"].transform.localEulerAngles = arg_413_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				arg_413_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_413_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["10104ui_story"].transform.position).z)
				arg_413_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["10104ui_story"].transform.localEulerAngles = arg_413_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_416_1 = arg_413_1.actors_["10104ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect10104ui_story == nil then
				arg_413_1.var_.characterEffect10104ui_story = var_416_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_2 and not isNil(var_416_1) then
				if arg_413_1.var_.characterEffect10104ui_story and not isNil(var_416_1) then
					arg_413_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_2 and arg_413_1.time_ < 0 + var_416_2 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect10104ui_story then
				arg_413_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_416_4 = 0
			local var_416_5 = 0.425

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_4 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_6 = arg_413_1:GetWordFromCfg(322112100)
				local var_416_7 = arg_413_1:FormatText(var_416_6.content)

				arg_413_1.text_.text = var_416_7

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_9 = 17 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 17)

				if (17 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 17)) > 0 and var_416_5 < var_416_9 then
					arg_413_1.talkMaxDuration = var_416_9

					if var_416_9 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_9 + var_416_4
					end
				end

				arg_413_1.text_.text = var_416_7
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112100", "story_v_out_322112.awb") ~= 0 then
					local var_416_10 = manager.audio:GetVoiceLength("story_v_out_322112", "322112100", "story_v_out_322112.awb") / 1000

					if var_416_10 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_10 + var_416_4
					end

					if var_416_6.prefab_name ~= "" and arg_413_1.actors_[var_416_6.prefab_name] ~= nil then
						local var_416_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_6.prefab_name].transform, "story_v_out_322112", "322112100", "story_v_out_322112.awb")

						arg_413_1:RecordAudio("322112100", var_416_11)
						arg_413_1:RecordAudio("322112100", var_416_11)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_322112", "322112100", "story_v_out_322112.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_322112", "322112100", "story_v_out_322112.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_12 = math.max(var_416_5, arg_413_1.talkMaxDuration)

			if var_416_4 <= arg_413_1.time_ and arg_413_1.time_ < var_416_4 + var_416_12 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_4) / var_416_12

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_4 + var_416_12 and arg_413_1.time_ < var_416_4 + var_416_12 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play322112101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 322112101
		arg_417_1.duration_ = 2.23

		local var_417_0 = {
			zh = 1.866,
			ja = 2.233
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play322112102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["10104ui_story"]) and arg_417_1.var_.characterEffect10104ui_story == nil then
				arg_417_1.var_.characterEffect10104ui_story = arg_417_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["10104ui_story"]) then
				if arg_417_1.var_.characterEffect10104ui_story and not isNil(arg_417_1.actors_["10104ui_story"]) then
					arg_417_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_417_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_0)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["10104ui_story"]) and arg_417_1.var_.characterEffect10104ui_story then
				arg_417_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_417_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_420_1 = 0
			local var_420_2 = 0.2

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_417_1.callingController_:SetSelectedState("calling")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_3 = arg_417_1:GetWordFromCfg(322112101)
				local var_420_4 = arg_417_1:FormatText(var_420_3.content)

				arg_417_1.text_.text = var_420_4

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_6 = 8 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_4) / 8)

				if (8 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_4) / 8)) > 0 and var_420_2 < var_420_6 then
					arg_417_1.talkMaxDuration = var_420_6

					if var_420_6 + var_420_1 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_6 + var_420_1
					end
				end

				arg_417_1.text_.text = var_420_4
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112101", "story_v_out_322112.awb") ~= 0 then
					local var_420_7 = manager.audio:GetVoiceLength("story_v_out_322112", "322112101", "story_v_out_322112.awb") / 1000

					if var_420_7 + var_420_1 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_1
					end

					if var_420_3.prefab_name ~= "" and arg_417_1.actors_[var_420_3.prefab_name] ~= nil then
						local var_420_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_3.prefab_name].transform, "story_v_out_322112", "322112101", "story_v_out_322112.awb")

						arg_417_1:RecordAudio("322112101", var_420_8)
						arg_417_1:RecordAudio("322112101", var_420_8)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_322112", "322112101", "story_v_out_322112.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_322112", "322112101", "story_v_out_322112.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_9 = math.max(var_420_2, arg_417_1.talkMaxDuration)

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_9 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_1) / var_420_9

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_1 + var_420_9 and arg_417_1.time_ < var_420_1 + var_420_9 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play322112102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 322112102
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play322112103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos10104ui_story = arg_421_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_424_0 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 then
				arg_421_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_421_1.time_ - 0) / var_424_0)
				arg_421_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["10104ui_story"].transform.position).z)
				arg_421_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["10104ui_story"].transform.localEulerAngles = arg_421_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 then
				arg_421_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_421_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["10104ui_story"].transform.position).z)
				arg_421_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["10104ui_story"].transform.localEulerAngles = arg_421_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_424_1 = 0
			local var_424_2 = 1.1

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_3 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(322112102).content)

				arg_421_1.text_.text = var_424_3

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 44 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 44)

				if (44 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 44)) > 0 and var_424_2 < var_424_5 then
					arg_421_1.talkMaxDuration = var_424_5

					if var_424_5 + var_424_1 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + var_424_1
					end
				end

				arg_421_1.text_.text = var_424_3
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_6 = math.max(var_424_2, arg_421_1.talkMaxDuration)

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_6 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_1) / var_424_6

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_1 + var_424_6 and arg_421_1.time_ < var_424_1 + var_424_6 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play322112103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 322112103
		arg_425_1.duration_ = 4.03

		local var_425_0 = {
			zh = 3.533,
			ja = 4.033
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play322112104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos10104ui_story = arg_425_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_428_0 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 then
				arg_425_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_425_1.time_ - 0) / var_428_0)
				arg_425_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["10104ui_story"].transform.position).z)
				arg_425_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["10104ui_story"].transform.localEulerAngles = arg_425_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 then
				arg_425_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_425_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["10104ui_story"].transform.position).z)
				arg_425_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["10104ui_story"].transform.localEulerAngles = arg_425_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_428_1 = arg_425_1.actors_["10104ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect10104ui_story == nil then
				arg_425_1.var_.characterEffect10104ui_story = var_428_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_2 and not isNil(var_428_1) then
				if arg_425_1.var_.characterEffect10104ui_story and not isNil(var_428_1) then
					arg_425_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= 0 + var_428_2 and arg_425_1.time_ < 0 + var_428_2 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect10104ui_story then
				arg_425_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_428_4 = 0
			local var_428_5 = 0.225

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_4 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_6 = arg_425_1:GetWordFromCfg(322112103)
				local var_428_7 = arg_425_1:FormatText(var_428_6.content)

				arg_425_1.text_.text = var_428_7

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_9 = 9 <= 0 and var_428_5 or var_428_5 * (utf8.len(var_428_7) / 9)

				if (9 <= 0 and var_428_5 or var_428_5 * (utf8.len(var_428_7) / 9)) > 0 and var_428_5 < var_428_9 then
					arg_425_1.talkMaxDuration = var_428_9

					if var_428_9 + var_428_4 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_9 + var_428_4
					end
				end

				arg_425_1.text_.text = var_428_7
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112103", "story_v_out_322112.awb") ~= 0 then
					local var_428_10 = manager.audio:GetVoiceLength("story_v_out_322112", "322112103", "story_v_out_322112.awb") / 1000

					if var_428_10 + var_428_4 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_10 + var_428_4
					end

					if var_428_6.prefab_name ~= "" and arg_425_1.actors_[var_428_6.prefab_name] ~= nil then
						local var_428_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_6.prefab_name].transform, "story_v_out_322112", "322112103", "story_v_out_322112.awb")

						arg_425_1:RecordAudio("322112103", var_428_11)
						arg_425_1:RecordAudio("322112103", var_428_11)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_322112", "322112103", "story_v_out_322112.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_322112", "322112103", "story_v_out_322112.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_12 = math.max(var_428_5, arg_425_1.talkMaxDuration)

			if var_428_4 <= arg_425_1.time_ and arg_425_1.time_ < var_428_4 + var_428_12 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_4) / var_428_12

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_4 + var_428_12 and arg_425_1.time_ < var_428_4 + var_428_12 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play322112104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 322112104
		arg_429_1.duration_ = 82.47

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
			arg_429_1.auto_ = false
		end

		function arg_429_1.playNext_(arg_431_0)
			arg_429_1.onStoryFinished_()
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 1 < arg_429_1.time_ and arg_429_1.time_ <= 1 + arg_432_0 then
				SetActive(arg_429_1.dialog_, false)
				SetActive(arg_429_1.allBtn_.gameObject, false)
				arg_429_1.hideBtnsController_:SetSelectedIndex(1)
				arg_429_1:StopAllVoice()

				arg_429_1.marker = "1032211stop1"

				manager.video:Play("SofdecAsset/story/story_1032211.usm", function(arg_433_0)
					arg_429_1:Skip(arg_433_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_434_0)
					arg_429_1.state_ = arg_434_0 and "pause" or "playing"
				end, 1032211)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_432_0 = 67.8

			if 1 <= arg_429_1.time_ and arg_429_1.time_ < 1 + var_432_0 then
				-- block empty
			end

			if arg_429_1.time_ >= 1 + var_432_0 and arg_429_1.time_ < 1 + var_432_0 + arg_432_0 then
				arg_429_1.marker = ""
			end

			local var_432_1 = 0

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.mask_.enabled = true
				arg_429_1.mask_.raycastTarget = true

				arg_429_1:SetGaussion(false)
			end

			local var_432_2 = 1

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 then
				local var_432_3 = Color.New(0, 0, 0)

				var_432_3.a = Mathf.Lerp(0, 1, (arg_429_1.time_ - var_432_1) / var_432_2)
				arg_429_1.mask_.color = var_432_3
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 then
				local var_432_4 = Color.New(0, 0, 0)

				var_432_4.a = 1
				arg_429_1.mask_.color = var_432_4
			end

			local var_432_5 = 1

			if 1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_5 + arg_432_0 then
				arg_429_1.mask_.enabled = true
				arg_429_1.mask_.raycastTarget = true

				arg_429_1:SetGaussion(false)
			end

			local var_432_6 = 0.5

			if var_432_5 <= arg_429_1.time_ and arg_429_1.time_ < var_432_5 + var_432_6 then
				local var_432_7 = Color.New(0, 0, 0)

				var_432_7.a = Mathf.Lerp(1, 0, (arg_429_1.time_ - var_432_5) / var_432_6)
				arg_429_1.mask_.color = var_432_7
			end

			if arg_429_1.time_ >= var_432_5 + var_432_6 and arg_429_1.time_ < var_432_5 + var_432_6 + arg_432_0 then
				local var_432_8 = Color.New(0, 0, 0)

				arg_429_1.mask_.enabled = false
				var_432_8.a = 0
				arg_429_1.mask_.color = var_432_8
			end

			local var_432_9 = arg_429_1.actors_["10104ui_story"].transform

			if 0.965999998152256 < arg_429_1.time_ and arg_429_1.time_ <= 0.965999998152256 + arg_432_0 then
				arg_429_1.var_.moveOldPos10104ui_story = var_432_9.localPosition
			end

			local var_432_10 = 0.001

			if 0.965999998152256 <= arg_429_1.time_ and arg_429_1.time_ < 0.965999998152256 + var_432_10 then
				var_432_9.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_429_1.time_ - 0.965999998152256) / var_432_10)
				var_432_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_432_9.position).x, (manager.ui.mainCamera.transform.position - var_432_9.position).y, (manager.ui.mainCamera.transform.position - var_432_9.position).z)
				var_432_9.localEulerAngles.z = 0
				var_432_9.localEulerAngles.x = 0
				var_432_9.localEulerAngles = var_432_9.localEulerAngles
			end

			if arg_429_1.time_ >= 0.965999998152256 + var_432_10 and arg_429_1.time_ < 0.965999998152256 + var_432_10 + arg_432_0 then
				var_432_9.localPosition = Vector3.New(0, 100, 0)
				var_432_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_432_9.position).x, (manager.ui.mainCamera.transform.position - var_432_9.position).y, (manager.ui.mainCamera.transform.position - var_432_9.position).z)
				var_432_9.localEulerAngles.z = 0
				var_432_9.localEulerAngles.x = 0
				var_432_9.localEulerAngles = var_432_9.localEulerAngles
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play322112037 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 322112037
		arg_435_1.duration_ = 2

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play322112038(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos1284ui_story = arg_435_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_438_0 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 then
				arg_435_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_435_1.time_ - 0) / var_438_0)
				arg_435_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1284ui_story"].transform.position).z)
				arg_435_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1284ui_story"].transform.localEulerAngles = arg_435_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 then
				arg_435_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_435_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1284ui_story"].transform.position).z)
				arg_435_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1284ui_story"].transform.localEulerAngles = arg_435_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_438_1 = arg_435_1.actors_["1284ui_story"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_1) and arg_435_1.var_.characterEffect1284ui_story == nil then
				arg_435_1.var_.characterEffect1284ui_story = var_438_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_2 and not isNil(var_438_1) then
				if arg_435_1.var_.characterEffect1284ui_story and not isNil(var_438_1) then
					arg_435_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_2 and arg_435_1.time_ < 0 + var_438_2 + arg_438_0 and not isNil(var_438_1) and arg_435_1.var_.characterEffect1284ui_story then
				arg_435_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_438_4 = "1284ui_story"

			if arg_435_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_438_5 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_435_1.stage_.transform)

				var_438_5.name = var_438_4
				var_438_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_435_1.actors_[var_438_4] = var_438_5

				local var_438_6 = var_438_5:GetComponentInChildren(typeof(CharacterEffect))

				var_438_6.enabled = true

				local var_438_7 = GameObjectTools.GetOrAddComponent(var_438_5, typeof(DynamicBoneHelper))

				if var_438_7 then
					var_438_7:EnableDynamicBone(false)
				end

				arg_435_1:ShowWeapon(var_438_6.transform, false)

				arg_435_1.var_[var_438_4 .. "Animator"] = var_438_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_435_1.var_[var_438_4 .. "Animator"].applyRootMotion = true
				arg_435_1.var_[var_438_4 .. "LipSync"] = var_438_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_2")
			end

			local var_438_8 = "1284ui_story"

			if arg_435_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_438_9 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_435_1.stage_.transform)

				var_438_9.name = var_438_8
				var_438_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_435_1.actors_[var_438_8] = var_438_9

				local var_438_10 = var_438_9:GetComponentInChildren(typeof(CharacterEffect))

				var_438_10.enabled = true

				local var_438_11 = GameObjectTools.GetOrAddComponent(var_438_9, typeof(DynamicBoneHelper))

				if var_438_11 then
					var_438_11:EnableDynamicBone(false)
				end

				arg_435_1:ShowWeapon(var_438_10.transform, false)

				arg_435_1.var_[var_438_8 .. "Animator"] = var_438_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_435_1.var_[var_438_8 .. "Animator"].applyRootMotion = true
				arg_435_1.var_[var_438_8 .. "LipSync"] = var_438_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_438_12 = 0
			local var_438_13 = 0.1

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_12 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_14 = arg_435_1:GetWordFromCfg(322112037)
				local var_438_15 = arg_435_1:FormatText(var_438_14.content)

				arg_435_1.text_.text = var_438_15

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_17 = 4 <= 0 and var_438_13 or var_438_13 * (utf8.len(var_438_15) / 4)

				if (4 <= 0 and var_438_13 or var_438_13 * (utf8.len(var_438_15) / 4)) > 0 and var_438_13 < var_438_17 then
					arg_435_1.talkMaxDuration = var_438_17

					if var_438_17 + var_438_12 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_17 + var_438_12
					end
				end

				arg_435_1.text_.text = var_438_15
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112037", "story_v_out_322112.awb") ~= 0 then
					local var_438_18 = manager.audio:GetVoiceLength("story_v_out_322112", "322112037", "story_v_out_322112.awb") / 1000

					if var_438_18 + var_438_12 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_18 + var_438_12
					end

					if var_438_14.prefab_name ~= "" and arg_435_1.actors_[var_438_14.prefab_name] ~= nil then
						local var_438_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_14.prefab_name].transform, "story_v_out_322112", "322112037", "story_v_out_322112.awb")

						arg_435_1:RecordAudio("322112037", var_438_19)
						arg_435_1:RecordAudio("322112037", var_438_19)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_322112", "322112037", "story_v_out_322112.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_322112", "322112037", "story_v_out_322112.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_20 = math.max(var_438_13, arg_435_1.talkMaxDuration)

			if var_438_12 <= arg_435_1.time_ and arg_435_1.time_ < var_438_12 + var_438_20 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_12) / var_438_20

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_12 + var_438_20 and arg_435_1.time_ < var_438_12 + var_438_20 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play322112038 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 322112038
		arg_439_1.duration_ = 3.4

		local var_439_0 = {
			zh = 3.4,
			ja = 3.133
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
				arg_439_0:Play322112039(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos1284ui_story = arg_439_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_442_0 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 then
				arg_439_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_439_1.time_ - 0) / var_442_0)
				arg_439_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1284ui_story"].transform.position).z)
				arg_439_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["1284ui_story"].transform.localEulerAngles = arg_439_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 then
				arg_439_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_439_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1284ui_story"].transform.position).z)
				arg_439_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["1284ui_story"].transform.localEulerAngles = arg_439_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_442_1 = arg_439_1.actors_["1284ui_story"]

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(var_442_1) and arg_439_1.var_.characterEffect1284ui_story == nil then
				arg_439_1.var_.characterEffect1284ui_story = var_442_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_2 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_2 and not isNil(var_442_1) then
				if arg_439_1.var_.characterEffect1284ui_story and not isNil(var_442_1) then
					arg_439_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= 0 + var_442_2 and arg_439_1.time_ < 0 + var_442_2 + arg_442_0 and not isNil(var_442_1) and arg_439_1.var_.characterEffect1284ui_story then
				arg_439_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_442_4 = 0
			local var_442_5 = 0.3

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_4 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_6 = arg_439_1:GetWordFromCfg(322112038)
				local var_442_7 = arg_439_1:FormatText(var_442_6.content)

				arg_439_1.text_.text = var_442_7

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_9 = 12 <= 0 and var_442_5 or var_442_5 * (utf8.len(var_442_7) / 12)

				if (12 <= 0 and var_442_5 or var_442_5 * (utf8.len(var_442_7) / 12)) > 0 and var_442_5 < var_442_9 then
					arg_439_1.talkMaxDuration = var_442_9

					if var_442_9 + var_442_4 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_9 + var_442_4
					end
				end

				arg_439_1.text_.text = var_442_7
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322112", "322112038", "story_v_out_322112.awb") ~= 0 then
					local var_442_10 = manager.audio:GetVoiceLength("story_v_out_322112", "322112038", "story_v_out_322112.awb") / 1000

					if var_442_10 + var_442_4 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_10 + var_442_4
					end

					if var_442_6.prefab_name ~= "" and arg_439_1.actors_[var_442_6.prefab_name] ~= nil then
						local var_442_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_6.prefab_name].transform, "story_v_out_322112", "322112038", "story_v_out_322112.awb")

						arg_439_1:RecordAudio("322112038", var_442_11)
						arg_439_1:RecordAudio("322112038", var_442_11)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_322112", "322112038", "story_v_out_322112.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_322112", "322112038", "story_v_out_322112.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_12 = math.max(var_442_5, arg_439_1.talkMaxDuration)

			if var_442_4 <= arg_439_1.time_ and arg_439_1.time_ < var_442_4 + var_442_12 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_4) / var_442_12

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_4 + var_442_12 and arg_439_1.time_ < var_442_4 + var_442_12 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/MS2206",
		"TextureConfig/Background/ST2102a",
		"TextureConfig/Background/L14f",
		"SofdecAsset/story/story_1032211.usm"
	},
	voices = {
		"story_v_out_322112.awb"
	},
	skipMarkers = {
		322112104
	}
}
