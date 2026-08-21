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
			local var_4_0 = "S0805"

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
				local var_4_5 = arg_1_1.bgs_.S0805

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
					if iter_4_0 ~= "S0805" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.S0805
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueS0805 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueS0805 = var_4_18
				end

				arg_1_1.var_.alphaOldValueS0805 = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueS0805, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueS0805 then
					local var_4_22 = arg_1_1.var_.alphaMatValueS0805.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueS0805.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueS0805 then
				local var_4_23 = arg_1_1.var_.alphaMatValueS0805
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = arg_1_1.bgs_.S0805.transform
			local var_4_26 = 0

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.var_.moveOldPosS0805 = var_4_25.localPosition
			end

			local var_4_27 = 6

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				local var_4_28 = (arg_1_1.time_ - var_4_26) / var_4_27
				local var_4_29 = Vector3.New(0, 1, 9.5)

				var_4_25.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosS0805, var_4_29, var_4_28)
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				var_4_25.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_4_30 = 0
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 2
			local var_4_37 = 0.975

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[80].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_40 = arg_1_1:GetWordFromCfg(108111001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 39
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111001", "story_v_out_108111.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_108111", "108111001", "story_v_out_108111.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_108111", "108111001", "story_v_out_108111.awb")

						arg_1_1:RecordAudio("108111001", var_4_46)
						arg_1_1:RecordAudio("108111001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_108111", "108111001", "story_v_out_108111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_108111", "108111001", "story_v_out_108111.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_36 + 0.3
			local var_4_48 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
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
			local var_11_0 = 0
			local var_11_1 = 0.7

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[80].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:GetWordFromCfg(108111002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 28
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111002", "story_v_out_108111.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_108111", "108111002", "story_v_out_108111.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_108111", "108111002", "story_v_out_108111.awb")

						arg_8_1:RecordAudio("108111002", var_11_9)
						arg_8_1:RecordAudio("108111002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_108111", "108111002", "story_v_out_108111.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_108111", "108111002", "story_v_out_108111.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_10 and arg_8_1.time_ < var_11_0 + var_11_10 + arg_11_0 then
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
			local var_15_0 = 0
			local var_15_1 = 0.575

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[161].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:GetWordFromCfg(108111003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 23
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111003", "story_v_out_108111.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_108111", "108111003", "story_v_out_108111.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_108111", "108111003", "story_v_out_108111.awb")

						arg_12_1:RecordAudio("108111003", var_15_9)
						arg_12_1:RecordAudio("108111003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_108111", "108111003", "story_v_out_108111.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_108111", "108111003", "story_v_out_108111.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_10 and arg_12_1.time_ < var_15_0 + var_15_10 + arg_15_0 then
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
			local var_19_0 = 0
			local var_19_1 = 0.65

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[161].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:GetWordFromCfg(108111004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 26
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111004", "story_v_out_108111.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_108111", "108111004", "story_v_out_108111.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_108111", "108111004", "story_v_out_108111.awb")

						arg_16_1:RecordAudio("108111004", var_19_9)
						arg_16_1:RecordAudio("108111004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_108111", "108111004", "story_v_out_108111.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_108111", "108111004", "story_v_out_108111.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_10 and arg_16_1.time_ < var_19_0 + var_19_10 + arg_19_0 then
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
			local var_23_0 = 0
			local var_23_1 = 0.05

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[80].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:GetWordFromCfg(108111005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 2
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111005", "story_v_out_108111.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_108111", "108111005", "story_v_out_108111.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_108111", "108111005", "story_v_out_108111.awb")

						arg_20_1:RecordAudio("108111005", var_23_9)
						arg_20_1:RecordAudio("108111005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_108111", "108111005", "story_v_out_108111.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_108111", "108111005", "story_v_out_108111.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
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
			local var_27_0 = 0
			local var_27_1 = 0.625

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[80].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:GetWordFromCfg(108111006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 25
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111006", "story_v_out_108111.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_108111", "108111006", "story_v_out_108111.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_108111", "108111006", "story_v_out_108111.awb")

						arg_24_1:RecordAudio("108111006", var_27_9)
						arg_24_1:RecordAudio("108111006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_108111", "108111006", "story_v_out_108111.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_108111", "108111006", "story_v_out_108111.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_10 and arg_24_1.time_ < var_27_0 + var_27_10 + arg_27_0 then
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
			local var_31_0 = 0
			local var_31_1 = 0.075

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[161].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_3 = arg_28_1:GetWordFromCfg(108111007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 3
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111007", "story_v_out_108111.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_108111", "108111007", "story_v_out_108111.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_108111", "108111007", "story_v_out_108111.awb")

						arg_28_1:RecordAudio("108111007", var_31_9)
						arg_28_1:RecordAudio("108111007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_108111", "108111007", "story_v_out_108111.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_108111", "108111007", "story_v_out_108111.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_10 and arg_28_1.time_ < var_31_0 + var_31_10 + arg_31_0 then
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
			local var_35_0 = 0
			local var_35_1 = 0.875

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[161].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:GetWordFromCfg(108111008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 35
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111008", "story_v_out_108111.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_108111", "108111008", "story_v_out_108111.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_108111", "108111008", "story_v_out_108111.awb")

						arg_32_1:RecordAudio("108111008", var_35_9)
						arg_32_1:RecordAudio("108111008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_108111", "108111008", "story_v_out_108111.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_108111", "108111008", "story_v_out_108111.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
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
			local var_39_0 = 0
			local var_39_1 = 0.05

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[80].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:GetWordFromCfg(108111009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 2
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111009", "story_v_out_108111.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_108111", "108111009", "story_v_out_108111.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_108111", "108111009", "story_v_out_108111.awb")

						arg_36_1:RecordAudio("108111009", var_39_9)
						arg_36_1:RecordAudio("108111009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_108111", "108111009", "story_v_out_108111.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_108111", "108111009", "story_v_out_108111.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_10 and arg_36_1.time_ < var_39_0 + var_39_10 + arg_39_0 then
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
			local var_43_0 = 0
			local var_43_1 = 0.2

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[80].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(108111010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111010", "story_v_out_108111.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_108111", "108111010", "story_v_out_108111.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_108111", "108111010", "story_v_out_108111.awb")

						arg_40_1:RecordAudio("108111010", var_43_9)
						arg_40_1:RecordAudio("108111010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_108111", "108111010", "story_v_out_108111.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_108111", "108111010", "story_v_out_108111.awb")
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
			local var_47_0 = 0
			local var_47_1 = 0.625

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[161].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:GetWordFromCfg(108111011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111011", "story_v_out_108111.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_108111", "108111011", "story_v_out_108111.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_108111", "108111011", "story_v_out_108111.awb")

						arg_44_1:RecordAudio("108111011", var_47_9)
						arg_44_1:RecordAudio("108111011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_108111", "108111011", "story_v_out_108111.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_108111", "108111011", "story_v_out_108111.awb")
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
			local var_51_0 = 0
			local var_51_1 = 0.575

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[161].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(108111012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111012", "story_v_out_108111.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_108111", "108111012", "story_v_out_108111.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_108111", "108111012", "story_v_out_108111.awb")

						arg_48_1:RecordAudio("108111012", var_51_9)
						arg_48_1:RecordAudio("108111012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_108111", "108111012", "story_v_out_108111.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_108111", "108111012", "story_v_out_108111.awb")
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
			local var_55_0 = 0
			local var_55_1 = 0.45

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[80].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:GetWordFromCfg(108111013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 18
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111013", "story_v_out_108111.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_108111", "108111013", "story_v_out_108111.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_108111", "108111013", "story_v_out_108111.awb")

						arg_52_1:RecordAudio("108111013", var_55_9)
						arg_52_1:RecordAudio("108111013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_108111", "108111013", "story_v_out_108111.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_108111", "108111013", "story_v_out_108111.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_10 and arg_52_1.time_ < var_55_0 + var_55_10 + arg_55_0 then
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
			local var_59_0 = 0
			local var_59_1 = 0.100000001490116

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				local var_59_2 = "play"
				local var_59_3 = "effect"

				arg_56_1:AudioAction(var_59_2, var_59_3, "se_story_8", "se_story_8_door", "")
			end

			local var_59_4 = 0
			local var_59_5 = 0.35

			if var_59_4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(108111014)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_8 = 14
				local var_59_9 = utf8.len(var_59_7)
				local var_59_10 = var_59_8 <= 0 and var_59_5 or var_59_5 * (var_59_9 / var_59_8)

				if var_59_10 > 0 and var_59_5 < var_59_10 then
					arg_56_1.talkMaxDuration = var_59_10

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_11 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_11 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_11

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_11 and arg_56_1.time_ < var_59_4 + var_59_11 + arg_59_0 then
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
			local var_63_0 = 0
			local var_63_1 = 0.775

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_2 = arg_60_1:GetWordFromCfg(108111015)
				local var_63_3 = arg_60_1:FormatText(var_63_2.content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 31
				local var_63_5 = utf8.len(var_63_3)
				local var_63_6 = var_63_4 <= 0 and var_63_1 or var_63_1 * (var_63_5 / var_63_4)

				if var_63_6 > 0 and var_63_1 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_7 and arg_60_1.time_ < var_63_0 + var_63_7 + arg_63_0 then
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
			local var_67_0 = 0
			local var_67_1 = 1.25

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_2 = arg_64_1:GetWordFromCfg(108111016)
				local var_67_3 = arg_64_1:FormatText(var_67_2.content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 50
				local var_67_5 = utf8.len(var_67_3)
				local var_67_6 = var_67_4 <= 0 and var_67_1 or var_67_1 * (var_67_5 / var_67_4)

				if var_67_6 > 0 and var_67_1 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_7 and arg_64_1.time_ < var_67_0 + var_67_7 + arg_67_0 then
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
			local var_71_0 = 0
			local var_71_1 = 0.525

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(108111017)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 21
				local var_71_5 = utf8.len(var_71_3)
				local var_71_6 = var_71_4 <= 0 and var_71_1 or var_71_1 * (var_71_5 / var_71_4)

				if var_71_6 > 0 and var_71_1 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_7 and arg_68_1.time_ < var_71_0 + var_71_7 + arg_71_0 then
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
			local var_75_0 = arg_72_1.bgs_.S0805
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				local var_75_2 = var_75_0:GetComponent("SpriteRenderer")

				if var_75_2 then
					arg_72_1.var_.alphaOldValueS0805 = var_75_2.color.a
					arg_72_1.var_.alphaMatValueS0805 = var_75_2
				end

				arg_72_1.var_.alphaOldValueS0805 = 1
			end

			local var_75_3 = 1.5

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_3 then
				local var_75_4 = (arg_72_1.time_ - var_75_1) / var_75_3
				local var_75_5 = Mathf.Lerp(arg_72_1.var_.alphaOldValueS0805, 0, var_75_4)

				if arg_72_1.var_.alphaMatValueS0805 then
					local var_75_6 = arg_72_1.var_.alphaMatValueS0805.color

					var_75_6.a = var_75_5
					arg_72_1.var_.alphaMatValueS0805.color = var_75_6
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_3 and arg_72_1.time_ < var_75_1 + var_75_3 + arg_75_0 and arg_72_1.var_.alphaMatValueS0805 then
				local var_75_7 = arg_72_1.var_.alphaMatValueS0805
				local var_75_8 = var_75_7.color

				var_75_8.a = 0
				var_75_7.color = var_75_8
			end

			local var_75_9 = 1.33333333333333
			local var_75_10 = 0.85

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_11 = arg_72_1:GetWordFromCfg(108111018)
				local var_75_12 = arg_72_1:FormatText(var_75_11.content)

				arg_72_1.text_.text = var_75_12

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_13 = 32
				local var_75_14 = utf8.len(var_75_12)
				local var_75_15 = var_75_13 <= 0 and var_75_10 or var_75_10 * (var_75_14 / var_75_13)

				if var_75_15 > 0 and var_75_10 < var_75_15 then
					arg_72_1.talkMaxDuration = var_75_15

					if var_75_15 + var_75_9 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_15 + var_75_9
					end
				end

				arg_72_1.text_.text = var_75_12
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111018", "story_v_out_108111.awb") ~= 0 then
					local var_75_16 = manager.audio:GetVoiceLength("story_v_out_108111", "108111018", "story_v_out_108111.awb") / 1000

					if var_75_16 + var_75_9 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_16 + var_75_9
					end

					if var_75_11.prefab_name ~= "" and arg_72_1.actors_[var_75_11.prefab_name] ~= nil then
						local var_75_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_11.prefab_name].transform, "story_v_out_108111", "108111018", "story_v_out_108111.awb")

						arg_72_1:RecordAudio("108111018", var_75_17)
						arg_72_1:RecordAudio("108111018", var_75_17)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_108111", "108111018", "story_v_out_108111.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_108111", "108111018", "story_v_out_108111.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_18 = math.max(var_75_10, arg_72_1.talkMaxDuration)

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_18 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_9) / var_75_18

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_9 + var_75_18 and arg_72_1.time_ < var_75_9 + var_75_18 + arg_75_0 then
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
			local var_79_0 = "C05b"

			if arg_76_1.bgs_[var_79_0] == nil then
				local var_79_1 = Object.Instantiate(arg_76_1.paintGo_)

				var_79_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_79_0)
				var_79_1.name = var_79_0
				var_79_1.transform.parent = arg_76_1.stage_.transform
				var_79_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.bgs_[var_79_0] = var_79_1
			end

			local var_79_2 = 0

			if var_79_2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				local var_79_3 = manager.ui.mainCamera.transform.localPosition
				local var_79_4 = Vector3.New(0, 0, 10) + Vector3.New(var_79_3.x, var_79_3.y, 0)
				local var_79_5 = arg_76_1.bgs_.C05b

				var_79_5.transform.localPosition = var_79_4
				var_79_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_6 = var_79_5:GetComponent("SpriteRenderer")

				if var_79_6 and var_79_6.sprite then
					local var_79_7 = (var_79_5.transform.localPosition - var_79_3).z
					local var_79_8 = manager.ui.mainCameraCom_
					local var_79_9 = 2 * var_79_7 * Mathf.Tan(var_79_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_79_10 = var_79_9 * var_79_8.aspect
					local var_79_11 = var_79_6.sprite.bounds.size.x
					local var_79_12 = var_79_6.sprite.bounds.size.y
					local var_79_13 = var_79_10 / var_79_11
					local var_79_14 = var_79_9 / var_79_12
					local var_79_15 = var_79_14 < var_79_13 and var_79_13 or var_79_14

					var_79_5.transform.localScale = Vector3.New(var_79_15, var_79_15, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "C05b" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_79_16 = arg_76_1.bgs_.C05b
			local var_79_17 = 0

			if var_79_17 < arg_76_1.time_ and arg_76_1.time_ <= var_79_17 + arg_79_0 then
				local var_79_18 = var_79_16:GetComponent("SpriteRenderer")

				if var_79_18 then
					arg_76_1.var_.alphaOldValueC05b = var_79_18.color.a
					arg_76_1.var_.alphaMatValueC05b = var_79_18
				end

				arg_76_1.var_.alphaOldValueC05b = 0
			end

			local var_79_19 = 1.5

			if var_79_17 <= arg_76_1.time_ and arg_76_1.time_ < var_79_17 + var_79_19 then
				local var_79_20 = (arg_76_1.time_ - var_79_17) / var_79_19
				local var_79_21 = Mathf.Lerp(arg_76_1.var_.alphaOldValueC05b, 1, var_79_20)

				if arg_76_1.var_.alphaMatValueC05b then
					local var_79_22 = arg_76_1.var_.alphaMatValueC05b.color

					var_79_22.a = var_79_21
					arg_76_1.var_.alphaMatValueC05b.color = var_79_22
				end
			end

			if arg_76_1.time_ >= var_79_17 + var_79_19 and arg_76_1.time_ < var_79_17 + var_79_19 + arg_79_0 and arg_76_1.var_.alphaMatValueC05b then
				local var_79_23 = arg_76_1.var_.alphaMatValueC05b
				local var_79_24 = var_79_23.color

				var_79_24.a = 1
				var_79_23.color = var_79_24
			end

			local var_79_25 = "4015_tpose"

			if arg_76_1.actors_[var_79_25] == nil then
				local var_79_26 = Asset.Load("Char/" .. "4015_tpose")

				if not isNil(var_79_26) then
					local var_79_27 = Object.Instantiate(Asset.Load("Char/" .. "4015_tpose"), arg_76_1.stage_.transform)

					var_79_27.name = var_79_25
					var_79_27.transform.localPosition = Vector3.New(0, 100, 0)
					arg_76_1.actors_[var_79_25] = var_79_27

					local var_79_28 = var_79_27:GetComponentInChildren(typeof(CharacterEffect))

					var_79_28.enabled = true

					local var_79_29 = GameObjectTools.GetOrAddComponent(var_79_27, typeof(DynamicBoneHelper))

					if var_79_29 then
						var_79_29:EnableDynamicBone(false)
					end

					arg_76_1:ShowWeapon(var_79_28.transform, false)

					arg_76_1.var_[var_79_25 .. "Animator"] = var_79_28.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_76_1.var_[var_79_25 .. "Animator"].applyRootMotion = true
					arg_76_1.var_[var_79_25 .. "LipSync"] = var_79_28.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_79_30 = arg_76_1.actors_["4015_tpose"].transform
			local var_79_31 = 2

			if var_79_31 < arg_76_1.time_ and arg_76_1.time_ <= var_79_31 + arg_79_0 then
				arg_76_1.var_.moveOldPos4015_tpose = var_79_30.localPosition

				local var_79_32 = GameObjectTools.GetOrAddComponent(var_79_30.gameObject, typeof(DynamicBoneHelper))

				if var_79_32 then
					var_79_32:EnableDynamicBone(false)
				end
			end

			local var_79_33 = 0.001

			if var_79_31 <= arg_76_1.time_ and arg_76_1.time_ < var_79_31 + var_79_33 then
				local var_79_34 = (arg_76_1.time_ - var_79_31) / var_79_33
				local var_79_35 = Vector3.New(0, -2.65, -2)

				var_79_30.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos4015_tpose, var_79_35, var_79_34)

				local var_79_36 = manager.ui.mainCamera.transform.position - var_79_30.position

				var_79_30.forward = Vector3.New(var_79_36.x, var_79_36.y, var_79_36.z)

				local var_79_37 = var_79_30.localEulerAngles

				var_79_37.z = 0
				var_79_37.x = 0
				var_79_30.localEulerAngles = var_79_37
			end

			if arg_76_1.time_ >= var_79_31 + var_79_33 and arg_76_1.time_ < var_79_31 + var_79_33 + arg_79_0 then
				var_79_30.localPosition = Vector3.New(0, -2.65, -2)

				local var_79_38 = manager.ui.mainCamera.transform.position - var_79_30.position

				var_79_30.forward = Vector3.New(var_79_38.x, var_79_38.y, var_79_38.z)

				local var_79_39 = var_79_30.localEulerAngles

				var_79_39.z = 0
				var_79_39.x = 0
				var_79_30.localEulerAngles = var_79_39

				local var_79_40 = GameObjectTools.GetOrAddComponent(var_79_30.gameObject, typeof(DynamicBoneHelper))

				if var_79_40 then
					var_79_40:EnableDynamicBone(true)
				end
			end

			local var_79_41 = arg_76_1.actors_["4015_tpose"]
			local var_79_42 = 2

			if var_79_42 < arg_76_1.time_ and arg_76_1.time_ <= var_79_42 + arg_79_0 and not isNil(var_79_41) and arg_76_1.var_.characterEffect4015_tpose == nil then
				arg_76_1.var_.characterEffect4015_tpose = var_79_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_43 = 0.2

			if var_79_42 <= arg_76_1.time_ and arg_76_1.time_ < var_79_42 + var_79_43 and not isNil(var_79_41) then
				local var_79_44 = (arg_76_1.time_ - var_79_42) / var_79_43

				if arg_76_1.var_.characterEffect4015_tpose and not isNil(var_79_41) then
					arg_76_1.var_.characterEffect4015_tpose.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_42 + var_79_43 and arg_76_1.time_ < var_79_42 + var_79_43 + arg_79_0 and not isNil(var_79_41) and arg_76_1.var_.characterEffect4015_tpose then
				arg_76_1.var_.characterEffect4015_tpose.fillFlat = false
			end

			local var_79_45 = 2

			if var_79_45 < arg_76_1.time_ and arg_76_1.time_ <= var_79_45 + arg_79_0 then
				arg_76_1:PlayTimeline("4015_tpose", "StoryTimeline/CharAction/story4015/story4015action/4015action1_1")
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_46 = 2
			local var_79_47 = 0.175

			if var_79_46 < arg_76_1.time_ and arg_76_1.time_ <= var_79_46 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_48 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_48:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_49 = arg_76_1:FormatText(StoryNameCfg[156].name)

				arg_76_1.leftNameTxt_.text = var_79_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_50 = arg_76_1:GetWordFromCfg(108111019)
				local var_79_51 = arg_76_1:FormatText(var_79_50.content)

				arg_76_1.text_.text = var_79_51

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_52 = 7
				local var_79_53 = utf8.len(var_79_51)
				local var_79_54 = var_79_52 <= 0 and var_79_47 or var_79_47 * (var_79_53 / var_79_52)

				if var_79_54 > 0 and var_79_47 < var_79_54 then
					arg_76_1.talkMaxDuration = var_79_54
					var_79_46 = var_79_46 + 0.3

					if var_79_54 + var_79_46 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_54 + var_79_46
					end
				end

				arg_76_1.text_.text = var_79_51
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111019", "story_v_out_108111.awb") ~= 0 then
					local var_79_55 = manager.audio:GetVoiceLength("story_v_out_108111", "108111019", "story_v_out_108111.awb") / 1000

					if var_79_55 + var_79_46 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_55 + var_79_46
					end

					if var_79_50.prefab_name ~= "" and arg_76_1.actors_[var_79_50.prefab_name] ~= nil then
						local var_79_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_50.prefab_name].transform, "story_v_out_108111", "108111019", "story_v_out_108111.awb")

						arg_76_1:RecordAudio("108111019", var_79_56)
						arg_76_1:RecordAudio("108111019", var_79_56)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_108111", "108111019", "story_v_out_108111.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_108111", "108111019", "story_v_out_108111.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_57 = var_79_46 + 0.3
			local var_79_58 = math.max(var_79_47, arg_76_1.talkMaxDuration)

			if var_79_57 <= arg_76_1.time_ and arg_76_1.time_ < var_79_57 + var_79_58 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_57) / var_79_58

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_57 + var_79_58 and arg_76_1.time_ < var_79_57 + var_79_58 + arg_79_0 then
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
			local var_85_0 = arg_82_1.actors_["4015_tpose"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos4015_tpose = var_85_0.localPosition

				local var_85_2 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(false)
				end
			end

			local var_85_3 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_3 then
				local var_85_4 = (arg_82_1.time_ - var_85_1) / var_85_3
				local var_85_5 = Vector3.New(0, 100, 0)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos4015_tpose, var_85_5, var_85_4)

				local var_85_6 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_6.x, var_85_6.y, var_85_6.z)

				local var_85_7 = var_85_0.localEulerAngles

				var_85_7.z = 0
				var_85_7.x = 0
				var_85_0.localEulerAngles = var_85_7
			end

			if arg_82_1.time_ >= var_85_1 + var_85_3 and arg_82_1.time_ < var_85_1 + var_85_3 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0, 100, 0)

				local var_85_8 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_8.x, var_85_8.y, var_85_8.z)

				local var_85_9 = var_85_0.localEulerAngles

				var_85_9.z = 0
				var_85_9.x = 0
				var_85_0.localEulerAngles = var_85_9

				local var_85_10 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_10 then
					var_85_10:EnableDynamicBone(true)
				end
			end

			local var_85_11 = 0
			local var_85_12 = 0.825

			if var_85_11 < arg_82_1.time_ and arg_82_1.time_ <= var_85_11 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_13 = arg_82_1:GetWordFromCfg(108111020)
				local var_85_14 = arg_82_1:FormatText(var_85_13.content)

				arg_82_1.text_.text = var_85_14

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_15 = 33
				local var_85_16 = utf8.len(var_85_14)
				local var_85_17 = var_85_15 <= 0 and var_85_12 or var_85_12 * (var_85_16 / var_85_15)

				if var_85_17 > 0 and var_85_12 < var_85_17 then
					arg_82_1.talkMaxDuration = var_85_17

					if var_85_17 + var_85_11 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_17 + var_85_11
					end
				end

				arg_82_1.text_.text = var_85_14
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_18 = math.max(var_85_12, arg_82_1.talkMaxDuration)

			if var_85_11 <= arg_82_1.time_ and arg_82_1.time_ < var_85_11 + var_85_18 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_11) / var_85_18

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_11 + var_85_18 and arg_82_1.time_ < var_85_11 + var_85_18 + arg_85_0 then
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
			local var_89_0 = 0
			local var_89_1 = 1

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				local var_89_2 = "play"
				local var_89_3 = "effect"

				arg_86_1:AudioAction(var_89_2, var_89_3, "se_story_8", "se_story_8_jingyu", "")
			end

			local var_89_4 = 0
			local var_89_5 = 1.075

			if var_89_4 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_6 = arg_86_1:GetWordFromCfg(108111021)
				local var_89_7 = arg_86_1:FormatText(var_89_6.content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_8 = 43
				local var_89_9 = utf8.len(var_89_7)
				local var_89_10 = var_89_8 <= 0 and var_89_5 or var_89_5 * (var_89_9 / var_89_8)

				if var_89_10 > 0 and var_89_5 < var_89_10 then
					arg_86_1.talkMaxDuration = var_89_10

					if var_89_10 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_11 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_11 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_11

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_11 and arg_86_1.time_ < var_89_4 + var_89_11 + arg_89_0 then
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
			local var_93_0 = 0
			local var_93_1 = 0.825

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(108111022)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 33
				local var_93_5 = utf8.len(var_93_3)
				local var_93_6 = var_93_4 <= 0 and var_93_1 or var_93_1 * (var_93_5 / var_93_4)

				if var_93_6 > 0 and var_93_1 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_7 and arg_90_1.time_ < var_93_0 + var_93_7 + arg_93_0 then
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
			local var_97_0 = "1084ui_story"

			if arg_94_1.actors_[var_97_0] == nil then
				local var_97_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_97_1) then
					local var_97_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_94_1.stage_.transform)

					var_97_2.name = var_97_0
					var_97_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_94_1.actors_[var_97_0] = var_97_2

					local var_97_3 = var_97_2:GetComponentInChildren(typeof(CharacterEffect))

					var_97_3.enabled = true

					local var_97_4 = GameObjectTools.GetOrAddComponent(var_97_2, typeof(DynamicBoneHelper))

					if var_97_4 then
						var_97_4:EnableDynamicBone(false)
					end

					arg_94_1:ShowWeapon(var_97_3.transform, false)

					arg_94_1.var_[var_97_0 .. "Animator"] = var_97_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_94_1.var_[var_97_0 .. "Animator"].applyRootMotion = true
					arg_94_1.var_[var_97_0 .. "LipSync"] = var_97_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_97_5 = arg_94_1.actors_["1084ui_story"].transform
			local var_97_6 = 0

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.var_.moveOldPos1084ui_story = var_97_5.localPosition
			end

			local var_97_7 = 0.001

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_7 then
				local var_97_8 = (arg_94_1.time_ - var_97_6) / var_97_7
				local var_97_9 = Vector3.New(-0.7, -0.97, -6)

				var_97_5.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1084ui_story, var_97_9, var_97_8)

				local var_97_10 = manager.ui.mainCamera.transform.position - var_97_5.position

				var_97_5.forward = Vector3.New(var_97_10.x, var_97_10.y, var_97_10.z)

				local var_97_11 = var_97_5.localEulerAngles

				var_97_11.z = 0
				var_97_11.x = 0
				var_97_5.localEulerAngles = var_97_11
			end

			if arg_94_1.time_ >= var_97_6 + var_97_7 and arg_94_1.time_ < var_97_6 + var_97_7 + arg_97_0 then
				var_97_5.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_97_12 = manager.ui.mainCamera.transform.position - var_97_5.position

				var_97_5.forward = Vector3.New(var_97_12.x, var_97_12.y, var_97_12.z)

				local var_97_13 = var_97_5.localEulerAngles

				var_97_13.z = 0
				var_97_13.x = 0
				var_97_5.localEulerAngles = var_97_13
			end

			local var_97_14 = arg_94_1.actors_["1084ui_story"]
			local var_97_15 = 0

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 and not isNil(var_97_14) and arg_94_1.var_.characterEffect1084ui_story == nil then
				arg_94_1.var_.characterEffect1084ui_story = var_97_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_16 = 0.2

			if var_97_15 <= arg_94_1.time_ and arg_94_1.time_ < var_97_15 + var_97_16 and not isNil(var_97_14) then
				local var_97_17 = (arg_94_1.time_ - var_97_15) / var_97_16

				if arg_94_1.var_.characterEffect1084ui_story and not isNil(var_97_14) then
					arg_94_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_15 + var_97_16 and arg_94_1.time_ < var_97_15 + var_97_16 + arg_97_0 and not isNil(var_97_14) and arg_94_1.var_.characterEffect1084ui_story then
				arg_94_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_97_18 = 0

			if var_97_18 < arg_94_1.time_ and arg_94_1.time_ <= var_97_18 + arg_97_0 then
				arg_94_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_97_19 = 0

			if var_97_19 < arg_94_1.time_ and arg_94_1.time_ <= var_97_19 + arg_97_0 then
				arg_94_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_97_20 = 0
			local var_97_21 = 0.15

			if var_97_20 < arg_94_1.time_ and arg_94_1.time_ <= var_97_20 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_22 = arg_94_1:FormatText(StoryNameCfg[6].name)

				arg_94_1.leftNameTxt_.text = var_97_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_23 = arg_94_1:GetWordFromCfg(108111023)
				local var_97_24 = arg_94_1:FormatText(var_97_23.content)

				arg_94_1.text_.text = var_97_24

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_25 = 6
				local var_97_26 = utf8.len(var_97_24)
				local var_97_27 = var_97_25 <= 0 and var_97_21 or var_97_21 * (var_97_26 / var_97_25)

				if var_97_27 > 0 and var_97_21 < var_97_27 then
					arg_94_1.talkMaxDuration = var_97_27

					if var_97_27 + var_97_20 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_27 + var_97_20
					end
				end

				arg_94_1.text_.text = var_97_24
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111023", "story_v_out_108111.awb") ~= 0 then
					local var_97_28 = manager.audio:GetVoiceLength("story_v_out_108111", "108111023", "story_v_out_108111.awb") / 1000

					if var_97_28 + var_97_20 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_28 + var_97_20
					end

					if var_97_23.prefab_name ~= "" and arg_94_1.actors_[var_97_23.prefab_name] ~= nil then
						local var_97_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_23.prefab_name].transform, "story_v_out_108111", "108111023", "story_v_out_108111.awb")

						arg_94_1:RecordAudio("108111023", var_97_29)
						arg_94_1:RecordAudio("108111023", var_97_29)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_108111", "108111023", "story_v_out_108111.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_108111", "108111023", "story_v_out_108111.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_30 = math.max(var_97_21, arg_94_1.talkMaxDuration)

			if var_97_20 <= arg_94_1.time_ and arg_94_1.time_ < var_97_20 + var_97_30 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_20) / var_97_30

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_20 + var_97_30 and arg_94_1.time_ < var_97_20 + var_97_30 + arg_97_0 then
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
			local var_101_0 = "1038ui_story"

			if arg_98_1.actors_[var_101_0] == nil then
				local var_101_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_101_1) then
					local var_101_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_98_1.stage_.transform)

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

			local var_101_5 = arg_98_1.actors_["1038ui_story"].transform
			local var_101_6 = 0

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.var_.moveOldPos1038ui_story = var_101_5.localPosition
			end

			local var_101_7 = 0.001

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_7 then
				local var_101_8 = (arg_98_1.time_ - var_101_6) / var_101_7
				local var_101_9 = Vector3.New(0.7, -1.11, -5.9)

				var_101_5.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1038ui_story, var_101_9, var_101_8)

				local var_101_10 = manager.ui.mainCamera.transform.position - var_101_5.position

				var_101_5.forward = Vector3.New(var_101_10.x, var_101_10.y, var_101_10.z)

				local var_101_11 = var_101_5.localEulerAngles

				var_101_11.z = 0
				var_101_11.x = 0
				var_101_5.localEulerAngles = var_101_11
			end

			if arg_98_1.time_ >= var_101_6 + var_101_7 and arg_98_1.time_ < var_101_6 + var_101_7 + arg_101_0 then
				var_101_5.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_101_12 = manager.ui.mainCamera.transform.position - var_101_5.position

				var_101_5.forward = Vector3.New(var_101_12.x, var_101_12.y, var_101_12.z)

				local var_101_13 = var_101_5.localEulerAngles

				var_101_13.z = 0
				var_101_13.x = 0
				var_101_5.localEulerAngles = var_101_13
			end

			local var_101_14 = arg_98_1.actors_["1038ui_story"]
			local var_101_15 = 0

			if var_101_15 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 and not isNil(var_101_14) and arg_98_1.var_.characterEffect1038ui_story == nil then
				arg_98_1.var_.characterEffect1038ui_story = var_101_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_16 = 0.2

			if var_101_15 <= arg_98_1.time_ and arg_98_1.time_ < var_101_15 + var_101_16 and not isNil(var_101_14) then
				local var_101_17 = (arg_98_1.time_ - var_101_15) / var_101_16

				if arg_98_1.var_.characterEffect1038ui_story and not isNil(var_101_14) then
					arg_98_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_15 + var_101_16 and arg_98_1.time_ < var_101_15 + var_101_16 + arg_101_0 and not isNil(var_101_14) and arg_98_1.var_.characterEffect1038ui_story then
				arg_98_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_101_18 = arg_98_1.actors_["1084ui_story"]
			local var_101_19 = 0

			if var_101_19 < arg_98_1.time_ and arg_98_1.time_ <= var_101_19 + arg_101_0 and not isNil(var_101_18) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = var_101_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_20 = 0.2

			if var_101_19 <= arg_98_1.time_ and arg_98_1.time_ < var_101_19 + var_101_20 and not isNil(var_101_18) then
				local var_101_21 = (arg_98_1.time_ - var_101_19) / var_101_20

				if arg_98_1.var_.characterEffect1084ui_story and not isNil(var_101_18) then
					local var_101_22 = Mathf.Lerp(0, 0.5, var_101_21)

					arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1084ui_story.fillRatio = var_101_22
				end
			end

			if arg_98_1.time_ >= var_101_19 + var_101_20 and arg_98_1.time_ < var_101_19 + var_101_20 + arg_101_0 and not isNil(var_101_18) and arg_98_1.var_.characterEffect1084ui_story then
				local var_101_23 = 0.5

				arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1084ui_story.fillRatio = var_101_23
			end

			local var_101_24 = 0

			if var_101_24 < arg_98_1.time_ and arg_98_1.time_ <= var_101_24 + arg_101_0 then
				arg_98_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_101_25 = 0

			if var_101_25 < arg_98_1.time_ and arg_98_1.time_ <= var_101_25 + arg_101_0 then
				arg_98_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_101_26 = 0
			local var_101_27 = 0.8

			if var_101_26 < arg_98_1.time_ and arg_98_1.time_ <= var_101_26 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_28 = arg_98_1:FormatText(StoryNameCfg[94].name)

				arg_98_1.leftNameTxt_.text = var_101_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_29 = arg_98_1:GetWordFromCfg(108111024)
				local var_101_30 = arg_98_1:FormatText(var_101_29.content)

				arg_98_1.text_.text = var_101_30

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_31 = 32
				local var_101_32 = utf8.len(var_101_30)
				local var_101_33 = var_101_31 <= 0 and var_101_27 or var_101_27 * (var_101_32 / var_101_31)

				if var_101_33 > 0 and var_101_27 < var_101_33 then
					arg_98_1.talkMaxDuration = var_101_33

					if var_101_33 + var_101_26 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_33 + var_101_26
					end
				end

				arg_98_1.text_.text = var_101_30
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111024", "story_v_out_108111.awb") ~= 0 then
					local var_101_34 = manager.audio:GetVoiceLength("story_v_out_108111", "108111024", "story_v_out_108111.awb") / 1000

					if var_101_34 + var_101_26 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_34 + var_101_26
					end

					if var_101_29.prefab_name ~= "" and arg_98_1.actors_[var_101_29.prefab_name] ~= nil then
						local var_101_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_29.prefab_name].transform, "story_v_out_108111", "108111024", "story_v_out_108111.awb")

						arg_98_1:RecordAudio("108111024", var_101_35)
						arg_98_1:RecordAudio("108111024", var_101_35)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_108111", "108111024", "story_v_out_108111.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_108111", "108111024", "story_v_out_108111.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_36 = math.max(var_101_27, arg_98_1.talkMaxDuration)

			if var_101_26 <= arg_98_1.time_ and arg_98_1.time_ < var_101_26 + var_101_36 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_26) / var_101_36

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_26 + var_101_36 and arg_98_1.time_ < var_101_26 + var_101_36 + arg_101_0 then
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
			local var_105_0 = arg_102_1.actors_["1084ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos1084ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(0, 100, 0)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1084ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0, 100, 0)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = arg_102_1.actors_["1038ui_story"].transform
			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1.var_.moveOldPos1038ui_story = var_105_9.localPosition
			end

			local var_105_11 = 0.001

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_11 then
				local var_105_12 = (arg_102_1.time_ - var_105_10) / var_105_11
				local var_105_13 = Vector3.New(0, 100, 0)

				var_105_9.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1038ui_story, var_105_13, var_105_12)

				local var_105_14 = manager.ui.mainCamera.transform.position - var_105_9.position

				var_105_9.forward = Vector3.New(var_105_14.x, var_105_14.y, var_105_14.z)

				local var_105_15 = var_105_9.localEulerAngles

				var_105_15.z = 0
				var_105_15.x = 0
				var_105_9.localEulerAngles = var_105_15
			end

			if arg_102_1.time_ >= var_105_10 + var_105_11 and arg_102_1.time_ < var_105_10 + var_105_11 + arg_105_0 then
				var_105_9.localPosition = Vector3.New(0, 100, 0)

				local var_105_16 = manager.ui.mainCamera.transform.position - var_105_9.position

				var_105_9.forward = Vector3.New(var_105_16.x, var_105_16.y, var_105_16.z)

				local var_105_17 = var_105_9.localEulerAngles

				var_105_17.z = 0
				var_105_17.x = 0
				var_105_9.localEulerAngles = var_105_17
			end

			local var_105_18 = 0
			local var_105_19 = 0.775

			if var_105_18 < arg_102_1.time_ and arg_102_1.time_ <= var_105_18 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_20 = arg_102_1:GetWordFromCfg(108111025)
				local var_105_21 = arg_102_1:FormatText(var_105_20.content)

				arg_102_1.text_.text = var_105_21

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_22 = 31
				local var_105_23 = utf8.len(var_105_21)
				local var_105_24 = var_105_22 <= 0 and var_105_19 or var_105_19 * (var_105_23 / var_105_22)

				if var_105_24 > 0 and var_105_19 < var_105_24 then
					arg_102_1.talkMaxDuration = var_105_24

					if var_105_24 + var_105_18 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_24 + var_105_18
					end
				end

				arg_102_1.text_.text = var_105_21
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_25 = math.max(var_105_19, arg_102_1.talkMaxDuration)

			if var_105_18 <= arg_102_1.time_ and arg_102_1.time_ < var_105_18 + var_105_25 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_18) / var_105_25

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_18 + var_105_25 and arg_102_1.time_ < var_105_18 + var_105_25 + arg_105_0 then
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
			local var_109_0 = arg_106_1.actors_["1084ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos1084ui_story = var_109_0.localPosition
			end

			local var_109_2 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2
				local var_109_4 = Vector3.New(-0.7, -0.97, -6)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1084ui_story, var_109_4, var_109_3)

				local var_109_5 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_5.x, var_109_5.y, var_109_5.z)

				local var_109_6 = var_109_0.localEulerAngles

				var_109_6.z = 0
				var_109_6.x = 0
				var_109_0.localEulerAngles = var_109_6
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_109_7 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_7.x, var_109_7.y, var_109_7.z)

				local var_109_8 = var_109_0.localEulerAngles

				var_109_8.z = 0
				var_109_8.x = 0
				var_109_0.localEulerAngles = var_109_8
			end

			local var_109_9 = arg_106_1.actors_["1084ui_story"]
			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1084ui_story == nil then
				arg_106_1.var_.characterEffect1084ui_story = var_109_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_11 = 0.2

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_11 and not isNil(var_109_9) then
				local var_109_12 = (arg_106_1.time_ - var_109_10) / var_109_11

				if arg_106_1.var_.characterEffect1084ui_story and not isNil(var_109_9) then
					arg_106_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_10 + var_109_11 and arg_106_1.time_ < var_109_10 + var_109_11 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1084ui_story then
				arg_106_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_109_13 = 0

			if var_109_13 < arg_106_1.time_ and arg_106_1.time_ <= var_109_13 + arg_109_0 then
				arg_106_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_109_14 = 5.89805981832114e-17

			if var_109_14 < arg_106_1.time_ and arg_106_1.time_ <= var_109_14 + arg_109_0 then
				arg_106_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_109_15 = 0
			local var_109_16 = 0.35

			if var_109_15 < arg_106_1.time_ and arg_106_1.time_ <= var_109_15 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_17 = arg_106_1:FormatText(StoryNameCfg[6].name)

				arg_106_1.leftNameTxt_.text = var_109_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_18 = arg_106_1:GetWordFromCfg(108111026)
				local var_109_19 = arg_106_1:FormatText(var_109_18.content)

				arg_106_1.text_.text = var_109_19

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_20 = 14
				local var_109_21 = utf8.len(var_109_19)
				local var_109_22 = var_109_20 <= 0 and var_109_16 or var_109_16 * (var_109_21 / var_109_20)

				if var_109_22 > 0 and var_109_16 < var_109_22 then
					arg_106_1.talkMaxDuration = var_109_22

					if var_109_22 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_22 + var_109_15
					end
				end

				arg_106_1.text_.text = var_109_19
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111026", "story_v_out_108111.awb") ~= 0 then
					local var_109_23 = manager.audio:GetVoiceLength("story_v_out_108111", "108111026", "story_v_out_108111.awb") / 1000

					if var_109_23 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_23 + var_109_15
					end

					if var_109_18.prefab_name ~= "" and arg_106_1.actors_[var_109_18.prefab_name] ~= nil then
						local var_109_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_18.prefab_name].transform, "story_v_out_108111", "108111026", "story_v_out_108111.awb")

						arg_106_1:RecordAudio("108111026", var_109_24)
						arg_106_1:RecordAudio("108111026", var_109_24)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_108111", "108111026", "story_v_out_108111.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_108111", "108111026", "story_v_out_108111.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_25 = math.max(var_109_16, arg_106_1.talkMaxDuration)

			if var_109_15 <= arg_106_1.time_ and arg_106_1.time_ < var_109_15 + var_109_25 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_15) / var_109_25

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_15 + var_109_25 and arg_106_1.time_ < var_109_15 + var_109_25 + arg_109_0 then
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
			local var_113_0 = arg_110_1.actors_["1038ui_story"].transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPos1038ui_story = var_113_0.localPosition
			end

			local var_113_2 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2
				local var_113_4 = Vector3.New(0.7, -1.11, -5.9)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1038ui_story, var_113_4, var_113_3)

				local var_113_5 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_5.x, var_113_5.y, var_113_5.z)

				local var_113_6 = var_113_0.localEulerAngles

				var_113_6.z = 0
				var_113_6.x = 0
				var_113_0.localEulerAngles = var_113_6
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_113_7 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_7.x, var_113_7.y, var_113_7.z)

				local var_113_8 = var_113_0.localEulerAngles

				var_113_8.z = 0
				var_113_8.x = 0
				var_113_0.localEulerAngles = var_113_8
			end

			local var_113_9 = arg_110_1.actors_["1038ui_story"]
			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 and not isNil(var_113_9) and arg_110_1.var_.characterEffect1038ui_story == nil then
				arg_110_1.var_.characterEffect1038ui_story = var_113_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_11 = 0.2

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_11 and not isNil(var_113_9) then
				local var_113_12 = (arg_110_1.time_ - var_113_10) / var_113_11

				if arg_110_1.var_.characterEffect1038ui_story and not isNil(var_113_9) then
					arg_110_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_10 + var_113_11 and arg_110_1.time_ < var_113_10 + var_113_11 + arg_113_0 and not isNil(var_113_9) and arg_110_1.var_.characterEffect1038ui_story then
				arg_110_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_113_13 = arg_110_1.actors_["1084ui_story"]
			local var_113_14 = 0

			if var_113_14 < arg_110_1.time_ and arg_110_1.time_ <= var_113_14 + arg_113_0 and not isNil(var_113_13) and arg_110_1.var_.characterEffect1084ui_story == nil then
				arg_110_1.var_.characterEffect1084ui_story = var_113_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_15 = 0.2

			if var_113_14 <= arg_110_1.time_ and arg_110_1.time_ < var_113_14 + var_113_15 and not isNil(var_113_13) then
				local var_113_16 = (arg_110_1.time_ - var_113_14) / var_113_15

				if arg_110_1.var_.characterEffect1084ui_story and not isNil(var_113_13) then
					local var_113_17 = Mathf.Lerp(0, 0.5, var_113_16)

					arg_110_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1084ui_story.fillRatio = var_113_17
				end
			end

			if arg_110_1.time_ >= var_113_14 + var_113_15 and arg_110_1.time_ < var_113_14 + var_113_15 + arg_113_0 and not isNil(var_113_13) and arg_110_1.var_.characterEffect1084ui_story then
				local var_113_18 = 0.5

				arg_110_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1084ui_story.fillRatio = var_113_18
			end

			local var_113_19 = 0

			if var_113_19 < arg_110_1.time_ and arg_110_1.time_ <= var_113_19 + arg_113_0 then
				arg_110_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			local var_113_20 = 0

			if var_113_20 < arg_110_1.time_ and arg_110_1.time_ <= var_113_20 + arg_113_0 then
				arg_110_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_113_21 = 0
			local var_113_22 = 0.8

			if var_113_21 < arg_110_1.time_ and arg_110_1.time_ <= var_113_21 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_23 = arg_110_1:FormatText(StoryNameCfg[94].name)

				arg_110_1.leftNameTxt_.text = var_113_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_24 = arg_110_1:GetWordFromCfg(108111027)
				local var_113_25 = arg_110_1:FormatText(var_113_24.content)

				arg_110_1.text_.text = var_113_25

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_26 = 32
				local var_113_27 = utf8.len(var_113_25)
				local var_113_28 = var_113_26 <= 0 and var_113_22 or var_113_22 * (var_113_27 / var_113_26)

				if var_113_28 > 0 and var_113_22 < var_113_28 then
					arg_110_1.talkMaxDuration = var_113_28

					if var_113_28 + var_113_21 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_28 + var_113_21
					end
				end

				arg_110_1.text_.text = var_113_25
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111027", "story_v_out_108111.awb") ~= 0 then
					local var_113_29 = manager.audio:GetVoiceLength("story_v_out_108111", "108111027", "story_v_out_108111.awb") / 1000

					if var_113_29 + var_113_21 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_29 + var_113_21
					end

					if var_113_24.prefab_name ~= "" and arg_110_1.actors_[var_113_24.prefab_name] ~= nil then
						local var_113_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_24.prefab_name].transform, "story_v_out_108111", "108111027", "story_v_out_108111.awb")

						arg_110_1:RecordAudio("108111027", var_113_30)
						arg_110_1:RecordAudio("108111027", var_113_30)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_108111", "108111027", "story_v_out_108111.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_108111", "108111027", "story_v_out_108111.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_31 = math.max(var_113_22, arg_110_1.talkMaxDuration)

			if var_113_21 <= arg_110_1.time_ and arg_110_1.time_ < var_113_21 + var_113_31 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_21) / var_113_31

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_21 + var_113_31 and arg_110_1.time_ < var_113_21 + var_113_31 + arg_113_0 then
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
			local var_117_0 = 0

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_117_1 = 0
			local var_117_2 = 0.6

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_3 = arg_114_1:FormatText(StoryNameCfg[94].name)

				arg_114_1.leftNameTxt_.text = var_117_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_4 = arg_114_1:GetWordFromCfg(108111028)
				local var_117_5 = arg_114_1:FormatText(var_117_4.content)

				arg_114_1.text_.text = var_117_5

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_6 = 24
				local var_117_7 = utf8.len(var_117_5)
				local var_117_8 = var_117_6 <= 0 and var_117_2 or var_117_2 * (var_117_7 / var_117_6)

				if var_117_8 > 0 and var_117_2 < var_117_8 then
					arg_114_1.talkMaxDuration = var_117_8

					if var_117_8 + var_117_1 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_1
					end
				end

				arg_114_1.text_.text = var_117_5
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111028", "story_v_out_108111.awb") ~= 0 then
					local var_117_9 = manager.audio:GetVoiceLength("story_v_out_108111", "108111028", "story_v_out_108111.awb") / 1000

					if var_117_9 + var_117_1 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_1
					end

					if var_117_4.prefab_name ~= "" and arg_114_1.actors_[var_117_4.prefab_name] ~= nil then
						local var_117_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_4.prefab_name].transform, "story_v_out_108111", "108111028", "story_v_out_108111.awb")

						arg_114_1:RecordAudio("108111028", var_117_10)
						arg_114_1:RecordAudio("108111028", var_117_10)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_108111", "108111028", "story_v_out_108111.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_108111", "108111028", "story_v_out_108111.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_11 = math.max(var_117_2, arg_114_1.talkMaxDuration)

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_11 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_1) / var_117_11

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_1 + var_117_11 and arg_114_1.time_ < var_117_1 + var_117_11 + arg_117_0 then
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
			local var_121_0 = arg_118_1.actors_["1038ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos1038ui_story = var_121_0.localPosition
			end

			local var_121_2 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2
				local var_121_4 = Vector3.New(0, 100, 0)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1038ui_story, var_121_4, var_121_3)

				local var_121_5 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_5.x, var_121_5.y, var_121_5.z)

				local var_121_6 = var_121_0.localEulerAngles

				var_121_6.z = 0
				var_121_6.x = 0
				var_121_0.localEulerAngles = var_121_6
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(0, 100, 0)

				local var_121_7 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_7.x, var_121_7.y, var_121_7.z)

				local var_121_8 = var_121_0.localEulerAngles

				var_121_8.z = 0
				var_121_8.x = 0
				var_121_0.localEulerAngles = var_121_8
			end

			local var_121_9 = "1050ui_story"

			if arg_118_1.actors_[var_121_9] == nil then
				local var_121_10 = Asset.Load("Char/" .. "1050ui_story")

				if not isNil(var_121_10) then
					local var_121_11 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_118_1.stage_.transform)

					var_121_11.name = var_121_9
					var_121_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_118_1.actors_[var_121_9] = var_121_11

					local var_121_12 = var_121_11:GetComponentInChildren(typeof(CharacterEffect))

					var_121_12.enabled = true

					local var_121_13 = GameObjectTools.GetOrAddComponent(var_121_11, typeof(DynamicBoneHelper))

					if var_121_13 then
						var_121_13:EnableDynamicBone(false)
					end

					arg_118_1:ShowWeapon(var_121_12.transform, false)

					arg_118_1.var_[var_121_9 .. "Animator"] = var_121_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_118_1.var_[var_121_9 .. "Animator"].applyRootMotion = true
					arg_118_1.var_[var_121_9 .. "LipSync"] = var_121_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_121_14 = arg_118_1.actors_["1050ui_story"].transform
			local var_121_15 = 0

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1.var_.moveOldPos1050ui_story = var_121_14.localPosition
			end

			local var_121_16 = 0.001

			if var_121_15 <= arg_118_1.time_ and arg_118_1.time_ < var_121_15 + var_121_16 then
				local var_121_17 = (arg_118_1.time_ - var_121_15) / var_121_16
				local var_121_18 = Vector3.New(0, -1, -6.1)

				var_121_14.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1050ui_story, var_121_18, var_121_17)

				local var_121_19 = manager.ui.mainCamera.transform.position - var_121_14.position

				var_121_14.forward = Vector3.New(var_121_19.x, var_121_19.y, var_121_19.z)

				local var_121_20 = var_121_14.localEulerAngles

				var_121_20.z = 0
				var_121_20.x = 0
				var_121_14.localEulerAngles = var_121_20
			end

			if arg_118_1.time_ >= var_121_15 + var_121_16 and arg_118_1.time_ < var_121_15 + var_121_16 + arg_121_0 then
				var_121_14.localPosition = Vector3.New(0, -1, -6.1)

				local var_121_21 = manager.ui.mainCamera.transform.position - var_121_14.position

				var_121_14.forward = Vector3.New(var_121_21.x, var_121_21.y, var_121_21.z)

				local var_121_22 = var_121_14.localEulerAngles

				var_121_22.z = 0
				var_121_22.x = 0
				var_121_14.localEulerAngles = var_121_22
			end

			local var_121_23 = arg_118_1.actors_["1050ui_story"]
			local var_121_24 = 0

			if var_121_24 < arg_118_1.time_ and arg_118_1.time_ <= var_121_24 + arg_121_0 and not isNil(var_121_23) and arg_118_1.var_.characterEffect1050ui_story == nil then
				arg_118_1.var_.characterEffect1050ui_story = var_121_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_25 = 0.2

			if var_121_24 <= arg_118_1.time_ and arg_118_1.time_ < var_121_24 + var_121_25 and not isNil(var_121_23) then
				local var_121_26 = (arg_118_1.time_ - var_121_24) / var_121_25

				if arg_118_1.var_.characterEffect1050ui_story and not isNil(var_121_23) then
					arg_118_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_24 + var_121_25 and arg_118_1.time_ < var_121_24 + var_121_25 + arg_121_0 and not isNil(var_121_23) and arg_118_1.var_.characterEffect1050ui_story then
				arg_118_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_121_27 = 0

			if var_121_27 < arg_118_1.time_ and arg_118_1.time_ <= var_121_27 + arg_121_0 then
				arg_118_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			local var_121_28 = 0

			if var_121_28 < arg_118_1.time_ and arg_118_1.time_ <= var_121_28 + arg_121_0 then
				arg_118_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_121_29 = arg_118_1.actors_["1084ui_story"].transform
			local var_121_30 = 0

			if var_121_30 < arg_118_1.time_ and arg_118_1.time_ <= var_121_30 + arg_121_0 then
				arg_118_1.var_.moveOldPos1084ui_story = var_121_29.localPosition
			end

			local var_121_31 = 0.001

			if var_121_30 <= arg_118_1.time_ and arg_118_1.time_ < var_121_30 + var_121_31 then
				local var_121_32 = (arg_118_1.time_ - var_121_30) / var_121_31
				local var_121_33 = Vector3.New(0, 100, 0)

				var_121_29.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1084ui_story, var_121_33, var_121_32)

				local var_121_34 = manager.ui.mainCamera.transform.position - var_121_29.position

				var_121_29.forward = Vector3.New(var_121_34.x, var_121_34.y, var_121_34.z)

				local var_121_35 = var_121_29.localEulerAngles

				var_121_35.z = 0
				var_121_35.x = 0
				var_121_29.localEulerAngles = var_121_35
			end

			if arg_118_1.time_ >= var_121_30 + var_121_31 and arg_118_1.time_ < var_121_30 + var_121_31 + arg_121_0 then
				var_121_29.localPosition = Vector3.New(0, 100, 0)

				local var_121_36 = manager.ui.mainCamera.transform.position - var_121_29.position

				var_121_29.forward = Vector3.New(var_121_36.x, var_121_36.y, var_121_36.z)

				local var_121_37 = var_121_29.localEulerAngles

				var_121_37.z = 0
				var_121_37.x = 0
				var_121_29.localEulerAngles = var_121_37
			end

			local var_121_38 = 0
			local var_121_39 = 0.425

			if var_121_38 < arg_118_1.time_ and arg_118_1.time_ <= var_121_38 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_40 = arg_118_1:FormatText(StoryNameCfg[74].name)

				arg_118_1.leftNameTxt_.text = var_121_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_41 = arg_118_1:GetWordFromCfg(108111029)
				local var_121_42 = arg_118_1:FormatText(var_121_41.content)

				arg_118_1.text_.text = var_121_42

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_43 = 17
				local var_121_44 = utf8.len(var_121_42)
				local var_121_45 = var_121_43 <= 0 and var_121_39 or var_121_39 * (var_121_44 / var_121_43)

				if var_121_45 > 0 and var_121_39 < var_121_45 then
					arg_118_1.talkMaxDuration = var_121_45

					if var_121_45 + var_121_38 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_45 + var_121_38
					end
				end

				arg_118_1.text_.text = var_121_42
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111029", "story_v_out_108111.awb") ~= 0 then
					local var_121_46 = manager.audio:GetVoiceLength("story_v_out_108111", "108111029", "story_v_out_108111.awb") / 1000

					if var_121_46 + var_121_38 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_46 + var_121_38
					end

					if var_121_41.prefab_name ~= "" and arg_118_1.actors_[var_121_41.prefab_name] ~= nil then
						local var_121_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_41.prefab_name].transform, "story_v_out_108111", "108111029", "story_v_out_108111.awb")

						arg_118_1:RecordAudio("108111029", var_121_47)
						arg_118_1:RecordAudio("108111029", var_121_47)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_108111", "108111029", "story_v_out_108111.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_108111", "108111029", "story_v_out_108111.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_48 = math.max(var_121_39, arg_118_1.talkMaxDuration)

			if var_121_38 <= arg_118_1.time_ and arg_118_1.time_ < var_121_38 + var_121_48 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_38) / var_121_48

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_38 + var_121_48 and arg_118_1.time_ < var_121_38 + var_121_48 + arg_121_0 then
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
			local var_125_0 = arg_122_1.actors_["1084ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1084ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1084ui_story then
				arg_122_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_125_4 = 0

			if var_125_4 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 then
				arg_122_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_125_6 = arg_122_1.actors_["1050ui_story"].transform
			local var_125_7 = 0

			if var_125_7 < arg_122_1.time_ and arg_122_1.time_ <= var_125_7 + arg_125_0 then
				arg_122_1.var_.moveOldPos1050ui_story = var_125_6.localPosition
			end

			local var_125_8 = 0.001

			if var_125_7 <= arg_122_1.time_ and arg_122_1.time_ < var_125_7 + var_125_8 then
				local var_125_9 = (arg_122_1.time_ - var_125_7) / var_125_8
				local var_125_10 = Vector3.New(0, 100, 0)

				var_125_6.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1050ui_story, var_125_10, var_125_9)

				local var_125_11 = manager.ui.mainCamera.transform.position - var_125_6.position

				var_125_6.forward = Vector3.New(var_125_11.x, var_125_11.y, var_125_11.z)

				local var_125_12 = var_125_6.localEulerAngles

				var_125_12.z = 0
				var_125_12.x = 0
				var_125_6.localEulerAngles = var_125_12
			end

			if arg_122_1.time_ >= var_125_7 + var_125_8 and arg_122_1.time_ < var_125_7 + var_125_8 + arg_125_0 then
				var_125_6.localPosition = Vector3.New(0, 100, 0)

				local var_125_13 = manager.ui.mainCamera.transform.position - var_125_6.position

				var_125_6.forward = Vector3.New(var_125_13.x, var_125_13.y, var_125_13.z)

				local var_125_14 = var_125_6.localEulerAngles

				var_125_14.z = 0
				var_125_14.x = 0
				var_125_6.localEulerAngles = var_125_14
			end

			local var_125_15 = arg_122_1.actors_["1084ui_story"].transform
			local var_125_16 = 0

			if var_125_16 < arg_122_1.time_ and arg_122_1.time_ <= var_125_16 + arg_125_0 then
				arg_122_1.var_.moveOldPos1084ui_story = var_125_15.localPosition
			end

			local var_125_17 = 0.001

			if var_125_16 <= arg_122_1.time_ and arg_122_1.time_ < var_125_16 + var_125_17 then
				local var_125_18 = (arg_122_1.time_ - var_125_16) / var_125_17
				local var_125_19 = Vector3.New(0, -0.97, -6)

				var_125_15.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1084ui_story, var_125_19, var_125_18)

				local var_125_20 = manager.ui.mainCamera.transform.position - var_125_15.position

				var_125_15.forward = Vector3.New(var_125_20.x, var_125_20.y, var_125_20.z)

				local var_125_21 = var_125_15.localEulerAngles

				var_125_21.z = 0
				var_125_21.x = 0
				var_125_15.localEulerAngles = var_125_21
			end

			if arg_122_1.time_ >= var_125_16 + var_125_17 and arg_122_1.time_ < var_125_16 + var_125_17 + arg_125_0 then
				var_125_15.localPosition = Vector3.New(0, -0.97, -6)

				local var_125_22 = manager.ui.mainCamera.transform.position - var_125_15.position

				var_125_15.forward = Vector3.New(var_125_22.x, var_125_22.y, var_125_22.z)

				local var_125_23 = var_125_15.localEulerAngles

				var_125_23.z = 0
				var_125_23.x = 0
				var_125_15.localEulerAngles = var_125_23
			end

			local var_125_24 = 0
			local var_125_25 = 0.35

			if var_125_24 < arg_122_1.time_ and arg_122_1.time_ <= var_125_24 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_26 = arg_122_1:FormatText(StoryNameCfg[6].name)

				arg_122_1.leftNameTxt_.text = var_125_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_27 = arg_122_1:GetWordFromCfg(108111030)
				local var_125_28 = arg_122_1:FormatText(var_125_27.content)

				arg_122_1.text_.text = var_125_28

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_29 = 14
				local var_125_30 = utf8.len(var_125_28)
				local var_125_31 = var_125_29 <= 0 and var_125_25 or var_125_25 * (var_125_30 / var_125_29)

				if var_125_31 > 0 and var_125_25 < var_125_31 then
					arg_122_1.talkMaxDuration = var_125_31

					if var_125_31 + var_125_24 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_31 + var_125_24
					end
				end

				arg_122_1.text_.text = var_125_28
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108111", "108111030", "story_v_out_108111.awb") ~= 0 then
					local var_125_32 = manager.audio:GetVoiceLength("story_v_out_108111", "108111030", "story_v_out_108111.awb") / 1000

					if var_125_32 + var_125_24 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_32 + var_125_24
					end

					if var_125_27.prefab_name ~= "" and arg_122_1.actors_[var_125_27.prefab_name] ~= nil then
						local var_125_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_27.prefab_name].transform, "story_v_out_108111", "108111030", "story_v_out_108111.awb")

						arg_122_1:RecordAudio("108111030", var_125_33)
						arg_122_1:RecordAudio("108111030", var_125_33)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_108111", "108111030", "story_v_out_108111.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_108111", "108111030", "story_v_out_108111.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_34 = math.max(var_125_25, arg_122_1.talkMaxDuration)

			if var_125_24 <= arg_122_1.time_ and arg_122_1.time_ < var_125_24 + var_125_34 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_24) / var_125_34

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_24 + var_125_34 and arg_122_1.time_ < var_125_24 + var_125_34 + arg_125_0 then
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
