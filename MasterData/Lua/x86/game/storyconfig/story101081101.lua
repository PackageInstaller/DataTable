return {
	Play108111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 108111001
		arg_1_1.duration_ = 13.07

		local var_1_0 = {
			ja = 12.666,
			ko = 11.533,
			zh = 13.066,
			en = 9.1
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
				arg_1_0:Play108111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.S0805 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0805")
				var_4_0.name = "S0805"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.S0805 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.S0805

				arg_1_1.bgs_.S0805.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0805" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.S0805:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueS0805 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueS0805 = var_4_4
				end

				arg_1_1.var_.alphaOldValueS0805 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueS0805 then
					arg_1_1.var_.alphaMatValueS0805.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueS0805, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueS0805.color = arg_1_1.var_.alphaMatValueS0805.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueS0805 then
				arg_1_1.var_.alphaMatValueS0805.color.a = 1
				arg_1_1.var_.alphaMatValueS0805.color = arg_1_1.var_.alphaMatValueS0805.color
			end

			local var_4_6 = arg_1_1.bgs_.S0805.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosS0805 = var_4_6.localPosition
			end

			local var_4_7 = 6

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_7 then
				var_4_6.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosS0805, Vector3.New(0, 1, 9.5), (arg_1_1.time_ - 0) / var_4_7)
			end

			if arg_1_1.time_ >= 0 + var_4_7 and arg_1_1.time_ < 0 + var_4_7 + arg_4_0 then
				var_4_6.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_10 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			local var_4_11 = 2
			local var_4_12 = 0.975

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_13 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_13:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_14 = arg_1_1:GetWordFromCfg(108111001)
				local var_4_15 = arg_1_1:FormatText(var_4_14.content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 39 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_15) / 39)

				if (39 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_15) / 39)) > 0 and var_4_12 < var_4_17 then
					arg_1_1.talkMaxDuration = var_4_17
					var_4_11 = var_4_11 + 0.3

					if var_4_17 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_15
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111001", "story_v_out_108111.awb") ~= 0 then
					local var_4_18 = manager.audio:GetVoiceLength("story_v_out_108111", "108111001", "story_v_out_108111.awb") / 1000

					if var_4_18 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_11
					end

					if var_4_14.prefab_name ~= "" and arg_1_1.actors_[var_4_14.prefab_name] ~= nil then
						local var_4_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_14.prefab_name].transform, "story_v_out_108111", "108111001", "story_v_out_108111.awb")

						arg_1_1:RecordAudio("108111001", var_4_19)
						arg_1_1:RecordAudio("108111001", var_4_19)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_108111", "108111001", "story_v_out_108111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_108111", "108111001", "story_v_out_108111.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_11 + 0.3
			local var_4_21 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0805",
				changeDisplayLayer = false,
				needEase = false,
				duration = 6,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play108111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 108111002
		arg_8_1.duration_ = 6.9

		local var_8_0 = {
			ja = 6.766,
			ko = 3.866,
			zh = 5.9,
			en = 6.9
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play108111003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.7

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:GetWordFromCfg(108111002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 28 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 28)

				if (28 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 28)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111002", "story_v_out_108111.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_108111", "108111002", "story_v_out_108111.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_108111", "108111002", "story_v_out_108111.awb")

						arg_8_1:RecordAudio("108111002", var_11_6)
						arg_8_1:RecordAudio("108111002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_108111", "108111002", "story_v_out_108111.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_108111", "108111002", "story_v_out_108111.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play108111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 108111003
		arg_12_1.duration_ = 9.47

		local var_12_0 = {
			ja = 8.2,
			ko = 9.466,
			zh = 6.4,
			en = 6.2
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play108111004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.575

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[161].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:GetWordFromCfg(108111003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 23 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 23)

				if (23 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 23)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111003", "story_v_out_108111.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_108111", "108111003", "story_v_out_108111.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_108111", "108111003", "story_v_out_108111.awb")

						arg_12_1:RecordAudio("108111003", var_15_6)
						arg_12_1:RecordAudio("108111003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_108111", "108111003", "story_v_out_108111.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_108111", "108111003", "story_v_out_108111.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play108111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 108111004
		arg_16_1.duration_ = 6.43

		local var_16_0 = {
			ja = 6.433,
			ko = 5.6,
			zh = 6.333,
			en = 3.766
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play108111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.65

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[161].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:GetWordFromCfg(108111004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 26 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 26)

				if (26 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 26)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111004", "story_v_out_108111.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_108111", "108111004", "story_v_out_108111.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_108111", "108111004", "story_v_out_108111.awb")

						arg_16_1:RecordAudio("108111004", var_19_6)
						arg_16_1:RecordAudio("108111004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_108111", "108111004", "story_v_out_108111.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_108111", "108111004", "story_v_out_108111.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play108111005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 108111005
		arg_20_1.duration_ = 4.43

		local var_20_0 = {
			ja = 0.833,
			ko = 0.6,
			zh = 4.433,
			en = 1
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play108111006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.05

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:GetWordFromCfg(108111005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 2 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 2)

				if (2 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 2)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111005", "story_v_out_108111.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_108111", "108111005", "story_v_out_108111.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_108111", "108111005", "story_v_out_108111.awb")

						arg_20_1:RecordAudio("108111005", var_23_6)
						arg_20_1:RecordAudio("108111005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_108111", "108111005", "story_v_out_108111.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_108111", "108111005", "story_v_out_108111.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play108111006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 108111006
		arg_24_1.duration_ = 5.63

		local var_24_0 = {
			ja = 5.233,
			ko = 5.633,
			zh = 5.6,
			en = 5.566
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play108111007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.625

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_1 = arg_24_1:GetWordFromCfg(108111006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 25 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 25)

				if (25 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 25)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111006", "story_v_out_108111.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_108111", "108111006", "story_v_out_108111.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_108111", "108111006", "story_v_out_108111.awb")

						arg_24_1:RecordAudio("108111006", var_27_6)
						arg_24_1:RecordAudio("108111006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_108111", "108111006", "story_v_out_108111.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_108111", "108111006", "story_v_out_108111.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play108111007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 108111007
		arg_28_1.duration_ = 2.1

		local var_28_0 = {
			ja = 2.1,
			ko = 1.1,
			zh = 1.4,
			en = 1.233
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play108111008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.075

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[161].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:GetWordFromCfg(108111007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 3 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 3)

				if (3 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 3)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111007", "story_v_out_108111.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_108111", "108111007", "story_v_out_108111.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_108111", "108111007", "story_v_out_108111.awb")

						arg_28_1:RecordAudio("108111007", var_31_6)
						arg_28_1:RecordAudio("108111007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_108111", "108111007", "story_v_out_108111.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_108111", "108111007", "story_v_out_108111.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play108111008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 108111008
		arg_32_1.duration_ = 13.07

		local var_32_0 = {
			ja = 13.066,
			ko = 9.1,
			zh = 10.1,
			en = 12.4
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play108111009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.875

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[161].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:GetWordFromCfg(108111008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 35 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 35)

				if (35 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 35)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111008", "story_v_out_108111.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_108111", "108111008", "story_v_out_108111.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_108111", "108111008", "story_v_out_108111.awb")

						arg_32_1:RecordAudio("108111008", var_35_6)
						arg_32_1:RecordAudio("108111008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_108111", "108111008", "story_v_out_108111.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_108111", "108111008", "story_v_out_108111.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play108111009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 108111009
		arg_36_1.duration_ = 4.43

		local var_36_0 = {
			ja = 1.6,
			ko = 0.6,
			zh = 4.433,
			en = 2.833
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play108111010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.05

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:GetWordFromCfg(108111009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 2 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 2)

				if (2 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 2)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111009", "story_v_out_108111.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_108111", "108111009", "story_v_out_108111.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_108111", "108111009", "story_v_out_108111.awb")

						arg_36_1:RecordAudio("108111009", var_39_6)
						arg_36_1:RecordAudio("108111009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_108111", "108111009", "story_v_out_108111.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_108111", "108111009", "story_v_out_108111.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play108111010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 108111010
		arg_40_1.duration_ = 2.8

		local var_40_0 = {
			ja = 1.7,
			ko = 2.466,
			zh = 2.333,
			en = 2.8
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
				arg_40_0:Play108111011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.2

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:GetWordFromCfg(108111010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 8 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 8)

				if (8 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 8)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111010", "story_v_out_108111.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_108111", "108111010", "story_v_out_108111.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_108111", "108111010", "story_v_out_108111.awb")

						arg_40_1:RecordAudio("108111010", var_43_6)
						arg_40_1:RecordAudio("108111010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_108111", "108111010", "story_v_out_108111.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_108111", "108111010", "story_v_out_108111.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play108111011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 108111011
		arg_44_1.duration_ = 16.9

		local var_44_0 = {
			ja = 16.9,
			ko = 9.233,
			zh = 9.466,
			en = 7.3
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
				arg_44_0:Play108111012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.625

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[161].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:GetWordFromCfg(108111011)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 25 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 25)

				if (25 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 25)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111011", "story_v_out_108111.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_108111", "108111011", "story_v_out_108111.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_108111", "108111011", "story_v_out_108111.awb")

						arg_44_1:RecordAudio("108111011", var_47_6)
						arg_44_1:RecordAudio("108111011", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_108111", "108111011", "story_v_out_108111.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_108111", "108111011", "story_v_out_108111.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play108111012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 108111012
		arg_48_1.duration_ = 7.33

		local var_48_0 = {
			ja = 6.366,
			ko = 6.1,
			zh = 6.566,
			en = 7.333
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
				arg_48_0:Play108111013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.575

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[161].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:GetWordFromCfg(108111012)
				local var_51_2 = arg_48_1:FormatText(var_51_1.content)

				arg_48_1.text_.text = var_51_2

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 23 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 23)

				if (23 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 23)) > 0 and var_51_0 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + 0
					end
				end

				arg_48_1.text_.text = var_51_2
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111012", "story_v_out_108111.awb") ~= 0 then
					local var_51_5 = manager.audio:GetVoiceLength("story_v_out_108111", "108111012", "story_v_out_108111.awb") / 1000

					if var_51_5 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + 0
					end

					if var_51_1.prefab_name ~= "" and arg_48_1.actors_[var_51_1.prefab_name] ~= nil then
						local var_51_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_1.prefab_name].transform, "story_v_out_108111", "108111012", "story_v_out_108111.awb")

						arg_48_1:RecordAudio("108111012", var_51_6)
						arg_48_1:RecordAudio("108111012", var_51_6)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_108111", "108111012", "story_v_out_108111.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_108111", "108111012", "story_v_out_108111.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play108111013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 108111013
		arg_52_1.duration_ = 5.37

		local var_52_0 = {
			ja = 5.366,
			ko = 2.966,
			zh = 5.1,
			en = 5.2
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
				arg_52_0:Play108111014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.45

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:GetWordFromCfg(108111013)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 18 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 18)

				if (18 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 18)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111013", "story_v_out_108111.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_out_108111", "108111013", "story_v_out_108111.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_out_108111", "108111013", "story_v_out_108111.awb")

						arg_52_1:RecordAudio("108111013", var_55_6)
						arg_52_1:RecordAudio("108111013", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_108111", "108111013", "story_v_out_108111.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_108111", "108111013", "story_v_out_108111.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play108111014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 108111014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play108111015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:AudioAction("play", "effect", "se_story_8", "se_story_8_door", "")
			end

			local var_59_1 = 0
			local var_59_2 = 0.35

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_3 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(108111014).content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 14 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 14)

				if (14 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 14)) > 0 and var_59_2 < var_59_5 then
					arg_56_1.talkMaxDuration = var_59_5

					if var_59_5 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_6 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_6 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_6

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_6 and arg_56_1.time_ < var_59_1 + var_59_6 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play108111015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 108111015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play108111016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.775

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(108111015).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 31 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 31)

				if (31 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 31)) > 0 and var_63_0 < var_63_3 then
					arg_60_1.talkMaxDuration = var_63_3

					if var_63_3 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_3 + 0
					end
				end

				arg_60_1.text_.text = var_63_1
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_4 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_4

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play108111016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 108111016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play108111017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 1.25

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_1 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(108111016).content)

				arg_64_1.text_.text = var_67_1

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_3 = 50 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 50)

				if (50 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 50)) > 0 and var_67_0 < var_67_3 then
					arg_64_1.talkMaxDuration = var_67_3

					if var_67_3 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_3 + 0
					end
				end

				arg_64_1.text_.text = var_67_1
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_4 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_4

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play108111017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 108111017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play108111018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.525

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(108111017).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 21 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 21)

				if (21 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 21)) > 0 and var_71_0 < var_71_3 then
					arg_68_1.talkMaxDuration = var_71_3

					if var_71_3 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_3 + 0
					end
				end

				arg_68_1.text_.text = var_71_1
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_4 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_4

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play108111018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 108111018
		arg_72_1.duration_ = 13.17

		local var_72_0 = {
			ja = 12.6333333333333,
			ko = 9.83333333333333,
			zh = 13.1663333333333,
			en = 12.7333333333333
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play108111019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				local var_75_0 = arg_72_1.bgs_.S0805:GetComponent("SpriteRenderer")

				if var_75_0 then
					arg_72_1.var_.alphaOldValueS0805 = var_75_0.color.a
					arg_72_1.var_.alphaMatValueS0805 = var_75_0
				end

				arg_72_1.var_.alphaOldValueS0805 = 1
			end

			local var_75_1 = 1.5

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_1 then
				if arg_72_1.var_.alphaMatValueS0805 then
					arg_72_1.var_.alphaMatValueS0805.color.a = Mathf.Lerp(arg_72_1.var_.alphaOldValueS0805, 0, (arg_72_1.time_ - 0) / var_75_1)
					arg_72_1.var_.alphaMatValueS0805.color = arg_72_1.var_.alphaMatValueS0805.color
				end
			end

			if arg_72_1.time_ >= 0 + var_75_1 and arg_72_1.time_ < 0 + var_75_1 + arg_75_0 and arg_72_1.var_.alphaMatValueS0805 then
				arg_72_1.var_.alphaMatValueS0805.color.a = 0
				arg_72_1.var_.alphaMatValueS0805.color = arg_72_1.var_.alphaMatValueS0805.color
			end

			local var_75_2 = 1.33333333333333
			local var_75_3 = 0.85

			if 1.33333333333333 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_4 = arg_72_1:GetWordFromCfg(108111018)
				local var_75_5 = arg_72_1:FormatText(var_75_4.content)

				arg_72_1.text_.text = var_75_5

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 32 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 32)

				if (32 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 32)) > 0 and var_75_3 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_2
					end
				end

				arg_72_1.text_.text = var_75_5
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111018", "story_v_out_108111.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_108111", "108111018", "story_v_out_108111.awb") / 1000

					if var_75_8 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_2
					end

					if var_75_4.prefab_name ~= "" and arg_72_1.actors_[var_75_4.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_4.prefab_name].transform, "story_v_out_108111", "108111018", "story_v_out_108111.awb")

						arg_72_1:RecordAudio("108111018", var_75_9)
						arg_72_1:RecordAudio("108111018", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_108111", "108111018", "story_v_out_108111.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_108111", "108111018", "story_v_out_108111.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_3, arg_72_1.talkMaxDuration)

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_2) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_2 + var_75_10 and arg_72_1.time_ < var_75_2 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play108111019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 108111019
		arg_76_1.duration_ = 6.07

		local var_76_0 = {
			ja = 6.066,
			ko = 3.366,
			zh = 5.5,
			en = 5.2
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play108111020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if arg_76_1.bgs_.C05b == nil then
				local var_79_0 = Object.Instantiate(arg_76_1.paintGo_)

				var_79_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C05b")
				var_79_0.name = "C05b"
				var_79_0.transform.parent = arg_76_1.stage_.transform
				var_79_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.bgs_.C05b = var_79_0
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				local var_79_1 = arg_76_1.bgs_.C05b

				arg_76_1.bgs_.C05b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_79_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_2 = var_79_1:GetComponent("SpriteRenderer")

				if var_79_2 and var_79_2.sprite then
					local var_79_3 = 2 * (var_79_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_79_1.transform.localScale = Vector3.New(var_79_3 / var_79_2.sprite.bounds.size.y < var_79_3 * manager.ui.mainCameraCom_.aspect / var_79_2.sprite.bounds.size.x and var_79_3 * manager.ui.mainCameraCom_.aspect / var_79_2.sprite.bounds.size.x or var_79_3 / var_79_2.sprite.bounds.size.y, var_79_3 / var_79_2.sprite.bounds.size.y < var_79_3 * manager.ui.mainCameraCom_.aspect / var_79_2.sprite.bounds.size.x and var_79_3 * manager.ui.mainCameraCom_.aspect / var_79_2.sprite.bounds.size.x or var_79_3 / var_79_2.sprite.bounds.size.y, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "C05b" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				local var_79_4 = arg_76_1.bgs_.C05b:GetComponent("SpriteRenderer")

				if var_79_4 then
					arg_76_1.var_.alphaOldValueC05b = var_79_4.color.a
					arg_76_1.var_.alphaMatValueC05b = var_79_4
				end

				arg_76_1.var_.alphaOldValueC05b = 0
			end

			local var_79_5 = 1.5

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_5 then
				if arg_76_1.var_.alphaMatValueC05b then
					arg_76_1.var_.alphaMatValueC05b.color.a = Mathf.Lerp(arg_76_1.var_.alphaOldValueC05b, 1, (arg_76_1.time_ - 0) / var_79_5)
					arg_76_1.var_.alphaMatValueC05b.color = arg_76_1.var_.alphaMatValueC05b.color
				end
			end

			if arg_76_1.time_ >= 0 + var_79_5 and arg_76_1.time_ < 0 + var_79_5 + arg_79_0 and arg_76_1.var_.alphaMatValueC05b then
				arg_76_1.var_.alphaMatValueC05b.color.a = 1
				arg_76_1.var_.alphaMatValueC05b.color = arg_76_1.var_.alphaMatValueC05b.color
			end

			local var_79_6 = "4015_tpose"

			if arg_76_1.actors_["4015_tpose"] == nil and not isNil((Asset.Load("Char/" .. "4015_tpose"))) then
				local var_79_7 = Object.Instantiate(Asset.Load("Char/" .. "4015_tpose"), arg_76_1.stage_.transform)

				var_79_7.name = var_79_6
				var_79_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.actors_[var_79_6] = var_79_7

				local var_79_8 = var_79_7:GetComponentInChildren(typeof(CharacterEffect))

				var_79_8.enabled = true

				local var_79_9 = GameObjectTools.GetOrAddComponent(var_79_7, typeof(DynamicBoneHelper))

				if var_79_9 then
					var_79_9:EnableDynamicBone(false)
				end

				arg_76_1:ShowWeapon(var_79_8.transform, false)

				arg_76_1.var_[var_79_6 .. "Animator"] = var_79_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_76_1.var_[var_79_6 .. "Animator"].applyRootMotion = true
				arg_76_1.var_[var_79_6 .. "LipSync"] = var_79_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_79_10 = arg_76_1.actors_["4015_tpose"].transform

			if 2 < arg_76_1.time_ and arg_76_1.time_ <= 2 + arg_79_0 then
				arg_76_1.var_.moveOldPos4015_tpose = var_79_10.localPosition

				local var_79_11 = GameObjectTools.GetOrAddComponent(var_79_10.gameObject, typeof(DynamicBoneHelper))

				if var_79_11 then
					var_79_11:EnableDynamicBone(false)
				end
			end

			local var_79_12 = 0.001

			if 2 <= arg_76_1.time_ and arg_76_1.time_ < 2 + var_79_12 then
				var_79_10.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos4015_tpose, Vector3.New(0, -2.65, -2), (arg_76_1.time_ - 2) / var_79_12)
				var_79_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_10.position).x, (manager.ui.mainCamera.transform.position - var_79_10.position).y, (manager.ui.mainCamera.transform.position - var_79_10.position).z)
				var_79_10.localEulerAngles.z = 0
				var_79_10.localEulerAngles.x = 0
				var_79_10.localEulerAngles = var_79_10.localEulerAngles
			end

			if arg_76_1.time_ >= 2 + var_79_12 and arg_76_1.time_ < 2 + var_79_12 + arg_79_0 then
				var_79_10.localPosition = Vector3.New(0, -2.65, -2)
				var_79_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_10.position).x, (manager.ui.mainCamera.transform.position - var_79_10.position).y, (manager.ui.mainCamera.transform.position - var_79_10.position).z)
				var_79_10.localEulerAngles.z = 0
				var_79_10.localEulerAngles.x = 0
				var_79_10.localEulerAngles = var_79_10.localEulerAngles

				local var_79_13 = GameObjectTools.GetOrAddComponent(var_79_10.gameObject, typeof(DynamicBoneHelper))

				if var_79_13 then
					var_79_13:EnableDynamicBone(true)
				end
			end

			local var_79_14 = arg_76_1.actors_["4015_tpose"]

			if 2 < arg_76_1.time_ and arg_76_1.time_ <= 2 + arg_79_0 and not isNil(var_79_14) and arg_76_1.var_.characterEffect4015_tpose == nil then
				arg_76_1.var_.characterEffect4015_tpose = var_79_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_15 = 0.2

			if 2 <= arg_76_1.time_ and arg_76_1.time_ < 2 + var_79_15 and not isNil(var_79_14) then
				if arg_76_1.var_.characterEffect4015_tpose and not isNil(var_79_14) then
					arg_76_1.var_.characterEffect4015_tpose.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 2 + var_79_15 and arg_76_1.time_ < 2 + var_79_15 + arg_79_0 and not isNil(var_79_14) and arg_76_1.var_.characterEffect4015_tpose then
				arg_76_1.var_.characterEffect4015_tpose.fillFlat = false
			end

			if 2 < arg_76_1.time_ and arg_76_1.time_ <= 2 + arg_79_0 then
				arg_76_1:PlayTimeline("4015_tpose", "StoryTimeline/CharAction/story4015/story4015action/4015action1_1")
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_17 = 2
			local var_79_18 = 0.175

			if 2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_17 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_19 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_19:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_20 = arg_76_1:GetWordFromCfg(108111019)
				local var_79_21 = arg_76_1:FormatText(var_79_20.content)

				arg_76_1.text_.text = var_79_21

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_23 = 7 <= 0 and var_79_18 or var_79_18 * (utf8.len(var_79_21) / 7)

				if (7 <= 0 and var_79_18 or var_79_18 * (utf8.len(var_79_21) / 7)) > 0 and var_79_18 < var_79_23 then
					arg_76_1.talkMaxDuration = var_79_23
					var_79_17 = var_79_17 + 0.3

					if var_79_23 + var_79_17 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_23 + var_79_17
					end
				end

				arg_76_1.text_.text = var_79_21
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111019", "story_v_out_108111.awb") ~= 0 then
					local var_79_24 = manager.audio:GetVoiceLength("story_v_out_108111", "108111019", "story_v_out_108111.awb") / 1000

					if var_79_24 + var_79_17 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_24 + var_79_17
					end

					if var_79_20.prefab_name ~= "" and arg_76_1.actors_[var_79_20.prefab_name] ~= nil then
						local var_79_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_20.prefab_name].transform, "story_v_out_108111", "108111019", "story_v_out_108111.awb")

						arg_76_1:RecordAudio("108111019", var_79_25)
						arg_76_1:RecordAudio("108111019", var_79_25)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_108111", "108111019", "story_v_out_108111.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_108111", "108111019", "story_v_out_108111.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_26 = var_79_17 + 0.3
			local var_79_27 = math.max(var_79_18, arg_76_1.talkMaxDuration)

			if var_79_17 + 0.3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_26 + var_79_27 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_26) / var_79_27

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_26 + var_79_27 and arg_76_1.time_ < var_79_26 + var_79_27 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4015_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play108111020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 108111020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play108111021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos4015_tpose = arg_82_1.actors_["4015_tpose"].transform.localPosition

				local var_85_0 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["4015_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_0 then
					var_85_0:EnableDynamicBone(false)
				end
			end

			local var_85_1 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_1 then
				arg_82_1.actors_["4015_tpose"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos4015_tpose, Vector3.New(0, 100, 0), (arg_82_1.time_ - 0) / var_85_1)
				arg_82_1.actors_["4015_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["4015_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["4015_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["4015_tpose"].transform.position).z)
				arg_82_1.actors_["4015_tpose"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["4015_tpose"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["4015_tpose"].transform.localEulerAngles = arg_82_1.actors_["4015_tpose"].transform.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_1 and arg_82_1.time_ < 0 + var_85_1 + arg_85_0 then
				arg_82_1.actors_["4015_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_82_1.actors_["4015_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["4015_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["4015_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["4015_tpose"].transform.position).z)
				arg_82_1.actors_["4015_tpose"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["4015_tpose"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["4015_tpose"].transform.localEulerAngles = arg_82_1.actors_["4015_tpose"].transform.localEulerAngles

				local var_85_2 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["4015_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(true)
				end
			end

			local var_85_3 = 0
			local var_85_4 = 0.825

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_3 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_5 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(108111020).content)

				arg_82_1.text_.text = var_85_5

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_7 = 33 <= 0 and var_85_4 or var_85_4 * (utf8.len(var_85_5) / 33)

				if (33 <= 0 and var_85_4 or var_85_4 * (utf8.len(var_85_5) / 33)) > 0 and var_85_4 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_3 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_3
					end
				end

				arg_82_1.text_.text = var_85_5
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_8 = math.max(var_85_4, arg_82_1.talkMaxDuration)

			if var_85_3 <= arg_82_1.time_ and arg_82_1.time_ < var_85_3 + var_85_8 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_3) / var_85_8

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_3 + var_85_8 and arg_82_1.time_ < var_85_3 + var_85_8 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4015_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play108111021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 108111021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play108111022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:AudioAction("play", "effect", "se_story_8", "se_story_8_jingyu", "")
			end

			local var_89_1 = 0
			local var_89_2 = 1.075

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_3 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(108111021).content)

				arg_86_1.text_.text = var_89_3

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 43 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 43)

				if (43 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 43)) > 0 and var_89_2 < var_89_5 then
					arg_86_1.talkMaxDuration = var_89_5

					if var_89_5 + var_89_1 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + var_89_1
					end
				end

				arg_86_1.text_.text = var_89_3
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_6 = math.max(var_89_2, arg_86_1.talkMaxDuration)

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_6 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_1) / var_89_6

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_1 + var_89_6 and arg_86_1.time_ < var_89_1 + var_89_6 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play108111022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 108111022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play108111023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.825

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(108111022).content)

				arg_90_1.text_.text = var_93_1

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_3 = 33 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 33)

				if (33 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 33)) > 0 and var_93_0 < var_93_3 then
					arg_90_1.talkMaxDuration = var_93_3

					if var_93_3 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_3 + 0
					end
				end

				arg_90_1.text_.text = var_93_1
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_4 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_4

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play108111023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 108111023
		arg_94_1.duration_ = 2.4

		local var_94_0 = {
			ja = 2.4,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_94_0:Play108111024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if arg_94_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_97_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_94_1.stage_.transform)

				var_97_0.name = "1084ui_story"
				var_97_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.actors_["1084ui_story"] = var_97_0

				local var_97_1 = var_97_0:GetComponentInChildren(typeof(CharacterEffect))

				var_97_1.enabled = true

				local var_97_2 = GameObjectTools.GetOrAddComponent(var_97_0, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(false)
				end

				arg_94_1:ShowWeapon(var_97_1.transform, false)

				arg_94_1.var_["1084ui_story" .. "Animator"] = var_97_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_94_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_94_1.var_["1084ui_story" .. "LipSync"] = var_97_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_97_3 = arg_94_1.actors_["1084ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1084ui_story = var_97_3.localPosition
			end

			local var_97_4 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				var_97_3.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_94_1.time_ - 0) / var_97_4)
				var_97_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_3.position).x, (manager.ui.mainCamera.transform.position - var_97_3.position).y, (manager.ui.mainCamera.transform.position - var_97_3.position).z)
				var_97_3.localEulerAngles.z = 0
				var_97_3.localEulerAngles.x = 0
				var_97_3.localEulerAngles = var_97_3.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				var_97_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_97_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_3.position).x, (manager.ui.mainCamera.transform.position - var_97_3.position).y, (manager.ui.mainCamera.transform.position - var_97_3.position).z)
				var_97_3.localEulerAngles.z = 0
				var_97_3.localEulerAngles.x = 0
				var_97_3.localEulerAngles = var_97_3.localEulerAngles
			end

			local var_97_5 = arg_94_1.actors_["1084ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_5) and arg_94_1.var_.characterEffect1084ui_story == nil then
				arg_94_1.var_.characterEffect1084ui_story = var_97_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_6 and not isNil(var_97_5) then
				if arg_94_1.var_.characterEffect1084ui_story and not isNil(var_97_5) then
					arg_94_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_6 and arg_94_1.time_ < 0 + var_97_6 + arg_97_0 and not isNil(var_97_5) and arg_94_1.var_.characterEffect1084ui_story then
				arg_94_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_97_8 = 0
			local var_97_9 = 0.15

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_10 = arg_94_1:GetWordFromCfg(108111023)
				local var_97_11 = arg_94_1:FormatText(var_97_10.content)

				arg_94_1.text_.text = var_97_11

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_13 = 6 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 6)

				if (6 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 6)) > 0 and var_97_9 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_11
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111023", "story_v_out_108111.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_108111", "108111023", "story_v_out_108111.awb") / 1000

					if var_97_14 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_8
					end

					if var_97_10.prefab_name ~= "" and arg_94_1.actors_[var_97_10.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_10.prefab_name].transform, "story_v_out_108111", "108111023", "story_v_out_108111.awb")

						arg_94_1:RecordAudio("108111023", var_97_15)
						arg_94_1:RecordAudio("108111023", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_108111", "108111023", "story_v_out_108111.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_108111", "108111023", "story_v_out_108111.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_16 and arg_94_1.time_ < var_97_8 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play108111024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 108111024
		arg_98_1.duration_ = 8.97

		local var_98_0 = {
			ja = 7.466,
			ko = 8.966,
			zh = 7.6,
			en = 6.466
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
				arg_98_0:Play108111025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if arg_98_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_101_0 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_98_1.stage_.transform)

				var_101_0.name = "1038ui_story"
				var_101_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.actors_["1038ui_story"] = var_101_0

				local var_101_1 = var_101_0:GetComponentInChildren(typeof(CharacterEffect))

				var_101_1.enabled = true

				local var_101_2 = GameObjectTools.GetOrAddComponent(var_101_0, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(false)
				end

				arg_98_1:ShowWeapon(var_101_1.transform, false)

				arg_98_1.var_["1038ui_story" .. "Animator"] = var_101_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_98_1.var_["1038ui_story" .. "Animator"].applyRootMotion = true
				arg_98_1.var_["1038ui_story" .. "LipSync"] = var_101_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_101_3 = arg_98_1.actors_["1038ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1038ui_story = var_101_3.localPosition
			end

			local var_101_4 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				var_101_3.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_98_1.time_ - 0) / var_101_4)
				var_101_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_3.position).x, (manager.ui.mainCamera.transform.position - var_101_3.position).y, (manager.ui.mainCamera.transform.position - var_101_3.position).z)
				var_101_3.localEulerAngles.z = 0
				var_101_3.localEulerAngles.x = 0
				var_101_3.localEulerAngles = var_101_3.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				var_101_3.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_101_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_3.position).x, (manager.ui.mainCamera.transform.position - var_101_3.position).y, (manager.ui.mainCamera.transform.position - var_101_3.position).z)
				var_101_3.localEulerAngles.z = 0
				var_101_3.localEulerAngles.x = 0
				var_101_3.localEulerAngles = var_101_3.localEulerAngles
			end

			local var_101_5 = arg_98_1.actors_["1038ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_5) and arg_98_1.var_.characterEffect1038ui_story == nil then
				arg_98_1.var_.characterEffect1038ui_story = var_101_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_6 and not isNil(var_101_5) then
				if arg_98_1.var_.characterEffect1038ui_story and not isNil(var_101_5) then
					arg_98_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_6 and arg_98_1.time_ < 0 + var_101_6 + arg_101_0 and not isNil(var_101_5) and arg_98_1.var_.characterEffect1038ui_story then
				arg_98_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_101_8 = arg_98_1.actors_["1084ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_8) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = var_101_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_9 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_9 and not isNil(var_101_8) then
				if arg_98_1.var_.characterEffect1084ui_story and not isNil(var_101_8) then
					arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_9)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_9 and arg_98_1.time_ < 0 + var_101_9 + arg_101_0 and not isNil(var_101_8) and arg_98_1.var_.characterEffect1084ui_story then
				arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_101_10 = 0
			local var_101_11 = 0.8

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_12 = arg_98_1:GetWordFromCfg(108111024)
				local var_101_13 = arg_98_1:FormatText(var_101_12.content)

				arg_98_1.text_.text = var_101_13

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_15 = 32 <= 0 and var_101_11 or var_101_11 * (utf8.len(var_101_13) / 32)

				if (32 <= 0 and var_101_11 or var_101_11 * (utf8.len(var_101_13) / 32)) > 0 and var_101_11 < var_101_15 then
					arg_98_1.talkMaxDuration = var_101_15

					if var_101_15 + var_101_10 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_15 + var_101_10
					end
				end

				arg_98_1.text_.text = var_101_13
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111024", "story_v_out_108111.awb") ~= 0 then
					local var_101_16 = manager.audio:GetVoiceLength("story_v_out_108111", "108111024", "story_v_out_108111.awb") / 1000

					if var_101_16 + var_101_10 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_16 + var_101_10
					end

					if var_101_12.prefab_name ~= "" and arg_98_1.actors_[var_101_12.prefab_name] ~= nil then
						local var_101_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_12.prefab_name].transform, "story_v_out_108111", "108111024", "story_v_out_108111.awb")

						arg_98_1:RecordAudio("108111024", var_101_17)
						arg_98_1:RecordAudio("108111024", var_101_17)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_108111", "108111024", "story_v_out_108111.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_108111", "108111024", "story_v_out_108111.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_18 = math.max(var_101_11, arg_98_1.talkMaxDuration)

			if var_101_10 <= arg_98_1.time_ and arg_98_1.time_ < var_101_10 + var_101_18 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_10) / var_101_18

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_10 + var_101_18 and arg_98_1.time_ < var_101_10 + var_101_18 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play108111025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 108111025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play108111026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1084ui_story = arg_102_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1084ui_story"].transform.position).z)
				arg_102_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1084ui_story"].transform.localEulerAngles = arg_102_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_102_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1084ui_story"].transform.position).z)
				arg_102_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1084ui_story"].transform.localEulerAngles = arg_102_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_105_1 = arg_102_1.actors_["1038ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1038ui_story = var_105_1.localPosition
			end

			local var_105_2 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 then
				var_105_1.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_2)
				var_105_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_1.position).x, (manager.ui.mainCamera.transform.position - var_105_1.position).y, (manager.ui.mainCamera.transform.position - var_105_1.position).z)
				var_105_1.localEulerAngles.z = 0
				var_105_1.localEulerAngles.x = 0
				var_105_1.localEulerAngles = var_105_1.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 then
				var_105_1.localPosition = Vector3.New(0, 100, 0)
				var_105_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_1.position).x, (manager.ui.mainCamera.transform.position - var_105_1.position).y, (manager.ui.mainCamera.transform.position - var_105_1.position).z)
				var_105_1.localEulerAngles.z = 0
				var_105_1.localEulerAngles.x = 0
				var_105_1.localEulerAngles = var_105_1.localEulerAngles
			end

			local var_105_3 = 0
			local var_105_4 = 0.775

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_3 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_5 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(108111025).content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 31 <= 0 and var_105_4 or var_105_4 * (utf8.len(var_105_5) / 31)

				if (31 <= 0 and var_105_4 or var_105_4 * (utf8.len(var_105_5) / 31)) > 0 and var_105_4 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_3 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_3
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_8 = math.max(var_105_4, arg_102_1.talkMaxDuration)

			if var_105_3 <= arg_102_1.time_ and arg_102_1.time_ < var_105_3 + var_105_8 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_3) / var_105_8

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_3 + var_105_8 and arg_102_1.time_ < var_105_3 + var_105_8 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play108111026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 108111026
		arg_106_1.duration_ = 7

		local var_106_0 = {
			ja = 7,
			ko = 4.4,
			zh = 5,
			en = 6.433
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
				arg_106_0:Play108111027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1084ui_story = arg_106_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_109_0 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				arg_106_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_106_1.time_ - 0) / var_109_0)
				arg_106_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1084ui_story"].transform.position).z)
				arg_106_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1084ui_story"].transform.localEulerAngles = arg_106_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				arg_106_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_106_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1084ui_story"].transform.position).z)
				arg_106_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1084ui_story"].transform.localEulerAngles = arg_106_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_109_1 = arg_106_1.actors_["1084ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect1084ui_story == nil then
				arg_106_1.var_.characterEffect1084ui_story = var_109_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_2 and not isNil(var_109_1) then
				if arg_106_1.var_.characterEffect1084ui_story and not isNil(var_109_1) then
					arg_106_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_2 and arg_106_1.time_ < 0 + var_109_2 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect1084ui_story then
				arg_106_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 5.89805981832114e-17 < arg_106_1.time_ and arg_106_1.time_ <= 5.89805981832114e-17 + arg_109_0 then
				arg_106_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_109_4 = 0
			local var_109_5 = 0.35

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_6 = arg_106_1:GetWordFromCfg(108111026)
				local var_109_7 = arg_106_1:FormatText(var_109_6.content)

				arg_106_1.text_.text = var_109_7

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 14 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 14)

				if (14 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 14)) > 0 and var_109_5 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_7
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111026", "story_v_out_108111.awb") ~= 0 then
					local var_109_10 = manager.audio:GetVoiceLength("story_v_out_108111", "108111026", "story_v_out_108111.awb") / 1000

					if var_109_10 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_4
					end

					if var_109_6.prefab_name ~= "" and arg_106_1.actors_[var_109_6.prefab_name] ~= nil then
						local var_109_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_6.prefab_name].transform, "story_v_out_108111", "108111026", "story_v_out_108111.awb")

						arg_106_1:RecordAudio("108111026", var_109_11)
						arg_106_1:RecordAudio("108111026", var_109_11)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_108111", "108111026", "story_v_out_108111.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_108111", "108111026", "story_v_out_108111.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_12 = math.max(var_109_5, arg_106_1.talkMaxDuration)

			if var_109_4 <= arg_106_1.time_ and arg_106_1.time_ < var_109_4 + var_109_12 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_4) / var_109_12

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_4 + var_109_12 and arg_106_1.time_ < var_109_4 + var_109_12 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play108111027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 108111027
		arg_110_1.duration_ = 12.83

		local var_110_0 = {
			ja = 12.833,
			ko = 8.066,
			zh = 6.5,
			en = 7.466
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
				arg_110_0:Play108111028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1038ui_story = arg_110_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_113_0 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 then
				arg_110_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_110_1.time_ - 0) / var_113_0)
				arg_110_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1038ui_story"].transform.position).z)
				arg_110_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1038ui_story"].transform.localEulerAngles = arg_110_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 then
				arg_110_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.9)
				arg_110_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1038ui_story"].transform.position).z)
				arg_110_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1038ui_story"].transform.localEulerAngles = arg_110_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_113_1 = arg_110_1.actors_["1038ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect1038ui_story == nil then
				arg_110_1.var_.characterEffect1038ui_story = var_113_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_2 and not isNil(var_113_1) then
				if arg_110_1.var_.characterEffect1038ui_story and not isNil(var_113_1) then
					arg_110_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_2 and arg_110_1.time_ < 0 + var_113_2 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect1038ui_story then
				arg_110_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_113_4 = arg_110_1.actors_["1084ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect1084ui_story == nil then
				arg_110_1.var_.characterEffect1084ui_story = var_113_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_5 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_5 and not isNil(var_113_4) then
				if arg_110_1.var_.characterEffect1084ui_story and not isNil(var_113_4) then
					arg_110_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_5)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_5 and arg_110_1.time_ < 0 + var_113_5 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect1084ui_story then
				arg_110_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_113_6 = 0
			local var_113_7 = 0.8

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_8 = arg_110_1:GetWordFromCfg(108111027)
				local var_113_9 = arg_110_1:FormatText(var_113_8.content)

				arg_110_1.text_.text = var_113_9

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_11 = 32 <= 0 and var_113_7 or var_113_7 * (utf8.len(var_113_9) / 32)

				if (32 <= 0 and var_113_7 or var_113_7 * (utf8.len(var_113_9) / 32)) > 0 and var_113_7 < var_113_11 then
					arg_110_1.talkMaxDuration = var_113_11

					if var_113_11 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_11 + var_113_6
					end
				end

				arg_110_1.text_.text = var_113_9
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111027", "story_v_out_108111.awb") ~= 0 then
					local var_113_12 = manager.audio:GetVoiceLength("story_v_out_108111", "108111027", "story_v_out_108111.awb") / 1000

					if var_113_12 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_12 + var_113_6
					end

					if var_113_8.prefab_name ~= "" and arg_110_1.actors_[var_113_8.prefab_name] ~= nil then
						local var_113_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_8.prefab_name].transform, "story_v_out_108111", "108111027", "story_v_out_108111.awb")

						arg_110_1:RecordAudio("108111027", var_113_13)
						arg_110_1:RecordAudio("108111027", var_113_13)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_108111", "108111027", "story_v_out_108111.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_108111", "108111027", "story_v_out_108111.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_14 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_14 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_14

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_14 and arg_110_1.time_ < var_113_6 + var_113_14 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play108111028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 108111028
		arg_114_1.duration_ = 7.73

		local var_114_0 = {
			ja = 7.733,
			ko = 6.1,
			zh = 5.8,
			en = 5.566
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play108111029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_117_0 = 0
			local var_117_1 = 0.6

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_2 = arg_114_1:GetWordFromCfg(108111028)
				local var_117_3 = arg_114_1:FormatText(var_117_2.content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 24 <= 0 and var_117_1 or var_117_1 * (utf8.len(var_117_3) / 24)

				if (24 <= 0 and var_117_1 or var_117_1 * (utf8.len(var_117_3) / 24)) > 0 and var_117_1 < var_117_5 then
					arg_114_1.talkMaxDuration = var_117_5

					if var_117_5 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111028", "story_v_out_108111.awb") ~= 0 then
					local var_117_6 = manager.audio:GetVoiceLength("story_v_out_108111", "108111028", "story_v_out_108111.awb") / 1000

					if var_117_6 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_6 + var_117_0
					end

					if var_117_2.prefab_name ~= "" and arg_114_1.actors_[var_117_2.prefab_name] ~= nil then
						local var_117_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_2.prefab_name].transform, "story_v_out_108111", "108111028", "story_v_out_108111.awb")

						arg_114_1:RecordAudio("108111028", var_117_7)
						arg_114_1:RecordAudio("108111028", var_117_7)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_108111", "108111028", "story_v_out_108111.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_108111", "108111028", "story_v_out_108111.awb")
				end

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
	Play108111029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 108111029
		arg_118_1.duration_ = 5.63

		local var_118_0 = {
			ja = 5.633,
			ko = 4.566,
			zh = 3.566,
			en = 4.366
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
				arg_118_0:Play108111030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1038ui_story = arg_118_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_121_0 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 then
				arg_118_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_118_1.time_ - 0) / var_121_0)
				arg_118_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1038ui_story"].transform.position).z)
				arg_118_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1038ui_story"].transform.localEulerAngles = arg_118_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 then
				arg_118_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_118_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1038ui_story"].transform.position).z)
				arg_118_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1038ui_story"].transform.localEulerAngles = arg_118_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_121_1 = "1050ui_story"

			if arg_118_1.actors_["1050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1050ui_story"))) then
				local var_121_2 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_118_1.stage_.transform)

				var_121_2.name = var_121_1
				var_121_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_118_1.actors_[var_121_1] = var_121_2

				local var_121_3 = var_121_2:GetComponentInChildren(typeof(CharacterEffect))

				var_121_3.enabled = true

				local var_121_4 = GameObjectTools.GetOrAddComponent(var_121_2, typeof(DynamicBoneHelper))

				if var_121_4 then
					var_121_4:EnableDynamicBone(false)
				end

				arg_118_1:ShowWeapon(var_121_3.transform, false)

				arg_118_1.var_[var_121_1 .. "Animator"] = var_121_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_118_1.var_[var_121_1 .. "Animator"].applyRootMotion = true
				arg_118_1.var_[var_121_1 .. "LipSync"] = var_121_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_121_5 = arg_118_1.actors_["1050ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1050ui_story = var_121_5.localPosition
			end

			local var_121_6 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_6 then
				var_121_5.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_118_1.time_ - 0) / var_121_6)
				var_121_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_5.position).x, (manager.ui.mainCamera.transform.position - var_121_5.position).y, (manager.ui.mainCamera.transform.position - var_121_5.position).z)
				var_121_5.localEulerAngles.z = 0
				var_121_5.localEulerAngles.x = 0
				var_121_5.localEulerAngles = var_121_5.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_6 and arg_118_1.time_ < 0 + var_121_6 + arg_121_0 then
				var_121_5.localPosition = Vector3.New(0, -1, -6.1)
				var_121_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_5.position).x, (manager.ui.mainCamera.transform.position - var_121_5.position).y, (manager.ui.mainCamera.transform.position - var_121_5.position).z)
				var_121_5.localEulerAngles.z = 0
				var_121_5.localEulerAngles.x = 0
				var_121_5.localEulerAngles = var_121_5.localEulerAngles
			end

			local var_121_7 = arg_118_1.actors_["1050ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_7) and arg_118_1.var_.characterEffect1050ui_story == nil then
				arg_118_1.var_.characterEffect1050ui_story = var_121_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_8 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_8 and not isNil(var_121_7) then
				if arg_118_1.var_.characterEffect1050ui_story and not isNil(var_121_7) then
					arg_118_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_8 and arg_118_1.time_ < 0 + var_121_8 + arg_121_0 and not isNil(var_121_7) and arg_118_1.var_.characterEffect1050ui_story then
				arg_118_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_121_10 = arg_118_1.actors_["1084ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1084ui_story = var_121_10.localPosition
			end

			local var_121_11 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_11 then
				var_121_10.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_118_1.time_ - 0) / var_121_11)
				var_121_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_10.position).x, (manager.ui.mainCamera.transform.position - var_121_10.position).y, (manager.ui.mainCamera.transform.position - var_121_10.position).z)
				var_121_10.localEulerAngles.z = 0
				var_121_10.localEulerAngles.x = 0
				var_121_10.localEulerAngles = var_121_10.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_11 and arg_118_1.time_ < 0 + var_121_11 + arg_121_0 then
				var_121_10.localPosition = Vector3.New(0, 100, 0)
				var_121_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_10.position).x, (manager.ui.mainCamera.transform.position - var_121_10.position).y, (manager.ui.mainCamera.transform.position - var_121_10.position).z)
				var_121_10.localEulerAngles.z = 0
				var_121_10.localEulerAngles.x = 0
				var_121_10.localEulerAngles = var_121_10.localEulerAngles
			end

			local var_121_12 = 0
			local var_121_13 = 0.425

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_12 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_14 = arg_118_1:GetWordFromCfg(108111029)
				local var_121_15 = arg_118_1:FormatText(var_121_14.content)

				arg_118_1.text_.text = var_121_15

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_17 = 17 <= 0 and var_121_13 or var_121_13 * (utf8.len(var_121_15) / 17)

				if (17 <= 0 and var_121_13 or var_121_13 * (utf8.len(var_121_15) / 17)) > 0 and var_121_13 < var_121_17 then
					arg_118_1.talkMaxDuration = var_121_17

					if var_121_17 + var_121_12 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_17 + var_121_12
					end
				end

				arg_118_1.text_.text = var_121_15
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111029", "story_v_out_108111.awb") ~= 0 then
					local var_121_18 = manager.audio:GetVoiceLength("story_v_out_108111", "108111029", "story_v_out_108111.awb") / 1000

					if var_121_18 + var_121_12 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_18 + var_121_12
					end

					if var_121_14.prefab_name ~= "" and arg_118_1.actors_[var_121_14.prefab_name] ~= nil then
						local var_121_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_14.prefab_name].transform, "story_v_out_108111", "108111029", "story_v_out_108111.awb")

						arg_118_1:RecordAudio("108111029", var_121_19)
						arg_118_1:RecordAudio("108111029", var_121_19)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_108111", "108111029", "story_v_out_108111.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_108111", "108111029", "story_v_out_108111.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_20 = math.max(var_121_13, arg_118_1.talkMaxDuration)

			if var_121_12 <= arg_118_1.time_ and arg_118_1.time_ < var_121_12 + var_121_20 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_12) / var_121_20

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_12 + var_121_20 and arg_118_1.time_ < var_121_12 + var_121_20 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
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

		arg_118_1:InitPlayNodeList()
	end,
	Play108111030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 108111030
		arg_122_1.duration_ = 4.83

		local var_122_0 = {
			ja = 4.233,
			ko = 3.666,
			zh = 3.6,
			en = 4.833
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
			arg_122_1.auto_ = false
		end

		function arg_122_1.playNext_(arg_124_0)
			arg_122_1.onStoryFinished_()
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1084ui_story"]) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = arg_122_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1084ui_story"]) then
				if arg_122_1.var_.characterEffect1084ui_story and not isNil(arg_122_1.actors_["1084ui_story"]) then
					arg_122_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1084ui_story"]) and arg_122_1.var_.characterEffect1084ui_story then
				arg_122_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_125_2 = arg_122_1.actors_["1050ui_story"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1050ui_story = var_125_2.localPosition
			end

			local var_125_3 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 then
				var_125_2.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_122_1.time_ - 0) / var_125_3)
				var_125_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_2.position).x, (manager.ui.mainCamera.transform.position - var_125_2.position).y, (manager.ui.mainCamera.transform.position - var_125_2.position).z)
				var_125_2.localEulerAngles.z = 0
				var_125_2.localEulerAngles.x = 0
				var_125_2.localEulerAngles = var_125_2.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 then
				var_125_2.localPosition = Vector3.New(0, 100, 0)
				var_125_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_2.position).x, (manager.ui.mainCamera.transform.position - var_125_2.position).y, (manager.ui.mainCamera.transform.position - var_125_2.position).z)
				var_125_2.localEulerAngles.z = 0
				var_125_2.localEulerAngles.x = 0
				var_125_2.localEulerAngles = var_125_2.localEulerAngles
			end

			local var_125_4 = arg_122_1.actors_["1084ui_story"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1084ui_story = var_125_4.localPosition
			end

			local var_125_5 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_5 then
				var_125_4.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_122_1.time_ - 0) / var_125_5)
				var_125_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_4.position).x, (manager.ui.mainCamera.transform.position - var_125_4.position).y, (manager.ui.mainCamera.transform.position - var_125_4.position).z)
				var_125_4.localEulerAngles.z = 0
				var_125_4.localEulerAngles.x = 0
				var_125_4.localEulerAngles = var_125_4.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_5 and arg_122_1.time_ < 0 + var_125_5 + arg_125_0 then
				var_125_4.localPosition = Vector3.New(0, -0.97, -6)
				var_125_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_4.position).x, (manager.ui.mainCamera.transform.position - var_125_4.position).y, (manager.ui.mainCamera.transform.position - var_125_4.position).z)
				var_125_4.localEulerAngles.z = 0
				var_125_4.localEulerAngles.x = 0
				var_125_4.localEulerAngles = var_125_4.localEulerAngles
			end

			local var_125_6 = 0
			local var_125_7 = 0.35

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_8 = arg_122_1:GetWordFromCfg(108111030)
				local var_125_9 = arg_122_1:FormatText(var_125_8.content)

				arg_122_1.text_.text = var_125_9

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 14 <= 0 and var_125_7 or var_125_7 * (utf8.len(var_125_9) / 14)

				if (14 <= 0 and var_125_7 or var_125_7 * (utf8.len(var_125_9) / 14)) > 0 and var_125_7 < var_125_11 then
					arg_122_1.talkMaxDuration = var_125_11

					if var_125_11 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_11 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_9
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111030", "story_v_out_108111.awb") ~= 0 then
					local var_125_12 = manager.audio:GetVoiceLength("story_v_out_108111", "108111030", "story_v_out_108111.awb") / 1000

					if var_125_12 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_12 + var_125_6
					end

					if var_125_8.prefab_name ~= "" and arg_122_1.actors_[var_125_8.prefab_name] ~= nil then
						local var_125_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_8.prefab_name].transform, "story_v_out_108111", "108111030", "story_v_out_108111.awb")

						arg_122_1:RecordAudio("108111030", var_125_13)
						arg_122_1:RecordAudio("108111030", var_125_13)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_108111", "108111030", "story_v_out_108111.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_108111", "108111030", "story_v_out_108111.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_14 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_14 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_14

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_14 and arg_122_1.time_ < var_125_6 + var_125_14 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
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
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0805",
		"TextureConfig/Background/C05b"
	},
	voices = {
		"story_v_out_108111.awb"
	}
}
