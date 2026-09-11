return {
	Play317031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317031001
		arg_1_1.duration_ = 4.5

		local var_1_0 = {
			zh = 4.233,
			ja = 4.5
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
				arg_1_0:Play317031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.YA0102 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "YA0102")
				var_4_0.name = "YA0102"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.YA0102 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.YA0102

				arg_1_1.bgs_.YA0102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "YA0102" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 1.56666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.56666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 0.2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:GetWordFromCfg(317031001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 8 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 8)

				if (8 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 8)) > 0 and var_4_15 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_14 = var_4_14 + 0.3

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031001", "story_v_out_317031.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_317031", "317031001", "story_v_out_317031.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_317031", "317031001", "story_v_out_317031.awb")

						arg_1_1:RecordAudio("317031001", var_4_22)
						arg_1_1:RecordAudio("317031001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_317031", "317031001", "story_v_out_317031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_317031", "317031001", "story_v_out_317031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_14 + 0.3
			local var_4_24 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play317031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317031002
		arg_9_1.duration_ = 5.2

		local var_9_0 = {
			zh = 4.133,
			ja = 5.2
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
				arg_9_0:Play317031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.375

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(317031002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 15 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 15)

				if (15 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 15)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031002", "story_v_out_317031.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031002", "story_v_out_317031.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_317031", "317031002", "story_v_out_317031.awb")

						arg_9_1:RecordAudio("317031002", var_12_6)
						arg_9_1:RecordAudio("317031002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_317031", "317031002", "story_v_out_317031.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_317031", "317031002", "story_v_out_317031.awb")
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
	Play317031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317031003
		arg_13_1.duration_ = 13

		local var_13_0 = {
			zh = 11.233,
			ja = 13
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
				arg_13_0:Play317031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.075

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(317031003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 43 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 43)

				if (43 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 43)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031003", "story_v_out_317031.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031003", "story_v_out_317031.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_317031", "317031003", "story_v_out_317031.awb")

						arg_13_1:RecordAudio("317031003", var_16_6)
						arg_13_1:RecordAudio("317031003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_317031", "317031003", "story_v_out_317031.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_317031", "317031003", "story_v_out_317031.awb")
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
	Play317031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317031004
		arg_17_1.duration_ = 15.3

		local var_17_0 = {
			zh = 15.3,
			ja = 10.9
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
				arg_17_0:Play317031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.725

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(317031004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 69 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 69)

				if (69 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 69)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031004", "story_v_out_317031.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031004", "story_v_out_317031.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_317031", "317031004", "story_v_out_317031.awb")

						arg_17_1:RecordAudio("317031004", var_20_6)
						arg_17_1:RecordAudio("317031004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_317031", "317031004", "story_v_out_317031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_317031", "317031004", "story_v_out_317031.awb")
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
	Play317031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317031005
		arg_21_1.duration_ = 12.1

		local var_21_0 = {
			zh = 10.866,
			ja = 12.1
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
				arg_21_0:Play317031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.175

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(317031005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 47 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 47)

				if (47 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 47)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031005", "story_v_out_317031.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031005", "story_v_out_317031.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_317031", "317031005", "story_v_out_317031.awb")

						arg_21_1:RecordAudio("317031005", var_24_6)
						arg_21_1:RecordAudio("317031005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_317031", "317031005", "story_v_out_317031.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_317031", "317031005", "story_v_out_317031.awb")
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
	Play317031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317031006
		arg_25_1.duration_ = 8.8

		local var_25_0 = {
			zh = 8.8,
			ja = 7.533
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
				arg_25_0:Play317031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.775

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(317031006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 31 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 31)

				if (31 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 31)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031006", "story_v_out_317031.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031006", "story_v_out_317031.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_317031", "317031006", "story_v_out_317031.awb")

						arg_25_1:RecordAudio("317031006", var_28_6)
						arg_25_1:RecordAudio("317031006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_317031", "317031006", "story_v_out_317031.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_317031", "317031006", "story_v_out_317031.awb")
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
	Play317031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317031007
		arg_29_1.duration_ = 1.33

		local var_29_0 = {
			zh = 1.333,
			ja = 1.133
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
				arg_29_0:Play317031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.1

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(317031007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 4 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 4)

				if (4 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 4)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031007", "story_v_out_317031.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031007", "story_v_out_317031.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_317031", "317031007", "story_v_out_317031.awb")

						arg_29_1:RecordAudio("317031007", var_32_6)
						arg_29_1:RecordAudio("317031007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_317031", "317031007", "story_v_out_317031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_317031", "317031007", "story_v_out_317031.awb")
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
	Play317031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 317031008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play317031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.95

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(317031008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 38 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 38)

				if (38 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 38)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play317031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 317031009
		arg_37_1.duration_ = 22.03

		local var_37_0 = {
			zh = 14,
			ja = 22.033
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
				arg_37_0:Play317031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.bgs_.K06a == nil then
				local var_40_0 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K06a")
				var_40_0.name = "K06a"
				var_40_0.transform.parent = arg_37_1.stage_.transform
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_.K06a = var_40_0
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				local var_40_1 = arg_37_1.bgs_.K06a

				arg_37_1.bgs_.K06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_2 = var_40_1:GetComponent("SpriteRenderer")

				if var_40_2 and var_40_2.sprite then
					local var_40_3 = 2 * (var_40_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_1.transform.localScale = Vector3.New(var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "K06a" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_4 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_5 = 2

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_5 then
				local var_40_6 = Color.New(0, 0, 0)

				var_40_6.a = Mathf.Lerp(0, 1, (arg_37_1.time_ - var_40_4) / var_40_5)
				arg_37_1.mask_.color = var_40_6
			end

			if arg_37_1.time_ >= var_40_4 + var_40_5 and arg_37_1.time_ < var_40_4 + var_40_5 + arg_40_0 then
				local var_40_7 = Color.New(0, 0, 0)

				var_40_7.a = 1
				arg_37_1.mask_.color = var_40_7
			end

			local var_40_8 = 2

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_9 = 2

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 then
				local var_40_10 = Color.New(0, 0, 0)

				var_40_10.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_8) / var_40_9)
				arg_37_1.mask_.color = var_40_10
			end

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 then
				local var_40_11 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_11.a = 0
				arg_37_1.mask_.color = var_40_11
			end

			local var_40_12 = 2

			arg_37_1.isInRecall_ = false

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.screenFilterGo_:SetActive(true)

				arg_37_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_40_2, iter_40_3 in pairs(arg_37_1.actors_) do
					for iter_40_4, iter_40_5 in ipairs((iter_40_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_40_5.color = iter_40_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_40_13 = 0.0166666666666667

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_13 then
				arg_37_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_37_1.time_ - var_40_12) / var_40_13)
			end

			if arg_37_1.time_ >= var_40_12 + var_40_13 and arg_37_1.time_ < var_40_12 + var_40_13 + arg_40_0 then
				arg_37_1.screenFilterEffect_.weight = 1
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_14 = 4
			local var_40_15 = 1.125

			if 4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_16 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_16:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[543].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_17 = arg_37_1:GetWordFromCfg(317031009)
				local var_40_18 = arg_37_1:FormatText(var_40_17.content)

				arg_37_1.text_.text = var_40_18

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 45 <= 0 and var_40_15 or var_40_15 * (utf8.len(var_40_18) / 45)

				if (45 <= 0 and var_40_15 or var_40_15 * (utf8.len(var_40_18) / 45)) > 0 and var_40_15 < var_40_20 then
					arg_37_1.talkMaxDuration = var_40_20
					var_40_14 = var_40_14 + 0.3

					if var_40_20 + var_40_14 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_14
					end
				end

				arg_37_1.text_.text = var_40_18
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031009", "story_v_out_317031.awb") ~= 0 then
					local var_40_21 = manager.audio:GetVoiceLength("story_v_out_317031", "317031009", "story_v_out_317031.awb") / 1000

					if var_40_21 + var_40_14 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_21 + var_40_14
					end

					if var_40_17.prefab_name ~= "" and arg_37_1.actors_[var_40_17.prefab_name] ~= nil then
						local var_40_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_17.prefab_name].transform, "story_v_out_317031", "317031009", "story_v_out_317031.awb")

						arg_37_1:RecordAudio("317031009", var_40_22)
						arg_37_1:RecordAudio("317031009", var_40_22)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_317031", "317031009", "story_v_out_317031.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_317031", "317031009", "story_v_out_317031.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_23 = var_40_14 + 0.3
			local var_40_24 = math.max(var_40_15, arg_37_1.talkMaxDuration)

			if var_40_14 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_23 + var_40_24 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_23) / var_40_24

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_23 + var_40_24 and arg_37_1.time_ < var_40_23 + var_40_24 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play317031010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 317031010
		arg_43_1.duration_ = 13.1

		local var_43_0 = {
			zh = 8.133,
			ja = 13.1
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
				arg_43_0:Play317031011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.7

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[543].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_1 = arg_43_1:GetWordFromCfg(317031010)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 28 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 28)

				if (28 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 28)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031010", "story_v_out_317031.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031010", "story_v_out_317031.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_317031", "317031010", "story_v_out_317031.awb")

						arg_43_1:RecordAudio("317031010", var_46_6)
						arg_43_1:RecordAudio("317031010", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_317031", "317031010", "story_v_out_317031.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_317031", "317031010", "story_v_out_317031.awb")
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
	Play317031011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 317031011
		arg_47_1.duration_ = 10.7

		local var_47_0 = {
			zh = 7.166,
			ja = 10.7
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
				arg_47_0:Play317031012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.625

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[543].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:GetWordFromCfg(317031011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 25 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 25)

				if (25 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 25)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031011", "story_v_out_317031.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031011", "story_v_out_317031.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_317031", "317031011", "story_v_out_317031.awb")

						arg_47_1:RecordAudio("317031011", var_50_6)
						arg_47_1:RecordAudio("317031011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_317031", "317031011", "story_v_out_317031.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_317031", "317031011", "story_v_out_317031.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play317031012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 317031012
		arg_51_1.duration_ = 9.8

		local var_51_0 = {
			zh = 3.966,
			ja = 9.8
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play317031013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.375

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[544].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_1 = arg_51_1:GetWordFromCfg(317031012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 15 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 15)

				if (15 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 15)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031012", "story_v_out_317031.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031012", "story_v_out_317031.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_317031", "317031012", "story_v_out_317031.awb")

						arg_51_1:RecordAudio("317031012", var_54_6)
						arg_51_1:RecordAudio("317031012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_317031", "317031012", "story_v_out_317031.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_317031", "317031012", "story_v_out_317031.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play317031013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 317031013
		arg_55_1.duration_ = 17.03

		local var_55_0 = {
			zh = 17.033,
			ja = 11.7
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
				arg_55_0:Play317031014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 1.575

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[544].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:GetWordFromCfg(317031013)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 63 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 63)

				if (63 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 63)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031013", "story_v_out_317031.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031013", "story_v_out_317031.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_317031", "317031013", "story_v_out_317031.awb")

						arg_55_1:RecordAudio("317031013", var_58_6)
						arg_55_1:RecordAudio("317031013", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_317031", "317031013", "story_v_out_317031.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_317031", "317031013", "story_v_out_317031.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play317031014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 317031014
		arg_59_1.duration_ = 11.77

		local var_59_0 = {
			zh = 11.766,
			ja = 8.033
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
				arg_59_0:Play317031015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 1.275

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[544].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_1 = arg_59_1:GetWordFromCfg(317031014)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 51 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 51)

				if (51 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 51)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031014", "story_v_out_317031.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031014", "story_v_out_317031.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_317031", "317031014", "story_v_out_317031.awb")

						arg_59_1:RecordAudio("317031014", var_62_6)
						arg_59_1:RecordAudio("317031014", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_317031", "317031014", "story_v_out_317031.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_317031", "317031014", "story_v_out_317031.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play317031015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 317031015
		arg_63_1.duration_ = 13.87

		local var_63_0 = {
			zh = 10.3,
			ja = 13.866
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
				arg_63_0:Play317031016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.05

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[545].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:GetWordFromCfg(317031015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 42 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 42)

				if (42 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 42)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031015", "story_v_out_317031.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031015", "story_v_out_317031.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_317031", "317031015", "story_v_out_317031.awb")

						arg_63_1:RecordAudio("317031015", var_66_6)
						arg_63_1:RecordAudio("317031015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_317031", "317031015", "story_v_out_317031.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_317031", "317031015", "story_v_out_317031.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play317031016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 317031016
		arg_67_1.duration_ = 5.67

		local var_67_0 = {
			zh = 4.566,
			ja = 5.666
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
				arg_67_0:Play317031017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.45

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[545].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:GetWordFromCfg(317031016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 18 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 18)

				if (18 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 18)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031016", "story_v_out_317031.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031016", "story_v_out_317031.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_317031", "317031016", "story_v_out_317031.awb")

						arg_67_1:RecordAudio("317031016", var_70_6)
						arg_67_1:RecordAudio("317031016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_317031", "317031016", "story_v_out_317031.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_317031", "317031016", "story_v_out_317031.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play317031017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 317031017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play317031018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.675

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(317031017).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 27 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 27)

				if (27 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 27)) > 0 and var_74_0 < var_74_3 then
					arg_71_1.talkMaxDuration = var_74_3

					if var_74_3 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_3 + 0
					end
				end

				arg_71_1.text_.text = var_74_1
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_4 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_4

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play317031018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 317031018
		arg_75_1.duration_ = 11.4

		local var_75_0 = {
			zh = 8,
			ja = 11.4
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
				arg_75_0:Play317031019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if arg_75_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_78_0 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_75_1.stage_.transform)

				var_78_0.name = "1015ui_story"
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["1015ui_story"] = var_78_0

				local var_78_1 = var_78_0:GetComponentInChildren(typeof(CharacterEffect))

				var_78_1.enabled = true

				local var_78_2 = GameObjectTools.GetOrAddComponent(var_78_0, typeof(DynamicBoneHelper))

				if var_78_2 then
					var_78_2:EnableDynamicBone(false)
				end

				arg_75_1:ShowWeapon(var_78_1.transform, false)

				arg_75_1.var_["1015ui_story" .. "Animator"] = var_78_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_75_1.var_["1015ui_story" .. "Animator"].applyRootMotion = true
				arg_75_1.var_["1015ui_story" .. "LipSync"] = var_78_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_78_3 = arg_75_1.actors_["1015ui_story"].transform

			if 4 < arg_75_1.time_ and arg_75_1.time_ <= 4 + arg_78_0 then
				arg_75_1.var_.moveOldPos1015ui_story = var_78_3.localPosition
			end

			local var_78_4 = 0.001

			if 4 <= arg_75_1.time_ and arg_75_1.time_ < 4 + var_78_4 then
				var_78_3.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_75_1.time_ - 4) / var_78_4)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			if arg_75_1.time_ >= 4 + var_78_4 and arg_75_1.time_ < 4 + var_78_4 + arg_78_0 then
				var_78_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= 2 + arg_78_0 then
				local var_78_5 = arg_75_1.bgs_.K06a

				arg_75_1.bgs_.K06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_78_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_78_6 = var_78_5:GetComponent("SpriteRenderer")

				if var_78_6 and var_78_6.sprite then
					local var_78_7 = 2 * (var_78_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_78_5.transform.localScale = Vector3.New(var_78_7 / var_78_6.sprite.bounds.size.y < var_78_7 * manager.ui.mainCameraCom_.aspect / var_78_6.sprite.bounds.size.x and var_78_7 * manager.ui.mainCameraCom_.aspect / var_78_6.sprite.bounds.size.x or var_78_7 / var_78_6.sprite.bounds.size.y, var_78_7 / var_78_6.sprite.bounds.size.y < var_78_7 * manager.ui.mainCameraCom_.aspect / var_78_6.sprite.bounds.size.x and var_78_7 * manager.ui.mainCameraCom_.aspect / var_78_6.sprite.bounds.size.x or var_78_7 / var_78_6.sprite.bounds.size.y, 0)
				end

				for iter_78_0, iter_78_1 in pairs(arg_75_1.bgs_) do
					if iter_78_0 ~= "K06a" then
						iter_78_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_78_8 = 0

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_9 = 2

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_9 then
				local var_78_10 = Color.New(0, 0, 0)

				var_78_10.a = Mathf.Lerp(0, 1, (arg_75_1.time_ - var_78_8) / var_78_9)
				arg_75_1.mask_.color = var_78_10
			end

			if arg_75_1.time_ >= var_78_8 + var_78_9 and arg_75_1.time_ < var_78_8 + var_78_9 + arg_78_0 then
				local var_78_11 = Color.New(0, 0, 0)

				var_78_11.a = 1
				arg_75_1.mask_.color = var_78_11
			end

			local var_78_12 = 2

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_12 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_13 = 2

			if var_78_12 <= arg_75_1.time_ and arg_75_1.time_ < var_78_12 + var_78_13 then
				local var_78_14 = Color.New(0, 0, 0)

				var_78_14.a = Mathf.Lerp(1, 0, (arg_75_1.time_ - var_78_12) / var_78_13)
				arg_75_1.mask_.color = var_78_14
			end

			if arg_75_1.time_ >= var_78_12 + var_78_13 and arg_75_1.time_ < var_78_12 + var_78_13 + arg_78_0 then
				local var_78_15 = Color.New(0, 0, 0)

				arg_75_1.mask_.enabled = false
				var_78_15.a = 0
				arg_75_1.mask_.color = var_78_15
			end

			local var_78_16 = 2

			arg_75_1.isInRecall_ = false

			if var_78_16 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 then
				arg_75_1.screenFilterGo_:SetActive(false)

				for iter_78_2, iter_78_3 in pairs(arg_75_1.actors_) do
					for iter_78_4, iter_78_5 in ipairs((iter_78_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_78_5.color = iter_78_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_78_17 = 0.0166666666666667

			if var_78_16 <= arg_75_1.time_ and arg_75_1.time_ < var_78_16 + var_78_17 then
				arg_75_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_75_1.time_ - var_78_16) / var_78_17)
			end

			if arg_75_1.time_ >= var_78_16 + var_78_17 and arg_75_1.time_ < var_78_16 + var_78_17 + arg_78_0 then
				arg_75_1.screenFilterEffect_.weight = 0
			end

			local var_78_18 = arg_75_1.actors_["1015ui_story"]

			if 4 < arg_75_1.time_ and arg_75_1.time_ <= 4 + arg_78_0 and not isNil(var_78_18) and arg_75_1.var_.characterEffect1015ui_story == nil then
				arg_75_1.var_.characterEffect1015ui_story = var_78_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_19 = 0.2

			if 4 <= arg_75_1.time_ and arg_75_1.time_ < 4 + var_78_19 and not isNil(var_78_18) then
				if arg_75_1.var_.characterEffect1015ui_story and not isNil(var_78_18) then
					arg_75_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 4 + var_78_19 and arg_75_1.time_ < 4 + var_78_19 + arg_78_0 and not isNil(var_78_18) and arg_75_1.var_.characterEffect1015ui_story then
				arg_75_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 4 < arg_75_1.time_ and arg_75_1.time_ <= 4 + arg_78_0 then
				arg_75_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 4 < arg_75_1.time_ and arg_75_1.time_ <= 4 + arg_78_0 then
				arg_75_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_21 = 4
			local var_78_22 = 0.375

			if 4 < arg_75_1.time_ and arg_75_1.time_ <= var_78_21 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_23 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_23:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_75_1.dialogCg_.alpha = arg_79_0
				end))
				var_78_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_24 = arg_75_1:GetWordFromCfg(317031018)
				local var_78_25 = arg_75_1:FormatText(var_78_24.content)

				arg_75_1.text_.text = var_78_25

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_27 = 15 <= 0 and var_78_22 or var_78_22 * (utf8.len(var_78_25) / 15)

				if (15 <= 0 and var_78_22 or var_78_22 * (utf8.len(var_78_25) / 15)) > 0 and var_78_22 < var_78_27 then
					arg_75_1.talkMaxDuration = var_78_27
					var_78_21 = var_78_21 + 0.3

					if var_78_27 + var_78_21 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_27 + var_78_21
					end
				end

				arg_75_1.text_.text = var_78_25
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031018", "story_v_out_317031.awb") ~= 0 then
					local var_78_28 = manager.audio:GetVoiceLength("story_v_out_317031", "317031018", "story_v_out_317031.awb") / 1000

					if var_78_28 + var_78_21 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_28 + var_78_21
					end

					if var_78_24.prefab_name ~= "" and arg_75_1.actors_[var_78_24.prefab_name] ~= nil then
						local var_78_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_24.prefab_name].transform, "story_v_out_317031", "317031018", "story_v_out_317031.awb")

						arg_75_1:RecordAudio("317031018", var_78_29)
						arg_75_1:RecordAudio("317031018", var_78_29)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_317031", "317031018", "story_v_out_317031.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_317031", "317031018", "story_v_out_317031.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_30 = var_78_21 + 0.3
			local var_78_31 = math.max(var_78_22, arg_75_1.talkMaxDuration)

			if var_78_21 + 0.3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_30 + var_78_31 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_30) / var_78_31

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_30 + var_78_31 and arg_75_1.time_ < var_78_30 + var_78_31 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play317031019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 317031019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play317031020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_84_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_81_1.bgmTxt_.text ~= var_84_2 and arg_81_1.bgmTxt_.text ~= "" then
						if arg_81_1.bgmTxt2_.text ~= "" then
							arg_81_1.bgmTxt_.text = arg_81_1.bgmTxt2_.text
						end

						arg_81_1.bgmTxt2_.text = var_84_2

						arg_81_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_81_1.bgmTxt_.text = var_84_2
						arg_81_1.bgmTxt2_.text = var_84_2
					end

					if arg_81_1.bgmTimer then
						arg_81_1.bgmTimer:Stop()

						arg_81_1.bgmTimer = nil
					end

					if arg_81_1.settingData.show_music_name == 1 then
						arg_81_1.musicController:SetSelectedState("show")
						arg_81_1.musicAnimator_:Play("open", 0, 0)

						if arg_81_1.settingData.music_time ~= 0 then
							arg_81_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_81_1.settingData.music_time), function()
								if arg_81_1 == nil or isNil(arg_81_1.bgmTxt_) then
									return
								end

								arg_81_1.musicController:SetSelectedState("hide")
								arg_81_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_84_3 = arg_81_1.actors_["1015ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_3) and arg_81_1.var_.characterEffect1015ui_story == nil then
				arg_81_1.var_.characterEffect1015ui_story = var_84_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_4 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 and not isNil(var_84_3) then
				if arg_81_1.var_.characterEffect1015ui_story and not isNil(var_84_3) then
					arg_81_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_4)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 and not isNil(var_84_3) and arg_81_1.var_.characterEffect1015ui_story then
				arg_81_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_5 = 0
			local var_84_6 = 0.6

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_7 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(317031019).content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 24 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_7) / 24)

				if (24 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_7) / 24)) > 0 and var_84_6 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_5
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_6, arg_81_1.talkMaxDuration)

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_5) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_5 + var_84_10 and arg_81_1.time_ < var_84_5 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play317031020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 317031020
		arg_86_1.duration_ = 9.7

		local var_86_0 = {
			zh = 7.933,
			ja = 9.7
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
				arg_86_0:Play317031021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if arg_86_1.bgs_.K05f == nil then
				local var_89_0 = Object.Instantiate(arg_86_1.paintGo_)

				var_89_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K05f")
				var_89_0.name = "K05f"
				var_89_0.transform.parent = arg_86_1.stage_.transform
				var_89_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.bgs_.K05f = var_89_0
			end

			if 2 < arg_86_1.time_ and arg_86_1.time_ <= 2 + arg_89_0 then
				local var_89_1 = arg_86_1.bgs_.K05f

				arg_86_1.bgs_.K05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_89_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_89_2 = var_89_1:GetComponent("SpriteRenderer")

				if var_89_2 and var_89_2.sprite then
					local var_89_3 = 2 * (var_89_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_89_1.transform.localScale = Vector3.New(var_89_3 / var_89_2.sprite.bounds.size.y < var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x and var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x or var_89_3 / var_89_2.sprite.bounds.size.y, var_89_3 / var_89_2.sprite.bounds.size.y < var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x and var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x or var_89_3 / var_89_2.sprite.bounds.size.y, 0)
				end

				for iter_89_0, iter_89_1 in pairs(arg_86_1.bgs_) do
					if iter_89_0 ~= "K05f" then
						iter_89_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_89_4 = 0

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_5 = 2

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_5 then
				local var_89_6 = Color.New(0, 0, 0)

				var_89_6.a = Mathf.Lerp(0, 1, (arg_86_1.time_ - var_89_4) / var_89_5)
				arg_86_1.mask_.color = var_89_6
			end

			if arg_86_1.time_ >= var_89_4 + var_89_5 and arg_86_1.time_ < var_89_4 + var_89_5 + arg_89_0 then
				local var_89_7 = Color.New(0, 0, 0)

				var_89_7.a = 1
				arg_86_1.mask_.color = var_89_7
			end

			local var_89_8 = 2

			if 2 < arg_86_1.time_ and arg_86_1.time_ <= var_89_8 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_9 = 2

			if var_89_8 <= arg_86_1.time_ and arg_86_1.time_ < var_89_8 + var_89_9 then
				local var_89_10 = Color.New(0, 0, 0)

				var_89_10.a = Mathf.Lerp(1, 0, (arg_86_1.time_ - var_89_8) / var_89_9)
				arg_86_1.mask_.color = var_89_10
			end

			if arg_86_1.time_ >= var_89_8 + var_89_9 and arg_86_1.time_ < var_89_8 + var_89_9 + arg_89_0 then
				local var_89_11 = Color.New(0, 0, 0)

				arg_86_1.mask_.enabled = false
				var_89_11.a = 0
				arg_86_1.mask_.color = var_89_11
			end

			local var_89_12 = "2078ui_story"

			if arg_86_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_89_13 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_86_1.stage_.transform)

				var_89_13.name = var_89_12
				var_89_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_[var_89_12] = var_89_13

				local var_89_14 = var_89_13:GetComponentInChildren(typeof(CharacterEffect))

				var_89_14.enabled = true

				local var_89_15 = GameObjectTools.GetOrAddComponent(var_89_13, typeof(DynamicBoneHelper))

				if var_89_15 then
					var_89_15:EnableDynamicBone(false)
				end

				arg_86_1:ShowWeapon(var_89_14.transform, false)

				arg_86_1.var_[var_89_12 .. "Animator"] = var_89_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_86_1.var_[var_89_12 .. "Animator"].applyRootMotion = true
				arg_86_1.var_[var_89_12 .. "LipSync"] = var_89_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_89_16 = arg_86_1.actors_["2078ui_story"].transform

			if 4 < arg_86_1.time_ and arg_86_1.time_ <= 4 + arg_89_0 then
				arg_86_1.var_.moveOldPos2078ui_story = var_89_16.localPosition
			end

			local var_89_17 = 0.001

			if 4 <= arg_86_1.time_ and arg_86_1.time_ < 4 + var_89_17 then
				var_89_16.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_86_1.time_ - 4) / var_89_17)
				var_89_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_16.position).x, (manager.ui.mainCamera.transform.position - var_89_16.position).y, (manager.ui.mainCamera.transform.position - var_89_16.position).z)
				var_89_16.localEulerAngles.z = 0
				var_89_16.localEulerAngles.x = 0
				var_89_16.localEulerAngles = var_89_16.localEulerAngles
			end

			if arg_86_1.time_ >= 4 + var_89_17 and arg_86_1.time_ < 4 + var_89_17 + arg_89_0 then
				var_89_16.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				var_89_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_16.position).x, (manager.ui.mainCamera.transform.position - var_89_16.position).y, (manager.ui.mainCamera.transform.position - var_89_16.position).z)
				var_89_16.localEulerAngles.z = 0
				var_89_16.localEulerAngles.x = 0
				var_89_16.localEulerAngles = var_89_16.localEulerAngles
			end

			local var_89_18 = arg_86_1.actors_["2078ui_story"]

			if 4 < arg_86_1.time_ and arg_86_1.time_ <= 4 + arg_89_0 and not isNil(var_89_18) and arg_86_1.var_.characterEffect2078ui_story == nil then
				arg_86_1.var_.characterEffect2078ui_story = var_89_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_19 = 0.200000002980232

			if 4 <= arg_86_1.time_ and arg_86_1.time_ < 4 + var_89_19 and not isNil(var_89_18) then
				if arg_86_1.var_.characterEffect2078ui_story and not isNil(var_89_18) then
					arg_86_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 4 + var_89_19 and arg_86_1.time_ < 4 + var_89_19 + arg_89_0 and not isNil(var_89_18) and arg_86_1.var_.characterEffect2078ui_story then
				arg_86_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 4 < arg_86_1.time_ and arg_86_1.time_ <= 4 + arg_89_0 then
				arg_86_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_89_21 = "2079ui_story"

			if arg_86_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_89_22 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_86_1.stage_.transform)

				var_89_22.name = var_89_21
				var_89_22.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_[var_89_21] = var_89_22

				local var_89_23 = var_89_22:GetComponentInChildren(typeof(CharacterEffect))

				var_89_23.enabled = true

				local var_89_24 = GameObjectTools.GetOrAddComponent(var_89_22, typeof(DynamicBoneHelper))

				if var_89_24 then
					var_89_24:EnableDynamicBone(false)
				end

				arg_86_1:ShowWeapon(var_89_23.transform, false)

				arg_86_1.var_[var_89_21 .. "Animator"] = var_89_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_86_1.var_[var_89_21 .. "Animator"].applyRootMotion = true
				arg_86_1.var_[var_89_21 .. "LipSync"] = var_89_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_89_25 = arg_86_1.actors_["2079ui_story"].transform

			if 4 < arg_86_1.time_ and arg_86_1.time_ <= 4 + arg_89_0 then
				arg_86_1.var_.moveOldPos2079ui_story = var_89_25.localPosition
			end

			local var_89_26 = 0.001

			if 4 <= arg_86_1.time_ and arg_86_1.time_ < 4 + var_89_26 then
				var_89_25.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_86_1.time_ - 4) / var_89_26)
				var_89_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_25.position).x, (manager.ui.mainCamera.transform.position - var_89_25.position).y, (manager.ui.mainCamera.transform.position - var_89_25.position).z)
				var_89_25.localEulerAngles.z = 0
				var_89_25.localEulerAngles.x = 0
				var_89_25.localEulerAngles = var_89_25.localEulerAngles
			end

			if arg_86_1.time_ >= 4 + var_89_26 and arg_86_1.time_ < 4 + var_89_26 + arg_89_0 then
				var_89_25.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_89_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_25.position).x, (manager.ui.mainCamera.transform.position - var_89_25.position).y, (manager.ui.mainCamera.transform.position - var_89_25.position).z)
				var_89_25.localEulerAngles.z = 0
				var_89_25.localEulerAngles.x = 0
				var_89_25.localEulerAngles = var_89_25.localEulerAngles
			end

			local var_89_27 = arg_86_1.actors_["2079ui_story"]

			if 4 < arg_86_1.time_ and arg_86_1.time_ <= 4 + arg_89_0 and not isNil(var_89_27) and arg_86_1.var_.characterEffect2079ui_story == nil then
				arg_86_1.var_.characterEffect2079ui_story = var_89_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_28 = 0.200000002980232

			if 4 <= arg_86_1.time_ and arg_86_1.time_ < 4 + var_89_28 and not isNil(var_89_27) then
				if arg_86_1.var_.characterEffect2079ui_story and not isNil(var_89_27) then
					arg_86_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_86_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 4) / var_89_28)
				end
			end

			if arg_86_1.time_ >= 4 + var_89_28 and arg_86_1.time_ < 4 + var_89_28 + arg_89_0 and not isNil(var_89_27) and arg_86_1.var_.characterEffect2079ui_story then
				arg_86_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_86_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			if 4 < arg_86_1.time_ and arg_86_1.time_ <= 4 + arg_89_0 then
				arg_86_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_89_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_86_1.bgmTxt_.text ~= var_89_31 and arg_86_1.bgmTxt_.text ~= "" then
						if arg_86_1.bgmTxt2_.text ~= "" then
							arg_86_1.bgmTxt_.text = arg_86_1.bgmTxt2_.text
						end

						arg_86_1.bgmTxt2_.text = var_89_31

						arg_86_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_86_1.bgmTxt_.text = var_89_31
						arg_86_1.bgmTxt2_.text = var_89_31
					end

					if arg_86_1.bgmTimer then
						arg_86_1.bgmTimer:Stop()

						arg_86_1.bgmTimer = nil
					end

					if arg_86_1.settingData.show_music_name == 1 then
						arg_86_1.musicController:SetSelectedState("show")
						arg_86_1.musicAnimator_:Play("open", 0, 0)

						if arg_86_1.settingData.music_time ~= 0 then
							arg_86_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_86_1.settingData.music_time), function()
								if arg_86_1 == nil or isNil(arg_86_1.bgmTxt_) then
									return
								end

								arg_86_1.musicController:SetSelectedState("hide")
								arg_86_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.56666666666667 < arg_86_1.time_ and arg_86_1.time_ <= 1.56666666666667 + arg_89_0 then
				arg_86_1:AudioAction("play", "music", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu.awb")

				local var_89_34 = manager.audio:GetAudioName("bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu")

				if "" ~= "" then
					if arg_86_1.bgmTxt_.text ~= var_89_34 and arg_86_1.bgmTxt_.text ~= "" then
						if arg_86_1.bgmTxt2_.text ~= "" then
							arg_86_1.bgmTxt_.text = arg_86_1.bgmTxt2_.text
						end

						arg_86_1.bgmTxt2_.text = var_89_34

						arg_86_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_86_1.bgmTxt_.text = var_89_34
						arg_86_1.bgmTxt2_.text = var_89_34
					end

					if arg_86_1.bgmTimer then
						arg_86_1.bgmTimer:Stop()

						arg_86_1.bgmTimer = nil
					end

					if arg_86_1.settingData.show_music_name == 1 then
						arg_86_1.musicController:SetSelectedState("show")
						arg_86_1.musicAnimator_:Play("open", 0, 0)

						if arg_86_1.settingData.music_time ~= 0 then
							arg_86_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_86_1.settingData.music_time), function()
								if arg_86_1 == nil or isNil(arg_86_1.bgmTxt_) then
									return
								end

								arg_86_1.musicController:SetSelectedState("hide")
								arg_86_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_89_35 = arg_86_1.actors_["1015ui_story"].transform

			if 2 < arg_86_1.time_ and arg_86_1.time_ <= 2 + arg_89_0 then
				arg_86_1.var_.moveOldPos1015ui_story = var_89_35.localPosition
			end

			local var_89_36 = 0.001

			if 2 <= arg_86_1.time_ and arg_86_1.time_ < 2 + var_89_36 then
				var_89_35.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 2) / var_89_36)
				var_89_35.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_35.position).x, (manager.ui.mainCamera.transform.position - var_89_35.position).y, (manager.ui.mainCamera.transform.position - var_89_35.position).z)
				var_89_35.localEulerAngles.z = 0
				var_89_35.localEulerAngles.x = 0
				var_89_35.localEulerAngles = var_89_35.localEulerAngles
			end

			if arg_86_1.time_ >= 2 + var_89_36 and arg_86_1.time_ < 2 + var_89_36 + arg_89_0 then
				var_89_35.localPosition = Vector3.New(0, 100, 0)
				var_89_35.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_35.position).x, (manager.ui.mainCamera.transform.position - var_89_35.position).y, (manager.ui.mainCamera.transform.position - var_89_35.position).z)
				var_89_35.localEulerAngles.z = 0
				var_89_35.localEulerAngles.x = 0
				var_89_35.localEulerAngles = var_89_35.localEulerAngles
			end

			if arg_86_1.frameCnt_ <= 1 then
				arg_86_1.dialog_:SetActive(false)
			end

			local var_89_37 = 4
			local var_89_38 = 0.4

			if 4 < arg_86_1.time_ and arg_86_1.time_ <= var_89_37 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				arg_86_1.dialog_:SetActive(true)

				arg_86_1.dialogCg_.alpha = 0

				local var_89_39 = LeanTween.value(arg_86_1.dialog_, 0, 1, 0.3)

				var_89_39:setOnUpdate(LuaHelper.FloatAction(function(arg_92_0)
					arg_86_1.dialogCg_.alpha = arg_92_0
				end))
				var_89_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_86_1.dialog_)
					var_89_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_86_1.duration_ = arg_86_1.duration_ + 0.3

				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[546].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_40 = arg_86_1:GetWordFromCfg(317031020)
				local var_89_41 = arg_86_1:FormatText(var_89_40.content)

				arg_86_1.text_.text = var_89_41

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_43 = 16 <= 0 and var_89_38 or var_89_38 * (utf8.len(var_89_41) / 16)

				if (16 <= 0 and var_89_38 or var_89_38 * (utf8.len(var_89_41) / 16)) > 0 and var_89_38 < var_89_43 then
					arg_86_1.talkMaxDuration = var_89_43
					var_89_37 = var_89_37 + 0.3

					if var_89_43 + var_89_37 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_43 + var_89_37
					end
				end

				arg_86_1.text_.text = var_89_41
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031020", "story_v_out_317031.awb") ~= 0 then
					local var_89_44 = manager.audio:GetVoiceLength("story_v_out_317031", "317031020", "story_v_out_317031.awb") / 1000

					if var_89_44 + var_89_37 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_44 + var_89_37
					end

					if var_89_40.prefab_name ~= "" and arg_86_1.actors_[var_89_40.prefab_name] ~= nil then
						local var_89_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_40.prefab_name].transform, "story_v_out_317031", "317031020", "story_v_out_317031.awb")

						arg_86_1:RecordAudio("317031020", var_89_45)
						arg_86_1:RecordAudio("317031020", var_89_45)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_317031", "317031020", "story_v_out_317031.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_317031", "317031020", "story_v_out_317031.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_46 = var_89_37 + 0.3
			local var_89_47 = math.max(var_89_38, arg_86_1.talkMaxDuration)

			if var_89_37 + 0.3 <= arg_86_1.time_ and arg_86_1.time_ < var_89_46 + var_89_47 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_46) / var_89_47

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_46 + var_89_47 and arg_86_1.time_ < var_89_46 + var_89_47 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play317031021 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 317031021
		arg_94_1.duration_ = 4.23

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play317031022(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.575

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[546].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:GetWordFromCfg(317031021)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 23 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 23)

				if (23 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 23)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031021", "story_v_out_317031.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031021", "story_v_out_317031.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_317031", "317031021", "story_v_out_317031.awb")

						arg_94_1:RecordAudio("317031021", var_97_6)
						arg_94_1:RecordAudio("317031021", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_317031", "317031021", "story_v_out_317031.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_317031", "317031021", "story_v_out_317031.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play317031022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 317031022
		arg_98_1.duration_ = 3.6

		local var_98_0 = {
			zh = 2.466,
			ja = 3.6
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
				arg_98_0:Play317031023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["2078ui_story"]) and arg_98_1.var_.characterEffect2078ui_story == nil then
				arg_98_1.var_.characterEffect2078ui_story = arg_98_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["2078ui_story"]) then
				if arg_98_1.var_.characterEffect2078ui_story and not isNil(arg_98_1.actors_["2078ui_story"]) then
					arg_98_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_98_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_0)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["2078ui_story"]) and arg_98_1.var_.characterEffect2078ui_story then
				arg_98_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_98_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_101_1 = arg_98_1.actors_["2079ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect2079ui_story == nil then
				arg_98_1.var_.characterEffect2079ui_story = var_101_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_2 and not isNil(var_101_1) then
				if arg_98_1.var_.characterEffect2079ui_story and not isNil(var_101_1) then
					arg_98_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_2 and arg_98_1.time_ < 0 + var_101_2 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect2079ui_story then
				arg_98_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_101_4 = 0
			local var_101_5 = 0.3

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_6 = arg_98_1:GetWordFromCfg(317031022)
				local var_101_7 = arg_98_1:FormatText(var_101_6.content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 12 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 12)

				if (12 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 12)) > 0 and var_101_5 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031022", "story_v_out_317031.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031022", "story_v_out_317031.awb") / 1000

					if var_101_10 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_4
					end

					if var_101_6.prefab_name ~= "" and arg_98_1.actors_[var_101_6.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_6.prefab_name].transform, "story_v_out_317031", "317031022", "story_v_out_317031.awb")

						arg_98_1:RecordAudio("317031022", var_101_11)
						arg_98_1:RecordAudio("317031022", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_317031", "317031022", "story_v_out_317031.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_317031", "317031022", "story_v_out_317031.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_12 and arg_98_1.time_ < var_101_4 + var_101_12 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play317031023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 317031023
		arg_102_1.duration_ = 11.57

		local var_102_0 = {
			zh = 6.9,
			ja = 11.566
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
				arg_102_0:Play317031024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["2078ui_story"]) and arg_102_1.var_.characterEffect2078ui_story == nil then
				arg_102_1.var_.characterEffect2078ui_story = arg_102_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["2078ui_story"]) then
				if arg_102_1.var_.characterEffect2078ui_story and not isNil(arg_102_1.actors_["2078ui_story"]) then
					arg_102_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["2078ui_story"]) and arg_102_1.var_.characterEffect2078ui_story then
				arg_102_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_105_2 = arg_102_1.actors_["2079ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect2079ui_story == nil then
				arg_102_1.var_.characterEffect2079ui_story = var_105_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_3 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 and not isNil(var_105_2) then
				if arg_102_1.var_.characterEffect2079ui_story and not isNil(var_105_2) then
					arg_102_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_102_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_3)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect2079ui_story then
				arg_102_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_102_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_105_4 = 0
			local var_105_5 = 0.725

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[546].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(317031023)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 29 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 29)

				if (29 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 29)) > 0 and var_105_5 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031023", "story_v_out_317031.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031023", "story_v_out_317031.awb") / 1000

					if var_105_10 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_4
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_out_317031", "317031023", "story_v_out_317031.awb")

						arg_102_1:RecordAudio("317031023", var_105_11)
						arg_102_1:RecordAudio("317031023", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_317031", "317031023", "story_v_out_317031.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_317031", "317031023", "story_v_out_317031.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_12 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_12 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_12

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_12 and arg_102_1.time_ < var_105_4 + var_105_12 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play317031024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 317031024
		arg_106_1.duration_ = 7.23

		local var_106_0 = {
			zh = 3.1,
			ja = 7.233
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
				arg_106_0:Play317031025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["2078ui_story"]) and arg_106_1.var_.characterEffect2078ui_story == nil then
				arg_106_1.var_.characterEffect2078ui_story = arg_106_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["2078ui_story"]) then
				if arg_106_1.var_.characterEffect2078ui_story and not isNil(arg_106_1.actors_["2078ui_story"]) then
					arg_106_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_106_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_0)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["2078ui_story"]) and arg_106_1.var_.characterEffect2078ui_story then
				arg_106_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_106_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_109_1 = arg_106_1.actors_["2079ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect2079ui_story == nil then
				arg_106_1.var_.characterEffect2079ui_story = var_109_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_2 and not isNil(var_109_1) then
				if arg_106_1.var_.characterEffect2079ui_story and not isNil(var_109_1) then
					arg_106_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_2 and arg_106_1.time_ < 0 + var_109_2 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect2079ui_story then
				arg_106_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_109_4 = 0
			local var_109_5 = 0.4

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_6 = arg_106_1:GetWordFromCfg(317031024)
				local var_109_7 = arg_106_1:FormatText(var_109_6.content)

				arg_106_1.text_.text = var_109_7

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 16 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 16)

				if (16 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 16)) > 0 and var_109_5 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_7
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031024", "story_v_out_317031.awb") ~= 0 then
					local var_109_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031024", "story_v_out_317031.awb") / 1000

					if var_109_10 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_4
					end

					if var_109_6.prefab_name ~= "" and arg_106_1.actors_[var_109_6.prefab_name] ~= nil then
						local var_109_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_6.prefab_name].transform, "story_v_out_317031", "317031024", "story_v_out_317031.awb")

						arg_106_1:RecordAudio("317031024", var_109_11)
						arg_106_1:RecordAudio("317031024", var_109_11)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_317031", "317031024", "story_v_out_317031.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_317031", "317031024", "story_v_out_317031.awb")
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

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play317031025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 317031025
		arg_110_1.duration_ = 1.9

		local var_110_0 = {
			zh = 1.5,
			ja = 1.9
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
				arg_110_0:Play317031026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["2078ui_story"]) and arg_110_1.var_.characterEffect2078ui_story == nil then
				arg_110_1.var_.characterEffect2078ui_story = arg_110_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["2078ui_story"]) then
				if arg_110_1.var_.characterEffect2078ui_story and not isNil(arg_110_1.actors_["2078ui_story"]) then
					arg_110_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["2078ui_story"]) and arg_110_1.var_.characterEffect2078ui_story then
				arg_110_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_113_2 = arg_110_1.actors_["2079ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect2079ui_story == nil then
				arg_110_1.var_.characterEffect2079ui_story = var_113_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_3 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_3 and not isNil(var_113_2) then
				if arg_110_1.var_.characterEffect2079ui_story and not isNil(var_113_2) then
					arg_110_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_110_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_3)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_3 and arg_110_1.time_ < 0 + var_113_3 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect2079ui_story then
				arg_110_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_110_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_113_4 = 0
			local var_113_5 = 0.075

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[546].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_6 = arg_110_1:GetWordFromCfg(317031025)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 3 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 3)

				if (3 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 3)) > 0 and var_113_5 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031025", "story_v_out_317031.awb") ~= 0 then
					local var_113_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031025", "story_v_out_317031.awb") / 1000

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end

					if var_113_6.prefab_name ~= "" and arg_110_1.actors_[var_113_6.prefab_name] ~= nil then
						local var_113_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_6.prefab_name].transform, "story_v_out_317031", "317031025", "story_v_out_317031.awb")

						arg_110_1:RecordAudio("317031025", var_113_11)
						arg_110_1:RecordAudio("317031025", var_113_11)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_317031", "317031025", "story_v_out_317031.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_317031", "317031025", "story_v_out_317031.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_12 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_12 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_12

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_12 and arg_110_1.time_ < var_113_4 + var_113_12 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play317031026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 317031026
		arg_114_1.duration_ = 2.23

		local var_114_0 = {
			zh = 1.866,
			ja = 2.233
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
				arg_114_0:Play317031027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.125

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[546].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:GetWordFromCfg(317031026)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 5 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 5)

				if (5 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 5)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031026", "story_v_out_317031.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031026", "story_v_out_317031.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_317031", "317031026", "story_v_out_317031.awb")

						arg_114_1:RecordAudio("317031026", var_117_6)
						arg_114_1:RecordAudio("317031026", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_317031", "317031026", "story_v_out_317031.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_317031", "317031026", "story_v_out_317031.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play317031027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 317031027
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play317031028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos2078ui_story = arg_118_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_121_0 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 then
				arg_118_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_118_1.time_ - 0) / var_121_0)
				arg_118_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["2078ui_story"].transform.position).z)
				arg_118_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["2078ui_story"].transform.localEulerAngles = arg_118_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 then
				arg_118_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_118_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["2078ui_story"].transform.position).z)
				arg_118_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["2078ui_story"].transform.localEulerAngles = arg_118_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_121_1 = arg_118_1.actors_["2079ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos2079ui_story = var_121_1.localPosition
			end

			local var_121_2 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 then
				var_121_1.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_118_1.time_ - 0) / var_121_2)
				var_121_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_1.position).x, (manager.ui.mainCamera.transform.position - var_121_1.position).y, (manager.ui.mainCamera.transform.position - var_121_1.position).z)
				var_121_1.localEulerAngles.z = 0
				var_121_1.localEulerAngles.x = 0
				var_121_1.localEulerAngles = var_121_1.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 then
				var_121_1.localPosition = Vector3.New(0, 100, 0)
				var_121_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_1.position).x, (manager.ui.mainCamera.transform.position - var_121_1.position).y, (manager.ui.mainCamera.transform.position - var_121_1.position).z)
				var_121_1.localEulerAngles.z = 0
				var_121_1.localEulerAngles.x = 0
				var_121_1.localEulerAngles = var_121_1.localEulerAngles
			end

			local var_121_3 = arg_118_1.actors_["1015ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1015ui_story = var_121_3.localPosition
			end

			local var_121_4 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				var_121_3.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_118_1.time_ - 0) / var_121_4)
				var_121_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_3.position).x, (manager.ui.mainCamera.transform.position - var_121_3.position).y, (manager.ui.mainCamera.transform.position - var_121_3.position).z)
				var_121_3.localEulerAngles.z = 0
				var_121_3.localEulerAngles.x = 0
				var_121_3.localEulerAngles = var_121_3.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				var_121_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_121_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_3.position).x, (manager.ui.mainCamera.transform.position - var_121_3.position).y, (manager.ui.mainCamera.transform.position - var_121_3.position).z)
				var_121_3.localEulerAngles.z = 0
				var_121_3.localEulerAngles.x = 0
				var_121_3.localEulerAngles = var_121_3.localEulerAngles
			end

			local var_121_5 = arg_118_1.actors_["1015ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_5) and arg_118_1.var_.characterEffect1015ui_story == nil then
				arg_118_1.var_.characterEffect1015ui_story = var_121_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_6 and not isNil(var_121_5) then
				if arg_118_1.var_.characterEffect1015ui_story and not isNil(var_121_5) then
					arg_118_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_6)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_6 and arg_118_1.time_ < 0 + var_121_6 + arg_121_0 and not isNil(var_121_5) and arg_118_1.var_.characterEffect1015ui_story then
				arg_118_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_121_7 = 0
			local var_121_8 = 0.8

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_7 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_9 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(317031027).content)

				arg_118_1.text_.text = var_121_9

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 32 <= 0 and var_121_8 or var_121_8 * (utf8.len(var_121_9) / 32)

				if (32 <= 0 and var_121_8 or var_121_8 * (utf8.len(var_121_9) / 32)) > 0 and var_121_8 < var_121_11 then
					arg_118_1.talkMaxDuration = var_121_11

					if var_121_11 + var_121_7 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_11 + var_121_7
					end
				end

				arg_118_1.text_.text = var_121_9
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_8, arg_118_1.talkMaxDuration)

			if var_121_7 <= arg_118_1.time_ and arg_118_1.time_ < var_121_7 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_7) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_7 + var_121_12 and arg_118_1.time_ < var_121_7 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play317031028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 317031028
		arg_122_1.duration_ = 9.8

		local var_122_0 = {
			zh = 8.366,
			ja = 9.8
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
				arg_122_0:Play317031029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos2078ui_story = arg_122_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_125_0 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 then
				arg_122_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_122_1.time_ - 0) / var_125_0)
				arg_122_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["2078ui_story"].transform.position).z)
				arg_122_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["2078ui_story"].transform.localEulerAngles = arg_122_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 then
				arg_122_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_122_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["2078ui_story"].transform.position).z)
				arg_122_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["2078ui_story"].transform.localEulerAngles = arg_122_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_125_1 = arg_122_1.actors_["2078ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect2078ui_story == nil then
				arg_122_1.var_.characterEffect2078ui_story = var_125_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_2 and not isNil(var_125_1) then
				if arg_122_1.var_.characterEffect2078ui_story and not isNil(var_125_1) then
					arg_122_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_2 and arg_122_1.time_ < 0 + var_125_2 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect2078ui_story then
				arg_122_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_125_4 = arg_122_1.actors_["1015ui_story"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1015ui_story = var_125_4.localPosition
			end

			local var_125_5 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_5 then
				var_125_4.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_122_1.time_ - 0) / var_125_5)
				var_125_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_4.position).x, (manager.ui.mainCamera.transform.position - var_125_4.position).y, (manager.ui.mainCamera.transform.position - var_125_4.position).z)
				var_125_4.localEulerAngles.z = 0
				var_125_4.localEulerAngles.x = 0
				var_125_4.localEulerAngles = var_125_4.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_5 and arg_122_1.time_ < 0 + var_125_5 + arg_125_0 then
				var_125_4.localPosition = Vector3.New(0, 100, 0)
				var_125_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_4.position).x, (manager.ui.mainCamera.transform.position - var_125_4.position).y, (manager.ui.mainCamera.transform.position - var_125_4.position).z)
				var_125_4.localEulerAngles.z = 0
				var_125_4.localEulerAngles.x = 0
				var_125_4.localEulerAngles = var_125_4.localEulerAngles
			end

			local var_125_6 = arg_122_1.actors_["1015ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_6) and arg_122_1.var_.characterEffect1015ui_story == nil then
				arg_122_1.var_.characterEffect1015ui_story = var_125_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_7 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_7 and not isNil(var_125_6) then
				if arg_122_1.var_.characterEffect1015ui_story and not isNil(var_125_6) then
					arg_122_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_7)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_7 and arg_122_1.time_ < 0 + var_125_7 + arg_125_0 and not isNil(var_125_6) and arg_122_1.var_.characterEffect1015ui_story then
				arg_122_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_125_8 = 0
			local var_125_9 = 0.925

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_8 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[546].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_10 = arg_122_1:GetWordFromCfg(317031028)
				local var_125_11 = arg_122_1:FormatText(var_125_10.content)

				arg_122_1.text_.text = var_125_11

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_13 = 37 <= 0 and var_125_9 or var_125_9 * (utf8.len(var_125_11) / 37)

				if (37 <= 0 and var_125_9 or var_125_9 * (utf8.len(var_125_11) / 37)) > 0 and var_125_9 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_8
					end
				end

				arg_122_1.text_.text = var_125_11
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031028", "story_v_out_317031.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_317031", "317031028", "story_v_out_317031.awb") / 1000

					if var_125_14 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_8
					end

					if var_125_10.prefab_name ~= "" and arg_122_1.actors_[var_125_10.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_10.prefab_name].transform, "story_v_out_317031", "317031028", "story_v_out_317031.awb")

						arg_122_1:RecordAudio("317031028", var_125_15)
						arg_122_1:RecordAudio("317031028", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_317031", "317031028", "story_v_out_317031.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_317031", "317031028", "story_v_out_317031.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_9, arg_122_1.talkMaxDuration)

			if var_125_8 <= arg_122_1.time_ and arg_122_1.time_ < var_125_8 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_8) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_8 + var_125_16 and arg_122_1.time_ < var_125_8 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play317031029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 317031029
		arg_126_1.duration_ = 1.63

		local var_126_0 = {
			zh = 1.633,
			ja = 1.366
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
				arg_126_0:Play317031030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos2078ui_story = arg_126_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_129_0 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 then
				arg_126_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_0)
				arg_126_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["2078ui_story"].transform.position).z)
				arg_126_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["2078ui_story"].transform.localEulerAngles = arg_126_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 then
				arg_126_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["2078ui_story"].transform.position).z)
				arg_126_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["2078ui_story"].transform.localEulerAngles = arg_126_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_129_1 = arg_126_1.actors_["2078ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect2078ui_story == nil then
				arg_126_1.var_.characterEffect2078ui_story = var_129_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_2 and not isNil(var_129_1) then
				if arg_126_1.var_.characterEffect2078ui_story and not isNil(var_129_1) then
					arg_126_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_126_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_2)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_2 and arg_126_1.time_ < 0 + var_129_2 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect2078ui_story then
				arg_126_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_126_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_129_3 = arg_126_1.actors_["1015ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1015ui_story = var_129_3.localPosition
			end

			local var_129_4 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 then
				var_129_3.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_126_1.time_ - 0) / var_129_4)
				var_129_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_3.position).x, (manager.ui.mainCamera.transform.position - var_129_3.position).y, (manager.ui.mainCamera.transform.position - var_129_3.position).z)
				var_129_3.localEulerAngles.z = 0
				var_129_3.localEulerAngles.x = 0
				var_129_3.localEulerAngles = var_129_3.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 then
				var_129_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_129_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_3.position).x, (manager.ui.mainCamera.transform.position - var_129_3.position).y, (manager.ui.mainCamera.transform.position - var_129_3.position).z)
				var_129_3.localEulerAngles.z = 0
				var_129_3.localEulerAngles.x = 0
				var_129_3.localEulerAngles = var_129_3.localEulerAngles
			end

			local var_129_5 = arg_126_1.actors_["1015ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.characterEffect1015ui_story == nil then
				arg_126_1.var_.characterEffect1015ui_story = var_129_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_6 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_6 and not isNil(var_129_5) then
				if arg_126_1.var_.characterEffect1015ui_story and not isNil(var_129_5) then
					arg_126_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_6 and arg_126_1.time_ < 0 + var_129_6 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.characterEffect1015ui_story then
				arg_126_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_129_8 = 0
			local var_129_9 = 0.15

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_10 = arg_126_1:GetWordFromCfg(317031029)
				local var_129_11 = arg_126_1:FormatText(var_129_10.content)

				arg_126_1.text_.text = var_129_11

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_13 = 6 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 6)

				if (6 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 6)) > 0 and var_129_9 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_8
					end
				end

				arg_126_1.text_.text = var_129_11
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031029", "story_v_out_317031.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_317031", "317031029", "story_v_out_317031.awb") / 1000

					if var_129_14 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_8
					end

					if var_129_10.prefab_name ~= "" and arg_126_1.actors_[var_129_10.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_10.prefab_name].transform, "story_v_out_317031", "317031029", "story_v_out_317031.awb")

						arg_126_1:RecordAudio("317031029", var_129_15)
						arg_126_1:RecordAudio("317031029", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_317031", "317031029", "story_v_out_317031.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_317031", "317031029", "story_v_out_317031.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_9, arg_126_1.talkMaxDuration)

			if var_129_8 <= arg_126_1.time_ and arg_126_1.time_ < var_129_8 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_8) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_8 + var_129_16 and arg_126_1.time_ < var_129_8 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play317031030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 317031030
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play317031031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1015ui_story = arg_130_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_133_0 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 then
				arg_130_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 0) / var_133_0)
				arg_130_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1015ui_story"].transform.position).z)
				arg_130_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1015ui_story"].transform.localEulerAngles = arg_130_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 then
				arg_130_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1015ui_story"].transform.position).z)
				arg_130_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1015ui_story"].transform.localEulerAngles = arg_130_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_133_1 = arg_130_1.actors_["1015ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect1015ui_story == nil then
				arg_130_1.var_.characterEffect1015ui_story = var_133_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_2 and not isNil(var_133_1) then
				if arg_130_1.var_.characterEffect1015ui_story and not isNil(var_133_1) then
					arg_130_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_2)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_2 and arg_130_1.time_ < 0 + var_133_2 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect1015ui_story then
				arg_130_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_133_3 = 0
			local var_133_4 = 1.25

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_3 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_5 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(317031030).content)

				arg_130_1.text_.text = var_133_5

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_7 = 50 <= 0 and var_133_4 or var_133_4 * (utf8.len(var_133_5) / 50)

				if (50 <= 0 and var_133_4 or var_133_4 * (utf8.len(var_133_5) / 50)) > 0 and var_133_4 < var_133_7 then
					arg_130_1.talkMaxDuration = var_133_7

					if var_133_7 + var_133_3 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_3
					end
				end

				arg_130_1.text_.text = var_133_5
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_8 = math.max(var_133_4, arg_130_1.talkMaxDuration)

			if var_133_3 <= arg_130_1.time_ and arg_130_1.time_ < var_133_3 + var_133_8 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_3) / var_133_8

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_3 + var_133_8 and arg_130_1.time_ < var_133_3 + var_133_8 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play317031031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 317031031
		arg_134_1.duration_ = 2.2

		local var_134_0 = {
			zh = 1.6,
			ja = 2.2
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play317031032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0.075

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_1 = arg_134_1:GetWordFromCfg(317031031)
				local var_137_2 = arg_134_1:FormatText(var_137_1.content)

				arg_134_1.text_.text = var_137_2

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 3 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 3)

				if (3 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 3)) > 0 and var_137_0 < var_137_4 then
					arg_134_1.talkMaxDuration = var_137_4

					if var_137_4 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_4 + 0
					end
				end

				arg_134_1.text_.text = var_137_2
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031031", "story_v_out_317031.awb") ~= 0 then
					local var_137_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031031", "story_v_out_317031.awb") / 1000

					if var_137_5 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + 0
					end

					if var_137_1.prefab_name ~= "" and arg_134_1.actors_[var_137_1.prefab_name] ~= nil then
						local var_137_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_1.prefab_name].transform, "story_v_out_317031", "317031031", "story_v_out_317031.awb")

						arg_134_1:RecordAudio("317031031", var_137_6)
						arg_134_1:RecordAudio("317031031", var_137_6)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_317031", "317031031", "story_v_out_317031.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_317031", "317031031", "story_v_out_317031.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_7 and arg_134_1.time_ < 0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play317031032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 317031032
		arg_138_1.duration_ = 6.67

		local var_138_0 = {
			zh = 6.666,
			ja = 3.933
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
				arg_138_0:Play317031033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1015ui_story = arg_138_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_141_0 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 then
				arg_138_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_138_1.time_ - 0) / var_141_0)
				arg_138_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1015ui_story"].transform.position).z)
				arg_138_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1015ui_story"].transform.localEulerAngles = arg_138_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 then
				arg_138_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_138_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1015ui_story"].transform.position).z)
				arg_138_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1015ui_story"].transform.localEulerAngles = arg_138_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_141_1 = arg_138_1.actors_["1015ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1015ui_story == nil then
				arg_138_1.var_.characterEffect1015ui_story = var_141_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_2 and not isNil(var_141_1) then
				if arg_138_1.var_.characterEffect1015ui_story and not isNil(var_141_1) then
					arg_138_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_2 and arg_138_1.time_ < 0 + var_141_2 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1015ui_story then
				arg_138_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_141_4 = 0
			local var_141_5 = 0.775

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_4 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_6 = arg_138_1:GetWordFromCfg(317031032)
				local var_141_7 = arg_138_1:FormatText(var_141_6.content)

				arg_138_1.text_.text = var_141_7

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_9 = 31 <= 0 and var_141_5 or var_141_5 * (utf8.len(var_141_7) / 31)

				if (31 <= 0 and var_141_5 or var_141_5 * (utf8.len(var_141_7) / 31)) > 0 and var_141_5 < var_141_9 then
					arg_138_1.talkMaxDuration = var_141_9

					if var_141_9 + var_141_4 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_9 + var_141_4
					end
				end

				arg_138_1.text_.text = var_141_7
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031032", "story_v_out_317031.awb") ~= 0 then
					local var_141_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031032", "story_v_out_317031.awb") / 1000

					if var_141_10 + var_141_4 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_10 + var_141_4
					end

					if var_141_6.prefab_name ~= "" and arg_138_1.actors_[var_141_6.prefab_name] ~= nil then
						local var_141_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_6.prefab_name].transform, "story_v_out_317031", "317031032", "story_v_out_317031.awb")

						arg_138_1:RecordAudio("317031032", var_141_11)
						arg_138_1:RecordAudio("317031032", var_141_11)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_317031", "317031032", "story_v_out_317031.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_317031", "317031032", "story_v_out_317031.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_12 = math.max(var_141_5, arg_138_1.talkMaxDuration)

			if var_141_4 <= arg_138_1.time_ and arg_138_1.time_ < var_141_4 + var_141_12 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_4) / var_141_12

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_4 + var_141_12 and arg_138_1.time_ < var_141_4 + var_141_12 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play317031033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 317031033
		arg_142_1.duration_ = 4.57

		local var_142_0 = {
			zh = 4.566,
			ja = 2.1
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
				arg_142_0:Play317031034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1015ui_story"]) and arg_142_1.var_.characterEffect1015ui_story == nil then
				arg_142_1.var_.characterEffect1015ui_story = arg_142_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1015ui_story"]) then
				if arg_142_1.var_.characterEffect1015ui_story and not isNil(arg_142_1.actors_["1015ui_story"]) then
					arg_142_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_0)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1015ui_story"]) and arg_142_1.var_.characterEffect1015ui_story then
				arg_142_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_145_1 = 0
			local var_145_2 = 0.725

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(317031033)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_6 = 29 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_4) / 29)

				if (29 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_4) / 29)) > 0 and var_145_2 < var_145_6 then
					arg_142_1.talkMaxDuration = var_145_6

					if var_145_6 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_1
					end
				end

				arg_142_1.text_.text = var_145_4
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031033", "story_v_out_317031.awb") ~= 0 then
					local var_145_7 = manager.audio:GetVoiceLength("story_v_out_317031", "317031033", "story_v_out_317031.awb") / 1000

					if var_145_7 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_1
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_317031", "317031033", "story_v_out_317031.awb")

						arg_142_1:RecordAudio("317031033", var_145_8)
						arg_142_1:RecordAudio("317031033", var_145_8)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_317031", "317031033", "story_v_out_317031.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_317031", "317031033", "story_v_out_317031.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_9 = math.max(var_145_2, arg_142_1.talkMaxDuration)

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_9 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_1) / var_145_9

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_1 + var_145_9 and arg_142_1.time_ < var_145_1 + var_145_9 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play317031034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 317031034
		arg_146_1.duration_ = 2.63

		local var_146_0 = {
			zh = 1.866,
			ja = 2.633
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
				arg_146_0:Play317031035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1015ui_story = arg_146_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_149_0 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				arg_146_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_146_1.time_ - 0) / var_149_0)
				arg_146_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1015ui_story"].transform.position).z)
				arg_146_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1015ui_story"].transform.localEulerAngles = arg_146_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				arg_146_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_146_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1015ui_story"].transform.position).z)
				arg_146_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1015ui_story"].transform.localEulerAngles = arg_146_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_149_1 = arg_146_1.actors_["1015ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect1015ui_story == nil then
				arg_146_1.var_.characterEffect1015ui_story = var_149_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_2 and not isNil(var_149_1) then
				if arg_146_1.var_.characterEffect1015ui_story and not isNil(var_149_1) then
					arg_146_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_2 and arg_146_1.time_ < 0 + var_149_2 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect1015ui_story then
				arg_146_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_149_4 = 0
			local var_149_5 = 0.175

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_6 = arg_146_1:GetWordFromCfg(317031034)
				local var_149_7 = arg_146_1:FormatText(var_149_6.content)

				arg_146_1.text_.text = var_149_7

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_9 = 7 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 7)

				if (7 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 7)) > 0 and var_149_5 < var_149_9 then
					arg_146_1.talkMaxDuration = var_149_9

					if var_149_9 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_9 + var_149_4
					end
				end

				arg_146_1.text_.text = var_149_7
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031034", "story_v_out_317031.awb") ~= 0 then
					local var_149_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031034", "story_v_out_317031.awb") / 1000

					if var_149_10 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_4
					end

					if var_149_6.prefab_name ~= "" and arg_146_1.actors_[var_149_6.prefab_name] ~= nil then
						local var_149_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_6.prefab_name].transform, "story_v_out_317031", "317031034", "story_v_out_317031.awb")

						arg_146_1:RecordAudio("317031034", var_149_11)
						arg_146_1:RecordAudio("317031034", var_149_11)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_317031", "317031034", "story_v_out_317031.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_317031", "317031034", "story_v_out_317031.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_12 = math.max(var_149_5, arg_146_1.talkMaxDuration)

			if var_149_4 <= arg_146_1.time_ and arg_146_1.time_ < var_149_4 + var_149_12 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_4) / var_149_12

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_4 + var_149_12 and arg_146_1.time_ < var_149_4 + var_149_12 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play317031035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 317031035
		arg_150_1.duration_ = 10.13

		local var_150_0 = {
			zh = 8.5,
			ja = 10.133
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
				arg_150_0:Play317031036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1015ui_story"]) and arg_150_1.var_.characterEffect1015ui_story == nil then
				arg_150_1.var_.characterEffect1015ui_story = arg_150_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["1015ui_story"]) then
				if arg_150_1.var_.characterEffect1015ui_story and not isNil(arg_150_1.actors_["1015ui_story"]) then
					arg_150_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_0)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["1015ui_story"]) and arg_150_1.var_.characterEffect1015ui_story then
				arg_150_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_153_1 = 0
			local var_153_2 = 1.05

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_3 = arg_150_1:GetWordFromCfg(317031035)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_6 = 42 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_4) / 42)

				if (42 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_4) / 42)) > 0 and var_153_2 < var_153_6 then
					arg_150_1.talkMaxDuration = var_153_6

					if var_153_6 + var_153_1 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_6 + var_153_1
					end
				end

				arg_150_1.text_.text = var_153_4
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031035", "story_v_out_317031.awb") ~= 0 then
					local var_153_7 = manager.audio:GetVoiceLength("story_v_out_317031", "317031035", "story_v_out_317031.awb") / 1000

					if var_153_7 + var_153_1 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_1
					end

					if var_153_3.prefab_name ~= "" and arg_150_1.actors_[var_153_3.prefab_name] ~= nil then
						local var_153_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_3.prefab_name].transform, "story_v_out_317031", "317031035", "story_v_out_317031.awb")

						arg_150_1:RecordAudio("317031035", var_153_8)
						arg_150_1:RecordAudio("317031035", var_153_8)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_317031", "317031035", "story_v_out_317031.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_317031", "317031035", "story_v_out_317031.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_9 = math.max(var_153_2, arg_150_1.talkMaxDuration)

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_9 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_1) / var_153_9

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_1 + var_153_9 and arg_150_1.time_ < var_153_1 + var_153_9 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play317031036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 317031036
		arg_154_1.duration_ = 2

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play317031037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1015ui_story = arg_154_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_157_0 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 then
				arg_154_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_154_1.time_ - 0) / var_157_0)
				arg_154_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1015ui_story"].transform.position).z)
				arg_154_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1015ui_story"].transform.localEulerAngles = arg_154_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 then
				arg_154_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_154_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1015ui_story"].transform.position).z)
				arg_154_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1015ui_story"].transform.localEulerAngles = arg_154_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_157_1 = arg_154_1.actors_["1015ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_1) and arg_154_1.var_.characterEffect1015ui_story == nil then
				arg_154_1.var_.characterEffect1015ui_story = var_157_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_2 and not isNil(var_157_1) then
				if arg_154_1.var_.characterEffect1015ui_story and not isNil(var_157_1) then
					arg_154_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_2 and arg_154_1.time_ < 0 + var_157_2 + arg_157_0 and not isNil(var_157_1) and arg_154_1.var_.characterEffect1015ui_story then
				arg_154_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_157_4 = 0
			local var_157_5 = 0.05

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_6 = arg_154_1:GetWordFromCfg(317031036)
				local var_157_7 = arg_154_1:FormatText(var_157_6.content)

				arg_154_1.text_.text = var_157_7

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_9 = 2 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 2)

				if (2 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 2)) > 0 and var_157_5 < var_157_9 then
					arg_154_1.talkMaxDuration = var_157_9

					if var_157_9 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_9 + var_157_4
					end
				end

				arg_154_1.text_.text = var_157_7
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031036", "story_v_out_317031.awb") ~= 0 then
					local var_157_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031036", "story_v_out_317031.awb") / 1000

					if var_157_10 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_4
					end

					if var_157_6.prefab_name ~= "" and arg_154_1.actors_[var_157_6.prefab_name] ~= nil then
						local var_157_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_6.prefab_name].transform, "story_v_out_317031", "317031036", "story_v_out_317031.awb")

						arg_154_1:RecordAudio("317031036", var_157_11)
						arg_154_1:RecordAudio("317031036", var_157_11)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_317031", "317031036", "story_v_out_317031.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_317031", "317031036", "story_v_out_317031.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_12 = math.max(var_157_5, arg_154_1.talkMaxDuration)

			if var_157_4 <= arg_154_1.time_ and arg_154_1.time_ < var_157_4 + var_157_12 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_4) / var_157_12

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_4 + var_157_12 and arg_154_1.time_ < var_157_4 + var_157_12 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play317031037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 317031037
		arg_158_1.duration_ = 11.97

		local var_158_0 = {
			zh = 11.966,
			ja = 9.6
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
				arg_158_0:Play317031038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1015ui_story"]) and arg_158_1.var_.characterEffect1015ui_story == nil then
				arg_158_1.var_.characterEffect1015ui_story = arg_158_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1015ui_story"]) then
				if arg_158_1.var_.characterEffect1015ui_story and not isNil(arg_158_1.actors_["1015ui_story"]) then
					arg_158_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_0)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1015ui_story"]) and arg_158_1.var_.characterEffect1015ui_story then
				arg_158_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_161_1 = 0
			local var_161_2 = 1.5

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_3 = arg_158_1:GetWordFromCfg(317031037)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_6 = 60 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_4) / 60)

				if (60 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_4) / 60)) > 0 and var_161_2 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_1
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031037", "story_v_out_317031.awb") ~= 0 then
					local var_161_7 = manager.audio:GetVoiceLength("story_v_out_317031", "317031037", "story_v_out_317031.awb") / 1000

					if var_161_7 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_1
					end

					if var_161_3.prefab_name ~= "" and arg_158_1.actors_[var_161_3.prefab_name] ~= nil then
						local var_161_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_3.prefab_name].transform, "story_v_out_317031", "317031037", "story_v_out_317031.awb")

						arg_158_1:RecordAudio("317031037", var_161_8)
						arg_158_1:RecordAudio("317031037", var_161_8)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_317031", "317031037", "story_v_out_317031.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_317031", "317031037", "story_v_out_317031.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_9 = math.max(var_161_2, arg_158_1.talkMaxDuration)

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_9 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_1) / var_161_9

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_1 + var_161_9 and arg_158_1.time_ < var_161_1 + var_161_9 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play317031038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 317031038
		arg_162_1.duration_ = 3.87

		local var_162_0 = {
			zh = 2.866,
			ja = 3.866
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
				arg_162_0:Play317031039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1015ui_story = arg_162_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_165_0 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 then
				arg_162_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_162_1.time_ - 0) / var_165_0)
				arg_162_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1015ui_story"].transform.position).z)
				arg_162_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["1015ui_story"].transform.localEulerAngles = arg_162_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 then
				arg_162_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_162_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1015ui_story"].transform.position).z)
				arg_162_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["1015ui_story"].transform.localEulerAngles = arg_162_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_165_1 = arg_162_1.actors_["1015ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_1) and arg_162_1.var_.characterEffect1015ui_story == nil then
				arg_162_1.var_.characterEffect1015ui_story = var_165_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_2 and not isNil(var_165_1) then
				if arg_162_1.var_.characterEffect1015ui_story and not isNil(var_165_1) then
					arg_162_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_2 and arg_162_1.time_ < 0 + var_165_2 + arg_165_0 and not isNil(var_165_1) and arg_162_1.var_.characterEffect1015ui_story then
				arg_162_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_165_4 = 0
			local var_165_5 = 0.2

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_6 = arg_162_1:GetWordFromCfg(317031038)
				local var_165_7 = arg_162_1:FormatText(var_165_6.content)

				arg_162_1.text_.text = var_165_7

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_9 = 8 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 8)

				if (8 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 8)) > 0 and var_165_5 < var_165_9 then
					arg_162_1.talkMaxDuration = var_165_9

					if var_165_9 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_9 + var_165_4
					end
				end

				arg_162_1.text_.text = var_165_7
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031038", "story_v_out_317031.awb") ~= 0 then
					local var_165_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031038", "story_v_out_317031.awb") / 1000

					if var_165_10 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_10 + var_165_4
					end

					if var_165_6.prefab_name ~= "" and arg_162_1.actors_[var_165_6.prefab_name] ~= nil then
						local var_165_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_6.prefab_name].transform, "story_v_out_317031", "317031038", "story_v_out_317031.awb")

						arg_162_1:RecordAudio("317031038", var_165_11)
						arg_162_1:RecordAudio("317031038", var_165_11)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_317031", "317031038", "story_v_out_317031.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_317031", "317031038", "story_v_out_317031.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_12 = math.max(var_165_5, arg_162_1.talkMaxDuration)

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_12 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_4) / var_165_12

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_4 + var_165_12 and arg_162_1.time_ < var_165_4 + var_165_12 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play317031039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 317031039
		arg_166_1.duration_ = 4.6

		local var_166_0 = {
			zh = 2.766,
			ja = 4.6
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play317031040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1015ui_story"]) and arg_166_1.var_.characterEffect1015ui_story == nil then
				arg_166_1.var_.characterEffect1015ui_story = arg_166_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1015ui_story"]) then
				if arg_166_1.var_.characterEffect1015ui_story and not isNil(arg_166_1.actors_["1015ui_story"]) then
					arg_166_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_0)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1015ui_story"]) and arg_166_1.var_.characterEffect1015ui_story then
				arg_166_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_169_1 = 0
			local var_169_2 = 0.35

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_3 = arg_166_1:GetWordFromCfg(317031039)
				local var_169_4 = arg_166_1:FormatText(var_169_3.content)

				arg_166_1.text_.text = var_169_4

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_6 = 14 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_4) / 14)

				if (14 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_4) / 14)) > 0 and var_169_2 < var_169_6 then
					arg_166_1.talkMaxDuration = var_169_6

					if var_169_6 + var_169_1 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_6 + var_169_1
					end
				end

				arg_166_1.text_.text = var_169_4
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031039", "story_v_out_317031.awb") ~= 0 then
					local var_169_7 = manager.audio:GetVoiceLength("story_v_out_317031", "317031039", "story_v_out_317031.awb") / 1000

					if var_169_7 + var_169_1 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_1
					end

					if var_169_3.prefab_name ~= "" and arg_166_1.actors_[var_169_3.prefab_name] ~= nil then
						local var_169_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_3.prefab_name].transform, "story_v_out_317031", "317031039", "story_v_out_317031.awb")

						arg_166_1:RecordAudio("317031039", var_169_8)
						arg_166_1:RecordAudio("317031039", var_169_8)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_317031", "317031039", "story_v_out_317031.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_317031", "317031039", "story_v_out_317031.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_9 = math.max(var_169_2, arg_166_1.talkMaxDuration)

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_9 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_1) / var_169_9

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_1 + var_169_9 and arg_166_1.time_ < var_169_1 + var_169_9 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play317031040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 317031040
		arg_170_1.duration_ = 7.9

		local var_170_0 = {
			zh = 7.9,
			ja = 7.6
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play317031041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1015ui_story = arg_170_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_173_0 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 then
				arg_170_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_170_1.time_ - 0) / var_173_0)
				arg_170_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1015ui_story"].transform.position).z)
				arg_170_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1015ui_story"].transform.localEulerAngles = arg_170_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 then
				arg_170_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_170_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1015ui_story"].transform.position).z)
				arg_170_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1015ui_story"].transform.localEulerAngles = arg_170_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_173_1 = arg_170_1.actors_["1015ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1015ui_story == nil then
				arg_170_1.var_.characterEffect1015ui_story = var_173_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_2 and not isNil(var_173_1) then
				if arg_170_1.var_.characterEffect1015ui_story and not isNil(var_173_1) then
					arg_170_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_2 and arg_170_1.time_ < 0 + var_173_2 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1015ui_story then
				arg_170_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_173_4 = 0
			local var_173_5 = 0.925

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_6 = arg_170_1:GetWordFromCfg(317031040)
				local var_173_7 = arg_170_1:FormatText(var_173_6.content)

				arg_170_1.text_.text = var_173_7

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_9 = 37 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 37)

				if (37 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 37)) > 0 and var_173_5 < var_173_9 then
					arg_170_1.talkMaxDuration = var_173_9

					if var_173_9 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_9 + var_173_4
					end
				end

				arg_170_1.text_.text = var_173_7
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031040", "story_v_out_317031.awb") ~= 0 then
					local var_173_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031040", "story_v_out_317031.awb") / 1000

					if var_173_10 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_4
					end

					if var_173_6.prefab_name ~= "" and arg_170_1.actors_[var_173_6.prefab_name] ~= nil then
						local var_173_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_6.prefab_name].transform, "story_v_out_317031", "317031040", "story_v_out_317031.awb")

						arg_170_1:RecordAudio("317031040", var_173_11)
						arg_170_1:RecordAudio("317031040", var_173_11)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_317031", "317031040", "story_v_out_317031.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_317031", "317031040", "story_v_out_317031.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_12 = math.max(var_173_5, arg_170_1.talkMaxDuration)

			if var_173_4 <= arg_170_1.time_ and arg_170_1.time_ < var_173_4 + var_173_12 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_4) / var_173_12

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_4 + var_173_12 and arg_170_1.time_ < var_173_4 + var_173_12 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play317031041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 317031041
		arg_174_1.duration_ = 14.4

		local var_174_0 = {
			zh = 13.9,
			ja = 14.4
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play317031042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1015ui_story = arg_174_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_177_0 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 then
				arg_174_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_174_1.time_ - 0) / var_177_0)
				arg_174_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1015ui_story"].transform.position).z)
				arg_174_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["1015ui_story"].transform.localEulerAngles = arg_174_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 then
				arg_174_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_174_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1015ui_story"].transform.position).z)
				arg_174_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["1015ui_story"].transform.localEulerAngles = arg_174_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_177_1 = arg_174_1.actors_["1015ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect1015ui_story == nil then
				arg_174_1.var_.characterEffect1015ui_story = var_177_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_2 and not isNil(var_177_1) then
				if arg_174_1.var_.characterEffect1015ui_story and not isNil(var_177_1) then
					arg_174_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_2 and arg_174_1.time_ < 0 + var_177_2 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect1015ui_story then
				arg_174_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_177_4 = 0
			local var_177_5 = 1.775

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_4 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_6 = arg_174_1:GetWordFromCfg(317031041)
				local var_177_7 = arg_174_1:FormatText(var_177_6.content)

				arg_174_1.text_.text = var_177_7

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_9 = 71 <= 0 and var_177_5 or var_177_5 * (utf8.len(var_177_7) / 71)

				if (71 <= 0 and var_177_5 or var_177_5 * (utf8.len(var_177_7) / 71)) > 0 and var_177_5 < var_177_9 then
					arg_174_1.talkMaxDuration = var_177_9

					if var_177_9 + var_177_4 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_9 + var_177_4
					end
				end

				arg_174_1.text_.text = var_177_7
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031041", "story_v_out_317031.awb") ~= 0 then
					local var_177_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031041", "story_v_out_317031.awb") / 1000

					if var_177_10 + var_177_4 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_10 + var_177_4
					end

					if var_177_6.prefab_name ~= "" and arg_174_1.actors_[var_177_6.prefab_name] ~= nil then
						local var_177_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_6.prefab_name].transform, "story_v_out_317031", "317031041", "story_v_out_317031.awb")

						arg_174_1:RecordAudio("317031041", var_177_11)
						arg_174_1:RecordAudio("317031041", var_177_11)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_317031", "317031041", "story_v_out_317031.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_317031", "317031041", "story_v_out_317031.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_12 = math.max(var_177_5, arg_174_1.talkMaxDuration)

			if var_177_4 <= arg_174_1.time_ and arg_174_1.time_ < var_177_4 + var_177_12 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_4) / var_177_12

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_4 + var_177_12 and arg_174_1.time_ < var_177_4 + var_177_12 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play317031042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 317031042
		arg_178_1.duration_ = 4.9

		local var_178_0 = {
			zh = 4.9,
			ja = 1.9
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
				arg_178_0:Play317031043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1015ui_story"]) and arg_178_1.var_.characterEffect1015ui_story == nil then
				arg_178_1.var_.characterEffect1015ui_story = arg_178_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1015ui_story"]) then
				if arg_178_1.var_.characterEffect1015ui_story and not isNil(arg_178_1.actors_["1015ui_story"]) then
					arg_178_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_0)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1015ui_story"]) and arg_178_1.var_.characterEffect1015ui_story then
				arg_178_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_181_1 = 0
			local var_181_2 = 0.475

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:GetWordFromCfg(317031042)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_6 = 19 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_4) / 19)

				if (19 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_4) / 19)) > 0 and var_181_2 < var_181_6 then
					arg_178_1.talkMaxDuration = var_181_6

					if var_181_6 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_6 + var_181_1
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031042", "story_v_out_317031.awb") ~= 0 then
					local var_181_7 = manager.audio:GetVoiceLength("story_v_out_317031", "317031042", "story_v_out_317031.awb") / 1000

					if var_181_7 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_1
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_317031", "317031042", "story_v_out_317031.awb")

						arg_178_1:RecordAudio("317031042", var_181_8)
						arg_178_1:RecordAudio("317031042", var_181_8)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_317031", "317031042", "story_v_out_317031.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_317031", "317031042", "story_v_out_317031.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_9 = math.max(var_181_2, arg_178_1.talkMaxDuration)

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_9 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_1) / var_181_9

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_1 + var_181_9 and arg_178_1.time_ < var_181_1 + var_181_9 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play317031043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 317031043
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play317031044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0.4

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(317031043).content)

				arg_182_1.text_.text = var_185_1

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_3 = 16 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 16)

				if (16 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 16)) > 0 and var_185_0 < var_185_3 then
					arg_182_1.talkMaxDuration = var_185_3

					if var_185_3 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_3 + 0
					end
				end

				arg_182_1.text_.text = var_185_1
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_4 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_4

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play317031044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 317031044
		arg_186_1.duration_ = 15.57

		local var_186_0 = {
			zh = 15.566,
			ja = 14.433
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
				arg_186_0:Play317031045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 1.95

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_1 = arg_186_1:GetWordFromCfg(317031044)
				local var_189_2 = arg_186_1:FormatText(var_189_1.content)

				arg_186_1.text_.text = var_189_2

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_4 = 78 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_2) / 78)

				if (78 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_2) / 78)) > 0 and var_189_0 < var_189_4 then
					arg_186_1.talkMaxDuration = var_189_4

					if var_189_4 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_4 + 0
					end
				end

				arg_186_1.text_.text = var_189_2
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031044", "story_v_out_317031.awb") ~= 0 then
					local var_189_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031044", "story_v_out_317031.awb") / 1000

					if var_189_5 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + 0
					end

					if var_189_1.prefab_name ~= "" and arg_186_1.actors_[var_189_1.prefab_name] ~= nil then
						local var_189_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_1.prefab_name].transform, "story_v_out_317031", "317031044", "story_v_out_317031.awb")

						arg_186_1:RecordAudio("317031044", var_189_6)
						arg_186_1:RecordAudio("317031044", var_189_6)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_317031", "317031044", "story_v_out_317031.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_317031", "317031044", "story_v_out_317031.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_7 = math.max(var_189_0, arg_186_1.talkMaxDuration)

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_7 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - 0) / var_189_7

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= 0 + var_189_7 and arg_186_1.time_ < 0 + var_189_7 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play317031045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 317031045
		arg_190_1.duration_ = 10.4

		local var_190_0 = {
			zh = 10.4,
			ja = 7.266
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
				arg_190_0:Play317031046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1015ui_story = arg_190_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_193_0 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 then
				arg_190_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_190_1.time_ - 0) / var_193_0)
				arg_190_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1015ui_story"].transform.position).z)
				arg_190_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1015ui_story"].transform.localEulerAngles = arg_190_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 then
				arg_190_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_190_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1015ui_story"].transform.position).z)
				arg_190_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1015ui_story"].transform.localEulerAngles = arg_190_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_193_1 = arg_190_1.actors_["1015ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1015ui_story == nil then
				arg_190_1.var_.characterEffect1015ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1015ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1015ui_story then
				arg_190_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_193_4 = 0
			local var_193_5 = 1.225

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(317031045)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 49 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 49)

				if (49 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 49)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031045", "story_v_out_317031.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031045", "story_v_out_317031.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_out_317031", "317031045", "story_v_out_317031.awb")

						arg_190_1:RecordAudio("317031045", var_193_11)
						arg_190_1:RecordAudio("317031045", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_317031", "317031045", "story_v_out_317031.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_317031", "317031045", "story_v_out_317031.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_12 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_12 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_12

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_12 and arg_190_1.time_ < var_193_4 + var_193_12 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play317031046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 317031046
		arg_194_1.duration_ = 3.8

		local var_194_0 = {
			zh = 2.733,
			ja = 3.8
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play317031047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1015ui_story"]) and arg_194_1.var_.characterEffect1015ui_story == nil then
				arg_194_1.var_.characterEffect1015ui_story = arg_194_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1015ui_story"]) then
				if arg_194_1.var_.characterEffect1015ui_story and not isNil(arg_194_1.actors_["1015ui_story"]) then
					arg_194_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_0)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1015ui_story"]) and arg_194_1.var_.characterEffect1015ui_story then
				arg_194_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_197_1 = 0
			local var_197_2 = 0.275

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:GetWordFromCfg(317031046)
				local var_197_4 = arg_194_1:FormatText(var_197_3.content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_6 = 11 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_4) / 11)

				if (11 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_4) / 11)) > 0 and var_197_2 < var_197_6 then
					arg_194_1.talkMaxDuration = var_197_6

					if var_197_6 + var_197_1 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_6 + var_197_1
					end
				end

				arg_194_1.text_.text = var_197_4
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031046", "story_v_out_317031.awb") ~= 0 then
					local var_197_7 = manager.audio:GetVoiceLength("story_v_out_317031", "317031046", "story_v_out_317031.awb") / 1000

					if var_197_7 + var_197_1 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_1
					end

					if var_197_3.prefab_name ~= "" and arg_194_1.actors_[var_197_3.prefab_name] ~= nil then
						local var_197_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_3.prefab_name].transform, "story_v_out_317031", "317031046", "story_v_out_317031.awb")

						arg_194_1:RecordAudio("317031046", var_197_8)
						arg_194_1:RecordAudio("317031046", var_197_8)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_317031", "317031046", "story_v_out_317031.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_317031", "317031046", "story_v_out_317031.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_9 = math.max(var_197_2, arg_194_1.talkMaxDuration)

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_9 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_1) / var_197_9

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_1 + var_197_9 and arg_194_1.time_ < var_197_1 + var_197_9 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play317031047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 317031047
		arg_198_1.duration_ = 4.07

		local var_198_0 = {
			zh = 2.566,
			ja = 4.066
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
				arg_198_0:Play317031048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1015ui_story = arg_198_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1015ui_story"].transform.position).z)
				arg_198_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1015ui_story"].transform.localEulerAngles = arg_198_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_198_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1015ui_story"].transform.position).z)
				arg_198_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1015ui_story"].transform.localEulerAngles = arg_198_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_201_1 = arg_198_1.actors_["1015ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect1015ui_story == nil then
				arg_198_1.var_.characterEffect1015ui_story = var_201_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_2 and not isNil(var_201_1) then
				if arg_198_1.var_.characterEffect1015ui_story and not isNil(var_201_1) then
					arg_198_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_2 and arg_198_1.time_ < 0 + var_201_2 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect1015ui_story then
				arg_198_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_201_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_198_1.bgmTxt_.text ~= var_201_6 and arg_198_1.bgmTxt_.text ~= "" then
						if arg_198_1.bgmTxt2_.text ~= "" then
							arg_198_1.bgmTxt_.text = arg_198_1.bgmTxt2_.text
						end

						arg_198_1.bgmTxt2_.text = var_201_6

						arg_198_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_198_1.bgmTxt_.text = var_201_6
						arg_198_1.bgmTxt2_.text = var_201_6
					end

					if arg_198_1.bgmTimer then
						arg_198_1.bgmTimer:Stop()

						arg_198_1.bgmTimer = nil
					end

					if arg_198_1.settingData.show_music_name == 1 then
						arg_198_1.musicController:SetSelectedState("show")
						arg_198_1.musicAnimator_:Play("open", 0, 0)

						if arg_198_1.settingData.music_time ~= 0 then
							arg_198_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_198_1.settingData.music_time), function()
								if arg_198_1 == nil or isNil(arg_198_1.bgmTxt_) then
									return
								end

								arg_198_1.musicController:SetSelectedState("hide")
								arg_198_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_201_7 = 0
			local var_201_8 = 0.25

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_7 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_9 = arg_198_1:GetWordFromCfg(317031047)
				local var_201_10 = arg_198_1:FormatText(var_201_9.content)

				arg_198_1.text_.text = var_201_10

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_12 = 10 <= 0 and var_201_8 or var_201_8 * (utf8.len(var_201_10) / 10)

				if (10 <= 0 and var_201_8 or var_201_8 * (utf8.len(var_201_10) / 10)) > 0 and var_201_8 < var_201_12 then
					arg_198_1.talkMaxDuration = var_201_12

					if var_201_12 + var_201_7 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_12 + var_201_7
					end
				end

				arg_198_1.text_.text = var_201_10
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031047", "story_v_out_317031.awb") ~= 0 then
					local var_201_13 = manager.audio:GetVoiceLength("story_v_out_317031", "317031047", "story_v_out_317031.awb") / 1000

					if var_201_13 + var_201_7 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_13 + var_201_7
					end

					if var_201_9.prefab_name ~= "" and arg_198_1.actors_[var_201_9.prefab_name] ~= nil then
						local var_201_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_9.prefab_name].transform, "story_v_out_317031", "317031047", "story_v_out_317031.awb")

						arg_198_1:RecordAudio("317031047", var_201_14)
						arg_198_1:RecordAudio("317031047", var_201_14)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_317031", "317031047", "story_v_out_317031.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_317031", "317031047", "story_v_out_317031.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_15 = math.max(var_201_8, arg_198_1.talkMaxDuration)

			if var_201_7 <= arg_198_1.time_ and arg_198_1.time_ < var_201_7 + var_201_15 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_7) / var_201_15

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_7 + var_201_15 and arg_198_1.time_ < var_201_7 + var_201_15 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play317031048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 317031048
		arg_203_1.duration_ = 9

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play317031049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if arg_203_1.bgs_.K03f == nil then
				local var_206_0 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K03f")
				var_206_0.name = "K03f"
				var_206_0.transform.parent = arg_203_1.stage_.transform
				var_206_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_.K03f = var_206_0
			end

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= 2 + arg_206_0 then
				local var_206_1 = arg_203_1.bgs_.K03f

				arg_203_1.bgs_.K03f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_206_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_2 = var_206_1:GetComponent("SpriteRenderer")

				if var_206_2 and var_206_2.sprite then
					local var_206_3 = 2 * (var_206_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_206_1.transform.localScale = Vector3.New(var_206_3 / var_206_2.sprite.bounds.size.y < var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x and var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x or var_206_3 / var_206_2.sprite.bounds.size.y, var_206_3 / var_206_2.sprite.bounds.size.y < var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x and var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x or var_206_3 / var_206_2.sprite.bounds.size.y, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "K03f" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_4 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_5 = 2

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_5 then
				local var_206_6 = Color.New(0, 0, 0)

				var_206_6.a = Mathf.Lerp(0, 1, (arg_203_1.time_ - var_206_4) / var_206_5)
				arg_203_1.mask_.color = var_206_6
			end

			if arg_203_1.time_ >= var_206_4 + var_206_5 and arg_203_1.time_ < var_206_4 + var_206_5 + arg_206_0 then
				local var_206_7 = Color.New(0, 0, 0)

				var_206_7.a = 1
				arg_203_1.mask_.color = var_206_7
			end

			local var_206_8 = 2

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_9 = 2

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_9 then
				local var_206_10 = Color.New(0, 0, 0)

				var_206_10.a = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_8) / var_206_9)
				arg_203_1.mask_.color = var_206_10
			end

			if arg_203_1.time_ >= var_206_8 + var_206_9 and arg_203_1.time_ < var_206_8 + var_206_9 + arg_206_0 then
				local var_206_11 = Color.New(0, 0, 0)

				arg_203_1.mask_.enabled = false
				var_206_11.a = 0
				arg_203_1.mask_.color = var_206_11
			end

			local var_206_12 = arg_203_1.actors_["1015ui_story"].transform

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= 2 + arg_206_0 then
				arg_203_1.var_.moveOldPos1015ui_story = var_206_12.localPosition
			end

			local var_206_13 = 0.001

			if 2 <= arg_203_1.time_ and arg_203_1.time_ < 2 + var_206_13 then
				var_206_12.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 2) / var_206_13)
				var_206_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_12.position).x, (manager.ui.mainCamera.transform.position - var_206_12.position).y, (manager.ui.mainCamera.transform.position - var_206_12.position).z)
				var_206_12.localEulerAngles.z = 0
				var_206_12.localEulerAngles.x = 0
				var_206_12.localEulerAngles = var_206_12.localEulerAngles
			end

			if arg_203_1.time_ >= 2 + var_206_13 and arg_203_1.time_ < 2 + var_206_13 + arg_206_0 then
				var_206_12.localPosition = Vector3.New(0, 100, 0)
				var_206_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_12.position).x, (manager.ui.mainCamera.transform.position - var_206_12.position).y, (manager.ui.mainCamera.transform.position - var_206_12.position).z)
				var_206_12.localEulerAngles.z = 0
				var_206_12.localEulerAngles.x = 0
				var_206_12.localEulerAngles = var_206_12.localEulerAngles
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_206_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_203_1.bgmTxt_.text ~= var_206_16 and arg_203_1.bgmTxt_.text ~= "" then
						if arg_203_1.bgmTxt2_.text ~= "" then
							arg_203_1.bgmTxt_.text = arg_203_1.bgmTxt2_.text
						end

						arg_203_1.bgmTxt2_.text = var_206_16

						arg_203_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_203_1.bgmTxt_.text = var_206_16
						arg_203_1.bgmTxt2_.text = var_206_16
					end

					if arg_203_1.bgmTimer then
						arg_203_1.bgmTimer:Stop()

						arg_203_1.bgmTimer = nil
					end

					if arg_203_1.settingData.show_music_name == 1 then
						arg_203_1.musicController:SetSelectedState("show")
						arg_203_1.musicAnimator_:Play("open", 0, 0)

						if arg_203_1.settingData.music_time ~= 0 then
							arg_203_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_203_1.settingData.music_time), function()
								if arg_203_1 == nil or isNil(arg_203_1.bgmTxt_) then
									return
								end

								arg_203_1.musicController:SetSelectedState("hide")
								arg_203_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 3.825 < arg_203_1.time_ and arg_203_1.time_ <= 3.825 + arg_206_0 then
				arg_203_1:AudioAction("play", "music", "bgm_activity_2_4_story_forest", "bgm_activity_2_4_story_forest", "bgm_activity_2_4_story_forest.awb")

				local var_206_19 = manager.audio:GetAudioName("bgm_activity_2_4_story_forest", "bgm_activity_2_4_story_forest")

				if "" ~= "" then
					if arg_203_1.bgmTxt_.text ~= var_206_19 and arg_203_1.bgmTxt_.text ~= "" then
						if arg_203_1.bgmTxt2_.text ~= "" then
							arg_203_1.bgmTxt_.text = arg_203_1.bgmTxt2_.text
						end

						arg_203_1.bgmTxt2_.text = var_206_19

						arg_203_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_203_1.bgmTxt_.text = var_206_19
						arg_203_1.bgmTxt2_.text = var_206_19
					end

					if arg_203_1.bgmTimer then
						arg_203_1.bgmTimer:Stop()

						arg_203_1.bgmTimer = nil
					end

					if arg_203_1.settingData.show_music_name == 1 then
						arg_203_1.musicController:SetSelectedState("show")
						arg_203_1.musicAnimator_:Play("open", 0, 0)

						if arg_203_1.settingData.music_time ~= 0 then
							arg_203_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_203_1.settingData.music_time), function()
								if arg_203_1 == nil or isNil(arg_203_1.bgmTxt_) then
									return
								end

								arg_203_1.musicController:SetSelectedState("hide")
								arg_203_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_20 = 4
			local var_206_21 = 0.825

			if 4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_20 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_22 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_22:setOnUpdate(LuaHelper.FloatAction(function(arg_209_0)
					arg_203_1.dialogCg_.alpha = arg_209_0
				end))
				var_206_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_23 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(317031048).content)

				arg_203_1.text_.text = var_206_23

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_25 = 33 <= 0 and var_206_21 or var_206_21 * (utf8.len(var_206_23) / 33)

				if (33 <= 0 and var_206_21 or var_206_21 * (utf8.len(var_206_23) / 33)) > 0 and var_206_21 < var_206_25 then
					arg_203_1.talkMaxDuration = var_206_25
					var_206_20 = var_206_20 + 0.3

					if var_206_25 + var_206_20 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_25 + var_206_20
					end
				end

				arg_203_1.text_.text = var_206_23
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_26 = var_206_20 + 0.3
			local var_206_27 = math.max(var_206_21, arg_203_1.talkMaxDuration)

			if var_206_20 + 0.3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_26 + var_206_27 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_26) / var_206_27

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_26 + var_206_27 and arg_203_1.time_ < var_206_26 + var_206_27 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play317031049 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 317031049
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play317031050(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.5

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(317031049).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 20 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 20)

				if (20 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 20)) > 0 and var_214_0 < var_214_3 then
					arg_211_1.talkMaxDuration = var_214_3

					if var_214_3 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_3 + 0
					end
				end

				arg_211_1.text_.text = var_214_1
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_4 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_4

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play317031050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 317031050
		arg_215_1.duration_ = 9.97

		local var_215_0 = {
			zh = 9.966,
			ja = 8.1
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
				arg_215_0:Play317031051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if arg_215_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_218_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_215_1.stage_.transform)

				var_218_0.name = "1093ui_story"
				var_218_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.actors_["1093ui_story"] = var_218_0

				local var_218_1 = var_218_0:GetComponentInChildren(typeof(CharacterEffect))

				var_218_1.enabled = true

				local var_218_2 = GameObjectTools.GetOrAddComponent(var_218_0, typeof(DynamicBoneHelper))

				if var_218_2 then
					var_218_2:EnableDynamicBone(false)
				end

				arg_215_1:ShowWeapon(var_218_1.transform, false)

				arg_215_1.var_["1093ui_story" .. "Animator"] = var_218_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_215_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_215_1.var_["1093ui_story" .. "LipSync"] = var_218_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_218_3 = arg_215_1.actors_["1093ui_story"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1093ui_story = var_218_3.localPosition
			end

			local var_218_4 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				var_218_3.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_215_1.time_ - 0) / var_218_4)
				var_218_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_3.position).x, (manager.ui.mainCamera.transform.position - var_218_3.position).y, (manager.ui.mainCamera.transform.position - var_218_3.position).z)
				var_218_3.localEulerAngles.z = 0
				var_218_3.localEulerAngles.x = 0
				var_218_3.localEulerAngles = var_218_3.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				var_218_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_218_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_3.position).x, (manager.ui.mainCamera.transform.position - var_218_3.position).y, (manager.ui.mainCamera.transform.position - var_218_3.position).z)
				var_218_3.localEulerAngles.z = 0
				var_218_3.localEulerAngles.x = 0
				var_218_3.localEulerAngles = var_218_3.localEulerAngles
			end

			local var_218_5 = arg_215_1.actors_["1093ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_5) and arg_215_1.var_.characterEffect1093ui_story == nil then
				arg_215_1.var_.characterEffect1093ui_story = var_218_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_6 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_6 and not isNil(var_218_5) then
				if arg_215_1.var_.characterEffect1093ui_story and not isNil(var_218_5) then
					arg_215_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_6 and arg_215_1.time_ < 0 + var_218_6 + arg_218_0 and not isNil(var_218_5) and arg_215_1.var_.characterEffect1093ui_story then
				arg_215_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_218_8 = 0
			local var_218_9 = 1.1

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_10 = arg_215_1:GetWordFromCfg(317031050)
				local var_218_11 = arg_215_1:FormatText(var_218_10.content)

				arg_215_1.text_.text = var_218_11

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_13 = 44 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 44)

				if (44 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 44)) > 0 and var_218_9 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_8
					end
				end

				arg_215_1.text_.text = var_218_11
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031050", "story_v_out_317031.awb") ~= 0 then
					local var_218_14 = manager.audio:GetVoiceLength("story_v_out_317031", "317031050", "story_v_out_317031.awb") / 1000

					if var_218_14 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_14 + var_218_8
					end

					if var_218_10.prefab_name ~= "" and arg_215_1.actors_[var_218_10.prefab_name] ~= nil then
						local var_218_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_10.prefab_name].transform, "story_v_out_317031", "317031050", "story_v_out_317031.awb")

						arg_215_1:RecordAudio("317031050", var_218_15)
						arg_215_1:RecordAudio("317031050", var_218_15)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_317031", "317031050", "story_v_out_317031.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_317031", "317031050", "story_v_out_317031.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_16 = math.max(var_218_9, arg_215_1.talkMaxDuration)

			if var_218_8 <= arg_215_1.time_ and arg_215_1.time_ < var_218_8 + var_218_16 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_8) / var_218_16

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_8 + var_218_16 and arg_215_1.time_ < var_218_8 + var_218_16 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play317031051 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 317031051
		arg_219_1.duration_ = 6.27

		local var_219_0 = {
			zh = 5.333,
			ja = 6.266
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
				arg_219_0:Play317031052(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_222_0 = 0
			local var_222_1 = 0.7

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(317031051)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 28 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 28)

				if (28 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 28)) > 0 and var_222_1 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031051", "story_v_out_317031.awb") ~= 0 then
					local var_222_6 = manager.audio:GetVoiceLength("story_v_out_317031", "317031051", "story_v_out_317031.awb") / 1000

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end

					if var_222_2.prefab_name ~= "" and arg_219_1.actors_[var_222_2.prefab_name] ~= nil then
						local var_222_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_2.prefab_name].transform, "story_v_out_317031", "317031051", "story_v_out_317031.awb")

						arg_219_1:RecordAudio("317031051", var_222_7)
						arg_219_1:RecordAudio("317031051", var_222_7)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_317031", "317031051", "story_v_out_317031.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_317031", "317031051", "story_v_out_317031.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_8 and arg_219_1.time_ < var_222_0 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play317031052 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 317031052
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play317031053(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1093ui_story"]) and arg_223_1.var_.characterEffect1093ui_story == nil then
				arg_223_1.var_.characterEffect1093ui_story = arg_223_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1093ui_story"]) then
				if arg_223_1.var_.characterEffect1093ui_story and not isNil(arg_223_1.actors_["1093ui_story"]) then
					arg_223_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1093ui_story"]) and arg_223_1.var_.characterEffect1093ui_story then
				arg_223_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0
			local var_226_2 = 0.5

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(317031052).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 20 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 20)

				if (20 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 20)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_6 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_6 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_6

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_6 and arg_223_1.time_ < var_226_1 + var_226_6 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play317031053 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 317031053
		arg_227_1.duration_ = 7.87

		local var_227_0 = {
			zh = 5.166,
			ja = 7.866
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play317031054(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1093ui_story"]) and arg_227_1.var_.characterEffect1093ui_story == nil then
				arg_227_1.var_.characterEffect1093ui_story = arg_227_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1093ui_story"]) then
				if arg_227_1.var_.characterEffect1093ui_story and not isNil(arg_227_1.actors_["1093ui_story"]) then
					arg_227_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1093ui_story"]) and arg_227_1.var_.characterEffect1093ui_story then
				arg_227_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_230_2 = 0
			local var_230_3 = 0.525

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_4 = arg_227_1:GetWordFromCfg(317031053)
				local var_230_5 = arg_227_1:FormatText(var_230_4.content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 21 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 21)

				if (21 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 21)) > 0 and var_230_3 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031053", "story_v_out_317031.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_317031", "317031053", "story_v_out_317031.awb") / 1000

					if var_230_8 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_2
					end

					if var_230_4.prefab_name ~= "" and arg_227_1.actors_[var_230_4.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_4.prefab_name].transform, "story_v_out_317031", "317031053", "story_v_out_317031.awb")

						arg_227_1:RecordAudio("317031053", var_230_9)
						arg_227_1:RecordAudio("317031053", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_317031", "317031053", "story_v_out_317031.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_317031", "317031053", "story_v_out_317031.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_10 and arg_227_1.time_ < var_230_2 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play317031054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 317031054
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play317031055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1093ui_story"]) and arg_231_1.var_.characterEffect1093ui_story == nil then
				arg_231_1.var_.characterEffect1093ui_story = arg_231_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1093ui_story"]) then
				if arg_231_1.var_.characterEffect1093ui_story and not isNil(arg_231_1.actors_["1093ui_story"]) then
					arg_231_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_0)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1093ui_story"]) and arg_231_1.var_.characterEffect1093ui_story then
				arg_231_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_234_1 = 0
			local var_234_2 = 0.1

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(317031054).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 4 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 4)

				if (4 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 4)) > 0 and var_234_2 < var_234_5 then
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

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play317031055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 317031055
		arg_235_1.duration_ = 15.27

		local var_235_0 = {
			zh = 15.266,
			ja = 15.1
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play317031056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1093ui_story"]) and arg_235_1.var_.characterEffect1093ui_story == nil then
				arg_235_1.var_.characterEffect1093ui_story = arg_235_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1093ui_story"]) then
				if arg_235_1.var_.characterEffect1093ui_story and not isNil(arg_235_1.actors_["1093ui_story"]) then
					arg_235_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1093ui_story"]) and arg_235_1.var_.characterEffect1093ui_story then
				arg_235_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_238_2 = 0
			local var_238_3 = 1.925

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_4 = arg_235_1:GetWordFromCfg(317031055)
				local var_238_5 = arg_235_1:FormatText(var_238_4.content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 76 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 76)

				if (76 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 76)) > 0 and var_238_3 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_2
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031055", "story_v_out_317031.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_317031", "317031055", "story_v_out_317031.awb") / 1000

					if var_238_8 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_2
					end

					if var_238_4.prefab_name ~= "" and arg_235_1.actors_[var_238_4.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_4.prefab_name].transform, "story_v_out_317031", "317031055", "story_v_out_317031.awb")

						arg_235_1:RecordAudio("317031055", var_238_9)
						arg_235_1:RecordAudio("317031055", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_317031", "317031055", "story_v_out_317031.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_317031", "317031055", "story_v_out_317031.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_3, arg_235_1.talkMaxDuration)

			if var_238_2 <= arg_235_1.time_ and arg_235_1.time_ < var_238_2 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_2) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_2 + var_238_10 and arg_235_1.time_ < var_238_2 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play317031056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 317031056
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play317031057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1093ui_story"]) and arg_239_1.var_.characterEffect1093ui_story == nil then
				arg_239_1.var_.characterEffect1093ui_story = arg_239_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1093ui_story"]) then
				if arg_239_1.var_.characterEffect1093ui_story and not isNil(arg_239_1.actors_["1093ui_story"]) then
					arg_239_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_0)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1093ui_story"]) and arg_239_1.var_.characterEffect1093ui_story then
				arg_239_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_242_1 = 0
			local var_242_2 = 0.5

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
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

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(317031056).content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 20 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 20)

				if (20 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 20)) > 0 and var_242_2 < var_242_5 then
					arg_239_1.talkMaxDuration = var_242_5

					if var_242_5 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_6 = math.max(var_242_2, arg_239_1.talkMaxDuration)

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_6 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_1) / var_242_6

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_1 + var_242_6 and arg_239_1.time_ < var_242_1 + var_242_6 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play317031057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 317031057
		arg_243_1.duration_ = 12.87

		local var_243_0 = {
			zh = 10.233,
			ja = 12.866
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
				arg_243_0:Play317031058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1093ui_story = arg_243_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1093ui_story"].transform.position).z)
				arg_243_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1093ui_story"].transform.localEulerAngles = arg_243_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_243_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1093ui_story"].transform.position).z)
				arg_243_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1093ui_story"].transform.localEulerAngles = arg_243_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1093ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1093ui_story == nil then
				arg_243_1.var_.characterEffect1093ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1093ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1093ui_story then
				arg_243_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action446")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_246_4 = 0
			local var_246_5 = 1.25

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_6 = arg_243_1:GetWordFromCfg(317031057)
				local var_246_7 = arg_243_1:FormatText(var_246_6.content)

				arg_243_1.text_.text = var_246_7

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_9 = 50 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 50)

				if (50 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 50)) > 0 and var_246_5 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_4
					end
				end

				arg_243_1.text_.text = var_246_7
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031057", "story_v_out_317031.awb") ~= 0 then
					local var_246_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031057", "story_v_out_317031.awb") / 1000

					if var_246_10 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_4
					end

					if var_246_6.prefab_name ~= "" and arg_243_1.actors_[var_246_6.prefab_name] ~= nil then
						local var_246_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_6.prefab_name].transform, "story_v_out_317031", "317031057", "story_v_out_317031.awb")

						arg_243_1:RecordAudio("317031057", var_246_11)
						arg_243_1:RecordAudio("317031057", var_246_11)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_317031", "317031057", "story_v_out_317031.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_317031", "317031057", "story_v_out_317031.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_12 = math.max(var_246_5, arg_243_1.talkMaxDuration)

			if var_246_4 <= arg_243_1.time_ and arg_243_1.time_ < var_246_4 + var_246_12 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_4) / var_246_12

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_4 + var_246_12 and arg_243_1.time_ < var_246_4 + var_246_12 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play317031058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 317031058
		arg_247_1.duration_ = 11.13

		local var_247_0 = {
			zh = 11.133,
			ja = 10.7
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
				arg_247_0:Play317031059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.3

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:GetWordFromCfg(317031058)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 52 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 52)

				if (52 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 52)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031058", "story_v_out_317031.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031058", "story_v_out_317031.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_317031", "317031058", "story_v_out_317031.awb")

						arg_247_1:RecordAudio("317031058", var_250_6)
						arg_247_1:RecordAudio("317031058", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_317031", "317031058", "story_v_out_317031.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_317031", "317031058", "story_v_out_317031.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play317031059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 317031059
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play317031060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1093ui_story"]) and arg_251_1.var_.characterEffect1093ui_story == nil then
				arg_251_1.var_.characterEffect1093ui_story = arg_251_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1093ui_story"]) then
				if arg_251_1.var_.characterEffect1093ui_story and not isNil(arg_251_1.actors_["1093ui_story"]) then
					arg_251_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_0)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1093ui_story"]) and arg_251_1.var_.characterEffect1093ui_story then
				arg_251_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_254_1 = 0
			local var_254_2 = 0.275

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(317031059).content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 11 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 11)

				if (11 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 11)) > 0 and var_254_2 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_1
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_6 = math.max(var_254_2, arg_251_1.talkMaxDuration)

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_6 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_1) / var_254_6

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_1 + var_254_6 and arg_251_1.time_ < var_254_1 + var_254_6 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play317031060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 317031060
		arg_255_1.duration_ = 8.43

		local var_255_0 = {
			zh = 3.9,
			ja = 8.433
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
				arg_255_0:Play317031061(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.5

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:GetWordFromCfg(317031060)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 20 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 20)

				if (20 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 20)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031060", "story_v_out_317031.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031060", "story_v_out_317031.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_317031", "317031060", "story_v_out_317031.awb")

						arg_255_1:RecordAudio("317031060", var_258_6)
						arg_255_1:RecordAudio("317031060", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_317031", "317031060", "story_v_out_317031.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_317031", "317031060", "story_v_out_317031.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play317031061 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 317031061
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play317031062(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1093ui_story = arg_259_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1093ui_story"].transform.position).z)
				arg_259_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1093ui_story"].transform.localEulerAngles = arg_259_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_259_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1093ui_story"].transform.position).z)
				arg_259_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1093ui_story"].transform.localEulerAngles = arg_259_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["1093ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1093ui_story == nil then
				arg_259_1.var_.characterEffect1093ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect1093ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_2)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1093ui_story then
				arg_259_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_262_3 = 0
			local var_262_4 = 0.75

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_3 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_5 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(317031061).content)

				arg_259_1.text_.text = var_262_5

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_7 = 30 <= 0 and var_262_4 or var_262_4 * (utf8.len(var_262_5) / 30)

				if (30 <= 0 and var_262_4 or var_262_4 * (utf8.len(var_262_5) / 30)) > 0 and var_262_4 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_3 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_3
					end
				end

				arg_259_1.text_.text = var_262_5
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_8 = math.max(var_262_4, arg_259_1.talkMaxDuration)

			if var_262_3 <= arg_259_1.time_ and arg_259_1.time_ < var_262_3 + var_262_8 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_3) / var_262_8

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_3 + var_262_8 and arg_259_1.time_ < var_262_3 + var_262_8 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play317031062 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 317031062
		arg_263_1.duration_ = 3.63

		local var_263_0 = {
			zh = 2.9,
			ja = 3.633
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
				arg_263_0:Play317031063(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1093ui_story = arg_263_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1093ui_story"].transform.position).z)
				arg_263_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1093ui_story"].transform.localEulerAngles = arg_263_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_263_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1093ui_story"].transform.position).z)
				arg_263_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1093ui_story"].transform.localEulerAngles = arg_263_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1093ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1093ui_story == nil then
				arg_263_1.var_.characterEffect1093ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1093ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1093ui_story then
				arg_263_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_266_4 = 0
			local var_266_5 = 0.15

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_6 = arg_263_1:GetWordFromCfg(317031062)
				local var_266_7 = arg_263_1:FormatText(var_266_6.content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 6 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 6)

				if (6 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 6)) > 0 and var_266_5 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031062", "story_v_out_317031.awb") ~= 0 then
					local var_266_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031062", "story_v_out_317031.awb") / 1000

					if var_266_10 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_4
					end

					if var_266_6.prefab_name ~= "" and arg_263_1.actors_[var_266_6.prefab_name] ~= nil then
						local var_266_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_6.prefab_name].transform, "story_v_out_317031", "317031062", "story_v_out_317031.awb")

						arg_263_1:RecordAudio("317031062", var_266_11)
						arg_263_1:RecordAudio("317031062", var_266_11)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_317031", "317031062", "story_v_out_317031.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_317031", "317031062", "story_v_out_317031.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_12 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_12 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_12

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_12 and arg_263_1.time_ < var_266_4 + var_266_12 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play317031063 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 317031063
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play317031064(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1093ui_story = arg_267_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1093ui_story"].transform.position).z)
				arg_267_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1093ui_story"].transform.localEulerAngles = arg_267_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1093ui_story"].transform.position).z)
				arg_267_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1093ui_story"].transform.localEulerAngles = arg_267_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_270_1 = 0
			local var_270_2 = 0.675

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_3 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(317031063).content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 27 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 27)

				if (27 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 27)) > 0 and var_270_2 < var_270_5 then
					arg_267_1.talkMaxDuration = var_270_5

					if var_270_5 + var_270_1 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + var_270_1
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_6 = math.max(var_270_2, arg_267_1.talkMaxDuration)

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_6 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_1) / var_270_6

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_1 + var_270_6 and arg_267_1.time_ < var_270_1 + var_270_6 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play317031064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 317031064
		arg_271_1.duration_ = 3.67

		local var_271_0 = {
			zh = 2.933,
			ja = 3.666
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
				arg_271_0:Play317031065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1015ui_story = arg_271_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1015ui_story"].transform.position).z)
				arg_271_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1015ui_story"].transform.localEulerAngles = arg_271_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_271_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1015ui_story"].transform.position).z)
				arg_271_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1015ui_story"].transform.localEulerAngles = arg_271_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["1015ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1015ui_story == nil then
				arg_271_1.var_.characterEffect1015ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect1015ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1015ui_story then
				arg_271_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_274_4 = 0
			local var_274_5 = 0.225

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_6 = arg_271_1:GetWordFromCfg(317031064)
				local var_274_7 = arg_271_1:FormatText(var_274_6.content)

				arg_271_1.text_.text = var_274_7

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_9 = 9 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 9)

				if (9 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 9)) > 0 and var_274_5 < var_274_9 then
					arg_271_1.talkMaxDuration = var_274_9

					if var_274_9 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_9 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_7
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031064", "story_v_out_317031.awb") ~= 0 then
					local var_274_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031064", "story_v_out_317031.awb") / 1000

					if var_274_10 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_4
					end

					if var_274_6.prefab_name ~= "" and arg_271_1.actors_[var_274_6.prefab_name] ~= nil then
						local var_274_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_6.prefab_name].transform, "story_v_out_317031", "317031064", "story_v_out_317031.awb")

						arg_271_1:RecordAudio("317031064", var_274_11)
						arg_271_1:RecordAudio("317031064", var_274_11)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_317031", "317031064", "story_v_out_317031.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_317031", "317031064", "story_v_out_317031.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_12 = math.max(var_274_5, arg_271_1.talkMaxDuration)

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_12 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_4) / var_274_12

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_4 + var_274_12 and arg_271_1.time_ < var_274_4 + var_274_12 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play317031065 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 317031065
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play317031066(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1015ui_story"]) and arg_275_1.var_.characterEffect1015ui_story == nil then
				arg_275_1.var_.characterEffect1015ui_story = arg_275_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1015ui_story"]) then
				if arg_275_1.var_.characterEffect1015ui_story and not isNil(arg_275_1.actors_["1015ui_story"]) then
					arg_275_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1015ui_story"]) and arg_275_1.var_.characterEffect1015ui_story then
				arg_275_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_278_1 = 0
			local var_278_2 = 0.725

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(317031065).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 29 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 29)

				if (29 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 29)) > 0 and var_278_2 < var_278_5 then
					arg_275_1.talkMaxDuration = var_278_5

					if var_278_5 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_6 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_6 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_6

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_6 and arg_275_1.time_ < var_278_1 + var_278_6 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play317031066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 317031066
		arg_279_1.duration_ = 4.67

		local var_279_0 = {
			zh = 4.666,
			ja = 4.566
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play317031067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1015ui_story = arg_279_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1015ui_story"].transform.position).z)
				arg_279_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1015ui_story"].transform.localEulerAngles = arg_279_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_279_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1015ui_story"].transform.position).z)
				arg_279_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1015ui_story"].transform.localEulerAngles = arg_279_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["1015ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1015ui_story == nil then
				arg_279_1.var_.characterEffect1015ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect1015ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1015ui_story then
				arg_279_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_282_4 = 0
			local var_282_5 = 0.6

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_6 = arg_279_1:GetWordFromCfg(317031066)
				local var_282_7 = arg_279_1:FormatText(var_282_6.content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 24 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 24)

				if (24 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 24)) > 0 and var_282_5 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031066", "story_v_out_317031.awb") ~= 0 then
					local var_282_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031066", "story_v_out_317031.awb") / 1000

					if var_282_10 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_4
					end

					if var_282_6.prefab_name ~= "" and arg_279_1.actors_[var_282_6.prefab_name] ~= nil then
						local var_282_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_6.prefab_name].transform, "story_v_out_317031", "317031066", "story_v_out_317031.awb")

						arg_279_1:RecordAudio("317031066", var_282_11)
						arg_279_1:RecordAudio("317031066", var_282_11)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_317031", "317031066", "story_v_out_317031.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_317031", "317031066", "story_v_out_317031.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_12 = math.max(var_282_5, arg_279_1.talkMaxDuration)

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_12 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_4) / var_282_12

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_4 + var_282_12 and arg_279_1.time_ < var_282_4 + var_282_12 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play317031067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 317031067
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play317031068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1015ui_story"]) and arg_283_1.var_.characterEffect1015ui_story == nil then
				arg_283_1.var_.characterEffect1015ui_story = arg_283_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1015ui_story"]) then
				if arg_283_1.var_.characterEffect1015ui_story and not isNil(arg_283_1.actors_["1015ui_story"]) then
					arg_283_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_0)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1015ui_story"]) and arg_283_1.var_.characterEffect1015ui_story then
				arg_283_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_286_1 = 0
			local var_286_2 = 0.7

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(317031067).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 28 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 28)

				if (28 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 28)) > 0 and var_286_2 < var_286_5 then
					arg_283_1.talkMaxDuration = var_286_5

					if var_286_5 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_6 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_6 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_6

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_6 and arg_283_1.time_ < var_286_1 + var_286_6 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play317031068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 317031068
		arg_287_1.duration_ = 6.37

		local var_287_0 = {
			zh = 6.366,
			ja = 4.5
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play317031069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1015ui_story = arg_287_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1015ui_story"].transform.position).z)
				arg_287_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1015ui_story"].transform.localEulerAngles = arg_287_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_287_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1015ui_story"].transform.position).z)
				arg_287_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1015ui_story"].transform.localEulerAngles = arg_287_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["1015ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1015ui_story == nil then
				arg_287_1.var_.characterEffect1015ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect1015ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1015ui_story then
				arg_287_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_290_4 = 0
			local var_290_5 = 0.8

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_6 = arg_287_1:GetWordFromCfg(317031068)
				local var_290_7 = arg_287_1:FormatText(var_290_6.content)

				arg_287_1.text_.text = var_290_7

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_9 = 32 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 32)

				if (32 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 32)) > 0 and var_290_5 < var_290_9 then
					arg_287_1.talkMaxDuration = var_290_9

					if var_290_9 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_4
					end
				end

				arg_287_1.text_.text = var_290_7
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031068", "story_v_out_317031.awb") ~= 0 then
					local var_290_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031068", "story_v_out_317031.awb") / 1000

					if var_290_10 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_4
					end

					if var_290_6.prefab_name ~= "" and arg_287_1.actors_[var_290_6.prefab_name] ~= nil then
						local var_290_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_6.prefab_name].transform, "story_v_out_317031", "317031068", "story_v_out_317031.awb")

						arg_287_1:RecordAudio("317031068", var_290_11)
						arg_287_1:RecordAudio("317031068", var_290_11)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_317031", "317031068", "story_v_out_317031.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_317031", "317031068", "story_v_out_317031.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_12 = math.max(var_290_5, arg_287_1.talkMaxDuration)

			if var_290_4 <= arg_287_1.time_ and arg_287_1.time_ < var_290_4 + var_290_12 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_4) / var_290_12

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_4 + var_290_12 and arg_287_1.time_ < var_290_4 + var_290_12 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play317031069 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 317031069
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play317031070(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1015ui_story"]) and arg_291_1.var_.characterEffect1015ui_story == nil then
				arg_291_1.var_.characterEffect1015ui_story = arg_291_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1015ui_story"]) then
				if arg_291_1.var_.characterEffect1015ui_story and not isNil(arg_291_1.actors_["1015ui_story"]) then
					arg_291_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1015ui_story"]) and arg_291_1.var_.characterEffect1015ui_story then
				arg_291_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_294_1 = 0
			local var_294_2 = 0.525

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(317031069).content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 21 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 21)

				if (21 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 21)) > 0 and var_294_2 < var_294_5 then
					arg_291_1.talkMaxDuration = var_294_5

					if var_294_5 + var_294_1 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + var_294_1
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_6 = math.max(var_294_2, arg_291_1.talkMaxDuration)

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_6 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_1) / var_294_6

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_1 + var_294_6 and arg_291_1.time_ < var_294_1 + var_294_6 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play317031070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 317031070
		arg_295_1.duration_ = 7.77

		local var_295_0 = {
			zh = 4.6,
			ja = 7.766
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play317031071(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1015ui_story = arg_295_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1015ui_story"].transform.position).z)
				arg_295_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1015ui_story"].transform.localEulerAngles = arg_295_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_295_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1015ui_story"].transform.position).z)
				arg_295_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1015ui_story"].transform.localEulerAngles = arg_295_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["1015ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1015ui_story == nil then
				arg_295_1.var_.characterEffect1015ui_story = var_298_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 and not isNil(var_298_1) then
				if arg_295_1.var_.characterEffect1015ui_story and not isNil(var_298_1) then
					arg_295_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1015ui_story then
				arg_295_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_298_4 = 0
			local var_298_5 = 0.65

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_6 = arg_295_1:GetWordFromCfg(317031070)
				local var_298_7 = arg_295_1:FormatText(var_298_6.content)

				arg_295_1.text_.text = var_298_7

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_9 = 26 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 26)

				if (26 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 26)) > 0 and var_298_5 < var_298_9 then
					arg_295_1.talkMaxDuration = var_298_9

					if var_298_9 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_4
					end
				end

				arg_295_1.text_.text = var_298_7
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031070", "story_v_out_317031.awb") ~= 0 then
					local var_298_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031070", "story_v_out_317031.awb") / 1000

					if var_298_10 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_4
					end

					if var_298_6.prefab_name ~= "" and arg_295_1.actors_[var_298_6.prefab_name] ~= nil then
						local var_298_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_6.prefab_name].transform, "story_v_out_317031", "317031070", "story_v_out_317031.awb")

						arg_295_1:RecordAudio("317031070", var_298_11)
						arg_295_1:RecordAudio("317031070", var_298_11)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_317031", "317031070", "story_v_out_317031.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_317031", "317031070", "story_v_out_317031.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_12 = math.max(var_298_5, arg_295_1.talkMaxDuration)

			if var_298_4 <= arg_295_1.time_ and arg_295_1.time_ < var_298_4 + var_298_12 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_4) / var_298_12

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_4 + var_298_12 and arg_295_1.time_ < var_298_4 + var_298_12 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play317031071 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 317031071
		arg_299_1.duration_ = 12.37

		local var_299_0 = {
			zh = 8.1,
			ja = 12.366
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play317031072(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 1.1

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:GetWordFromCfg(317031071)
				local var_302_2 = arg_299_1:FormatText(var_302_1.content)

				arg_299_1.text_.text = var_302_2

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 44 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 44)

				if (44 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 44)) > 0 and var_302_0 < var_302_4 then
					arg_299_1.talkMaxDuration = var_302_4

					if var_302_4 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_4 + 0
					end
				end

				arg_299_1.text_.text = var_302_2
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031071", "story_v_out_317031.awb") ~= 0 then
					local var_302_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031071", "story_v_out_317031.awb") / 1000

					if var_302_5 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + 0
					end

					if var_302_1.prefab_name ~= "" and arg_299_1.actors_[var_302_1.prefab_name] ~= nil then
						local var_302_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_1.prefab_name].transform, "story_v_out_317031", "317031071", "story_v_out_317031.awb")

						arg_299_1:RecordAudio("317031071", var_302_6)
						arg_299_1:RecordAudio("317031071", var_302_6)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_317031", "317031071", "story_v_out_317031.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_317031", "317031071", "story_v_out_317031.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play317031072 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 317031072
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play317031073(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1015ui_story"]) and arg_303_1.var_.characterEffect1015ui_story == nil then
				arg_303_1.var_.characterEffect1015ui_story = arg_303_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1015ui_story"]) then
				if arg_303_1.var_.characterEffect1015ui_story and not isNil(arg_303_1.actors_["1015ui_story"]) then
					arg_303_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1015ui_story"]) and arg_303_1.var_.characterEffect1015ui_story then
				arg_303_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.225

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(317031072).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 9 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 9)

				if (9 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 9)) > 0 and var_306_2 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_6 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_6 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_6

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_6 and arg_303_1.time_ < var_306_1 + var_306_6 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play317031073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 317031073
		arg_307_1.duration_ = 9.5

		local var_307_0 = {
			zh = 9.5,
			ja = 8.2
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play317031074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1015ui_story"]) and arg_307_1.var_.characterEffect1015ui_story == nil then
				arg_307_1.var_.characterEffect1015ui_story = arg_307_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1015ui_story"]) then
				if arg_307_1.var_.characterEffect1015ui_story and not isNil(arg_307_1.actors_["1015ui_story"]) then
					arg_307_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1015ui_story"]) and arg_307_1.var_.characterEffect1015ui_story then
				arg_307_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_310_2 = 0
			local var_310_3 = 1.125

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_4 = arg_307_1:GetWordFromCfg(317031073)
				local var_310_5 = arg_307_1:FormatText(var_310_4.content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_7 = 45 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 45)

				if (45 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 45)) > 0 and var_310_3 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031073", "story_v_out_317031.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_out_317031", "317031073", "story_v_out_317031.awb") / 1000

					if var_310_8 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_2
					end

					if var_310_4.prefab_name ~= "" and arg_307_1.actors_[var_310_4.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_4.prefab_name].transform, "story_v_out_317031", "317031073", "story_v_out_317031.awb")

						arg_307_1:RecordAudio("317031073", var_310_9)
						arg_307_1:RecordAudio("317031073", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_317031", "317031073", "story_v_out_317031.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_317031", "317031073", "story_v_out_317031.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_3, arg_307_1.talkMaxDuration)

			if var_310_2 <= arg_307_1.time_ and arg_307_1.time_ < var_310_2 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_2) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_2 + var_310_10 and arg_307_1.time_ < var_310_2 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play317031074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 317031074
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play317031075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1015ui_story"]) and arg_311_1.var_.characterEffect1015ui_story == nil then
				arg_311_1.var_.characterEffect1015ui_story = arg_311_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1015ui_story"]) then
				if arg_311_1.var_.characterEffect1015ui_story and not isNil(arg_311_1.actors_["1015ui_story"]) then
					arg_311_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1015ui_story"]) and arg_311_1.var_.characterEffect1015ui_story then
				arg_311_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 1.1

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(317031074).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 44 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 44)

				if (44 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 44)) > 0 and var_314_2 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_1
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_6 = math.max(var_314_2, arg_311_1.talkMaxDuration)

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_6 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_1) / var_314_6

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_1 + var_314_6 and arg_311_1.time_ < var_314_1 + var_314_6 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play317031075 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 317031075
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play317031076(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.35

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_1 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(317031075).content)

				arg_315_1.text_.text = var_318_1

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_3 = 14 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 14)

				if (14 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 14)) > 0 and var_318_0 < var_318_3 then
					arg_315_1.talkMaxDuration = var_318_3

					if var_318_3 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_3 + 0
					end
				end

				arg_315_1.text_.text = var_318_1
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_4 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_4

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play317031076 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 317031076
		arg_319_1.duration_ = 12.47

		local var_319_0 = {
			zh = 12.466,
			ja = 10.233
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play317031077(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1015ui_story = arg_319_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_322_0 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 then
				arg_319_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_319_1.time_ - 0) / var_322_0)
				arg_319_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1015ui_story"].transform.position).z)
				arg_319_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1015ui_story"].transform.localEulerAngles = arg_319_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 then
				arg_319_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_319_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1015ui_story"].transform.position).z)
				arg_319_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1015ui_story"].transform.localEulerAngles = arg_319_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_322_1 = arg_319_1.actors_["1015ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect1015ui_story == nil then
				arg_319_1.var_.characterEffect1015ui_story = var_322_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_2 and not isNil(var_322_1) then
				if arg_319_1.var_.characterEffect1015ui_story and not isNil(var_322_1) then
					arg_319_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_2 and arg_319_1.time_ < 0 + var_322_2 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect1015ui_story then
				arg_319_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_4 = 0
			local var_322_5 = 1.4

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_6 = arg_319_1:GetWordFromCfg(317031076)
				local var_322_7 = arg_319_1:FormatText(var_322_6.content)

				arg_319_1.text_.text = var_322_7

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_9 = 56 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 56)

				if (56 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 56)) > 0 and var_322_5 < var_322_9 then
					arg_319_1.talkMaxDuration = var_322_9

					if var_322_9 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_7
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031076", "story_v_out_317031.awb") ~= 0 then
					local var_322_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031076", "story_v_out_317031.awb") / 1000

					if var_322_10 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_4
					end

					if var_322_6.prefab_name ~= "" and arg_319_1.actors_[var_322_6.prefab_name] ~= nil then
						local var_322_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_6.prefab_name].transform, "story_v_out_317031", "317031076", "story_v_out_317031.awb")

						arg_319_1:RecordAudio("317031076", var_322_11)
						arg_319_1:RecordAudio("317031076", var_322_11)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_317031", "317031076", "story_v_out_317031.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_317031", "317031076", "story_v_out_317031.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_12 = math.max(var_322_5, arg_319_1.talkMaxDuration)

			if var_322_4 <= arg_319_1.time_ and arg_319_1.time_ < var_322_4 + var_322_12 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_4) / var_322_12

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_4 + var_322_12 and arg_319_1.time_ < var_322_4 + var_322_12 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play317031077 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 317031077
		arg_323_1.duration_ = 6.37

		local var_323_0 = {
			zh = 3.9,
			ja = 6.366
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
				arg_323_0:Play317031078(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1015ui_story = arg_323_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_326_0 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				arg_323_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_0)
				arg_323_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1015ui_story"].transform.position).z)
				arg_323_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1015ui_story"].transform.localEulerAngles = arg_323_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				arg_323_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_323_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1015ui_story"].transform.position).z)
				arg_323_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1015ui_story"].transform.localEulerAngles = arg_323_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_326_1 = arg_323_1.actors_["1015ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1015ui_story == nil then
				arg_323_1.var_.characterEffect1015ui_story = var_326_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_2 and not isNil(var_326_1) then
				if arg_323_1.var_.characterEffect1015ui_story and not isNil(var_326_1) then
					arg_323_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_2)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_2 and arg_323_1.time_ < 0 + var_326_2 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1015ui_story then
				arg_323_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_326_3 = arg_323_1.actors_["1093ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1093ui_story = var_326_3.localPosition
			end

			local var_326_4 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				var_326_3.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_323_1.time_ - 0) / var_326_4)
				var_326_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_3.position).x, (manager.ui.mainCamera.transform.position - var_326_3.position).y, (manager.ui.mainCamera.transform.position - var_326_3.position).z)
				var_326_3.localEulerAngles.z = 0
				var_326_3.localEulerAngles.x = 0
				var_326_3.localEulerAngles = var_326_3.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				var_326_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_326_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_3.position).x, (manager.ui.mainCamera.transform.position - var_326_3.position).y, (manager.ui.mainCamera.transform.position - var_326_3.position).z)
				var_326_3.localEulerAngles.z = 0
				var_326_3.localEulerAngles.x = 0
				var_326_3.localEulerAngles = var_326_3.localEulerAngles
			end

			local var_326_5 = arg_323_1.actors_["1093ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_5) and arg_323_1.var_.characterEffect1093ui_story == nil then
				arg_323_1.var_.characterEffect1093ui_story = var_326_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_6 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_6 and not isNil(var_326_5) then
				if arg_323_1.var_.characterEffect1093ui_story and not isNil(var_326_5) then
					arg_323_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_6 and arg_323_1.time_ < 0 + var_326_6 + arg_326_0 and not isNil(var_326_5) and arg_323_1.var_.characterEffect1093ui_story then
				arg_323_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_326_8 = 0
			local var_326_9 = 0.4

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_8 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_10 = arg_323_1:GetWordFromCfg(317031077)
				local var_326_11 = arg_323_1:FormatText(var_326_10.content)

				arg_323_1.text_.text = var_326_11

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_13 = 16 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 16)

				if (16 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 16)) > 0 and var_326_9 < var_326_13 then
					arg_323_1.talkMaxDuration = var_326_13

					if var_326_13 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_8
					end
				end

				arg_323_1.text_.text = var_326_11
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031077", "story_v_out_317031.awb") ~= 0 then
					local var_326_14 = manager.audio:GetVoiceLength("story_v_out_317031", "317031077", "story_v_out_317031.awb") / 1000

					if var_326_14 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_14 + var_326_8
					end

					if var_326_10.prefab_name ~= "" and arg_323_1.actors_[var_326_10.prefab_name] ~= nil then
						local var_326_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_10.prefab_name].transform, "story_v_out_317031", "317031077", "story_v_out_317031.awb")

						arg_323_1:RecordAudio("317031077", var_326_15)
						arg_323_1:RecordAudio("317031077", var_326_15)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_317031", "317031077", "story_v_out_317031.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_317031", "317031077", "story_v_out_317031.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_16 = math.max(var_326_9, arg_323_1.talkMaxDuration)

			if var_326_8 <= arg_323_1.time_ and arg_323_1.time_ < var_326_8 + var_326_16 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_8) / var_326_16

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_8 + var_326_16 and arg_323_1.time_ < var_326_8 + var_326_16 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play317031078 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 317031078
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play317031079(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1093ui_story"]) and arg_327_1.var_.characterEffect1093ui_story == nil then
				arg_327_1.var_.characterEffect1093ui_story = arg_327_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1093ui_story"]) then
				if arg_327_1.var_.characterEffect1093ui_story and not isNil(arg_327_1.actors_["1093ui_story"]) then
					arg_327_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_0)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1093ui_story"]) and arg_327_1.var_.characterEffect1093ui_story then
				arg_327_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_330_1 = 0
			local var_330_2 = 1.125

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_3 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(317031078).content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 45 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 45)

				if (45 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 45)) > 0 and var_330_2 < var_330_5 then
					arg_327_1.talkMaxDuration = var_330_5

					if var_330_5 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + var_330_1
					end
				end

				arg_327_1.text_.text = var_330_3
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_6 = math.max(var_330_2, arg_327_1.talkMaxDuration)

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_6 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_1) / var_330_6

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_1 + var_330_6 and arg_327_1.time_ < var_330_1 + var_330_6 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play317031079 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 317031079
		arg_331_1.duration_ = 10.57

		local var_331_0 = {
			zh = 8.2,
			ja = 10.566
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
				arg_331_0:Play317031080(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1015ui_story = arg_331_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_334_0 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 then
				arg_331_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_331_1.time_ - 0) / var_334_0)
				arg_331_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1015ui_story"].transform.position).z)
				arg_331_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1015ui_story"].transform.localEulerAngles = arg_331_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_331_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1015ui_story"].transform.position).z)
				arg_331_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1015ui_story"].transform.localEulerAngles = arg_331_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_334_1 = arg_331_1.actors_["1015ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1015ui_story == nil then
				arg_331_1.var_.characterEffect1015ui_story = var_334_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_2 and not isNil(var_334_1) then
				if arg_331_1.var_.characterEffect1015ui_story and not isNil(var_334_1) then
					arg_331_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_2 and arg_331_1.time_ < 0 + var_334_2 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1015ui_story then
				arg_331_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_334_4 = arg_331_1.actors_["1093ui_story"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1093ui_story = var_334_4.localPosition
			end

			local var_334_5 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_5 then
				var_334_4.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_331_1.time_ - 0) / var_334_5)
				var_334_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_4.position).x, (manager.ui.mainCamera.transform.position - var_334_4.position).y, (manager.ui.mainCamera.transform.position - var_334_4.position).z)
				var_334_4.localEulerAngles.z = 0
				var_334_4.localEulerAngles.x = 0
				var_334_4.localEulerAngles = var_334_4.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_5 and arg_331_1.time_ < 0 + var_334_5 + arg_334_0 then
				var_334_4.localPosition = Vector3.New(0, 100, 0)
				var_334_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_4.position).x, (manager.ui.mainCamera.transform.position - var_334_4.position).y, (manager.ui.mainCamera.transform.position - var_334_4.position).z)
				var_334_4.localEulerAngles.z = 0
				var_334_4.localEulerAngles.x = 0
				var_334_4.localEulerAngles = var_334_4.localEulerAngles
			end

			local var_334_6 = 0
			local var_334_7 = 0.975

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_6 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_8 = arg_331_1:GetWordFromCfg(317031079)
				local var_334_9 = arg_331_1:FormatText(var_334_8.content)

				arg_331_1.text_.text = var_334_9

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_11 = 39 <= 0 and var_334_7 or var_334_7 * (utf8.len(var_334_9) / 39)

				if (39 <= 0 and var_334_7 or var_334_7 * (utf8.len(var_334_9) / 39)) > 0 and var_334_7 < var_334_11 then
					arg_331_1.talkMaxDuration = var_334_11

					if var_334_11 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_11 + var_334_6
					end
				end

				arg_331_1.text_.text = var_334_9
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031079", "story_v_out_317031.awb") ~= 0 then
					local var_334_12 = manager.audio:GetVoiceLength("story_v_out_317031", "317031079", "story_v_out_317031.awb") / 1000

					if var_334_12 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_12 + var_334_6
					end

					if var_334_8.prefab_name ~= "" and arg_331_1.actors_[var_334_8.prefab_name] ~= nil then
						local var_334_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_8.prefab_name].transform, "story_v_out_317031", "317031079", "story_v_out_317031.awb")

						arg_331_1:RecordAudio("317031079", var_334_13)
						arg_331_1:RecordAudio("317031079", var_334_13)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_317031", "317031079", "story_v_out_317031.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_317031", "317031079", "story_v_out_317031.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_14 = math.max(var_334_7, arg_331_1.talkMaxDuration)

			if var_334_6 <= arg_331_1.time_ and arg_331_1.time_ < var_334_6 + var_334_14 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_6) / var_334_14

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_6 + var_334_14 and arg_331_1.time_ < var_334_6 + var_334_14 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play317031080 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 317031080
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play317031081(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1015ui_story"]) and arg_335_1.var_.characterEffect1015ui_story == nil then
				arg_335_1.var_.characterEffect1015ui_story = arg_335_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1015ui_story"]) then
				if arg_335_1.var_.characterEffect1015ui_story and not isNil(arg_335_1.actors_["1015ui_story"]) then
					arg_335_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_0)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1015ui_story"]) and arg_335_1.var_.characterEffect1015ui_story then
				arg_335_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_338_1 = 0
			local var_338_2 = 0.25

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(317031080).content)

				arg_335_1.text_.text = var_338_3

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 10 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 10)

				if (10 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 10)) > 0 and var_338_2 < var_338_5 then
					arg_335_1.talkMaxDuration = var_338_5

					if var_338_5 + var_338_1 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + var_338_1
					end
				end

				arg_335_1.text_.text = var_338_3
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_6 = math.max(var_338_2, arg_335_1.talkMaxDuration)

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_6 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_1) / var_338_6

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_1 + var_338_6 and arg_335_1.time_ < var_338_1 + var_338_6 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play317031081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 317031081
		arg_339_1.duration_ = 1.63

		local var_339_0 = {
			zh = 1.633,
			ja = 0.999999999999
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
				arg_339_0:Play317031082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1015ui_story = arg_339_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1015ui_story"].transform.position).z)
				arg_339_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1015ui_story"].transform.localEulerAngles = arg_339_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_339_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1015ui_story"].transform.position).z)
				arg_339_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1015ui_story"].transform.localEulerAngles = arg_339_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_342_1 = arg_339_1.actors_["1015ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1015ui_story == nil then
				arg_339_1.var_.characterEffect1015ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect1015ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1015ui_story then
				arg_339_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_342_4 = 0
			local var_342_5 = 0.2

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(317031081)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 8 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 8)

				if (8 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 8)) > 0 and var_342_5 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031081", "story_v_out_317031.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031081", "story_v_out_317031.awb") / 1000

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end

					if var_342_6.prefab_name ~= "" and arg_339_1.actors_[var_342_6.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_6.prefab_name].transform, "story_v_out_317031", "317031081", "story_v_out_317031.awb")

						arg_339_1:RecordAudio("317031081", var_342_11)
						arg_339_1:RecordAudio("317031081", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_317031", "317031081", "story_v_out_317031.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_317031", "317031081", "story_v_out_317031.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_12 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_12 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_12

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_12 and arg_339_1.time_ < var_342_4 + var_342_12 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play317031082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 317031082
		arg_343_1.duration_ = 11.67

		local var_343_0 = {
			zh = 11.3,
			ja = 11.666
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
				arg_343_0:Play317031083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 1.45

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_1 = arg_343_1:GetWordFromCfg(317031082)
				local var_346_2 = arg_343_1:FormatText(var_346_1.content)

				arg_343_1.text_.text = var_346_2

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 58 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 58)

				if (58 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 58)) > 0 and var_346_0 < var_346_4 then
					arg_343_1.talkMaxDuration = var_346_4

					if var_346_4 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_4 + 0
					end
				end

				arg_343_1.text_.text = var_346_2
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031082", "story_v_out_317031.awb") ~= 0 then
					local var_346_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031082", "story_v_out_317031.awb") / 1000

					if var_346_5 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + 0
					end

					if var_346_1.prefab_name ~= "" and arg_343_1.actors_[var_346_1.prefab_name] ~= nil then
						local var_346_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_1.prefab_name].transform, "story_v_out_317031", "317031082", "story_v_out_317031.awb")

						arg_343_1:RecordAudio("317031082", var_346_6)
						arg_343_1:RecordAudio("317031082", var_346_6)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_317031", "317031082", "story_v_out_317031.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_317031", "317031082", "story_v_out_317031.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_7 and arg_343_1.time_ < 0 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play317031083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 317031083
		arg_347_1.duration_ = 8.13

		local var_347_0 = {
			zh = 7.233,
			ja = 8.133
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
				arg_347_0:Play317031084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos1015ui_story = arg_347_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_350_0 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 then
				arg_347_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_347_1.time_ - 0) / var_350_0)
				arg_347_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1015ui_story"].transform.position).z)
				arg_347_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["1015ui_story"].transform.localEulerAngles = arg_347_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 then
				arg_347_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_347_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1015ui_story"].transform.position).z)
				arg_347_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["1015ui_story"].transform.localEulerAngles = arg_347_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_350_1 = arg_347_1.actors_["1015ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_1) and arg_347_1.var_.characterEffect1015ui_story == nil then
				arg_347_1.var_.characterEffect1015ui_story = var_350_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_2 and not isNil(var_350_1) then
				if arg_347_1.var_.characterEffect1015ui_story and not isNil(var_350_1) then
					arg_347_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_2 and arg_347_1.time_ < 0 + var_350_2 + arg_350_0 and not isNil(var_350_1) and arg_347_1.var_.characterEffect1015ui_story then
				arg_347_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_350_4 = 0
			local var_350_5 = 1.025

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_4 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_6 = arg_347_1:GetWordFromCfg(317031083)
				local var_350_7 = arg_347_1:FormatText(var_350_6.content)

				arg_347_1.text_.text = var_350_7

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_9 = 41 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 41)

				if (41 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 41)) > 0 and var_350_5 < var_350_9 then
					arg_347_1.talkMaxDuration = var_350_9

					if var_350_9 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_9 + var_350_4
					end
				end

				arg_347_1.text_.text = var_350_7
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031083", "story_v_out_317031.awb") ~= 0 then
					local var_350_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031083", "story_v_out_317031.awb") / 1000

					if var_350_10 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_4
					end

					if var_350_6.prefab_name ~= "" and arg_347_1.actors_[var_350_6.prefab_name] ~= nil then
						local var_350_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_6.prefab_name].transform, "story_v_out_317031", "317031083", "story_v_out_317031.awb")

						arg_347_1:RecordAudio("317031083", var_350_11)
						arg_347_1:RecordAudio("317031083", var_350_11)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_317031", "317031083", "story_v_out_317031.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_317031", "317031083", "story_v_out_317031.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_12 = math.max(var_350_5, arg_347_1.talkMaxDuration)

			if var_350_4 <= arg_347_1.time_ and arg_347_1.time_ < var_350_4 + var_350_12 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_4) / var_350_12

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_4 + var_350_12 and arg_347_1.time_ < var_350_4 + var_350_12 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play317031084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 317031084
		arg_351_1.duration_ = 7.83

		local var_351_0 = {
			zh = 7.833,
			ja = 6.966
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
				arg_351_0:Play317031085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 1.075

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:GetWordFromCfg(317031084)
				local var_354_2 = arg_351_1:FormatText(var_354_1.content)

				arg_351_1.text_.text = var_354_2

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 43 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 43)

				if (43 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 43)) > 0 and var_354_0 < var_354_4 then
					arg_351_1.talkMaxDuration = var_354_4

					if var_354_4 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_4 + 0
					end
				end

				arg_351_1.text_.text = var_354_2
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031084", "story_v_out_317031.awb") ~= 0 then
					local var_354_5 = manager.audio:GetVoiceLength("story_v_out_317031", "317031084", "story_v_out_317031.awb") / 1000

					if var_354_5 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + 0
					end

					if var_354_1.prefab_name ~= "" and arg_351_1.actors_[var_354_1.prefab_name] ~= nil then
						local var_354_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_1.prefab_name].transform, "story_v_out_317031", "317031084", "story_v_out_317031.awb")

						arg_351_1:RecordAudio("317031084", var_354_6)
						arg_351_1:RecordAudio("317031084", var_354_6)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_317031", "317031084", "story_v_out_317031.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_317031", "317031084", "story_v_out_317031.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_7 and arg_351_1.time_ < 0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play317031085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 317031085
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play317031086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.325

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_1 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(317031085).content)

				arg_355_1.text_.text = var_358_1

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_3 = 13 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 13)

				if (13 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 13)) > 0 and var_358_0 < var_358_3 then
					arg_355_1.talkMaxDuration = var_358_3

					if var_358_3 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_3 + 0
					end
				end

				arg_355_1.text_.text = var_358_1
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_4 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_4

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play317031086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 317031086
		arg_359_1.duration_ = 8.27

		local var_359_0 = {
			zh = 8.266,
			ja = 6.133
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
				arg_359_0:Play317031087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1015ui_story = arg_359_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1015ui_story"].transform.position).z)
				arg_359_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1015ui_story"].transform.localEulerAngles = arg_359_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_359_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1015ui_story"].transform.position).z)
				arg_359_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1015ui_story"].transform.localEulerAngles = arg_359_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_362_1 = arg_359_1.actors_["1015ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1015ui_story == nil then
				arg_359_1.var_.characterEffect1015ui_story = var_362_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 and not isNil(var_362_1) then
				if arg_359_1.var_.characterEffect1015ui_story and not isNil(var_362_1) then
					arg_359_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1015ui_story then
				arg_359_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_362_4 = 0
			local var_362_5 = 1.125

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_6 = arg_359_1:GetWordFromCfg(317031086)
				local var_362_7 = arg_359_1:FormatText(var_362_6.content)

				arg_359_1.text_.text = var_362_7

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_9 = 45 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 45)

				if (45 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 45)) > 0 and var_362_5 < var_362_9 then
					arg_359_1.talkMaxDuration = var_362_9

					if var_362_9 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_9 + var_362_4
					end
				end

				arg_359_1.text_.text = var_362_7
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031086", "story_v_out_317031.awb") ~= 0 then
					local var_362_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031086", "story_v_out_317031.awb") / 1000

					if var_362_10 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_4
					end

					if var_362_6.prefab_name ~= "" and arg_359_1.actors_[var_362_6.prefab_name] ~= nil then
						local var_362_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_6.prefab_name].transform, "story_v_out_317031", "317031086", "story_v_out_317031.awb")

						arg_359_1:RecordAudio("317031086", var_362_11)
						arg_359_1:RecordAudio("317031086", var_362_11)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_317031", "317031086", "story_v_out_317031.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_317031", "317031086", "story_v_out_317031.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_12 = math.max(var_362_5, arg_359_1.talkMaxDuration)

			if var_362_4 <= arg_359_1.time_ and arg_359_1.time_ < var_362_4 + var_362_12 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_4) / var_362_12

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_4 + var_362_12 and arg_359_1.time_ < var_362_4 + var_362_12 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play317031087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 317031087
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play317031088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1015ui_story"]) and arg_363_1.var_.characterEffect1015ui_story == nil then
				arg_363_1.var_.characterEffect1015ui_story = arg_363_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1015ui_story"]) then
				if arg_363_1.var_.characterEffect1015ui_story and not isNil(arg_363_1.actors_["1015ui_story"]) then
					arg_363_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_0)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1015ui_story"]) and arg_363_1.var_.characterEffect1015ui_story then
				arg_363_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_366_1 = 0
			local var_366_2 = 0.125

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(317031087).content)

				arg_363_1.text_.text = var_366_3

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 5 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_3) / 5)

				if (5 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_3) / 5)) > 0 and var_366_2 < var_366_5 then
					arg_363_1.talkMaxDuration = var_366_5

					if var_366_5 + var_366_1 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + var_366_1
					end
				end

				arg_363_1.text_.text = var_366_3
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_6 = math.max(var_366_2, arg_363_1.talkMaxDuration)

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_6 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_1) / var_366_6

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_1 + var_366_6 and arg_363_1.time_ < var_366_1 + var_366_6 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play317031088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 317031088
		arg_367_1.duration_ = 5.77

		local var_367_0 = {
			zh = 3.666,
			ja = 5.766
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
				arg_367_0:Play317031089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["1015ui_story"]) and arg_367_1.var_.characterEffect1015ui_story == nil then
				arg_367_1.var_.characterEffect1015ui_story = arg_367_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["1015ui_story"]) then
				if arg_367_1.var_.characterEffect1015ui_story and not isNil(arg_367_1.actors_["1015ui_story"]) then
					arg_367_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["1015ui_story"]) and arg_367_1.var_.characterEffect1015ui_story then
				arg_367_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_370_2 = 0
			local var_370_3 = 0.375

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_2 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_4 = arg_367_1:GetWordFromCfg(317031088)
				local var_370_5 = arg_367_1:FormatText(var_370_4.content)

				arg_367_1.text_.text = var_370_5

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_7 = 15 <= 0 and var_370_3 or var_370_3 * (utf8.len(var_370_5) / 15)

				if (15 <= 0 and var_370_3 or var_370_3 * (utf8.len(var_370_5) / 15)) > 0 and var_370_3 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_2 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_2
					end
				end

				arg_367_1.text_.text = var_370_5
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031088", "story_v_out_317031.awb") ~= 0 then
					local var_370_8 = manager.audio:GetVoiceLength("story_v_out_317031", "317031088", "story_v_out_317031.awb") / 1000

					if var_370_8 + var_370_2 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_8 + var_370_2
					end

					if var_370_4.prefab_name ~= "" and arg_367_1.actors_[var_370_4.prefab_name] ~= nil then
						local var_370_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_4.prefab_name].transform, "story_v_out_317031", "317031088", "story_v_out_317031.awb")

						arg_367_1:RecordAudio("317031088", var_370_9)
						arg_367_1:RecordAudio("317031088", var_370_9)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_317031", "317031088", "story_v_out_317031.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_317031", "317031088", "story_v_out_317031.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_10 = math.max(var_370_3, arg_367_1.talkMaxDuration)

			if var_370_2 <= arg_367_1.time_ and arg_367_1.time_ < var_370_2 + var_370_10 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_2) / var_370_10

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_2 + var_370_10 and arg_367_1.time_ < var_370_2 + var_370_10 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play317031089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 317031089
		arg_371_1.duration_ = 0.5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"

			SetActive(arg_371_1.choicesGo_, true)

			for iter_372_0, iter_372_1 in ipairs(arg_371_1.choices_) do
				SetActive(iter_372_1.go, iter_372_0 <= 1)
			end

			arg_371_1.choices_[1].txt.text = arg_371_1:FormatText(StoryChoiceCfg[523].name)
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play317031090(arg_371_1)
			end

			arg_371_1:RecordChoiceLog(317031089, 523)
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["1015ui_story"]) and arg_371_1.var_.characterEffect1015ui_story == nil then
				arg_371_1.var_.characterEffect1015ui_story = arg_371_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["1015ui_story"]) then
				if arg_371_1.var_.characterEffect1015ui_story and not isNil(arg_371_1.actors_["1015ui_story"]) then
					arg_371_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_0)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["1015ui_story"]) and arg_371_1.var_.characterEffect1015ui_story then
				arg_371_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_374_1 = 0

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.allBtn_.enabled = false
			end

			if arg_371_1.time_ >= var_374_1 + 0.5 and arg_371_1.time_ < var_374_1 + 0.5 + arg_374_0 then
				arg_371_1.allBtn_.enabled = true
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play317031090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 317031090
		arg_375_1.duration_ = 8.13

		local var_375_0 = {
			zh = 8.133,
			ja = 6.1
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
				arg_375_0:Play317031091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["1015ui_story"]) and arg_375_1.var_.characterEffect1015ui_story == nil then
				arg_375_1.var_.characterEffect1015ui_story = arg_375_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_0 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["1015ui_story"]) then
				if arg_375_1.var_.characterEffect1015ui_story and not isNil(arg_375_1.actors_["1015ui_story"]) then
					arg_375_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["1015ui_story"]) and arg_375_1.var_.characterEffect1015ui_story then
				arg_375_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_378_2 = 0
			local var_378_3 = 1

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_2 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_4 = arg_375_1:GetWordFromCfg(317031090)
				local var_378_5 = arg_375_1:FormatText(var_378_4.content)

				arg_375_1.text_.text = var_378_5

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_7 = 40 <= 0 and var_378_3 or var_378_3 * (utf8.len(var_378_5) / 40)

				if (40 <= 0 and var_378_3 or var_378_3 * (utf8.len(var_378_5) / 40)) > 0 and var_378_3 < var_378_7 then
					arg_375_1.talkMaxDuration = var_378_7

					if var_378_7 + var_378_2 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_7 + var_378_2
					end
				end

				arg_375_1.text_.text = var_378_5
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031090", "story_v_out_317031.awb") ~= 0 then
					local var_378_8 = manager.audio:GetVoiceLength("story_v_out_317031", "317031090", "story_v_out_317031.awb") / 1000

					if var_378_8 + var_378_2 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_8 + var_378_2
					end

					if var_378_4.prefab_name ~= "" and arg_375_1.actors_[var_378_4.prefab_name] ~= nil then
						local var_378_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_4.prefab_name].transform, "story_v_out_317031", "317031090", "story_v_out_317031.awb")

						arg_375_1:RecordAudio("317031090", var_378_9)
						arg_375_1:RecordAudio("317031090", var_378_9)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_317031", "317031090", "story_v_out_317031.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_317031", "317031090", "story_v_out_317031.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_10 = math.max(var_378_3, arg_375_1.talkMaxDuration)

			if var_378_2 <= arg_375_1.time_ and arg_375_1.time_ < var_378_2 + var_378_10 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_2) / var_378_10

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_2 + var_378_10 and arg_375_1.time_ < var_378_2 + var_378_10 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play317031091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 317031091
		arg_379_1.duration_ = 6.2

		local var_379_0 = {
			zh = 6.2,
			ja = 5.266
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
				arg_379_0:Play317031092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["1015ui_story"]) and arg_379_1.var_.characterEffect1015ui_story == nil then
				arg_379_1.var_.characterEffect1015ui_story = arg_379_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["1015ui_story"]) then
				if arg_379_1.var_.characterEffect1015ui_story and not isNil(arg_379_1.actors_["1015ui_story"]) then
					arg_379_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["1015ui_story"]) and arg_379_1.var_.characterEffect1015ui_story then
				arg_379_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_382_2 = 0
			local var_382_3 = 0.825

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_2 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_4 = arg_379_1:GetWordFromCfg(317031091)
				local var_382_5 = arg_379_1:FormatText(var_382_4.content)

				arg_379_1.text_.text = var_382_5

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_7 = 33 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_5) / 33)

				if (33 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_5) / 33)) > 0 and var_382_3 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_2 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_2
					end
				end

				arg_379_1.text_.text = var_382_5
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031091", "story_v_out_317031.awb") ~= 0 then
					local var_382_8 = manager.audio:GetVoiceLength("story_v_out_317031", "317031091", "story_v_out_317031.awb") / 1000

					if var_382_8 + var_382_2 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_8 + var_382_2
					end

					if var_382_4.prefab_name ~= "" and arg_379_1.actors_[var_382_4.prefab_name] ~= nil then
						local var_382_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_4.prefab_name].transform, "story_v_out_317031", "317031091", "story_v_out_317031.awb")

						arg_379_1:RecordAudio("317031091", var_382_9)
						arg_379_1:RecordAudio("317031091", var_382_9)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_317031", "317031091", "story_v_out_317031.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_317031", "317031091", "story_v_out_317031.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_10 = math.max(var_382_3, arg_379_1.talkMaxDuration)

			if var_382_2 <= arg_379_1.time_ and arg_379_1.time_ < var_382_2 + var_382_10 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_2) / var_382_10

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_2 + var_382_10 and arg_379_1.time_ < var_382_2 + var_382_10 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play317031092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 317031092
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play317031093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1015ui_story"]) and arg_383_1.var_.characterEffect1015ui_story == nil then
				arg_383_1.var_.characterEffect1015ui_story = arg_383_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1015ui_story"]) then
				if arg_383_1.var_.characterEffect1015ui_story and not isNil(arg_383_1.actors_["1015ui_story"]) then
					arg_383_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_0)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1015ui_story"]) and arg_383_1.var_.characterEffect1015ui_story then
				arg_383_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_386_1 = 0
			local var_386_2 = 0.225

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_3 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(317031092).content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 9 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 9)

				if (9 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 9)) > 0 and var_386_2 < var_386_5 then
					arg_383_1.talkMaxDuration = var_386_5

					if var_386_5 + var_386_1 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + var_386_1
					end
				end

				arg_383_1.text_.text = var_386_3
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_6 = math.max(var_386_2, arg_383_1.talkMaxDuration)

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_6 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_1) / var_386_6

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_1 + var_386_6 and arg_383_1.time_ < var_386_1 + var_386_6 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play317031093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 317031093
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play317031094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.425

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(317031093).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 17 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 17)

				if (17 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 17)) > 0 and var_390_0 < var_390_3 then
					arg_387_1.talkMaxDuration = var_390_3

					if var_390_3 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_3 + 0
					end
				end

				arg_387_1.text_.text = var_390_1
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_4 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_4

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play317031094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 317031094
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play317031095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.225

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_1 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(317031094).content)

				arg_391_1.text_.text = var_394_1

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_3 = 9 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 9)

				if (9 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 9)) > 0 and var_394_0 < var_394_3 then
					arg_391_1.talkMaxDuration = var_394_3

					if var_394_3 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_3 + 0
					end
				end

				arg_391_1.text_.text = var_394_1
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_4 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_4 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_4

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_4 and arg_391_1.time_ < 0 + var_394_4 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play317031095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 317031095
		arg_395_1.duration_ = 14.97

		local var_395_0 = {
			zh = 13.2,
			ja = 14.966
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
				arg_395_0:Play317031096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["1015ui_story"]) and arg_395_1.var_.characterEffect1015ui_story == nil then
				arg_395_1.var_.characterEffect1015ui_story = arg_395_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_0 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["1015ui_story"]) then
				if arg_395_1.var_.characterEffect1015ui_story and not isNil(arg_395_1.actors_["1015ui_story"]) then
					arg_395_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["1015ui_story"]) and arg_395_1.var_.characterEffect1015ui_story then
				arg_395_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_398_2 = 0
			local var_398_3 = 1.725

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_2 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_4 = arg_395_1:GetWordFromCfg(317031095)
				local var_398_5 = arg_395_1:FormatText(var_398_4.content)

				arg_395_1.text_.text = var_398_5

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_7 = 69 <= 0 and var_398_3 or var_398_3 * (utf8.len(var_398_5) / 69)

				if (69 <= 0 and var_398_3 or var_398_3 * (utf8.len(var_398_5) / 69)) > 0 and var_398_3 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_2
					end
				end

				arg_395_1.text_.text = var_398_5
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031095", "story_v_out_317031.awb") ~= 0 then
					local var_398_8 = manager.audio:GetVoiceLength("story_v_out_317031", "317031095", "story_v_out_317031.awb") / 1000

					if var_398_8 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_8 + var_398_2
					end

					if var_398_4.prefab_name ~= "" and arg_395_1.actors_[var_398_4.prefab_name] ~= nil then
						local var_398_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_4.prefab_name].transform, "story_v_out_317031", "317031095", "story_v_out_317031.awb")

						arg_395_1:RecordAudio("317031095", var_398_9)
						arg_395_1:RecordAudio("317031095", var_398_9)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_317031", "317031095", "story_v_out_317031.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_317031", "317031095", "story_v_out_317031.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_10 = math.max(var_398_3, arg_395_1.talkMaxDuration)

			if var_398_2 <= arg_395_1.time_ and arg_395_1.time_ < var_398_2 + var_398_10 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_2) / var_398_10

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_2 + var_398_10 and arg_395_1.time_ < var_398_2 + var_398_10 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play317031096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 317031096
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play317031097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1015ui_story"]) and arg_399_1.var_.characterEffect1015ui_story == nil then
				arg_399_1.var_.characterEffect1015ui_story = arg_399_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1015ui_story"]) then
				if arg_399_1.var_.characterEffect1015ui_story and not isNil(arg_399_1.actors_["1015ui_story"]) then
					arg_399_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 0) / var_402_0)
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1015ui_story"]) and arg_399_1.var_.characterEffect1015ui_story then
				arg_399_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_402_1 = 0
			local var_402_2 = 0.475

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_3 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(317031096).content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 19 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 19)

				if (19 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 19)) > 0 and var_402_2 < var_402_5 then
					arg_399_1.talkMaxDuration = var_402_5

					if var_402_5 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + var_402_1
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_6 = math.max(var_402_2, arg_399_1.talkMaxDuration)

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_6 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_1) / var_402_6

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_1 + var_402_6 and arg_399_1.time_ < var_402_1 + var_402_6 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play317031097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 317031097
		arg_403_1.duration_ = 11.2

		local var_403_0 = {
			zh = 11.2,
			ja = 7.566
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
				arg_403_0:Play317031098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["1015ui_story"]) and arg_403_1.var_.characterEffect1015ui_story == nil then
				arg_403_1.var_.characterEffect1015ui_story = arg_403_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_0 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["1015ui_story"]) then
				if arg_403_1.var_.characterEffect1015ui_story and not isNil(arg_403_1.actors_["1015ui_story"]) then
					arg_403_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["1015ui_story"]) and arg_403_1.var_.characterEffect1015ui_story then
				arg_403_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action3_1")
			end

			local var_406_2 = 0
			local var_406_3 = 1.5

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_2 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_4 = arg_403_1:GetWordFromCfg(317031097)
				local var_406_5 = arg_403_1:FormatText(var_406_4.content)

				arg_403_1.text_.text = var_406_5

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_7 = 60 <= 0 and var_406_3 or var_406_3 * (utf8.len(var_406_5) / 60)

				if (60 <= 0 and var_406_3 or var_406_3 * (utf8.len(var_406_5) / 60)) > 0 and var_406_3 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_2 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_2
					end
				end

				arg_403_1.text_.text = var_406_5
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031097", "story_v_out_317031.awb") ~= 0 then
					local var_406_8 = manager.audio:GetVoiceLength("story_v_out_317031", "317031097", "story_v_out_317031.awb") / 1000

					if var_406_8 + var_406_2 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_2
					end

					if var_406_4.prefab_name ~= "" and arg_403_1.actors_[var_406_4.prefab_name] ~= nil then
						local var_406_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_4.prefab_name].transform, "story_v_out_317031", "317031097", "story_v_out_317031.awb")

						arg_403_1:RecordAudio("317031097", var_406_9)
						arg_403_1:RecordAudio("317031097", var_406_9)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_317031", "317031097", "story_v_out_317031.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_317031", "317031097", "story_v_out_317031.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_10 = math.max(var_406_3, arg_403_1.talkMaxDuration)

			if var_406_2 <= arg_403_1.time_ and arg_403_1.time_ < var_406_2 + var_406_10 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_2) / var_406_10

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_2 + var_406_10 and arg_403_1.time_ < var_406_2 + var_406_10 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play317031098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 317031098
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play317031099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["1015ui_story"]) and arg_407_1.var_.characterEffect1015ui_story == nil then
				arg_407_1.var_.characterEffect1015ui_story = arg_407_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_0 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["1015ui_story"]) then
				if arg_407_1.var_.characterEffect1015ui_story and not isNil(arg_407_1.actors_["1015ui_story"]) then
					arg_407_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_0)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["1015ui_story"]) and arg_407_1.var_.characterEffect1015ui_story then
				arg_407_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_410_1 = 0
			local var_410_2 = 0.075

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_3 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(317031098).content)

				arg_407_1.text_.text = var_410_3

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 3 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 3)

				if (3 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 3)) > 0 and var_410_2 < var_410_5 then
					arg_407_1.talkMaxDuration = var_410_5

					if var_410_5 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + var_410_1
					end
				end

				arg_407_1.text_.text = var_410_3
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_6 = math.max(var_410_2, arg_407_1.talkMaxDuration)

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_6 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_1) / var_410_6

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_1 + var_410_6 and arg_407_1.time_ < var_410_1 + var_410_6 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play317031099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 317031099
		arg_411_1.duration_ = 9.3

		local var_411_0 = {
			zh = 4.933,
			ja = 9.3
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
				arg_411_0:Play317031100(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos1015ui_story = arg_411_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_414_0 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 then
				arg_411_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_411_1.time_ - 0) / var_414_0)
				arg_411_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1015ui_story"].transform.position).z)
				arg_411_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1015ui_story"].transform.localEulerAngles = arg_411_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 then
				arg_411_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_411_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1015ui_story"].transform.position).z)
				arg_411_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1015ui_story"].transform.localEulerAngles = arg_411_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_414_1 = arg_411_1.actors_["1015ui_story"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1015ui_story == nil then
				arg_411_1.var_.characterEffect1015ui_story = var_414_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_2 and not isNil(var_414_1) then
				if arg_411_1.var_.characterEffect1015ui_story and not isNil(var_414_1) then
					arg_411_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_411_1.time_ - 0) / var_414_2)
				end
			end

			if arg_411_1.time_ >= 0 + var_414_2 and arg_411_1.time_ < 0 + var_414_2 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1015ui_story then
				arg_411_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_414_3 = arg_411_1.actors_["1093ui_story"].transform

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos1093ui_story = var_414_3.localPosition
			end

			local var_414_4 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				var_414_3.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_411_1.time_ - 0) / var_414_4)
				var_414_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_414_3.position).x, (manager.ui.mainCamera.transform.position - var_414_3.position).y, (manager.ui.mainCamera.transform.position - var_414_3.position).z)
				var_414_3.localEulerAngles.z = 0
				var_414_3.localEulerAngles.x = 0
				var_414_3.localEulerAngles = var_414_3.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				var_414_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_414_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_414_3.position).x, (manager.ui.mainCamera.transform.position - var_414_3.position).y, (manager.ui.mainCamera.transform.position - var_414_3.position).z)
				var_414_3.localEulerAngles.z = 0
				var_414_3.localEulerAngles.x = 0
				var_414_3.localEulerAngles = var_414_3.localEulerAngles
			end

			local var_414_5 = arg_411_1.actors_["1093ui_story"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_5) and arg_411_1.var_.characterEffect1093ui_story == nil then
				arg_411_1.var_.characterEffect1093ui_story = var_414_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_6 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_6 and not isNil(var_414_5) then
				if arg_411_1.var_.characterEffect1093ui_story and not isNil(var_414_5) then
					arg_411_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= 0 + var_414_6 and arg_411_1.time_ < 0 + var_414_6 + arg_414_0 and not isNil(var_414_5) and arg_411_1.var_.characterEffect1093ui_story then
				arg_411_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_414_8 = 0
			local var_414_9 = 0.625

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_8 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_10 = arg_411_1:GetWordFromCfg(317031099)
				local var_414_11 = arg_411_1:FormatText(var_414_10.content)

				arg_411_1.text_.text = var_414_11

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_13 = 25 <= 0 and var_414_9 or var_414_9 * (utf8.len(var_414_11) / 25)

				if (25 <= 0 and var_414_9 or var_414_9 * (utf8.len(var_414_11) / 25)) > 0 and var_414_9 < var_414_13 then
					arg_411_1.talkMaxDuration = var_414_13

					if var_414_13 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_13 + var_414_8
					end
				end

				arg_411_1.text_.text = var_414_11
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031099", "story_v_out_317031.awb") ~= 0 then
					local var_414_14 = manager.audio:GetVoiceLength("story_v_out_317031", "317031099", "story_v_out_317031.awb") / 1000

					if var_414_14 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_14 + var_414_8
					end

					if var_414_10.prefab_name ~= "" and arg_411_1.actors_[var_414_10.prefab_name] ~= nil then
						local var_414_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_10.prefab_name].transform, "story_v_out_317031", "317031099", "story_v_out_317031.awb")

						arg_411_1:RecordAudio("317031099", var_414_15)
						arg_411_1:RecordAudio("317031099", var_414_15)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_317031", "317031099", "story_v_out_317031.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_317031", "317031099", "story_v_out_317031.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_16 = math.max(var_414_9, arg_411_1.talkMaxDuration)

			if var_414_8 <= arg_411_1.time_ and arg_411_1.time_ < var_414_8 + var_414_16 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_8) / var_414_16

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_8 + var_414_16 and arg_411_1.time_ < var_414_8 + var_414_16 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play317031100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 317031100
		arg_415_1.duration_ = 9.7

		local var_415_0 = {
			zh = 9.566,
			ja = 9.7
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
				arg_415_0:Play317031101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos1015ui_story = arg_415_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_418_0 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 then
				arg_415_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_415_1.time_ - 0) / var_418_0)
				arg_415_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1015ui_story"].transform.position).z)
				arg_415_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["1015ui_story"].transform.localEulerAngles = arg_415_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 then
				arg_415_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_415_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1015ui_story"].transform.position).z)
				arg_415_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["1015ui_story"].transform.localEulerAngles = arg_415_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_418_1 = arg_415_1.actors_["1015ui_story"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect1015ui_story == nil then
				arg_415_1.var_.characterEffect1015ui_story = var_418_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_2 and not isNil(var_418_1) then
				if arg_415_1.var_.characterEffect1015ui_story and not isNil(var_418_1) then
					arg_415_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= 0 + var_418_2 and arg_415_1.time_ < 0 + var_418_2 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect1015ui_story then
				arg_415_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_418_4 = arg_415_1.actors_["1093ui_story"].transform

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos1093ui_story = var_418_4.localPosition
			end

			local var_418_5 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_5 then
				var_418_4.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_415_1.time_ - 0) / var_418_5)
				var_418_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_418_4.position).x, (manager.ui.mainCamera.transform.position - var_418_4.position).y, (manager.ui.mainCamera.transform.position - var_418_4.position).z)
				var_418_4.localEulerAngles.z = 0
				var_418_4.localEulerAngles.x = 0
				var_418_4.localEulerAngles = var_418_4.localEulerAngles
			end

			if arg_415_1.time_ >= 0 + var_418_5 and arg_415_1.time_ < 0 + var_418_5 + arg_418_0 then
				var_418_4.localPosition = Vector3.New(0, 100, 0)
				var_418_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_418_4.position).x, (manager.ui.mainCamera.transform.position - var_418_4.position).y, (manager.ui.mainCamera.transform.position - var_418_4.position).z)
				var_418_4.localEulerAngles.z = 0
				var_418_4.localEulerAngles.x = 0
				var_418_4.localEulerAngles = var_418_4.localEulerAngles
			end

			local var_418_6 = arg_415_1.actors_["1093ui_story"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_6) and arg_415_1.var_.characterEffect1093ui_story == nil then
				arg_415_1.var_.characterEffect1093ui_story = var_418_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_7 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_7 and not isNil(var_418_6) then
				if arg_415_1.var_.characterEffect1093ui_story and not isNil(var_418_6) then
					arg_415_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0) / var_418_7)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_7 and arg_415_1.time_ < 0 + var_418_7 + arg_418_0 and not isNil(var_418_6) and arg_415_1.var_.characterEffect1093ui_story then
				arg_415_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_418_8 = 0
			local var_418_9 = 1.3

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_8 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_10 = arg_415_1:GetWordFromCfg(317031100)
				local var_418_11 = arg_415_1:FormatText(var_418_10.content)

				arg_415_1.text_.text = var_418_11

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_13 = 52 <= 0 and var_418_9 or var_418_9 * (utf8.len(var_418_11) / 52)

				if (52 <= 0 and var_418_9 or var_418_9 * (utf8.len(var_418_11) / 52)) > 0 and var_418_9 < var_418_13 then
					arg_415_1.talkMaxDuration = var_418_13

					if var_418_13 + var_418_8 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_13 + var_418_8
					end
				end

				arg_415_1.text_.text = var_418_11
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031100", "story_v_out_317031.awb") ~= 0 then
					local var_418_14 = manager.audio:GetVoiceLength("story_v_out_317031", "317031100", "story_v_out_317031.awb") / 1000

					if var_418_14 + var_418_8 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_14 + var_418_8
					end

					if var_418_10.prefab_name ~= "" and arg_415_1.actors_[var_418_10.prefab_name] ~= nil then
						local var_418_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_10.prefab_name].transform, "story_v_out_317031", "317031100", "story_v_out_317031.awb")

						arg_415_1:RecordAudio("317031100", var_418_15)
						arg_415_1:RecordAudio("317031100", var_418_15)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_317031", "317031100", "story_v_out_317031.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_317031", "317031100", "story_v_out_317031.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_16 = math.max(var_418_9, arg_415_1.talkMaxDuration)

			if var_418_8 <= arg_415_1.time_ and arg_415_1.time_ < var_418_8 + var_418_16 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_8) / var_418_16

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_8 + var_418_16 and arg_415_1.time_ < var_418_8 + var_418_16 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play317031101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 317031101
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play317031102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["1015ui_story"]) and arg_419_1.var_.characterEffect1015ui_story == nil then
				arg_419_1.var_.characterEffect1015ui_story = arg_419_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_0 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["1015ui_story"]) then
				if arg_419_1.var_.characterEffect1015ui_story and not isNil(arg_419_1.actors_["1015ui_story"]) then
					arg_419_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_419_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_419_1.time_ - 0) / var_422_0)
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["1015ui_story"]) and arg_419_1.var_.characterEffect1015ui_story then
				arg_419_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_419_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_422_1 = 0
			local var_422_2 = 0.35

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_3 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(317031101).content)

				arg_419_1.text_.text = var_422_3

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 14 <= 0 and var_422_2 or var_422_2 * (utf8.len(var_422_3) / 14)

				if (14 <= 0 and var_422_2 or var_422_2 * (utf8.len(var_422_3) / 14)) > 0 and var_422_2 < var_422_5 then
					arg_419_1.talkMaxDuration = var_422_5

					if var_422_5 + var_422_1 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + var_422_1
					end
				end

				arg_419_1.text_.text = var_422_3
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_6 = math.max(var_422_2, arg_419_1.talkMaxDuration)

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_6 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_1) / var_422_6

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_1 + var_422_6 and arg_419_1.time_ < var_422_1 + var_422_6 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play317031102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 317031102
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play317031103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos1015ui_story = arg_423_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_426_0 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 then
				arg_423_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_423_1.time_ - 0) / var_426_0)
				arg_423_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1015ui_story"].transform.position).z)
				arg_423_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1015ui_story"].transform.localEulerAngles = arg_423_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 then
				arg_423_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_423_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1015ui_story"].transform.position).z)
				arg_423_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1015ui_story"].transform.localEulerAngles = arg_423_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_426_1 = 0
			local var_426_2 = 0.5

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_3 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(317031102).content)

				arg_423_1.text_.text = var_426_3

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 20 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 20)

				if (20 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 20)) > 0 and var_426_2 < var_426_5 then
					arg_423_1.talkMaxDuration = var_426_5

					if var_426_5 + var_426_1 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_5 + var_426_1
					end
				end

				arg_423_1.text_.text = var_426_3
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_6 = math.max(var_426_2, arg_423_1.talkMaxDuration)

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_6 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_1) / var_426_6

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_1 + var_426_6 and arg_423_1.time_ < var_426_1 + var_426_6 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play317031103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 317031103
		arg_427_1.duration_ = 11.3

		local var_427_0 = {
			zh = 10.733,
			ja = 11.3
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
				arg_427_0:Play317031104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos1015ui_story = arg_427_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_430_0 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 then
				arg_427_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_427_1.time_ - 0) / var_430_0)
				arg_427_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1015ui_story"].transform.position).z)
				arg_427_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1015ui_story"].transform.localEulerAngles = arg_427_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 then
				arg_427_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_427_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1015ui_story"].transform.position).z)
				arg_427_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1015ui_story"].transform.localEulerAngles = arg_427_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_430_1 = arg_427_1.actors_["1015ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1015ui_story == nil then
				arg_427_1.var_.characterEffect1015ui_story = var_430_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_2 and not isNil(var_430_1) then
				if arg_427_1.var_.characterEffect1015ui_story and not isNil(var_430_1) then
					arg_427_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_2 and arg_427_1.time_ < 0 + var_430_2 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1015ui_story then
				arg_427_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_430_4 = 0
			local var_430_5 = 1.15

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_4 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_6 = arg_427_1:GetWordFromCfg(317031103)
				local var_430_7 = arg_427_1:FormatText(var_430_6.content)

				arg_427_1.text_.text = var_430_7

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_9 = 46 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 46)

				if (46 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 46)) > 0 and var_430_5 < var_430_9 then
					arg_427_1.talkMaxDuration = var_430_9

					if var_430_9 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_9 + var_430_4
					end
				end

				arg_427_1.text_.text = var_430_7
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031103", "story_v_out_317031.awb") ~= 0 then
					local var_430_10 = manager.audio:GetVoiceLength("story_v_out_317031", "317031103", "story_v_out_317031.awb") / 1000

					if var_430_10 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_10 + var_430_4
					end

					if var_430_6.prefab_name ~= "" and arg_427_1.actors_[var_430_6.prefab_name] ~= nil then
						local var_430_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_6.prefab_name].transform, "story_v_out_317031", "317031103", "story_v_out_317031.awb")

						arg_427_1:RecordAudio("317031103", var_430_11)
						arg_427_1:RecordAudio("317031103", var_430_11)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_317031", "317031103", "story_v_out_317031.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_317031", "317031103", "story_v_out_317031.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_12 = math.max(var_430_5, arg_427_1.talkMaxDuration)

			if var_430_4 <= arg_427_1.time_ and arg_427_1.time_ < var_430_4 + var_430_12 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_4) / var_430_12

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_4 + var_430_12 and arg_427_1.time_ < var_430_4 + var_430_12 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play317031104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 317031104
		arg_431_1.duration_ = 5.7

		local var_431_0 = {
			zh = 5.6,
			ja = 5.7
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
				arg_431_0:Play317031105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_434_0 = 0
			local var_434_1 = 0.75

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_2 = arg_431_1:GetWordFromCfg(317031104)
				local var_434_3 = arg_431_1:FormatText(var_434_2.content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 30 <= 0 and var_434_1 or var_434_1 * (utf8.len(var_434_3) / 30)

				if (30 <= 0 and var_434_1 or var_434_1 * (utf8.len(var_434_3) / 30)) > 0 and var_434_1 < var_434_5 then
					arg_431_1.talkMaxDuration = var_434_5

					if var_434_5 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_5 + var_434_0
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317031", "317031104", "story_v_out_317031.awb") ~= 0 then
					local var_434_6 = manager.audio:GetVoiceLength("story_v_out_317031", "317031104", "story_v_out_317031.awb") / 1000

					if var_434_6 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_6 + var_434_0
					end

					if var_434_2.prefab_name ~= "" and arg_431_1.actors_[var_434_2.prefab_name] ~= nil then
						local var_434_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_2.prefab_name].transform, "story_v_out_317031", "317031104", "story_v_out_317031.awb")

						arg_431_1:RecordAudio("317031104", var_434_7)
						arg_431_1:RecordAudio("317031104", var_434_7)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_317031", "317031104", "story_v_out_317031.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_317031", "317031104", "story_v_out_317031.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_8 = math.max(var_434_1, arg_431_1.talkMaxDuration)

			if var_434_0 <= arg_431_1.time_ and arg_431_1.time_ < var_434_0 + var_434_8 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_0) / var_434_8

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_0 + var_434_8 and arg_431_1.time_ < var_434_0 + var_434_8 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play317031105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 317031105
		arg_435_1.duration_ = 5

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
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["1015ui_story"]) and arg_435_1.var_.characterEffect1015ui_story == nil then
				arg_435_1.var_.characterEffect1015ui_story = arg_435_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["1015ui_story"]) then
				if arg_435_1.var_.characterEffect1015ui_story and not isNil(arg_435_1.actors_["1015ui_story"]) then
					arg_435_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_435_1.time_ - 0) / var_438_0)
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["1015ui_story"]) and arg_435_1.var_.characterEffect1015ui_story then
				arg_435_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_438_1 = 0
			local var_438_2 = 0.2

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_3 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(317031105).content)

				arg_435_1.text_.text = var_438_3

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 8 <= 0 and var_438_2 or var_438_2 * (utf8.len(var_438_3) / 8)

				if (8 <= 0 and var_438_2 or var_438_2 * (utf8.len(var_438_3) / 8)) > 0 and var_438_2 < var_438_5 then
					arg_435_1.talkMaxDuration = var_438_5

					if var_438_5 + var_438_1 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_5 + var_438_1
					end
				end

				arg_435_1.text_.text = var_438_3
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_6 = math.max(var_438_2, arg_435_1.talkMaxDuration)

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_6 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_1) / var_438_6

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_1 + var_438_6 and arg_435_1.time_ < var_438_1 + var_438_6 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/YA0102",
		"TextureConfig/Background/K06a",
		"TextureConfig/Background/K05f",
		"TextureConfig/Background/K03f"
	},
	voices = {
		"story_v_out_317031.awb"
	}
}
