return {
	Play108061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 108061001
		arg_1_1.duration_ = 5.33

		local var_1_0 = {
			ja = 4.2,
			ko = 5.333,
			zh = 4.633,
			en = 5.066
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
				arg_1_0:Play108061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.S0802 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0802")
				var_4_0.name = "S0802"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.S0802 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.S0802

				arg_1_1.bgs_.S0802.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0802" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.S0802:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueS0802 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueS0802 = var_4_4
				end

				arg_1_1.var_.alphaOldValueS0802 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueS0802 then
					arg_1_1.var_.alphaMatValueS0802.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueS0802, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueS0802.color = arg_1_1.var_.alphaMatValueS0802.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueS0802 then
				arg_1_1.var_.alphaMatValueS0802.color.a = 1
				arg_1_1.var_.alphaMatValueS0802.color = arg_1_1.var_.alphaMatValueS0802.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_8 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_8 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_8

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_8
						arg_1_1.bgmTxt2_.text = var_4_8
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

			local var_4_9 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_9 + 2 and arg_1_1.time_ < var_4_9 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_10 = 2
			local var_4_11 = 0.35

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_12 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_12:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_13 = arg_1_1:GetWordFromCfg(108061001)
				local var_4_14 = arg_1_1:FormatText(var_4_13.content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 14 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_14) / 14)

				if (14 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_14) / 14)) > 0 and var_4_11 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_10 = var_4_10 + 0.3

					if var_4_16 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_10
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061001", "story_v_out_108061.awb") ~= 0 then
					local var_4_17 = manager.audio:GetVoiceLength("story_v_out_108061", "108061001", "story_v_out_108061.awb") / 1000

					if var_4_17 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_10
					end

					if var_4_13.prefab_name ~= "" and arg_1_1.actors_[var_4_13.prefab_name] ~= nil then
						local var_4_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_13.prefab_name].transform, "story_v_out_108061", "108061001", "story_v_out_108061.awb")

						arg_1_1:RecordAudio("108061001", var_4_18)
						arg_1_1:RecordAudio("108061001", var_4_18)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_108061", "108061001", "story_v_out_108061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_108061", "108061001", "story_v_out_108061.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_10 + 0.3
			local var_4_20 = math.max(var_4_11, arg_1_1.talkMaxDuration)

			if var_4_10 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play108061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 108061002
		arg_8_1.duration_ = 3.83

		local var_8_0 = {
			ja = 2.633,
			ko = 2.633,
			zh = 3.833,
			en = 3.1
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
				arg_8_0:Play108061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.35

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:GetWordFromCfg(108061002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 6 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 6)

				if (6 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 6)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061002", "story_v_out_108061.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061002", "story_v_out_108061.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_108061", "108061002", "story_v_out_108061.awb")

						arg_8_1:RecordAudio("108061002", var_11_6)
						arg_8_1:RecordAudio("108061002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_108061", "108061002", "story_v_out_108061.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_108061", "108061002", "story_v_out_108061.awb")
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
	Play108061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 108061003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play108061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.95

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(108061003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 38 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 38)

				if (38 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 38)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play108061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 108061004
		arg_16_1.duration_ = 4.3

		local var_16_0 = {
			ja = 1.5,
			ko = 4.3,
			zh = 3.966,
			en = 3.7
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
				arg_16_0:Play108061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.45

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:GetWordFromCfg(108061004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 18 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 18)

				if (18 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 18)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061004", "story_v_out_108061.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061004", "story_v_out_108061.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_108061", "108061004", "story_v_out_108061.awb")

						arg_16_1:RecordAudio("108061004", var_19_6)
						arg_16_1:RecordAudio("108061004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_108061", "108061004", "story_v_out_108061.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_108061", "108061004", "story_v_out_108061.awb")
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
	Play108061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 108061005
		arg_20_1.duration_ = 4.3

		local var_20_0 = {
			ja = 3.233,
			ko = 3.6,
			zh = 4,
			en = 4.3
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
				arg_20_0:Play108061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.4

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:GetWordFromCfg(108061005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 16 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 16)

				if (16 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 16)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061005", "story_v_out_108061.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061005", "story_v_out_108061.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_108061", "108061005", "story_v_out_108061.awb")

						arg_20_1:RecordAudio("108061005", var_23_6)
						arg_20_1:RecordAudio("108061005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_108061", "108061005", "story_v_out_108061.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_108061", "108061005", "story_v_out_108061.awb")
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
	Play108061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 108061006
		arg_24_1.duration_ = 9.1

		local var_24_0 = {
			ja = 1.766,
			ko = 8.4,
			zh = 8.833,
			en = 9.1
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
				arg_24_0:Play108061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 1.05

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(108061006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 43 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 43)

				if (43 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 43)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061006", "story_v_out_108061.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061006", "story_v_out_108061.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_108061", "108061006", "story_v_out_108061.awb")

						arg_24_1:RecordAudio("108061006", var_27_6)
						arg_24_1:RecordAudio("108061006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_108061", "108061006", "story_v_out_108061.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_108061", "108061006", "story_v_out_108061.awb")
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
	Play108061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 108061007
		arg_28_1.duration_ = 6.63

		local var_28_0 = {
			ja = 6.633,
			ko = 5.866,
			zh = 4.6,
			en = 5.6
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
				arg_28_0:Play108061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.575

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:GetWordFromCfg(108061007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 23 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 23)

				if (23 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 23)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061007", "story_v_out_108061.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061007", "story_v_out_108061.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_108061", "108061007", "story_v_out_108061.awb")

						arg_28_1:RecordAudio("108061007", var_31_6)
						arg_28_1:RecordAudio("108061007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_108061", "108061007", "story_v_out_108061.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_108061", "108061007", "story_v_out_108061.awb")
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
	Play108061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 108061008
		arg_32_1.duration_ = 7.5

		local var_32_0 = {
			ja = 2.633,
			ko = 1.933,
			zh = 7.5,
			en = 2.533
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
				arg_32_0:Play108061009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.15

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:GetWordFromCfg(108061008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 6 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 6)

				if (6 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 6)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061008", "story_v_out_108061.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061008", "story_v_out_108061.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_108061", "108061008", "story_v_out_108061.awb")

						arg_32_1:RecordAudio("108061008", var_35_6)
						arg_32_1:RecordAudio("108061008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_108061", "108061008", "story_v_out_108061.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_108061", "108061008", "story_v_out_108061.awb")
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
	Play108061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 108061009
		arg_36_1.duration_ = 14.43

		local var_36_0 = {
			ja = 3.466,
			ko = 8.1,
			zh = 14.433,
			en = 6
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
				arg_36_0:Play108061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.425

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:GetWordFromCfg(108061009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 17 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 17)

				if (17 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 17)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061009", "story_v_out_108061.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061009", "story_v_out_108061.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_108061", "108061009", "story_v_out_108061.awb")

						arg_36_1:RecordAudio("108061009", var_39_6)
						arg_36_1:RecordAudio("108061009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_108061", "108061009", "story_v_out_108061.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_108061", "108061009", "story_v_out_108061.awb")
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
	Play108061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 108061010
		arg_40_1.duration_ = 11.37

		local var_40_0 = {
			ja = 8.233,
			ko = 4.766,
			zh = 11.366,
			en = 7.433
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
				arg_40_0:Play108061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.35

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[162].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:GetWordFromCfg(108061010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 14 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 14)

				if (14 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 14)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061010", "story_v_out_108061.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061010", "story_v_out_108061.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_108061", "108061010", "story_v_out_108061.awb")

						arg_40_1:RecordAudio("108061010", var_43_6)
						arg_40_1:RecordAudio("108061010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_108061", "108061010", "story_v_out_108061.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_108061", "108061010", "story_v_out_108061.awb")
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
	Play108061011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 108061011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play108061012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.35

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(108061011).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 14 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 14)

				if (14 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 14)) > 0 and var_47_0 < var_47_3 then
					arg_44_1.talkMaxDuration = var_47_3

					if var_47_3 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_3 + 0
					end
				end

				arg_44_1.text_.text = var_47_1
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_4 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_4

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play108061012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 108061012
		arg_48_1.duration_ = 4.03

		local var_48_0 = {
			ja = 1.8,
			ko = 3.1,
			zh = 3.066,
			en = 4.033
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
				arg_48_0:Play108061013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.35

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_1 = arg_48_1:GetWordFromCfg(108061012)
				local var_51_2 = arg_48_1:FormatText(var_51_1.content)

				arg_48_1.text_.text = var_51_2

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 14 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 14)

				if (14 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 14)) > 0 and var_51_0 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + 0
					end
				end

				arg_48_1.text_.text = var_51_2
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061012", "story_v_out_108061.awb") ~= 0 then
					local var_51_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061012", "story_v_out_108061.awb") / 1000

					if var_51_5 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + 0
					end

					if var_51_1.prefab_name ~= "" and arg_48_1.actors_[var_51_1.prefab_name] ~= nil then
						local var_51_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_1.prefab_name].transform, "story_v_out_108061", "108061012", "story_v_out_108061.awb")

						arg_48_1:RecordAudio("108061012", var_51_6)
						arg_48_1:RecordAudio("108061012", var_51_6)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_108061", "108061012", "story_v_out_108061.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_108061", "108061012", "story_v_out_108061.awb")
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
	Play108061013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 108061013
		arg_52_1.duration_ = 4.2

		local var_52_0 = {
			ja = 3.266,
			ko = 4,
			zh = 3.833,
			en = 4.2
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
				arg_52_0:Play108061014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if arg_52_1.bgs_.S0803 == nil then
				local var_55_0 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0803")
				var_55_0.name = "S0803"
				var_55_0.transform.parent = arg_52_1.stage_.transform
				var_55_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_.S0803 = var_55_0
			end

			if 1.5 < arg_52_1.time_ and arg_52_1.time_ <= 1.5 + arg_55_0 then
				local var_55_1 = arg_52_1.bgs_.S0803

				arg_52_1.bgs_.S0803.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_55_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_2 = var_55_1:GetComponent("SpriteRenderer")

				if var_55_2 and var_55_2.sprite then
					local var_55_3 = 2 * (var_55_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_55_1.transform.localScale = Vector3.New(var_55_3 / var_55_2.sprite.bounds.size.y < var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x and var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x or var_55_3 / var_55_2.sprite.bounds.size.y, var_55_3 / var_55_2.sprite.bounds.size.y < var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x and var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x or var_55_3 / var_55_2.sprite.bounds.size.y, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "S0803" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				local var_55_4 = arg_52_1.bgs_.S0802:GetComponent("SpriteRenderer")

				if var_55_4 then
					arg_52_1.var_.alphaOldValueS0802 = var_55_4.color.a
					arg_52_1.var_.alphaMatValueS0802 = var_55_4
				end

				arg_52_1.var_.alphaOldValueS0802 = 1
			end

			local var_55_5 = 1.5

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_5 then
				if arg_52_1.var_.alphaMatValueS0802 then
					arg_52_1.var_.alphaMatValueS0802.color.a = Mathf.Lerp(arg_52_1.var_.alphaOldValueS0802, 0, (arg_52_1.time_ - 0) / var_55_5)
					arg_52_1.var_.alphaMatValueS0802.color = arg_52_1.var_.alphaMatValueS0802.color
				end
			end

			if arg_52_1.time_ >= 0 + var_55_5 and arg_52_1.time_ < 0 + var_55_5 + arg_55_0 and arg_52_1.var_.alphaMatValueS0802 then
				arg_52_1.var_.alphaMatValueS0802.color.a = 0
				arg_52_1.var_.alphaMatValueS0802.color = arg_52_1.var_.alphaMatValueS0802.color
			end

			if 1.5 < arg_52_1.time_ and arg_52_1.time_ <= 1.5 + arg_55_0 then
				local var_55_6 = arg_52_1.bgs_.S0803:GetComponent("SpriteRenderer")

				if var_55_6 then
					arg_52_1.var_.alphaOldValueS0803 = var_55_6.color.a
					arg_52_1.var_.alphaMatValueS0803 = var_55_6
				end

				arg_52_1.var_.alphaOldValueS0803 = 0
			end

			local var_55_7 = 1.5

			if 1.5 <= arg_52_1.time_ and arg_52_1.time_ < 1.5 + var_55_7 then
				if arg_52_1.var_.alphaMatValueS0803 then
					arg_52_1.var_.alphaMatValueS0803.color.a = Mathf.Lerp(arg_52_1.var_.alphaOldValueS0803, 1, (arg_52_1.time_ - 1.5) / var_55_7)
					arg_52_1.var_.alphaMatValueS0803.color = arg_52_1.var_.alphaMatValueS0803.color
				end
			end

			if arg_52_1.time_ >= 1.5 + var_55_7 and arg_52_1.time_ < 1.5 + var_55_7 + arg_55_0 and arg_52_1.var_.alphaMatValueS0803 then
				arg_52_1.var_.alphaMatValueS0803.color.a = 1
				arg_52_1.var_.alphaMatValueS0803.color = arg_52_1.var_.alphaMatValueS0803.color
			end

			local var_55_8 = arg_52_1.bgs_.S0802.transform

			if 1.5 < arg_52_1.time_ and arg_52_1.time_ <= 1.5 + arg_55_0 then
				arg_52_1.var_.moveOldPosS0802 = var_55_8.localPosition
			end

			local var_55_9 = 0.001

			if 1.5 <= arg_52_1.time_ and arg_52_1.time_ < 1.5 + var_55_9 then
				var_55_8.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosS0802, Vector3.New(0, 100, 0), (arg_52_1.time_ - 1.5) / var_55_9)
			end

			if arg_52_1.time_ >= 1.5 + var_55_9 and arg_52_1.time_ < 1.5 + var_55_9 + arg_55_0 then
				var_55_8.localPosition = Vector3.New(0, 100, 0)
			end

			local var_55_10 = 0

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			if arg_52_1.time_ >= var_55_10 + 1.5 and arg_52_1.time_ < var_55_10 + 1.5 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_11 = 1.5
			local var_55_12 = 0.2

			if 1.5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_13 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_13:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_14 = arg_52_1:GetWordFromCfg(108061013)
				local var_55_15 = arg_52_1:FormatText(var_55_14.content)

				arg_52_1.text_.text = var_55_15

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_17 = 8 <= 0 and var_55_12 or var_55_12 * (utf8.len(var_55_15) / 8)

				if (8 <= 0 and var_55_12 or var_55_12 * (utf8.len(var_55_15) / 8)) > 0 and var_55_12 < var_55_17 then
					arg_52_1.talkMaxDuration = var_55_17
					var_55_11 = var_55_11 + 0.3

					if var_55_17 + var_55_11 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_17 + var_55_11
					end
				end

				arg_52_1.text_.text = var_55_15
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061013", "story_v_out_108061.awb") ~= 0 then
					local var_55_18 = manager.audio:GetVoiceLength("story_v_out_108061", "108061013", "story_v_out_108061.awb") / 1000

					if var_55_18 + var_55_11 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_18 + var_55_11
					end

					if var_55_14.prefab_name ~= "" and arg_52_1.actors_[var_55_14.prefab_name] ~= nil then
						local var_55_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_14.prefab_name].transform, "story_v_out_108061", "108061013", "story_v_out_108061.awb")

						arg_52_1:RecordAudio("108061013", var_55_19)
						arg_52_1:RecordAudio("108061013", var_55_19)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_108061", "108061013", "story_v_out_108061.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_108061", "108061013", "story_v_out_108061.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_20 = var_55_11 + 0.3
			local var_55_21 = math.max(var_55_12, arg_52_1.talkMaxDuration)

			if var_55_11 + 0.3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_20 + var_55_21 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_20) / var_55_21

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_20 + var_55_21 and arg_52_1.time_ < var_55_20 + var_55_21 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0802",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play108061014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 108061014
		arg_58_1.duration_ = 4.63

		local var_58_0 = {
			ja = 3.266,
			ko = 1.866,
			zh = 1.766,
			en = 4.633
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
				arg_58_0:Play108061015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.2

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_1 = arg_58_1:GetWordFromCfg(108061014)
				local var_61_2 = arg_58_1:FormatText(var_61_1.content)

				arg_58_1.text_.text = var_61_2

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 8 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 8)

				if (8 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 8)) > 0 and var_61_0 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end

				arg_58_1.text_.text = var_61_2
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061014", "story_v_out_108061.awb") ~= 0 then
					local var_61_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061014", "story_v_out_108061.awb") / 1000

					if var_61_5 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + 0
					end

					if var_61_1.prefab_name ~= "" and arg_58_1.actors_[var_61_1.prefab_name] ~= nil then
						local var_61_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_1.prefab_name].transform, "story_v_out_108061", "108061014", "story_v_out_108061.awb")

						arg_58_1:RecordAudio("108061014", var_61_6)
						arg_58_1:RecordAudio("108061014", var_61_6)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_108061", "108061014", "story_v_out_108061.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_108061", "108061014", "story_v_out_108061.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play108061015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 108061015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play108061016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.75

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(108061015).content)

				arg_62_1.text_.text = var_65_1

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_3 = 30 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 30)

				if (30 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 30)) > 0 and var_65_0 < var_65_3 then
					arg_62_1.talkMaxDuration = var_65_3

					if var_65_3 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_3 + 0
					end
				end

				arg_62_1.text_.text = var_65_1
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_4 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_4

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play108061016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 108061016
		arg_66_1.duration_ = 8.8

		local var_66_0 = {
			ja = 4.666,
			ko = 8.8,
			zh = 6.966,
			en = 6
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
				arg_66_0:Play108061017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.775

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:GetWordFromCfg(108061016)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 31 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 31)

				if (31 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 31)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061016", "story_v_out_108061.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061016", "story_v_out_108061.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_108061", "108061016", "story_v_out_108061.awb")

						arg_66_1:RecordAudio("108061016", var_69_6)
						arg_66_1:RecordAudio("108061016", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_108061", "108061016", "story_v_out_108061.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_108061", "108061016", "story_v_out_108061.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play108061017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 108061017
		arg_70_1.duration_ = 14.7

		local var_70_0 = {
			ja = 13.8,
			ko = 14.7,
			zh = 12.3,
			en = 14.566
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
				arg_70_0:Play108061018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 1.35

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_1 = arg_70_1:GetWordFromCfg(108061017)
				local var_73_2 = arg_70_1:FormatText(var_73_1.content)

				arg_70_1.text_.text = var_73_2

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 54 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 54)

				if (54 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 54)) > 0 and var_73_0 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end

				arg_70_1.text_.text = var_73_2
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061017", "story_v_out_108061.awb") ~= 0 then
					local var_73_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061017", "story_v_out_108061.awb") / 1000

					if var_73_5 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + 0
					end

					if var_73_1.prefab_name ~= "" and arg_70_1.actors_[var_73_1.prefab_name] ~= nil then
						local var_73_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_1.prefab_name].transform, "story_v_out_108061", "108061017", "story_v_out_108061.awb")

						arg_70_1:RecordAudio("108061017", var_73_6)
						arg_70_1:RecordAudio("108061017", var_73_6)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_108061", "108061017", "story_v_out_108061.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_108061", "108061017", "story_v_out_108061.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play108061018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 108061018
		arg_74_1.duration_ = 3.9

		local var_74_0 = {
			ja = 3.333,
			ko = 3,
			zh = 3.866,
			en = 3.9
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
				arg_74_0:Play108061019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.525

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_1 = arg_74_1:GetWordFromCfg(108061018)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 21 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 21)

				if (21 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 21)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061018", "story_v_out_108061.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061018", "story_v_out_108061.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_108061", "108061018", "story_v_out_108061.awb")

						arg_74_1:RecordAudio("108061018", var_77_6)
						arg_74_1:RecordAudio("108061018", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_108061", "108061018", "story_v_out_108061.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_108061", "108061018", "story_v_out_108061.awb")
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
	Play108061019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 108061019
		arg_78_1.duration_ = 7.43

		local var_78_0 = {
			ja = 5.9,
			ko = 6.1,
			zh = 5.6,
			en = 7.433
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play108061020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				local var_81_0 = arg_78_1.bgs_.S0803

				arg_78_1.bgs_.S0803.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_81_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_1 = var_81_0:GetComponent("SpriteRenderer")

				if var_81_1 and var_81_1.sprite then
					local var_81_2 = 2 * (var_81_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_81_0.transform.localScale = Vector3.New(var_81_2 / var_81_1.sprite.bounds.size.y < var_81_2 * manager.ui.mainCameraCom_.aspect / var_81_1.sprite.bounds.size.x and var_81_2 * manager.ui.mainCameraCom_.aspect / var_81_1.sprite.bounds.size.x or var_81_2 / var_81_1.sprite.bounds.size.y, var_81_2 / var_81_1.sprite.bounds.size.y < var_81_2 * manager.ui.mainCameraCom_.aspect / var_81_1.sprite.bounds.size.x and var_81_2 * manager.ui.mainCameraCom_.aspect / var_81_1.sprite.bounds.size.x or var_81_2 / var_81_1.sprite.bounds.size.y, 0)
				end

				for iter_81_0, iter_81_1 in pairs(arg_78_1.bgs_) do
					if iter_81_0 ~= "S0803" then
						iter_81_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_3 = "C06c"

			if arg_78_1.bgs_.C06c == nil then
				local var_81_4 = Object.Instantiate(arg_78_1.paintGo_)

				var_81_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_81_3)
				var_81_4.name = var_81_3
				var_81_4.transform.parent = arg_78_1.stage_.transform
				var_81_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.bgs_[var_81_3] = var_81_4
			end

			if 1.5 < arg_78_1.time_ and arg_78_1.time_ <= 1.5 + arg_81_0 then
				local var_81_5 = arg_78_1.bgs_.C06c

				arg_78_1.bgs_.C06c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_81_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_6 = var_81_5:GetComponent("SpriteRenderer")

				if var_81_6 and var_81_6.sprite then
					local var_81_7 = 2 * (var_81_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_81_5.transform.localScale = Vector3.New(var_81_7 / var_81_6.sprite.bounds.size.y < var_81_7 * manager.ui.mainCameraCom_.aspect / var_81_6.sprite.bounds.size.x and var_81_7 * manager.ui.mainCameraCom_.aspect / var_81_6.sprite.bounds.size.x or var_81_7 / var_81_6.sprite.bounds.size.y, var_81_7 / var_81_6.sprite.bounds.size.y < var_81_7 * manager.ui.mainCameraCom_.aspect / var_81_6.sprite.bounds.size.x and var_81_7 * manager.ui.mainCameraCom_.aspect / var_81_6.sprite.bounds.size.x or var_81_7 / var_81_6.sprite.bounds.size.y, 0)
				end

				for iter_81_2, iter_81_3 in pairs(arg_78_1.bgs_) do
					if iter_81_2 ~= "C06c" then
						iter_81_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				local var_81_8 = arg_78_1.bgs_.S0803:GetComponent("SpriteRenderer")

				if var_81_8 then
					arg_78_1.var_.alphaOldValueS0803 = var_81_8.color.a
					arg_78_1.var_.alphaMatValueS0803 = var_81_8
				end

				arg_78_1.var_.alphaOldValueS0803 = 1
			end

			local var_81_9 = 1.5

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_9 then
				if arg_78_1.var_.alphaMatValueS0803 then
					arg_78_1.var_.alphaMatValueS0803.color.a = Mathf.Lerp(arg_78_1.var_.alphaOldValueS0803, 0, (arg_78_1.time_ - 0) / var_81_9)
					arg_78_1.var_.alphaMatValueS0803.color = arg_78_1.var_.alphaMatValueS0803.color
				end
			end

			if arg_78_1.time_ >= 0 + var_81_9 and arg_78_1.time_ < 0 + var_81_9 + arg_81_0 and arg_78_1.var_.alphaMatValueS0803 then
				arg_78_1.var_.alphaMatValueS0803.color.a = 0
				arg_78_1.var_.alphaMatValueS0803.color = arg_78_1.var_.alphaMatValueS0803.color
			end

			if 1.5 < arg_78_1.time_ and arg_78_1.time_ <= 1.5 + arg_81_0 then
				local var_81_10 = arg_78_1.bgs_.C06c:GetComponent("SpriteRenderer")

				if var_81_10 then
					arg_78_1.var_.alphaOldValueC06c = var_81_10.color.a
					arg_78_1.var_.alphaMatValueC06c = var_81_10
				end

				arg_78_1.var_.alphaOldValueC06c = 0
			end

			local var_81_11 = 1.5

			if 1.5 <= arg_78_1.time_ and arg_78_1.time_ < 1.5 + var_81_11 then
				if arg_78_1.var_.alphaMatValueC06c then
					arg_78_1.var_.alphaMatValueC06c.color.a = Mathf.Lerp(arg_78_1.var_.alphaOldValueC06c, 1, (arg_78_1.time_ - 1.5) / var_81_11)
					arg_78_1.var_.alphaMatValueC06c.color = arg_78_1.var_.alphaMatValueC06c.color
				end
			end

			if arg_78_1.time_ >= 1.5 + var_81_11 and arg_78_1.time_ < 1.5 + var_81_11 + arg_81_0 and arg_78_1.var_.alphaMatValueC06c then
				arg_78_1.var_.alphaMatValueC06c.color.a = 1
				arg_78_1.var_.alphaMatValueC06c.color = arg_78_1.var_.alphaMatValueC06c.color
			end

			local var_81_12 = "1050ui_story"

			if arg_78_1.actors_["1050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1050ui_story"))) then
				local var_81_13 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_78_1.stage_.transform)

				var_81_13.name = var_81_12
				var_81_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.actors_[var_81_12] = var_81_13

				local var_81_14 = var_81_13:GetComponentInChildren(typeof(CharacterEffect))

				var_81_14.enabled = true

				local var_81_15 = GameObjectTools.GetOrAddComponent(var_81_13, typeof(DynamicBoneHelper))

				if var_81_15 then
					var_81_15:EnableDynamicBone(false)
				end

				arg_78_1:ShowWeapon(var_81_14.transform, false)

				arg_78_1.var_[var_81_12 .. "Animator"] = var_81_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_78_1.var_[var_81_12 .. "Animator"].applyRootMotion = true
				arg_78_1.var_[var_81_12 .. "LipSync"] = var_81_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_81_16 = arg_78_1.actors_["1050ui_story"]

			if 1.8 < arg_78_1.time_ and arg_78_1.time_ <= 1.8 + arg_81_0 and not isNil(var_81_16) and arg_78_1.var_.characterEffect1050ui_story == nil then
				arg_78_1.var_.characterEffect1050ui_story = var_81_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_17 = 0.0166666666666667

			if 1.8 <= arg_78_1.time_ and arg_78_1.time_ < 1.8 + var_81_17 and not isNil(var_81_16) then
				if arg_78_1.var_.characterEffect1050ui_story and not isNil(var_81_16) then
					arg_78_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 1.8 + var_81_17 and arg_78_1.time_ < 1.8 + var_81_17 + arg_81_0 and not isNil(var_81_16) and arg_78_1.var_.characterEffect1050ui_story then
				arg_78_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_81_19 = arg_78_1.actors_["1050ui_story"].transform

			if 1.8 < arg_78_1.time_ and arg_78_1.time_ <= 1.8 + arg_81_0 then
				arg_78_1.var_.moveOldPos1050ui_story = var_81_19.localPosition
			end

			local var_81_20 = 0.001

			if 1.8 <= arg_78_1.time_ and arg_78_1.time_ < 1.8 + var_81_20 then
				var_81_19.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_78_1.time_ - 1.8) / var_81_20)
				var_81_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_19.position).x, (manager.ui.mainCamera.transform.position - var_81_19.position).y, (manager.ui.mainCamera.transform.position - var_81_19.position).z)
				var_81_19.localEulerAngles.z = 0
				var_81_19.localEulerAngles.x = 0
				var_81_19.localEulerAngles = var_81_19.localEulerAngles
			end

			if arg_78_1.time_ >= 1.8 + var_81_20 and arg_78_1.time_ < 1.8 + var_81_20 + arg_81_0 then
				var_81_19.localPosition = Vector3.New(0, -1, -6.1)
				var_81_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_19.position).x, (manager.ui.mainCamera.transform.position - var_81_19.position).y, (manager.ui.mainCamera.transform.position - var_81_19.position).z)
				var_81_19.localEulerAngles.z = 0
				var_81_19.localEulerAngles.x = 0
				var_81_19.localEulerAngles = var_81_19.localEulerAngles
			end

			if 1.8 < arg_78_1.time_ and arg_78_1.time_ <= 1.8 + arg_81_0 then
				arg_78_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			if 1.8 < arg_78_1.time_ and arg_78_1.time_ <= 1.8 + arg_81_0 then
				arg_78_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_81_21 = 0

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_21 + arg_81_0 then
				arg_78_1.allBtn_.enabled = false
			end

			if arg_78_1.time_ >= var_81_21 + 2 and arg_78_1.time_ < var_81_21 + 2 + arg_81_0 then
				arg_78_1.allBtn_.enabled = true
			end

			if arg_78_1.frameCnt_ <= 1 then
				arg_78_1.dialog_:SetActive(false)
			end

			local var_81_22 = 2
			local var_81_23 = 0.35

			if 2 < arg_78_1.time_ and arg_78_1.time_ <= var_81_22 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_24 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_24:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_25 = arg_78_1:GetWordFromCfg(108061019)
				local var_81_26 = arg_78_1:FormatText(var_81_25.content)

				arg_78_1.text_.text = var_81_26

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_28 = 14 <= 0 and var_81_23 or var_81_23 * (utf8.len(var_81_26) / 14)

				if (14 <= 0 and var_81_23 or var_81_23 * (utf8.len(var_81_26) / 14)) > 0 and var_81_23 < var_81_28 then
					arg_78_1.talkMaxDuration = var_81_28
					var_81_22 = var_81_22 + 0.3

					if var_81_28 + var_81_22 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_28 + var_81_22
					end
				end

				arg_78_1.text_.text = var_81_26
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061019", "story_v_out_108061.awb") ~= 0 then
					local var_81_29 = manager.audio:GetVoiceLength("story_v_out_108061", "108061019", "story_v_out_108061.awb") / 1000

					if var_81_29 + var_81_22 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_29 + var_81_22
					end

					if var_81_25.prefab_name ~= "" and arg_78_1.actors_[var_81_25.prefab_name] ~= nil then
						local var_81_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_25.prefab_name].transform, "story_v_out_108061", "108061019", "story_v_out_108061.awb")

						arg_78_1:RecordAudio("108061019", var_81_30)
						arg_78_1:RecordAudio("108061019", var_81_30)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_108061", "108061019", "story_v_out_108061.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_108061", "108061019", "story_v_out_108061.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_31 = var_81_22 + 0.3
			local var_81_32 = math.max(var_81_23, arg_78_1.talkMaxDuration)

			if var_81_22 + 0.3 <= arg_78_1.time_ and arg_78_1.time_ < var_81_31 + var_81_32 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_31) / var_81_32

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_31 + var_81_32 and arg_78_1.time_ < var_81_31 + var_81_32 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play108061020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 108061020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play108061021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1050ui_story = arg_84_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_87_0 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				arg_84_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1050ui_story"].transform.position).z)
				arg_84_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1050ui_story"].transform.localEulerAngles = arg_84_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				arg_84_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1050ui_story"].transform.position).z)
				arg_84_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1050ui_story"].transform.localEulerAngles = arg_84_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_87_1 = 0
			local var_87_2 = 1.175

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(108061020).content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 47 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 47)

				if (47 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 47)) > 0 and var_87_2 < var_87_5 then
					arg_84_1.talkMaxDuration = var_87_5

					if var_87_5 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_6 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_6 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_6

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_6 and arg_84_1.time_ < var_87_1 + var_87_6 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play108061021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 108061021
		arg_88_1.duration_ = 4.73

		local var_88_0 = {
			ja = 2.866,
			ko = 4.733,
			zh = 4.633,
			en = 2.533
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play108061022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.325

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3014")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_1 = arg_88_1:GetWordFromCfg(108061021)
				local var_91_2 = arg_88_1:FormatText(var_91_1.content)

				arg_88_1.text_.text = var_91_2

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 13 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 13)

				if (13 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 13)) > 0 and var_91_0 < var_91_4 then
					arg_88_1.talkMaxDuration = var_91_4

					if var_91_4 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_4 + 0
					end
				end

				arg_88_1.text_.text = var_91_2
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061021", "story_v_out_108061.awb") ~= 0 then
					local var_91_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061021", "story_v_out_108061.awb") / 1000

					if var_91_5 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + 0
					end

					if var_91_1.prefab_name ~= "" and arg_88_1.actors_[var_91_1.prefab_name] ~= nil then
						local var_91_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_1.prefab_name].transform, "story_v_out_108061", "108061021", "story_v_out_108061.awb")

						arg_88_1:RecordAudio("108061021", var_91_6)
						arg_88_1:RecordAudio("108061021", var_91_6)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_108061", "108061021", "story_v_out_108061.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_108061", "108061021", "story_v_out_108061.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play108061022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 108061022
		arg_92_1.duration_ = 2

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play108061023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if arg_92_1.actors_["1099ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1099ui_story"))) then
				local var_95_0 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_92_1.stage_.transform)

				var_95_0.name = "1099ui_story"
				var_95_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["1099ui_story"] = var_95_0

				local var_95_1 = var_95_0:GetComponentInChildren(typeof(CharacterEffect))

				var_95_1.enabled = true

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end

				arg_92_1:ShowWeapon(var_95_1.transform, false)

				arg_92_1.var_["1099ui_story" .. "Animator"] = var_95_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_92_1.var_["1099ui_story" .. "Animator"].applyRootMotion = true
				arg_92_1.var_["1099ui_story" .. "LipSync"] = var_95_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_95_3 = arg_92_1.actors_["1099ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect1099ui_story == nil then
				arg_92_1.var_.characterEffect1099ui_story = var_95_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_4 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 and not isNil(var_95_3) then
				if arg_92_1.var_.characterEffect1099ui_story and not isNil(var_95_3) then
					arg_92_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect1099ui_story then
				arg_92_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_95_6 = arg_92_1.actors_["1099ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1099ui_story = var_95_6.localPosition
			end

			local var_95_7 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				var_95_6.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_92_1.time_ - 0) / var_95_7)
				var_95_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_6.position).x, (manager.ui.mainCamera.transform.position - var_95_6.position).y, (manager.ui.mainCamera.transform.position - var_95_6.position).z)
				var_95_6.localEulerAngles.z = 0
				var_95_6.localEulerAngles.x = 0
				var_95_6.localEulerAngles = var_95_6.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				var_95_6.localPosition = Vector3.New(0, -1.08, -5.9)
				var_95_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_6.position).x, (manager.ui.mainCamera.transform.position - var_95_6.position).y, (manager.ui.mainCamera.transform.position - var_95_6.position).z)
				var_95_6.localEulerAngles.z = 0
				var_95_6.localEulerAngles.x = 0
				var_95_6.localEulerAngles = var_95_6.localEulerAngles
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_95_8 = 0
			local var_95_9 = 0.2

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_10 = arg_92_1:GetWordFromCfg(108061022)
				local var_95_11 = arg_92_1:FormatText(var_95_10.content)

				arg_92_1.text_.text = var_95_11

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 4 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 4)

				if (4 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 4)) > 0 and var_95_9 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_8
					end
				end

				arg_92_1.text_.text = var_95_11
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061022", "story_v_out_108061.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_108061", "108061022", "story_v_out_108061.awb") / 1000

					if var_95_14 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_8
					end

					if var_95_10.prefab_name ~= "" and arg_92_1.actors_[var_95_10.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_10.prefab_name].transform, "story_v_out_108061", "108061022", "story_v_out_108061.awb")

						arg_92_1:RecordAudio("108061022", var_95_15)
						arg_92_1:RecordAudio("108061022", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_108061", "108061022", "story_v_out_108061.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_108061", "108061022", "story_v_out_108061.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_9, arg_92_1.talkMaxDuration)

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_8) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_8 + var_95_16 and arg_92_1.time_ < var_95_8 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play108061023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 108061023
		arg_96_1.duration_ = 19.23

		local var_96_0 = {
			ja = 13.066,
			ko = 15.666,
			zh = 18.733,
			en = 19.233
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play108061024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if arg_96_1.actors_["3014_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3014_tpose"))) then
				local var_99_0 = Object.Instantiate(Asset.Load("Char/" .. "3014_tpose"), arg_96_1.stage_.transform)

				var_99_0.name = "3014_tpose"
				var_99_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.actors_["3014_tpose"] = var_99_0

				local var_99_1 = var_99_0:GetComponentInChildren(typeof(CharacterEffect))

				var_99_1.enabled = true

				local var_99_2 = GameObjectTools.GetOrAddComponent(var_99_0, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(false)
				end

				arg_96_1:ShowWeapon(var_99_1.transform, false)

				arg_96_1.var_["3014_tpose" .. "Animator"] = var_99_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_96_1.var_["3014_tpose" .. "Animator"].applyRootMotion = true
				arg_96_1.var_["3014_tpose" .. "LipSync"] = var_99_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_99_3 = arg_96_1.actors_["3014_tpose"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_3) and arg_96_1.var_.characterEffect3014_tpose == nil then
				arg_96_1.var_.characterEffect3014_tpose = var_99_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_4 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 and not isNil(var_99_3) then
				if arg_96_1.var_.characterEffect3014_tpose and not isNil(var_99_3) then
					arg_96_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 and not isNil(var_99_3) and arg_96_1.var_.characterEffect3014_tpose then
				arg_96_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_99_6 = arg_96_1.actors_["3014_tpose"].transform

			if 3.60822483003176e-16 < arg_96_1.time_ and arg_96_1.time_ <= 3.60822483003176e-16 + arg_99_0 then
				arg_96_1.var_.moveOldPos3014_tpose = var_99_6.localPosition

				local var_99_7 = GameObjectTools.GetOrAddComponent(var_99_6.gameObject, typeof(DynamicBoneHelper))

				if var_99_7 then
					var_99_7:EnableDynamicBone(false)
				end
			end

			local var_99_8 = 0.001

			if 3.60822483003176e-16 <= arg_96_1.time_ and arg_96_1.time_ < 3.60822483003176e-16 + var_99_8 then
				var_99_6.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos3014_tpose, Vector3.New(0, -2.35, -2.9), (arg_96_1.time_ - 3.60822483003176e-16) / var_99_8)
				var_99_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_6.position).x, (manager.ui.mainCamera.transform.position - var_99_6.position).y, (manager.ui.mainCamera.transform.position - var_99_6.position).z)
				var_99_6.localEulerAngles.z = 0
				var_99_6.localEulerAngles.x = 0
				var_99_6.localEulerAngles = var_99_6.localEulerAngles
			end

			if arg_96_1.time_ >= 3.60822483003176e-16 + var_99_8 and arg_96_1.time_ < 3.60822483003176e-16 + var_99_8 + arg_99_0 then
				var_99_6.localPosition = Vector3.New(0, -2.35, -2.9)
				var_99_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_6.position).x, (manager.ui.mainCamera.transform.position - var_99_6.position).y, (manager.ui.mainCamera.transform.position - var_99_6.position).z)
				var_99_6.localEulerAngles.z = 0
				var_99_6.localEulerAngles.x = 0
				var_99_6.localEulerAngles = var_99_6.localEulerAngles

				local var_99_9 = GameObjectTools.GetOrAddComponent(var_99_6.gameObject, typeof(DynamicBoneHelper))

				if var_99_9 then
					var_99_9:EnableDynamicBone(true)
				end
			end

			local var_99_10 = arg_96_1.actors_["1099ui_story"].transform

			if 3.60822483003176e-16 < arg_96_1.time_ and arg_96_1.time_ <= 3.60822483003176e-16 + arg_99_0 then
				arg_96_1.var_.moveOldPos1099ui_story = var_99_10.localPosition
			end

			local var_99_11 = 0.001

			if 3.60822483003176e-16 <= arg_96_1.time_ and arg_96_1.time_ < 3.60822483003176e-16 + var_99_11 then
				var_99_10.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 3.60822483003176e-16) / var_99_11)
				var_99_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_10.position).x, (manager.ui.mainCamera.transform.position - var_99_10.position).y, (manager.ui.mainCamera.transform.position - var_99_10.position).z)
				var_99_10.localEulerAngles.z = 0
				var_99_10.localEulerAngles.x = 0
				var_99_10.localEulerAngles = var_99_10.localEulerAngles
			end

			if arg_96_1.time_ >= 3.60822483003176e-16 + var_99_11 and arg_96_1.time_ < 3.60822483003176e-16 + var_99_11 + arg_99_0 then
				var_99_10.localPosition = Vector3.New(0, 100, 0)
				var_99_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_10.position).x, (manager.ui.mainCamera.transform.position - var_99_10.position).y, (manager.ui.mainCamera.transform.position - var_99_10.position).z)
				var_99_10.localEulerAngles.z = 0
				var_99_10.localEulerAngles.x = 0
				var_99_10.localEulerAngles = var_99_10.localEulerAngles
			end

			local var_99_12 = 0
			local var_99_13 = 1.475

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_14 = arg_96_1:GetWordFromCfg(108061023)
				local var_99_15 = arg_96_1:FormatText(var_99_14.content)

				arg_96_1.text_.text = var_99_15

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_17 = 59 <= 0 and var_99_13 or var_99_13 * (utf8.len(var_99_15) / 59)

				if (59 <= 0 and var_99_13 or var_99_13 * (utf8.len(var_99_15) / 59)) > 0 and var_99_13 < var_99_17 then
					arg_96_1.talkMaxDuration = var_99_17

					if var_99_17 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_17 + var_99_12
					end
				end

				arg_96_1.text_.text = var_99_15
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061023", "story_v_out_108061.awb") ~= 0 then
					local var_99_18 = manager.audio:GetVoiceLength("story_v_out_108061", "108061023", "story_v_out_108061.awb") / 1000

					if var_99_18 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_18 + var_99_12
					end

					if var_99_14.prefab_name ~= "" and arg_96_1.actors_[var_99_14.prefab_name] ~= nil then
						local var_99_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_14.prefab_name].transform, "story_v_out_108061", "108061023", "story_v_out_108061.awb")

						arg_96_1:RecordAudio("108061023", var_99_19)
						arg_96_1:RecordAudio("108061023", var_99_19)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_108061", "108061023", "story_v_out_108061.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_108061", "108061023", "story_v_out_108061.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_20 = math.max(var_99_13, arg_96_1.talkMaxDuration)

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_20 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_12) / var_99_20

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_12 + var_99_20 and arg_96_1.time_ < var_99_12 + var_99_20 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 3.60822483003176e-16,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 3.60822483003176e-16,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play108061024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 108061024
		arg_100_1.duration_ = 3.3

		local var_100_0 = {
			ja = 3.3,
			ko = 3.1,
			zh = 2.9,
			en = 2.5
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
				arg_100_0:Play108061025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1099ui_story"]) and arg_100_1.var_.characterEffect1099ui_story == nil then
				arg_100_1.var_.characterEffect1099ui_story = arg_100_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1099ui_story"]) then
				if arg_100_1.var_.characterEffect1099ui_story and not isNil(arg_100_1.actors_["1099ui_story"]) then
					arg_100_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1099ui_story"]) and arg_100_1.var_.characterEffect1099ui_story then
				arg_100_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_103_2 = arg_100_1.actors_["1099ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1099ui_story = var_103_2.localPosition
			end

			local var_103_3 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 then
				var_103_2.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_100_1.time_ - 0) / var_103_3)
				var_103_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_2.position).x, (manager.ui.mainCamera.transform.position - var_103_2.position).y, (manager.ui.mainCamera.transform.position - var_103_2.position).z)
				var_103_2.localEulerAngles.z = 0
				var_103_2.localEulerAngles.x = 0
				var_103_2.localEulerAngles = var_103_2.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 then
				var_103_2.localPosition = Vector3.New(0, -1.08, -5.9)
				var_103_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_2.position).x, (manager.ui.mainCamera.transform.position - var_103_2.position).y, (manager.ui.mainCamera.transform.position - var_103_2.position).z)
				var_103_2.localEulerAngles.z = 0
				var_103_2.localEulerAngles.x = 0
				var_103_2.localEulerAngles = var_103_2.localEulerAngles
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_1")
			end

			local var_103_4 = arg_100_1.actors_["3014_tpose"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos3014_tpose = var_103_4.localPosition

				local var_103_5 = GameObjectTools.GetOrAddComponent(var_103_4.gameObject, typeof(DynamicBoneHelper))

				if var_103_5 then
					var_103_5:EnableDynamicBone(false)
				end
			end

			local var_103_6 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_6 then
				var_103_4.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos3014_tpose, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_6)
				var_103_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_4.position).x, (manager.ui.mainCamera.transform.position - var_103_4.position).y, (manager.ui.mainCamera.transform.position - var_103_4.position).z)
				var_103_4.localEulerAngles.z = 0
				var_103_4.localEulerAngles.x = 0
				var_103_4.localEulerAngles = var_103_4.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_6 and arg_100_1.time_ < 0 + var_103_6 + arg_103_0 then
				var_103_4.localPosition = Vector3.New(0, 100, 0)
				var_103_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_4.position).x, (manager.ui.mainCamera.transform.position - var_103_4.position).y, (manager.ui.mainCamera.transform.position - var_103_4.position).z)
				var_103_4.localEulerAngles.z = 0
				var_103_4.localEulerAngles.x = 0
				var_103_4.localEulerAngles = var_103_4.localEulerAngles

				local var_103_7 = GameObjectTools.GetOrAddComponent(var_103_4.gameObject, typeof(DynamicBoneHelper))

				if var_103_7 then
					var_103_7:EnableDynamicBone(true)
				end
			end

			local var_103_8 = 0
			local var_103_9 = 0.35

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_10 = arg_100_1:GetWordFromCfg(108061024)
				local var_103_11 = arg_100_1:FormatText(var_103_10.content)

				arg_100_1.text_.text = var_103_11

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 14 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 14)

				if (14 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 14)) > 0 and var_103_9 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_11
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061024", "story_v_out_108061.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_108061", "108061024", "story_v_out_108061.awb") / 1000

					if var_103_14 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_8
					end

					if var_103_10.prefab_name ~= "" and arg_100_1.actors_[var_103_10.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_10.prefab_name].transform, "story_v_out_108061", "108061024", "story_v_out_108061.awb")

						arg_100_1:RecordAudio("108061024", var_103_15)
						arg_100_1:RecordAudio("108061024", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_108061", "108061024", "story_v_out_108061.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_108061", "108061024", "story_v_out_108061.awb")
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
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play108061025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 108061025
		arg_104_1.duration_ = 9.5

		local var_104_0 = {
			ja = 9.3,
			ko = 9.5,
			zh = 8.466,
			en = 9.2
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
				arg_104_0:Play108061026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos3014_tpose = arg_104_1.actors_["3014_tpose"].transform.localPosition

				local var_107_0 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_0 then
					var_107_0:EnableDynamicBone(false)
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["3014_tpose"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos3014_tpose, Vector3.New(0, -2.35, -2.9), (arg_104_1.time_ - 0) / var_107_1)
				arg_104_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["3014_tpose"].transform.position).z)
				arg_104_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["3014_tpose"].transform.localEulerAngles = arg_104_1.actors_["3014_tpose"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["3014_tpose"].transform.localPosition = Vector3.New(0, -2.35, -2.9)
				arg_104_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["3014_tpose"].transform.position).z)
				arg_104_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["3014_tpose"].transform.localEulerAngles = arg_104_1.actors_["3014_tpose"].transform.localEulerAngles

				local var_107_2 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(true)
				end
			end

			local var_107_3 = arg_104_1.actors_["3014_tpose"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect3014_tpose == nil then
				arg_104_1.var_.characterEffect3014_tpose = var_107_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_4 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 and not isNil(var_107_3) then
				if arg_104_1.var_.characterEffect3014_tpose and not isNil(var_107_3) then
					arg_104_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect3014_tpose then
				arg_104_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_107_6 = arg_104_1.actors_["1099ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1099ui_story = var_107_6.localPosition
			end

			local var_107_7 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				var_107_6.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_104_1.time_ - 0) / var_107_7)
				var_107_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_6.position).x, (manager.ui.mainCamera.transform.position - var_107_6.position).y, (manager.ui.mainCamera.transform.position - var_107_6.position).z)
				var_107_6.localEulerAngles.z = 0
				var_107_6.localEulerAngles.x = 0
				var_107_6.localEulerAngles = var_107_6.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				var_107_6.localPosition = Vector3.New(0, 100, 0)
				var_107_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_6.position).x, (manager.ui.mainCamera.transform.position - var_107_6.position).y, (manager.ui.mainCamera.transform.position - var_107_6.position).z)
				var_107_6.localEulerAngles.z = 0
				var_107_6.localEulerAngles.x = 0
				var_107_6.localEulerAngles = var_107_6.localEulerAngles
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_107_8 = 0
			local var_107_9 = 0.8

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_8 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_10 = arg_104_1:GetWordFromCfg(108061025)
				local var_107_11 = arg_104_1:FormatText(var_107_10.content)

				arg_104_1.text_.text = var_107_11

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_13 = 28 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_11) / 28)

				if (28 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_11) / 28)) > 0 and var_107_9 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_8
					end
				end

				arg_104_1.text_.text = var_107_11
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061025", "story_v_out_108061.awb") ~= 0 then
					local var_107_14 = manager.audio:GetVoiceLength("story_v_out_108061", "108061025", "story_v_out_108061.awb") / 1000

					if var_107_14 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_8
					end

					if var_107_10.prefab_name ~= "" and arg_104_1.actors_[var_107_10.prefab_name] ~= nil then
						local var_107_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_10.prefab_name].transform, "story_v_out_108061", "108061025", "story_v_out_108061.awb")

						arg_104_1:RecordAudio("108061025", var_107_15)
						arg_104_1:RecordAudio("108061025", var_107_15)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_108061", "108061025", "story_v_out_108061.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_108061", "108061025", "story_v_out_108061.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_16 = math.max(var_107_9, arg_104_1.talkMaxDuration)

			if var_107_8 <= arg_104_1.time_ and arg_104_1.time_ < var_107_8 + var_107_16 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_8) / var_107_16

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_8 + var_107_16 and arg_104_1.time_ < var_107_8 + var_107_16 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play108061026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 108061026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play108061027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["3014_tpose"]) and arg_108_1.var_.characterEffect3014_tpose == nil then
				arg_108_1.var_.characterEffect3014_tpose = arg_108_1.actors_["3014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["3014_tpose"]) then
				if arg_108_1.var_.characterEffect3014_tpose and not isNil(arg_108_1.actors_["3014_tpose"]) then
					arg_108_1.var_.characterEffect3014_tpose.fillFlat = true
					arg_108_1.var_.characterEffect3014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["3014_tpose"]) and arg_108_1.var_.characterEffect3014_tpose then
				arg_108_1.var_.characterEffect3014_tpose.fillFlat = true
				arg_108_1.var_.characterEffect3014_tpose.fillRatio = 0.5
			end

			local var_111_1 = 0
			local var_111_2 = 0.95

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

				local var_111_3 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(108061026).content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 38 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 38)

				if (38 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 38)) > 0 and var_111_2 < var_111_5 then
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
	Play108061027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 108061027
		arg_112_1.duration_ = 9.07

		local var_112_0 = {
			ja = 8.5,
			ko = 7.8,
			zh = 9.066,
			en = 6.233
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
				arg_112_0:Play108061028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["3014_tpose"]) and arg_112_1.var_.characterEffect3014_tpose == nil then
				arg_112_1.var_.characterEffect3014_tpose = arg_112_1.actors_["3014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["3014_tpose"]) then
				if arg_112_1.var_.characterEffect3014_tpose and not isNil(arg_112_1.actors_["3014_tpose"]) then
					arg_112_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["3014_tpose"]) and arg_112_1.var_.characterEffect3014_tpose then
				arg_112_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_115_2 = 0
			local var_115_3 = 0.65

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(108061027)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 25 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 25)

				if (25 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 25)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061027", "story_v_out_108061.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_108061", "108061027", "story_v_out_108061.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_108061", "108061027", "story_v_out_108061.awb")

						arg_112_1:RecordAudio("108061027", var_115_9)
						arg_112_1:RecordAudio("108061027", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_108061", "108061027", "story_v_out_108061.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_108061", "108061027", "story_v_out_108061.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play108061028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 108061028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play108061029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["3014_tpose"]) and arg_116_1.var_.characterEffect3014_tpose == nil then
				arg_116_1.var_.characterEffect3014_tpose = arg_116_1.actors_["3014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["3014_tpose"]) then
				if arg_116_1.var_.characterEffect3014_tpose and not isNil(arg_116_1.actors_["3014_tpose"]) then
					arg_116_1.var_.characterEffect3014_tpose.fillFlat = true
					arg_116_1.var_.characterEffect3014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["3014_tpose"]) and arg_116_1.var_.characterEffect3014_tpose then
				arg_116_1.var_.characterEffect3014_tpose.fillFlat = true
				arg_116_1.var_.characterEffect3014_tpose.fillRatio = 0.5
			end

			local var_119_1 = 0
			local var_119_2 = 1.325

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(108061028).content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 53 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 53)

				if (53 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 53)) > 0 and var_119_2 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_6 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_6 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_6

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_6 and arg_116_1.time_ < var_119_1 + var_119_6 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play108061029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 108061029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play108061030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.85

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(108061029).content)

				arg_120_1.text_.text = var_123_1

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_3 = 34 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 34)

				if (34 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 34)) > 0 and var_123_0 < var_123_3 then
					arg_120_1.talkMaxDuration = var_123_3

					if var_123_3 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_3 + 0
					end
				end

				arg_120_1.text_.text = var_123_1
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_4 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_4

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play108061030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 108061030
		arg_124_1.duration_ = 14.37

		local var_124_0 = {
			ja = 13.166,
			ko = 10.666,
			zh = 14.366,
			en = 12.266
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play108061031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["3014_tpose"]) and arg_124_1.var_.characterEffect3014_tpose == nil then
				arg_124_1.var_.characterEffect3014_tpose = arg_124_1.actors_["3014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["3014_tpose"]) then
				if arg_124_1.var_.characterEffect3014_tpose and not isNil(arg_124_1.actors_["3014_tpose"]) then
					arg_124_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["3014_tpose"]) and arg_124_1.var_.characterEffect3014_tpose then
				arg_124_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_127_2 = 0
			local var_127_3 = 1.075

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_2 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_4 = arg_124_1:GetWordFromCfg(108061030)
				local var_127_5 = arg_124_1:FormatText(var_127_4.content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_7 = 43 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 43)

				if (43 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 43)) > 0 and var_127_3 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_2
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061030", "story_v_out_108061.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_108061", "108061030", "story_v_out_108061.awb") / 1000

					if var_127_8 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_2
					end

					if var_127_4.prefab_name ~= "" and arg_124_1.actors_[var_127_4.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_4.prefab_name].transform, "story_v_out_108061", "108061030", "story_v_out_108061.awb")

						arg_124_1:RecordAudio("108061030", var_127_9)
						arg_124_1:RecordAudio("108061030", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_108061", "108061030", "story_v_out_108061.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_108061", "108061030", "story_v_out_108061.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_3, arg_124_1.talkMaxDuration)

			if var_127_2 <= arg_124_1.time_ and arg_124_1.time_ < var_127_2 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_2) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_2 + var_127_10 and arg_124_1.time_ < var_127_2 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play108061031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 108061031
		arg_128_1.duration_ = 10.83

		local var_128_0 = {
			ja = 10.833,
			ko = 9.6,
			zh = 10.8,
			en = 7.5
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
				arg_128_0:Play108061032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.85

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_1 = arg_128_1:GetWordFromCfg(108061031)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 34 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 34)

				if (34 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 34)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061031", "story_v_out_108061.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061031", "story_v_out_108061.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_out_108061", "108061031", "story_v_out_108061.awb")

						arg_128_1:RecordAudio("108061031", var_131_6)
						arg_128_1:RecordAudio("108061031", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_108061", "108061031", "story_v_out_108061.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_108061", "108061031", "story_v_out_108061.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play108061032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 108061032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play108061033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos3014_tpose = arg_132_1.actors_["3014_tpose"].transform.localPosition

				local var_135_0 = GameObjectTools.GetOrAddComponent(arg_132_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_135_0 then
					var_135_0:EnableDynamicBone(false)
				end
			end

			local var_135_1 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_1 then
				arg_132_1.actors_["3014_tpose"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos3014_tpose, Vector3.New(0, 100, 0), (arg_132_1.time_ - 0) / var_135_1)
				arg_132_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["3014_tpose"].transform.position).z)
				arg_132_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["3014_tpose"].transform.localEulerAngles = arg_132_1.actors_["3014_tpose"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_1 and arg_132_1.time_ < 0 + var_135_1 + arg_135_0 then
				arg_132_1.actors_["3014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_132_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["3014_tpose"].transform.position).z)
				arg_132_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["3014_tpose"].transform.localEulerAngles = arg_132_1.actors_["3014_tpose"].transform.localEulerAngles

				local var_135_2 = GameObjectTools.GetOrAddComponent(arg_132_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(true)
				end
			end

			local var_135_3 = 0
			local var_135_4 = 1

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_3 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_5 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(108061032).content)

				arg_132_1.text_.text = var_135_5

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_7 = 40 <= 0 and var_135_4 or var_135_4 * (utf8.len(var_135_5) / 40)

				if (40 <= 0 and var_135_4 or var_135_4 * (utf8.len(var_135_5) / 40)) > 0 and var_135_4 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_3 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_3
					end
				end

				arg_132_1.text_.text = var_135_5
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_8 = math.max(var_135_4, arg_132_1.talkMaxDuration)

			if var_135_3 <= arg_132_1.time_ and arg_132_1.time_ < var_135_3 + var_135_8 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_3) / var_135_8

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_3 + var_135_8 and arg_132_1.time_ < var_135_3 + var_135_8 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play108061033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 108061033
		arg_136_1.duration_ = 2

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play108061034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos3014_tpose = arg_136_1.actors_["3014_tpose"].transform.localPosition

				local var_139_0 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_0 then
					var_139_0:EnableDynamicBone(false)
				end
			end

			local var_139_1 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_1 then
				arg_136_1.actors_["3014_tpose"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos3014_tpose, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_1)
				arg_136_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["3014_tpose"].transform.position).z)
				arg_136_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["3014_tpose"].transform.localEulerAngles = arg_136_1.actors_["3014_tpose"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_1 and arg_136_1.time_ < 0 + var_139_1 + arg_139_0 then
				arg_136_1.actors_["3014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.actors_["3014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["3014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["3014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["3014_tpose"].transform.position).z)
				arg_136_1.actors_["3014_tpose"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["3014_tpose"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["3014_tpose"].transform.localEulerAngles = arg_136_1.actors_["3014_tpose"].transform.localEulerAngles

				local var_139_2 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["3014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(true)
				end
			end

			local var_139_3 = arg_136_1.actors_["1099ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1099ui_story = var_139_3.localPosition
			end

			local var_139_4 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 then
				var_139_3.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_136_1.time_ - 0) / var_139_4)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 then
				var_139_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_139_5 = arg_136_1.actors_["1099ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_5) and arg_136_1.var_.characterEffect1099ui_story == nil then
				arg_136_1.var_.characterEffect1099ui_story = var_139_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_6 and not isNil(var_139_5) then
				if arg_136_1.var_.characterEffect1099ui_story and not isNil(var_139_5) then
					arg_136_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_6 and arg_136_1.time_ < 0 + var_139_6 + arg_139_0 and not isNil(var_139_5) and arg_136_1.var_.characterEffect1099ui_story then
				arg_136_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_139_8 = 0
			local var_139_9 = 0.075

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_8 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_10 = arg_136_1:GetWordFromCfg(108061033)
				local var_139_11 = arg_136_1:FormatText(var_139_10.content)

				arg_136_1.text_.text = var_139_11

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_13 = 3 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_11) / 3)

				if (3 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_11) / 3)) > 0 and var_139_9 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_8
					end
				end

				arg_136_1.text_.text = var_139_11
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061033", "story_v_out_108061.awb") ~= 0 then
					local var_139_14 = manager.audio:GetVoiceLength("story_v_out_108061", "108061033", "story_v_out_108061.awb") / 1000

					if var_139_14 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_14 + var_139_8
					end

					if var_139_10.prefab_name ~= "" and arg_136_1.actors_[var_139_10.prefab_name] ~= nil then
						local var_139_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_10.prefab_name].transform, "story_v_out_108061", "108061033", "story_v_out_108061.awb")

						arg_136_1:RecordAudio("108061033", var_139_15)
						arg_136_1:RecordAudio("108061033", var_139_15)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_108061", "108061033", "story_v_out_108061.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_108061", "108061033", "story_v_out_108061.awb")
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
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play108061034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 108061034
		arg_140_1.duration_ = 7.23

		local var_140_0 = {
			ja = 4.666,
			ko = 6.4,
			zh = 7.233,
			en = 6.1
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
				arg_140_0:Play108061035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1099ui_story = arg_140_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_143_0 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 then
				arg_140_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 0) / var_143_0)
				arg_140_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1099ui_story"].transform.position).z)
				arg_140_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1099ui_story"].transform.localEulerAngles = arg_140_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 then
				arg_140_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1099ui_story"].transform.position).z)
				arg_140_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1099ui_story"].transform.localEulerAngles = arg_140_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_143_1 = arg_140_1.actors_["3014_tpose"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos3014_tpose = var_143_1.localPosition

				local var_143_2 = GameObjectTools.GetOrAddComponent(var_143_1.gameObject, typeof(DynamicBoneHelper))

				if var_143_2 then
					var_143_2:EnableDynamicBone(false)
				end
			end

			local var_143_3 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_3 then
				var_143_1.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos3014_tpose, Vector3.New(0, -2.35, -2.9), (arg_140_1.time_ - 0) / var_143_3)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_3 and arg_140_1.time_ < 0 + var_143_3 + arg_143_0 then
				var_143_1.localPosition = Vector3.New(0, -2.35, -2.9)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles

				local var_143_4 = GameObjectTools.GetOrAddComponent(var_143_1.gameObject, typeof(DynamicBoneHelper))

				if var_143_4 then
					var_143_4:EnableDynamicBone(true)
				end
			end

			local var_143_5 = arg_140_1.actors_["3014_tpose"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_5) and arg_140_1.var_.characterEffect3014_tpose == nil then
				arg_140_1.var_.characterEffect3014_tpose = var_143_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_6 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_6 and not isNil(var_143_5) then
				if arg_140_1.var_.characterEffect3014_tpose and not isNil(var_143_5) then
					arg_140_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_6 and arg_140_1.time_ < 0 + var_143_6 + arg_143_0 and not isNil(var_143_5) and arg_140_1.var_.characterEffect3014_tpose then
				arg_140_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_143_8 = 0
			local var_143_9 = 0.575

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_10 = arg_140_1:GetWordFromCfg(108061034)
				local var_143_11 = arg_140_1:FormatText(var_143_10.content)

				arg_140_1.text_.text = var_143_11

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 23 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 23)

				if (23 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 23)) > 0 and var_143_9 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_8
					end
				end

				arg_140_1.text_.text = var_143_11
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061034", "story_v_out_108061.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_108061", "108061034", "story_v_out_108061.awb") / 1000

					if var_143_14 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_8
					end

					if var_143_10.prefab_name ~= "" and arg_140_1.actors_[var_143_10.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_10.prefab_name].transform, "story_v_out_108061", "108061034", "story_v_out_108061.awb")

						arg_140_1:RecordAudio("108061034", var_143_15)
						arg_140_1:RecordAudio("108061034", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_108061", "108061034", "story_v_out_108061.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_108061", "108061034", "story_v_out_108061.awb")
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
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play108061035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 108061035
		arg_144_1.duration_ = 11.13

		local var_144_0 = {
			ja = 8.666,
			ko = 10.366,
			zh = 11.133,
			en = 7.1
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play108061036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.775

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:GetWordFromCfg(108061035)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 31 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 31)

				if (31 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 31)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061035", "story_v_out_108061.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061035", "story_v_out_108061.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_108061", "108061035", "story_v_out_108061.awb")

						arg_144_1:RecordAudio("108061035", var_147_6)
						arg_144_1:RecordAudio("108061035", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_108061", "108061035", "story_v_out_108061.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_108061", "108061035", "story_v_out_108061.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play108061036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 108061036
		arg_148_1.duration_ = 15.37

		local var_148_0 = {
			ja = 13.466,
			ko = 13.2,
			zh = 15.366,
			en = 14.8
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
				arg_148_0:Play108061037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 1.2

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:GetWordFromCfg(108061036)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 47 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 47)

				if (47 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 47)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061036", "story_v_out_108061.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061036", "story_v_out_108061.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_out_108061", "108061036", "story_v_out_108061.awb")

						arg_148_1:RecordAudio("108061036", var_151_6)
						arg_148_1:RecordAudio("108061036", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_108061", "108061036", "story_v_out_108061.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_108061", "108061036", "story_v_out_108061.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play108061037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 108061037
		arg_152_1.duration_ = 8.87

		local var_152_0 = {
			ja = 8.866,
			ko = 7.166,
			zh = 8.6,
			en = 5.8
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
			arg_152_1.auto_ = false
		end

		function arg_152_1.playNext_(arg_154_0)
			arg_152_1.onStoryFinished_()
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.625

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_1 = arg_152_1:GetWordFromCfg(108061037)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.text_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 25 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 25)

				if (25 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 25)) > 0 and var_155_0 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end

				arg_152_1.text_.text = var_155_2
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108061", "108061037", "story_v_out_108061.awb") ~= 0 then
					local var_155_5 = manager.audio:GetVoiceLength("story_v_out_108061", "108061037", "story_v_out_108061.awb") / 1000

					if var_155_5 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + 0
					end

					if var_155_1.prefab_name ~= "" and arg_152_1.actors_[var_155_1.prefab_name] ~= nil then
						local var_155_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_1.prefab_name].transform, "story_v_out_108061", "108061037", "story_v_out_108061.awb")

						arg_152_1:RecordAudio("108061037", var_155_6)
						arg_152_1:RecordAudio("108061037", var_155_6)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_108061", "108061037", "story_v_out_108061.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_108061", "108061037", "story_v_out_108061.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0802",
		"TextureConfig/Background/S0803",
		"TextureConfig/Background/C06c"
	},
	voices = {
		"story_v_out_108061.awb"
	}
}
