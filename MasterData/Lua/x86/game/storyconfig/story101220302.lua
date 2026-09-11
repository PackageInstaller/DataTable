return {
	Play122032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122032001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play122032002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.XH0501 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0501")
				var_4_0.name = "XH0501"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.XH0501 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.XH0501

				arg_1_1.bgs_.XH0501.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "XH0501" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

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

			local var_4_8 = arg_1_1.bgs_.XH0501.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0501 = var_4_8.localPosition
			end

			local var_4_9 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_9 then
				var_4_8.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0501, Vector3.New(0, 1, 9.5), (arg_1_1.time_ - 0) / var_4_9)
			end

			if arg_1_1.time_ >= 0 + var_4_9 and arg_1_1.time_ < 0 + var_4_9 + arg_4_0 then
				var_4_8.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_4_10 = arg_1_1.bgs_.XH0501.transform

			if 0.0166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.0166666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0501 = var_4_10.localPosition
			end

			local var_4_11 = 1.98333333333333

			if 0.0166666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 0.0166666666666667 + var_4_11 then
				var_4_10.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0501, Vector3.New(0, 1, 10), (arg_1_1.time_ - 0.0166666666666667) / var_4_11)
			end

			if arg_1_1.time_ >= 0.0166666666666667 + var_4_11 and arg_1_1.time_ < 0.0166666666666667 + var_4_11 + arg_4_0 then
				var_4_10.localPosition = Vector3.New(0, 1, 10)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_0_battle_tianlu", "bgm_activity_2_0_battle_tianlu", "bgm_activity_2_0_battle_tianlu.awb")

				local var_4_17 = manager.audio:GetAudioName("bgm_activity_2_0_battle_tianlu", "bgm_activity_2_0_battle_tianlu")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_17 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_17

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_17
						arg_1_1.bgmTxt2_.text = var_4_17
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

			local var_4_18 = 2
			local var_4_19 = 0.85

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(122032001).content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 34 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 34)

				if (34 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 34)) > 0 and var_4_19 < var_4_23 then
					arg_1_1.talkMaxDuration = var_4_23
					var_4_18 = var_4_18 + 0.3

					if var_4_23 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_21
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_18 + 0.3
			local var_4_25 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0501",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0501",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.98333333333333,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play122032002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 122032002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play122032003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.525

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(122032002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 61 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 61)

				if (61 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 61)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play122032003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 122032003
		arg_13_1.duration_ = 9.17

		local var_13_0 = {
			ja = 9.166,
			ko = 2.033,
			zh = 2.033
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
				arg_13_0:Play122032004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.325

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(122032003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 13 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 13)

				if (13 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 13)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032003", "story_v_out_122032.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_122032", "122032003", "story_v_out_122032.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_122032", "122032003", "story_v_out_122032.awb")

						arg_13_1:RecordAudio("122032003", var_16_6)
						arg_13_1:RecordAudio("122032003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_122032", "122032003", "story_v_out_122032.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_122032", "122032003", "story_v_out_122032.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play122032004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 122032004
		arg_17_1.duration_ = 7.8

		local var_17_0 = {
			ja = 7.8,
			ko = 4.1,
			zh = 4.1
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
				arg_17_0:Play122032005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.5

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(122032004)
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

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032004", "story_v_out_122032.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_122032", "122032004", "story_v_out_122032.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_122032", "122032004", "story_v_out_122032.awb")

						arg_17_1:RecordAudio("122032004", var_20_6)
						arg_17_1:RecordAudio("122032004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_122032", "122032004", "story_v_out_122032.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_122032", "122032004", "story_v_out_122032.awb")
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
	Play122032005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 122032005
		arg_21_1.duration_ = 4.4

		local var_21_0 = {
			ja = 4.4,
			ko = 3.266,
			zh = 3.266
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
				arg_21_0:Play122032006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.4

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(122032005)
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

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032005", "story_v_out_122032.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_122032", "122032005", "story_v_out_122032.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_122032", "122032005", "story_v_out_122032.awb")

						arg_21_1:RecordAudio("122032005", var_24_6)
						arg_21_1:RecordAudio("122032005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_122032", "122032005", "story_v_out_122032.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_122032", "122032005", "story_v_out_122032.awb")
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
	Play122032006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 122032006
		arg_25_1.duration_ = 3.27

		local var_25_0 = {
			ja = 3.266,
			ko = 2.366,
			zh = 2.366
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
				arg_25_0:Play122032007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.275

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(122032006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 11 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 11)

				if (11 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 11)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032006", "story_v_out_122032.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_122032", "122032006", "story_v_out_122032.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_122032", "122032006", "story_v_out_122032.awb")

						arg_25_1:RecordAudio("122032006", var_28_6)
						arg_25_1:RecordAudio("122032006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_122032", "122032006", "story_v_out_122032.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_122032", "122032006", "story_v_out_122032.awb")
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
	Play122032007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 122032007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play122032008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.85

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(122032007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 34 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 34)

				if (34 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 34)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play122032008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 122032008
		arg_33_1.duration_ = 7

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play122032009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_0 = 1

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				local var_36_1 = Color.New(1, 1, 1)

				var_36_1.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.mask_.color = var_36_1
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				local var_36_2 = Color.New(1, 1, 1)

				arg_33_1.mask_.enabled = false
				var_36_2.a = 0
				arg_33_1.mask_.color = var_36_2
			end

			local var_36_3 = 2

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_4 = 0.6

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_4 then
				local var_36_5 = Color.New(1, 1, 1)

				var_36_5.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - var_36_3) / var_36_4)
				arg_33_1.mask_.color = var_36_5
			end

			if arg_33_1.time_ >= var_36_3 + var_36_4 and arg_33_1.time_ < var_36_3 + var_36_4 + arg_36_0 then
				local var_36_6 = Color.New(1, 1, 1)

				arg_33_1.mask_.enabled = false
				var_36_6.a = 0
				arg_33_1.mask_.color = var_36_6
			end

			local var_36_7 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.allBtn_.enabled = false
			end

			if arg_33_1.time_ >= var_36_7 + 3 and arg_33_1.time_ < var_36_7 + 3 + arg_36_0 then
				arg_33_1.allBtn_.enabled = true
			end

			local var_36_8 = manager.ui.mainCamera.transform

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= 2 + arg_36_0 then
				arg_33_1.var_.shakeOldPos = var_36_8.localPosition
			end

			local var_36_9 = 1

			if 2 <= arg_33_1.time_ and arg_33_1.time_ < 2 + var_36_9 then
				local var_36_10, var_36_11 = math.modf((arg_33_1.time_ - 2) / 0.066)

				var_36_8.localPosition = Vector3.New(var_36_11 * 0.13, var_36_11 * 0.13, var_36_11 * 0.13) + arg_33_1.var_.shakeOldPos
			end

			if arg_33_1.time_ >= 2 + var_36_9 and arg_33_1.time_ < 2 + var_36_9 + arg_36_0 then
				var_36_8.localPosition = arg_33_1.var_.shakeOldPos
			end

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= 2 + arg_36_0 then
				arg_33_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_gravitybomb", "")
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_13 = 2
			local var_36_14 = 1.55

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_15 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_15:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_16 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(122032008).content)

				arg_33_1.text_.text = var_36_16

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_18 = 62 <= 0 and var_36_14 or var_36_14 * (utf8.len(var_36_16) / 62)

				if (62 <= 0 and var_36_14 or var_36_14 * (utf8.len(var_36_16) / 62)) > 0 and var_36_14 < var_36_18 then
					arg_33_1.talkMaxDuration = var_36_18
					var_36_13 = var_36_13 + 0.3

					if var_36_18 + var_36_13 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_13
					end
				end

				arg_33_1.text_.text = var_36_16
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_19 = var_36_13 + 0.3
			local var_36_20 = math.max(var_36_14, arg_33_1.talkMaxDuration)

			if var_36_13 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_19 + var_36_20 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_19) / var_36_20

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_19 + var_36_20 and arg_33_1.time_ < var_36_19 + var_36_20 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play122032009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 122032009
		arg_39_1.duration_ = 2.27

		local var_39_0 = {
			ja = 2.266,
			ko = 0.999999999999,
			zh = 0.999999999999
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
				arg_39_0:Play122032010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.075

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:GetWordFromCfg(122032009)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 3 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 3)

				if (3 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 3)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032009", "story_v_out_122032.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_122032", "122032009", "story_v_out_122032.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_122032", "122032009", "story_v_out_122032.awb")

						arg_39_1:RecordAudio("122032009", var_42_6)
						arg_39_1:RecordAudio("122032009", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_122032", "122032009", "story_v_out_122032.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_122032", "122032009", "story_v_out_122032.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play122032010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 122032010
		arg_43_1.duration_ = 1.9

		local var_43_0 = {
			ja = 1.9,
			ko = 0.999999999999,
			zh = 0.999999999999
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
				arg_43_0:Play122032011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.075

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:GetWordFromCfg(122032010)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 3 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 3)

				if (3 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 3)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032010", "story_v_out_122032.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_122032", "122032010", "story_v_out_122032.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_122032", "122032010", "story_v_out_122032.awb")

						arg_43_1:RecordAudio("122032010", var_46_6)
						arg_43_1:RecordAudio("122032010", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_122032", "122032010", "story_v_out_122032.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_122032", "122032010", "story_v_out_122032.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play122032011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 122032011
		arg_47_1.duration_ = 9

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play122032012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if arg_47_1.bgs_.STblack == nil then
				local var_50_0 = Object.Instantiate(arg_47_1.paintGo_)

				var_50_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_50_0.name = "STblack"
				var_50_0.transform.parent = arg_47_1.stage_.transform
				var_50_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.bgs_.STblack = var_50_0
			end

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= 2 + arg_50_0 then
				local var_50_1 = arg_47_1.bgs_.STblack

				arg_47_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_50_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_2 = var_50_1:GetComponent("SpriteRenderer")

				if var_50_2 and var_50_2.sprite then
					local var_50_3 = 2 * (var_50_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_50_1.transform.localScale = Vector3.New(var_50_3 / var_50_2.sprite.bounds.size.y < var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x and var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x or var_50_3 / var_50_2.sprite.bounds.size.y, var_50_3 / var_50_2.sprite.bounds.size.y < var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x and var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x or var_50_3 / var_50_2.sprite.bounds.size.y, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "STblack" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_4 = 0

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_5 = 2

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_5 then
				local var_50_6 = Color.New(1, 1, 1)

				var_50_6.a = Mathf.Lerp(0, 1, (arg_47_1.time_ - var_50_4) / var_50_5)
				arg_47_1.mask_.color = var_50_6
			end

			if arg_47_1.time_ >= var_50_4 + var_50_5 and arg_47_1.time_ < var_50_4 + var_50_5 + arg_50_0 then
				local var_50_7 = Color.New(1, 1, 1)

				var_50_7.a = 1
				arg_47_1.mask_.color = var_50_7
			end

			local var_50_8 = 2

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_9 = 1

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_9 then
				local var_50_10 = Color.New(1, 1, 1)

				var_50_10.a = Mathf.Lerp(1, 0, (arg_47_1.time_ - var_50_8) / var_50_9)
				arg_47_1.mask_.color = var_50_10
			end

			if arg_47_1.time_ >= var_50_8 + var_50_9 and arg_47_1.time_ < var_50_8 + var_50_9 + arg_50_0 then
				local var_50_11 = Color.New(1, 1, 1)

				arg_47_1.mask_.enabled = false
				var_50_11.a = 0
				arg_47_1.mask_.color = var_50_11
			end

			local var_50_12 = manager.ui.mainCamera.transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.shakeOldPos = var_50_12.localPosition
			end

			local var_50_13 = 2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_13 then
				local var_50_14, var_50_15 = math.modf((arg_47_1.time_ - 0) / 0.066)

				var_50_12.localPosition = Vector3.New(var_50_15 * 0.13, var_50_15 * 0.13, var_50_15 * 0.13) + arg_47_1.var_.shakeOldPos
			end

			if arg_47_1.time_ >= 0 + var_50_13 and arg_47_1.time_ < 0 + var_50_13 + arg_50_0 then
				var_50_12.localPosition = arg_47_1.var_.shakeOldPos
			end

			if 4 < arg_47_1.time_ and arg_47_1.time_ <= 4 + arg_50_0 then
				arg_47_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_windexplosion", "")
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_17 = 3.999999999999
			local var_50_18 = 1.2

			if 3.999999999999 < arg_47_1.time_ and arg_47_1.time_ <= var_50_17 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_19 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_19:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_20 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(122032011).content)

				arg_47_1.text_.text = var_50_20

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_22 = 48 <= 0 and var_50_18 or var_50_18 * (utf8.len(var_50_20) / 48)

				if (48 <= 0 and var_50_18 or var_50_18 * (utf8.len(var_50_20) / 48)) > 0 and var_50_18 < var_50_22 then
					arg_47_1.talkMaxDuration = var_50_22
					var_50_17 = var_50_17 + 0.3

					if var_50_22 + var_50_17 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_22 + var_50_17
					end
				end

				arg_47_1.text_.text = var_50_20
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_23 = var_50_17 + 0.3
			local var_50_24 = math.max(var_50_18, arg_47_1.talkMaxDuration)

			if var_50_17 + 0.3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_23 + var_50_24 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_23) / var_50_24

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_23 + var_50_24 and arg_47_1.time_ < var_50_23 + var_50_24 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play122032012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 122032012
		arg_53_1.duration_ = 9.5

		local var_53_0 = {
			ja = 9.50000000298023,
			ko = 6.33300000298023,
			zh = 6.33300000298023
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
				arg_53_0:Play122032013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if arg_53_1.bgs_.J05g == nil then
				local var_56_0 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J05g")
				var_56_0.name = "J05g"
				var_56_0.transform.parent = arg_53_1.stage_.transform
				var_56_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_.J05g = var_56_0
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				local var_56_1 = arg_53_1.bgs_.J05g

				arg_53_1.bgs_.J05g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_56_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_2 = var_56_1:GetComponent("SpriteRenderer")

				if var_56_2 and var_56_2.sprite then
					local var_56_3 = 2 * (var_56_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_56_1.transform.localScale = Vector3.New(var_56_3 / var_56_2.sprite.bounds.size.y < var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x and var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x or var_56_3 / var_56_2.sprite.bounds.size.y, var_56_3 / var_56_2.sprite.bounds.size.y < var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x and var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x or var_56_3 / var_56_2.sprite.bounds.size.y, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "J05g" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_4 = 0

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_5 = 2

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_5 then
				local var_56_6 = Color.New(0, 0, 0)

				var_56_6.a = Mathf.Lerp(1, 0, (arg_53_1.time_ - var_56_4) / var_56_5)
				arg_53_1.mask_.color = var_56_6
			end

			if arg_53_1.time_ >= var_56_4 + var_56_5 and arg_53_1.time_ < var_56_4 + var_56_5 + arg_56_0 then
				local var_56_7 = Color.New(0, 0, 0)

				arg_53_1.mask_.enabled = false
				var_56_7.a = 0
				arg_53_1.mask_.color = var_56_7
			end

			local var_56_8 = "1074ui_story"

			if arg_53_1.actors_["1074ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1074ui_story"))) then
				local var_56_9 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_53_1.stage_.transform)

				var_56_9.name = var_56_8
				var_56_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_[var_56_8] = var_56_9

				local var_56_10 = var_56_9:GetComponentInChildren(typeof(CharacterEffect))

				var_56_10.enabled = true

				local var_56_11 = GameObjectTools.GetOrAddComponent(var_56_9, typeof(DynamicBoneHelper))

				if var_56_11 then
					var_56_11:EnableDynamicBone(false)
				end

				arg_53_1:ShowWeapon(var_56_10.transform, false)

				arg_53_1.var_[var_56_8 .. "Animator"] = var_56_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_53_1.var_[var_56_8 .. "Animator"].applyRootMotion = true
				arg_53_1.var_[var_56_8 .. "LipSync"] = var_56_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_56_12 = arg_53_1.actors_["1074ui_story"].transform

			if 1.8 < arg_53_1.time_ and arg_53_1.time_ <= 1.8 + arg_56_0 then
				arg_53_1.var_.moveOldPos1074ui_story = var_56_12.localPosition
			end

			local var_56_13 = 0.001

			if 1.8 <= arg_53_1.time_ and arg_53_1.time_ < 1.8 + var_56_13 then
				var_56_12.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_53_1.time_ - 1.8) / var_56_13)
				var_56_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_12.position).x, (manager.ui.mainCamera.transform.position - var_56_12.position).y, (manager.ui.mainCamera.transform.position - var_56_12.position).z)
				var_56_12.localEulerAngles.z = 0
				var_56_12.localEulerAngles.x = 0
				var_56_12.localEulerAngles = var_56_12.localEulerAngles
			end

			if arg_53_1.time_ >= 1.8 + var_56_13 and arg_53_1.time_ < 1.8 + var_56_13 + arg_56_0 then
				var_56_12.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				var_56_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_12.position).x, (manager.ui.mainCamera.transform.position - var_56_12.position).y, (manager.ui.mainCamera.transform.position - var_56_12.position).z)
				var_56_12.localEulerAngles.z = 0
				var_56_12.localEulerAngles.x = 0
				var_56_12.localEulerAngles = var_56_12.localEulerAngles
			end

			local var_56_14 = arg_53_1.actors_["1074ui_story"]

			if 1.8 < arg_53_1.time_ and arg_53_1.time_ <= 1.8 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.characterEffect1074ui_story == nil then
				arg_53_1.var_.characterEffect1074ui_story = var_56_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_15 = 0.200000002980232

			if 1.8 <= arg_53_1.time_ and arg_53_1.time_ < 1.8 + var_56_15 and not isNil(var_56_14) then
				if arg_53_1.var_.characterEffect1074ui_story and not isNil(var_56_14) then
					arg_53_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 1.8 + var_56_15 and arg_53_1.time_ < 1.8 + var_56_15 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.characterEffect1074ui_story then
				arg_53_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 1.8 < arg_53_1.time_ and arg_53_1.time_ <= 1.8 + arg_56_0 then
				arg_53_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			if 1.8 < arg_53_1.time_ and arg_53_1.time_ <= 1.8 + arg_56_0 then
				arg_53_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_17 = "10044ui_story"

			if arg_53_1.actors_["10044ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10044ui_story"))) then
				local var_56_18 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_53_1.stage_.transform)

				var_56_18.name = var_56_17
				var_56_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_[var_56_17] = var_56_18

				local var_56_19 = var_56_18:GetComponentInChildren(typeof(CharacterEffect))

				var_56_19.enabled = true

				local var_56_20 = GameObjectTools.GetOrAddComponent(var_56_18, typeof(DynamicBoneHelper))

				if var_56_20 then
					var_56_20:EnableDynamicBone(false)
				end

				arg_53_1:ShowWeapon(var_56_19.transform, false)

				arg_53_1.var_[var_56_17 .. "Animator"] = var_56_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_53_1.var_[var_56_17 .. "Animator"].applyRootMotion = true
				arg_53_1.var_[var_56_17 .. "LipSync"] = var_56_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_56_21 = arg_53_1.actors_["10044ui_story"].transform

			if 1.8 < arg_53_1.time_ and arg_53_1.time_ <= 1.8 + arg_56_0 then
				arg_53_1.var_.moveOldPos10044ui_story = var_56_21.localPosition
			end

			local var_56_22 = 0.001

			if 1.8 <= arg_53_1.time_ and arg_53_1.time_ < 1.8 + var_56_22 then
				var_56_21.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10044ui_story, Vector3.New(0.7, -0.72, -6.3), (arg_53_1.time_ - 1.8) / var_56_22)
				var_56_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_21.position).x, (manager.ui.mainCamera.transform.position - var_56_21.position).y, (manager.ui.mainCamera.transform.position - var_56_21.position).z)
				var_56_21.localEulerAngles.z = 0
				var_56_21.localEulerAngles.x = 0
				var_56_21.localEulerAngles = var_56_21.localEulerAngles
			end

			if arg_53_1.time_ >= 1.8 + var_56_22 and arg_53_1.time_ < 1.8 + var_56_22 + arg_56_0 then
				var_56_21.localPosition = Vector3.New(0.7, -0.72, -6.3)
				var_56_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_21.position).x, (manager.ui.mainCamera.transform.position - var_56_21.position).y, (manager.ui.mainCamera.transform.position - var_56_21.position).z)
				var_56_21.localEulerAngles.z = 0
				var_56_21.localEulerAngles.x = 0
				var_56_21.localEulerAngles = var_56_21.localEulerAngles
			end

			local var_56_23 = arg_53_1.actors_["10044ui_story"]

			if 1.8 < arg_53_1.time_ and arg_53_1.time_ <= 1.8 + arg_56_0 and not isNil(var_56_23) and arg_53_1.var_.characterEffect10044ui_story == nil then
				arg_53_1.var_.characterEffect10044ui_story = var_56_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_24 = 0.200000002980232

			if 1.8 <= arg_53_1.time_ and arg_53_1.time_ < 1.8 + var_56_24 and not isNil(var_56_23) then
				if arg_53_1.var_.characterEffect10044ui_story and not isNil(var_56_23) then
					arg_53_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 1.8) / var_56_24)
				end
			end

			if arg_53_1.time_ >= 1.8 + var_56_24 and arg_53_1.time_ < 1.8 + var_56_24 + arg_56_0 and not isNil(var_56_23) and arg_53_1.var_.characterEffect10044ui_story then
				arg_53_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 1.8 < arg_53_1.time_ and arg_53_1.time_ <= 1.8 + arg_56_0 then
				arg_53_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_25 = 2.00000000298023
			local var_56_26 = 0.45

			if 2.00000000298023 < arg_53_1.time_ and arg_53_1.time_ <= var_56_25 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_27 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_27:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_28 = arg_53_1:GetWordFromCfg(122032012)
				local var_56_29 = arg_53_1:FormatText(var_56_28.content)

				arg_53_1.text_.text = var_56_29

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_31 = 18 <= 0 and var_56_26 or var_56_26 * (utf8.len(var_56_29) / 18)

				if (18 <= 0 and var_56_26 or var_56_26 * (utf8.len(var_56_29) / 18)) > 0 and var_56_26 < var_56_31 then
					arg_53_1.talkMaxDuration = var_56_31
					var_56_25 = var_56_25 + 0.3

					if var_56_31 + var_56_25 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_31 + var_56_25
					end
				end

				arg_53_1.text_.text = var_56_29
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032012", "story_v_out_122032.awb") ~= 0 then
					local var_56_32 = manager.audio:GetVoiceLength("story_v_out_122032", "122032012", "story_v_out_122032.awb") / 1000

					if var_56_32 + var_56_25 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_32 + var_56_25
					end

					if var_56_28.prefab_name ~= "" and arg_53_1.actors_[var_56_28.prefab_name] ~= nil then
						local var_56_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_28.prefab_name].transform, "story_v_out_122032", "122032012", "story_v_out_122032.awb")

						arg_53_1:RecordAudio("122032012", var_56_33)
						arg_53_1:RecordAudio("122032012", var_56_33)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_122032", "122032012", "story_v_out_122032.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_122032", "122032012", "story_v_out_122032.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_34 = var_56_25 + 0.3
			local var_56_35 = math.max(var_56_26, arg_53_1.talkMaxDuration)

			if var_56_25 + 0.3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_34 + var_56_35 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_34) / var_56_35

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_34 + var_56_35 and arg_53_1.time_ < var_56_34 + var_56_35 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play122032013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 122032013
		arg_59_1.duration_ = 3

		local var_59_0 = {
			ja = 3,
			ko = 2.933,
			zh = 2.933
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
				arg_59_0:Play122032014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["10044ui_story"]) and arg_59_1.var_.characterEffect10044ui_story == nil then
				arg_59_1.var_.characterEffect10044ui_story = arg_59_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["10044ui_story"]) then
				if arg_59_1.var_.characterEffect10044ui_story and not isNil(arg_59_1.actors_["10044ui_story"]) then
					arg_59_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["10044ui_story"]) and arg_59_1.var_.characterEffect10044ui_story then
				arg_59_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_2 = arg_59_1.actors_["1074ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.characterEffect1074ui_story == nil then
				arg_59_1.var_.characterEffect1074ui_story = var_62_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_3 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_3 and not isNil(var_62_2) then
				if arg_59_1.var_.characterEffect1074ui_story and not isNil(var_62_2) then
					arg_59_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_3)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_3 and arg_59_1.time_ < 0 + var_62_3 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.characterEffect1074ui_story then
				arg_59_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_62_4 = 0
			local var_62_5 = 0.225

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(122032013)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 9 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 9)

				if (9 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 9)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032013", "story_v_out_122032.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_122032", "122032013", "story_v_out_122032.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_122032", "122032013", "story_v_out_122032.awb")

						arg_59_1:RecordAudio("122032013", var_62_11)
						arg_59_1:RecordAudio("122032013", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_122032", "122032013", "story_v_out_122032.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_122032", "122032013", "story_v_out_122032.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_12 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_12 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_12

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_12 and arg_59_1.time_ < var_62_4 + var_62_12 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play122032014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 122032014
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play122032015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["10044ui_story"]) and arg_63_1.var_.characterEffect10044ui_story == nil then
				arg_63_1.var_.characterEffect10044ui_story = arg_63_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["10044ui_story"]) then
				if arg_63_1.var_.characterEffect10044ui_story and not isNil(arg_63_1.actors_["10044ui_story"]) then
					arg_63_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["10044ui_story"]) and arg_63_1.var_.characterEffect10044ui_story then
				arg_63_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 1.575

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(122032014).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 63 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 63)

				if (63 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 63)) > 0 and var_66_2 < var_66_5 then
					arg_63_1.talkMaxDuration = var_66_5

					if var_66_5 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_6 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_6 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_6

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_6 and arg_63_1.time_ < var_66_1 + var_66_6 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play122032015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 122032015
		arg_67_1.duration_ = 3.87

		local var_67_0 = {
			ja = 3.866,
			ko = 3.366,
			zh = 3.366
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
				arg_67_0:Play122032016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["10044ui_story"]) and arg_67_1.var_.characterEffect10044ui_story == nil then
				arg_67_1.var_.characterEffect10044ui_story = arg_67_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["10044ui_story"]) then
				if arg_67_1.var_.characterEffect10044ui_story and not isNil(arg_67_1.actors_["10044ui_story"]) then
					arg_67_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["10044ui_story"]) and arg_67_1.var_.characterEffect10044ui_story then
				arg_67_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_2")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_70_2 = 0
			local var_70_3 = 0.3

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:GetWordFromCfg(122032015)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_7 = 12 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 12)

				if (12 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 12)) > 0 and var_70_3 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032015", "story_v_out_122032.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_122032", "122032015", "story_v_out_122032.awb") / 1000

					if var_70_8 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_2
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_out_122032", "122032015", "story_v_out_122032.awb")

						arg_67_1:RecordAudio("122032015", var_70_9)
						arg_67_1:RecordAudio("122032015", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_122032", "122032015", "story_v_out_122032.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_122032", "122032015", "story_v_out_122032.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_3, arg_67_1.talkMaxDuration)

			if var_70_2 <= arg_67_1.time_ and arg_67_1.time_ < var_70_2 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_2) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_2 + var_70_10 and arg_67_1.time_ < var_70_2 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play122032016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 122032016
		arg_71_1.duration_ = 2

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play122032017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1074ui_story = arg_71_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1074ui_story"].transform.position).z)
				arg_71_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1074ui_story"].transform.localEulerAngles = arg_71_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_71_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1074ui_story"].transform.position).z)
				arg_71_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1074ui_story"].transform.localEulerAngles = arg_71_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1074ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1074ui_story == nil then
				arg_71_1.var_.characterEffect1074ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1074ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1074ui_story then
				arg_71_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074actionlink/1074action456")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_74_4 = arg_71_1.actors_["10044ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect10044ui_story == nil then
				arg_71_1.var_.characterEffect10044ui_story = var_74_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_5 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_5 and not isNil(var_74_4) then
				if arg_71_1.var_.characterEffect10044ui_story and not isNil(var_74_4) then
					arg_71_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_5)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_5 and arg_71_1.time_ < 0 + var_74_5 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect10044ui_story then
				arg_71_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_74_6 = 0
			local var_74_7 = 0.05

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(122032016)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 2 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 2)

				if (2 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 2)) > 0 and var_74_7 < var_74_11 then
					arg_71_1.talkMaxDuration = var_74_11

					if var_74_11 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032016", "story_v_out_122032.awb") ~= 0 then
					local var_74_12 = manager.audio:GetVoiceLength("story_v_out_122032", "122032016", "story_v_out_122032.awb") / 1000

					if var_74_12 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_6
					end

					if var_74_8.prefab_name ~= "" and arg_71_1.actors_[var_74_8.prefab_name] ~= nil then
						local var_74_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_8.prefab_name].transform, "story_v_out_122032", "122032016", "story_v_out_122032.awb")

						arg_71_1:RecordAudio("122032016", var_74_13)
						arg_71_1:RecordAudio("122032016", var_74_13)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_122032", "122032016", "story_v_out_122032.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_122032", "122032016", "story_v_out_122032.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_14 and arg_71_1.time_ < var_74_6 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play122032017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 122032017
		arg_75_1.duration_ = 6.53

		local var_75_0 = {
			ja = 6.533,
			ko = 5,
			zh = 5
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
				arg_75_0:Play122032018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1074ui_story"]) and arg_75_1.var_.characterEffect1074ui_story == nil then
				arg_75_1.var_.characterEffect1074ui_story = arg_75_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1074ui_story"]) then
				if arg_75_1.var_.characterEffect1074ui_story and not isNil(arg_75_1.actors_["1074ui_story"]) then
					arg_75_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1074ui_story"]) and arg_75_1.var_.characterEffect1074ui_story then
				arg_75_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074actionlink/1074action465")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_78_2 = 0
			local var_78_3 = 0.625

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_4 = arg_75_1:GetWordFromCfg(122032017)
				local var_78_5 = arg_75_1:FormatText(var_78_4.content)

				arg_75_1.text_.text = var_78_5

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_7 = 25 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_5) / 25)

				if (25 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_5) / 25)) > 0 and var_78_3 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_2
					end
				end

				arg_75_1.text_.text = var_78_5
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032017", "story_v_out_122032.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_122032", "122032017", "story_v_out_122032.awb") / 1000

					if var_78_8 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_2
					end

					if var_78_4.prefab_name ~= "" and arg_75_1.actors_[var_78_4.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_4.prefab_name].transform, "story_v_out_122032", "122032017", "story_v_out_122032.awb")

						arg_75_1:RecordAudio("122032017", var_78_9)
						arg_75_1:RecordAudio("122032017", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_122032", "122032017", "story_v_out_122032.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_122032", "122032017", "story_v_out_122032.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_3, arg_75_1.talkMaxDuration)

			if var_78_2 <= arg_75_1.time_ and arg_75_1.time_ < var_78_2 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_2) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_2 + var_78_10 and arg_75_1.time_ < var_78_2 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play122032018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 122032018
		arg_79_1.duration_ = 5.77

		local var_79_0 = {
			ja = 5.766,
			ko = 4.966,
			zh = 4.966
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
				arg_79_0:Play122032019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1074ui_story = arg_79_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1074ui_story"].transform.position).z)
				arg_79_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1074ui_story"].transform.localEulerAngles = arg_79_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1074ui_story"].transform.position).z)
				arg_79_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1074ui_story"].transform.localEulerAngles = arg_79_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1074ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1074ui_story == nil then
				arg_79_1.var_.characterEffect1074ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1074ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_2)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1074ui_story then
				arg_79_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_82_3 = arg_79_1.actors_["10044ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10044ui_story = var_82_3.localPosition
			end

			local var_82_4 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				var_82_3.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_4)
				var_82_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_3.position).x, (manager.ui.mainCamera.transform.position - var_82_3.position).y, (manager.ui.mainCamera.transform.position - var_82_3.position).z)
				var_82_3.localEulerAngles.z = 0
				var_82_3.localEulerAngles.x = 0
				var_82_3.localEulerAngles = var_82_3.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				var_82_3.localPosition = Vector3.New(0, 100, 0)
				var_82_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_3.position).x, (manager.ui.mainCamera.transform.position - var_82_3.position).y, (manager.ui.mainCamera.transform.position - var_82_3.position).z)
				var_82_3.localEulerAngles.z = 0
				var_82_3.localEulerAngles.x = 0
				var_82_3.localEulerAngles = var_82_3.localEulerAngles
			end

			local var_82_5 = arg_79_1.actors_["10044ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_5) and arg_79_1.var_.characterEffect10044ui_story == nil then
				arg_79_1.var_.characterEffect10044ui_story = var_82_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_6 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_6 and not isNil(var_82_5) then
				if arg_79_1.var_.characterEffect10044ui_story and not isNil(var_82_5) then
					arg_79_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_6)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_6 and arg_79_1.time_ < 0 + var_82_6 + arg_82_0 and not isNil(var_82_5) and arg_79_1.var_.characterEffect10044ui_story then
				arg_79_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_82_7 = manager.ui.mainCamera.transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.shakeOldPos = var_82_7.localPosition
			end

			local var_82_8 = 0.6

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_8 then
				local var_82_9, var_82_10 = math.modf((arg_79_1.time_ - 0) / 0.066)

				var_82_7.localPosition = Vector3.New(var_82_10 * 0.13, var_82_10 * 0.13, var_82_10 * 0.13) + arg_79_1.var_.shakeOldPos
			end

			if arg_79_1.time_ >= 0 + var_82_8 and arg_79_1.time_ < 0 + var_82_8 + arg_82_0 then
				var_82_7.localPosition = arg_79_1.var_.shakeOldPos
			end

			local var_82_11 = 0

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			if arg_79_1.time_ >= var_82_11 + 0.6 and arg_79_1.time_ < var_82_11 + 0.6 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			local var_82_12 = 0
			local var_82_13 = 0.475

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_12 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_14 = arg_79_1:GetWordFromCfg(122032018)
				local var_82_15 = arg_79_1:FormatText(var_82_14.content)

				arg_79_1.text_.text = var_82_15

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_17 = 19 <= 0 and var_82_13 or var_82_13 * (utf8.len(var_82_15) / 19)

				if (19 <= 0 and var_82_13 or var_82_13 * (utf8.len(var_82_15) / 19)) > 0 and var_82_13 < var_82_17 then
					arg_79_1.talkMaxDuration = var_82_17

					if var_82_17 + var_82_12 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_17 + var_82_12
					end
				end

				arg_79_1.text_.text = var_82_15
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032018", "story_v_out_122032.awb") ~= 0 then
					local var_82_18 = manager.audio:GetVoiceLength("story_v_out_122032", "122032018", "story_v_out_122032.awb") / 1000

					if var_82_18 + var_82_12 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_18 + var_82_12
					end

					if var_82_14.prefab_name ~= "" and arg_79_1.actors_[var_82_14.prefab_name] ~= nil then
						local var_82_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_14.prefab_name].transform, "story_v_out_122032", "122032018", "story_v_out_122032.awb")

						arg_79_1:RecordAudio("122032018", var_82_19)
						arg_79_1:RecordAudio("122032018", var_82_19)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_122032", "122032018", "story_v_out_122032.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_122032", "122032018", "story_v_out_122032.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_20 = math.max(var_82_13, arg_79_1.talkMaxDuration)

			if var_82_12 <= arg_79_1.time_ and arg_79_1.time_ < var_82_12 + var_82_20 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_12) / var_82_20

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_12 + var_82_20 and arg_79_1.time_ < var_82_12 + var_82_20 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play122032019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 122032019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play122032020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.875

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(122032019).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 35 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 35)

				if (35 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 35)) > 0 and var_86_0 < var_86_3 then
					arg_83_1.talkMaxDuration = var_86_3

					if var_86_3 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_3 + 0
					end
				end

				arg_83_1.text_.text = var_86_1
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_4 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_4

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play122032020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 122032020
		arg_87_1.duration_ = 4.8

		local var_87_0 = {
			ja = 4.8,
			ko = 2.6,
			zh = 2.6
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
				arg_87_0:Play122032021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1074ui_story = arg_87_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1074ui_story"].transform.position).z)
				arg_87_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1074ui_story"].transform.localEulerAngles = arg_87_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_87_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1074ui_story"].transform.position).z)
				arg_87_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1074ui_story"].transform.localEulerAngles = arg_87_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1074ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1074ui_story == nil then
				arg_87_1.var_.characterEffect1074ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1074ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1074ui_story then
				arg_87_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_90_4 = "1072ui_story"

			if arg_87_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_90_5 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_87_1.stage_.transform)

				var_90_5.name = var_90_4
				var_90_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_[var_90_4] = var_90_5

				local var_90_6 = var_90_5:GetComponentInChildren(typeof(CharacterEffect))

				var_90_6.enabled = true

				local var_90_7 = GameObjectTools.GetOrAddComponent(var_90_5, typeof(DynamicBoneHelper))

				if var_90_7 then
					var_90_7:EnableDynamicBone(false)
				end

				arg_87_1:ShowWeapon(var_90_6.transform, false)

				arg_87_1.var_[var_90_4 .. "Animator"] = var_90_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_87_1.var_[var_90_4 .. "Animator"].applyRootMotion = true
				arg_87_1.var_[var_90_4 .. "LipSync"] = var_90_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_90_8 = arg_87_1.actors_["1072ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1072ui_story = var_90_8.localPosition
			end

			local var_90_9 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_9 then
				var_90_8.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_87_1.time_ - 0) / var_90_9)
				var_90_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_8.position).x, (manager.ui.mainCamera.transform.position - var_90_8.position).y, (manager.ui.mainCamera.transform.position - var_90_8.position).z)
				var_90_8.localEulerAngles.z = 0
				var_90_8.localEulerAngles.x = 0
				var_90_8.localEulerAngles = var_90_8.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_9 and arg_87_1.time_ < 0 + var_90_9 + arg_90_0 then
				var_90_8.localPosition = Vector3.New(0.7, -0.71, -6)
				var_90_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_8.position).x, (manager.ui.mainCamera.transform.position - var_90_8.position).y, (manager.ui.mainCamera.transform.position - var_90_8.position).z)
				var_90_8.localEulerAngles.z = 0
				var_90_8.localEulerAngles.x = 0
				var_90_8.localEulerAngles = var_90_8.localEulerAngles
			end

			local var_90_10 = arg_87_1.actors_["1072ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_10) and arg_87_1.var_.characterEffect1072ui_story == nil then
				arg_87_1.var_.characterEffect1072ui_story = var_90_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_11 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_11 and not isNil(var_90_10) then
				if arg_87_1.var_.characterEffect1072ui_story and not isNil(var_90_10) then
					arg_87_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_11)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_11 and arg_87_1.time_ < 0 + var_90_11 + arg_90_0 and not isNil(var_90_10) and arg_87_1.var_.characterEffect1072ui_story then
				arg_87_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_1")
			end

			local var_90_12 = 0
			local var_90_13 = 0.275

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_12 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_14 = arg_87_1:GetWordFromCfg(122032020)
				local var_90_15 = arg_87_1:FormatText(var_90_14.content)

				arg_87_1.text_.text = var_90_15

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_17 = 11 <= 0 and var_90_13 or var_90_13 * (utf8.len(var_90_15) / 11)

				if (11 <= 0 and var_90_13 or var_90_13 * (utf8.len(var_90_15) / 11)) > 0 and var_90_13 < var_90_17 then
					arg_87_1.talkMaxDuration = var_90_17

					if var_90_17 + var_90_12 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_17 + var_90_12
					end
				end

				arg_87_1.text_.text = var_90_15
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032020", "story_v_out_122032.awb") ~= 0 then
					local var_90_18 = manager.audio:GetVoiceLength("story_v_out_122032", "122032020", "story_v_out_122032.awb") / 1000

					if var_90_18 + var_90_12 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_18 + var_90_12
					end

					if var_90_14.prefab_name ~= "" and arg_87_1.actors_[var_90_14.prefab_name] ~= nil then
						local var_90_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_14.prefab_name].transform, "story_v_out_122032", "122032020", "story_v_out_122032.awb")

						arg_87_1:RecordAudio("122032020", var_90_19)
						arg_87_1:RecordAudio("122032020", var_90_19)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_122032", "122032020", "story_v_out_122032.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_122032", "122032020", "story_v_out_122032.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_20 = math.max(var_90_13, arg_87_1.talkMaxDuration)

			if var_90_12 <= arg_87_1.time_ and arg_87_1.time_ < var_90_12 + var_90_20 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_12) / var_90_20

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_12 + var_90_20 and arg_87_1.time_ < var_90_12 + var_90_20 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play122032021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 122032021
		arg_91_1.duration_ = 10

		local var_91_0 = {
			ja = 10,
			ko = 7.366,
			zh = 7.333
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
				arg_91_0:Play122032022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1072ui_story"]) and arg_91_1.var_.characterEffect1072ui_story == nil then
				arg_91_1.var_.characterEffect1072ui_story = arg_91_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1072ui_story"]) then
				if arg_91_1.var_.characterEffect1072ui_story and not isNil(arg_91_1.actors_["1072ui_story"]) then
					arg_91_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1072ui_story"]) and arg_91_1.var_.characterEffect1072ui_story then
				arg_91_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_94_2 = arg_91_1.actors_["1074ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.characterEffect1074ui_story == nil then
				arg_91_1.var_.characterEffect1074ui_story = var_94_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_3 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 and not isNil(var_94_2) then
				if arg_91_1.var_.characterEffect1074ui_story and not isNil(var_94_2) then
					arg_91_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_3)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.characterEffect1074ui_story then
				arg_91_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_94_4 = 0
			local var_94_5 = 0.85

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(122032021)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 34 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 34)

				if (34 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 34)) > 0 and var_94_5 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032021", "story_v_out_122032.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_out_122032", "122032021", "story_v_out_122032.awb") / 1000

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_out_122032", "122032021", "story_v_out_122032.awb")

						arg_91_1:RecordAudio("122032021", var_94_11)
						arg_91_1:RecordAudio("122032021", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_122032", "122032021", "story_v_out_122032.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_122032", "122032021", "story_v_out_122032.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_12 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_12

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_12 and arg_91_1.time_ < var_94_4 + var_94_12 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play122032022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 122032022
		arg_95_1.duration_ = 6.57

		local var_95_0 = {
			ja = 6.566,
			ko = 3.666,
			zh = 3.666
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
				arg_95_0:Play122032023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1074ui_story"]) and arg_95_1.var_.characterEffect1074ui_story == nil then
				arg_95_1.var_.characterEffect1074ui_story = arg_95_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1074ui_story"]) then
				if arg_95_1.var_.characterEffect1074ui_story and not isNil(arg_95_1.actors_["1074ui_story"]) then
					arg_95_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1074ui_story"]) and arg_95_1.var_.characterEffect1074ui_story then
				arg_95_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_2")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_98_2 = arg_95_1.actors_["1072ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.characterEffect1072ui_story == nil then
				arg_95_1.var_.characterEffect1072ui_story = var_98_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_3 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_3 and not isNil(var_98_2) then
				if arg_95_1.var_.characterEffect1072ui_story and not isNil(var_98_2) then
					arg_95_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_3)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_3 and arg_95_1.time_ < 0 + var_98_3 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.characterEffect1072ui_story then
				arg_95_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_98_4 = 0
			local var_98_5 = 0.4

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(122032022)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 16 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 16)

				if (16 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 16)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032022", "story_v_out_122032.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_122032", "122032022", "story_v_out_122032.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_122032", "122032022", "story_v_out_122032.awb")

						arg_95_1:RecordAudio("122032022", var_98_11)
						arg_95_1:RecordAudio("122032022", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_122032", "122032022", "story_v_out_122032.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_122032", "122032022", "story_v_out_122032.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play122032023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 122032023
		arg_99_1.duration_ = 7.53

		local var_99_0 = {
			ja = 7.533,
			ko = 5.466,
			zh = 5.466
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
				arg_99_0:Play122032024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1072ui_story"]) and arg_99_1.var_.characterEffect1072ui_story == nil then
				arg_99_1.var_.characterEffect1072ui_story = arg_99_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1072ui_story"]) then
				if arg_99_1.var_.characterEffect1072ui_story and not isNil(arg_99_1.actors_["1072ui_story"]) then
					arg_99_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1072ui_story"]) and arg_99_1.var_.characterEffect1072ui_story then
				arg_99_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_2")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_2 = arg_99_1.actors_["1074ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.characterEffect1074ui_story == nil then
				arg_99_1.var_.characterEffect1074ui_story = var_102_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_3 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_3 and not isNil(var_102_2) then
				if arg_99_1.var_.characterEffect1074ui_story and not isNil(var_102_2) then
					arg_99_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_3)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_3 and arg_99_1.time_ < 0 + var_102_3 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.characterEffect1074ui_story then
				arg_99_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_102_4 = 0
			local var_102_5 = 0.7

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(122032023)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 28 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 28)

				if (28 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 28)) > 0 and var_102_5 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032023", "story_v_out_122032.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_out_122032", "122032023", "story_v_out_122032.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_out_122032", "122032023", "story_v_out_122032.awb")

						arg_99_1:RecordAudio("122032023", var_102_11)
						arg_99_1:RecordAudio("122032023", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_122032", "122032023", "story_v_out_122032.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_122032", "122032023", "story_v_out_122032.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_12 = math.max(var_102_5, arg_99_1.talkMaxDuration)

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_12 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_4) / var_102_12

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_4 + var_102_12 and arg_99_1.time_ < var_102_4 + var_102_12 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play122032024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 122032024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play122032025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1072ui_story"]) and arg_103_1.var_.characterEffect1072ui_story == nil then
				arg_103_1.var_.characterEffect1072ui_story = arg_103_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1072ui_story"]) then
				if arg_103_1.var_.characterEffect1072ui_story and not isNil(arg_103_1.actors_["1072ui_story"]) then
					arg_103_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_0)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1072ui_story"]) and arg_103_1.var_.characterEffect1072ui_story then
				arg_103_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_106_1 = 0
			local var_106_2 = 0.825

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(122032024).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 33 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 33)

				if (33 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 33)) > 0 and var_106_2 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_1 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_1
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_6 = math.max(var_106_2, arg_103_1.talkMaxDuration)

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_6 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_1) / var_106_6

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_1 + var_106_6 and arg_103_1.time_ < var_106_1 + var_106_6 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play122032025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 122032025
		arg_107_1.duration_ = 9.87

		local var_107_0 = {
			ja = 9.866,
			ko = 6.6,
			zh = 6.6
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
			arg_107_1.auto_ = false
		end

		function arg_107_1.playNext_(arg_109_0)
			arg_107_1.onStoryFinished_()
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1074ui_story"]) and arg_107_1.var_.characterEffect1074ui_story == nil then
				arg_107_1.var_.characterEffect1074ui_story = arg_107_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1074ui_story"]) then
				if arg_107_1.var_.characterEffect1074ui_story and not isNil(arg_107_1.actors_["1074ui_story"]) then
					arg_107_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1074ui_story"]) and arg_107_1.var_.characterEffect1074ui_story then
				arg_107_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_110_2 = 0
			local var_110_3 = 0.575

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_4 = arg_107_1:GetWordFromCfg(122032025)
				local var_110_5 = arg_107_1:FormatText(var_110_4.content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_7 = 23 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 23)

				if (23 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 23)) > 0 and var_110_3 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_2
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122032", "122032025", "story_v_out_122032.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_122032", "122032025", "story_v_out_122032.awb") / 1000

					if var_110_8 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_2
					end

					if var_110_4.prefab_name ~= "" and arg_107_1.actors_[var_110_4.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_4.prefab_name].transform, "story_v_out_122032", "122032025", "story_v_out_122032.awb")

						arg_107_1:RecordAudio("122032025", var_110_9)
						arg_107_1:RecordAudio("122032025", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_122032", "122032025", "story_v_out_122032.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_122032", "122032025", "story_v_out_122032.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_3, arg_107_1.talkMaxDuration)

			if var_110_2 <= arg_107_1.time_ and arg_107_1.time_ < var_110_2 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_2) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_2 + var_110_10 and arg_107_1.time_ < var_110_2 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/XH0501",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J05g"
	},
	voices = {
		"story_v_out_122032.awb"
	}
}
