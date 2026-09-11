return {
	Play113131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113131001
		arg_1_1.duration_ = 21.9

		local var_1_0 = {
			ja = 13.6,
			ko = 17.5,
			zh = 21.866,
			en = 21.9
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
				arg_1_0:Play113131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_0 = 2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_0 then
				local var_4_1 = Color.New(0, 0, 0)

				var_4_1.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - 0) / var_4_0)
				arg_1_1.mask_.color = var_4_1
			end

			if arg_1_1.time_ >= 0 + var_4_0 and arg_1_1.time_ < 0 + var_4_0 + arg_4_0 then
				local var_4_2 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_2.a = 0
				arg_1_1.mask_.color = var_4_2
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = 2
			local var_4_7 = 1.525

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_8 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_8:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_9 = arg_1_1:GetWordFromCfg(113131001)
				local var_4_10 = arg_1_1:FormatText(var_4_9.content)

				arg_1_1.text_.text = var_4_10

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_12 = 61 <= 0 and var_4_7 or var_4_7 * (utf8.len(var_4_10) / 61)

				if (61 <= 0 and var_4_7 or var_4_7 * (utf8.len(var_4_10) / 61)) > 0 and var_4_7 < var_4_12 then
					arg_1_1.talkMaxDuration = var_4_12
					var_4_6 = var_4_6 + 0.3

					if var_4_12 + var_4_6 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_12 + var_4_6
					end
				end

				arg_1_1.text_.text = var_4_10
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131001", "story_v_out_113131.awb") ~= 0 then
					local var_4_13 = manager.audio:GetVoiceLength("story_v_out_113131", "113131001", "story_v_out_113131.awb") / 1000

					if var_4_13 + var_4_6 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_13 + var_4_6
					end

					if var_4_9.prefab_name ~= "" and arg_1_1.actors_[var_4_9.prefab_name] ~= nil then
						local var_4_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_9.prefab_name].transform, "story_v_out_113131", "113131001", "story_v_out_113131.awb")

						arg_1_1:RecordAudio("113131001", var_4_14)
						arg_1_1:RecordAudio("113131001", var_4_14)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113131", "113131001", "story_v_out_113131.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113131", "113131001", "story_v_out_113131.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_15 = var_4_6 + 0.3
			local var_4_16 = math.max(var_4_7, arg_1_1.talkMaxDuration)

			if var_4_6 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_15 + var_4_16 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_15) / var_4_16

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_15 + var_4_16 and arg_1_1.time_ < var_4_15 + var_4_16 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play113131002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 113131002
		arg_8_1.duration_ = 12.43

		local var_8_0 = {
			ja = 12.433,
			ko = 9.2,
			zh = 10.6,
			en = 10.933
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
				arg_8_0:Play113131003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.925

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:GetWordFromCfg(113131002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 37 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 37)

				if (37 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 37)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131002", "story_v_out_113131.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_113131", "113131002", "story_v_out_113131.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_113131", "113131002", "story_v_out_113131.awb")

						arg_8_1:RecordAudio("113131002", var_11_6)
						arg_8_1:RecordAudio("113131002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_113131", "113131002", "story_v_out_113131.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_113131", "113131002", "story_v_out_113131.awb")
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
	Play113131003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 113131003
		arg_12_1.duration_ = 19.03

		local var_12_0 = {
			ja = 19.033,
			ko = 10.066,
			zh = 12.933,
			en = 12.7
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
				arg_12_0:Play113131004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_0 = 2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 then
				local var_15_1 = Color.New(0, 0, 0)

				var_15_1.a = Mathf.Lerp(0, 1, (arg_12_1.time_ - 0) / var_15_0)
				arg_12_1.mask_.color = var_15_1
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 then
				local var_15_2 = Color.New(0, 0, 0)

				var_15_2.a = 1
				arg_12_1.mask_.color = var_15_2
			end

			local var_15_3 = 2

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_3 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_4 = 2

			if var_15_3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_3 + var_15_4 then
				local var_15_5 = Color.New(0, 0, 0)

				var_15_5.a = Mathf.Lerp(1, 0, (arg_12_1.time_ - var_15_3) / var_15_4)
				arg_12_1.mask_.color = var_15_5
			end

			if arg_12_1.time_ >= var_15_3 + var_15_4 and arg_12_1.time_ < var_15_3 + var_15_4 + arg_15_0 then
				local var_15_6 = Color.New(0, 0, 0)

				arg_12_1.mask_.enabled = false
				var_15_6.a = 0
				arg_12_1.mask_.color = var_15_6
			end

			local var_15_7 = "OM0108"

			if arg_12_1.bgs_.OM0108 == nil then
				local var_15_8 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_15_7)
				var_15_8.name = var_15_7
				var_15_8.transform.parent = arg_12_1.stage_.transform
				var_15_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_[var_15_7] = var_15_8
			end

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= 2 + arg_15_0 then
				local var_15_9 = arg_12_1.bgs_.OM0108

				arg_12_1.bgs_.OM0108.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_15_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_10 = var_15_9:GetComponent("SpriteRenderer")

				if var_15_10 and var_15_10.sprite then
					local var_15_11 = 2 * (var_15_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_15_9.transform.localScale = Vector3.New(var_15_11 / var_15_10.sprite.bounds.size.y < var_15_11 * manager.ui.mainCameraCom_.aspect / var_15_10.sprite.bounds.size.x and var_15_11 * manager.ui.mainCameraCom_.aspect / var_15_10.sprite.bounds.size.x or var_15_11 / var_15_10.sprite.bounds.size.y, var_15_11 / var_15_10.sprite.bounds.size.y < var_15_11 * manager.ui.mainCameraCom_.aspect / var_15_10.sprite.bounds.size.x and var_15_11 * manager.ui.mainCameraCom_.aspect / var_15_10.sprite.bounds.size.x or var_15_11 / var_15_10.sprite.bounds.size.y, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "OM0108" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_12 = 4
			local var_15_13 = 0.425

			if 4 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_14 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_14:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_15 = arg_12_1:GetWordFromCfg(113131003)
				local var_15_16 = arg_12_1:FormatText(var_15_15.content)

				arg_12_1.text_.text = var_15_16

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_18 = 17 <= 0 and var_15_13 or var_15_13 * (utf8.len(var_15_16) / 17)

				if (17 <= 0 and var_15_13 or var_15_13 * (utf8.len(var_15_16) / 17)) > 0 and var_15_13 < var_15_18 then
					arg_12_1.talkMaxDuration = var_15_18
					var_15_12 = var_15_12 + 0.3

					if var_15_18 + var_15_12 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_18 + var_15_12
					end
				end

				arg_12_1.text_.text = var_15_16
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131003", "story_v_out_113131.awb") ~= 0 then
					local var_15_19 = manager.audio:GetVoiceLength("story_v_out_113131", "113131003", "story_v_out_113131.awb") / 1000

					if var_15_19 + var_15_12 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_19 + var_15_12
					end

					if var_15_15.prefab_name ~= "" and arg_12_1.actors_[var_15_15.prefab_name] ~= nil then
						local var_15_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_15.prefab_name].transform, "story_v_out_113131", "113131003", "story_v_out_113131.awb")

						arg_12_1:RecordAudio("113131003", var_15_20)
						arg_12_1:RecordAudio("113131003", var_15_20)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_113131", "113131003", "story_v_out_113131.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_113131", "113131003", "story_v_out_113131.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_21 = var_15_12 + 0.3
			local var_15_22 = math.max(var_15_13, arg_12_1.talkMaxDuration)

			if var_15_12 + 0.3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_21 + var_15_22 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_21) / var_15_22

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_21 + var_15_22 and arg_12_1.time_ < var_15_21 + var_15_22 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play113131004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 113131004
		arg_18_1.duration_ = 13.47

		local var_18_0 = {
			ja = 10.4,
			ko = 12.2,
			zh = 12.966,
			en = 13.466
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
				arg_18_0:Play113131005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 1.225

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_1 = arg_18_1:GetWordFromCfg(113131004)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 49 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 49)

				if (49 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 49)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131004", "story_v_out_113131.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_out_113131", "113131004", "story_v_out_113131.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_out_113131", "113131004", "story_v_out_113131.awb")

						arg_18_1:RecordAudio("113131004", var_21_6)
						arg_18_1:RecordAudio("113131004", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_113131", "113131004", "story_v_out_113131.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_113131", "113131004", "story_v_out_113131.awb")
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
	Play113131005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 113131005
		arg_22_1.duration_ = 12.47

		local var_22_0 = {
			ja = 12.466,
			ko = 7.966,
			zh = 8.2,
			en = 9.066
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
				arg_22_0:Play113131006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.8

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_1 = arg_22_1:GetWordFromCfg(113131005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 32 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 32)

				if (32 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 32)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131005", "story_v_out_113131.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_113131", "113131005", "story_v_out_113131.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_113131", "113131005", "story_v_out_113131.awb")

						arg_22_1:RecordAudio("113131005", var_25_6)
						arg_22_1:RecordAudio("113131005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_113131", "113131005", "story_v_out_113131.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_113131", "113131005", "story_v_out_113131.awb")
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
	Play113131006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 113131006
		arg_26_1.duration_ = 8.27

		local var_26_0 = {
			ja = 8.266,
			ko = 2.733,
			zh = 4.533,
			en = 5.066
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
				arg_26_0:Play113131007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.375

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_1 = arg_26_1:GetWordFromCfg(113131006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 15 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 15)

				if (15 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 15)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131006", "story_v_out_113131.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_113131", "113131006", "story_v_out_113131.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_113131", "113131006", "story_v_out_113131.awb")

						arg_26_1:RecordAudio("113131006", var_29_6)
						arg_26_1:RecordAudio("113131006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_113131", "113131006", "story_v_out_113131.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_113131", "113131006", "story_v_out_113131.awb")
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
	Play113131007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 113131007
		arg_30_1.duration_ = 6.72

		local var_30_0 = {
			ja = 6.725,
			ko = 5.491,
			zh = 5.458,
			en = 6.291
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play113131008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_0 = 2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 then
				local var_33_1 = Color.New(0, 0, 0)

				var_33_1.a = Mathf.Lerp(0, 1, (arg_30_1.time_ - 0) / var_33_0)
				arg_30_1.mask_.color = var_33_1
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 then
				local var_33_2 = Color.New(0, 0, 0)

				var_33_2.a = 1
				arg_30_1.mask_.color = var_33_2
			end

			local var_33_3 = 2

			if 2 < arg_30_1.time_ and arg_30_1.time_ <= var_33_3 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_4 = 2

			if var_33_3 <= arg_30_1.time_ and arg_30_1.time_ < var_33_3 + var_33_4 then
				local var_33_5 = Color.New(0, 0, 0)

				var_33_5.a = Mathf.Lerp(1, 0, (arg_30_1.time_ - var_33_3) / var_33_4)
				arg_30_1.mask_.color = var_33_5
			end

			if arg_30_1.time_ >= var_33_3 + var_33_4 and arg_30_1.time_ < var_33_3 + var_33_4 + arg_33_0 then
				local var_33_6 = Color.New(0, 0, 0)

				arg_30_1.mask_.enabled = false
				var_33_6.a = 0
				arg_30_1.mask_.color = var_33_6
			end

			local var_33_7 = "STblack"

			if arg_30_1.bgs_.STblack == nil then
				local var_33_8 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_33_7)
				var_33_8.name = var_33_7
				var_33_8.transform.parent = arg_30_1.stage_.transform
				var_33_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_[var_33_7] = var_33_8
			end

			if 2 < arg_30_1.time_ and arg_30_1.time_ <= 2 + arg_33_0 then
				local var_33_9 = arg_30_1.bgs_.STblack

				arg_30_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_33_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_10 = var_33_9:GetComponent("SpriteRenderer")

				if var_33_10 and var_33_10.sprite then
					local var_33_11 = 2 * (var_33_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_33_9.transform.localScale = Vector3.New(var_33_11 / var_33_10.sprite.bounds.size.y < var_33_11 * manager.ui.mainCameraCom_.aspect / var_33_10.sprite.bounds.size.x and var_33_11 * manager.ui.mainCameraCom_.aspect / var_33_10.sprite.bounds.size.x or var_33_11 / var_33_10.sprite.bounds.size.y, var_33_11 / var_33_10.sprite.bounds.size.y < var_33_11 * manager.ui.mainCameraCom_.aspect / var_33_10.sprite.bounds.size.x and var_33_11 * manager.ui.mainCameraCom_.aspect / var_33_10.sprite.bounds.size.x or var_33_11 / var_33_10.sprite.bounds.size.y, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "STblack" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_12 = 3.925
			local var_33_13 = 0.075

			if 3.925 < arg_30_1.time_ and arg_30_1.time_ <= var_33_12 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_14 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_14:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_30_1.dialogCg_.alpha = arg_34_0
				end))
				var_33_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_15 = arg_30_1:GetWordFromCfg(113131007)
				local var_33_16 = arg_30_1:FormatText(var_33_15.content)

				arg_30_1.text_.text = var_33_16

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_18 = 3 <= 0 and var_33_13 or var_33_13 * (utf8.len(var_33_16) / 3)

				if (3 <= 0 and var_33_13 or var_33_13 * (utf8.len(var_33_16) / 3)) > 0 and var_33_13 < var_33_18 then
					arg_30_1.talkMaxDuration = var_33_18
					var_33_12 = var_33_12 + 0.3

					if var_33_18 + var_33_12 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_18 + var_33_12
					end
				end

				arg_30_1.text_.text = var_33_16
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131007", "story_v_out_113131.awb") ~= 0 then
					local var_33_19 = manager.audio:GetVoiceLength("story_v_out_113131", "113131007", "story_v_out_113131.awb") / 1000

					if var_33_19 + var_33_12 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_19 + var_33_12
					end

					if var_33_15.prefab_name ~= "" and arg_30_1.actors_[var_33_15.prefab_name] ~= nil then
						local var_33_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_15.prefab_name].transform, "story_v_out_113131", "113131007", "story_v_out_113131.awb")

						arg_30_1:RecordAudio("113131007", var_33_20)
						arg_30_1:RecordAudio("113131007", var_33_20)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_113131", "113131007", "story_v_out_113131.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_113131", "113131007", "story_v_out_113131.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_21 = var_33_12 + 0.3
			local var_33_22 = math.max(var_33_13, arg_30_1.talkMaxDuration)

			if var_33_12 + 0.3 <= arg_30_1.time_ and arg_30_1.time_ < var_33_21 + var_33_22 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_21) / var_33_22

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_21 + var_33_22 and arg_30_1.time_ < var_33_21 + var_33_22 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play113131008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 113131008
		arg_36_1.duration_ = 12.67

		local var_36_0 = {
			ja = 12.666,
			ko = 10.566,
			zh = 9.8,
			en = 5.566
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
				arg_36_0:Play113131009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.875

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:GetWordFromCfg(113131008)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 35 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 35)

				if (35 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 35)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131008", "story_v_out_113131.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_113131", "113131008", "story_v_out_113131.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_113131", "113131008", "story_v_out_113131.awb")

						arg_36_1:RecordAudio("113131008", var_39_6)
						arg_36_1:RecordAudio("113131008", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_113131", "113131008", "story_v_out_113131.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_113131", "113131008", "story_v_out_113131.awb")
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
	Play113131009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 113131009
		arg_40_1.duration_ = 8.63

		local var_40_0 = {
			ja = 8.633,
			ko = 3.8,
			zh = 5.666,
			en = 6.5
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
				arg_40_0:Play113131010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.375

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:GetWordFromCfg(113131009)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 15 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 15)

				if (15 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 15)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131009", "story_v_out_113131.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_113131", "113131009", "story_v_out_113131.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_113131", "113131009", "story_v_out_113131.awb")

						arg_40_1:RecordAudio("113131009", var_43_6)
						arg_40_1:RecordAudio("113131009", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_113131", "113131009", "story_v_out_113131.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_113131", "113131009", "story_v_out_113131.awb")
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
	Play113131010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 113131010
		arg_44_1.duration_ = 14.63

		local var_44_0 = {
			ja = 9.933,
			ko = 7.9,
			zh = 10.333,
			en = 14.633
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
				arg_44_0:Play113131011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.7

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:GetWordFromCfg(113131010)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 28 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 28)

				if (28 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 28)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131010", "story_v_out_113131.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_113131", "113131010", "story_v_out_113131.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_113131", "113131010", "story_v_out_113131.awb")

						arg_44_1:RecordAudio("113131010", var_47_6)
						arg_44_1:RecordAudio("113131010", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_113131", "113131010", "story_v_out_113131.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_113131", "113131010", "story_v_out_113131.awb")
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
	Play113131011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 113131011
		arg_48_1.duration_ = 7.57

		local var_48_0 = {
			ja = 7.566,
			ko = 6.1,
			zh = 6.466,
			en = 5.3
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
				arg_48_0:Play113131012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.4

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:GetWordFromCfg(113131011)
				local var_51_2 = arg_48_1:FormatText(var_51_1.content)

				arg_48_1.text_.text = var_51_2

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 16 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 16)

				if (16 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 16)) > 0 and var_51_0 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + 0
					end
				end

				arg_48_1.text_.text = var_51_2
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131011", "story_v_out_113131.awb") ~= 0 then
					local var_51_5 = manager.audio:GetVoiceLength("story_v_out_113131", "113131011", "story_v_out_113131.awb") / 1000

					if var_51_5 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + 0
					end

					if var_51_1.prefab_name ~= "" and arg_48_1.actors_[var_51_1.prefab_name] ~= nil then
						local var_51_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_1.prefab_name].transform, "story_v_out_113131", "113131011", "story_v_out_113131.awb")

						arg_48_1:RecordAudio("113131011", var_51_6)
						arg_48_1:RecordAudio("113131011", var_51_6)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_113131", "113131011", "story_v_out_113131.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_113131", "113131011", "story_v_out_113131.awb")
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
	Play113131012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 113131012
		arg_52_1.duration_ = 8.47

		local var_52_0 = {
			ja = 6.5,
			ko = 6.5,
			zh = 8.466,
			en = 5.8
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
				arg_52_0:Play113131013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if arg_52_1.bgs_.ST21a == nil then
				local var_55_0 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST21a")
				var_55_0.name = "ST21a"
				var_55_0.transform.parent = arg_52_1.stage_.transform
				var_55_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_.ST21a = var_55_0
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				local var_55_1 = arg_52_1.bgs_.ST21a

				arg_52_1.bgs_.ST21a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_55_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_2 = var_55_1:GetComponent("SpriteRenderer")

				if var_55_2 and var_55_2.sprite then
					local var_55_3 = 2 * (var_55_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_55_1.transform.localScale = Vector3.New(var_55_3 / var_55_2.sprite.bounds.size.y < var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x and var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x or var_55_3 / var_55_2.sprite.bounds.size.y, var_55_3 / var_55_2.sprite.bounds.size.y < var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x and var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x or var_55_3 / var_55_2.sprite.bounds.size.y, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "ST21a" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_4 = 0

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_5 = 2

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_5 then
				local var_55_6 = Color.New(1, 1, 1)

				var_55_6.a = Mathf.Lerp(1, 0, (arg_52_1.time_ - var_55_4) / var_55_5)
				arg_52_1.mask_.color = var_55_6
			end

			if arg_52_1.time_ >= var_55_4 + var_55_5 and arg_52_1.time_ < var_55_4 + var_55_5 + arg_55_0 then
				local var_55_7 = Color.New(1, 1, 1)

				arg_52_1.mask_.enabled = false
				var_55_7.a = 0
				arg_52_1.mask_.color = var_55_7
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_8 = 2
			local var_55_9 = 0.25

			if 2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_10 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_10:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_11 = arg_52_1:GetWordFromCfg(113131012)
				local var_55_12 = arg_52_1:FormatText(var_55_11.content)

				arg_52_1.text_.text = var_55_12

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_14 = 10 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_12) / 10)

				if (10 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_12) / 10)) > 0 and var_55_9 < var_55_14 then
					arg_52_1.talkMaxDuration = var_55_14
					var_55_8 = var_55_8 + 0.3

					if var_55_14 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_8
					end
				end

				arg_52_1.text_.text = var_55_12
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131012", "story_v_out_113131.awb") ~= 0 then
					local var_55_15 = manager.audio:GetVoiceLength("story_v_out_113131", "113131012", "story_v_out_113131.awb") / 1000

					if var_55_15 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_15 + var_55_8
					end

					if var_55_11.prefab_name ~= "" and arg_52_1.actors_[var_55_11.prefab_name] ~= nil then
						local var_55_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_11.prefab_name].transform, "story_v_out_113131", "113131012", "story_v_out_113131.awb")

						arg_52_1:RecordAudio("113131012", var_55_16)
						arg_52_1:RecordAudio("113131012", var_55_16)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_113131", "113131012", "story_v_out_113131.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_113131", "113131012", "story_v_out_113131.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_17 = var_55_8 + 0.3
			local var_55_18 = math.max(var_55_9, arg_52_1.talkMaxDuration)

			if var_55_8 + 0.3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_17 + var_55_18 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_17) / var_55_18

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_17 + var_55_18 and arg_52_1.time_ < var_55_17 + var_55_18 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play113131013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 113131013
		arg_58_1.duration_ = 7.77

		local var_58_0 = {
			ja = 6.166,
			ko = 6.233,
			zh = 7.533,
			en = 7.766
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
				arg_58_0:Play113131014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:AudioAction("play", "music", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_61_2 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if "" ~= "" then
					if arg_58_1.bgmTxt_.text ~= var_61_2 and arg_58_1.bgmTxt_.text ~= "" then
						if arg_58_1.bgmTxt2_.text ~= "" then
							arg_58_1.bgmTxt_.text = arg_58_1.bgmTxt2_.text
						end

						arg_58_1.bgmTxt2_.text = var_61_2

						arg_58_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_58_1.bgmTxt_.text = var_61_2
						arg_58_1.bgmTxt2_.text = var_61_2
					end

					if arg_58_1.bgmTimer then
						arg_58_1.bgmTimer:Stop()

						arg_58_1.bgmTimer = nil
					end

					if arg_58_1.settingData.show_music_name == 1 then
						arg_58_1.musicController:SetSelectedState("show")
						arg_58_1.musicAnimator_:Play("open", 0, 0)

						if arg_58_1.settingData.music_time ~= 0 then
							arg_58_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_58_1.settingData.music_time), function()
								if arg_58_1 == nil or isNil(arg_58_1.bgmTxt_) then
									return
								end

								arg_58_1.musicController:SetSelectedState("hide")
								arg_58_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_61_3 = 0
			local var_61_4 = 0.625

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_3 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[210].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_5 = arg_58_1:GetWordFromCfg(113131013)
				local var_61_6 = arg_58_1:FormatText(var_61_5.content)

				arg_58_1.text_.text = var_61_6

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_8 = 25 <= 0 and var_61_4 or var_61_4 * (utf8.len(var_61_6) / 25)

				if (25 <= 0 and var_61_4 or var_61_4 * (utf8.len(var_61_6) / 25)) > 0 and var_61_4 < var_61_8 then
					arg_58_1.talkMaxDuration = var_61_8

					if var_61_8 + var_61_3 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_3
					end
				end

				arg_58_1.text_.text = var_61_6
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131013", "story_v_out_113131.awb") ~= 0 then
					local var_61_9 = manager.audio:GetVoiceLength("story_v_out_113131", "113131013", "story_v_out_113131.awb") / 1000

					if var_61_9 + var_61_3 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_3
					end

					if var_61_5.prefab_name ~= "" and arg_58_1.actors_[var_61_5.prefab_name] ~= nil then
						local var_61_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_5.prefab_name].transform, "story_v_out_113131", "113131013", "story_v_out_113131.awb")

						arg_58_1:RecordAudio("113131013", var_61_10)
						arg_58_1:RecordAudio("113131013", var_61_10)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_113131", "113131013", "story_v_out_113131.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_113131", "113131013", "story_v_out_113131.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_11 = math.max(var_61_4, arg_58_1.talkMaxDuration)

			if var_61_3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_3 + var_61_11 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_3) / var_61_11

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_3 + var_61_11 and arg_58_1.time_ < var_61_3 + var_61_11 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play113131014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 113131014
		arg_63_1.duration_ = 7.3

		local var_63_0 = {
			ja = 7.3,
			ko = 2.733,
			zh = 4.566,
			en = 5.9
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
				arg_63_0:Play113131015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if arg_63_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_66_0 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_63_1.stage_.transform)

				var_66_0.name = "1041ui_story"
				var_66_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.actors_["1041ui_story"] = var_66_0

				local var_66_1 = var_66_0:GetComponentInChildren(typeof(CharacterEffect))

				var_66_1.enabled = true

				local var_66_2 = GameObjectTools.GetOrAddComponent(var_66_0, typeof(DynamicBoneHelper))

				if var_66_2 then
					var_66_2:EnableDynamicBone(false)
				end

				arg_63_1:ShowWeapon(var_66_1.transform, false)

				arg_63_1.var_["1041ui_story" .. "Animator"] = var_66_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_63_1.var_["1041ui_story" .. "Animator"].applyRootMotion = true
				arg_63_1.var_["1041ui_story" .. "LipSync"] = var_66_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_66_3 = arg_63_1.actors_["1041ui_story"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1041ui_story = var_66_3.localPosition
			end

			local var_66_4 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				var_66_3.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_63_1.time_ - 0) / var_66_4)
				var_66_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_3.position).x, (manager.ui.mainCamera.transform.position - var_66_3.position).y, (manager.ui.mainCamera.transform.position - var_66_3.position).z)
				var_66_3.localEulerAngles.z = 0
				var_66_3.localEulerAngles.x = 0
				var_66_3.localEulerAngles = var_66_3.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				var_66_3.localPosition = Vector3.New(0, -1.11, -5.9)
				var_66_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_3.position).x, (manager.ui.mainCamera.transform.position - var_66_3.position).y, (manager.ui.mainCamera.transform.position - var_66_3.position).z)
				var_66_3.localEulerAngles.z = 0
				var_66_3.localEulerAngles.x = 0
				var_66_3.localEulerAngles = var_66_3.localEulerAngles
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_66_5 = arg_63_1.actors_["1041ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.characterEffect1041ui_story == nil then
				arg_63_1.var_.characterEffect1041ui_story = var_66_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_6 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_6 and not isNil(var_66_5) then
				if arg_63_1.var_.characterEffect1041ui_story and not isNil(var_66_5) then
					arg_63_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_6 and arg_63_1.time_ < 0 + var_66_6 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.characterEffect1041ui_story then
				arg_63_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_66_8 = 0
			local var_66_9 = 0.2

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_10 = arg_63_1:GetWordFromCfg(113131014)
				local var_66_11 = arg_63_1:FormatText(var_66_10.content)

				arg_63_1.text_.text = var_66_11

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_13 = 8 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 8)

				if (8 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 8)) > 0 and var_66_9 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_8
					end
				end

				arg_63_1.text_.text = var_66_11
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131014", "story_v_out_113131.awb") ~= 0 then
					local var_66_14 = manager.audio:GetVoiceLength("story_v_out_113131", "113131014", "story_v_out_113131.awb") / 1000

					if var_66_14 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_8
					end

					if var_66_10.prefab_name ~= "" and arg_63_1.actors_[var_66_10.prefab_name] ~= nil then
						local var_66_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_10.prefab_name].transform, "story_v_out_113131", "113131014", "story_v_out_113131.awb")

						arg_63_1:RecordAudio("113131014", var_66_15)
						arg_63_1:RecordAudio("113131014", var_66_15)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_113131", "113131014", "story_v_out_113131.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_113131", "113131014", "story_v_out_113131.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_16 = math.max(var_66_9, arg_63_1.talkMaxDuration)

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_16 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_8) / var_66_16

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_8 + var_66_16 and arg_63_1.time_ < var_66_8 + var_66_16 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play113131015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 113131015
		arg_67_1.duration_ = 8.13

		local var_67_0 = {
			ja = 7.466,
			ko = 7.633,
			zh = 7.233,
			en = 8.133
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
				arg_67_0:Play113131016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1041ui_story"]) and arg_67_1.var_.characterEffect1041ui_story == nil then
				arg_67_1.var_.characterEffect1041ui_story = arg_67_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1041ui_story"]) then
				if arg_67_1.var_.characterEffect1041ui_story and not isNil(arg_67_1.actors_["1041ui_story"]) then
					arg_67_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1041ui_story"]) and arg_67_1.var_.characterEffect1041ui_story then
				arg_67_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_70_1 = 0
			local var_70_2 = 0.825

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[210].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(113131015)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_6 = 32 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_4) / 32)

				if (32 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_4) / 32)) > 0 and var_70_2 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131015", "story_v_out_113131.awb") ~= 0 then
					local var_70_7 = manager.audio:GetVoiceLength("story_v_out_113131", "113131015", "story_v_out_113131.awb") / 1000

					if var_70_7 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_1
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_113131", "113131015", "story_v_out_113131.awb")

						arg_67_1:RecordAudio("113131015", var_70_8)
						arg_67_1:RecordAudio("113131015", var_70_8)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_113131", "113131015", "story_v_out_113131.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_113131", "113131015", "story_v_out_113131.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_9 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_9 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_9

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_9 and arg_67_1.time_ < var_70_1 + var_70_9 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play113131016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 113131016
		arg_71_1.duration_ = 4.8

		local var_71_0 = {
			ja = 4.8,
			ko = 2.466,
			zh = 3.6,
			en = 2.8
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
				arg_71_0:Play113131017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_74_0 = arg_71_1.actors_["1041ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1041ui_story == nil then
				arg_71_1.var_.characterEffect1041ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_1 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 and not isNil(var_74_0) then
				if arg_71_1.var_.characterEffect1041ui_story and not isNil(var_74_0) then
					arg_71_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1041ui_story then
				arg_71_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_74_3 = 0
			local var_74_4 = 0.225

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_3 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_5 = arg_71_1:GetWordFromCfg(113131016)
				local var_74_6 = arg_71_1:FormatText(var_74_5.content)

				arg_71_1.text_.text = var_74_6

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_8 = 9 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_6) / 9)

				if (9 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_6) / 9)) > 0 and var_74_4 < var_74_8 then
					arg_71_1.talkMaxDuration = var_74_8

					if var_74_8 + var_74_3 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_3
					end
				end

				arg_71_1.text_.text = var_74_6
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131016", "story_v_out_113131.awb") ~= 0 then
					local var_74_9 = manager.audio:GetVoiceLength("story_v_out_113131", "113131016", "story_v_out_113131.awb") / 1000

					if var_74_9 + var_74_3 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_3
					end

					if var_74_5.prefab_name ~= "" and arg_71_1.actors_[var_74_5.prefab_name] ~= nil then
						local var_74_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_5.prefab_name].transform, "story_v_out_113131", "113131016", "story_v_out_113131.awb")

						arg_71_1:RecordAudio("113131016", var_74_10)
						arg_71_1:RecordAudio("113131016", var_74_10)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_113131", "113131016", "story_v_out_113131.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_113131", "113131016", "story_v_out_113131.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_11 = math.max(var_74_4, arg_71_1.talkMaxDuration)

			if var_74_3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_3 + var_74_11 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_3) / var_74_11

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_3 + var_74_11 and arg_71_1.time_ < var_74_3 + var_74_11 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play113131017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 113131017
		arg_75_1.duration_ = 11.27

		local var_75_0 = {
			ja = 9.5,
			ko = 10.066,
			zh = 7.333,
			en = 11.266
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
				arg_75_0:Play113131018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1041ui_story"]) and arg_75_1.var_.characterEffect1041ui_story == nil then
				arg_75_1.var_.characterEffect1041ui_story = arg_75_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1041ui_story"]) then
				if arg_75_1.var_.characterEffect1041ui_story and not isNil(arg_75_1.actors_["1041ui_story"]) then
					arg_75_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1041ui_story"]) and arg_75_1.var_.characterEffect1041ui_story then
				arg_75_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 0.875

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[210].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:GetWordFromCfg(113131017)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_6 = 35 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_4) / 35)

				if (35 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_4) / 35)) > 0 and var_78_2 < var_78_6 then
					arg_75_1.talkMaxDuration = var_78_6

					if var_78_6 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131017", "story_v_out_113131.awb") ~= 0 then
					local var_78_7 = manager.audio:GetVoiceLength("story_v_out_113131", "113131017", "story_v_out_113131.awb") / 1000

					if var_78_7 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_1
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_113131", "113131017", "story_v_out_113131.awb")

						arg_75_1:RecordAudio("113131017", var_78_8)
						arg_75_1:RecordAudio("113131017", var_78_8)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_113131", "113131017", "story_v_out_113131.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_113131", "113131017", "story_v_out_113131.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_9 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_9 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_9

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_9 and arg_75_1.time_ < var_78_1 + var_78_9 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play113131018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 113131018
		arg_79_1.duration_ = 5.07

		local var_79_0 = {
			ja = 3.366,
			ko = 4.766,
			zh = 5.066,
			en = 5
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
				arg_79_0:Play113131019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_82_0 = arg_79_1.actors_["1041ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1041ui_story == nil then
				arg_79_1.var_.characterEffect1041ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_1 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 and not isNil(var_82_0) then
				if arg_79_1.var_.characterEffect1041ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1041ui_story then
				arg_79_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_82_3 = 0
			local var_82_4 = 0.6

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_3 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_5 = arg_79_1:GetWordFromCfg(113131018)
				local var_82_6 = arg_79_1:FormatText(var_82_5.content)

				arg_79_1.text_.text = var_82_6

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_8 = 24 <= 0 and var_82_4 or var_82_4 * (utf8.len(var_82_6) / 24)

				if (24 <= 0 and var_82_4 or var_82_4 * (utf8.len(var_82_6) / 24)) > 0 and var_82_4 < var_82_8 then
					arg_79_1.talkMaxDuration = var_82_8

					if var_82_8 + var_82_3 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_3
					end
				end

				arg_79_1.text_.text = var_82_6
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131018", "story_v_out_113131.awb") ~= 0 then
					local var_82_9 = manager.audio:GetVoiceLength("story_v_out_113131", "113131018", "story_v_out_113131.awb") / 1000

					if var_82_9 + var_82_3 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_3
					end

					if var_82_5.prefab_name ~= "" and arg_79_1.actors_[var_82_5.prefab_name] ~= nil then
						local var_82_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_5.prefab_name].transform, "story_v_out_113131", "113131018", "story_v_out_113131.awb")

						arg_79_1:RecordAudio("113131018", var_82_10)
						arg_79_1:RecordAudio("113131018", var_82_10)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_113131", "113131018", "story_v_out_113131.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_113131", "113131018", "story_v_out_113131.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_11 = math.max(var_82_4, arg_79_1.talkMaxDuration)

			if var_82_3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_3 + var_82_11 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_3) / var_82_11

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_3 + var_82_11 and arg_79_1.time_ < var_82_3 + var_82_11 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play113131019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 113131019
		arg_83_1.duration_ = 7.53

		local var_83_0 = {
			ja = 5.866,
			ko = 7.533,
			zh = 6.733,
			en = 6.433
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
				arg_83_0:Play113131020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1041ui_story"]) and arg_83_1.var_.characterEffect1041ui_story == nil then
				arg_83_1.var_.characterEffect1041ui_story = arg_83_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1041ui_story"]) then
				if arg_83_1.var_.characterEffect1041ui_story and not isNil(arg_83_1.actors_["1041ui_story"]) then
					arg_83_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1041ui_story"]) and arg_83_1.var_.characterEffect1041ui_story then
				arg_83_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.675

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[210].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(113131019)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 27 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 27)

				if (27 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 27)) > 0 and var_86_2 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131019", "story_v_out_113131.awb") ~= 0 then
					local var_86_7 = manager.audio:GetVoiceLength("story_v_out_113131", "113131019", "story_v_out_113131.awb") / 1000

					if var_86_7 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_1
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_113131", "113131019", "story_v_out_113131.awb")

						arg_83_1:RecordAudio("113131019", var_86_8)
						arg_83_1:RecordAudio("113131019", var_86_8)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_113131", "113131019", "story_v_out_113131.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_113131", "113131019", "story_v_out_113131.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_9 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_9 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_9

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_9 and arg_83_1.time_ < var_86_1 + var_86_9 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play113131020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 113131020
		arg_87_1.duration_ = 2.17

		local var_87_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.166,
			en = 1.999999999999
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
				arg_87_0:Play113131021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_90_0 = arg_87_1.actors_["1041ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1041ui_story == nil then
				arg_87_1.var_.characterEffect1041ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_1 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 and not isNil(var_90_0) then
				if arg_87_1.var_.characterEffect1041ui_story and not isNil(var_90_0) then
					arg_87_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1041ui_story then
				arg_87_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_90_3 = 0
			local var_90_4 = 0.05

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_5 = arg_87_1:GetWordFromCfg(113131020)
				local var_90_6 = arg_87_1:FormatText(var_90_5.content)

				arg_87_1.text_.text = var_90_6

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_8 = 2 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_6) / 2)

				if (2 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_6) / 2)) > 0 and var_90_4 < var_90_8 then
					arg_87_1.talkMaxDuration = var_90_8

					if var_90_8 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_3
					end
				end

				arg_87_1.text_.text = var_90_6
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131020", "story_v_out_113131.awb") ~= 0 then
					local var_90_9 = manager.audio:GetVoiceLength("story_v_out_113131", "113131020", "story_v_out_113131.awb") / 1000

					if var_90_9 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_3
					end

					if var_90_5.prefab_name ~= "" and arg_87_1.actors_[var_90_5.prefab_name] ~= nil then
						local var_90_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_5.prefab_name].transform, "story_v_out_113131", "113131020", "story_v_out_113131.awb")

						arg_87_1:RecordAudio("113131020", var_90_10)
						arg_87_1:RecordAudio("113131020", var_90_10)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_113131", "113131020", "story_v_out_113131.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_113131", "113131020", "story_v_out_113131.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_11 = math.max(var_90_4, arg_87_1.talkMaxDuration)

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_11 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_3) / var_90_11

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_3 + var_90_11 and arg_87_1.time_ < var_90_3 + var_90_11 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play113131021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 113131021
		arg_91_1.duration_ = 9

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play113131022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_0 = 2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				local var_94_1 = Color.New(0, 0, 0)

				var_94_1.a = Mathf.Lerp(0, 1, (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.mask_.color = var_94_1
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				local var_94_2 = Color.New(0, 0, 0)

				var_94_2.a = 1
				arg_91_1.mask_.color = var_94_2
			end

			local var_94_3 = 2

			if 2 < arg_91_1.time_ and arg_91_1.time_ <= var_94_3 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_4 = 2

			if var_94_3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_3 + var_94_4 then
				local var_94_5 = Color.New(0, 0, 0)

				var_94_5.a = Mathf.Lerp(1, 0, (arg_91_1.time_ - var_94_3) / var_94_4)
				arg_91_1.mask_.color = var_94_5
			end

			if arg_91_1.time_ >= var_94_3 + var_94_4 and arg_91_1.time_ < var_94_3 + var_94_4 + arg_94_0 then
				local var_94_6 = Color.New(0, 0, 0)

				arg_91_1.mask_.enabled = false
				var_94_6.a = 0
				arg_91_1.mask_.color = var_94_6
			end

			local var_94_7 = "ST21"

			if arg_91_1.bgs_.ST21 == nil then
				local var_94_8 = Object.Instantiate(arg_91_1.paintGo_)

				var_94_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_94_7)
				var_94_8.name = var_94_7
				var_94_8.transform.parent = arg_91_1.stage_.transform
				var_94_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.bgs_[var_94_7] = var_94_8
			end

			if 2 < arg_91_1.time_ and arg_91_1.time_ <= 2 + arg_94_0 then
				local var_94_9 = arg_91_1.bgs_.ST21

				arg_91_1.bgs_.ST21.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_94_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_10 = var_94_9:GetComponent("SpriteRenderer")

				if var_94_10 and var_94_10.sprite then
					local var_94_11 = 2 * (var_94_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_94_9.transform.localScale = Vector3.New(var_94_11 / var_94_10.sprite.bounds.size.y < var_94_11 * manager.ui.mainCameraCom_.aspect / var_94_10.sprite.bounds.size.x and var_94_11 * manager.ui.mainCameraCom_.aspect / var_94_10.sprite.bounds.size.x or var_94_11 / var_94_10.sprite.bounds.size.y, var_94_11 / var_94_10.sprite.bounds.size.y < var_94_11 * manager.ui.mainCameraCom_.aspect / var_94_10.sprite.bounds.size.x and var_94_11 * manager.ui.mainCameraCom_.aspect / var_94_10.sprite.bounds.size.x or var_94_11 / var_94_10.sprite.bounds.size.y, 0)
				end

				for iter_94_0, iter_94_1 in pairs(arg_91_1.bgs_) do
					if iter_94_0 ~= "ST21" then
						iter_94_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_94_12 = arg_91_1.actors_["1041ui_story"].transform

			if 1.966 < arg_91_1.time_ and arg_91_1.time_ <= 1.966 + arg_94_0 then
				arg_91_1.var_.moveOldPos1041ui_story = var_94_12.localPosition
			end

			local var_94_13 = 0.001

			if 1.966 <= arg_91_1.time_ and arg_91_1.time_ < 1.966 + var_94_13 then
				var_94_12.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 1.966) / var_94_13)
				var_94_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_12.position).x, (manager.ui.mainCamera.transform.position - var_94_12.position).y, (manager.ui.mainCamera.transform.position - var_94_12.position).z)
				var_94_12.localEulerAngles.z = 0
				var_94_12.localEulerAngles.x = 0
				var_94_12.localEulerAngles = var_94_12.localEulerAngles
			end

			if arg_91_1.time_ >= 1.966 + var_94_13 and arg_91_1.time_ < 1.966 + var_94_13 + arg_94_0 then
				var_94_12.localPosition = Vector3.New(0, 100, 0)
				var_94_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_12.position).x, (manager.ui.mainCamera.transform.position - var_94_12.position).y, (manager.ui.mainCamera.transform.position - var_94_12.position).z)
				var_94_12.localEulerAngles.z = 0
				var_94_12.localEulerAngles.x = 0
				var_94_12.localEulerAngles = var_94_12.localEulerAngles
			end

			if arg_91_1.frameCnt_ <= 1 then
				arg_91_1.dialog_:SetActive(false)
			end

			local var_94_14 = 4
			local var_94_15 = 0.275

			if 4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_14 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				arg_91_1.dialog_:SetActive(true)

				arg_91_1.dialogCg_.alpha = 0

				local var_94_16 = LeanTween.value(arg_91_1.dialog_, 0, 1, 0.3)

				var_94_16:setOnUpdate(LuaHelper.FloatAction(function(arg_95_0)
					arg_91_1.dialogCg_.alpha = arg_95_0
				end))
				var_94_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_91_1.dialog_)
					var_94_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_91_1.duration_ = arg_91_1.duration_ + 0.3

				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_17 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(113131021).content)

				arg_91_1.text_.text = var_94_17

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_19 = 11 <= 0 and var_94_15 or var_94_15 * (utf8.len(var_94_17) / 11)

				if (11 <= 0 and var_94_15 or var_94_15 * (utf8.len(var_94_17) / 11)) > 0 and var_94_15 < var_94_19 then
					arg_91_1.talkMaxDuration = var_94_19
					var_94_14 = var_94_14 + 0.3

					if var_94_19 + var_94_14 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_19 + var_94_14
					end
				end

				arg_91_1.text_.text = var_94_17
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_20 = var_94_14 + 0.3
			local var_94_21 = math.max(var_94_15, arg_91_1.talkMaxDuration)

			if var_94_14 + 0.3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_20 + var_94_21 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_20) / var_94_21

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_20 + var_94_21 and arg_91_1.time_ < var_94_20 + var_94_21 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play113131022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 113131022
		arg_97_1.duration_ = 3.37

		local var_97_0 = {
			ja = 3.366,
			ko = 2.466,
			zh = 2.666,
			en = 2.1
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
				arg_97_0:Play113131023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.3

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1068")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:GetWordFromCfg(113131022)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 12 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 12)

				if (12 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 12)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131022", "story_v_out_113131.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_113131", "113131022", "story_v_out_113131.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_113131", "113131022", "story_v_out_113131.awb")

						arg_97_1:RecordAudio("113131022", var_100_6)
						arg_97_1:RecordAudio("113131022", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_113131", "113131022", "story_v_out_113131.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_113131", "113131022", "story_v_out_113131.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play113131023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 113131023
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play113131024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.675

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(113131023).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 28 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 28)

				if (28 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 28)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play113131024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 113131024
		arg_105_1.duration_ = 9.5

		local var_105_0 = {
			ja = 9.5,
			ko = 7,
			zh = 7.433,
			en = 5.333
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
				arg_105_0:Play113131025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if arg_105_1.actors_["1068ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1068ui_story"))) then
				local var_108_0 = Object.Instantiate(Asset.Load("Char/" .. "1068ui_story"), arg_105_1.stage_.transform)

				var_108_0.name = "1068ui_story"
				var_108_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["1068ui_story"] = var_108_0

				local var_108_1 = var_108_0:GetComponentInChildren(typeof(CharacterEffect))

				var_108_1.enabled = true

				local var_108_2 = GameObjectTools.GetOrAddComponent(var_108_0, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(false)
				end

				arg_105_1:ShowWeapon(var_108_1.transform, false)

				arg_105_1.var_["1068ui_story" .. "Animator"] = var_108_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_105_1.var_["1068ui_story" .. "Animator"].applyRootMotion = true
				arg_105_1.var_["1068ui_story" .. "LipSync"] = var_108_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_108_3 = arg_105_1.actors_["1068ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1068ui_story = var_108_3.localPosition
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_3.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1068ui_story, Vector3.New(-0.7, -0.95, -5.88), (arg_105_1.time_ - 0) / var_108_4)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_3.localPosition = Vector3.New(-0.7, -0.95, -5.88)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_108_5 = arg_105_1.actors_["1068ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect1068ui_story == nil then
				arg_105_1.var_.characterEffect1068ui_story = var_108_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_6 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.characterEffect1068ui_story and not isNil(var_108_5) then
					arg_105_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect1068ui_story then
				arg_105_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_108_8 = 0
			local var_108_9 = 0.725

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(113131024)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 29 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 29)

				if (29 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 29)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131024", "story_v_out_113131.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_113131", "113131024", "story_v_out_113131.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_113131", "113131024", "story_v_out_113131.awb")

						arg_105_1:RecordAudio("113131024", var_108_15)
						arg_105_1:RecordAudio("113131024", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_113131", "113131024", "story_v_out_113131.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_113131", "113131024", "story_v_out_113131.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play113131025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 113131025
		arg_109_1.duration_ = 8.23

		local var_109_0 = {
			ja = 8.233,
			ko = 6.433,
			zh = 6.5,
			en = 7.466
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
				arg_109_0:Play113131026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if arg_109_1.actors_["1067ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1067ui_story"))) then
				local var_112_0 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_109_1.stage_.transform)

				var_112_0.name = "1067ui_story"
				var_112_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["1067ui_story"] = var_112_0

				local var_112_1 = var_112_0:GetComponentInChildren(typeof(CharacterEffect))

				var_112_1.enabled = true

				local var_112_2 = GameObjectTools.GetOrAddComponent(var_112_0, typeof(DynamicBoneHelper))

				if var_112_2 then
					var_112_2:EnableDynamicBone(false)
				end

				arg_109_1:ShowWeapon(var_112_1.transform, false)

				arg_109_1.var_["1067ui_story" .. "Animator"] = var_112_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_109_1.var_["1067ui_story" .. "Animator"].applyRootMotion = true
				arg_109_1.var_["1067ui_story" .. "LipSync"] = var_112_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_112_3 = arg_109_1.actors_["1067ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1067ui_story = var_112_3.localPosition
			end

			local var_112_4 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				var_112_3.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1067ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_109_1.time_ - 0) / var_112_4)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				var_112_3.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_112_5 = arg_109_1.actors_["1067ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1067ui_story == nil then
				arg_109_1.var_.characterEffect1067ui_story = var_112_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_6 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.characterEffect1067ui_story and not isNil(var_112_5) then
					arg_109_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1067ui_story then
				arg_109_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_112_8 = arg_109_1.actors_["1068ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.characterEffect1068ui_story == nil then
				arg_109_1.var_.characterEffect1068ui_story = var_112_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_9 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_9 and not isNil(var_112_8) then
				if arg_109_1.var_.characterEffect1068ui_story and not isNil(var_112_8) then
					arg_109_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_9)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_9 and arg_109_1.time_ < 0 + var_112_9 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.characterEffect1068ui_story then
				arg_109_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_112_10 = 0
			local var_112_11 = 0.725

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_12 = arg_109_1:GetWordFromCfg(113131025)
				local var_112_13 = arg_109_1:FormatText(var_112_12.content)

				arg_109_1.text_.text = var_112_13

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_15 = 29 <= 0 and var_112_11 or var_112_11 * (utf8.len(var_112_13) / 29)

				if (29 <= 0 and var_112_11 or var_112_11 * (utf8.len(var_112_13) / 29)) > 0 and var_112_11 < var_112_15 then
					arg_109_1.talkMaxDuration = var_112_15

					if var_112_15 + var_112_10 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_15 + var_112_10
					end
				end

				arg_109_1.text_.text = var_112_13
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131025", "story_v_out_113131.awb") ~= 0 then
					local var_112_16 = manager.audio:GetVoiceLength("story_v_out_113131", "113131025", "story_v_out_113131.awb") / 1000

					if var_112_16 + var_112_10 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_16 + var_112_10
					end

					if var_112_12.prefab_name ~= "" and arg_109_1.actors_[var_112_12.prefab_name] ~= nil then
						local var_112_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_12.prefab_name].transform, "story_v_out_113131", "113131025", "story_v_out_113131.awb")

						arg_109_1:RecordAudio("113131025", var_112_17)
						arg_109_1:RecordAudio("113131025", var_112_17)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_113131", "113131025", "story_v_out_113131.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_113131", "113131025", "story_v_out_113131.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_18 = math.max(var_112_11, arg_109_1.talkMaxDuration)

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_18 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_10) / var_112_18

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_10 + var_112_18 and arg_109_1.time_ < var_112_10 + var_112_18 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play113131026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 113131026
		arg_113_1.duration_ = 8.53

		local var_113_0 = {
			ja = 8.533,
			ko = 4.866,
			zh = 4.966,
			en = 5.5
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play113131027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1068ui_story"]) and arg_113_1.var_.characterEffect1068ui_story == nil then
				arg_113_1.var_.characterEffect1068ui_story = arg_113_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1068ui_story"]) then
				if arg_113_1.var_.characterEffect1068ui_story and not isNil(arg_113_1.actors_["1068ui_story"]) then
					arg_113_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1068ui_story"]) and arg_113_1.var_.characterEffect1068ui_story then
				arg_113_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_116_2 = arg_113_1.actors_["1067ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1067ui_story == nil then
				arg_113_1.var_.characterEffect1067ui_story = var_116_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_3 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.characterEffect1067ui_story and not isNil(var_116_2) then
					arg_113_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_3)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1067ui_story then
				arg_113_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_116_4 = 0
			local var_116_5 = 0.55

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(113131026)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 20 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 20)

				if (20 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 20)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131026", "story_v_out_113131.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_113131", "113131026", "story_v_out_113131.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_113131", "113131026", "story_v_out_113131.awb")

						arg_113_1:RecordAudio("113131026", var_116_11)
						arg_113_1:RecordAudio("113131026", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_113131", "113131026", "story_v_out_113131.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_113131", "113131026", "story_v_out_113131.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play113131027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 113131027
		arg_117_1.duration_ = 5.87

		local var_117_0 = {
			ja = 5.866,
			ko = 4.166,
			zh = 4.066,
			en = 5.4
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play113131028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1068ui_story"]) and arg_117_1.var_.characterEffect1068ui_story == nil then
				arg_117_1.var_.characterEffect1068ui_story = arg_117_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1068ui_story"]) then
				if arg_117_1.var_.characterEffect1068ui_story and not isNil(arg_117_1.actors_["1068ui_story"]) then
					arg_117_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1068ui_story"]) and arg_117_1.var_.characterEffect1068ui_story then
				arg_117_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_120_1 = arg_117_1.actors_["1067ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1067ui_story == nil then
				arg_117_1.var_.characterEffect1067ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1067ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1067ui_story then
				arg_117_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_2")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_120_4 = 0
			local var_120_5 = 0.45

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(113131027)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 18 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 18)

				if (18 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 18)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131027", "story_v_out_113131.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_113131", "113131027", "story_v_out_113131.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_113131", "113131027", "story_v_out_113131.awb")

						arg_117_1:RecordAudio("113131027", var_120_11)
						arg_117_1:RecordAudio("113131027", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_113131", "113131027", "story_v_out_113131.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_113131", "113131027", "story_v_out_113131.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play113131028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 113131028
		arg_121_1.duration_ = 6.87

		local var_121_0 = {
			ja = 6.866,
			ko = 5.6,
			zh = 6.1,
			en = 5.033
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
				arg_121_0:Play113131029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1067ui_story"]) and arg_121_1.var_.characterEffect1067ui_story == nil then
				arg_121_1.var_.characterEffect1067ui_story = arg_121_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1067ui_story"]) then
				if arg_121_1.var_.characterEffect1067ui_story and not isNil(arg_121_1.actors_["1067ui_story"]) then
					arg_121_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1067ui_story"]) and arg_121_1.var_.characterEffect1067ui_story then
				arg_121_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_124_1 = arg_121_1.actors_["1068ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1068ui_story == nil then
				arg_121_1.var_.characterEffect1068ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1068ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1068ui_story then
				arg_121_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action3_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_124_4 = 0
			local var_124_5 = 0.5

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(113131028)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 20 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 20)

				if (20 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 20)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131028", "story_v_out_113131.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_113131", "113131028", "story_v_out_113131.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_113131", "113131028", "story_v_out_113131.awb")

						arg_121_1:RecordAudio("113131028", var_124_11)
						arg_121_1:RecordAudio("113131028", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_113131", "113131028", "story_v_out_113131.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_113131", "113131028", "story_v_out_113131.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play113131029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 113131029
		arg_125_1.duration_ = 3.5

		local var_125_0 = {
			ja = 3.5,
			ko = 3.2,
			zh = 2.3,
			en = 2.733
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
				arg_125_0:Play113131030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1068ui_story"]) and arg_125_1.var_.characterEffect1068ui_story == nil then
				arg_125_1.var_.characterEffect1068ui_story = arg_125_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1068ui_story"]) then
				if arg_125_1.var_.characterEffect1068ui_story and not isNil(arg_125_1.actors_["1068ui_story"]) then
					arg_125_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1068ui_story"]) and arg_125_1.var_.characterEffect1068ui_story then
				arg_125_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_128_1 = arg_125_1.actors_["1067ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1067ui_story == nil then
				arg_125_1.var_.characterEffect1067ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1067ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1067ui_story then
				arg_125_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_128_4 = 0
			local var_128_5 = 0.2

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(113131029)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 8 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 8)

				if (8 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 8)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131029", "story_v_out_113131.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_113131", "113131029", "story_v_out_113131.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_113131", "113131029", "story_v_out_113131.awb")

						arg_125_1:RecordAudio("113131029", var_128_11)
						arg_125_1:RecordAudio("113131029", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_113131", "113131029", "story_v_out_113131.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_113131", "113131029", "story_v_out_113131.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play113131030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 113131030
		arg_129_1.duration_ = 10

		local var_129_0 = {
			ja = 10,
			ko = 7.733,
			zh = 6.7,
			en = 7.466
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
				arg_129_0:Play113131031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1068ui_story"]) and arg_129_1.var_.characterEffect1068ui_story == nil then
				arg_129_1.var_.characterEffect1068ui_story = arg_129_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1068ui_story"]) then
				if arg_129_1.var_.characterEffect1068ui_story and not isNil(arg_129_1.actors_["1068ui_story"]) then
					arg_129_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1068ui_story"]) and arg_129_1.var_.characterEffect1068ui_story then
				arg_129_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action3_2")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_132_2 = arg_129_1.actors_["1067ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1067ui_story == nil then
				arg_129_1.var_.characterEffect1067ui_story = var_132_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_3 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.characterEffect1067ui_story and not isNil(var_132_2) then
					arg_129_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_3)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1067ui_story then
				arg_129_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_132_4 = 0
			local var_132_5 = 0.75

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(113131030)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 30 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 30)

				if (30 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 30)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131030", "story_v_out_113131.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_113131", "113131030", "story_v_out_113131.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_113131", "113131030", "story_v_out_113131.awb")

						arg_129_1:RecordAudio("113131030", var_132_11)
						arg_129_1:RecordAudio("113131030", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_113131", "113131030", "story_v_out_113131.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_113131", "113131030", "story_v_out_113131.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play113131031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 113131031
		arg_133_1.duration_ = 3.3

		local var_133_0 = {
			ja = 2.066,
			ko = 2.133,
			zh = 3.3,
			en = 2.733
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
				arg_133_0:Play113131032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1067ui_story"]) and arg_133_1.var_.characterEffect1067ui_story == nil then
				arg_133_1.var_.characterEffect1067ui_story = arg_133_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1067ui_story"]) then
				if arg_133_1.var_.characterEffect1067ui_story and not isNil(arg_133_1.actors_["1067ui_story"]) then
					arg_133_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1067ui_story"]) and arg_133_1.var_.characterEffect1067ui_story then
				arg_133_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_136_2 = arg_133_1.actors_["1068ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect1068ui_story == nil then
				arg_133_1.var_.characterEffect1068ui_story = var_136_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_3 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.characterEffect1068ui_story and not isNil(var_136_2) then
					arg_133_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_3)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect1068ui_story then
				arg_133_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_136_4 = 0
			local var_136_5 = 0.15

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(113131031)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 6 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 6)

				if (6 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 6)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131031", "story_v_out_113131.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_113131", "113131031", "story_v_out_113131.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_113131", "113131031", "story_v_out_113131.awb")

						arg_133_1:RecordAudio("113131031", var_136_11)
						arg_133_1:RecordAudio("113131031", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_113131", "113131031", "story_v_out_113131.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_113131", "113131031", "story_v_out_113131.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play113131032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 113131032
		arg_137_1.duration_ = 4.27

		local var_137_0 = {
			ja = 3.7,
			ko = 4.1,
			zh = 4.266,
			en = 2.8
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
				arg_137_0:Play113131033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1067ui_story"]) and arg_137_1.var_.characterEffect1067ui_story == nil then
				arg_137_1.var_.characterEffect1067ui_story = arg_137_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1067ui_story"]) then
				if arg_137_1.var_.characterEffect1067ui_story and not isNil(arg_137_1.actors_["1067ui_story"]) then
					arg_137_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1067ui_story"]) and arg_137_1.var_.characterEffect1067ui_story then
				arg_137_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_2")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_140_1 = 0
			local var_140_2 = 0.475

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(113131032)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 19 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_4) / 19)

				if (19 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_4) / 19)) > 0 and var_140_2 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131032", "story_v_out_113131.awb") ~= 0 then
					local var_140_7 = manager.audio:GetVoiceLength("story_v_out_113131", "113131032", "story_v_out_113131.awb") / 1000

					if var_140_7 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_1
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_113131", "113131032", "story_v_out_113131.awb")

						arg_137_1:RecordAudio("113131032", var_140_8)
						arg_137_1:RecordAudio("113131032", var_140_8)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_113131", "113131032", "story_v_out_113131.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_113131", "113131032", "story_v_out_113131.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_9 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_9 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_9

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_9 and arg_137_1.time_ < var_140_1 + var_140_9 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play113131033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 113131033
		arg_141_1.duration_ = 4.93

		local var_141_0 = {
			ja = 3.2,
			ko = 4.933,
			zh = 4.466,
			en = 3.033
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
				arg_141_0:Play113131034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1068ui_story"]) and arg_141_1.var_.characterEffect1068ui_story == nil then
				arg_141_1.var_.characterEffect1068ui_story = arg_141_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1068ui_story"]) then
				if arg_141_1.var_.characterEffect1068ui_story and not isNil(arg_141_1.actors_["1068ui_story"]) then
					arg_141_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1068ui_story"]) and arg_141_1.var_.characterEffect1068ui_story then
				arg_141_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_144_2 = 0
			local var_144_3 = 0.45

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_4 = arg_141_1:GetWordFromCfg(113131033)
				local var_144_5 = arg_141_1:FormatText(var_144_4.content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_7 = 18 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 18)

				if (18 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 18)) > 0 and var_144_3 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131033", "story_v_out_113131.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_113131", "113131033", "story_v_out_113131.awb") / 1000

					if var_144_8 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_2
					end

					if var_144_4.prefab_name ~= "" and arg_141_1.actors_[var_144_4.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_4.prefab_name].transform, "story_v_out_113131", "113131033", "story_v_out_113131.awb")

						arg_141_1:RecordAudio("113131033", var_144_9)
						arg_141_1:RecordAudio("113131033", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_113131", "113131033", "story_v_out_113131.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_113131", "113131033", "story_v_out_113131.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_10 and arg_141_1.time_ < var_144_2 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play113131034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 113131034
		arg_145_1.duration_ = 8.97

		local var_145_0 = {
			ja = 8.966,
			ko = 5.9,
			zh = 5.566,
			en = 5.733
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
				arg_145_0:Play113131035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1067ui_story = arg_145_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1067ui_story"].transform.position).z)
				arg_145_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1067ui_story"].transform.localEulerAngles = arg_145_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1067ui_story"].transform.position).z)
				arg_145_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1067ui_story"].transform.localEulerAngles = arg_145_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_148_1 = "1042ui_story"

			if arg_145_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_148_2 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_145_1.stage_.transform)

				var_148_2.name = var_148_1
				var_148_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_[var_148_1] = var_148_2

				local var_148_3 = var_148_2:GetComponentInChildren(typeof(CharacterEffect))

				var_148_3.enabled = true

				local var_148_4 = GameObjectTools.GetOrAddComponent(var_148_2, typeof(DynamicBoneHelper))

				if var_148_4 then
					var_148_4:EnableDynamicBone(false)
				end

				arg_145_1:ShowWeapon(var_148_3.transform, false)

				arg_145_1.var_[var_148_1 .. "Animator"] = var_148_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_145_1.var_[var_148_1 .. "Animator"].applyRootMotion = true
				arg_145_1.var_[var_148_1 .. "LipSync"] = var_148_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_148_5 = arg_145_1.actors_["1042ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1042ui_story = var_148_5.localPosition
			end

			local var_148_6 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 then
				var_148_5.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_145_1.time_ - 0) / var_148_6)
				var_148_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_5.position).x, (manager.ui.mainCamera.transform.position - var_148_5.position).y, (manager.ui.mainCamera.transform.position - var_148_5.position).z)
				var_148_5.localEulerAngles.z = 0
				var_148_5.localEulerAngles.x = 0
				var_148_5.localEulerAngles = var_148_5.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 then
				var_148_5.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_148_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_5.position).x, (manager.ui.mainCamera.transform.position - var_148_5.position).y, (manager.ui.mainCamera.transform.position - var_148_5.position).z)
				var_148_5.localEulerAngles.z = 0
				var_148_5.localEulerAngles.x = 0
				var_148_5.localEulerAngles = var_148_5.localEulerAngles
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_148_7 = arg_145_1.actors_["1042ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.characterEffect1042ui_story == nil then
				arg_145_1.var_.characterEffect1042ui_story = var_148_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_8 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_8 and not isNil(var_148_7) then
				if arg_145_1.var_.characterEffect1042ui_story and not isNil(var_148_7) then
					arg_145_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_8 and arg_145_1.time_ < 0 + var_148_8 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.characterEffect1042ui_story then
				arg_145_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_148_10 = arg_145_1.actors_["1068ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_10) and arg_145_1.var_.characterEffect1068ui_story == nil then
				arg_145_1.var_.characterEffect1068ui_story = var_148_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_11 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_11 and not isNil(var_148_10) then
				if arg_145_1.var_.characterEffect1068ui_story and not isNil(var_148_10) then
					arg_145_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_11)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_11 and arg_145_1.time_ < 0 + var_148_11 + arg_148_0 and not isNil(var_148_10) and arg_145_1.var_.characterEffect1068ui_story then
				arg_145_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_148_12 = 0
			local var_148_13 = 0.65

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_12 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_14 = arg_145_1:GetWordFromCfg(113131034)
				local var_148_15 = arg_145_1:FormatText(var_148_14.content)

				arg_145_1.text_.text = var_148_15

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_17 = 26 <= 0 and var_148_13 or var_148_13 * (utf8.len(var_148_15) / 26)

				if (26 <= 0 and var_148_13 or var_148_13 * (utf8.len(var_148_15) / 26)) > 0 and var_148_13 < var_148_17 then
					arg_145_1.talkMaxDuration = var_148_17

					if var_148_17 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_17 + var_148_12
					end
				end

				arg_145_1.text_.text = var_148_15
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131034", "story_v_out_113131.awb") ~= 0 then
					local var_148_18 = manager.audio:GetVoiceLength("story_v_out_113131", "113131034", "story_v_out_113131.awb") / 1000

					if var_148_18 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_18 + var_148_12
					end

					if var_148_14.prefab_name ~= "" and arg_145_1.actors_[var_148_14.prefab_name] ~= nil then
						local var_148_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_14.prefab_name].transform, "story_v_out_113131", "113131034", "story_v_out_113131.awb")

						arg_145_1:RecordAudio("113131034", var_148_19)
						arg_145_1:RecordAudio("113131034", var_148_19)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_113131", "113131034", "story_v_out_113131.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_113131", "113131034", "story_v_out_113131.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_20 = math.max(var_148_13, arg_145_1.talkMaxDuration)

			if var_148_12 <= arg_145_1.time_ and arg_145_1.time_ < var_148_12 + var_148_20 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_12) / var_148_20

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_12 + var_148_20 and arg_145_1.time_ < var_148_12 + var_148_20 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play113131035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 113131035
		arg_149_1.duration_ = 16.1

		local var_149_0 = {
			ja = 16.1,
			ko = 10.1,
			zh = 12,
			en = 13.666
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
				arg_149_0:Play113131036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action6_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_152_0 = arg_149_1.actors_["1042ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1042ui_story == nil then
				arg_149_1.var_.characterEffect1042ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_1 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 and not isNil(var_152_0) then
				if arg_149_1.var_.characterEffect1042ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_1)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1042ui_story then
				arg_149_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_152_2 = arg_149_1.actors_["1068ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1068ui_story == nil then
				arg_149_1.var_.characterEffect1068ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect1068ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1068ui_story then
				arg_149_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_152_5 = 0
			local var_152_6 = 1.4

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_7 = arg_149_1:GetWordFromCfg(113131035)
				local var_152_8 = arg_149_1:FormatText(var_152_7.content)

				arg_149_1.text_.text = var_152_8

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_10 = 56 <= 0 and var_152_6 or var_152_6 * (utf8.len(var_152_8) / 56)

				if (56 <= 0 and var_152_6 or var_152_6 * (utf8.len(var_152_8) / 56)) > 0 and var_152_6 < var_152_10 then
					arg_149_1.talkMaxDuration = var_152_10

					if var_152_10 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_5
					end
				end

				arg_149_1.text_.text = var_152_8
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131035", "story_v_out_113131.awb") ~= 0 then
					local var_152_11 = manager.audio:GetVoiceLength("story_v_out_113131", "113131035", "story_v_out_113131.awb") / 1000

					if var_152_11 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_5
					end

					if var_152_7.prefab_name ~= "" and arg_149_1.actors_[var_152_7.prefab_name] ~= nil then
						local var_152_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_7.prefab_name].transform, "story_v_out_113131", "113131035", "story_v_out_113131.awb")

						arg_149_1:RecordAudio("113131035", var_152_12)
						arg_149_1:RecordAudio("113131035", var_152_12)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_113131", "113131035", "story_v_out_113131.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_113131", "113131035", "story_v_out_113131.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_13 = math.max(var_152_6, arg_149_1.talkMaxDuration)

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_13 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_5) / var_152_13

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_5 + var_152_13 and arg_149_1.time_ < var_152_5 + var_152_13 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play113131036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 113131036
		arg_153_1.duration_ = 5.97

		local var_153_0 = {
			ja = 5.966,
			ko = 3.366,
			zh = 4.4,
			en = 4
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
				arg_153_0:Play113131037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1068ui_story"]) and arg_153_1.var_.characterEffect1068ui_story == nil then
				arg_153_1.var_.characterEffect1068ui_story = arg_153_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1068ui_story"]) then
				if arg_153_1.var_.characterEffect1068ui_story and not isNil(arg_153_1.actors_["1068ui_story"]) then
					arg_153_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1068ui_story"]) and arg_153_1.var_.characterEffect1068ui_story then
				arg_153_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 0.475

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(113131036)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_6 = 19 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_4) / 19)

				if (19 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_4) / 19)) > 0 and var_156_2 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131036", "story_v_out_113131.awb") ~= 0 then
					local var_156_7 = manager.audio:GetVoiceLength("story_v_out_113131", "113131036", "story_v_out_113131.awb") / 1000

					if var_156_7 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_1
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_113131", "113131036", "story_v_out_113131.awb")

						arg_153_1:RecordAudio("113131036", var_156_8)
						arg_153_1:RecordAudio("113131036", var_156_8)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_113131", "113131036", "story_v_out_113131.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_113131", "113131036", "story_v_out_113131.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_9 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_9 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_9

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_9 and arg_153_1.time_ < var_156_1 + var_156_9 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play113131037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 113131037
		arg_157_1.duration_ = 6.5

		local var_157_0 = {
			ja = 6.5,
			ko = 5.7,
			zh = 6.166,
			en = 6.5
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play113131038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_160_0 = arg_157_1.actors_["1042ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1042ui_story == nil then
				arg_157_1.var_.characterEffect1042ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_1 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_1 and not isNil(var_160_0) then
				if arg_157_1.var_.characterEffect1042ui_story and not isNil(var_160_0) then
					arg_157_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_1 and arg_157_1.time_ < 0 + var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1042ui_story then
				arg_157_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_160_3 = arg_157_1.actors_["1067ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_3) and arg_157_1.var_.characterEffect1067ui_story == nil then
				arg_157_1.var_.characterEffect1067ui_story = var_160_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_4 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 and not isNil(var_160_3) then
				if arg_157_1.var_.characterEffect1067ui_story and not isNil(var_160_3) then
					arg_157_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_4)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 and not isNil(var_160_3) and arg_157_1.var_.characterEffect1067ui_story then
				arg_157_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_160_5 = 0
			local var_160_6 = 0.675

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_7 = arg_157_1:GetWordFromCfg(113131037)
				local var_160_8 = arg_157_1:FormatText(var_160_7.content)

				arg_157_1.text_.text = var_160_8

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_10 = 27 <= 0 and var_160_6 or var_160_6 * (utf8.len(var_160_8) / 27)

				if (27 <= 0 and var_160_6 or var_160_6 * (utf8.len(var_160_8) / 27)) > 0 and var_160_6 < var_160_10 then
					arg_157_1.talkMaxDuration = var_160_10

					if var_160_10 + var_160_5 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_5
					end
				end

				arg_157_1.text_.text = var_160_8
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131037", "story_v_out_113131.awb") ~= 0 then
					local var_160_11 = manager.audio:GetVoiceLength("story_v_out_113131", "113131037", "story_v_out_113131.awb") / 1000

					if var_160_11 + var_160_5 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_11 + var_160_5
					end

					if var_160_7.prefab_name ~= "" and arg_157_1.actors_[var_160_7.prefab_name] ~= nil then
						local var_160_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_7.prefab_name].transform, "story_v_out_113131", "113131037", "story_v_out_113131.awb")

						arg_157_1:RecordAudio("113131037", var_160_12)
						arg_157_1:RecordAudio("113131037", var_160_12)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_113131", "113131037", "story_v_out_113131.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_113131", "113131037", "story_v_out_113131.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_13 = math.max(var_160_6, arg_157_1.talkMaxDuration)

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_13 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_5) / var_160_13

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_5 + var_160_13 and arg_157_1.time_ < var_160_5 + var_160_13 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play113131038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 113131038
		arg_161_1.duration_ = 9.43

		local var_161_0 = {
			ja = 9.433,
			ko = 5.066,
			zh = 4.533,
			en = 4.533
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
			arg_161_1.auto_ = false
		end

		function arg_161_1.playNext_(arg_163_0)
			arg_161_1.onStoryFinished_()
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_164_0 = arg_161_1.actors_["1042ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1042ui_story == nil then
				arg_161_1.var_.characterEffect1042ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_1 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 and not isNil(var_164_0) then
				if arg_161_1.var_.characterEffect1042ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_1)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1042ui_story then
				arg_161_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_164_2 = arg_161_1.actors_["1068ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.characterEffect1068ui_story == nil then
				arg_161_1.var_.characterEffect1068ui_story = var_164_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_3 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 and not isNil(var_164_2) then
				if arg_161_1.var_.characterEffect1068ui_story and not isNil(var_164_2) then
					arg_161_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.characterEffect1068ui_story then
				arg_161_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_164_5 = arg_161_1.actors_["1068ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1068ui_story = var_164_5.localPosition
			end

			local var_164_6 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 then
				var_164_5.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1068ui_story, Vector3.New(-0.7, -0.95, -5.88), (arg_161_1.time_ - 0) / var_164_6)
				var_164_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_5.position).x, (manager.ui.mainCamera.transform.position - var_164_5.position).y, (manager.ui.mainCamera.transform.position - var_164_5.position).z)
				var_164_5.localEulerAngles.z = 0
				var_164_5.localEulerAngles.x = 0
				var_164_5.localEulerAngles = var_164_5.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 then
				var_164_5.localPosition = Vector3.New(-0.7, -0.95, -5.88)
				var_164_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_5.position).x, (manager.ui.mainCamera.transform.position - var_164_5.position).y, (manager.ui.mainCamera.transform.position - var_164_5.position).z)
				var_164_5.localEulerAngles.z = 0
				var_164_5.localEulerAngles.x = 0
				var_164_5.localEulerAngles = var_164_5.localEulerAngles
			end

			local var_164_7 = arg_161_1.actors_["1067ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1067ui_story = var_164_7.localPosition
			end

			local var_164_8 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_8 then
				var_164_7.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_8)
				var_164_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_7.position).x, (manager.ui.mainCamera.transform.position - var_164_7.position).y, (manager.ui.mainCamera.transform.position - var_164_7.position).z)
				var_164_7.localEulerAngles.z = 0
				var_164_7.localEulerAngles.x = 0
				var_164_7.localEulerAngles = var_164_7.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_8 and arg_161_1.time_ < 0 + var_164_8 + arg_164_0 then
				var_164_7.localPosition = Vector3.New(0, 100, 0)
				var_164_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_7.position).x, (manager.ui.mainCamera.transform.position - var_164_7.position).y, (manager.ui.mainCamera.transform.position - var_164_7.position).z)
				var_164_7.localEulerAngles.z = 0
				var_164_7.localEulerAngles.x = 0
				var_164_7.localEulerAngles = var_164_7.localEulerAngles
			end

			local var_164_9 = 0
			local var_164_10 = 0.5

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_11 = arg_161_1:GetWordFromCfg(113131038)
				local var_164_12 = arg_161_1:FormatText(var_164_11.content)

				arg_161_1.text_.text = var_164_12

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_14 = 20 <= 0 and var_164_10 or var_164_10 * (utf8.len(var_164_12) / 20)

				if (20 <= 0 and var_164_10 or var_164_10 * (utf8.len(var_164_12) / 20)) > 0 and var_164_10 < var_164_14 then
					arg_161_1.talkMaxDuration = var_164_14

					if var_164_14 + var_164_9 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_9
					end
				end

				arg_161_1.text_.text = var_164_12
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113131", "113131038", "story_v_out_113131.awb") ~= 0 then
					local var_164_15 = manager.audio:GetVoiceLength("story_v_out_113131", "113131038", "story_v_out_113131.awb") / 1000

					if var_164_15 + var_164_9 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_15 + var_164_9
					end

					if var_164_11.prefab_name ~= "" and arg_161_1.actors_[var_164_11.prefab_name] ~= nil then
						local var_164_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_11.prefab_name].transform, "story_v_out_113131", "113131038", "story_v_out_113131.awb")

						arg_161_1:RecordAudio("113131038", var_164_16)
						arg_161_1:RecordAudio("113131038", var_164_16)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_113131", "113131038", "story_v_out_113131.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_113131", "113131038", "story_v_out_113131.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_17 = math.max(var_164_10, arg_161_1.talkMaxDuration)

			if var_164_9 <= arg_161_1.time_ and arg_161_1.time_ < var_164_9 + var_164_17 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_9) / var_164_17

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_9 + var_164_17 and arg_161_1.time_ < var_164_9 + var_164_17 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/OM0108",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST21a",
		"TextureConfig/Background/ST21"
	},
	voices = {
		"story_v_out_113131.awb"
	}
}
