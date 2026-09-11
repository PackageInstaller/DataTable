return {
	Play115261001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115261001
		arg_1_1.duration_ = 6.43

		local var_1_0 = {
			ja = 5.1,
			ko = 6.433,
			zh = 5.633,
			en = 5.933
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
				arg_1_0:Play115261002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

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

			local var_4_3 = "ST22"

			if arg_1_1.bgs_.ST22 == nil then
				local var_4_4 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_3)
				var_4_4.name = var_4_3
				var_4_4.transform.parent = arg_1_1.stage_.transform
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_3] = var_4_4
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.ST22

				arg_1_1.bgs_.ST22.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = 2 * (var_4_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_5.transform.localScale = Vector3.New(var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST22" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			if 1.10700136857828 < arg_1_1.time_ and arg_1_1.time_ <= 1.10700136857828 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess")

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
			local var_4_15 = 0.666666666666667

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[306].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:GetWordFromCfg(115261001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 12 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 12)

				if (12 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 12)) > 0 and var_4_15 < var_4_20 then
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

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261001", "story_v_out_115261.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_115261", "115261001", "story_v_out_115261.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_115261", "115261001", "story_v_out_115261.awb")

						arg_1_1:RecordAudio("115261001", var_4_22)
						arg_1_1:RecordAudio("115261001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_115261", "115261001", "story_v_out_115261.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_115261", "115261001", "story_v_out_115261.awb")
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
	Play115261002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115261002
		arg_9_1.duration_ = 5.17

		local var_9_0 = {
			ja = 3.4,
			ko = 5.166,
			zh = 3.833,
			en = 3.6
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
				arg_9_0:Play115261003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.666666666666667

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[306].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(115261002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 12 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 12)

				if (12 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 12)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261002", "story_v_out_115261.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261002", "story_v_out_115261.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_115261", "115261002", "story_v_out_115261.awb")

						arg_9_1:RecordAudio("115261002", var_12_6)
						arg_9_1:RecordAudio("115261002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_115261", "115261002", "story_v_out_115261.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_115261", "115261002", "story_v_out_115261.awb")
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
	Play115261003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115261003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play115261004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 3

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(115261003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 56 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 56)

				if (56 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 56)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play115261004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115261004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play115261005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 2.93333333333333

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(115261004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 53 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 53)

				if (53 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 53)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play115261005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115261005
		arg_21_1.duration_ = 2.93

		local var_21_0 = {
			ja = 1.499999999999,
			ko = 2.933,
			zh = 1.5,
			en = 1.6
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
				arg_21_0:Play115261006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.366666666666667

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(115261005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 6 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 6)

				if (6 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 6)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261005", "story_v_out_115261.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261005", "story_v_out_115261.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_115261", "115261005", "story_v_out_115261.awb")

						arg_21_1:RecordAudio("115261005", var_24_6)
						arg_21_1:RecordAudio("115261005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_115261", "115261005", "story_v_out_115261.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_115261", "115261005", "story_v_out_115261.awb")
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
	Play115261006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 115261006
		arg_25_1.duration_ = 3

		local var_25_0 = {
			ja = 2.499999999999,
			ko = 3,
			zh = 2.499999999999,
			en = 2.499999999999
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
				arg_25_0:Play115261007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 2

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(115261006)
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

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261006", "story_v_out_115261.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261006", "story_v_out_115261.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_115261", "115261006", "story_v_out_115261.awb")

						arg_25_1:RecordAudio("115261006", var_28_6)
						arg_25_1:RecordAudio("115261006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_115261", "115261006", "story_v_out_115261.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_115261", "115261006", "story_v_out_115261.awb")
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
	Play115261007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 115261007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play115261008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 2.66666666666667

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

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(115261007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 47 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 47)

				if (47 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 47)) > 0 and var_32_0 < var_32_3 then
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
	Play115261008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 115261008
		arg_33_1.duration_ = 1.5

		local var_33_0 = {
			ja = 1.499999999999,
			ko = 1.5,
			zh = 1.499999999999,
			en = 1.499999999999
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
				arg_33_0:Play115261009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.333333333333333

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(115261008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 2 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 2)

				if (2 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 2)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261008", "story_v_out_115261.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261008", "story_v_out_115261.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_115261", "115261008", "story_v_out_115261.awb")

						arg_33_1:RecordAudio("115261008", var_36_6)
						arg_33_1:RecordAudio("115261008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_115261", "115261008", "story_v_out_115261.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_115261", "115261008", "story_v_out_115261.awb")
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
	Play115261009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 115261009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play115261010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 2.2

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(115261009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 39 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 39)

				if (39 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 39)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play115261010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 115261010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play115261011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 2.03333333333333

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(115261010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 46 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 46)

				if (46 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 46)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play115261011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 115261011
		arg_45_1.duration_ = 5.57

		local var_45_0 = {
			ja = 5.566,
			ko = 4.633,
			zh = 5.366,
			en = 4.466
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
				arg_45_0:Play115261012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.33333333333333

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(115261011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 24 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 24)

				if (24 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 24)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261011", "story_v_out_115261.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261011", "story_v_out_115261.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_115261", "115261011", "story_v_out_115261.awb")

						arg_45_1:RecordAudio("115261011", var_48_6)
						arg_45_1:RecordAudio("115261011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_115261", "115261011", "story_v_out_115261.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_115261", "115261011", "story_v_out_115261.awb")
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
	Play115261012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 115261012
		arg_49_1.duration_ = 9.03

		local var_49_0 = {
			ja = 3.9,
			ko = 9.033,
			zh = 6.533,
			en = 8.5
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
				arg_49_0:Play115261013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.93333333333333

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(115261012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 36 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 36)

				if (36 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 36)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261012", "story_v_out_115261.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261012", "story_v_out_115261.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_115261", "115261012", "story_v_out_115261.awb")

						arg_49_1:RecordAudio("115261012", var_52_6)
						arg_49_1:RecordAudio("115261012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_115261", "115261012", "story_v_out_115261.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_115261", "115261012", "story_v_out_115261.awb")
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
	Play115261013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 115261013
		arg_53_1.duration_ = 10.37

		local var_53_0 = {
			ja = 10.366,
			ko = 3.933,
			zh = 3.333,
			en = 3.766
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
				arg_53_0:Play115261014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.16666666666667

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(115261013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 18 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 18)

				if (18 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 18)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261013", "story_v_out_115261.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261013", "story_v_out_115261.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_115261", "115261013", "story_v_out_115261.awb")

						arg_53_1:RecordAudio("115261013", var_56_6)
						arg_53_1:RecordAudio("115261013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_115261", "115261013", "story_v_out_115261.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_115261", "115261013", "story_v_out_115261.awb")
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
	Play115261014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 115261014
		arg_57_1.duration_ = 9.67

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play115261015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 2.66666666666667 < arg_57_1.time_ and arg_57_1.time_ <= 2.66666666666667 + arg_60_0 then
				local var_60_0 = arg_57_1.bgs_.ST22

				arg_57_1.bgs_.ST22.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_60_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_60_1 = var_60_0:GetComponent("SpriteRenderer")

				if var_60_1 and var_60_1.sprite then
					local var_60_2 = 2 * (var_60_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_60_0.transform.localScale = Vector3.New(var_60_2 / var_60_1.sprite.bounds.size.y < var_60_2 * manager.ui.mainCameraCom_.aspect / var_60_1.sprite.bounds.size.x and var_60_2 * manager.ui.mainCameraCom_.aspect / var_60_1.sprite.bounds.size.x or var_60_2 / var_60_1.sprite.bounds.size.y, var_60_2 / var_60_1.sprite.bounds.size.y < var_60_2 * manager.ui.mainCameraCom_.aspect / var_60_1.sprite.bounds.size.x and var_60_2 * manager.ui.mainCameraCom_.aspect / var_60_1.sprite.bounds.size.x or var_60_2 / var_60_1.sprite.bounds.size.y, 0)
				end

				for iter_60_0, iter_60_1 in pairs(arg_57_1.bgs_) do
					if iter_60_0 ~= "ST22" then
						iter_60_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_60_3 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_4 = 2

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_4 then
				local var_60_5 = Color.New(0, 0, 0)

				var_60_5.a = Mathf.Lerp(0, 1, (arg_57_1.time_ - var_60_3) / var_60_4)
				arg_57_1.mask_.color = var_60_5
			end

			if arg_57_1.time_ >= var_60_3 + var_60_4 and arg_57_1.time_ < var_60_3 + var_60_4 + arg_60_0 then
				local var_60_6 = Color.New(0, 0, 0)

				var_60_6.a = 1
				arg_57_1.mask_.color = var_60_6
			end

			local var_60_7 = 2.66666666666667

			if 2.66666666666667 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_8 = 2

			if var_60_7 <= arg_57_1.time_ and arg_57_1.time_ < var_60_7 + var_60_8 then
				local var_60_9 = Color.New(0, 0, 0)

				var_60_9.a = Mathf.Lerp(1, 0, (arg_57_1.time_ - var_60_7) / var_60_8)
				arg_57_1.mask_.color = var_60_9
			end

			if arg_57_1.time_ >= var_60_7 + var_60_8 and arg_57_1.time_ < var_60_7 + var_60_8 + arg_60_0 then
				local var_60_10 = Color.New(0, 0, 0)

				arg_57_1.mask_.enabled = false
				var_60_10.a = 0
				arg_57_1.mask_.color = var_60_10
			end

			local var_60_11 = 2

			arg_57_1.isInRecall_ = false

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.screenFilterGo_:SetActive(true)

				arg_57_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_60_2, iter_60_3 in pairs(arg_57_1.actors_) do
					for iter_60_4, iter_60_5 in ipairs((iter_60_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_60_5.color = iter_60_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_60_12 = 0.766666666666667

			if var_60_11 <= arg_57_1.time_ and arg_57_1.time_ < var_60_11 + var_60_12 then
				arg_57_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_57_1.time_ - var_60_11) / var_60_12)
			end

			if arg_57_1.time_ >= var_60_11 + var_60_12 and arg_57_1.time_ < var_60_11 + var_60_12 + arg_60_0 then
				arg_57_1.screenFilterEffect_.weight = 1
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_13 = 4.66666666666667
			local var_60_14 = 0.466666666666667

			if 4.66666666666667 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_15 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_15:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_16 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(115261014).content)

				arg_57_1.text_.text = var_60_16

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_18 = 2 <= 0 and var_60_14 or var_60_14 * (utf8.len(var_60_16) / 2)

				if (2 <= 0 and var_60_14 or var_60_14 * (utf8.len(var_60_16) / 2)) > 0 and var_60_14 < var_60_18 then
					arg_57_1.talkMaxDuration = var_60_18
					var_60_13 = var_60_13 + 0.3

					if var_60_18 + var_60_13 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_18 + var_60_13
					end
				end

				arg_57_1.text_.text = var_60_16
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_19 = var_60_13 + 0.3
			local var_60_20 = math.max(var_60_14, arg_57_1.talkMaxDuration)

			if var_60_13 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_19 + var_60_20 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_19) / var_60_20

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_19 + var_60_20 and arg_57_1.time_ < var_60_19 + var_60_20 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play115261015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 115261015
		arg_63_1.duration_ = 12.03

		local var_63_0 = {
			ja = 8.3,
			ko = 12.033,
			zh = 10.1,
			en = 8.333
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
				arg_63_0:Play115261016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.125

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:GetWordFromCfg(115261015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 45 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 45)

				if (45 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 45)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261015", "story_v_out_115261.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261015", "story_v_out_115261.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_115261", "115261015", "story_v_out_115261.awb")

						arg_63_1:RecordAudio("115261015", var_66_6)
						arg_63_1:RecordAudio("115261015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_115261", "115261015", "story_v_out_115261.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_115261", "115261015", "story_v_out_115261.awb")
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
	Play115261016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 115261016
		arg_67_1.duration_ = 9.4

		local var_67_0 = {
			ja = 4.266,
			ko = 7.266,
			zh = 7.4,
			en = 9.4
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
				arg_67_0:Play115261017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 1.5

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:GetWordFromCfg(115261016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 28 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 28)

				if (28 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 28)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261016", "story_v_out_115261.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261016", "story_v_out_115261.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_115261", "115261016", "story_v_out_115261.awb")

						arg_67_1:RecordAudio("115261016", var_70_6)
						arg_67_1:RecordAudio("115261016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_115261", "115261016", "story_v_out_115261.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_115261", "115261016", "story_v_out_115261.awb")
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
	Play115261017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 115261017
		arg_71_1.duration_ = 18.37

		local var_71_0 = {
			ja = 10.666,
			ko = 18.366,
			zh = 13.566,
			en = 14.2
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
				arg_71_0:Play115261018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if arg_71_1.actors_["1038"] == nil then
				local var_74_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1038")

				if not isNil(var_74_0) then
					local var_74_1 = Object.Instantiate(var_74_0, arg_71_1.canvasGo_.transform)

					var_74_1.transform:SetSiblingIndex(1)

					var_74_1.name = "1038"
					var_74_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_71_1.actors_["1038"] = var_74_1

					if arg_71_1.isInRecall_ then
						for iter_74_0, iter_74_1 in ipairs((var_74_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_74_1.color = arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_74_2 = arg_71_1.actors_["1038"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1038 = var_74_2.localPosition
				var_74_2.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1038", 3)

				for iter_74_2 = 0, var_74_2.childCount - 1 do
					local var_74_3 = var_74_2:GetChild(iter_74_2)

					if var_74_3.name == "split_9" or not string.find(var_74_3.name, "split") then
						var_74_3.gameObject:SetActive(true)
					else
						var_74_3.gameObject:SetActive(false)
					end
				end
			end

			local var_74_4 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				var_74_2.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_71_1.time_ - 0) / var_74_4)
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				var_74_2.localPosition = Vector3.New(0, -400, 0)
			end

			local var_74_5 = arg_71_1.actors_["1038"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.actorSpriteComps1038 == nil then
				arg_71_1.var_.actorSpriteComps1038 = var_74_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_6 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_6 and not isNil(var_74_5) then
				if arg_71_1.var_.actorSpriteComps1038 then
					for iter_74_3, iter_74_4 in pairs(arg_71_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_74_4 then
							if arg_71_1.isInRecall_ then
								iter_74_4.color = Color.New(Mathf.Lerp(iter_74_4.color.r, arg_71_1.hightColor1.r, (arg_71_1.time_ - 0) / var_74_6), Mathf.Lerp(iter_74_4.color.g, arg_71_1.hightColor1.g, (arg_71_1.time_ - 0) / var_74_6), (Mathf.Lerp(iter_74_4.color.b, arg_71_1.hightColor1.b, (arg_71_1.time_ - 0) / var_74_6)))
							else
								local var_74_7 = Mathf.Lerp(iter_74_4.color.r, 1, (arg_71_1.time_ - 0) / var_74_6)

								iter_74_4.color = Color.New(var_74_7, var_74_7, var_74_7)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_6 and arg_71_1.time_ < 0 + var_74_6 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.actorSpriteComps1038 then
				for iter_74_5, iter_74_6 in pairs(arg_71_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_74_6 then
						iter_74_6.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_71_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				local var_74_8 = arg_71_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_74_8 then
					arg_71_1.var_.alphaOldValue1038 = var_74_8.alpha
					arg_71_1.var_.characterEffect1038 = var_74_8
				end

				arg_71_1.var_.alphaOldValue1038 = 0
			end

			local var_74_9 = 0.5

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_9 then
				if arg_71_1.var_.characterEffect1038 then
					arg_71_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_71_1.var_.alphaOldValue1038, 1, (arg_71_1.time_ - 0) / var_74_9)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_9 and arg_71_1.time_ < 0 + var_74_9 + arg_74_0 and arg_71_1.var_.characterEffect1038 then
				arg_71_1.var_.characterEffect1038.alpha = 1
			end

			local var_74_10 = 0
			local var_74_11 = 2.5

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_12 = arg_71_1:GetWordFromCfg(115261017)
				local var_74_13 = arg_71_1:FormatText(var_74_12.content)

				arg_71_1.text_.text = var_74_13

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_15 = 54 <= 0 and var_74_11 or var_74_11 * (utf8.len(var_74_13) / 54)

				if (54 <= 0 and var_74_11 or var_74_11 * (utf8.len(var_74_13) / 54)) > 0 and var_74_11 < var_74_15 then
					arg_71_1.talkMaxDuration = var_74_15

					if var_74_15 + var_74_10 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_15 + var_74_10
					end
				end

				arg_71_1.text_.text = var_74_13
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261017", "story_v_out_115261.awb") ~= 0 then
					local var_74_16 = manager.audio:GetVoiceLength("story_v_out_115261", "115261017", "story_v_out_115261.awb") / 1000

					if var_74_16 + var_74_10 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_16 + var_74_10
					end

					if var_74_12.prefab_name ~= "" and arg_71_1.actors_[var_74_12.prefab_name] ~= nil then
						local var_74_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_12.prefab_name].transform, "story_v_out_115261", "115261017", "story_v_out_115261.awb")

						arg_71_1:RecordAudio("115261017", var_74_17)
						arg_71_1:RecordAudio("115261017", var_74_17)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_115261", "115261017", "story_v_out_115261.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_115261", "115261017", "story_v_out_115261.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_18 = math.max(var_74_11, arg_71_1.talkMaxDuration)

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_18 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_10) / var_74_18

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_10 + var_74_18 and arg_71_1.time_ < var_74_10 + var_74_18 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play115261018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 115261018
		arg_75_1.duration_ = 9.47

		local var_75_0 = {
			ja = 4.033,
			ko = 9.466,
			zh = 7.066,
			en = 7.266
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
				arg_75_0:Play115261019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 1.33333333333333

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:GetWordFromCfg(115261018)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 31 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 31)

				if (31 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 31)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261018", "story_v_out_115261.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261018", "story_v_out_115261.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_115261", "115261018", "story_v_out_115261.awb")

						arg_75_1:RecordAudio("115261018", var_78_6)
						arg_75_1:RecordAudio("115261018", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_115261", "115261018", "story_v_out_115261.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_115261", "115261018", "story_v_out_115261.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play115261019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 115261019
		arg_79_1.duration_ = 12.9

		local var_79_0 = {
			ja = 9.6,
			ko = 12.9,
			zh = 9.3,
			en = 10.466
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
				arg_79_0:Play115261020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1038"]) and arg_79_1.var_.actorSpriteComps1038 == nil then
				arg_79_1.var_.actorSpriteComps1038 = arg_79_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1038"]) then
				if arg_79_1.var_.actorSpriteComps1038 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								iter_82_1.color = Color.New(Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor2.r, (arg_79_1.time_ - 0) / var_82_0), Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor2.g, (arg_79_1.time_ - 0) / var_82_0), (Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor2.b, (arg_79_1.time_ - 0) / var_82_0)))
							else
								local var_82_1 = Mathf.Lerp(iter_82_1.color.r, 0.5, (arg_79_1.time_ - 0) / var_82_0)

								iter_82_1.color = Color.New(var_82_1, var_82_1, var_82_1)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1038"]) and arg_79_1.var_.actorSpriteComps1038 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps1038 = nil
			end

			local var_82_2 = 0
			local var_82_3 = 1.66666666666667

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_4 = arg_79_1:GetWordFromCfg(115261019)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 36 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 36)

				if (36 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 36)) > 0 and var_82_3 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261019", "story_v_out_115261.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261019", "story_v_out_115261.awb") / 1000

					if var_82_8 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_2
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_out_115261", "115261019", "story_v_out_115261.awb")

						arg_79_1:RecordAudio("115261019", var_82_9)
						arg_79_1:RecordAudio("115261019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_115261", "115261019", "story_v_out_115261.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_115261", "115261019", "story_v_out_115261.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_10 and arg_79_1.time_ < var_82_2 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play115261020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 115261020
		arg_83_1.duration_ = 7.87

		local var_83_0 = {
			ja = 7.866,
			ko = 6.933,
			zh = 5.166,
			en = 5.566
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
				arg_83_0:Play115261021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 1.16666666666667

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_1 = arg_83_1:GetWordFromCfg(115261020)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 20 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 20)

				if (20 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 20)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261020", "story_v_out_115261.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261020", "story_v_out_115261.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_115261", "115261020", "story_v_out_115261.awb")

						arg_83_1:RecordAudio("115261020", var_86_6)
						arg_83_1:RecordAudio("115261020", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_115261", "115261020", "story_v_out_115261.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_115261", "115261020", "story_v_out_115261.awb")
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
	Play115261021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 115261021
		arg_87_1.duration_ = 2.63

		local var_87_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 2.633,
			en = 1.2
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
				arg_87_0:Play115261022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1038"]) and arg_87_1.var_.actorSpriteComps1038 == nil then
				arg_87_1.var_.actorSpriteComps1038 = arg_87_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_0 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1038"]) then
				if arg_87_1.var_.actorSpriteComps1038 then
					for iter_90_0, iter_90_1 in pairs(arg_87_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_90_1 then
							if arg_87_1.isInRecall_ then
								iter_90_1.color = Color.New(Mathf.Lerp(iter_90_1.color.r, arg_87_1.hightColor1.r, (arg_87_1.time_ - 0) / var_90_0), Mathf.Lerp(iter_90_1.color.g, arg_87_1.hightColor1.g, (arg_87_1.time_ - 0) / var_90_0), (Mathf.Lerp(iter_90_1.color.b, arg_87_1.hightColor1.b, (arg_87_1.time_ - 0) / var_90_0)))
							else
								local var_90_1 = Mathf.Lerp(iter_90_1.color.r, 1, (arg_87_1.time_ - 0) / var_90_0)

								iter_90_1.color = Color.New(var_90_1, var_90_1, var_90_1)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1038"]) and arg_87_1.var_.actorSpriteComps1038 then
				for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_90_3 then
						iter_90_3.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_87_1.var_.actorSpriteComps1038 = nil
			end

			local var_90_2 = 0
			local var_90_3 = 0.333333333333333

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_4 = arg_87_1:GetWordFromCfg(115261021)
				local var_90_5 = arg_87_1:FormatText(var_90_4.content)

				arg_87_1.text_.text = var_90_5

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_7 = 2 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 2)

				if (2 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 2)) > 0 and var_90_3 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_2
					end
				end

				arg_87_1.text_.text = var_90_5
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261021", "story_v_out_115261.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261021", "story_v_out_115261.awb") / 1000

					if var_90_8 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_2
					end

					if var_90_4.prefab_name ~= "" and arg_87_1.actors_[var_90_4.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_4.prefab_name].transform, "story_v_out_115261", "115261021", "story_v_out_115261.awb")

						arg_87_1:RecordAudio("115261021", var_90_9)
						arg_87_1:RecordAudio("115261021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_115261", "115261021", "story_v_out_115261.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_115261", "115261021", "story_v_out_115261.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_3, arg_87_1.talkMaxDuration)

			if var_90_2 <= arg_87_1.time_ and arg_87_1.time_ < var_90_2 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_2) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_2 + var_90_10 and arg_87_1.time_ < var_90_2 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play115261022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 115261022
		arg_91_1.duration_ = 9.6

		local var_91_0 = {
			ja = 7.1,
			ko = 9.566,
			zh = 9.6,
			en = 9.433
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
				arg_91_0:Play115261023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 1.5

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:GetWordFromCfg(115261022)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 37 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 37)

				if (37 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 37)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261022", "story_v_out_115261.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261022", "story_v_out_115261.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_115261", "115261022", "story_v_out_115261.awb")

						arg_91_1:RecordAudio("115261022", var_94_6)
						arg_91_1:RecordAudio("115261022", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_115261", "115261022", "story_v_out_115261.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_115261", "115261022", "story_v_out_115261.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play115261023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 115261023
		arg_95_1.duration_ = 9.93

		local var_95_0 = {
			ja = 7.2,
			ko = 7.033,
			zh = 7.966,
			en = 9.933
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
				arg_95_0:Play115261024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 1.33333333333333

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:GetWordFromCfg(115261023)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 28 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 28)

				if (28 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 28)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261023", "story_v_out_115261.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261023", "story_v_out_115261.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_115261", "115261023", "story_v_out_115261.awb")

						arg_95_1:RecordAudio("115261023", var_98_6)
						arg_95_1:RecordAudio("115261023", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_115261", "115261023", "story_v_out_115261.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_115261", "115261023", "story_v_out_115261.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play115261024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 115261024
		arg_99_1.duration_ = 4

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play115261025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = false

				arg_99_1:SetGaussion(false)
			end

			local var_102_0 = 2.00133333333333

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				local var_102_1 = Color.New(0, 0, 0)

				var_102_1.a = Mathf.Lerp(0, 1, (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.mask_.color = var_102_1
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				local var_102_2 = Color.New(0, 0, 0)

				var_102_2.a = 1
				arg_99_1.mask_.color = var_102_2
			end

			local var_102_3 = 2.00133333333333

			if 2.00133333333333 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = false

				arg_99_1:SetGaussion(false)
			end

			local var_102_4 = 0.165333333333335

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_4 then
				local var_102_5 = Color.New(0, 0, 0)

				var_102_5.a = Mathf.Lerp(1, 0, (arg_99_1.time_ - var_102_3) / var_102_4)
				arg_99_1.mask_.color = var_102_5
			end

			if arg_99_1.time_ >= var_102_3 + var_102_4 and arg_99_1.time_ < var_102_3 + var_102_4 + arg_102_0 then
				local var_102_6 = Color.New(0, 0, 0)

				arg_99_1.mask_.enabled = false
				var_102_6.a = 0
				arg_99_1.mask_.color = var_102_6
			end

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= 2 + arg_102_0 then
				arg_99_1.fswbg_:SetActive(true)
				arg_99_1.dialog_:SetActive(false)

				arg_99_1.fswtw_.percent = 0
				arg_99_1.fswt_.text = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(115261024).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.fswt_)

				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_99_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_99_1.fswtw_:SetDirty()

				arg_99_1.typewritterCharCountI18N = 0

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_7 = 2.01666666666667

			if 2.01666666666667 < arg_99_1.time_ and arg_99_1.time_ <= var_102_7 + arg_102_0 then
				arg_99_1.var_.oldValueTypewriter = arg_99_1.fswtw_.percent

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_8 = 15
			local var_102_9 = 1
			local var_102_10, var_102_11 = arg_99_1:GetPercentByPara(arg_99_1:FormatText(arg_99_1:GetWordFromCfg(115261024).content), 1)

			if var_102_7 < arg_99_1.time_ and arg_99_1.time_ <= var_102_7 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				local var_102_12 = var_102_8 <= 0 and var_102_9 or var_102_9 * ((var_102_11 - arg_99_1.typewritterCharCountI18N) / var_102_8)

				if (var_102_8 <= 0 and var_102_9 or var_102_9 * ((var_102_11 - arg_99_1.typewritterCharCountI18N) / var_102_8)) > 0 and var_102_9 < var_102_12 then
					arg_99_1.talkMaxDuration = var_102_12

					if var_102_12 + var_102_7 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_12 + var_102_7
					end
				end
			end

			local var_102_13 = math.max(1, arg_99_1.talkMaxDuration)

			if var_102_7 <= arg_99_1.time_ and arg_99_1.time_ < var_102_7 + var_102_13 then
				arg_99_1.fswtw_.percent = Mathf.Lerp(arg_99_1.var_.oldValueTypewriter, var_102_10, (arg_99_1.time_ - var_102_7) / var_102_13)
				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_99_1.fswtw_:SetDirty()
			end

			if arg_99_1.time_ >= var_102_7 + var_102_13 and arg_99_1.time_ < var_102_7 + var_102_13 + arg_102_0 then
				arg_99_1.fswtw_.percent = var_102_10

				arg_99_1.fswtw_:SetDirty()
				arg_99_1:ShowNextGo(true)

				arg_99_1.typewritterCharCountI18N = var_102_11
			end

			local var_102_14 = 2.06666666666667

			if 2.06666666666667 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1.var_.oldValueTypewriter = arg_99_1.fswtw_.percent

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_15 = 0
			local var_102_16 = 0
			local var_102_17, var_102_18 = arg_99_1:GetPercentByPara(arg_99_1:FormatText(arg_99_1:GetWordFromCfg(115261024).content), 1)

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				local var_102_19 = var_102_15 <= 0 and var_102_16 or var_102_16 * ((var_102_18 - arg_99_1.typewritterCharCountI18N) / var_102_15)

				if (var_102_15 <= 0 and var_102_16 or var_102_16 * ((var_102_18 - arg_99_1.typewritterCharCountI18N) / var_102_15)) > 0 and var_102_16 < var_102_19 then
					arg_99_1.talkMaxDuration = var_102_19

					if var_102_19 + var_102_14 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_19 + var_102_14
					end
				end
			end

			local var_102_20 = math.max(0, arg_99_1.talkMaxDuration)

			if var_102_14 <= arg_99_1.time_ and arg_99_1.time_ < var_102_14 + var_102_20 then
				arg_99_1.fswtw_.percent = Mathf.Lerp(arg_99_1.var_.oldValueTypewriter, var_102_17, (arg_99_1.time_ - var_102_14) / var_102_20)
				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_99_1.fswtw_:SetDirty()
			end

			if arg_99_1.time_ >= var_102_14 + var_102_20 and arg_99_1.time_ < var_102_14 + var_102_20 + arg_102_0 then
				arg_99_1.fswtw_.percent = var_102_17

				arg_99_1.fswtw_:SetDirty()
				arg_99_1:ShowNextGo(true)

				arg_99_1.typewritterCharCountI18N = var_102_18
			end

			local var_102_21 = arg_99_1.actors_["1038"].transform

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= 2 + arg_102_0 then
				arg_99_1.var_.moveOldPos1038 = var_102_21.localPosition
				var_102_21.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1038", 7)

				for iter_102_0 = 0, var_102_21.childCount - 1 do
					local var_102_22 = var_102_21:GetChild(iter_102_0)

					if var_102_22.name == "split_9" or not string.find(var_102_22.name, "split") then
						var_102_22.gameObject:SetActive(true)
					else
						var_102_22.gameObject:SetActive(false)
					end
				end
			end

			local var_102_23 = 0.001

			if 2 <= arg_99_1.time_ and arg_99_1.time_ < 2 + var_102_23 then
				var_102_21.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1038, Vector3.New(0, -2000, -180), (arg_99_1.time_ - 2) / var_102_23)
			end

			if arg_99_1.time_ >= 2 + var_102_23 and arg_99_1.time_ < 2 + var_102_23 + arg_102_0 then
				var_102_21.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_102_24 = 2

			arg_99_1.isInRecall_ = false

			if var_102_24 < arg_99_1.time_ and arg_99_1.time_ <= var_102_24 + arg_102_0 then
				arg_99_1.screenFilterGo_:SetActive(false)

				for iter_102_1, iter_102_2 in pairs(arg_99_1.actors_) do
					for iter_102_3, iter_102_4 in ipairs((iter_102_2:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_102_4.color = iter_102_4.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_102_25 = 0.0166666666666667

			if var_102_24 <= arg_99_1.time_ and arg_99_1.time_ < var_102_24 + var_102_25 then
				arg_99_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_99_1.time_ - var_102_24) / var_102_25)
			end

			if arg_99_1.time_ >= var_102_24 + var_102_25 and arg_99_1.time_ < var_102_24 + var_102_25 + arg_102_0 then
				arg_99_1.screenFilterEffect_.weight = 0
			end

			local var_102_26 = "STblack"

			if arg_99_1.bgs_.STblack == nil then
				local var_102_27 = Object.Instantiate(arg_99_1.paintGo_)

				var_102_27:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_102_26)
				var_102_27.name = var_102_26
				var_102_27.transform.parent = arg_99_1.stage_.transform
				var_102_27.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.bgs_[var_102_26] = var_102_27
			end

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= 2 + arg_102_0 then
				local var_102_28 = arg_99_1.bgs_.STblack

				arg_99_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_102_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_29 = var_102_28:GetComponent("SpriteRenderer")

				if var_102_29 and var_102_29.sprite then
					local var_102_30 = 2 * (var_102_28.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_102_28.transform.localScale = Vector3.New(var_102_30 / var_102_29.sprite.bounds.size.y < var_102_30 * manager.ui.mainCameraCom_.aspect / var_102_29.sprite.bounds.size.x and var_102_30 * manager.ui.mainCameraCom_.aspect / var_102_29.sprite.bounds.size.x or var_102_30 / var_102_29.sprite.bounds.size.y, var_102_30 / var_102_29.sprite.bounds.size.y < var_102_30 * manager.ui.mainCameraCom_.aspect / var_102_29.sprite.bounds.size.x and var_102_30 * manager.ui.mainCameraCom_.aspect / var_102_29.sprite.bounds.size.x or var_102_30 / var_102_29.sprite.bounds.size.y, 0)
				end

				for iter_102_5, iter_102_6 in pairs(arg_99_1.bgs_) do
					if iter_102_5 ~= "STblack" then
						iter_102_6.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play115261025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 115261025
		arg_103_1.duration_ = 1

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play115261026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.oldValueTypewriter = arg_103_1.fswtw_.percent

				SetActive(arg_103_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_103_1:ShowNextGo(false)
			end

			local var_106_0 = 14
			local var_106_1 = 0.933333333333333
			local var_106_2, var_106_3 = arg_103_1:GetPercentByPara(arg_103_1:FormatText(arg_103_1:GetWordFromCfg(115261024).content), 2)

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				local var_106_4 = var_106_0 <= 0 and var_106_1 or var_106_1 * ((var_106_3 - arg_103_1.typewritterCharCountI18N) / var_106_0)

				if (var_106_0 <= 0 and var_106_1 or var_106_1 * ((var_106_3 - arg_103_1.typewritterCharCountI18N) / var_106_0)) > 0 and var_106_1 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end
			end

			local var_106_5 = math.max(0.933333333333333, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_5 then
				arg_103_1.fswtw_.percent = Mathf.Lerp(arg_103_1.var_.oldValueTypewriter, var_106_2, (arg_103_1.time_ - 0) / var_106_5)
				arg_103_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_103_1.fswtw_:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_5 and arg_103_1.time_ < 0 + var_106_5 + arg_106_0 then
				arg_103_1.fswtw_.percent = var_106_2

				arg_103_1.fswtw_:SetDirty()
				arg_103_1:ShowNextGo(true)

				arg_103_1.typewritterCharCountI18N = var_106_3
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play115261026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 115261026
		arg_107_1.duration_ = 1.07

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play115261027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.oldValueTypewriter = arg_107_1.fswtw_.percent

				SetActive(arg_107_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_107_1:ShowNextGo(false)
			end

			local var_110_0 = 16
			local var_110_1 = 1.06666666666667
			local var_110_2, var_110_3 = arg_107_1:GetPercentByPara(arg_107_1:FormatText(arg_107_1:GetWordFromCfg(115261024).content), 3)

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0

				local var_110_4 = var_110_0 <= 0 and var_110_1 or var_110_1 * ((var_110_3 - arg_107_1.typewritterCharCountI18N) / var_110_0)

				if (var_110_0 <= 0 and var_110_1 or var_110_1 * ((var_110_3 - arg_107_1.typewritterCharCountI18N) / var_110_0)) > 0 and var_110_1 < var_110_4 then
					arg_107_1.talkMaxDuration = var_110_4

					if var_110_4 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_4 + 0
					end
				end
			end

			local var_110_5 = math.max(1.06666666666667, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_5 then
				arg_107_1.fswtw_.percent = Mathf.Lerp(arg_107_1.var_.oldValueTypewriter, var_110_2, (arg_107_1.time_ - 0) / var_110_5)
				arg_107_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_107_1.fswtw_:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_5 and arg_107_1.time_ < 0 + var_110_5 + arg_110_0 then
				arg_107_1.fswtw_.percent = var_110_2

				arg_107_1.fswtw_:SetDirty()
				arg_107_1:ShowNextGo(true)

				arg_107_1.typewritterCharCountI18N = var_110_3
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play115261027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 115261027
		arg_111_1.duration_ = 1.13

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play115261028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.oldValueTypewriter = arg_111_1.fswtw_.percent

				SetActive(arg_111_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_111_1:ShowNextGo(false)
			end

			local var_114_0 = 17
			local var_114_1 = 1.13333333333333
			local var_114_2, var_114_3 = arg_111_1:GetPercentByPara(arg_111_1:FormatText(arg_111_1:GetWordFromCfg(115261024).content), 4)

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				local var_114_4 = var_114_0 <= 0 and var_114_1 or var_114_1 * ((var_114_3 - arg_111_1.typewritterCharCountI18N) / var_114_0)

				if (var_114_0 <= 0 and var_114_1 or var_114_1 * ((var_114_3 - arg_111_1.typewritterCharCountI18N) / var_114_0)) > 0 and var_114_1 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end
			end

			local var_114_5 = math.max(1.13333333333333, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_5 then
				arg_111_1.fswtw_.percent = Mathf.Lerp(arg_111_1.var_.oldValueTypewriter, var_114_2, (arg_111_1.time_ - 0) / var_114_5)
				arg_111_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_111_1.fswtw_:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_5 and arg_111_1.time_ < 0 + var_114_5 + arg_114_0 then
				arg_111_1.fswtw_.percent = var_114_2

				arg_111_1.fswtw_:SetDirty()
				arg_111_1:ShowNextGo(true)

				arg_111_1.typewritterCharCountI18N = var_114_3
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play115261028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 115261028
		arg_115_1.duration_ = 1

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play115261029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.oldValueTypewriter = arg_115_1.fswtw_.percent

				SetActive(arg_115_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_115_1:ShowNextGo(false)
			end

			local var_118_0 = 12
			local var_118_1 = 0.8
			local var_118_2, var_118_3 = arg_115_1:GetPercentByPara(arg_115_1:FormatText(arg_115_1:GetWordFromCfg(115261024).content), 5)

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				local var_118_4 = var_118_0 <= 0 and var_118_1 or var_118_1 * ((var_118_3 - arg_115_1.typewritterCharCountI18N) / var_118_0)

				if (var_118_0 <= 0 and var_118_1 or var_118_1 * ((var_118_3 - arg_115_1.typewritterCharCountI18N) / var_118_0)) > 0 and var_118_1 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end
			end

			local var_118_5 = math.max(0.8, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_5 then
				arg_115_1.fswtw_.percent = Mathf.Lerp(arg_115_1.var_.oldValueTypewriter, var_118_2, (arg_115_1.time_ - 0) / var_118_5)
				arg_115_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_115_1.fswtw_:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_5 and arg_115_1.time_ < 0 + var_118_5 + arg_118_0 then
				arg_115_1.fswtw_.percent = var_118_2

				arg_115_1.fswtw_:SetDirty()
				arg_115_1:ShowNextGo(true)

				arg_115_1.typewritterCharCountI18N = var_118_3
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play115261029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 115261029
		arg_119_1.duration_ = 1

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play115261030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.oldValueTypewriter = arg_119_1.fswtw_.percent

				SetActive(arg_119_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_119_1:ShowNextGo(false)
			end

			local var_122_0 = 14
			local var_122_1 = 0.933333333333333
			local var_122_2, var_122_3 = arg_119_1:GetPercentByPara(arg_119_1:FormatText(arg_119_1:GetWordFromCfg(115261024).content), 6)

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				local var_122_4 = var_122_0 <= 0 and var_122_1 or var_122_1 * ((var_122_3 - arg_119_1.typewritterCharCountI18N) / var_122_0)

				if (var_122_0 <= 0 and var_122_1 or var_122_1 * ((var_122_3 - arg_119_1.typewritterCharCountI18N) / var_122_0)) > 0 and var_122_1 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end
			end

			local var_122_5 = math.max(0.933333333333333, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_5 then
				arg_119_1.fswtw_.percent = Mathf.Lerp(arg_119_1.var_.oldValueTypewriter, var_122_2, (arg_119_1.time_ - 0) / var_122_5)
				arg_119_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_119_1.fswtw_:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_5 and arg_119_1.time_ < 0 + var_122_5 + arg_122_0 then
				arg_119_1.fswtw_.percent = var_122_2

				arg_119_1.fswtw_:SetDirty()
				arg_119_1:ShowNextGo(true)

				arg_119_1.typewritterCharCountI18N = var_122_3
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play115261030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 115261030
		arg_123_1.duration_ = 1

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play115261031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.oldValueTypewriter = arg_123_1.fswtw_.percent

				SetActive(arg_123_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_123_1:ShowNextGo(false)
			end

			local var_126_0 = 14
			local var_126_1 = 0.933333333333333
			local var_126_2, var_126_3 = arg_123_1:GetPercentByPara(arg_123_1:FormatText(arg_123_1:GetWordFromCfg(115261024).content), 7)

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				local var_126_4 = var_126_0 <= 0 and var_126_1 or var_126_1 * ((var_126_3 - arg_123_1.typewritterCharCountI18N) / var_126_0)

				if (var_126_0 <= 0 and var_126_1 or var_126_1 * ((var_126_3 - arg_123_1.typewritterCharCountI18N) / var_126_0)) > 0 and var_126_1 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end
			end

			local var_126_5 = math.max(0.933333333333333, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_5 then
				arg_123_1.fswtw_.percent = Mathf.Lerp(arg_123_1.var_.oldValueTypewriter, var_126_2, (arg_123_1.time_ - 0) / var_126_5)
				arg_123_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_123_1.fswtw_:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_5 and arg_123_1.time_ < 0 + var_126_5 + arg_126_0 then
				arg_123_1.fswtw_.percent = var_126_2

				arg_123_1.fswtw_:SetDirty()
				arg_123_1:ShowNextGo(true)

				arg_123_1.typewritterCharCountI18N = var_126_3
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play115261031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 115261031
		arg_127_1.duration_ = 8

		local var_127_0 = {
			ja = 6.99999999999999,
			ko = 7.06599999999999,
			zh = 7.99999999999999,
			en = 7.13299999999999
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
				arg_127_0:Play115261032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.bgs_.F01a == nil then
				local var_130_0 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01a")
				var_130_0.name = "F01a"
				var_130_0.transform.parent = arg_127_1.stage_.transform
				var_130_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_.F01a = var_130_0
			end

			if 4 < arg_127_1.time_ and arg_127_1.time_ <= 4 + arg_130_0 then
				local var_130_1 = arg_127_1.bgs_.F01a

				arg_127_1.bgs_.F01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_130_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_2 = var_130_1:GetComponent("SpriteRenderer")

				if var_130_2 and var_130_2.sprite then
					local var_130_3 = 2 * (var_130_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_130_1.transform.localScale = Vector3.New(var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "F01a" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_4 = 4

			if 4 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = false

				arg_127_1:SetGaussion(false)
			end

			local var_130_5 = 2

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_5 then
				local var_130_6 = Color.New(0, 0, 0)

				var_130_6.a = Mathf.Lerp(1, 0, (arg_127_1.time_ - var_130_4) / var_130_5)
				arg_127_1.mask_.color = var_130_6
			end

			if arg_127_1.time_ >= var_130_4 + var_130_5 and arg_127_1.time_ < var_130_4 + var_130_5 + arg_130_0 then
				local var_130_7 = Color.New(0, 0, 0)

				arg_127_1.mask_.enabled = false
				var_130_7.a = 0
				arg_127_1.mask_.color = var_130_7
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.fswbg_:SetActive(false)
				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_127_1:ShowNextGo(false)
			end

			local var_130_8 = arg_127_1.actors_["1038"].transform

			if 5.99999999999999 < arg_127_1.time_ and arg_127_1.time_ <= 5.99999999999999 + arg_130_0 then
				arg_127_1.var_.moveOldPos1038 = var_130_8.localPosition
				var_130_8.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1038", 2)

				for iter_130_2 = 0, var_130_8.childCount - 1 do
					local var_130_9 = var_130_8:GetChild(iter_130_2)

					if var_130_9.name == "split_1" or not string.find(var_130_9.name, "split") then
						var_130_9.gameObject:SetActive(true)
					else
						var_130_9.gameObject:SetActive(false)
					end
				end
			end

			local var_130_10 = 0.001

			if 5.99999999999999 <= arg_127_1.time_ and arg_127_1.time_ < 5.99999999999999 + var_130_10 then
				var_130_8.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_127_1.time_ - 5.99999999999999) / var_130_10)
			end

			if arg_127_1.time_ >= 5.99999999999999 + var_130_10 and arg_127_1.time_ < 5.99999999999999 + var_130_10 + arg_130_0 then
				var_130_8.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_130_11 = arg_127_1.actors_["1038"]

			if 5.99999999999999 < arg_127_1.time_ and arg_127_1.time_ <= 5.99999999999999 + arg_130_0 and not isNil(var_130_11) and arg_127_1.var_.actorSpriteComps1038 == nil then
				arg_127_1.var_.actorSpriteComps1038 = var_130_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_12 = 0.2

			if 5.99999999999999 <= arg_127_1.time_ and arg_127_1.time_ < 5.99999999999999 + var_130_12 and not isNil(var_130_11) then
				if arg_127_1.var_.actorSpriteComps1038 then
					for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_130_4 then
							if arg_127_1.isInRecall_ then
								iter_130_4.color = Color.New(Mathf.Lerp(iter_130_4.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 5.99999999999999) / var_130_12), Mathf.Lerp(iter_130_4.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 5.99999999999999) / var_130_12), (Mathf.Lerp(iter_130_4.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 5.99999999999999) / var_130_12)))
							else
								local var_130_13 = Mathf.Lerp(iter_130_4.color.r, 1, (arg_127_1.time_ - 5.99999999999999) / var_130_12)

								iter_130_4.color = Color.New(var_130_13, var_130_13, var_130_13)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 5.99999999999999 + var_130_12 and arg_127_1.time_ < 5.99999999999999 + var_130_12 + arg_130_0 and not isNil(var_130_11) and arg_127_1.var_.actorSpriteComps1038 then
				for iter_130_5, iter_130_6 in pairs(arg_127_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_130_6 then
						iter_130_6.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps1038 = nil
			end

			if 5.99999999999999 < arg_127_1.time_ and arg_127_1.time_ <= 5.99999999999999 + arg_130_0 then
				local var_130_14 = arg_127_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_130_14 then
					arg_127_1.var_.alphaOldValue1038 = var_130_14.alpha
					arg_127_1.var_.characterEffect1038 = var_130_14
				end

				arg_127_1.var_.alphaOldValue1038 = 0
			end

			local var_130_15 = 0.5

			if 5.99999999999999 <= arg_127_1.time_ and arg_127_1.time_ < 5.99999999999999 + var_130_15 then
				if arg_127_1.var_.characterEffect1038 then
					arg_127_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_127_1.var_.alphaOldValue1038, 1, (arg_127_1.time_ - 5.99999999999999) / var_130_15)
				end
			end

			if arg_127_1.time_ >= 5.99999999999999 + var_130_15 and arg_127_1.time_ < 5.99999999999999 + var_130_15 + arg_130_0 and arg_127_1.var_.characterEffect1038 then
				arg_127_1.var_.characterEffect1038.alpha = 1
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_130_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_127_1.bgmTxt_.text ~= var_130_18 and arg_127_1.bgmTxt_.text ~= "" then
						if arg_127_1.bgmTxt2_.text ~= "" then
							arg_127_1.bgmTxt_.text = arg_127_1.bgmTxt2_.text
						end

						arg_127_1.bgmTxt2_.text = var_130_18

						arg_127_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_127_1.bgmTxt_.text = var_130_18
						arg_127_1.bgmTxt2_.text = var_130_18
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

			if 1.03333333333333 < arg_127_1.time_ and arg_127_1.time_ <= 1.03333333333333 + arg_130_0 then
				arg_127_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_130_21 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_127_1.bgmTxt_.text ~= var_130_21 and arg_127_1.bgmTxt_.text ~= "" then
						if arg_127_1.bgmTxt2_.text ~= "" then
							arg_127_1.bgmTxt_.text = arg_127_1.bgmTxt2_.text
						end

						arg_127_1.bgmTxt2_.text = var_130_21

						arg_127_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_127_1.bgmTxt_.text = var_130_21
						arg_127_1.bgmTxt2_.text = var_130_21
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

			local var_130_22 = 5.99999999999999
			local var_130_23 = 0.1

			if 5.99999999999999 < arg_127_1.time_ and arg_127_1.time_ <= var_130_22 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_24 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_24:setOnUpdate(LuaHelper.FloatAction(function(arg_133_0)
					arg_127_1.dialogCg_.alpha = arg_133_0
				end))
				var_130_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_25 = arg_127_1:GetWordFromCfg(115261031)
				local var_130_26 = arg_127_1:FormatText(var_130_25.content)

				arg_127_1.text_.text = var_130_26

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_28 = 4 <= 0 and var_130_23 or var_130_23 * (utf8.len(var_130_26) / 4)

				if (4 <= 0 and var_130_23 or var_130_23 * (utf8.len(var_130_26) / 4)) > 0 and var_130_23 < var_130_28 then
					arg_127_1.talkMaxDuration = var_130_28
					var_130_22 = var_130_22 + 0.3

					if var_130_28 + var_130_22 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_28 + var_130_22
					end
				end

				arg_127_1.text_.text = var_130_26
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261031", "story_v_out_115261.awb") ~= 0 then
					local var_130_29 = manager.audio:GetVoiceLength("story_v_out_115261", "115261031", "story_v_out_115261.awb") / 1000

					if var_130_29 + var_130_22 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_29 + var_130_22
					end

					if var_130_25.prefab_name ~= "" and arg_127_1.actors_[var_130_25.prefab_name] ~= nil then
						local var_130_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_25.prefab_name].transform, "story_v_out_115261", "115261031", "story_v_out_115261.awb")

						arg_127_1:RecordAudio("115261031", var_130_30)
						arg_127_1:RecordAudio("115261031", var_130_30)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_115261", "115261031", "story_v_out_115261.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_115261", "115261031", "story_v_out_115261.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_31 = var_130_22 + 0.3
			local var_130_32 = math.max(var_130_23, arg_127_1.talkMaxDuration)

			if var_130_22 + 0.3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_31 + var_130_32 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_31) / var_130_32

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_31 + var_130_32 and arg_127_1.time_ < var_130_31 + var_130_32 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.99999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play115261032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 115261032
		arg_135_1.duration_ = 1.2

		local var_135_0 = {
			ja = 0.999999999999,
			ko = 1.066,
			zh = 1.133,
			en = 1.2
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
				arg_135_0:Play115261033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1038"]) and arg_135_1.var_.actorSpriteComps1038 == nil then
				arg_135_1.var_.actorSpriteComps1038 = arg_135_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1038"]) then
				if arg_135_1.var_.actorSpriteComps1038 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								iter_138_1.color = Color.New(Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_0), Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_0), (Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_0)))
							else
								local var_138_1 = Mathf.Lerp(iter_138_1.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_0)

								iter_138_1.color = Color.New(var_138_1, var_138_1, var_138_1)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1038"]) and arg_135_1.var_.actorSpriteComps1038 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps1038 = nil
			end

			local var_138_2 = "10030"

			if arg_135_1.actors_["10030"] == nil then
				local var_138_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10030")

				if not isNil(var_138_3) then
					local var_138_4 = Object.Instantiate(var_138_3, arg_135_1.canvasGo_.transform)

					var_138_4.transform:SetSiblingIndex(1)

					var_138_4.name = var_138_2
					var_138_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_135_1.actors_[var_138_2] = var_138_4

					if arg_135_1.isInRecall_ then
						for iter_138_4, iter_138_5 in ipairs((var_138_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_138_5.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_138_5 = arg_135_1.actors_["10030"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10030 = var_138_5.localPosition
				var_138_5.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10030", 4)

				for iter_138_6 = 0, var_138_5.childCount - 1 do
					local var_138_6 = var_138_5:GetChild(iter_138_6)

					if var_138_6.name == "split_1" or not string.find(var_138_6.name, "split") then
						var_138_6.gameObject:SetActive(true)
					else
						var_138_6.gameObject:SetActive(false)
					end
				end
			end

			local var_138_7 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				var_138_5.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_135_1.time_ - 0) / var_138_7)
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				var_138_5.localPosition = Vector3.New(390, -390, 150)
			end

			local var_138_8 = arg_135_1.actors_["10030"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_8) and arg_135_1.var_.actorSpriteComps10030 == nil then
				arg_135_1.var_.actorSpriteComps10030 = var_138_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_9 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_9 and not isNil(var_138_8) then
				if arg_135_1.var_.actorSpriteComps10030 then
					for iter_138_7, iter_138_8 in pairs(arg_135_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_138_8 then
							if arg_135_1.isInRecall_ then
								iter_138_8.color = Color.New(Mathf.Lerp(iter_138_8.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_9), Mathf.Lerp(iter_138_8.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_9), (Mathf.Lerp(iter_138_8.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_9)))
							else
								local var_138_10 = Mathf.Lerp(iter_138_8.color.r, 1, (arg_135_1.time_ - 0) / var_138_9)

								iter_138_8.color = Color.New(var_138_10, var_138_10, var_138_10)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_9 and arg_135_1.time_ < 0 + var_138_9 + arg_138_0 and not isNil(var_138_8) and arg_135_1.var_.actorSpriteComps10030 then
				for iter_138_9, iter_138_10 in pairs(arg_135_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_138_10 then
						iter_138_10.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				local var_138_11 = arg_135_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_138_11 then
					arg_135_1.var_.alphaOldValue10030 = var_138_11.alpha
					arg_135_1.var_.characterEffect10030 = var_138_11
				end

				arg_135_1.var_.alphaOldValue10030 = 0
			end

			local var_138_12 = 0.5

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_12 then
				if arg_135_1.var_.characterEffect10030 then
					arg_135_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_135_1.var_.alphaOldValue10030, 1, (arg_135_1.time_ - 0) / var_138_12)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_12 and arg_135_1.time_ < 0 + var_138_12 + arg_138_0 and arg_135_1.var_.characterEffect10030 then
				arg_135_1.var_.characterEffect10030.alpha = 1
			end

			local var_138_13 = 0
			local var_138_14 = 0.1

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_13 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_15 = arg_135_1:GetWordFromCfg(115261032)
				local var_138_16 = arg_135_1:FormatText(var_138_15.content)

				arg_135_1.text_.text = var_138_16

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_18 = 4 <= 0 and var_138_14 or var_138_14 * (utf8.len(var_138_16) / 4)

				if (4 <= 0 and var_138_14 or var_138_14 * (utf8.len(var_138_16) / 4)) > 0 and var_138_14 < var_138_18 then
					arg_135_1.talkMaxDuration = var_138_18

					if var_138_18 + var_138_13 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_18 + var_138_13
					end
				end

				arg_135_1.text_.text = var_138_16
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261032", "story_v_out_115261.awb") ~= 0 then
					local var_138_19 = manager.audio:GetVoiceLength("story_v_out_115261", "115261032", "story_v_out_115261.awb") / 1000

					if var_138_19 + var_138_13 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_19 + var_138_13
					end

					if var_138_15.prefab_name ~= "" and arg_135_1.actors_[var_138_15.prefab_name] ~= nil then
						local var_138_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_15.prefab_name].transform, "story_v_out_115261", "115261032", "story_v_out_115261.awb")

						arg_135_1:RecordAudio("115261032", var_138_20)
						arg_135_1:RecordAudio("115261032", var_138_20)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_115261", "115261032", "story_v_out_115261.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_115261", "115261032", "story_v_out_115261.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_21 = math.max(var_138_14, arg_135_1.talkMaxDuration)

			if var_138_13 <= arg_135_1.time_ and arg_135_1.time_ < var_138_13 + var_138_21 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_13) / var_138_21

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_13 + var_138_21 and arg_135_1.time_ < var_138_13 + var_138_21 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play115261033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 115261033
		arg_139_1.duration_ = 5.4

		local var_139_0 = {
			ja = 4.8,
			ko = 5.4,
			zh = 4,
			en = 5
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
				arg_139_0:Play115261034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.4

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:GetWordFromCfg(115261033)
				local var_142_2 = arg_139_1:FormatText(var_142_1.content)

				arg_139_1.text_.text = var_142_2

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 16 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 16)

				if (16 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 16)) > 0 and var_142_0 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end

				arg_139_1.text_.text = var_142_2
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261033", "story_v_out_115261.awb") ~= 0 then
					local var_142_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261033", "story_v_out_115261.awb") / 1000

					if var_142_5 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + 0
					end

					if var_142_1.prefab_name ~= "" and arg_139_1.actors_[var_142_1.prefab_name] ~= nil then
						local var_142_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_1.prefab_name].transform, "story_v_out_115261", "115261033", "story_v_out_115261.awb")

						arg_139_1:RecordAudio("115261033", var_142_6)
						arg_139_1:RecordAudio("115261033", var_142_6)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_115261", "115261033", "story_v_out_115261.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_115261", "115261033", "story_v_out_115261.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play115261034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 115261034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play115261035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0.5 < arg_143_1.time_ and arg_143_1.time_ <= 0.5 + arg_146_0 then
				arg_143_1.var_.moveOldPos1038 = arg_143_1.actors_["1038"].transform.localPosition
				arg_143_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1038", 7)

				for iter_146_0 = 0, arg_143_1.actors_["1038"].transform.childCount - 1 do
					local var_146_0 = arg_143_1.actors_["1038"].transform:GetChild(iter_146_0)

					if var_146_0.name == "split_5" or not string.find(var_146_0.name, "split") then
						var_146_0.gameObject:SetActive(true)
					else
						var_146_0.gameObject:SetActive(false)
					end
				end
			end

			local var_146_1 = 0.001

			if 0.5 <= arg_143_1.time_ and arg_143_1.time_ < 0.5 + var_146_1 then
				arg_143_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1038, Vector3.New(0, -2000, 0), (arg_143_1.time_ - 0.5) / var_146_1)
			end

			if arg_143_1.time_ >= 0.5 + var_146_1 and arg_143_1.time_ < 0.5 + var_146_1 + arg_146_0 then
				arg_143_1.actors_["1038"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_146_2 = arg_143_1.actors_["10030"].transform

			if 0.5 < arg_143_1.time_ and arg_143_1.time_ <= 0.5 + arg_146_0 then
				arg_143_1.var_.moveOldPos10030 = var_146_2.localPosition
				var_146_2.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10030", 7)

				for iter_146_1 = 0, var_146_2.childCount - 1 do
					local var_146_3 = var_146_2:GetChild(iter_146_1)

					if var_146_3.name == "split_1" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if 0.5 <= arg_143_1.time_ and arg_143_1.time_ < 0.5 + var_146_4 then
				var_146_2.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10030, Vector3.New(0, -2000, 150), (arg_143_1.time_ - 0.5) / var_146_4)
			end

			if arg_143_1.time_ >= 0.5 + var_146_4 and arg_143_1.time_ < 0.5 + var_146_4 + arg_146_0 then
				var_146_2.localPosition = Vector3.New(0, -2000, 150)
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				local var_146_5 = arg_143_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_146_5 then
					arg_143_1.var_.alphaOldValue10030 = var_146_5.alpha
					arg_143_1.var_.characterEffect10030 = var_146_5
				end

				arg_143_1.var_.alphaOldValue10030 = 1
			end

			local var_146_6 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_6 then
				if arg_143_1.var_.characterEffect10030 then
					arg_143_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_143_1.var_.alphaOldValue10030, 0, (arg_143_1.time_ - 0) / var_146_6)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_6 and arg_143_1.time_ < 0 + var_146_6 + arg_146_0 and arg_143_1.var_.characterEffect10030 then
				arg_143_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				local var_146_7 = arg_143_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_146_7 then
					arg_143_1.var_.alphaOldValue1038 = var_146_7.alpha
					arg_143_1.var_.characterEffect1038 = var_146_7
				end

				arg_143_1.var_.alphaOldValue1038 = 1
			end

			local var_146_8 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_8 then
				if arg_143_1.var_.characterEffect1038 then
					arg_143_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_143_1.var_.alphaOldValue1038, 0, (arg_143_1.time_ - 0) / var_146_8)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_8 and arg_143_1.time_ < 0 + var_146_8 + arg_146_0 and arg_143_1.var_.characterEffect1038 then
				arg_143_1.var_.characterEffect1038.alpha = 0
			end

			local var_146_9 = 0
			local var_146_10 = 0.7

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_11 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(115261034).content)

				arg_143_1.text_.text = var_146_11

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 28 <= 0 and var_146_10 or var_146_10 * (utf8.len(var_146_11) / 28)

				if (28 <= 0 and var_146_10 or var_146_10 * (utf8.len(var_146_11) / 28)) > 0 and var_146_10 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_9 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_9
					end
				end

				arg_143_1.text_.text = var_146_11
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_10, arg_143_1.talkMaxDuration)

			if var_146_9 <= arg_143_1.time_ and arg_143_1.time_ < var_146_9 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_9) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_9 + var_146_14 and arg_143_1.time_ < var_146_9 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play115261035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 115261035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play115261036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 1.275

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(115261035).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 51 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 51)

				if (51 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 51)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play115261036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 115261036
		arg_151_1.duration_ = 6.03

		local var_151_0 = {
			ja = 5.8,
			ko = 6.033,
			zh = 4.3,
			en = 3.766
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
				arg_151_0:Play115261037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10030"]) and arg_151_1.var_.actorSpriteComps10030 == nil then
				arg_151_1.var_.actorSpriteComps10030 = arg_151_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10030"]) then
				if arg_151_1.var_.actorSpriteComps10030 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								iter_154_1.color = Color.New(Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, (arg_151_1.time_ - 0) / var_154_0), Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, (arg_151_1.time_ - 0) / var_154_0), (Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, (arg_151_1.time_ - 0) / var_154_0)))
							else
								local var_154_1 = Mathf.Lerp(iter_154_1.color.r, 1, (arg_151_1.time_ - 0) / var_154_0)

								iter_154_1.color = Color.New(var_154_1, var_154_1, var_154_1)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10030"]) and arg_151_1.var_.actorSpriteComps10030 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_151_1.var_.actorSpriteComps10030 = nil
			end

			local var_154_2 = arg_151_1.actors_["10030"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10030 = var_154_2.localPosition
				var_154_2.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10030", 4)

				for iter_154_4 = 0, var_154_2.childCount - 1 do
					local var_154_3 = var_154_2:GetChild(iter_154_4)

					if var_154_3.name == "split_3" or not string.find(var_154_3.name, "split") then
						var_154_3.gameObject:SetActive(true)
					else
						var_154_3.gameObject:SetActive(false)
					end
				end
			end

			local var_154_4 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				var_154_2.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_151_1.time_ - 0) / var_154_4)
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				var_154_2.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				local var_154_5 = arg_151_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_154_5 then
					arg_151_1.var_.alphaOldValue10030 = var_154_5.alpha
					arg_151_1.var_.characterEffect10030 = var_154_5
				end

				arg_151_1.var_.alphaOldValue10030 = 0
			end

			local var_154_6 = 0.5

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_6 then
				if arg_151_1.var_.characterEffect10030 then
					arg_151_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_151_1.var_.alphaOldValue10030, 1, (arg_151_1.time_ - 0) / var_154_6)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_6 and arg_151_1.time_ < 0 + var_154_6 + arg_154_0 and arg_151_1.var_.characterEffect10030 then
				arg_151_1.var_.characterEffect10030.alpha = 1
			end

			local var_154_7 = 0
			local var_154_8 = 0.35

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_9 = arg_151_1:GetWordFromCfg(115261036)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_12 = 14 <= 0 and var_154_8 or var_154_8 * (utf8.len(var_154_10) / 14)

				if (14 <= 0 and var_154_8 or var_154_8 * (utf8.len(var_154_10) / 14)) > 0 and var_154_8 < var_154_12 then
					arg_151_1.talkMaxDuration = var_154_12

					if var_154_12 + var_154_7 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_12 + var_154_7
					end
				end

				arg_151_1.text_.text = var_154_10
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261036", "story_v_out_115261.awb") ~= 0 then
					local var_154_13 = manager.audio:GetVoiceLength("story_v_out_115261", "115261036", "story_v_out_115261.awb") / 1000

					if var_154_13 + var_154_7 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_7
					end

					if var_154_9.prefab_name ~= "" and arg_151_1.actors_[var_154_9.prefab_name] ~= nil then
						local var_154_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_9.prefab_name].transform, "story_v_out_115261", "115261036", "story_v_out_115261.awb")

						arg_151_1:RecordAudio("115261036", var_154_14)
						arg_151_1:RecordAudio("115261036", var_154_14)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_115261", "115261036", "story_v_out_115261.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_115261", "115261036", "story_v_out_115261.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_15 = math.max(var_154_8, arg_151_1.talkMaxDuration)

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_15 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_7) / var_154_15

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_7 + var_154_15 and arg_151_1.time_ < var_154_7 + var_154_15 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play115261037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 115261037
		arg_155_1.duration_ = 9.5

		local var_155_0 = {
			ja = 9.5,
			ko = 7,
			zh = 7.7,
			en = 8.133
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
				arg_155_0:Play115261038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["10030"]) and arg_155_1.var_.actorSpriteComps10030 == nil then
				arg_155_1.var_.actorSpriteComps10030 = arg_155_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_0 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["10030"]) then
				if arg_155_1.var_.actorSpriteComps10030 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								iter_158_1.color = Color.New(Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor2.r, (arg_155_1.time_ - 0) / var_158_0), Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor2.g, (arg_155_1.time_ - 0) / var_158_0), (Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor2.b, (arg_155_1.time_ - 0) / var_158_0)))
							else
								local var_158_1 = Mathf.Lerp(iter_158_1.color.r, 0.5, (arg_155_1.time_ - 0) / var_158_0)

								iter_158_1.color = Color.New(var_158_1, var_158_1, var_158_1)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["10030"]) and arg_155_1.var_.actorSpriteComps10030 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_158_3 then
						iter_158_3.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_155_1.var_.actorSpriteComps10030 = nil
			end

			local var_158_2 = arg_155_1.actors_["1038"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps1038 == nil then
				arg_155_1.var_.actorSpriteComps1038 = var_158_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_3 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.actorSpriteComps1038 then
					for iter_158_4, iter_158_5 in pairs(arg_155_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_158_5 then
							if arg_155_1.isInRecall_ then
								iter_158_5.color = Color.New(Mathf.Lerp(iter_158_5.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_3), Mathf.Lerp(iter_158_5.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_3), (Mathf.Lerp(iter_158_5.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_3)))
							else
								local var_158_4 = Mathf.Lerp(iter_158_5.color.r, 1, (arg_155_1.time_ - 0) / var_158_3)

								iter_158_5.color = Color.New(var_158_4, var_158_4, var_158_4)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps1038 then
				for iter_158_6, iter_158_7 in pairs(arg_155_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_158_7 then
						iter_158_7.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps1038 = nil
			end

			local var_158_5 = arg_155_1.actors_["1038"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1038 = var_158_5.localPosition
				var_158_5.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1038", 2)

				for iter_158_8 = 0, var_158_5.childCount - 1 do
					local var_158_6 = var_158_5:GetChild(iter_158_8)

					if var_158_6.name == "split_1" or not string.find(var_158_6.name, "split") then
						var_158_6.gameObject:SetActive(true)
					else
						var_158_6.gameObject:SetActive(false)
					end
				end
			end

			local var_158_7 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				var_158_5.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_155_1.time_ - 0) / var_158_7)
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				var_158_5.localPosition = Vector3.New(-390, -400, 0)
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				local var_158_8 = arg_155_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_158_8 then
					arg_155_1.var_.alphaOldValue1038 = var_158_8.alpha
					arg_155_1.var_.characterEffect1038 = var_158_8
				end

				arg_155_1.var_.alphaOldValue1038 = 0
			end

			local var_158_9 = 0.034

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_9 then
				if arg_155_1.var_.characterEffect1038 then
					arg_155_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_155_1.var_.alphaOldValue1038, 1, (arg_155_1.time_ - 0) / var_158_9)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_9 and arg_155_1.time_ < 0 + var_158_9 + arg_158_0 and arg_155_1.var_.characterEffect1038 then
				arg_155_1.var_.characterEffect1038.alpha = 1
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				local var_158_10 = arg_155_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_158_10 then
					arg_155_1.var_.alphaOldValue1038 = var_158_10.alpha
					arg_155_1.var_.characterEffect1038 = var_158_10
				end

				arg_155_1.var_.alphaOldValue1038 = 0
			end

			local var_158_11 = 0.5

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_11 then
				if arg_155_1.var_.characterEffect1038 then
					arg_155_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_155_1.var_.alphaOldValue1038, 1, (arg_155_1.time_ - 0) / var_158_11)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_11 and arg_155_1.time_ < 0 + var_158_11 + arg_158_0 and arg_155_1.var_.characterEffect1038 then
				arg_155_1.var_.characterEffect1038.alpha = 1
			end

			local var_158_12 = 0
			local var_158_13 = 0.875

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_12 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_14 = arg_155_1:GetWordFromCfg(115261037)
				local var_158_15 = arg_155_1:FormatText(var_158_14.content)

				arg_155_1.text_.text = var_158_15

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_17 = 35 <= 0 and var_158_13 or var_158_13 * (utf8.len(var_158_15) / 35)

				if (35 <= 0 and var_158_13 or var_158_13 * (utf8.len(var_158_15) / 35)) > 0 and var_158_13 < var_158_17 then
					arg_155_1.talkMaxDuration = var_158_17

					if var_158_17 + var_158_12 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_17 + var_158_12
					end
				end

				arg_155_1.text_.text = var_158_15
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261037", "story_v_out_115261.awb") ~= 0 then
					local var_158_18 = manager.audio:GetVoiceLength("story_v_out_115261", "115261037", "story_v_out_115261.awb") / 1000

					if var_158_18 + var_158_12 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_18 + var_158_12
					end

					if var_158_14.prefab_name ~= "" and arg_155_1.actors_[var_158_14.prefab_name] ~= nil then
						local var_158_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_14.prefab_name].transform, "story_v_out_115261", "115261037", "story_v_out_115261.awb")

						arg_155_1:RecordAudio("115261037", var_158_19)
						arg_155_1:RecordAudio("115261037", var_158_19)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_115261", "115261037", "story_v_out_115261.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_115261", "115261037", "story_v_out_115261.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_20 = math.max(var_158_13, arg_155_1.talkMaxDuration)

			if var_158_12 <= arg_155_1.time_ and arg_155_1.time_ < var_158_12 + var_158_20 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_12) / var_158_20

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_12 + var_158_20 and arg_155_1.time_ < var_158_12 + var_158_20 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play115261038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 115261038
		arg_159_1.duration_ = 4.4

		local var_159_0 = {
			ja = 4.4,
			ko = 2.933,
			zh = 2.366,
			en = 2.466
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
				arg_159_0:Play115261039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["10030"]) and arg_159_1.var_.actorSpriteComps10030 == nil then
				arg_159_1.var_.actorSpriteComps10030 = arg_159_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_0 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["10030"]) then
				if arg_159_1.var_.actorSpriteComps10030 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								iter_162_1.color = Color.New(Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor1.r, (arg_159_1.time_ - 0) / var_162_0), Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor1.g, (arg_159_1.time_ - 0) / var_162_0), (Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor1.b, (arg_159_1.time_ - 0) / var_162_0)))
							else
								local var_162_1 = Mathf.Lerp(iter_162_1.color.r, 1, (arg_159_1.time_ - 0) / var_162_0)

								iter_162_1.color = Color.New(var_162_1, var_162_1, var_162_1)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["10030"]) and arg_159_1.var_.actorSpriteComps10030 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_162_3 then
						iter_162_3.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_159_1.var_.actorSpriteComps10030 = nil
			end

			local var_162_2 = arg_159_1.actors_["1038"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps1038 == nil then
				arg_159_1.var_.actorSpriteComps1038 = var_162_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_3 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_3 and not isNil(var_162_2) then
				if arg_159_1.var_.actorSpriteComps1038 then
					for iter_162_4, iter_162_5 in pairs(arg_159_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_162_5 then
							if arg_159_1.isInRecall_ then
								iter_162_5.color = Color.New(Mathf.Lerp(iter_162_5.color.r, arg_159_1.hightColor2.r, (arg_159_1.time_ - 0) / var_162_3), Mathf.Lerp(iter_162_5.color.g, arg_159_1.hightColor2.g, (arg_159_1.time_ - 0) / var_162_3), (Mathf.Lerp(iter_162_5.color.b, arg_159_1.hightColor2.b, (arg_159_1.time_ - 0) / var_162_3)))
							else
								local var_162_4 = Mathf.Lerp(iter_162_5.color.r, 0.5, (arg_159_1.time_ - 0) / var_162_3)

								iter_162_5.color = Color.New(var_162_4, var_162_4, var_162_4)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_3 and arg_159_1.time_ < 0 + var_162_3 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps1038 then
				for iter_162_6, iter_162_7 in pairs(arg_159_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_162_7 then
						iter_162_7.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_159_1.var_.actorSpriteComps1038 = nil
			end

			local var_162_5 = 0
			local var_162_6 = 0.175

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_7 = arg_159_1:GetWordFromCfg(115261038)
				local var_162_8 = arg_159_1:FormatText(var_162_7.content)

				arg_159_1.text_.text = var_162_8

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_10 = 7 <= 0 and var_162_6 or var_162_6 * (utf8.len(var_162_8) / 7)

				if (7 <= 0 and var_162_6 or var_162_6 * (utf8.len(var_162_8) / 7)) > 0 and var_162_6 < var_162_10 then
					arg_159_1.talkMaxDuration = var_162_10

					if var_162_10 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_5
					end
				end

				arg_159_1.text_.text = var_162_8
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261038", "story_v_out_115261.awb") ~= 0 then
					local var_162_11 = manager.audio:GetVoiceLength("story_v_out_115261", "115261038", "story_v_out_115261.awb") / 1000

					if var_162_11 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_5
					end

					if var_162_7.prefab_name ~= "" and arg_159_1.actors_[var_162_7.prefab_name] ~= nil then
						local var_162_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_7.prefab_name].transform, "story_v_out_115261", "115261038", "story_v_out_115261.awb")

						arg_159_1:RecordAudio("115261038", var_162_12)
						arg_159_1:RecordAudio("115261038", var_162_12)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_115261", "115261038", "story_v_out_115261.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_115261", "115261038", "story_v_out_115261.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_13 = math.max(var_162_6, arg_159_1.talkMaxDuration)

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_13 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_5) / var_162_13

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_5 + var_162_13 and arg_159_1.time_ < var_162_5 + var_162_13 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play115261039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 115261039
		arg_163_1.duration_ = 9.47

		local var_163_0 = {
			ja = 9.466,
			ko = 7.9,
			zh = 6.033,
			en = 8.766
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
				arg_163_0:Play115261040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.725

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:GetWordFromCfg(115261039)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 29 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 29)

				if (29 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 29)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261039", "story_v_out_115261.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261039", "story_v_out_115261.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_out_115261", "115261039", "story_v_out_115261.awb")

						arg_163_1:RecordAudio("115261039", var_166_6)
						arg_163_1:RecordAudio("115261039", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_115261", "115261039", "story_v_out_115261.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_115261", "115261039", "story_v_out_115261.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play115261040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 115261040
		arg_167_1.duration_ = 15.93

		local var_167_0 = {
			ja = 15.933,
			ko = 11.033,
			zh = 9.5,
			en = 10.5
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
				arg_167_0:Play115261041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 1

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(115261040)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 40 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 40)

				if (40 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 40)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261040", "story_v_out_115261.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261040", "story_v_out_115261.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_115261", "115261040", "story_v_out_115261.awb")

						arg_167_1:RecordAudio("115261040", var_170_6)
						arg_167_1:RecordAudio("115261040", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_115261", "115261040", "story_v_out_115261.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_115261", "115261040", "story_v_out_115261.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play115261041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 115261041
		arg_171_1.duration_ = 6.1

		local var_171_0 = {
			ja = 4.133,
			ko = 3.633,
			zh = 3.833,
			en = 6.1
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
				arg_171_0:Play115261042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["10030"]) and arg_171_1.var_.actorSpriteComps10030 == nil then
				arg_171_1.var_.actorSpriteComps10030 = arg_171_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_0 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["10030"]) then
				if arg_171_1.var_.actorSpriteComps10030 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								iter_174_1.color = Color.New(Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor2.r, (arg_171_1.time_ - 0) / var_174_0), Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor2.g, (arg_171_1.time_ - 0) / var_174_0), (Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor2.b, (arg_171_1.time_ - 0) / var_174_0)))
							else
								local var_174_1 = Mathf.Lerp(iter_174_1.color.r, 0.5, (arg_171_1.time_ - 0) / var_174_0)

								iter_174_1.color = Color.New(var_174_1, var_174_1, var_174_1)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["10030"]) and arg_171_1.var_.actorSpriteComps10030 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_174_3 then
						iter_174_3.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_171_1.var_.actorSpriteComps10030 = nil
			end

			local var_174_2 = arg_171_1.actors_["1038"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps1038 == nil then
				arg_171_1.var_.actorSpriteComps1038 = var_174_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_3 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.actorSpriteComps1038 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_174_5 then
							if arg_171_1.isInRecall_ then
								iter_174_5.color = Color.New(Mathf.Lerp(iter_174_5.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_3), Mathf.Lerp(iter_174_5.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_3), (Mathf.Lerp(iter_174_5.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_3)))
							else
								local var_174_4 = Mathf.Lerp(iter_174_5.color.r, 1, (arg_171_1.time_ - 0) / var_174_3)

								iter_174_5.color = Color.New(var_174_4, var_174_4, var_174_4)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps1038 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_174_7 then
						iter_174_7.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps1038 = nil
			end

			local var_174_5 = 0
			local var_174_6 = 0.325

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_7 = arg_171_1:GetWordFromCfg(115261041)
				local var_174_8 = arg_171_1:FormatText(var_174_7.content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_10 = 13 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 13)

				if (13 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 13)) > 0 and var_174_6 < var_174_10 then
					arg_171_1.talkMaxDuration = var_174_10

					if var_174_10 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261041", "story_v_out_115261.awb") ~= 0 then
					local var_174_11 = manager.audio:GetVoiceLength("story_v_out_115261", "115261041", "story_v_out_115261.awb") / 1000

					if var_174_11 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_5
					end

					if var_174_7.prefab_name ~= "" and arg_171_1.actors_[var_174_7.prefab_name] ~= nil then
						local var_174_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_7.prefab_name].transform, "story_v_out_115261", "115261041", "story_v_out_115261.awb")

						arg_171_1:RecordAudio("115261041", var_174_12)
						arg_171_1:RecordAudio("115261041", var_174_12)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_115261", "115261041", "story_v_out_115261.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_115261", "115261041", "story_v_out_115261.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_13 = math.max(var_174_6, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_13 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_5) / var_174_13

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_13 and arg_171_1.time_ < var_174_5 + var_174_13 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play115261042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 115261042
		arg_175_1.duration_ = 12.3

		local var_175_0 = {
			ja = 12.3,
			ko = 10.366,
			zh = 8.2,
			en = 10.2
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
				arg_175_0:Play115261043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["10030"]) and arg_175_1.var_.actorSpriteComps10030 == nil then
				arg_175_1.var_.actorSpriteComps10030 = arg_175_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_0 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["10030"]) then
				if arg_175_1.var_.actorSpriteComps10030 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_178_1 then
							if arg_175_1.isInRecall_ then
								iter_178_1.color = Color.New(Mathf.Lerp(iter_178_1.color.r, arg_175_1.hightColor1.r, (arg_175_1.time_ - 0) / var_178_0), Mathf.Lerp(iter_178_1.color.g, arg_175_1.hightColor1.g, (arg_175_1.time_ - 0) / var_178_0), (Mathf.Lerp(iter_178_1.color.b, arg_175_1.hightColor1.b, (arg_175_1.time_ - 0) / var_178_0)))
							else
								local var_178_1 = Mathf.Lerp(iter_178_1.color.r, 1, (arg_175_1.time_ - 0) / var_178_0)

								iter_178_1.color = Color.New(var_178_1, var_178_1, var_178_1)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["10030"]) and arg_175_1.var_.actorSpriteComps10030 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_178_3 then
						iter_178_3.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps10030 = nil
			end

			local var_178_2 = arg_175_1.actors_["1038"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1038 == nil then
				arg_175_1.var_.actorSpriteComps1038 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps1038 then
					for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_178_5 then
							if arg_175_1.isInRecall_ then
								iter_178_5.color = Color.New(Mathf.Lerp(iter_178_5.color.r, arg_175_1.hightColor2.r, (arg_175_1.time_ - 0) / var_178_3), Mathf.Lerp(iter_178_5.color.g, arg_175_1.hightColor2.g, (arg_175_1.time_ - 0) / var_178_3), (Mathf.Lerp(iter_178_5.color.b, arg_175_1.hightColor2.b, (arg_175_1.time_ - 0) / var_178_3)))
							else
								local var_178_4 = Mathf.Lerp(iter_178_5.color.r, 0.5, (arg_175_1.time_ - 0) / var_178_3)

								iter_178_5.color = Color.New(var_178_4, var_178_4, var_178_4)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1038 then
				for iter_178_6, iter_178_7 in pairs(arg_175_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_178_7 then
						iter_178_7.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps1038 = nil
			end

			local var_178_5 = 0
			local var_178_6 = 0.95

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_7 = arg_175_1:GetWordFromCfg(115261042)
				local var_178_8 = arg_175_1:FormatText(var_178_7.content)

				arg_175_1.text_.text = var_178_8

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_10 = 38 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_8) / 38)

				if (38 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_8) / 38)) > 0 and var_178_6 < var_178_10 then
					arg_175_1.talkMaxDuration = var_178_10

					if var_178_10 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_5
					end
				end

				arg_175_1.text_.text = var_178_8
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261042", "story_v_out_115261.awb") ~= 0 then
					local var_178_11 = manager.audio:GetVoiceLength("story_v_out_115261", "115261042", "story_v_out_115261.awb") / 1000

					if var_178_11 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_5
					end

					if var_178_7.prefab_name ~= "" and arg_175_1.actors_[var_178_7.prefab_name] ~= nil then
						local var_178_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_7.prefab_name].transform, "story_v_out_115261", "115261042", "story_v_out_115261.awb")

						arg_175_1:RecordAudio("115261042", var_178_12)
						arg_175_1:RecordAudio("115261042", var_178_12)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_115261", "115261042", "story_v_out_115261.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_115261", "115261042", "story_v_out_115261.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_13 = math.max(var_178_6, arg_175_1.talkMaxDuration)

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_13 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_5) / var_178_13

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_5 + var_178_13 and arg_175_1.time_ < var_178_5 + var_178_13 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play115261043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 115261043
		arg_179_1.duration_ = 12

		local var_179_0 = {
			ja = 7.866,
			ko = 10.7,
			zh = 9.7,
			en = 12
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play115261044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["10030"]) and arg_179_1.var_.actorSpriteComps10030 == nil then
				arg_179_1.var_.actorSpriteComps10030 = arg_179_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["10030"]) then
				if arg_179_1.var_.actorSpriteComps10030 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								iter_182_1.color = Color.New(Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_0), Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_0), (Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_0)))
							else
								local var_182_1 = Mathf.Lerp(iter_182_1.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_0)

								iter_182_1.color = Color.New(var_182_1, var_182_1, var_182_1)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["10030"]) and arg_179_1.var_.actorSpriteComps10030 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps10030 = nil
			end

			local var_182_2 = arg_179_1.actors_["1038"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps1038 == nil then
				arg_179_1.var_.actorSpriteComps1038 = var_182_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_3 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.actorSpriteComps1038 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_182_5 then
							if arg_179_1.isInRecall_ then
								iter_182_5.color = Color.New(Mathf.Lerp(iter_182_5.color.r, arg_179_1.hightColor1.r, (arg_179_1.time_ - 0) / var_182_3), Mathf.Lerp(iter_182_5.color.g, arg_179_1.hightColor1.g, (arg_179_1.time_ - 0) / var_182_3), (Mathf.Lerp(iter_182_5.color.b, arg_179_1.hightColor1.b, (arg_179_1.time_ - 0) / var_182_3)))
							else
								local var_182_4 = Mathf.Lerp(iter_182_5.color.r, 1, (arg_179_1.time_ - 0) / var_182_3)

								iter_182_5.color = Color.New(var_182_4, var_182_4, var_182_4)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps1038 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_182_7 then
						iter_182_7.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps1038 = nil
			end

			local var_182_5 = 0
			local var_182_6 = 0.875

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_7 = arg_179_1:GetWordFromCfg(115261043)
				local var_182_8 = arg_179_1:FormatText(var_182_7.content)

				arg_179_1.text_.text = var_182_8

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_10 = 35 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 35)

				if (35 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 35)) > 0 and var_182_6 < var_182_10 then
					arg_179_1.talkMaxDuration = var_182_10

					if var_182_10 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_5
					end
				end

				arg_179_1.text_.text = var_182_8
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261043", "story_v_out_115261.awb") ~= 0 then
					local var_182_11 = manager.audio:GetVoiceLength("story_v_out_115261", "115261043", "story_v_out_115261.awb") / 1000

					if var_182_11 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_5
					end

					if var_182_7.prefab_name ~= "" and arg_179_1.actors_[var_182_7.prefab_name] ~= nil then
						local var_182_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_7.prefab_name].transform, "story_v_out_115261", "115261043", "story_v_out_115261.awb")

						arg_179_1:RecordAudio("115261043", var_182_12)
						arg_179_1:RecordAudio("115261043", var_182_12)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_115261", "115261043", "story_v_out_115261.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_115261", "115261043", "story_v_out_115261.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_13 = math.max(var_182_6, arg_179_1.talkMaxDuration)

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_13 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_5) / var_182_13

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_5 + var_182_13 and arg_179_1.time_ < var_182_5 + var_182_13 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play115261044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 115261044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play115261045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0.5 < arg_183_1.time_ and arg_183_1.time_ <= 0.5 + arg_186_0 then
				arg_183_1.var_.moveOldPos10030 = arg_183_1.actors_["10030"].transform.localPosition
				arg_183_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10030", 0)

				for iter_186_0 = 0, arg_183_1.actors_["10030"].transform.childCount - 1 do
					local var_186_0 = arg_183_1.actors_["10030"].transform:GetChild(iter_186_0)

					if var_186_0.name == "split_3" or not string.find(var_186_0.name, "split") then
						var_186_0.gameObject:SetActive(true)
					else
						var_186_0.gameObject:SetActive(false)
					end
				end
			end

			local var_186_1 = 0.001

			if 0.5 <= arg_183_1.time_ and arg_183_1.time_ < 0.5 + var_186_1 then
				arg_183_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10030, Vector3.New(-2000, -390, 150), (arg_183_1.time_ - 0.5) / var_186_1)
			end

			if arg_183_1.time_ >= 0.5 + var_186_1 and arg_183_1.time_ < 0.5 + var_186_1 + arg_186_0 then
				arg_183_1.actors_["10030"].transform.localPosition = Vector3.New(-2000, -390, 150)
			end

			local var_186_2 = arg_183_1.actors_["1038"].transform

			if 0.5 < arg_183_1.time_ and arg_183_1.time_ <= 0.5 + arg_186_0 then
				arg_183_1.var_.moveOldPos1038 = var_186_2.localPosition
				var_186_2.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1038", 0)

				for iter_186_1 = 0, var_186_2.childCount - 1 do
					local var_186_3 = var_186_2:GetChild(iter_186_1)

					if var_186_3.name == "split_1" or not string.find(var_186_3.name, "split") then
						var_186_3.gameObject:SetActive(true)
					else
						var_186_3.gameObject:SetActive(false)
					end
				end
			end

			local var_186_4 = 0.001

			if 0.5 <= arg_183_1.time_ and arg_183_1.time_ < 0.5 + var_186_4 then
				var_186_2.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1038, Vector3.New(-2000, -400, 0), (arg_183_1.time_ - 0.5) / var_186_4)
			end

			if arg_183_1.time_ >= 0.5 + var_186_4 and arg_183_1.time_ < 0.5 + var_186_4 + arg_186_0 then
				var_186_2.localPosition = Vector3.New(-2000, -400, 0)
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				local var_186_5 = arg_183_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_186_5 then
					arg_183_1.var_.alphaOldValue10030 = var_186_5.alpha
					arg_183_1.var_.characterEffect10030 = var_186_5
				end

				arg_183_1.var_.alphaOldValue10030 = 1
			end

			local var_186_6 = 0.5

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_6 then
				if arg_183_1.var_.characterEffect10030 then
					arg_183_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_183_1.var_.alphaOldValue10030, 0, (arg_183_1.time_ - 0) / var_186_6)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_6 and arg_183_1.time_ < 0 + var_186_6 + arg_186_0 and arg_183_1.var_.characterEffect10030 then
				arg_183_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				local var_186_7 = arg_183_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_186_7 then
					arg_183_1.var_.alphaOldValue1038 = var_186_7.alpha
					arg_183_1.var_.characterEffect1038 = var_186_7
				end

				arg_183_1.var_.alphaOldValue1038 = 1
			end

			local var_186_8 = 0.5

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_8 then
				if arg_183_1.var_.characterEffect1038 then
					arg_183_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_183_1.var_.alphaOldValue1038, 0, (arg_183_1.time_ - 0) / var_186_8)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_8 and arg_183_1.time_ < 0 + var_186_8 + arg_186_0 and arg_183_1.var_.characterEffect1038 then
				arg_183_1.var_.characterEffect1038.alpha = 0
			end

			local var_186_9 = 0
			local var_186_10 = 1.175

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_9 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_11 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(115261044).content)

				arg_183_1.text_.text = var_186_11

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_13 = 47 <= 0 and var_186_10 or var_186_10 * (utf8.len(var_186_11) / 47)

				if (47 <= 0 and var_186_10 or var_186_10 * (utf8.len(var_186_11) / 47)) > 0 and var_186_10 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_9 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_9
					end
				end

				arg_183_1.text_.text = var_186_11
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_10, arg_183_1.talkMaxDuration)

			if var_186_9 <= arg_183_1.time_ and arg_183_1.time_ < var_186_9 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_9) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_9 + var_186_14 and arg_183_1.time_ < var_186_9 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play115261045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 115261045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play115261046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 1.225

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(115261045).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 49 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 49)

				if (49 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 49)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play115261046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 115261046
		arg_191_1.duration_ = 6.87

		local var_191_0 = {
			ja = 4.533,
			ko = 6.2,
			zh = 5.166,
			en = 6.866
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
				arg_191_0:Play115261047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10030 = arg_191_1.actors_["10030"].transform.localPosition
				arg_191_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10030", 4)

				for iter_194_0 = 0, arg_191_1.actors_["10030"].transform.childCount - 1 do
					local var_194_0 = arg_191_1.actors_["10030"].transform:GetChild(iter_194_0)

					if var_194_0.name == "split_3" or not string.find(var_194_0.name, "split") then
						var_194_0.gameObject:SetActive(true)
					else
						var_194_0.gameObject:SetActive(false)
					end
				end
			end

			local var_194_1 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_1 then
				arg_191_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_191_1.time_ - 0) / var_194_1)
			end

			if arg_191_1.time_ >= 0 + var_194_1 and arg_191_1.time_ < 0 + var_194_1 + arg_194_0 then
				arg_191_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_194_2 = arg_191_1.actors_["10030"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps10030 == nil then
				arg_191_1.var_.actorSpriteComps10030 = var_194_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_3 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_3 and not isNil(var_194_2) then
				if arg_191_1.var_.actorSpriteComps10030 then
					for iter_194_1, iter_194_2 in pairs(arg_191_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_194_2 then
							if arg_191_1.isInRecall_ then
								iter_194_2.color = Color.New(Mathf.Lerp(iter_194_2.color.r, arg_191_1.hightColor1.r, (arg_191_1.time_ - 0) / var_194_3), Mathf.Lerp(iter_194_2.color.g, arg_191_1.hightColor1.g, (arg_191_1.time_ - 0) / var_194_3), (Mathf.Lerp(iter_194_2.color.b, arg_191_1.hightColor1.b, (arg_191_1.time_ - 0) / var_194_3)))
							else
								local var_194_4 = Mathf.Lerp(iter_194_2.color.r, 1, (arg_191_1.time_ - 0) / var_194_3)

								iter_194_2.color = Color.New(var_194_4, var_194_4, var_194_4)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_3 and arg_191_1.time_ < 0 + var_194_3 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps10030 then
				for iter_194_3, iter_194_4 in pairs(arg_191_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_194_4 then
						iter_194_4.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_191_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				local var_194_5 = arg_191_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_194_5 then
					arg_191_1.var_.alphaOldValue10030 = var_194_5.alpha
					arg_191_1.var_.characterEffect10030 = var_194_5
				end

				arg_191_1.var_.alphaOldValue10030 = 0
			end

			local var_194_6 = 0.5

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_6 then
				if arg_191_1.var_.characterEffect10030 then
					arg_191_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_191_1.var_.alphaOldValue10030, 1, (arg_191_1.time_ - 0) / var_194_6)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_6 and arg_191_1.time_ < 0 + var_194_6 + arg_194_0 and arg_191_1.var_.characterEffect10030 then
				arg_191_1.var_.characterEffect10030.alpha = 1
			end

			local var_194_7 = 0
			local var_194_8 = 0.65

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_7 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_9 = arg_191_1:GetWordFromCfg(115261046)
				local var_194_10 = arg_191_1:FormatText(var_194_9.content)

				arg_191_1.text_.text = var_194_10

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_12 = 26 <= 0 and var_194_8 or var_194_8 * (utf8.len(var_194_10) / 26)

				if (26 <= 0 and var_194_8 or var_194_8 * (utf8.len(var_194_10) / 26)) > 0 and var_194_8 < var_194_12 then
					arg_191_1.talkMaxDuration = var_194_12

					if var_194_12 + var_194_7 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_7
					end
				end

				arg_191_1.text_.text = var_194_10
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261046", "story_v_out_115261.awb") ~= 0 then
					local var_194_13 = manager.audio:GetVoiceLength("story_v_out_115261", "115261046", "story_v_out_115261.awb") / 1000

					if var_194_13 + var_194_7 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_7
					end

					if var_194_9.prefab_name ~= "" and arg_191_1.actors_[var_194_9.prefab_name] ~= nil then
						local var_194_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_9.prefab_name].transform, "story_v_out_115261", "115261046", "story_v_out_115261.awb")

						arg_191_1:RecordAudio("115261046", var_194_14)
						arg_191_1:RecordAudio("115261046", var_194_14)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_115261", "115261046", "story_v_out_115261.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_115261", "115261046", "story_v_out_115261.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_15 = math.max(var_194_8, arg_191_1.talkMaxDuration)

			if var_194_7 <= arg_191_1.time_ and arg_191_1.time_ < var_194_7 + var_194_15 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_7) / var_194_15

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_7 + var_194_15 and arg_191_1.time_ < var_194_7 + var_194_15 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play115261047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 115261047
		arg_195_1.duration_ = 13

		local var_195_0 = {
			ja = 12.933,
			ko = 11.533,
			zh = 13,
			en = 12.933
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play115261048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["10030"]) and arg_195_1.var_.actorSpriteComps10030 == nil then
				arg_195_1.var_.actorSpriteComps10030 = arg_195_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_0 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["10030"]) then
				if arg_195_1.var_.actorSpriteComps10030 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								iter_198_1.color = Color.New(Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor2.r, (arg_195_1.time_ - 0) / var_198_0), Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor2.g, (arg_195_1.time_ - 0) / var_198_0), (Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor2.b, (arg_195_1.time_ - 0) / var_198_0)))
							else
								local var_198_1 = Mathf.Lerp(iter_198_1.color.r, 0.5, (arg_195_1.time_ - 0) / var_198_0)

								iter_198_1.color = Color.New(var_198_1, var_198_1, var_198_1)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["10030"]) and arg_195_1.var_.actorSpriteComps10030 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_198_3 then
						iter_198_3.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps10030 = nil
			end

			local var_198_2 = arg_195_1.actors_["1038"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1038 = var_198_2.localPosition
				var_198_2.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1038", 2)

				for iter_198_4 = 0, var_198_2.childCount - 1 do
					local var_198_3 = var_198_2:GetChild(iter_198_4)

					if var_198_3.name == "split_1" or not string.find(var_198_3.name, "split") then
						var_198_3.gameObject:SetActive(true)
					else
						var_198_3.gameObject:SetActive(false)
					end
				end
			end

			local var_198_4 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				var_198_2.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_195_1.time_ - 0) / var_198_4)
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				var_198_2.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_198_5 = arg_195_1.actors_["1038"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.actorSpriteComps1038 == nil then
				arg_195_1.var_.actorSpriteComps1038 = var_198_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_6 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_6 and not isNil(var_198_5) then
				if arg_195_1.var_.actorSpriteComps1038 then
					for iter_198_5, iter_198_6 in pairs(arg_195_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_198_6 then
							if arg_195_1.isInRecall_ then
								iter_198_6.color = Color.New(Mathf.Lerp(iter_198_6.color.r, arg_195_1.hightColor1.r, (arg_195_1.time_ - 0) / var_198_6), Mathf.Lerp(iter_198_6.color.g, arg_195_1.hightColor1.g, (arg_195_1.time_ - 0) / var_198_6), (Mathf.Lerp(iter_198_6.color.b, arg_195_1.hightColor1.b, (arg_195_1.time_ - 0) / var_198_6)))
							else
								local var_198_7 = Mathf.Lerp(iter_198_6.color.r, 1, (arg_195_1.time_ - 0) / var_198_6)

								iter_198_6.color = Color.New(var_198_7, var_198_7, var_198_7)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_6 and arg_195_1.time_ < 0 + var_198_6 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.actorSpriteComps1038 then
				for iter_198_7, iter_198_8 in pairs(arg_195_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_198_8 then
						iter_198_8.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_195_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				local var_198_8 = arg_195_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_198_8 then
					arg_195_1.var_.alphaOldValue1038 = var_198_8.alpha
					arg_195_1.var_.characterEffect1038 = var_198_8
				end

				arg_195_1.var_.alphaOldValue1038 = 0
			end

			local var_198_9 = 0.5

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_9 then
				if arg_195_1.var_.characterEffect1038 then
					arg_195_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_195_1.var_.alphaOldValue1038, 1, (arg_195_1.time_ - 0) / var_198_9)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_9 and arg_195_1.time_ < 0 + var_198_9 + arg_198_0 and arg_195_1.var_.characterEffect1038 then
				arg_195_1.var_.characterEffect1038.alpha = 1
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				local var_198_10 = arg_195_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_198_10 then
					arg_195_1.var_.alphaOldValue10030 = var_198_10.alpha
					arg_195_1.var_.characterEffect10030 = var_198_10
				end

				arg_195_1.var_.alphaOldValue10030 = 0
			end

			local var_198_11 = 0.0166666666666667

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_11 then
				if arg_195_1.var_.characterEffect10030 then
					arg_195_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_195_1.var_.alphaOldValue10030, 1, (arg_195_1.time_ - 0) / var_198_11)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_11 and arg_195_1.time_ < 0 + var_198_11 + arg_198_0 and arg_195_1.var_.characterEffect10030 then
				arg_195_1.var_.characterEffect10030.alpha = 1
			end

			local var_198_12 = 0
			local var_198_13 = 1.225

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_12 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_14 = arg_195_1:GetWordFromCfg(115261047)
				local var_198_15 = arg_195_1:FormatText(var_198_14.content)

				arg_195_1.text_.text = var_198_15

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_17 = 49 <= 0 and var_198_13 or var_198_13 * (utf8.len(var_198_15) / 49)

				if (49 <= 0 and var_198_13 or var_198_13 * (utf8.len(var_198_15) / 49)) > 0 and var_198_13 < var_198_17 then
					arg_195_1.talkMaxDuration = var_198_17

					if var_198_17 + var_198_12 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_17 + var_198_12
					end
				end

				arg_195_1.text_.text = var_198_15
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261047", "story_v_out_115261.awb") ~= 0 then
					local var_198_18 = manager.audio:GetVoiceLength("story_v_out_115261", "115261047", "story_v_out_115261.awb") / 1000

					if var_198_18 + var_198_12 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_18 + var_198_12
					end

					if var_198_14.prefab_name ~= "" and arg_195_1.actors_[var_198_14.prefab_name] ~= nil then
						local var_198_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_14.prefab_name].transform, "story_v_out_115261", "115261047", "story_v_out_115261.awb")

						arg_195_1:RecordAudio("115261047", var_198_19)
						arg_195_1:RecordAudio("115261047", var_198_19)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_115261", "115261047", "story_v_out_115261.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_115261", "115261047", "story_v_out_115261.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_20 = math.max(var_198_13, arg_195_1.talkMaxDuration)

			if var_198_12 <= arg_195_1.time_ and arg_195_1.time_ < var_198_12 + var_198_20 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_12) / var_198_20

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_12 + var_198_20 and arg_195_1.time_ < var_198_12 + var_198_20 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play115261048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 115261048
		arg_199_1.duration_ = 8.5

		local var_199_0 = {
			ja = 8.5,
			ko = 5.1,
			zh = 4,
			en = 6.433
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play115261049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["10030"]) and arg_199_1.var_.actorSpriteComps10030 == nil then
				arg_199_1.var_.actorSpriteComps10030 = arg_199_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_0 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["10030"]) then
				if arg_199_1.var_.actorSpriteComps10030 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								iter_202_1.color = Color.New(Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor1.r, (arg_199_1.time_ - 0) / var_202_0), Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor1.g, (arg_199_1.time_ - 0) / var_202_0), (Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor1.b, (arg_199_1.time_ - 0) / var_202_0)))
							else
								local var_202_1 = Mathf.Lerp(iter_202_1.color.r, 1, (arg_199_1.time_ - 0) / var_202_0)

								iter_202_1.color = Color.New(var_202_1, var_202_1, var_202_1)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["10030"]) and arg_199_1.var_.actorSpriteComps10030 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_202_3 then
						iter_202_3.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps10030 = nil
			end

			local var_202_2 = arg_199_1.actors_["1038"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps1038 == nil then
				arg_199_1.var_.actorSpriteComps1038 = var_202_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_3 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.actorSpriteComps1038 then
					for iter_202_4, iter_202_5 in pairs(arg_199_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_202_5 then
							if arg_199_1.isInRecall_ then
								iter_202_5.color = Color.New(Mathf.Lerp(iter_202_5.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_3), Mathf.Lerp(iter_202_5.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_3), (Mathf.Lerp(iter_202_5.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_3)))
							else
								local var_202_4 = Mathf.Lerp(iter_202_5.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_3)

								iter_202_5.color = Color.New(var_202_4, var_202_4, var_202_4)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps1038 then
				for iter_202_6, iter_202_7 in pairs(arg_199_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_202_7 then
						iter_202_7.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps1038 = nil
			end

			local var_202_5 = arg_199_1.actors_["10030"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10030 = var_202_5.localPosition
				var_202_5.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10030", 4)

				for iter_202_8 = 0, var_202_5.childCount - 1 do
					local var_202_6 = var_202_5:GetChild(iter_202_8)

					if var_202_6.name == "split_1" or not string.find(var_202_6.name, "split") then
						var_202_6.gameObject:SetActive(true)
					else
						var_202_6.gameObject:SetActive(false)
					end
				end
			end

			local var_202_7 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				var_202_5.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_199_1.time_ - 0) / var_202_7)
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				var_202_5.localPosition = Vector3.New(390, -390, 150)
			end

			local var_202_8 = 0
			local var_202_9 = 0.45

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_10 = arg_199_1:GetWordFromCfg(115261048)
				local var_202_11 = arg_199_1:FormatText(var_202_10.content)

				arg_199_1.text_.text = var_202_11

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_13 = 18 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_11) / 18)

				if (18 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_11) / 18)) > 0 and var_202_9 < var_202_13 then
					arg_199_1.talkMaxDuration = var_202_13

					if var_202_13 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_8
					end
				end

				arg_199_1.text_.text = var_202_11
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261048", "story_v_out_115261.awb") ~= 0 then
					local var_202_14 = manager.audio:GetVoiceLength("story_v_out_115261", "115261048", "story_v_out_115261.awb") / 1000

					if var_202_14 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_14 + var_202_8
					end

					if var_202_10.prefab_name ~= "" and arg_199_1.actors_[var_202_10.prefab_name] ~= nil then
						local var_202_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_10.prefab_name].transform, "story_v_out_115261", "115261048", "story_v_out_115261.awb")

						arg_199_1:RecordAudio("115261048", var_202_15)
						arg_199_1:RecordAudio("115261048", var_202_15)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_115261", "115261048", "story_v_out_115261.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_115261", "115261048", "story_v_out_115261.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_16 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_16

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_16 and arg_199_1.time_ < var_202_8 + var_202_16 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play115261049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 115261049
		arg_203_1.duration_ = 11.1

		local var_203_0 = {
			ja = 11.1,
			ko = 8.966,
			zh = 8.733,
			en = 8.8
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play115261050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["10030"]) and arg_203_1.var_.actorSpriteComps10030 == nil then
				arg_203_1.var_.actorSpriteComps10030 = arg_203_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["10030"]) then
				if arg_203_1.var_.actorSpriteComps10030 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								iter_206_1.color = Color.New(Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor2.r, (arg_203_1.time_ - 0) / var_206_0), Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor2.g, (arg_203_1.time_ - 0) / var_206_0), (Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor2.b, (arg_203_1.time_ - 0) / var_206_0)))
							else
								local var_206_1 = Mathf.Lerp(iter_206_1.color.r, 0.5, (arg_203_1.time_ - 0) / var_206_0)

								iter_206_1.color = Color.New(var_206_1, var_206_1, var_206_1)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["10030"]) and arg_203_1.var_.actorSpriteComps10030 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_206_3 then
						iter_206_3.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_203_1.var_.actorSpriteComps10030 = nil
			end

			local var_206_2 = arg_203_1.actors_["1038"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps1038 == nil then
				arg_203_1.var_.actorSpriteComps1038 = var_206_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_3 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_3 and not isNil(var_206_2) then
				if arg_203_1.var_.actorSpriteComps1038 then
					for iter_206_4, iter_206_5 in pairs(arg_203_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_206_5 then
							if arg_203_1.isInRecall_ then
								iter_206_5.color = Color.New(Mathf.Lerp(iter_206_5.color.r, arg_203_1.hightColor1.r, (arg_203_1.time_ - 0) / var_206_3), Mathf.Lerp(iter_206_5.color.g, arg_203_1.hightColor1.g, (arg_203_1.time_ - 0) / var_206_3), (Mathf.Lerp(iter_206_5.color.b, arg_203_1.hightColor1.b, (arg_203_1.time_ - 0) / var_206_3)))
							else
								local var_206_4 = Mathf.Lerp(iter_206_5.color.r, 1, (arg_203_1.time_ - 0) / var_206_3)

								iter_206_5.color = Color.New(var_206_4, var_206_4, var_206_4)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_3 and arg_203_1.time_ < 0 + var_206_3 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps1038 then
				for iter_206_6, iter_206_7 in pairs(arg_203_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_206_7 then
						iter_206_7.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_203_1.var_.actorSpriteComps1038 = nil
			end

			local var_206_5 = 0
			local var_206_6 = 0.8

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_7 = arg_203_1:GetWordFromCfg(115261049)
				local var_206_8 = arg_203_1:FormatText(var_206_7.content)

				arg_203_1.text_.text = var_206_8

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_10 = 32 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 32)

				if (32 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 32)) > 0 and var_206_6 < var_206_10 then
					arg_203_1.talkMaxDuration = var_206_10

					if var_206_10 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_5
					end
				end

				arg_203_1.text_.text = var_206_8
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261049", "story_v_out_115261.awb") ~= 0 then
					local var_206_11 = manager.audio:GetVoiceLength("story_v_out_115261", "115261049", "story_v_out_115261.awb") / 1000

					if var_206_11 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_5
					end

					if var_206_7.prefab_name ~= "" and arg_203_1.actors_[var_206_7.prefab_name] ~= nil then
						local var_206_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_7.prefab_name].transform, "story_v_out_115261", "115261049", "story_v_out_115261.awb")

						arg_203_1:RecordAudio("115261049", var_206_12)
						arg_203_1:RecordAudio("115261049", var_206_12)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_115261", "115261049", "story_v_out_115261.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_115261", "115261049", "story_v_out_115261.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_13 = math.max(var_206_6, arg_203_1.talkMaxDuration)

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_13 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_5) / var_206_13

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_5 + var_206_13 and arg_203_1.time_ < var_206_5 + var_206_13 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play115261050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 115261050
		arg_207_1.duration_ = 6.17

		local var_207_0 = {
			ja = 6.166,
			ko = 4.7,
			zh = 4.633,
			en = 4.866
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play115261051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["10030"]) and arg_207_1.var_.actorSpriteComps10030 == nil then
				arg_207_1.var_.actorSpriteComps10030 = arg_207_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_0 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["10030"]) then
				if arg_207_1.var_.actorSpriteComps10030 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								iter_210_1.color = Color.New(Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor1.r, (arg_207_1.time_ - 0) / var_210_0), Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor1.g, (arg_207_1.time_ - 0) / var_210_0), (Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor1.b, (arg_207_1.time_ - 0) / var_210_0)))
							else
								local var_210_1 = Mathf.Lerp(iter_210_1.color.r, 1, (arg_207_1.time_ - 0) / var_210_0)

								iter_210_1.color = Color.New(var_210_1, var_210_1, var_210_1)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["10030"]) and arg_207_1.var_.actorSpriteComps10030 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_210_3 then
						iter_210_3.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_207_1.var_.actorSpriteComps10030 = nil
			end

			local var_210_2 = arg_207_1.actors_["1038"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps1038 == nil then
				arg_207_1.var_.actorSpriteComps1038 = var_210_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_3 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 and not isNil(var_210_2) then
				if arg_207_1.var_.actorSpriteComps1038 then
					for iter_210_4, iter_210_5 in pairs(arg_207_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_210_5 then
							if arg_207_1.isInRecall_ then
								iter_210_5.color = Color.New(Mathf.Lerp(iter_210_5.color.r, arg_207_1.hightColor2.r, (arg_207_1.time_ - 0) / var_210_3), Mathf.Lerp(iter_210_5.color.g, arg_207_1.hightColor2.g, (arg_207_1.time_ - 0) / var_210_3), (Mathf.Lerp(iter_210_5.color.b, arg_207_1.hightColor2.b, (arg_207_1.time_ - 0) / var_210_3)))
							else
								local var_210_4 = Mathf.Lerp(iter_210_5.color.r, 0.5, (arg_207_1.time_ - 0) / var_210_3)

								iter_210_5.color = Color.New(var_210_4, var_210_4, var_210_4)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps1038 then
				for iter_210_6, iter_210_7 in pairs(arg_207_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_210_7 then
						iter_210_7.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_207_1.var_.actorSpriteComps1038 = nil
			end

			local var_210_5 = arg_207_1.actors_["10030"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10030 = var_210_5.localPosition
				var_210_5.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10030", 4)

				for iter_210_8 = 0, var_210_5.childCount - 1 do
					local var_210_6 = var_210_5:GetChild(iter_210_8)

					if var_210_6.name == "split_3" or not string.find(var_210_6.name, "split") then
						var_210_6.gameObject:SetActive(true)
					else
						var_210_6.gameObject:SetActive(false)
					end
				end
			end

			local var_210_7 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				var_210_5.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_207_1.time_ - 0) / var_210_7)
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				var_210_5.localPosition = Vector3.New(390, -390, 150)
			end

			local var_210_8 = 0
			local var_210_9 = 0.45

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_10 = arg_207_1:GetWordFromCfg(115261050)
				local var_210_11 = arg_207_1:FormatText(var_210_10.content)

				arg_207_1.text_.text = var_210_11

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_13 = 18 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 18)

				if (18 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 18)) > 0 and var_210_9 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_8
					end
				end

				arg_207_1.text_.text = var_210_11
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261050", "story_v_out_115261.awb") ~= 0 then
					local var_210_14 = manager.audio:GetVoiceLength("story_v_out_115261", "115261050", "story_v_out_115261.awb") / 1000

					if var_210_14 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_14 + var_210_8
					end

					if var_210_10.prefab_name ~= "" and arg_207_1.actors_[var_210_10.prefab_name] ~= nil then
						local var_210_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_10.prefab_name].transform, "story_v_out_115261", "115261050", "story_v_out_115261.awb")

						arg_207_1:RecordAudio("115261050", var_210_15)
						arg_207_1:RecordAudio("115261050", var_210_15)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_115261", "115261050", "story_v_out_115261.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_115261", "115261050", "story_v_out_115261.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_16 = math.max(var_210_9, arg_207_1.talkMaxDuration)

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_16 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_8) / var_210_16

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_8 + var_210_16 and arg_207_1.time_ < var_210_8 + var_210_16 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play115261051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 115261051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play115261052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0.5 < arg_211_1.time_ and arg_211_1.time_ <= 0.5 + arg_214_0 then
				arg_211_1.var_.moveOldPos10030 = arg_211_1.actors_["10030"].transform.localPosition
				arg_211_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10030", 4)

				for iter_214_0 = 0, arg_211_1.actors_["10030"].transform.childCount - 1 do
					local var_214_0 = arg_211_1.actors_["10030"].transform:GetChild(iter_214_0)

					if var_214_0.name == "split_3" or not string.find(var_214_0.name, "split") then
						var_214_0.gameObject:SetActive(true)
					else
						var_214_0.gameObject:SetActive(false)
					end
				end
			end

			local var_214_1 = 0.001

			if 0.5 <= arg_211_1.time_ and arg_211_1.time_ < 0.5 + var_214_1 then
				arg_211_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_211_1.time_ - 0.5) / var_214_1)
			end

			if arg_211_1.time_ >= 0.5 + var_214_1 and arg_211_1.time_ < 0.5 + var_214_1 + arg_214_0 then
				arg_211_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				local var_214_2 = arg_211_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_214_2 then
					arg_211_1.var_.alphaOldValue10030 = var_214_2.alpha
					arg_211_1.var_.characterEffect10030 = var_214_2
				end

				arg_211_1.var_.alphaOldValue10030 = 1
			end

			local var_214_3 = 0.5

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_3 then
				if arg_211_1.var_.characterEffect10030 then
					arg_211_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_211_1.var_.alphaOldValue10030, 0, (arg_211_1.time_ - 0) / var_214_3)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_3 and arg_211_1.time_ < 0 + var_214_3 + arg_214_0 and arg_211_1.var_.characterEffect10030 then
				arg_211_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				local var_214_4 = arg_211_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_214_4 then
					arg_211_1.var_.alphaOldValue1038 = var_214_4.alpha
					arg_211_1.var_.characterEffect1038 = var_214_4
				end

				arg_211_1.var_.alphaOldValue1038 = 1
			end

			local var_214_5 = 0.5

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_5 then
				if arg_211_1.var_.characterEffect1038 then
					arg_211_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_211_1.var_.alphaOldValue1038, 0, (arg_211_1.time_ - 0) / var_214_5)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_5 and arg_211_1.time_ < 0 + var_214_5 + arg_214_0 and arg_211_1.var_.characterEffect1038 then
				arg_211_1.var_.characterEffect1038.alpha = 0
			end

			local var_214_6 = 0
			local var_214_7 = 0.525

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_8 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(115261051).content)

				arg_211_1.text_.text = var_214_8

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_10 = 21 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_8) / 21)

				if (21 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_8) / 21)) > 0 and var_214_7 < var_214_10 then
					arg_211_1.talkMaxDuration = var_214_10

					if var_214_10 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_6
					end
				end

				arg_211_1.text_.text = var_214_8
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_11 = math.max(var_214_7, arg_211_1.talkMaxDuration)

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_11 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_6) / var_214_11

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_6 + var_214_11 and arg_211_1.time_ < var_214_6 + var_214_11 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play115261052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 115261052
		arg_215_1.duration_ = 10.23

		local var_215_0 = {
			ja = 8.066,
			ko = 6.9,
			zh = 8.233,
			en = 10.233
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
				arg_215_0:Play115261053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1038"]) and arg_215_1.var_.actorSpriteComps1038 == nil then
				arg_215_1.var_.actorSpriteComps1038 = arg_215_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1038"]) then
				if arg_215_1.var_.actorSpriteComps1038 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								iter_218_1.color = Color.New(Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor1.r, (arg_215_1.time_ - 0) / var_218_0), Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor1.g, (arg_215_1.time_ - 0) / var_218_0), (Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor1.b, (arg_215_1.time_ - 0) / var_218_0)))
							else
								local var_218_1 = Mathf.Lerp(iter_218_1.color.r, 1, (arg_215_1.time_ - 0) / var_218_0)

								iter_218_1.color = Color.New(var_218_1, var_218_1, var_218_1)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1038"]) and arg_215_1.var_.actorSpriteComps1038 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_218_3 then
						iter_218_3.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_215_1.var_.actorSpriteComps1038 = nil
			end

			local var_218_2 = arg_215_1.actors_["1038"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1038 = var_218_2.localPosition
				var_218_2.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1038", 2)

				for iter_218_4 = 0, var_218_2.childCount - 1 do
					local var_218_3 = var_218_2:GetChild(iter_218_4)

					if var_218_3.name == "split_1" or not string.find(var_218_3.name, "split") then
						var_218_3.gameObject:SetActive(true)
					else
						var_218_3.gameObject:SetActive(false)
					end
				end
			end

			local var_218_4 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				var_218_2.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_215_1.time_ - 0) / var_218_4)
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				var_218_2.localPosition = Vector3.New(-390, -400, 0)
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				local var_218_5 = arg_215_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_218_5 then
					arg_215_1.var_.alphaOldValue1038 = var_218_5.alpha
					arg_215_1.var_.characterEffect1038 = var_218_5
				end

				arg_215_1.var_.alphaOldValue1038 = 0
			end

			local var_218_6 = 0.5

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_6 then
				if arg_215_1.var_.characterEffect1038 then
					arg_215_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_215_1.var_.alphaOldValue1038, 1, (arg_215_1.time_ - 0) / var_218_6)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_6 and arg_215_1.time_ < 0 + var_218_6 + arg_218_0 and arg_215_1.var_.characterEffect1038 then
				arg_215_1.var_.characterEffect1038.alpha = 1
			end

			local var_218_7 = arg_215_1.actors_["10030"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_7) and arg_215_1.var_.actorSpriteComps10030 == nil then
				arg_215_1.var_.actorSpriteComps10030 = var_218_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_8 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_8 and not isNil(var_218_7) then
				if arg_215_1.var_.actorSpriteComps10030 then
					for iter_218_5, iter_218_6 in pairs(arg_215_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_218_6 then
							if arg_215_1.isInRecall_ then
								iter_218_6.color = Color.New(Mathf.Lerp(iter_218_6.color.r, arg_215_1.hightColor2.r, (arg_215_1.time_ - 0) / var_218_8), Mathf.Lerp(iter_218_6.color.g, arg_215_1.hightColor2.g, (arg_215_1.time_ - 0) / var_218_8), (Mathf.Lerp(iter_218_6.color.b, arg_215_1.hightColor2.b, (arg_215_1.time_ - 0) / var_218_8)))
							else
								local var_218_9 = Mathf.Lerp(iter_218_6.color.r, 0.5, (arg_215_1.time_ - 0) / var_218_8)

								iter_218_6.color = Color.New(var_218_9, var_218_9, var_218_9)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_8 and arg_215_1.time_ < 0 + var_218_8 + arg_218_0 and not isNil(var_218_7) and arg_215_1.var_.actorSpriteComps10030 then
				for iter_218_7, iter_218_8 in pairs(arg_215_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_218_8 then
						iter_218_8.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_215_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				local var_218_10 = arg_215_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_218_10 then
					arg_215_1.var_.alphaOldValue10030 = var_218_10.alpha
					arg_215_1.var_.characterEffect10030 = var_218_10
				end

				arg_215_1.var_.alphaOldValue10030 = 0
			end

			local var_218_11 = 0.333333333333333

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_11 then
				if arg_215_1.var_.characterEffect10030 then
					arg_215_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_215_1.var_.alphaOldValue10030, 1, (arg_215_1.time_ - 0) / var_218_11)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_11 and arg_215_1.time_ < 0 + var_218_11 + arg_218_0 and arg_215_1.var_.characterEffect10030 then
				arg_215_1.var_.characterEffect10030.alpha = 1
			end

			local var_218_12 = 0
			local var_218_13 = 0.7

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_12 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_14 = arg_215_1:GetWordFromCfg(115261052)
				local var_218_15 = arg_215_1:FormatText(var_218_14.content)

				arg_215_1.text_.text = var_218_15

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_17 = 29 <= 0 and var_218_13 or var_218_13 * (utf8.len(var_218_15) / 29)

				if (29 <= 0 and var_218_13 or var_218_13 * (utf8.len(var_218_15) / 29)) > 0 and var_218_13 < var_218_17 then
					arg_215_1.talkMaxDuration = var_218_17

					if var_218_17 + var_218_12 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_17 + var_218_12
					end
				end

				arg_215_1.text_.text = var_218_15
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261052", "story_v_out_115261.awb") ~= 0 then
					local var_218_18 = manager.audio:GetVoiceLength("story_v_out_115261", "115261052", "story_v_out_115261.awb") / 1000

					if var_218_18 + var_218_12 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_18 + var_218_12
					end

					if var_218_14.prefab_name ~= "" and arg_215_1.actors_[var_218_14.prefab_name] ~= nil then
						local var_218_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_14.prefab_name].transform, "story_v_out_115261", "115261052", "story_v_out_115261.awb")

						arg_215_1:RecordAudio("115261052", var_218_19)
						arg_215_1:RecordAudio("115261052", var_218_19)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_115261", "115261052", "story_v_out_115261.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_115261", "115261052", "story_v_out_115261.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_20 = math.max(var_218_13, arg_215_1.talkMaxDuration)

			if var_218_12 <= arg_215_1.time_ and arg_215_1.time_ < var_218_12 + var_218_20 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_12) / var_218_20

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_12 + var_218_20 and arg_215_1.time_ < var_218_12 + var_218_20 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play115261053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 115261053
		arg_219_1.duration_ = 14.77

		local var_219_0 = {
			ja = 14.766,
			ko = 9.4,
			zh = 9.433,
			en = 11.033
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
				arg_219_0:Play115261054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.925

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:GetWordFromCfg(115261053)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 37 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 37)

				if (37 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 37)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261053", "story_v_out_115261.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261053", "story_v_out_115261.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_115261", "115261053", "story_v_out_115261.awb")

						arg_219_1:RecordAudio("115261053", var_222_6)
						arg_219_1:RecordAudio("115261053", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_115261", "115261053", "story_v_out_115261.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_115261", "115261053", "story_v_out_115261.awb")
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
	Play115261054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 115261054
		arg_223_1.duration_ = 2.87

		local var_223_0 = {
			ja = 2.866,
			ko = 1.6,
			zh = 1.7,
			en = 2.6
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
				arg_223_0:Play115261055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["10030"]) and arg_223_1.var_.actorSpriteComps10030 == nil then
				arg_223_1.var_.actorSpriteComps10030 = arg_223_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["10030"]) then
				if arg_223_1.var_.actorSpriteComps10030 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								iter_226_1.color = Color.New(Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor1.r, (arg_223_1.time_ - 0) / var_226_0), Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor1.g, (arg_223_1.time_ - 0) / var_226_0), (Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor1.b, (arg_223_1.time_ - 0) / var_226_0)))
							else
								local var_226_1 = Mathf.Lerp(iter_226_1.color.r, 1, (arg_223_1.time_ - 0) / var_226_0)

								iter_226_1.color = Color.New(var_226_1, var_226_1, var_226_1)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["10030"]) and arg_223_1.var_.actorSpriteComps10030 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_226_3 then
						iter_226_3.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps10030 = nil
			end

			local var_226_2 = arg_223_1.actors_["1038"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps1038 == nil then
				arg_223_1.var_.actorSpriteComps1038 = var_226_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_3 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_3 and not isNil(var_226_2) then
				if arg_223_1.var_.actorSpriteComps1038 then
					for iter_226_4, iter_226_5 in pairs(arg_223_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_226_5 then
							if arg_223_1.isInRecall_ then
								iter_226_5.color = Color.New(Mathf.Lerp(iter_226_5.color.r, arg_223_1.hightColor2.r, (arg_223_1.time_ - 0) / var_226_3), Mathf.Lerp(iter_226_5.color.g, arg_223_1.hightColor2.g, (arg_223_1.time_ - 0) / var_226_3), (Mathf.Lerp(iter_226_5.color.b, arg_223_1.hightColor2.b, (arg_223_1.time_ - 0) / var_226_3)))
							else
								local var_226_4 = Mathf.Lerp(iter_226_5.color.r, 0.5, (arg_223_1.time_ - 0) / var_226_3)

								iter_226_5.color = Color.New(var_226_4, var_226_4, var_226_4)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_3 and arg_223_1.time_ < 0 + var_226_3 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps1038 then
				for iter_226_6, iter_226_7 in pairs(arg_223_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_226_7 then
						iter_226_7.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_223_1.var_.actorSpriteComps1038 = nil
			end

			local var_226_5 = 0
			local var_226_6 = 0.15

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_7 = arg_223_1:GetWordFromCfg(115261054)
				local var_226_8 = arg_223_1:FormatText(var_226_7.content)

				arg_223_1.text_.text = var_226_8

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_10 = 6 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 6)

				if (6 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 6)) > 0 and var_226_6 < var_226_10 then
					arg_223_1.talkMaxDuration = var_226_10

					if var_226_10 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_5
					end
				end

				arg_223_1.text_.text = var_226_8
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261054", "story_v_out_115261.awb") ~= 0 then
					local var_226_11 = manager.audio:GetVoiceLength("story_v_out_115261", "115261054", "story_v_out_115261.awb") / 1000

					if var_226_11 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_5
					end

					if var_226_7.prefab_name ~= "" and arg_223_1.actors_[var_226_7.prefab_name] ~= nil then
						local var_226_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_7.prefab_name].transform, "story_v_out_115261", "115261054", "story_v_out_115261.awb")

						arg_223_1:RecordAudio("115261054", var_226_12)
						arg_223_1:RecordAudio("115261054", var_226_12)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_115261", "115261054", "story_v_out_115261.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_115261", "115261054", "story_v_out_115261.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_13 = math.max(var_226_6, arg_223_1.talkMaxDuration)

			if var_226_5 <= arg_223_1.time_ and arg_223_1.time_ < var_226_5 + var_226_13 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_5) / var_226_13

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_5 + var_226_13 and arg_223_1.time_ < var_226_5 + var_226_13 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play115261055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 115261055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play115261056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				local var_230_0 = arg_227_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_230_0 then
					arg_227_1.var_.alphaOldValue1038 = var_230_0.alpha
					arg_227_1.var_.characterEffect1038 = var_230_0
				end

				arg_227_1.var_.alphaOldValue1038 = 1
			end

			local var_230_1 = 0.5

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_1 then
				if arg_227_1.var_.characterEffect1038 then
					arg_227_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_227_1.var_.alphaOldValue1038, 0, (arg_227_1.time_ - 0) / var_230_1)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_1 and arg_227_1.time_ < 0 + var_230_1 + arg_230_0 and arg_227_1.var_.characterEffect1038 then
				arg_227_1.var_.characterEffect1038.alpha = 0
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				local var_230_2 = arg_227_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_230_2 then
					arg_227_1.var_.alphaOldValue10030 = var_230_2.alpha
					arg_227_1.var_.characterEffect10030 = var_230_2
				end

				arg_227_1.var_.alphaOldValue10030 = 1
			end

			local var_230_3 = 0.5

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_3 then
				if arg_227_1.var_.characterEffect10030 then
					arg_227_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_227_1.var_.alphaOldValue10030, 0, (arg_227_1.time_ - 0) / var_230_3)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_3 and arg_227_1.time_ < 0 + var_230_3 + arg_230_0 and arg_227_1.var_.characterEffect10030 then
				arg_227_1.var_.characterEffect10030.alpha = 0
			end

			local var_230_4 = 0
			local var_230_5 = 1.275

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_6 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(115261055).content)

				arg_227_1.text_.text = var_230_6

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_8 = 51 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_6) / 51)

				if (51 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_6) / 51)) > 0 and var_230_5 < var_230_8 then
					arg_227_1.talkMaxDuration = var_230_8

					if var_230_8 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_4
					end
				end

				arg_227_1.text_.text = var_230_6
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_9 = math.max(var_230_5, arg_227_1.talkMaxDuration)

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_9 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_4) / var_230_9

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_4 + var_230_9 and arg_227_1.time_ < var_230_4 + var_230_9 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play115261056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 115261056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play115261057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.875

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_1 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(115261056).content)

				arg_231_1.text_.text = var_234_1

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_3 = 35 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 35)

				if (35 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 35)) > 0 and var_234_0 < var_234_3 then
					arg_231_1.talkMaxDuration = var_234_3

					if var_234_3 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_3 + 0
					end
				end

				arg_231_1.text_.text = var_234_1
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_4 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_4

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play115261057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 115261057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play115261058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.65

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(115261057).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 26 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 26)

				if (26 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 26)) > 0 and var_238_0 < var_238_3 then
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
	Play115261058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 115261058
		arg_239_1.duration_ = 3.37

		local var_239_0 = {
			ja = 3.366,
			ko = 1.933,
			zh = 2.966,
			en = 2.2
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
				arg_239_0:Play115261059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1038 = arg_239_1.actors_["1038"].transform.localPosition
				arg_239_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("1038", 3)

				for iter_242_0 = 0, arg_239_1.actors_["1038"].transform.childCount - 1 do
					local var_242_0 = arg_239_1.actors_["1038"].transform:GetChild(iter_242_0)

					if var_242_0.name == "split_1" or not string.find(var_242_0.name, "split") then
						var_242_0.gameObject:SetActive(true)
					else
						var_242_0.gameObject:SetActive(false)
					end
				end
			end

			local var_242_1 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_1 then
				arg_239_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_239_1.time_ - 0) / var_242_1)
			end

			if arg_239_1.time_ >= 0 + var_242_1 and arg_239_1.time_ < 0 + var_242_1 + arg_242_0 then
				arg_239_1.actors_["1038"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_242_2 = arg_239_1.actors_["1038"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps1038 == nil then
				arg_239_1.var_.actorSpriteComps1038 = var_242_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_3 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_3 and not isNil(var_242_2) then
				if arg_239_1.var_.actorSpriteComps1038 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_242_2 then
							if arg_239_1.isInRecall_ then
								iter_242_2.color = Color.New(Mathf.Lerp(iter_242_2.color.r, arg_239_1.hightColor1.r, (arg_239_1.time_ - 0) / var_242_3), Mathf.Lerp(iter_242_2.color.g, arg_239_1.hightColor1.g, (arg_239_1.time_ - 0) / var_242_3), (Mathf.Lerp(iter_242_2.color.b, arg_239_1.hightColor1.b, (arg_239_1.time_ - 0) / var_242_3)))
							else
								local var_242_4 = Mathf.Lerp(iter_242_2.color.r, 1, (arg_239_1.time_ - 0) / var_242_3)

								iter_242_2.color = Color.New(var_242_4, var_242_4, var_242_4)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_3 and arg_239_1.time_ < 0 + var_242_3 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps1038 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_242_4 then
						iter_242_4.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_239_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				local var_242_5 = arg_239_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_242_5 then
					arg_239_1.var_.alphaOldValue1038 = var_242_5.alpha
					arg_239_1.var_.characterEffect1038 = var_242_5
				end

				arg_239_1.var_.alphaOldValue1038 = 0
			end

			local var_242_6 = 0.5

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_6 then
				if arg_239_1.var_.characterEffect1038 then
					arg_239_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_239_1.var_.alphaOldValue1038, 1, (arg_239_1.time_ - 0) / var_242_6)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_6 and arg_239_1.time_ < 0 + var_242_6 + arg_242_0 and arg_239_1.var_.characterEffect1038 then
				arg_239_1.var_.characterEffect1038.alpha = 1
			end

			local var_242_7 = 0
			local var_242_8 = 0.275

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_7 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_9 = arg_239_1:GetWordFromCfg(115261058)
				local var_242_10 = arg_239_1:FormatText(var_242_9.content)

				arg_239_1.text_.text = var_242_10

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_12 = 11 <= 0 and var_242_8 or var_242_8 * (utf8.len(var_242_10) / 11)

				if (11 <= 0 and var_242_8 or var_242_8 * (utf8.len(var_242_10) / 11)) > 0 and var_242_8 < var_242_12 then
					arg_239_1.talkMaxDuration = var_242_12

					if var_242_12 + var_242_7 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_12 + var_242_7
					end
				end

				arg_239_1.text_.text = var_242_10
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261058", "story_v_out_115261.awb") ~= 0 then
					local var_242_13 = manager.audio:GetVoiceLength("story_v_out_115261", "115261058", "story_v_out_115261.awb") / 1000

					if var_242_13 + var_242_7 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_13 + var_242_7
					end

					if var_242_9.prefab_name ~= "" and arg_239_1.actors_[var_242_9.prefab_name] ~= nil then
						local var_242_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_9.prefab_name].transform, "story_v_out_115261", "115261058", "story_v_out_115261.awb")

						arg_239_1:RecordAudio("115261058", var_242_14)
						arg_239_1:RecordAudio("115261058", var_242_14)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_115261", "115261058", "story_v_out_115261.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_115261", "115261058", "story_v_out_115261.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_15 = math.max(var_242_8, arg_239_1.talkMaxDuration)

			if var_242_7 <= arg_239_1.time_ and arg_239_1.time_ < var_242_7 + var_242_15 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_7) / var_242_15

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_7 + var_242_15 and arg_239_1.time_ < var_242_7 + var_242_15 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play115261059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 115261059
		arg_243_1.duration_ = 7.43

		local var_243_0 = {
			ja = 7.433,
			ko = 6.066,
			zh = 4.1,
			en = 4.766
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
				arg_243_0:Play115261060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1038"]) and arg_243_1.var_.actorSpriteComps1038 == nil then
				arg_243_1.var_.actorSpriteComps1038 = arg_243_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_0 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1038"]) then
				if arg_243_1.var_.actorSpriteComps1038 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								iter_246_1.color = Color.New(Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor2.r, (arg_243_1.time_ - 0) / var_246_0), Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor2.g, (arg_243_1.time_ - 0) / var_246_0), (Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor2.b, (arg_243_1.time_ - 0) / var_246_0)))
							else
								local var_246_1 = Mathf.Lerp(iter_246_1.color.r, 0.5, (arg_243_1.time_ - 0) / var_246_0)

								iter_246_1.color = Color.New(var_246_1, var_246_1, var_246_1)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1038"]) and arg_243_1.var_.actorSpriteComps1038 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_246_3 then
						iter_246_3.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_243_1.var_.actorSpriteComps1038 = nil
			end

			local var_246_2 = 0
			local var_246_3 = 0.5

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_4 = arg_243_1:GetWordFromCfg(115261059)
				local var_246_5 = arg_243_1:FormatText(var_246_4.content)

				arg_243_1.text_.text = var_246_5

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_7 = 22 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_5) / 22)

				if (22 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_5) / 22)) > 0 and var_246_3 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_5
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261059", "story_v_out_115261.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261059", "story_v_out_115261.awb") / 1000

					if var_246_8 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_2
					end

					if var_246_4.prefab_name ~= "" and arg_243_1.actors_[var_246_4.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_4.prefab_name].transform, "story_v_out_115261", "115261059", "story_v_out_115261.awb")

						arg_243_1:RecordAudio("115261059", var_246_9)
						arg_243_1:RecordAudio("115261059", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_115261", "115261059", "story_v_out_115261.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_115261", "115261059", "story_v_out_115261.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_3, arg_243_1.talkMaxDuration)

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_2) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_2 + var_246_10 and arg_243_1.time_ < var_246_2 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play115261060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 115261060
		arg_247_1.duration_ = 3

		local var_247_0 = {
			ja = 2.966,
			ko = 2.533,
			zh = 3,
			en = 2.8
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
				arg_247_0:Play115261061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.225

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10030_split_1")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_1 = arg_247_1:GetWordFromCfg(115261060)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 9 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 9)

				if (9 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 9)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261060", "story_v_out_115261.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261060", "story_v_out_115261.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_115261", "115261060", "story_v_out_115261.awb")

						arg_247_1:RecordAudio("115261060", var_250_6)
						arg_247_1:RecordAudio("115261060", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_115261", "115261060", "story_v_out_115261.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_115261", "115261060", "story_v_out_115261.awb")
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
	Play115261061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 115261061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play115261062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				local var_254_0 = arg_251_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_254_0 then
					arg_251_1.var_.alphaOldValue1038 = var_254_0.alpha
					arg_251_1.var_.characterEffect1038 = var_254_0
				end

				arg_251_1.var_.alphaOldValue1038 = 1
			end

			local var_254_1 = 0.333333333333333

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_1 then
				if arg_251_1.var_.characterEffect1038 then
					arg_251_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_251_1.var_.alphaOldValue1038, 0, (arg_251_1.time_ - 0) / var_254_1)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_1 and arg_251_1.time_ < 0 + var_254_1 + arg_254_0 and arg_251_1.var_.characterEffect1038 then
				arg_251_1.var_.characterEffect1038.alpha = 0
			end

			local var_254_2 = 0
			local var_254_3 = 0.8

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_4 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(115261061).content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_6 = 32 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_4) / 32)

				if (32 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_4) / 32)) > 0 and var_254_3 < var_254_6 then
					arg_251_1.talkMaxDuration = var_254_6

					if var_254_6 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_2
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_3, arg_251_1.talkMaxDuration)

			if var_254_2 <= arg_251_1.time_ and arg_251_1.time_ < var_254_2 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_2) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_2 + var_254_7 and arg_251_1.time_ < var_254_2 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play115261062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 115261062
		arg_255_1.duration_ = 5.97

		local var_255_0 = {
			ja = 5.366,
			ko = 3.8,
			zh = 4.2,
			en = 5.966
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
				arg_255_0:Play115261063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.375

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:GetWordFromCfg(115261062)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 15 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 15)

				if (15 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 15)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261062", "story_v_out_115261.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261062", "story_v_out_115261.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_115261", "115261062", "story_v_out_115261.awb")

						arg_255_1:RecordAudio("115261062", var_258_6)
						arg_255_1:RecordAudio("115261062", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_115261", "115261062", "story_v_out_115261.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_115261", "115261062", "story_v_out_115261.awb")
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
	Play115261063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 115261063
		arg_259_1.duration_ = 5.67

		local var_259_0 = {
			ja = 5.666,
			ko = 4.7,
			zh = 3.866,
			en = 4.966
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
				arg_259_0:Play115261064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.475

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_1 = arg_259_1:GetWordFromCfg(115261063)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 19 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 19)

				if (19 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 19)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261063", "story_v_out_115261.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261063", "story_v_out_115261.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_115261", "115261063", "story_v_out_115261.awb")

						arg_259_1:RecordAudio("115261063", var_262_6)
						arg_259_1:RecordAudio("115261063", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_115261", "115261063", "story_v_out_115261.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_115261", "115261063", "story_v_out_115261.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play115261064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 115261064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play115261065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.275

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(115261064).content)

				arg_263_1.text_.text = var_266_1

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_3 = 11 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 11)

				if (11 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 11)) > 0 and var_266_0 < var_266_3 then
					arg_263_1.talkMaxDuration = var_266_3

					if var_266_3 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_3 + 0
					end
				end

				arg_263_1.text_.text = var_266_1
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_4 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_4

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play115261065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 115261065
		arg_267_1.duration_ = 10.63

		local var_267_0 = {
			ja = 6.466,
			ko = 10.6,
			zh = 9.566,
			en = 10.633
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
				arg_267_0:Play115261066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1038 = arg_267_1.actors_["1038"].transform.localPosition
				arg_267_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("1038", 3)

				for iter_270_0 = 0, arg_267_1.actors_["1038"].transform.childCount - 1 do
					local var_270_0 = arg_267_1.actors_["1038"].transform:GetChild(iter_270_0)

					if var_270_0.name == "split_9" or not string.find(var_270_0.name, "split") then
						var_270_0.gameObject:SetActive(true)
					else
						var_270_0.gameObject:SetActive(false)
					end
				end
			end

			local var_270_1 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_1 then
				arg_267_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_267_1.time_ - 0) / var_270_1)
			end

			if arg_267_1.time_ >= 0 + var_270_1 and arg_267_1.time_ < 0 + var_270_1 + arg_270_0 then
				arg_267_1.actors_["1038"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_270_2 = arg_267_1.actors_["1038"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.actorSpriteComps1038 == nil then
				arg_267_1.var_.actorSpriteComps1038 = var_270_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_3 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_3 and not isNil(var_270_2) then
				if arg_267_1.var_.actorSpriteComps1038 then
					for iter_270_1, iter_270_2 in pairs(arg_267_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_270_2 then
							if arg_267_1.isInRecall_ then
								iter_270_2.color = Color.New(Mathf.Lerp(iter_270_2.color.r, arg_267_1.hightColor1.r, (arg_267_1.time_ - 0) / var_270_3), Mathf.Lerp(iter_270_2.color.g, arg_267_1.hightColor1.g, (arg_267_1.time_ - 0) / var_270_3), (Mathf.Lerp(iter_270_2.color.b, arg_267_1.hightColor1.b, (arg_267_1.time_ - 0) / var_270_3)))
							else
								local var_270_4 = Mathf.Lerp(iter_270_2.color.r, 1, (arg_267_1.time_ - 0) / var_270_3)

								iter_270_2.color = Color.New(var_270_4, var_270_4, var_270_4)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_3 and arg_267_1.time_ < 0 + var_270_3 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.actorSpriteComps1038 then
				for iter_270_3, iter_270_4 in pairs(arg_267_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_270_4 then
						iter_270_4.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_267_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				local var_270_5 = arg_267_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_270_5 then
					arg_267_1.var_.alphaOldValue1038 = var_270_5.alpha
					arg_267_1.var_.characterEffect1038 = var_270_5
				end

				arg_267_1.var_.alphaOldValue1038 = 0
			end

			local var_270_6 = 0.5

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_6 then
				if arg_267_1.var_.characterEffect1038 then
					arg_267_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_267_1.var_.alphaOldValue1038, 1, (arg_267_1.time_ - 0) / var_270_6)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_6 and arg_267_1.time_ < 0 + var_270_6 + arg_270_0 and arg_267_1.var_.characterEffect1038 then
				arg_267_1.var_.characterEffect1038.alpha = 1
			end

			local var_270_7 = 0
			local var_270_8 = 0.8

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_7 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_9 = arg_267_1:GetWordFromCfg(115261065)
				local var_270_10 = arg_267_1:FormatText(var_270_9.content)

				arg_267_1.text_.text = var_270_10

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_12 = 32 <= 0 and var_270_8 or var_270_8 * (utf8.len(var_270_10) / 32)

				if (32 <= 0 and var_270_8 or var_270_8 * (utf8.len(var_270_10) / 32)) > 0 and var_270_8 < var_270_12 then
					arg_267_1.talkMaxDuration = var_270_12

					if var_270_12 + var_270_7 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_12 + var_270_7
					end
				end

				arg_267_1.text_.text = var_270_10
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261065", "story_v_out_115261.awb") ~= 0 then
					local var_270_13 = manager.audio:GetVoiceLength("story_v_out_115261", "115261065", "story_v_out_115261.awb") / 1000

					if var_270_13 + var_270_7 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_13 + var_270_7
					end

					if var_270_9.prefab_name ~= "" and arg_267_1.actors_[var_270_9.prefab_name] ~= nil then
						local var_270_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_9.prefab_name].transform, "story_v_out_115261", "115261065", "story_v_out_115261.awb")

						arg_267_1:RecordAudio("115261065", var_270_14)
						arg_267_1:RecordAudio("115261065", var_270_14)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_115261", "115261065", "story_v_out_115261.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_115261", "115261065", "story_v_out_115261.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_15 = math.max(var_270_8, arg_267_1.talkMaxDuration)

			if var_270_7 <= arg_267_1.time_ and arg_267_1.time_ < var_270_7 + var_270_15 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_7) / var_270_15

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_7 + var_270_15 and arg_267_1.time_ < var_270_7 + var_270_15 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play115261066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 115261066
		arg_271_1.duration_ = 15.43

		local var_271_0 = {
			ja = 7.866,
			ko = 13.4,
			zh = 12.5,
			en = 15.433
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
				arg_271_0:Play115261067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 1.3

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:GetWordFromCfg(115261066)
				local var_274_2 = arg_271_1:FormatText(var_274_1.content)

				arg_271_1.text_.text = var_274_2

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 52 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 52)

				if (52 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 52)) > 0 and var_274_0 < var_274_4 then
					arg_271_1.talkMaxDuration = var_274_4

					if var_274_4 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_4 + 0
					end
				end

				arg_271_1.text_.text = var_274_2
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261066", "story_v_out_115261.awb") ~= 0 then
					local var_274_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261066", "story_v_out_115261.awb") / 1000

					if var_274_5 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + 0
					end

					if var_274_1.prefab_name ~= "" and arg_271_1.actors_[var_274_1.prefab_name] ~= nil then
						local var_274_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_1.prefab_name].transform, "story_v_out_115261", "115261066", "story_v_out_115261.awb")

						arg_271_1:RecordAudio("115261066", var_274_6)
						arg_271_1:RecordAudio("115261066", var_274_6)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_115261", "115261066", "story_v_out_115261.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_115261", "115261066", "story_v_out_115261.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play115261067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 115261067
		arg_275_1.duration_ = 7.5

		local var_275_0 = {
			ja = 6.833,
			ko = 6.866,
			zh = 5.4,
			en = 7.5
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play115261068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1038"]) and arg_275_1.var_.actorSpriteComps1038 == nil then
				arg_275_1.var_.actorSpriteComps1038 = arg_275_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_0 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1038"]) then
				if arg_275_1.var_.actorSpriteComps1038 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								iter_278_1.color = Color.New(Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor2.r, (arg_275_1.time_ - 0) / var_278_0), Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor2.g, (arg_275_1.time_ - 0) / var_278_0), (Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor2.b, (arg_275_1.time_ - 0) / var_278_0)))
							else
								local var_278_1 = Mathf.Lerp(iter_278_1.color.r, 0.5, (arg_275_1.time_ - 0) / var_278_0)

								iter_278_1.color = Color.New(var_278_1, var_278_1, var_278_1)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1038"]) and arg_275_1.var_.actorSpriteComps1038 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_278_3 then
						iter_278_3.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_275_1.var_.actorSpriteComps1038 = nil
			end

			local var_278_2 = 0
			local var_278_3 = 0.625

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_4 = arg_275_1:GetWordFromCfg(115261067)
				local var_278_5 = arg_275_1:FormatText(var_278_4.content)

				arg_275_1.text_.text = var_278_5

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_7 = 25 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 25)

				if (25 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 25)) > 0 and var_278_3 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_2
					end
				end

				arg_275_1.text_.text = var_278_5
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261067", "story_v_out_115261.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261067", "story_v_out_115261.awb") / 1000

					if var_278_8 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_2
					end

					if var_278_4.prefab_name ~= "" and arg_275_1.actors_[var_278_4.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_4.prefab_name].transform, "story_v_out_115261", "115261067", "story_v_out_115261.awb")

						arg_275_1:RecordAudio("115261067", var_278_9)
						arg_275_1:RecordAudio("115261067", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_115261", "115261067", "story_v_out_115261.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_115261", "115261067", "story_v_out_115261.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_3, arg_275_1.talkMaxDuration)

			if var_278_2 <= arg_275_1.time_ and arg_275_1.time_ < var_278_2 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_2) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_2 + var_278_10 and arg_275_1.time_ < var_278_2 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play115261068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 115261068
		arg_279_1.duration_ = 2.4

		local var_279_0 = {
			ja = 0.999999999999,
			ko = 1.066,
			zh = 2.4,
			en = 0.999999999999
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
				arg_279_0:Play115261069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1038"]) and arg_279_1.var_.actorSpriteComps1038 == nil then
				arg_279_1.var_.actorSpriteComps1038 = arg_279_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_0 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1038"]) then
				if arg_279_1.var_.actorSpriteComps1038 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								iter_282_1.color = Color.New(Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor1.r, (arg_279_1.time_ - 0) / var_282_0), Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor1.g, (arg_279_1.time_ - 0) / var_282_0), (Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor1.b, (arg_279_1.time_ - 0) / var_282_0)))
							else
								local var_282_1 = Mathf.Lerp(iter_282_1.color.r, 1, (arg_279_1.time_ - 0) / var_282_0)

								iter_282_1.color = Color.New(var_282_1, var_282_1, var_282_1)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1038"]) and arg_279_1.var_.actorSpriteComps1038 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_282_3 then
						iter_282_3.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_279_1.var_.actorSpriteComps1038 = nil
			end

			local var_282_2 = arg_279_1.actors_["1038"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1038 = var_282_2.localPosition
				var_282_2.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("1038", 3)

				for iter_282_4 = 0, var_282_2.childCount - 1 do
					local var_282_3 = var_282_2:GetChild(iter_282_4)

					if var_282_3.name == "split_9" or not string.find(var_282_3.name, "split") then
						var_282_3.gameObject:SetActive(true)
					else
						var_282_3.gameObject:SetActive(false)
					end
				end
			end

			local var_282_4 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				var_282_2.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_279_1.time_ - 0) / var_282_4)
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				var_282_2.localPosition = Vector3.New(0, -400, 0)
			end

			local var_282_5 = 0
			local var_282_6 = 0.05

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_7 = arg_279_1:GetWordFromCfg(115261068)
				local var_282_8 = arg_279_1:FormatText(var_282_7.content)

				arg_279_1.text_.text = var_282_8

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_10 = 2 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 2)

				if (2 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 2)) > 0 and var_282_6 < var_282_10 then
					arg_279_1.talkMaxDuration = var_282_10

					if var_282_10 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_5
					end
				end

				arg_279_1.text_.text = var_282_8
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261068", "story_v_out_115261.awb") ~= 0 then
					local var_282_11 = manager.audio:GetVoiceLength("story_v_out_115261", "115261068", "story_v_out_115261.awb") / 1000

					if var_282_11 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_11 + var_282_5
					end

					if var_282_7.prefab_name ~= "" and arg_279_1.actors_[var_282_7.prefab_name] ~= nil then
						local var_282_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_7.prefab_name].transform, "story_v_out_115261", "115261068", "story_v_out_115261.awb")

						arg_279_1:RecordAudio("115261068", var_282_12)
						arg_279_1:RecordAudio("115261068", var_282_12)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_115261", "115261068", "story_v_out_115261.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_115261", "115261068", "story_v_out_115261.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_13 = math.max(var_282_6, arg_279_1.talkMaxDuration)

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_13 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_5) / var_282_13

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_5 + var_282_13 and arg_279_1.time_ < var_282_5 + var_282_13 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play115261069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 115261069
		arg_283_1.duration_ = 4.4

		local var_283_0 = {
			ja = 3.333,
			ko = 3.433,
			zh = 4.4,
			en = 3.5
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play115261070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.375

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:GetWordFromCfg(115261069)
				local var_286_2 = arg_283_1:FormatText(var_286_1.content)

				arg_283_1.text_.text = var_286_2

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_4 = 15 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 15)

				if (15 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 15)) > 0 and var_286_0 < var_286_4 then
					arg_283_1.talkMaxDuration = var_286_4

					if var_286_4 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_4 + 0
					end
				end

				arg_283_1.text_.text = var_286_2
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261069", "story_v_out_115261.awb") ~= 0 then
					local var_286_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261069", "story_v_out_115261.awb") / 1000

					if var_286_5 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + 0
					end

					if var_286_1.prefab_name ~= "" and arg_283_1.actors_[var_286_1.prefab_name] ~= nil then
						local var_286_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_1.prefab_name].transform, "story_v_out_115261", "115261069", "story_v_out_115261.awb")

						arg_283_1:RecordAudio("115261069", var_286_6)
						arg_283_1:RecordAudio("115261069", var_286_6)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_115261", "115261069", "story_v_out_115261.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_115261", "115261069", "story_v_out_115261.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_7 and arg_283_1.time_ < 0 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play115261070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 115261070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play115261071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				local var_290_0 = arg_287_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_290_0 then
					arg_287_1.var_.alphaOldValue1038 = var_290_0.alpha
					arg_287_1.var_.characterEffect1038 = var_290_0
				end

				arg_287_1.var_.alphaOldValue1038 = 1
			end

			local var_290_1 = 0.333333333333333

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_1 then
				if arg_287_1.var_.characterEffect1038 then
					arg_287_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_287_1.var_.alphaOldValue1038, 0, (arg_287_1.time_ - 0) / var_290_1)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_1 and arg_287_1.time_ < 0 + var_290_1 + arg_290_0 and arg_287_1.var_.characterEffect1038 then
				arg_287_1.var_.characterEffect1038.alpha = 0
			end

			local var_290_2 = 0
			local var_290_3 = 0.925

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_4 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(115261070).content)

				arg_287_1.text_.text = var_290_4

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_6 = 37 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_4) / 37)

				if (37 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_4) / 37)) > 0 and var_290_3 < var_290_6 then
					arg_287_1.talkMaxDuration = var_290_6

					if var_290_6 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_6 + var_290_2
					end
				end

				arg_287_1.text_.text = var_290_4
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_3, arg_287_1.talkMaxDuration)

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_2) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_2 + var_290_7 and arg_287_1.time_ < var_290_2 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play115261071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 115261071
		arg_291_1.duration_ = 7.73

		local var_291_0 = {
			ja = 5.433,
			ko = 5.733,
			zh = 7.733,
			en = 6.666
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play115261072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1038 = arg_291_1.actors_["1038"].transform.localPosition
				arg_291_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("1038", 3)

				for iter_294_0 = 0, arg_291_1.actors_["1038"].transform.childCount - 1 do
					local var_294_0 = arg_291_1.actors_["1038"].transform:GetChild(iter_294_0)

					if var_294_0.name == "split_1" or not string.find(var_294_0.name, "split") then
						var_294_0.gameObject:SetActive(true)
					else
						var_294_0.gameObject:SetActive(false)
					end
				end
			end

			local var_294_1 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_1 then
				arg_291_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_291_1.time_ - 0) / var_294_1)
			end

			if arg_291_1.time_ >= 0 + var_294_1 and arg_291_1.time_ < 0 + var_294_1 + arg_294_0 then
				arg_291_1.actors_["1038"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_294_2 = arg_291_1.actors_["1038"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.actorSpriteComps1038 == nil then
				arg_291_1.var_.actorSpriteComps1038 = var_294_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_3 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_3 and not isNil(var_294_2) then
				if arg_291_1.var_.actorSpriteComps1038 then
					for iter_294_1, iter_294_2 in pairs(arg_291_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_294_2 then
							if arg_291_1.isInRecall_ then
								iter_294_2.color = Color.New(Mathf.Lerp(iter_294_2.color.r, arg_291_1.hightColor1.r, (arg_291_1.time_ - 0) / var_294_3), Mathf.Lerp(iter_294_2.color.g, arg_291_1.hightColor1.g, (arg_291_1.time_ - 0) / var_294_3), (Mathf.Lerp(iter_294_2.color.b, arg_291_1.hightColor1.b, (arg_291_1.time_ - 0) / var_294_3)))
							else
								local var_294_4 = Mathf.Lerp(iter_294_2.color.r, 1, (arg_291_1.time_ - 0) / var_294_3)

								iter_294_2.color = Color.New(var_294_4, var_294_4, var_294_4)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_3 and arg_291_1.time_ < 0 + var_294_3 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.actorSpriteComps1038 then
				for iter_294_3, iter_294_4 in pairs(arg_291_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_294_4 then
						iter_294_4.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_291_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				local var_294_5 = arg_291_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_294_5 then
					arg_291_1.var_.alphaOldValue1038 = var_294_5.alpha
					arg_291_1.var_.characterEffect1038 = var_294_5
				end

				arg_291_1.var_.alphaOldValue1038 = 0
			end

			local var_294_6 = 0.5

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_6 then
				if arg_291_1.var_.characterEffect1038 then
					arg_291_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_291_1.var_.alphaOldValue1038, 1, (arg_291_1.time_ - 0) / var_294_6)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_6 and arg_291_1.time_ < 0 + var_294_6 + arg_294_0 and arg_291_1.var_.characterEffect1038 then
				arg_291_1.var_.characterEffect1038.alpha = 1
			end

			local var_294_7 = 0
			local var_294_8 = 0.75

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_7 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_9 = arg_291_1:GetWordFromCfg(115261071)
				local var_294_10 = arg_291_1:FormatText(var_294_9.content)

				arg_291_1.text_.text = var_294_10

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_12 = 30 <= 0 and var_294_8 or var_294_8 * (utf8.len(var_294_10) / 30)

				if (30 <= 0 and var_294_8 or var_294_8 * (utf8.len(var_294_10) / 30)) > 0 and var_294_8 < var_294_12 then
					arg_291_1.talkMaxDuration = var_294_12

					if var_294_12 + var_294_7 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_12 + var_294_7
					end
				end

				arg_291_1.text_.text = var_294_10
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261071", "story_v_out_115261.awb") ~= 0 then
					local var_294_13 = manager.audio:GetVoiceLength("story_v_out_115261", "115261071", "story_v_out_115261.awb") / 1000

					if var_294_13 + var_294_7 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_13 + var_294_7
					end

					if var_294_9.prefab_name ~= "" and arg_291_1.actors_[var_294_9.prefab_name] ~= nil then
						local var_294_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_9.prefab_name].transform, "story_v_out_115261", "115261071", "story_v_out_115261.awb")

						arg_291_1:RecordAudio("115261071", var_294_14)
						arg_291_1:RecordAudio("115261071", var_294_14)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_115261", "115261071", "story_v_out_115261.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_115261", "115261071", "story_v_out_115261.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_15 = math.max(var_294_8, arg_291_1.talkMaxDuration)

			if var_294_7 <= arg_291_1.time_ and arg_291_1.time_ < var_294_7 + var_294_15 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_7) / var_294_15

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_7 + var_294_15 and arg_291_1.time_ < var_294_7 + var_294_15 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play115261072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 115261072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play115261073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				local var_298_0 = arg_295_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_298_0 then
					arg_295_1.var_.alphaOldValue1038 = var_298_0.alpha
					arg_295_1.var_.characterEffect1038 = var_298_0
				end

				arg_295_1.var_.alphaOldValue1038 = 1
			end

			local var_298_1 = 0.333333333333333

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_1 then
				if arg_295_1.var_.characterEffect1038 then
					arg_295_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_295_1.var_.alphaOldValue1038, 0, (arg_295_1.time_ - 0) / var_298_1)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_1 and arg_295_1.time_ < 0 + var_298_1 + arg_298_0 and arg_295_1.var_.characterEffect1038 then
				arg_295_1.var_.characterEffect1038.alpha = 0
			end

			local var_298_2 = 0
			local var_298_3 = 0.3

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_2 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_4 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(115261072).content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_6 = 12 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_4) / 12)

				if (12 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_4) / 12)) > 0 and var_298_3 < var_298_6 then
					arg_295_1.talkMaxDuration = var_298_6

					if var_298_6 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_6 + var_298_2
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_3, arg_295_1.talkMaxDuration)

			if var_298_2 <= arg_295_1.time_ and arg_295_1.time_ < var_298_2 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_2) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_2 + var_298_7 and arg_295_1.time_ < var_298_2 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play115261073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 115261073
		arg_299_1.duration_ = 4.13

		local var_299_0 = {
			ja = 4.133,
			ko = 2.666,
			zh = 3.166,
			en = 2.333
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
				arg_299_0:Play115261074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1038 = arg_299_1.actors_["1038"].transform.localPosition
				arg_299_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("1038", 2)

				for iter_302_0 = 0, arg_299_1.actors_["1038"].transform.childCount - 1 do
					local var_302_0 = arg_299_1.actors_["1038"].transform:GetChild(iter_302_0)

					if var_302_0.name == "split_1" or not string.find(var_302_0.name, "split") then
						var_302_0.gameObject:SetActive(true)
					else
						var_302_0.gameObject:SetActive(false)
					end
				end
			end

			local var_302_1 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_1 then
				arg_299_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_299_1.time_ - 0) / var_302_1)
			end

			if arg_299_1.time_ >= 0 + var_302_1 and arg_299_1.time_ < 0 + var_302_1 + arg_302_0 then
				arg_299_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_302_2 = arg_299_1.actors_["1038"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps1038 == nil then
				arg_299_1.var_.actorSpriteComps1038 = var_302_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_3 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_3 and not isNil(var_302_2) then
				if arg_299_1.var_.actorSpriteComps1038 then
					for iter_302_1, iter_302_2 in pairs(arg_299_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_302_2 then
							if arg_299_1.isInRecall_ then
								iter_302_2.color = Color.New(Mathf.Lerp(iter_302_2.color.r, arg_299_1.hightColor1.r, (arg_299_1.time_ - 0) / var_302_3), Mathf.Lerp(iter_302_2.color.g, arg_299_1.hightColor1.g, (arg_299_1.time_ - 0) / var_302_3), (Mathf.Lerp(iter_302_2.color.b, arg_299_1.hightColor1.b, (arg_299_1.time_ - 0) / var_302_3)))
							else
								local var_302_4 = Mathf.Lerp(iter_302_2.color.r, 1, (arg_299_1.time_ - 0) / var_302_3)

								iter_302_2.color = Color.New(var_302_4, var_302_4, var_302_4)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_3 and arg_299_1.time_ < 0 + var_302_3 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps1038 then
				for iter_302_3, iter_302_4 in pairs(arg_299_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_302_4 then
						iter_302_4.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_299_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				local var_302_5 = arg_299_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_302_5 then
					arg_299_1.var_.alphaOldValue1038 = var_302_5.alpha
					arg_299_1.var_.characterEffect1038 = var_302_5
				end

				arg_299_1.var_.alphaOldValue1038 = 0
			end

			local var_302_6 = 0.5

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_6 then
				if arg_299_1.var_.characterEffect1038 then
					arg_299_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_299_1.var_.alphaOldValue1038, 1, (arg_299_1.time_ - 0) / var_302_6)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_6 and arg_299_1.time_ < 0 + var_302_6 + arg_302_0 and arg_299_1.var_.characterEffect1038 then
				arg_299_1.var_.characterEffect1038.alpha = 1
			end

			local var_302_7 = arg_299_1.actors_["10030"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10030 = var_302_7.localPosition
				var_302_7.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10030", 4)

				for iter_302_5 = 0, var_302_7.childCount - 1 do
					local var_302_8 = var_302_7:GetChild(iter_302_5)

					if var_302_8.name == "split_1" or not string.find(var_302_8.name, "split") then
						var_302_8.gameObject:SetActive(true)
					else
						var_302_8.gameObject:SetActive(false)
					end
				end
			end

			local var_302_9 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_9 then
				var_302_7.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_299_1.time_ - 0) / var_302_9)
			end

			if arg_299_1.time_ >= 0 + var_302_9 and arg_299_1.time_ < 0 + var_302_9 + arg_302_0 then
				var_302_7.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				local var_302_10 = arg_299_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_302_10 then
					arg_299_1.var_.alphaOldValue10030 = var_302_10.alpha
					arg_299_1.var_.characterEffect10030 = var_302_10
				end

				arg_299_1.var_.alphaOldValue10030 = 0
			end

			local var_302_11 = 0.5

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_11 then
				if arg_299_1.var_.characterEffect10030 then
					arg_299_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_299_1.var_.alphaOldValue10030, 1, (arg_299_1.time_ - 0) / var_302_11)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_11 and arg_299_1.time_ < 0 + var_302_11 + arg_302_0 and arg_299_1.var_.characterEffect10030 then
				arg_299_1.var_.characterEffect10030.alpha = 1
			end

			local var_302_12 = arg_299_1.actors_["10030"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_12) and arg_299_1.var_.actorSpriteComps10030 == nil then
				arg_299_1.var_.actorSpriteComps10030 = var_302_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_13 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_13 and not isNil(var_302_12) then
				if arg_299_1.var_.actorSpriteComps10030 then
					for iter_302_6, iter_302_7 in pairs(arg_299_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_302_7 then
							if arg_299_1.isInRecall_ then
								iter_302_7.color = Color.New(Mathf.Lerp(iter_302_7.color.r, arg_299_1.hightColor2.r, (arg_299_1.time_ - 0) / var_302_13), Mathf.Lerp(iter_302_7.color.g, arg_299_1.hightColor2.g, (arg_299_1.time_ - 0) / var_302_13), (Mathf.Lerp(iter_302_7.color.b, arg_299_1.hightColor2.b, (arg_299_1.time_ - 0) / var_302_13)))
							else
								local var_302_14 = Mathf.Lerp(iter_302_7.color.r, 0.5, (arg_299_1.time_ - 0) / var_302_13)

								iter_302_7.color = Color.New(var_302_14, var_302_14, var_302_14)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_13 and arg_299_1.time_ < 0 + var_302_13 + arg_302_0 and not isNil(var_302_12) and arg_299_1.var_.actorSpriteComps10030 then
				for iter_302_8, iter_302_9 in pairs(arg_299_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_302_9 then
						iter_302_9.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_299_1.var_.actorSpriteComps10030 = nil
			end

			local var_302_15 = 0
			local var_302_16 = 0.275

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_17 = arg_299_1:GetWordFromCfg(115261073)
				local var_302_18 = arg_299_1:FormatText(var_302_17.content)

				arg_299_1.text_.text = var_302_18

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_20 = 11 <= 0 and var_302_16 or var_302_16 * (utf8.len(var_302_18) / 11)

				if (11 <= 0 and var_302_16 or var_302_16 * (utf8.len(var_302_18) / 11)) > 0 and var_302_16 < var_302_20 then
					arg_299_1.talkMaxDuration = var_302_20

					if var_302_20 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_20 + var_302_15
					end
				end

				arg_299_1.text_.text = var_302_18
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261073", "story_v_out_115261.awb") ~= 0 then
					local var_302_21 = manager.audio:GetVoiceLength("story_v_out_115261", "115261073", "story_v_out_115261.awb") / 1000

					if var_302_21 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_21 + var_302_15
					end

					if var_302_17.prefab_name ~= "" and arg_299_1.actors_[var_302_17.prefab_name] ~= nil then
						local var_302_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_17.prefab_name].transform, "story_v_out_115261", "115261073", "story_v_out_115261.awb")

						arg_299_1:RecordAudio("115261073", var_302_22)
						arg_299_1:RecordAudio("115261073", var_302_22)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_115261", "115261073", "story_v_out_115261.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_115261", "115261073", "story_v_out_115261.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_23 = math.max(var_302_16, arg_299_1.talkMaxDuration)

			if var_302_15 <= arg_299_1.time_ and arg_299_1.time_ < var_302_15 + var_302_23 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_15) / var_302_23

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_15 + var_302_23 and arg_299_1.time_ < var_302_15 + var_302_23 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play115261074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 115261074
		arg_303_1.duration_ = 19.03

		local var_303_0 = {
			ja = 12.5,
			ko = 8.166,
			zh = 7.9,
			en = 19.033
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play115261075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.875

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:GetWordFromCfg(115261074)
				local var_306_2 = arg_303_1:FormatText(var_306_1.content)

				arg_303_1.text_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 35 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 35)

				if (35 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 35)) > 0 and var_306_0 < var_306_4 then
					arg_303_1.talkMaxDuration = var_306_4

					if var_306_4 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_4 + 0
					end
				end

				arg_303_1.text_.text = var_306_2
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261074", "story_v_out_115261.awb") ~= 0 then
					local var_306_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261074", "story_v_out_115261.awb") / 1000

					if var_306_5 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + 0
					end

					if var_306_1.prefab_name ~= "" and arg_303_1.actors_[var_306_1.prefab_name] ~= nil then
						local var_306_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_1.prefab_name].transform, "story_v_out_115261", "115261074", "story_v_out_115261.awb")

						arg_303_1:RecordAudio("115261074", var_306_6)
						arg_303_1:RecordAudio("115261074", var_306_6)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_115261", "115261074", "story_v_out_115261.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_115261", "115261074", "story_v_out_115261.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_7 and arg_303_1.time_ < 0 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play115261075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 115261075
		arg_307_1.duration_ = 3.83

		local var_307_0 = {
			ja = 2.7,
			ko = 2.8,
			zh = 3.333,
			en = 3.833
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
				arg_307_0:Play115261076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1038 = arg_307_1.actors_["1038"].transform.localPosition
				arg_307_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1038", 2)

				for iter_310_0 = 0, arg_307_1.actors_["1038"].transform.childCount - 1 do
					local var_310_0 = arg_307_1.actors_["1038"].transform:GetChild(iter_310_0)

					if var_310_0.name == "split_1" or not string.find(var_310_0.name, "split") then
						var_310_0.gameObject:SetActive(true)
					else
						var_310_0.gameObject:SetActive(false)
					end
				end
			end

			local var_310_1 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_1 then
				arg_307_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_307_1.time_ - 0) / var_310_1)
			end

			if arg_307_1.time_ >= 0 + var_310_1 and arg_307_1.time_ < 0 + var_310_1 + arg_310_0 then
				arg_307_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_310_2 = arg_307_1.actors_["1038"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps1038 == nil then
				arg_307_1.var_.actorSpriteComps1038 = var_310_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_3 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_3 and not isNil(var_310_2) then
				if arg_307_1.var_.actorSpriteComps1038 then
					for iter_310_1, iter_310_2 in pairs(arg_307_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_310_2 then
							if arg_307_1.isInRecall_ then
								iter_310_2.color = Color.New(Mathf.Lerp(iter_310_2.color.r, arg_307_1.hightColor2.r, (arg_307_1.time_ - 0) / var_310_3), Mathf.Lerp(iter_310_2.color.g, arg_307_1.hightColor2.g, (arg_307_1.time_ - 0) / var_310_3), (Mathf.Lerp(iter_310_2.color.b, arg_307_1.hightColor2.b, (arg_307_1.time_ - 0) / var_310_3)))
							else
								local var_310_4 = Mathf.Lerp(iter_310_2.color.r, 0.5, (arg_307_1.time_ - 0) / var_310_3)

								iter_310_2.color = Color.New(var_310_4, var_310_4, var_310_4)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 0 + var_310_3 and arg_307_1.time_ < 0 + var_310_3 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps1038 then
				for iter_310_3, iter_310_4 in pairs(arg_307_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_310_4 then
						iter_310_4.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_307_1.var_.actorSpriteComps1038 = nil
			end

			local var_310_5 = arg_307_1.actors_["10030"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_5) and arg_307_1.var_.actorSpriteComps10030 == nil then
				arg_307_1.var_.actorSpriteComps10030 = var_310_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_6 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_6 and not isNil(var_310_5) then
				if arg_307_1.var_.actorSpriteComps10030 then
					for iter_310_5, iter_310_6 in pairs(arg_307_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_310_6 then
							if arg_307_1.isInRecall_ then
								iter_310_6.color = Color.New(Mathf.Lerp(iter_310_6.color.r, arg_307_1.hightColor1.r, (arg_307_1.time_ - 0) / var_310_6), Mathf.Lerp(iter_310_6.color.g, arg_307_1.hightColor1.g, (arg_307_1.time_ - 0) / var_310_6), (Mathf.Lerp(iter_310_6.color.b, arg_307_1.hightColor1.b, (arg_307_1.time_ - 0) / var_310_6)))
							else
								local var_310_7 = Mathf.Lerp(iter_310_6.color.r, 1, (arg_307_1.time_ - 0) / var_310_6)

								iter_310_6.color = Color.New(var_310_7, var_310_7, var_310_7)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 0 + var_310_6 and arg_307_1.time_ < 0 + var_310_6 + arg_310_0 and not isNil(var_310_5) and arg_307_1.var_.actorSpriteComps10030 then
				for iter_310_7, iter_310_8 in pairs(arg_307_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_310_8 then
						iter_310_8.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_307_1.var_.actorSpriteComps10030 = nil
			end

			local var_310_8 = 0
			local var_310_9 = 0.225

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_8 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_10 = arg_307_1:GetWordFromCfg(115261075)
				local var_310_11 = arg_307_1:FormatText(var_310_10.content)

				arg_307_1.text_.text = var_310_11

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_13 = 9 <= 0 and var_310_9 or var_310_9 * (utf8.len(var_310_11) / 9)

				if (9 <= 0 and var_310_9 or var_310_9 * (utf8.len(var_310_11) / 9)) > 0 and var_310_9 < var_310_13 then
					arg_307_1.talkMaxDuration = var_310_13

					if var_310_13 + var_310_8 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_13 + var_310_8
					end
				end

				arg_307_1.text_.text = var_310_11
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261075", "story_v_out_115261.awb") ~= 0 then
					local var_310_14 = manager.audio:GetVoiceLength("story_v_out_115261", "115261075", "story_v_out_115261.awb") / 1000

					if var_310_14 + var_310_8 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_14 + var_310_8
					end

					if var_310_10.prefab_name ~= "" and arg_307_1.actors_[var_310_10.prefab_name] ~= nil then
						local var_310_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_10.prefab_name].transform, "story_v_out_115261", "115261075", "story_v_out_115261.awb")

						arg_307_1:RecordAudio("115261075", var_310_15)
						arg_307_1:RecordAudio("115261075", var_310_15)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_115261", "115261075", "story_v_out_115261.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_115261", "115261075", "story_v_out_115261.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_16 = math.max(var_310_9, arg_307_1.talkMaxDuration)

			if var_310_8 <= arg_307_1.time_ and arg_307_1.time_ < var_310_8 + var_310_16 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_8) / var_310_16

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_8 + var_310_16 and arg_307_1.time_ < var_310_8 + var_310_16 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play115261076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 115261076
		arg_311_1.duration_ = 14.17

		local var_311_0 = {
			ja = 14.166,
			ko = 12.2,
			zh = 11.933,
			en = 14.166
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play115261077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1038"]) and arg_311_1.var_.actorSpriteComps1038 == nil then
				arg_311_1.var_.actorSpriteComps1038 = arg_311_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_0 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1038"]) then
				if arg_311_1.var_.actorSpriteComps1038 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								iter_314_1.color = Color.New(Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor1.r, (arg_311_1.time_ - 0) / var_314_0), Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor1.g, (arg_311_1.time_ - 0) / var_314_0), (Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor1.b, (arg_311_1.time_ - 0) / var_314_0)))
							else
								local var_314_1 = Mathf.Lerp(iter_314_1.color.r, 1, (arg_311_1.time_ - 0) / var_314_0)

								iter_314_1.color = Color.New(var_314_1, var_314_1, var_314_1)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1038"]) and arg_311_1.var_.actorSpriteComps1038 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_314_3 then
						iter_314_3.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_311_1.var_.actorSpriteComps1038 = nil
			end

			local var_314_2 = arg_311_1.actors_["10030"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.actorSpriteComps10030 == nil then
				arg_311_1.var_.actorSpriteComps10030 = var_314_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_3 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_3 and not isNil(var_314_2) then
				if arg_311_1.var_.actorSpriteComps10030 then
					for iter_314_4, iter_314_5 in pairs(arg_311_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_314_5 then
							if arg_311_1.isInRecall_ then
								iter_314_5.color = Color.New(Mathf.Lerp(iter_314_5.color.r, arg_311_1.hightColor2.r, (arg_311_1.time_ - 0) / var_314_3), Mathf.Lerp(iter_314_5.color.g, arg_311_1.hightColor2.g, (arg_311_1.time_ - 0) / var_314_3), (Mathf.Lerp(iter_314_5.color.b, arg_311_1.hightColor2.b, (arg_311_1.time_ - 0) / var_314_3)))
							else
								local var_314_4 = Mathf.Lerp(iter_314_5.color.r, 0.5, (arg_311_1.time_ - 0) / var_314_3)

								iter_314_5.color = Color.New(var_314_4, var_314_4, var_314_4)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= 0 + var_314_3 and arg_311_1.time_ < 0 + var_314_3 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.actorSpriteComps10030 then
				for iter_314_6, iter_314_7 in pairs(arg_311_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_314_7 then
						iter_314_7.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_311_1.var_.actorSpriteComps10030 = nil
			end

			local var_314_5 = 0
			local var_314_6 = 1.325

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_7 = arg_311_1:GetWordFromCfg(115261076)
				local var_314_8 = arg_311_1:FormatText(var_314_7.content)

				arg_311_1.text_.text = var_314_8

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_10 = 53 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 53)

				if (53 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 53)) > 0 and var_314_6 < var_314_10 then
					arg_311_1.talkMaxDuration = var_314_10

					if var_314_10 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_5
					end
				end

				arg_311_1.text_.text = var_314_8
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261076", "story_v_out_115261.awb") ~= 0 then
					local var_314_11 = manager.audio:GetVoiceLength("story_v_out_115261", "115261076", "story_v_out_115261.awb") / 1000

					if var_314_11 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_11 + var_314_5
					end

					if var_314_7.prefab_name ~= "" and arg_311_1.actors_[var_314_7.prefab_name] ~= nil then
						local var_314_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_7.prefab_name].transform, "story_v_out_115261", "115261076", "story_v_out_115261.awb")

						arg_311_1:RecordAudio("115261076", var_314_12)
						arg_311_1:RecordAudio("115261076", var_314_12)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_115261", "115261076", "story_v_out_115261.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_115261", "115261076", "story_v_out_115261.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_13 = math.max(var_314_6, arg_311_1.talkMaxDuration)

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_13 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_5) / var_314_13

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_5 + var_314_13 and arg_311_1.time_ < var_314_5 + var_314_13 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play115261077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 115261077
		arg_315_1.duration_ = 10.4

		local var_315_0 = {
			ja = 10.4,
			ko = 7.766,
			zh = 10.166,
			en = 8.333
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play115261078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1038"]) and arg_315_1.var_.actorSpriteComps1038 == nil then
				arg_315_1.var_.actorSpriteComps1038 = arg_315_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_0 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1038"]) then
				if arg_315_1.var_.actorSpriteComps1038 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								iter_318_1.color = Color.New(Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor2.r, (arg_315_1.time_ - 0) / var_318_0), Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor2.g, (arg_315_1.time_ - 0) / var_318_0), (Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor2.b, (arg_315_1.time_ - 0) / var_318_0)))
							else
								local var_318_1 = Mathf.Lerp(iter_318_1.color.r, 0.5, (arg_315_1.time_ - 0) / var_318_0)

								iter_318_1.color = Color.New(var_318_1, var_318_1, var_318_1)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1038"]) and arg_315_1.var_.actorSpriteComps1038 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_318_3 then
						iter_318_3.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_315_1.var_.actorSpriteComps1038 = nil
			end

			local var_318_2 = arg_315_1.actors_["10030"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.actorSpriteComps10030 == nil then
				arg_315_1.var_.actorSpriteComps10030 = var_318_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_3 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_3 and not isNil(var_318_2) then
				if arg_315_1.var_.actorSpriteComps10030 then
					for iter_318_4, iter_318_5 in pairs(arg_315_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_318_5 then
							if arg_315_1.isInRecall_ then
								iter_318_5.color = Color.New(Mathf.Lerp(iter_318_5.color.r, arg_315_1.hightColor1.r, (arg_315_1.time_ - 0) / var_318_3), Mathf.Lerp(iter_318_5.color.g, arg_315_1.hightColor1.g, (arg_315_1.time_ - 0) / var_318_3), (Mathf.Lerp(iter_318_5.color.b, arg_315_1.hightColor1.b, (arg_315_1.time_ - 0) / var_318_3)))
							else
								local var_318_4 = Mathf.Lerp(iter_318_5.color.r, 1, (arg_315_1.time_ - 0) / var_318_3)

								iter_318_5.color = Color.New(var_318_4, var_318_4, var_318_4)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_3 and arg_315_1.time_ < 0 + var_318_3 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.actorSpriteComps10030 then
				for iter_318_6, iter_318_7 in pairs(arg_315_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_318_7 then
						iter_318_7.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_315_1.var_.actorSpriteComps10030 = nil
			end

			local var_318_5 = arg_315_1.actors_["10030"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos10030 = var_318_5.localPosition
				var_318_5.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("10030", 4)

				for iter_318_8 = 0, var_318_5.childCount - 1 do
					local var_318_6 = var_318_5:GetChild(iter_318_8)

					if var_318_6.name == "split_5" or not string.find(var_318_6.name, "split") then
						var_318_6.gameObject:SetActive(true)
					else
						var_318_6.gameObject:SetActive(false)
					end
				end
			end

			local var_318_7 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				var_318_5.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_315_1.time_ - 0) / var_318_7)
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				var_318_5.localPosition = Vector3.New(390, -390, 150)
			end

			local var_318_8 = 0
			local var_318_9 = 0.75

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_8 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_10 = arg_315_1:GetWordFromCfg(115261077)
				local var_318_11 = arg_315_1:FormatText(var_318_10.content)

				arg_315_1.text_.text = var_318_11

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_13 = 38 <= 0 and var_318_9 or var_318_9 * (utf8.len(var_318_11) / 38)

				if (38 <= 0 and var_318_9 or var_318_9 * (utf8.len(var_318_11) / 38)) > 0 and var_318_9 < var_318_13 then
					arg_315_1.talkMaxDuration = var_318_13

					if var_318_13 + var_318_8 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_13 + var_318_8
					end
				end

				arg_315_1.text_.text = var_318_11
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261077", "story_v_out_115261.awb") ~= 0 then
					local var_318_14 = manager.audio:GetVoiceLength("story_v_out_115261", "115261077", "story_v_out_115261.awb") / 1000

					if var_318_14 + var_318_8 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_14 + var_318_8
					end

					if var_318_10.prefab_name ~= "" and arg_315_1.actors_[var_318_10.prefab_name] ~= nil then
						local var_318_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_10.prefab_name].transform, "story_v_out_115261", "115261077", "story_v_out_115261.awb")

						arg_315_1:RecordAudio("115261077", var_318_15)
						arg_315_1:RecordAudio("115261077", var_318_15)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_115261", "115261077", "story_v_out_115261.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_115261", "115261077", "story_v_out_115261.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_16 = math.max(var_318_9, arg_315_1.talkMaxDuration)

			if var_318_8 <= arg_315_1.time_ and arg_315_1.time_ < var_318_8 + var_318_16 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_8) / var_318_16

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_8 + var_318_16 and arg_315_1.time_ < var_318_8 + var_318_16 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play115261078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 115261078
		arg_319_1.duration_ = 12.17

		local var_319_0 = {
			ja = 12.166,
			ko = 7.4,
			zh = 6.2,
			en = 7.933
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
				arg_319_0:Play115261079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos10030 = arg_319_1.actors_["10030"].transform.localPosition
				arg_319_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("10030", 4)

				for iter_322_0 = 0, arg_319_1.actors_["10030"].transform.childCount - 1 do
					local var_322_0 = arg_319_1.actors_["10030"].transform:GetChild(iter_322_0)

					if var_322_0.name == "split_3" or not string.find(var_322_0.name, "split") then
						var_322_0.gameObject:SetActive(true)
					else
						var_322_0.gameObject:SetActive(false)
					end
				end
			end

			local var_322_1 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_1 then
				arg_319_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_319_1.time_ - 0) / var_322_1)
			end

			if arg_319_1.time_ >= 0 + var_322_1 and arg_319_1.time_ < 0 + var_322_1 + arg_322_0 then
				arg_319_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				local var_322_2 = arg_319_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_322_2 then
					arg_319_1.var_.alphaOldValue10030 = var_322_2.alpha
					arg_319_1.var_.characterEffect10030 = var_322_2
				end

				arg_319_1.var_.alphaOldValue10030 = 0
			end

			local var_322_3 = 0.0166666666666667

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_3 then
				if arg_319_1.var_.characterEffect10030 then
					arg_319_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_319_1.var_.alphaOldValue10030, 1, (arg_319_1.time_ - 0) / var_322_3)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_3 and arg_319_1.time_ < 0 + var_322_3 + arg_322_0 and arg_319_1.var_.characterEffect10030 then
				arg_319_1.var_.characterEffect10030.alpha = 1
			end

			local var_322_4 = 0
			local var_322_5 = 0.75

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_6 = arg_319_1:GetWordFromCfg(115261078)
				local var_322_7 = arg_319_1:FormatText(var_322_6.content)

				arg_319_1.text_.text = var_322_7

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_9 = 30 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 30)

				if (30 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 30)) > 0 and var_322_5 < var_322_9 then
					arg_319_1.talkMaxDuration = var_322_9

					if var_322_9 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_7
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261078", "story_v_out_115261.awb") ~= 0 then
					local var_322_10 = manager.audio:GetVoiceLength("story_v_out_115261", "115261078", "story_v_out_115261.awb") / 1000

					if var_322_10 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_4
					end

					if var_322_6.prefab_name ~= "" and arg_319_1.actors_[var_322_6.prefab_name] ~= nil then
						local var_322_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_6.prefab_name].transform, "story_v_out_115261", "115261078", "story_v_out_115261.awb")

						arg_319_1:RecordAudio("115261078", var_322_11)
						arg_319_1:RecordAudio("115261078", var_322_11)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_115261", "115261078", "story_v_out_115261.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_115261", "115261078", "story_v_out_115261.awb")
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
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play115261079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 115261079
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play115261080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				local var_326_0 = arg_323_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_326_0 then
					arg_323_1.var_.alphaOldValue10030 = var_326_0.alpha
					arg_323_1.var_.characterEffect10030 = var_326_0
				end

				arg_323_1.var_.alphaOldValue10030 = 1
			end

			local var_326_1 = 0.333333333333333

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_1 then
				if arg_323_1.var_.characterEffect10030 then
					arg_323_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_323_1.var_.alphaOldValue10030, 0, (arg_323_1.time_ - 0) / var_326_1)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_1 and arg_323_1.time_ < 0 + var_326_1 + arg_326_0 and arg_323_1.var_.characterEffect10030 then
				arg_323_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				local var_326_2 = arg_323_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_326_2 then
					arg_323_1.var_.alphaOldValue1038 = var_326_2.alpha
					arg_323_1.var_.characterEffect1038 = var_326_2
				end

				arg_323_1.var_.alphaOldValue1038 = 1
			end

			local var_326_3 = 0.333333333333333

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 then
				if arg_323_1.var_.characterEffect1038 then
					arg_323_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_323_1.var_.alphaOldValue1038, 0, (arg_323_1.time_ - 0) / var_326_3)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 and arg_323_1.var_.characterEffect1038 then
				arg_323_1.var_.characterEffect1038.alpha = 0
			end

			local var_326_4 = 0
			local var_326_5 = 0.85

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_6 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(115261079).content)

				arg_323_1.text_.text = var_326_6

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_8 = 34 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_6) / 34)

				if (34 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_6) / 34)) > 0 and var_326_5 < var_326_8 then
					arg_323_1.talkMaxDuration = var_326_8

					if var_326_8 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_8 + var_326_4
					end
				end

				arg_323_1.text_.text = var_326_6
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_9 = math.max(var_326_5, arg_323_1.talkMaxDuration)

			if var_326_4 <= arg_323_1.time_ and arg_323_1.time_ < var_326_4 + var_326_9 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_4) / var_326_9

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_4 + var_326_9 and arg_323_1.time_ < var_326_4 + var_326_9 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play115261080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 115261080
		arg_327_1.duration_ = 4.6

		local var_327_0 = {
			ja = 2.633,
			ko = 2.433,
			zh = 4.6,
			en = 3.266
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
				arg_327_0:Play115261081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1038"]) and arg_327_1.var_.actorSpriteComps1038 == nil then
				arg_327_1.var_.actorSpriteComps1038 = arg_327_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_0 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1038"]) then
				if arg_327_1.var_.actorSpriteComps1038 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								iter_330_1.color = Color.New(Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor1.r, (arg_327_1.time_ - 0) / var_330_0), Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor1.g, (arg_327_1.time_ - 0) / var_330_0), (Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor1.b, (arg_327_1.time_ - 0) / var_330_0)))
							else
								local var_330_1 = Mathf.Lerp(iter_330_1.color.r, 1, (arg_327_1.time_ - 0) / var_330_0)

								iter_330_1.color = Color.New(var_330_1, var_330_1, var_330_1)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1038"]) and arg_327_1.var_.actorSpriteComps1038 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_330_3 then
						iter_330_3.color = arg_327_1.isInRecall_ and (arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_327_1.var_.actorSpriteComps1038 = nil
			end

			local var_330_2 = arg_327_1.actors_["1038"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1038 = var_330_2.localPosition
				var_330_2.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("1038", 3)

				for iter_330_4 = 0, var_330_2.childCount - 1 do
					local var_330_3 = var_330_2:GetChild(iter_330_4)

					if var_330_3.name == "split_1" or not string.find(var_330_3.name, "split") then
						var_330_3.gameObject:SetActive(true)
					else
						var_330_3.gameObject:SetActive(false)
					end
				end
			end

			local var_330_4 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 then
				var_330_2.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_327_1.time_ - 0) / var_330_4)
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 then
				var_330_2.localPosition = Vector3.New(0, -400, 0)
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				local var_330_5 = arg_327_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_330_5 then
					arg_327_1.var_.alphaOldValue1038 = var_330_5.alpha
					arg_327_1.var_.characterEffect1038 = var_330_5
				end

				arg_327_1.var_.alphaOldValue1038 = 0
			end

			local var_330_6 = 0.333333333333333

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_6 then
				if arg_327_1.var_.characterEffect1038 then
					arg_327_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_327_1.var_.alphaOldValue1038, 1, (arg_327_1.time_ - 0) / var_330_6)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_6 and arg_327_1.time_ < 0 + var_330_6 + arg_330_0 and arg_327_1.var_.characterEffect1038 then
				arg_327_1.var_.characterEffect1038.alpha = 1
			end

			local var_330_7 = 0
			local var_330_8 = 0.225

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_7 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_9 = arg_327_1:GetWordFromCfg(115261080)
				local var_330_10 = arg_327_1:FormatText(var_330_9.content)

				arg_327_1.text_.text = var_330_10

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_12 = 9 <= 0 and var_330_8 or var_330_8 * (utf8.len(var_330_10) / 9)

				if (9 <= 0 and var_330_8 or var_330_8 * (utf8.len(var_330_10) / 9)) > 0 and var_330_8 < var_330_12 then
					arg_327_1.talkMaxDuration = var_330_12

					if var_330_12 + var_330_7 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_12 + var_330_7
					end
				end

				arg_327_1.text_.text = var_330_10
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261080", "story_v_out_115261.awb") ~= 0 then
					local var_330_13 = manager.audio:GetVoiceLength("story_v_out_115261", "115261080", "story_v_out_115261.awb") / 1000

					if var_330_13 + var_330_7 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_7
					end

					if var_330_9.prefab_name ~= "" and arg_327_1.actors_[var_330_9.prefab_name] ~= nil then
						local var_330_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_9.prefab_name].transform, "story_v_out_115261", "115261080", "story_v_out_115261.awb")

						arg_327_1:RecordAudio("115261080", var_330_14)
						arg_327_1:RecordAudio("115261080", var_330_14)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_115261", "115261080", "story_v_out_115261.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_115261", "115261080", "story_v_out_115261.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_15 = math.max(var_330_8, arg_327_1.talkMaxDuration)

			if var_330_7 <= arg_327_1.time_ and arg_327_1.time_ < var_330_7 + var_330_15 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_7) / var_330_15

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_7 + var_330_15 and arg_327_1.time_ < var_330_7 + var_330_15 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play115261081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 115261081
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play115261082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1038"]) and arg_331_1.var_.actorSpriteComps1038 == nil then
				arg_331_1.var_.actorSpriteComps1038 = arg_331_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_0 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1038"]) then
				if arg_331_1.var_.actorSpriteComps1038 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								iter_334_1.color = Color.New(Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor2.r, (arg_331_1.time_ - 0) / var_334_0), Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor2.g, (arg_331_1.time_ - 0) / var_334_0), (Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor2.b, (arg_331_1.time_ - 0) / var_334_0)))
							else
								local var_334_1 = Mathf.Lerp(iter_334_1.color.r, 0.5, (arg_331_1.time_ - 0) / var_334_0)

								iter_334_1.color = Color.New(var_334_1, var_334_1, var_334_1)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1038"]) and arg_331_1.var_.actorSpriteComps1038 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_334_3 then
						iter_334_3.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_331_1.var_.actorSpriteComps1038 = nil
			end

			if 1.999999999999 < arg_331_1.time_ and arg_331_1.time_ <= 1.999999999999 + arg_334_0 then
				arg_331_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_cup", "")
			end

			local var_334_3 = arg_331_1.actors_["1038"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1038 = var_334_3.localPosition
				var_334_3.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("1038", 7)

				for iter_334_4 = 0, var_334_3.childCount - 1 do
					local var_334_4 = var_334_3:GetChild(iter_334_4)

					if var_334_4.name == "split_1" or not string.find(var_334_4.name, "split") then
						var_334_4.gameObject:SetActive(true)
					else
						var_334_4.gameObject:SetActive(false)
					end
				end
			end

			local var_334_5 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_5 then
				var_334_3.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1038, Vector3.New(0, -2000, 0), (arg_331_1.time_ - 0) / var_334_5)
			end

			if arg_331_1.time_ >= 0 + var_334_5 and arg_331_1.time_ < 0 + var_334_5 + arg_334_0 then
				var_334_3.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_334_6 = 0
			local var_334_7 = 0.9

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_6 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_8 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(115261081).content)

				arg_331_1.text_.text = var_334_8

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_10 = 36 <= 0 and var_334_7 or var_334_7 * (utf8.len(var_334_8) / 36)

				if (36 <= 0 and var_334_7 or var_334_7 * (utf8.len(var_334_8) / 36)) > 0 and var_334_7 < var_334_10 then
					arg_331_1.talkMaxDuration = var_334_10

					if var_334_10 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_10 + var_334_6
					end
				end

				arg_331_1.text_.text = var_334_8
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_11 = math.max(var_334_7, arg_331_1.talkMaxDuration)

			if var_334_6 <= arg_331_1.time_ and arg_331_1.time_ < var_334_6 + var_334_11 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_6) / var_334_11

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_6 + var_334_11 and arg_331_1.time_ < var_334_6 + var_334_11 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play115261082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 115261082
		arg_335_1.duration_ = 5.47

		local var_335_0 = {
			ja = 5.4,
			ko = 4.833,
			zh = 5.466,
			en = 5
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play115261083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1038"]) and arg_335_1.var_.actorSpriteComps1038 == nil then
				arg_335_1.var_.actorSpriteComps1038 = arg_335_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_0 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1038"]) then
				if arg_335_1.var_.actorSpriteComps1038 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								iter_338_1.color = Color.New(Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor1.r, (arg_335_1.time_ - 0) / var_338_0), Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor1.g, (arg_335_1.time_ - 0) / var_338_0), (Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor1.b, (arg_335_1.time_ - 0) / var_338_0)))
							else
								local var_338_1 = Mathf.Lerp(iter_338_1.color.r, 1, (arg_335_1.time_ - 0) / var_338_0)

								iter_338_1.color = Color.New(var_338_1, var_338_1, var_338_1)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1038"]) and arg_335_1.var_.actorSpriteComps1038 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_338_3 then
						iter_338_3.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_335_1.var_.actorSpriteComps1038 = nil
			end

			local var_338_2 = arg_335_1.actors_["1038"].transform

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1038 = var_338_2.localPosition
				var_338_2.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("1038", 3)

				for iter_338_4 = 0, var_338_2.childCount - 1 do
					local var_338_3 = var_338_2:GetChild(iter_338_4)

					if var_338_3.name == "split_9" or not string.find(var_338_3.name, "split") then
						var_338_3.gameObject:SetActive(true)
					else
						var_338_3.gameObject:SetActive(false)
					end
				end
			end

			local var_338_4 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				var_338_2.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_335_1.time_ - 0) / var_338_4)
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				var_338_2.localPosition = Vector3.New(0, -400, 0)
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				local var_338_5 = arg_335_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_338_5 then
					arg_335_1.var_.alphaOldValue1038 = var_338_5.alpha
					arg_335_1.var_.characterEffect1038 = var_338_5
				end

				arg_335_1.var_.alphaOldValue1038 = 0
			end

			local var_338_6 = 0.5

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_6 then
				if arg_335_1.var_.characterEffect1038 then
					arg_335_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_335_1.var_.alphaOldValue1038, 1, (arg_335_1.time_ - 0) / var_338_6)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_6 and arg_335_1.time_ < 0 + var_338_6 + arg_338_0 and arg_335_1.var_.characterEffect1038 then
				arg_335_1.var_.characterEffect1038.alpha = 1
			end

			local var_338_7 = 0
			local var_338_8 = 0.45

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_7 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_9 = arg_335_1:GetWordFromCfg(115261082)
				local var_338_10 = arg_335_1:FormatText(var_338_9.content)

				arg_335_1.text_.text = var_338_10

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_12 = 18 <= 0 and var_338_8 or var_338_8 * (utf8.len(var_338_10) / 18)

				if (18 <= 0 and var_338_8 or var_338_8 * (utf8.len(var_338_10) / 18)) > 0 and var_338_8 < var_338_12 then
					arg_335_1.talkMaxDuration = var_338_12

					if var_338_12 + var_338_7 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_12 + var_338_7
					end
				end

				arg_335_1.text_.text = var_338_10
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261082", "story_v_out_115261.awb") ~= 0 then
					local var_338_13 = manager.audio:GetVoiceLength("story_v_out_115261", "115261082", "story_v_out_115261.awb") / 1000

					if var_338_13 + var_338_7 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_13 + var_338_7
					end

					if var_338_9.prefab_name ~= "" and arg_335_1.actors_[var_338_9.prefab_name] ~= nil then
						local var_338_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_9.prefab_name].transform, "story_v_out_115261", "115261082", "story_v_out_115261.awb")

						arg_335_1:RecordAudio("115261082", var_338_14)
						arg_335_1:RecordAudio("115261082", var_338_14)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_115261", "115261082", "story_v_out_115261.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_115261", "115261082", "story_v_out_115261.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_15 = math.max(var_338_8, arg_335_1.talkMaxDuration)

			if var_338_7 <= arg_335_1.time_ and arg_335_1.time_ < var_338_7 + var_338_15 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_7) / var_338_15

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_7 + var_338_15 and arg_335_1.time_ < var_338_7 + var_338_15 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play115261083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 115261083
		arg_339_1.duration_ = 8.33

		local var_339_0 = {
			ja = 8.333,
			ko = 7.5,
			zh = 8.3,
			en = 7.4
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
				arg_339_0:Play115261084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if arg_339_1.bgs_.ST27a == nil then
				local var_342_0 = Object.Instantiate(arg_339_1.paintGo_)

				var_342_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST27a")
				var_342_0.name = "ST27a"
				var_342_0.transform.parent = arg_339_1.stage_.transform
				var_342_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_339_1.bgs_.ST27a = var_342_0
			end

			if 2 < arg_339_1.time_ and arg_339_1.time_ <= 2 + arg_342_0 then
				local var_342_1 = arg_339_1.bgs_.ST27a

				arg_339_1.bgs_.ST27a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_342_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_342_2 = var_342_1:GetComponent("SpriteRenderer")

				if var_342_2 and var_342_2.sprite then
					local var_342_3 = 2 * (var_342_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_342_1.transform.localScale = Vector3.New(var_342_3 / var_342_2.sprite.bounds.size.y < var_342_3 * manager.ui.mainCameraCom_.aspect / var_342_2.sprite.bounds.size.x and var_342_3 * manager.ui.mainCameraCom_.aspect / var_342_2.sprite.bounds.size.x or var_342_3 / var_342_2.sprite.bounds.size.y, var_342_3 / var_342_2.sprite.bounds.size.y < var_342_3 * manager.ui.mainCameraCom_.aspect / var_342_2.sprite.bounds.size.x and var_342_3 * manager.ui.mainCameraCom_.aspect / var_342_2.sprite.bounds.size.x or var_342_3 / var_342_2.sprite.bounds.size.y, 0)
				end

				for iter_342_0, iter_342_1 in pairs(arg_339_1.bgs_) do
					if iter_342_0 ~= "ST27a" then
						iter_342_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_342_4 = arg_339_1.actors_["1038"].transform

			if 1.99933333333333 < arg_339_1.time_ and arg_339_1.time_ <= 1.99933333333333 + arg_342_0 then
				arg_339_1.var_.moveOldPos1038 = var_342_4.localPosition
				var_342_4.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("1038", 0)

				for iter_342_2 = 0, var_342_4.childCount - 1 do
					local var_342_5 = var_342_4:GetChild(iter_342_2)

					if var_342_5.name == "split_9" or not string.find(var_342_5.name, "split") then
						var_342_5.gameObject:SetActive(true)
					else
						var_342_5.gameObject:SetActive(false)
					end
				end
			end

			local var_342_6 = 0.001

			if 1.99933333333333 <= arg_339_1.time_ and arg_339_1.time_ < 1.99933333333333 + var_342_6 then
				var_342_4.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1038, Vector3.New(-2000, -400, 0), (arg_339_1.time_ - 1.99933333333333) / var_342_6)
			end

			if arg_339_1.time_ >= 1.99933333333333 + var_342_6 and arg_339_1.time_ < 1.99933333333333 + var_342_6 + arg_342_0 then
				var_342_4.localPosition = Vector3.New(-2000, -400, 0)
			end

			local var_342_7 = arg_339_1.actors_["10030"].transform

			if 4 < arg_339_1.time_ and arg_339_1.time_ <= 4 + arg_342_0 then
				arg_339_1.var_.moveOldPos10030 = var_342_7.localPosition
				var_342_7.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("10030", 3)

				for iter_342_3 = 0, var_342_7.childCount - 1 do
					local var_342_8 = var_342_7:GetChild(iter_342_3)

					if var_342_8.name == "split_3" or not string.find(var_342_8.name, "split") then
						var_342_8.gameObject:SetActive(true)
					else
						var_342_8.gameObject:SetActive(false)
					end
				end
			end

			local var_342_9 = 0.001

			if 4 <= arg_339_1.time_ and arg_339_1.time_ < 4 + var_342_9 then
				var_342_7.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_339_1.time_ - 4) / var_342_9)
			end

			if arg_339_1.time_ >= 4 + var_342_9 and arg_339_1.time_ < 4 + var_342_9 + arg_342_0 then
				var_342_7.localPosition = Vector3.New(0, -390, 150)
			end

			local var_342_10 = arg_339_1.actors_["10030"]

			if 4 < arg_339_1.time_ and arg_339_1.time_ <= 4 + arg_342_0 and not isNil(var_342_10) and arg_339_1.var_.actorSpriteComps10030 == nil then
				arg_339_1.var_.actorSpriteComps10030 = var_342_10:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_11 = 0.2

			if 4 <= arg_339_1.time_ and arg_339_1.time_ < 4 + var_342_11 and not isNil(var_342_10) then
				if arg_339_1.var_.actorSpriteComps10030 then
					for iter_342_4, iter_342_5 in pairs(arg_339_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_342_5 then
							if arg_339_1.isInRecall_ then
								iter_342_5.color = Color.New(Mathf.Lerp(iter_342_5.color.r, arg_339_1.hightColor1.r, (arg_339_1.time_ - 4) / var_342_11), Mathf.Lerp(iter_342_5.color.g, arg_339_1.hightColor1.g, (arg_339_1.time_ - 4) / var_342_11), (Mathf.Lerp(iter_342_5.color.b, arg_339_1.hightColor1.b, (arg_339_1.time_ - 4) / var_342_11)))
							else
								local var_342_12 = Mathf.Lerp(iter_342_5.color.r, 1, (arg_339_1.time_ - 4) / var_342_11)

								iter_342_5.color = Color.New(var_342_12, var_342_12, var_342_12)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 4 + var_342_11 and arg_339_1.time_ < 4 + var_342_11 + arg_342_0 and not isNil(var_342_10) and arg_339_1.var_.actorSpriteComps10030 then
				for iter_342_6, iter_342_7 in pairs(arg_339_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_342_7 then
						iter_342_7.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_339_1.var_.actorSpriteComps10030 = nil
			end

			local var_342_13 = 0

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_13 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_14 = 2

			if var_342_13 <= arg_339_1.time_ and arg_339_1.time_ < var_342_13 + var_342_14 then
				local var_342_15 = Color.New(0, 0, 0)

				var_342_15.a = Mathf.Lerp(0, 1, (arg_339_1.time_ - var_342_13) / var_342_14)
				arg_339_1.mask_.color = var_342_15
			end

			if arg_339_1.time_ >= var_342_13 + var_342_14 and arg_339_1.time_ < var_342_13 + var_342_14 + arg_342_0 then
				local var_342_16 = Color.New(0, 0, 0)

				var_342_16.a = 1
				arg_339_1.mask_.color = var_342_16
			end

			local var_342_17 = 2

			if 2 < arg_339_1.time_ and arg_339_1.time_ <= var_342_17 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_18 = 2

			if var_342_17 <= arg_339_1.time_ and arg_339_1.time_ < var_342_17 + var_342_18 then
				local var_342_19 = Color.New(0, 0, 0)

				var_342_19.a = Mathf.Lerp(1, 0, (arg_339_1.time_ - var_342_17) / var_342_18)
				arg_339_1.mask_.color = var_342_19
			end

			if arg_339_1.time_ >= var_342_17 + var_342_18 and arg_339_1.time_ < var_342_17 + var_342_18 + arg_342_0 then
				local var_342_20 = Color.New(0, 0, 0)

				arg_339_1.mask_.enabled = false
				var_342_20.a = 0
				arg_339_1.mask_.color = var_342_20
			end

			if 4 < arg_339_1.time_ and arg_339_1.time_ <= 4 + arg_342_0 then
				local var_342_21 = arg_339_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_342_21 then
					arg_339_1.var_.alphaOldValue10030 = var_342_21.alpha
					arg_339_1.var_.characterEffect10030 = var_342_21
				end

				arg_339_1.var_.alphaOldValue10030 = 0
			end

			local var_342_22 = 0.333333333333333

			if 4 <= arg_339_1.time_ and arg_339_1.time_ < 4 + var_342_22 then
				if arg_339_1.var_.characterEffect10030 then
					arg_339_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_339_1.var_.alphaOldValue10030, 1, (arg_339_1.time_ - 4) / var_342_22)
				end
			end

			if arg_339_1.time_ >= 4 + var_342_22 and arg_339_1.time_ < 4 + var_342_22 + arg_342_0 and arg_339_1.var_.characterEffect10030 then
				arg_339_1.var_.characterEffect10030.alpha = 1
			end

			if arg_339_1.frameCnt_ <= 1 then
				arg_339_1.dialog_:SetActive(false)
			end

			local var_342_23 = 4
			local var_342_24 = 0.4

			if 4 < arg_339_1.time_ and arg_339_1.time_ <= var_342_23 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0

				arg_339_1.dialog_:SetActive(true)

				arg_339_1.dialogCg_.alpha = 0

				local var_342_25 = LeanTween.value(arg_339_1.dialog_, 0, 1, 0.3)

				var_342_25:setOnUpdate(LuaHelper.FloatAction(function(arg_343_0)
					arg_339_1.dialogCg_.alpha = arg_343_0
				end))
				var_342_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_339_1.dialog_)
					var_342_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_339_1.duration_ = arg_339_1.duration_ + 0.3

				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_26 = arg_339_1:GetWordFromCfg(115261083)
				local var_342_27 = arg_339_1:FormatText(var_342_26.content)

				arg_339_1.text_.text = var_342_27

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_29 = 16 <= 0 and var_342_24 or var_342_24 * (utf8.len(var_342_27) / 16)

				if (16 <= 0 and var_342_24 or var_342_24 * (utf8.len(var_342_27) / 16)) > 0 and var_342_24 < var_342_29 then
					arg_339_1.talkMaxDuration = var_342_29
					var_342_23 = var_342_23 + 0.3

					if var_342_29 + var_342_23 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_29 + var_342_23
					end
				end

				arg_339_1.text_.text = var_342_27
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261083", "story_v_out_115261.awb") ~= 0 then
					local var_342_30 = manager.audio:GetVoiceLength("story_v_out_115261", "115261083", "story_v_out_115261.awb") / 1000

					if var_342_30 + var_342_23 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_30 + var_342_23
					end

					if var_342_26.prefab_name ~= "" and arg_339_1.actors_[var_342_26.prefab_name] ~= nil then
						local var_342_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_26.prefab_name].transform, "story_v_out_115261", "115261083", "story_v_out_115261.awb")

						arg_339_1:RecordAudio("115261083", var_342_31)
						arg_339_1:RecordAudio("115261083", var_342_31)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_115261", "115261083", "story_v_out_115261.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_115261", "115261083", "story_v_out_115261.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_32 = var_342_23 + 0.3
			local var_342_33 = math.max(var_342_24, arg_339_1.talkMaxDuration)

			if var_342_23 + 0.3 <= arg_339_1.time_ and arg_339_1.time_ < var_342_32 + var_342_33 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_32) / var_342_33

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_32 + var_342_33 and arg_339_1.time_ < var_342_32 + var_342_33 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.99933333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play115261084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 115261084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play115261085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				local var_348_0 = arg_345_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_348_0 then
					arg_345_1.var_.alphaOldValue10030 = var_348_0.alpha
					arg_345_1.var_.characterEffect10030 = var_348_0
				end

				arg_345_1.var_.alphaOldValue10030 = 1
			end

			local var_348_1 = 0.333333333333333

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_1 then
				if arg_345_1.var_.characterEffect10030 then
					arg_345_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_345_1.var_.alphaOldValue10030, 0, (arg_345_1.time_ - 0) / var_348_1)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_1 and arg_345_1.time_ < 0 + var_348_1 + arg_348_0 and arg_345_1.var_.characterEffect10030 then
				arg_345_1.var_.characterEffect10030.alpha = 0
			end

			local var_348_2 = 0
			local var_348_3 = 0.6

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_2 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_4 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(115261084).content)

				arg_345_1.text_.text = var_348_4

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_6 = 24 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_4) / 24)

				if (24 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_4) / 24)) > 0 and var_348_3 < var_348_6 then
					arg_345_1.talkMaxDuration = var_348_6

					if var_348_6 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_6 + var_348_2
					end
				end

				arg_345_1.text_.text = var_348_4
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_3, arg_345_1.talkMaxDuration)

			if var_348_2 <= arg_345_1.time_ and arg_345_1.time_ < var_348_2 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_2) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_2 + var_348_7 and arg_345_1.time_ < var_348_2 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play115261085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 115261085
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play115261086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 1.325

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_1 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(115261085).content)

				arg_349_1.text_.text = var_352_1

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_3 = 53 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 53)

				if (53 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 53)) > 0 and var_352_0 < var_352_3 then
					arg_349_1.talkMaxDuration = var_352_3

					if var_352_3 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_3 + 0
					end
				end

				arg_349_1.text_.text = var_352_1
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_4 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_4

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play115261086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 115261086
		arg_353_1.duration_ = 7.4

		local var_353_0 = {
			ja = 6.866,
			ko = 7.166,
			zh = 7.4,
			en = 5.866
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play115261087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0.65

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[310].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_1 = arg_353_1:GetWordFromCfg(115261086)
				local var_356_2 = arg_353_1:FormatText(var_356_1.content)

				arg_353_1.text_.text = var_356_2

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_4 = 26 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_2) / 26)

				if (26 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_2) / 26)) > 0 and var_356_0 < var_356_4 then
					arg_353_1.talkMaxDuration = var_356_4

					if var_356_4 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_4 + 0
					end
				end

				arg_353_1.text_.text = var_356_2
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261086", "story_v_out_115261.awb") ~= 0 then
					local var_356_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261086", "story_v_out_115261.awb") / 1000

					if var_356_5 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_5 + 0
					end

					if var_356_1.prefab_name ~= "" and arg_353_1.actors_[var_356_1.prefab_name] ~= nil then
						local var_356_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_1.prefab_name].transform, "story_v_out_115261", "115261086", "story_v_out_115261.awb")

						arg_353_1:RecordAudio("115261086", var_356_6)
						arg_353_1:RecordAudio("115261086", var_356_6)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_115261", "115261086", "story_v_out_115261.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_115261", "115261086", "story_v_out_115261.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_7 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_7 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_7

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_7 and arg_353_1.time_ < 0 + var_356_7 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play115261087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 115261087
		arg_357_1.duration_ = 9.97

		local var_357_0 = {
			ja = 7.166,
			ko = 9.9,
			zh = 8.7,
			en = 9.966
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play115261088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 1.075

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_1 = arg_357_1:GetWordFromCfg(115261087)
				local var_360_2 = arg_357_1:FormatText(var_360_1.content)

				arg_357_1.text_.text = var_360_2

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_4 = 43 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 43)

				if (43 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 43)) > 0 and var_360_0 < var_360_4 then
					arg_357_1.talkMaxDuration = var_360_4

					if var_360_4 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_4 + 0
					end
				end

				arg_357_1.text_.text = var_360_2
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261087", "story_v_out_115261.awb") ~= 0 then
					local var_360_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261087", "story_v_out_115261.awb") / 1000

					if var_360_5 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + 0
					end

					if var_360_1.prefab_name ~= "" and arg_357_1.actors_[var_360_1.prefab_name] ~= nil then
						local var_360_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_1.prefab_name].transform, "story_v_out_115261", "115261087", "story_v_out_115261.awb")

						arg_357_1:RecordAudio("115261087", var_360_6)
						arg_357_1:RecordAudio("115261087", var_360_6)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_115261", "115261087", "story_v_out_115261.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_115261", "115261087", "story_v_out_115261.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_7 and arg_357_1.time_ < 0 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play115261088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 115261088
		arg_361_1.duration_ = 14.77

		local var_361_0 = {
			ja = 10.933,
			ko = 14.766,
			zh = 12.866,
			en = 14.166
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play115261089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 1.125

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[310].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_1 = arg_361_1:GetWordFromCfg(115261088)
				local var_364_2 = arg_361_1:FormatText(var_364_1.content)

				arg_361_1.text_.text = var_364_2

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_4 = 45 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 45)

				if (45 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 45)) > 0 and var_364_0 < var_364_4 then
					arg_361_1.talkMaxDuration = var_364_4

					if var_364_4 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_4 + 0
					end
				end

				arg_361_1.text_.text = var_364_2
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261088", "story_v_out_115261.awb") ~= 0 then
					local var_364_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261088", "story_v_out_115261.awb") / 1000

					if var_364_5 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + 0
					end

					if var_364_1.prefab_name ~= "" and arg_361_1.actors_[var_364_1.prefab_name] ~= nil then
						local var_364_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_1.prefab_name].transform, "story_v_out_115261", "115261088", "story_v_out_115261.awb")

						arg_361_1:RecordAudio("115261088", var_364_6)
						arg_361_1:RecordAudio("115261088", var_364_6)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_115261", "115261088", "story_v_out_115261.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_115261", "115261088", "story_v_out_115261.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_7 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_7 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_7

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_7 and arg_361_1.time_ < 0 + var_364_7 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play115261089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 115261089
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play115261090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 1.575

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(115261089).content)

				arg_365_1.text_.text = var_368_1

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_3 = 63 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 63)

				if (63 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 63)) > 0 and var_368_0 < var_368_3 then
					arg_365_1.talkMaxDuration = var_368_3

					if var_368_3 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_3 + 0
					end
				end

				arg_365_1.text_.text = var_368_1
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_4 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_4

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play115261090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 115261090
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play115261091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0.325

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_1 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(115261090).content)

				arg_369_1.text_.text = var_372_1

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_3 = 13 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 13)

				if (13 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_1) / 13)) > 0 and var_372_0 < var_372_3 then
					arg_369_1.talkMaxDuration = var_372_3

					if var_372_3 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_3 + 0
					end
				end

				arg_369_1.text_.text = var_372_1
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_4 = math.max(var_372_0, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_4 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - 0) / var_372_4

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_4 and arg_369_1.time_ < 0 + var_372_4 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play115261091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 115261091
		arg_373_1.duration_ = 14.47

		local var_373_0 = {
			ja = 12.8,
			ko = 13.866,
			zh = 12.066,
			en = 14.466
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play115261092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if arg_373_1.actors_["10029"] == nil then
				local var_376_0 = Object.Instantiate(arg_373_1.imageGo_, arg_373_1.canvasGo_.transform)

				var_376_0.transform:SetSiblingIndex(1)

				var_376_0.name = "10029"

				local var_376_1 = var_376_0:GetComponent(typeof(Image))

				var_376_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10029")

				var_376_1:SetNativeSize()

				var_376_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_373_1.actors_["10029"] = var_376_0
			end

			local var_376_2 = arg_373_1.actors_["10029"].transform

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos10029 = var_376_2.localPosition
				var_376_2.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("10029", 3)
			end

			local var_376_3 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_3 then
				var_376_2.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10029, Vector3.New(0, -350, -180), (arg_373_1.time_ - 0) / var_376_3)
			end

			if arg_373_1.time_ >= 0 + var_376_3 and arg_373_1.time_ < 0 + var_376_3 + arg_376_0 then
				var_376_2.localPosition = Vector3.New(0, -350, -180)
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				local var_376_4 = arg_373_1.actors_["10029"]:GetComponent("Image")

				if var_376_4 then
					arg_373_1.var_.alphaMatValue10029 = var_376_4
					arg_373_1.var_.alphaOldValue10029 = var_376_4.color.a
				end

				arg_373_1.var_.alphaOldValue10029 = 0
			end

			local var_376_5 = 0.333333333333333

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_5 then
				if arg_373_1.var_.alphaMatValue10029 then
					arg_373_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_373_1.var_.alphaOldValue10029, 1, (arg_373_1.time_ - 0) / var_376_5)
					arg_373_1.var_.alphaMatValue10029.color = arg_373_1.var_.alphaMatValue10029.color
				end
			end

			if arg_373_1.time_ >= 0 + var_376_5 and arg_373_1.time_ < 0 + var_376_5 + arg_376_0 and arg_373_1.var_.alphaMatValue10029 then
				arg_373_1.var_.alphaMatValue10029.color.a = 1
				arg_373_1.var_.alphaMatValue10029.color = arg_373_1.var_.alphaMatValue10029.color
			end

			local var_376_6 = 0
			local var_376_7 = 1.1

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_8 = arg_373_1:GetWordFromCfg(115261091)
				local var_376_9 = arg_373_1:FormatText(var_376_8.content)

				arg_373_1.text_.text = var_376_9

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_11 = 43 <= 0 and var_376_7 or var_376_7 * (utf8.len(var_376_9) / 43)

				if (43 <= 0 and var_376_7 or var_376_7 * (utf8.len(var_376_9) / 43)) > 0 and var_376_7 < var_376_11 then
					arg_373_1.talkMaxDuration = var_376_11

					if var_376_11 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_11 + var_376_6
					end
				end

				arg_373_1.text_.text = var_376_9
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261091", "story_v_out_115261.awb") ~= 0 then
					local var_376_12 = manager.audio:GetVoiceLength("story_v_out_115261", "115261091", "story_v_out_115261.awb") / 1000

					if var_376_12 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_12 + var_376_6
					end

					if var_376_8.prefab_name ~= "" and arg_373_1.actors_[var_376_8.prefab_name] ~= nil then
						local var_376_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_8.prefab_name].transform, "story_v_out_115261", "115261091", "story_v_out_115261.awb")

						arg_373_1:RecordAudio("115261091", var_376_13)
						arg_373_1:RecordAudio("115261091", var_376_13)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_115261", "115261091", "story_v_out_115261.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_115261", "115261091", "story_v_out_115261.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_14 = math.max(var_376_7, arg_373_1.talkMaxDuration)

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_14 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_6) / var_376_14

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_6 + var_376_14 and arg_373_1.time_ < var_376_6 + var_376_14 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play115261092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 115261092
		arg_377_1.duration_ = 12.17

		local var_377_0 = {
			ja = 3.033,
			ko = 8.933,
			zh = 7.833,
			en = 12.166
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
				arg_377_0:Play115261093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.925

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_1 = arg_377_1:GetWordFromCfg(115261092)
				local var_380_2 = arg_377_1:FormatText(var_380_1.content)

				arg_377_1.text_.text = var_380_2

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_4 = 37 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 37)

				if (37 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 37)) > 0 and var_380_0 < var_380_4 then
					arg_377_1.talkMaxDuration = var_380_4

					if var_380_4 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_4 + 0
					end
				end

				arg_377_1.text_.text = var_380_2
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261092", "story_v_out_115261.awb") ~= 0 then
					local var_380_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261092", "story_v_out_115261.awb") / 1000

					if var_380_5 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + 0
					end

					if var_380_1.prefab_name ~= "" and arg_377_1.actors_[var_380_1.prefab_name] ~= nil then
						local var_380_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_1.prefab_name].transform, "story_v_out_115261", "115261092", "story_v_out_115261.awb")

						arg_377_1:RecordAudio("115261092", var_380_6)
						arg_377_1:RecordAudio("115261092", var_380_6)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_115261", "115261092", "story_v_out_115261.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_115261", "115261092", "story_v_out_115261.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_7 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_7 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_7

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_7 and arg_377_1.time_ < 0 + var_380_7 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play115261093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 115261093
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play115261094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				local var_384_0 = arg_381_1.actors_["10029"]:GetComponent("Image")

				if var_384_0 then
					arg_381_1.var_.alphaMatValue10029 = var_384_0
					arg_381_1.var_.alphaOldValue10029 = var_384_0.color.a
				end

				arg_381_1.var_.alphaOldValue10029 = 1
			end

			local var_384_1 = 0.333333333333333

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_1 then
				if arg_381_1.var_.alphaMatValue10029 then
					arg_381_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_381_1.var_.alphaOldValue10029, 0, (arg_381_1.time_ - 0) / var_384_1)
					arg_381_1.var_.alphaMatValue10029.color = arg_381_1.var_.alphaMatValue10029.color
				end
			end

			if arg_381_1.time_ >= 0 + var_384_1 and arg_381_1.time_ < 0 + var_384_1 + arg_384_0 and arg_381_1.var_.alphaMatValue10029 then
				arg_381_1.var_.alphaMatValue10029.color.a = 0
				arg_381_1.var_.alphaMatValue10029.color = arg_381_1.var_.alphaMatValue10029.color
			end

			local var_384_2 = 0
			local var_384_3 = 1.225

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_2 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_4 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(115261093).content)

				arg_381_1.text_.text = var_384_4

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_6 = 49 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_4) / 49)

				if (49 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_4) / 49)) > 0 and var_384_3 < var_384_6 then
					arg_381_1.talkMaxDuration = var_384_6

					if var_384_6 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_6 + var_384_2
					end
				end

				arg_381_1.text_.text = var_384_4
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_3, arg_381_1.talkMaxDuration)

			if var_384_2 <= arg_381_1.time_ and arg_381_1.time_ < var_384_2 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_2) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_2 + var_384_7 and arg_381_1.time_ < var_384_2 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play115261094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 115261094
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play115261095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 1.2

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(115261094).content)

				arg_385_1.text_.text = var_388_1

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_3 = 48 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_1) / 48)

				if (48 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_1) / 48)) > 0 and var_388_0 < var_388_3 then
					arg_385_1.talkMaxDuration = var_388_3

					if var_388_3 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_3 + 0
					end
				end

				arg_385_1.text_.text = var_388_1
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_4 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_4 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_4

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_4 and arg_385_1.time_ < 0 + var_388_4 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play115261095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 115261095
		arg_389_1.duration_ = 10.4

		local var_389_0 = {
			ja = 10.4,
			ko = 7.533,
			zh = 6.033,
			en = 9.233
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play115261096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos10030 = arg_389_1.actors_["10030"].transform.localPosition
				arg_389_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("10030", 4)

				for iter_392_0 = 0, arg_389_1.actors_["10030"].transform.childCount - 1 do
					local var_392_0 = arg_389_1.actors_["10030"].transform:GetChild(iter_392_0)

					if var_392_0.name == "split_3" or not string.find(var_392_0.name, "split") then
						var_392_0.gameObject:SetActive(true)
					else
						var_392_0.gameObject:SetActive(false)
					end
				end
			end

			local var_392_1 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_1 then
				arg_389_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_389_1.time_ - 0) / var_392_1)
			end

			if arg_389_1.time_ >= 0 + var_392_1 and arg_389_1.time_ < 0 + var_392_1 + arg_392_0 then
				arg_389_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				local var_392_2 = arg_389_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_392_2 then
					arg_389_1.var_.alphaOldValue10030 = var_392_2.alpha
					arg_389_1.var_.characterEffect10030 = var_392_2
				end

				arg_389_1.var_.alphaOldValue10030 = 0
			end

			local var_392_3 = 0.333333333333333

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_3 then
				if arg_389_1.var_.characterEffect10030 then
					arg_389_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_389_1.var_.alphaOldValue10030, 1, (arg_389_1.time_ - 0) / var_392_3)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_3 and arg_389_1.time_ < 0 + var_392_3 + arg_392_0 and arg_389_1.var_.characterEffect10030 then
				arg_389_1.var_.characterEffect10030.alpha = 1
			end

			local var_392_4 = arg_389_1.actors_["10029"].transform

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos10029 = var_392_4.localPosition
				var_392_4.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_392_5 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_5 then
				var_392_4.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10029, Vector3.New(-390, -350, -180), (arg_389_1.time_ - 0) / var_392_5)
			end

			if arg_389_1.time_ >= 0 + var_392_5 and arg_389_1.time_ < 0 + var_392_5 + arg_392_0 then
				var_392_4.localPosition = Vector3.New(-390, -350, -180)
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				local var_392_6 = arg_389_1.actors_["10029"]:GetComponent("Image")

				if var_392_6 then
					arg_389_1.var_.alphaMatValue10029 = var_392_6
					arg_389_1.var_.alphaOldValue10029 = var_392_6.color.a
				end

				arg_389_1.var_.alphaOldValue10029 = 0
			end

			local var_392_7 = 0.333333333333333

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_7 then
				if arg_389_1.var_.alphaMatValue10029 then
					arg_389_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_389_1.var_.alphaOldValue10029, 1, (arg_389_1.time_ - 0) / var_392_7)
					arg_389_1.var_.alphaMatValue10029.color = arg_389_1.var_.alphaMatValue10029.color
				end
			end

			if arg_389_1.time_ >= 0 + var_392_7 and arg_389_1.time_ < 0 + var_392_7 + arg_392_0 and arg_389_1.var_.alphaMatValue10029 then
				arg_389_1.var_.alphaMatValue10029.color.a = 1
				arg_389_1.var_.alphaMatValue10029.color = arg_389_1.var_.alphaMatValue10029.color
			end

			local var_392_8 = arg_389_1.actors_["10030"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_8) and arg_389_1.var_.actorSpriteComps10030 == nil then
				arg_389_1.var_.actorSpriteComps10030 = var_392_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_9 = 0.2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_9 and not isNil(var_392_8) then
				if arg_389_1.var_.actorSpriteComps10030 then
					for iter_392_1, iter_392_2 in pairs(arg_389_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_392_2 then
							if arg_389_1.isInRecall_ then
								iter_392_2.color = Color.New(Mathf.Lerp(iter_392_2.color.r, arg_389_1.hightColor1.r, (arg_389_1.time_ - 0) / var_392_9), Mathf.Lerp(iter_392_2.color.g, arg_389_1.hightColor1.g, (arg_389_1.time_ - 0) / var_392_9), (Mathf.Lerp(iter_392_2.color.b, arg_389_1.hightColor1.b, (arg_389_1.time_ - 0) / var_392_9)))
							else
								local var_392_10 = Mathf.Lerp(iter_392_2.color.r, 1, (arg_389_1.time_ - 0) / var_392_9)

								iter_392_2.color = Color.New(var_392_10, var_392_10, var_392_10)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_9 and arg_389_1.time_ < 0 + var_392_9 + arg_392_0 and not isNil(var_392_8) and arg_389_1.var_.actorSpriteComps10030 then
				for iter_392_3, iter_392_4 in pairs(arg_389_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_392_4 then
						iter_392_4.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_389_1.var_.actorSpriteComps10030 = nil
			end

			local var_392_11 = arg_389_1.actors_["10029"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_11) then
				local var_392_12 = var_392_11:GetComponent("Image")

				if var_392_12 then
					arg_389_1.var_.highlightMatValue10029 = var_392_12
				end
			end

			local var_392_13 = 0.2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_13 and not isNil(var_392_11) then
				if arg_389_1.var_.highlightMatValue10029 then
					local var_392_14 = Mathf.Lerp(1, 0.5, (arg_389_1.time_ - 0) / var_392_13)

					arg_389_1.var_.highlightMatValue10029.color.r = var_392_14
					arg_389_1.var_.highlightMatValue10029.color.g = var_392_14
					arg_389_1.var_.highlightMatValue10029.color.b = var_392_14
					arg_389_1.var_.highlightMatValue10029.color = arg_389_1.var_.highlightMatValue10029.color
				end
			end

			if arg_389_1.time_ >= 0 + var_392_13 and arg_389_1.time_ < 0 + var_392_13 + arg_392_0 and not isNil(var_392_11) and arg_389_1.var_.highlightMatValue10029 then
				arg_389_1.var_.highlightMatValue10029.color.r = 0.5
				arg_389_1.var_.highlightMatValue10029.color.g = 0.5
				arg_389_1.var_.highlightMatValue10029.color.b = 0.5
				arg_389_1.var_.highlightMatValue10029.color = arg_389_1.var_.highlightMatValue10029.color
			end

			local var_392_15 = 0
			local var_392_16 = 0.8

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_15 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_17 = arg_389_1:GetWordFromCfg(115261095)
				local var_392_18 = arg_389_1:FormatText(var_392_17.content)

				arg_389_1.text_.text = var_392_18

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_20 = 32 <= 0 and var_392_16 or var_392_16 * (utf8.len(var_392_18) / 32)

				if (32 <= 0 and var_392_16 or var_392_16 * (utf8.len(var_392_18) / 32)) > 0 and var_392_16 < var_392_20 then
					arg_389_1.talkMaxDuration = var_392_20

					if var_392_20 + var_392_15 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_20 + var_392_15
					end
				end

				arg_389_1.text_.text = var_392_18
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261095", "story_v_out_115261.awb") ~= 0 then
					local var_392_21 = manager.audio:GetVoiceLength("story_v_out_115261", "115261095", "story_v_out_115261.awb") / 1000

					if var_392_21 + var_392_15 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_21 + var_392_15
					end

					if var_392_17.prefab_name ~= "" and arg_389_1.actors_[var_392_17.prefab_name] ~= nil then
						local var_392_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_17.prefab_name].transform, "story_v_out_115261", "115261095", "story_v_out_115261.awb")

						arg_389_1:RecordAudio("115261095", var_392_22)
						arg_389_1:RecordAudio("115261095", var_392_22)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_115261", "115261095", "story_v_out_115261.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_115261", "115261095", "story_v_out_115261.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_23 = math.max(var_392_16, arg_389_1.talkMaxDuration)

			if var_392_15 <= arg_389_1.time_ and arg_389_1.time_ < var_392_15 + var_392_23 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_15) / var_392_23

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_15 + var_392_23 and arg_389_1.time_ < var_392_15 + var_392_23 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play115261096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 115261096
		arg_393_1.duration_ = 13.07

		local var_393_0 = {
			ja = 10.8,
			ko = 9.9,
			zh = 10.5,
			en = 13.066
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play115261097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["10030"]) and arg_393_1.var_.actorSpriteComps10030 == nil then
				arg_393_1.var_.actorSpriteComps10030 = arg_393_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_0 = 0.2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["10030"]) then
				if arg_393_1.var_.actorSpriteComps10030 then
					for iter_396_0, iter_396_1 in pairs(arg_393_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_396_1 then
							if arg_393_1.isInRecall_ then
								iter_396_1.color = Color.New(Mathf.Lerp(iter_396_1.color.r, arg_393_1.hightColor2.r, (arg_393_1.time_ - 0) / var_396_0), Mathf.Lerp(iter_396_1.color.g, arg_393_1.hightColor2.g, (arg_393_1.time_ - 0) / var_396_0), (Mathf.Lerp(iter_396_1.color.b, arg_393_1.hightColor2.b, (arg_393_1.time_ - 0) / var_396_0)))
							else
								local var_396_1 = Mathf.Lerp(iter_396_1.color.r, 0.5, (arg_393_1.time_ - 0) / var_396_0)

								iter_396_1.color = Color.New(var_396_1, var_396_1, var_396_1)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["10030"]) and arg_393_1.var_.actorSpriteComps10030 then
				for iter_396_2, iter_396_3 in pairs(arg_393_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_396_3 then
						iter_396_3.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_393_1.var_.actorSpriteComps10030 = nil
			end

			local var_396_2 = arg_393_1.actors_["10029"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_2) then
				local var_396_3 = var_396_2:GetComponent("Image")

				if var_396_3 then
					arg_393_1.var_.highlightMatValue10029 = var_396_3
				end
			end

			local var_396_4 = 0.2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_4 and not isNil(var_396_2) then
				if arg_393_1.var_.highlightMatValue10029 then
					local var_396_5 = Mathf.Lerp(0.5, 1, (arg_393_1.time_ - 0) / var_396_4)

					arg_393_1.var_.highlightMatValue10029.color.r = var_396_5
					arg_393_1.var_.highlightMatValue10029.color.g = var_396_5
					arg_393_1.var_.highlightMatValue10029.color.b = var_396_5
					arg_393_1.var_.highlightMatValue10029.color = arg_393_1.var_.highlightMatValue10029.color
				end
			end

			if arg_393_1.time_ >= 0 + var_396_4 and arg_393_1.time_ < 0 + var_396_4 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.highlightMatValue10029 then
				var_396_2.transform:SetSiblingIndex(1)

				arg_393_1.var_.highlightMatValue10029.color.r = 1
				arg_393_1.var_.highlightMatValue10029.color.g = 1
				arg_393_1.var_.highlightMatValue10029.color.b = 1
				arg_393_1.var_.highlightMatValue10029.color = arg_393_1.var_.highlightMatValue10029.color
			end

			local var_396_6 = 0
			local var_396_7 = 0.9

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_8 = arg_393_1:GetWordFromCfg(115261096)
				local var_396_9 = arg_393_1:FormatText(var_396_8.content)

				arg_393_1.text_.text = var_396_9

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_11 = 36 <= 0 and var_396_7 or var_396_7 * (utf8.len(var_396_9) / 36)

				if (36 <= 0 and var_396_7 or var_396_7 * (utf8.len(var_396_9) / 36)) > 0 and var_396_7 < var_396_11 then
					arg_393_1.talkMaxDuration = var_396_11

					if var_396_11 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_11 + var_396_6
					end
				end

				arg_393_1.text_.text = var_396_9
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261096", "story_v_out_115261.awb") ~= 0 then
					local var_396_12 = manager.audio:GetVoiceLength("story_v_out_115261", "115261096", "story_v_out_115261.awb") / 1000

					if var_396_12 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_12 + var_396_6
					end

					if var_396_8.prefab_name ~= "" and arg_393_1.actors_[var_396_8.prefab_name] ~= nil then
						local var_396_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_8.prefab_name].transform, "story_v_out_115261", "115261096", "story_v_out_115261.awb")

						arg_393_1:RecordAudio("115261096", var_396_13)
						arg_393_1:RecordAudio("115261096", var_396_13)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_115261", "115261096", "story_v_out_115261.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_115261", "115261096", "story_v_out_115261.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_14 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_14 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_14

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_14 and arg_393_1.time_ < var_396_6 + var_396_14 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play115261097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 115261097
		arg_397_1.duration_ = 18.03

		local var_397_0 = {
			ja = 8.666,
			ko = 14.9,
			zh = 11.933,
			en = 18.033
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play115261098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 1.25

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_1 = arg_397_1:GetWordFromCfg(115261097)
				local var_400_2 = arg_397_1:FormatText(var_400_1.content)

				arg_397_1.text_.text = var_400_2

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 50 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 50)

				if (50 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 50)) > 0 and var_400_0 < var_400_4 then
					arg_397_1.talkMaxDuration = var_400_4

					if var_400_4 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_4 + 0
					end
				end

				arg_397_1.text_.text = var_400_2
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261097", "story_v_out_115261.awb") ~= 0 then
					local var_400_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261097", "story_v_out_115261.awb") / 1000

					if var_400_5 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + 0
					end

					if var_400_1.prefab_name ~= "" and arg_397_1.actors_[var_400_1.prefab_name] ~= nil then
						local var_400_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_1.prefab_name].transform, "story_v_out_115261", "115261097", "story_v_out_115261.awb")

						arg_397_1:RecordAudio("115261097", var_400_6)
						arg_397_1:RecordAudio("115261097", var_400_6)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_115261", "115261097", "story_v_out_115261.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_115261", "115261097", "story_v_out_115261.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_7 and arg_397_1.time_ < 0 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play115261098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 115261098
		arg_401_1.duration_ = 1.63

		local var_401_0 = {
			ja = 1.066,
			ko = 1.366,
			zh = 1.633,
			en = 1.466
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play115261099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["10030"]) and arg_401_1.var_.actorSpriteComps10030 == nil then
				arg_401_1.var_.actorSpriteComps10030 = arg_401_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_0 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["10030"]) then
				if arg_401_1.var_.actorSpriteComps10030 then
					for iter_404_0, iter_404_1 in pairs(arg_401_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_404_1 then
							if arg_401_1.isInRecall_ then
								iter_404_1.color = Color.New(Mathf.Lerp(iter_404_1.color.r, arg_401_1.hightColor1.r, (arg_401_1.time_ - 0) / var_404_0), Mathf.Lerp(iter_404_1.color.g, arg_401_1.hightColor1.g, (arg_401_1.time_ - 0) / var_404_0), (Mathf.Lerp(iter_404_1.color.b, arg_401_1.hightColor1.b, (arg_401_1.time_ - 0) / var_404_0)))
							else
								local var_404_1 = Mathf.Lerp(iter_404_1.color.r, 1, (arg_401_1.time_ - 0) / var_404_0)

								iter_404_1.color = Color.New(var_404_1, var_404_1, var_404_1)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["10030"]) and arg_401_1.var_.actorSpriteComps10030 then
				for iter_404_2, iter_404_3 in pairs(arg_401_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_404_3 then
						iter_404_3.color = arg_401_1.isInRecall_ and (arg_401_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_401_1.var_.actorSpriteComps10030 = nil
			end

			local var_404_2 = arg_401_1.actors_["10029"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_2) then
				local var_404_3 = var_404_2:GetComponent("Image")

				if var_404_3 then
					arg_401_1.var_.highlightMatValue10029 = var_404_3
				end
			end

			local var_404_4 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_4 and not isNil(var_404_2) then
				if arg_401_1.var_.highlightMatValue10029 then
					local var_404_5 = Mathf.Lerp(1, 0.5, (arg_401_1.time_ - 0) / var_404_4)

					arg_401_1.var_.highlightMatValue10029.color.r = var_404_5
					arg_401_1.var_.highlightMatValue10029.color.g = var_404_5
					arg_401_1.var_.highlightMatValue10029.color.b = var_404_5
					arg_401_1.var_.highlightMatValue10029.color = arg_401_1.var_.highlightMatValue10029.color
				end
			end

			if arg_401_1.time_ >= 0 + var_404_4 and arg_401_1.time_ < 0 + var_404_4 + arg_404_0 and not isNil(var_404_2) and arg_401_1.var_.highlightMatValue10029 then
				arg_401_1.var_.highlightMatValue10029.color.r = 0.5
				arg_401_1.var_.highlightMatValue10029.color.g = 0.5
				arg_401_1.var_.highlightMatValue10029.color.b = 0.5
				arg_401_1.var_.highlightMatValue10029.color = arg_401_1.var_.highlightMatValue10029.color
			end

			local var_404_6 = 0
			local var_404_7 = 0.1

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_6 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_8 = arg_401_1:GetWordFromCfg(115261098)
				local var_404_9 = arg_401_1:FormatText(var_404_8.content)

				arg_401_1.text_.text = var_404_9

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_11 = 4 <= 0 and var_404_7 or var_404_7 * (utf8.len(var_404_9) / 4)

				if (4 <= 0 and var_404_7 or var_404_7 * (utf8.len(var_404_9) / 4)) > 0 and var_404_7 < var_404_11 then
					arg_401_1.talkMaxDuration = var_404_11

					if var_404_11 + var_404_6 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_11 + var_404_6
					end
				end

				arg_401_1.text_.text = var_404_9
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261098", "story_v_out_115261.awb") ~= 0 then
					local var_404_12 = manager.audio:GetVoiceLength("story_v_out_115261", "115261098", "story_v_out_115261.awb") / 1000

					if var_404_12 + var_404_6 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_12 + var_404_6
					end

					if var_404_8.prefab_name ~= "" and arg_401_1.actors_[var_404_8.prefab_name] ~= nil then
						local var_404_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_8.prefab_name].transform, "story_v_out_115261", "115261098", "story_v_out_115261.awb")

						arg_401_1:RecordAudio("115261098", var_404_13)
						arg_401_1:RecordAudio("115261098", var_404_13)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_115261", "115261098", "story_v_out_115261.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_115261", "115261098", "story_v_out_115261.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_14 = math.max(var_404_7, arg_401_1.talkMaxDuration)

			if var_404_6 <= arg_401_1.time_ and arg_401_1.time_ < var_404_6 + var_404_14 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_6) / var_404_14

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_6 + var_404_14 and arg_401_1.time_ < var_404_6 + var_404_14 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play115261099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 115261099
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play115261100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				local var_408_0 = arg_405_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_408_0 then
					arg_405_1.var_.alphaOldValue10030 = var_408_0.alpha
					arg_405_1.var_.characterEffect10030 = var_408_0
				end

				arg_405_1.var_.alphaOldValue10030 = 1
			end

			local var_408_1 = 0.333333333333333

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_1 then
				if arg_405_1.var_.characterEffect10030 then
					arg_405_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_405_1.var_.alphaOldValue10030, 0, (arg_405_1.time_ - 0) / var_408_1)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_1 and arg_405_1.time_ < 0 + var_408_1 + arg_408_0 and arg_405_1.var_.characterEffect10030 then
				arg_405_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				local var_408_2 = arg_405_1.actors_["10029"]:GetComponent("Image")

				if var_408_2 then
					arg_405_1.var_.alphaMatValue10029 = var_408_2
					arg_405_1.var_.alphaOldValue10029 = var_408_2.color.a
				end

				arg_405_1.var_.alphaOldValue10029 = 1
			end

			local var_408_3 = 0.333333333333333

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_3 then
				if arg_405_1.var_.alphaMatValue10029 then
					arg_405_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_405_1.var_.alphaOldValue10029, 0, (arg_405_1.time_ - 0) / var_408_3)
					arg_405_1.var_.alphaMatValue10029.color = arg_405_1.var_.alphaMatValue10029.color
				end
			end

			if arg_405_1.time_ >= 0 + var_408_3 and arg_405_1.time_ < 0 + var_408_3 + arg_408_0 and arg_405_1.var_.alphaMatValue10029 then
				arg_405_1.var_.alphaMatValue10029.color.a = 0
				arg_405_1.var_.alphaMatValue10029.color = arg_405_1.var_.alphaMatValue10029.color
			end

			local var_408_4 = 0
			local var_408_5 = 0.575

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_4 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_6 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(115261099).content)

				arg_405_1.text_.text = var_408_6

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_8 = 23 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_6) / 23)

				if (23 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_6) / 23)) > 0 and var_408_5 < var_408_8 then
					arg_405_1.talkMaxDuration = var_408_8

					if var_408_8 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_8 + var_408_4
					end
				end

				arg_405_1.text_.text = var_408_6
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_9 = math.max(var_408_5, arg_405_1.talkMaxDuration)

			if var_408_4 <= arg_405_1.time_ and arg_405_1.time_ < var_408_4 + var_408_9 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_4) / var_408_9

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_4 + var_408_9 and arg_405_1.time_ < var_408_4 + var_408_9 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play115261100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 115261100
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play115261101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0.75

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_1 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(115261100).content)

				arg_409_1.text_.text = var_412_1

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_3 = 30 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_1) / 30)

				if (30 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_1) / 30)) > 0 and var_412_0 < var_412_3 then
					arg_409_1.talkMaxDuration = var_412_3

					if var_412_3 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_3 + 0
					end
				end

				arg_409_1.text_.text = var_412_1
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_4 = math.max(var_412_0, arg_409_1.talkMaxDuration)

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_4 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - 0) / var_412_4

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= 0 + var_412_4 and arg_409_1.time_ < 0 + var_412_4 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play115261101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 115261101
		arg_413_1.duration_ = 3.97

		local var_413_0 = {
			ja = 2.666,
			ko = 3.433,
			zh = 3.966,
			en = 3.066
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
				arg_413_0:Play115261102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos10029 = arg_413_1.actors_["10029"].transform.localPosition
				arg_413_1.actors_["10029"].transform.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("10029", 3)
			end

			local var_416_0 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				arg_413_1.actors_["10029"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos10029, Vector3.New(0, -350, -180), (arg_413_1.time_ - 0) / var_416_0)
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				arg_413_1.actors_["10029"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_416_1 = arg_413_1.actors_["10029"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_1) then
				local var_416_2 = var_416_1:GetComponent("Image")

				if var_416_2 then
					arg_413_1.var_.highlightMatValue10029 = var_416_2
				end
			end

			local var_416_3 = 0.2

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_3 and not isNil(var_416_1) then
				if arg_413_1.var_.highlightMatValue10029 then
					local var_416_4 = Mathf.Lerp(0.5, 1, (arg_413_1.time_ - 0) / var_416_3)

					arg_413_1.var_.highlightMatValue10029.color.r = var_416_4
					arg_413_1.var_.highlightMatValue10029.color.g = var_416_4
					arg_413_1.var_.highlightMatValue10029.color.b = var_416_4
					arg_413_1.var_.highlightMatValue10029.color = arg_413_1.var_.highlightMatValue10029.color
				end
			end

			if arg_413_1.time_ >= 0 + var_416_3 and arg_413_1.time_ < 0 + var_416_3 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.highlightMatValue10029 then
				var_416_1.transform:SetSiblingIndex(1)

				arg_413_1.var_.highlightMatValue10029.color.r = 1
				arg_413_1.var_.highlightMatValue10029.color.g = 1
				arg_413_1.var_.highlightMatValue10029.color.b = 1
				arg_413_1.var_.highlightMatValue10029.color = arg_413_1.var_.highlightMatValue10029.color
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				local var_416_5 = arg_413_1.actors_["10029"]:GetComponent("Image")

				if var_416_5 then
					arg_413_1.var_.alphaMatValue10029 = var_416_5
					arg_413_1.var_.alphaOldValue10029 = var_416_5.color.a
				end

				arg_413_1.var_.alphaOldValue10029 = 0
			end

			local var_416_6 = 0.333333333333333

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_6 then
				if arg_413_1.var_.alphaMatValue10029 then
					arg_413_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_413_1.var_.alphaOldValue10029, 1, (arg_413_1.time_ - 0) / var_416_6)
					arg_413_1.var_.alphaMatValue10029.color = arg_413_1.var_.alphaMatValue10029.color
				end
			end

			if arg_413_1.time_ >= 0 + var_416_6 and arg_413_1.time_ < 0 + var_416_6 + arg_416_0 and arg_413_1.var_.alphaMatValue10029 then
				arg_413_1.var_.alphaMatValue10029.color.a = 1
				arg_413_1.var_.alphaMatValue10029.color = arg_413_1.var_.alphaMatValue10029.color
			end

			local var_416_7 = 0
			local var_416_8 = 0.175

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_7 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_9 = arg_413_1:GetWordFromCfg(115261101)
				local var_416_10 = arg_413_1:FormatText(var_416_9.content)

				arg_413_1.text_.text = var_416_10

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_12 = 7 <= 0 and var_416_8 or var_416_8 * (utf8.len(var_416_10) / 7)

				if (7 <= 0 and var_416_8 or var_416_8 * (utf8.len(var_416_10) / 7)) > 0 and var_416_8 < var_416_12 then
					arg_413_1.talkMaxDuration = var_416_12

					if var_416_12 + var_416_7 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_12 + var_416_7
					end
				end

				arg_413_1.text_.text = var_416_10
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261101", "story_v_out_115261.awb") ~= 0 then
					local var_416_13 = manager.audio:GetVoiceLength("story_v_out_115261", "115261101", "story_v_out_115261.awb") / 1000

					if var_416_13 + var_416_7 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_13 + var_416_7
					end

					if var_416_9.prefab_name ~= "" and arg_413_1.actors_[var_416_9.prefab_name] ~= nil then
						local var_416_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_9.prefab_name].transform, "story_v_out_115261", "115261101", "story_v_out_115261.awb")

						arg_413_1:RecordAudio("115261101", var_416_14)
						arg_413_1:RecordAudio("115261101", var_416_14)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_115261", "115261101", "story_v_out_115261.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_115261", "115261101", "story_v_out_115261.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_15 = math.max(var_416_8, arg_413_1.talkMaxDuration)

			if var_416_7 <= arg_413_1.time_ and arg_413_1.time_ < var_416_7 + var_416_15 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_7) / var_416_15

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_7 + var_416_15 and arg_413_1.time_ < var_416_7 + var_416_15 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play115261102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 115261102
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play115261103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["10029"]) then
				local var_420_0 = arg_417_1.actors_["10029"]:GetComponent("Image")

				if var_420_0 then
					arg_417_1.var_.highlightMatValue10029 = var_420_0
				end
			end

			local var_420_1 = 0.2

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_1 and not isNil(arg_417_1.actors_["10029"]) then
				if arg_417_1.var_.highlightMatValue10029 then
					local var_420_2 = Mathf.Lerp(1, 0.5, (arg_417_1.time_ - 0) / var_420_1)

					arg_417_1.var_.highlightMatValue10029.color.r = var_420_2
					arg_417_1.var_.highlightMatValue10029.color.g = var_420_2
					arg_417_1.var_.highlightMatValue10029.color.b = var_420_2
					arg_417_1.var_.highlightMatValue10029.color = arg_417_1.var_.highlightMatValue10029.color
				end
			end

			if arg_417_1.time_ >= 0 + var_420_1 and arg_417_1.time_ < 0 + var_420_1 + arg_420_0 and not isNil(arg_417_1.actors_["10029"]) and arg_417_1.var_.highlightMatValue10029 then
				arg_417_1.var_.highlightMatValue10029.color.r = 0.5
				arg_417_1.var_.highlightMatValue10029.color.g = 0.5
				arg_417_1.var_.highlightMatValue10029.color.b = 0.5
				arg_417_1.var_.highlightMatValue10029.color = arg_417_1.var_.highlightMatValue10029.color
			end

			local var_420_3 = 0
			local var_420_4 = 0.95

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_3 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, false)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_5 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(115261102).content)

				arg_417_1.text_.text = var_420_5

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_7 = 38 <= 0 and var_420_4 or var_420_4 * (utf8.len(var_420_5) / 38)

				if (38 <= 0 and var_420_4 or var_420_4 * (utf8.len(var_420_5) / 38)) > 0 and var_420_4 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_3 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_3
					end
				end

				arg_417_1.text_.text = var_420_5
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_8 = math.max(var_420_4, arg_417_1.talkMaxDuration)

			if var_420_3 <= arg_417_1.time_ and arg_417_1.time_ < var_420_3 + var_420_8 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_3) / var_420_8

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_3 + var_420_8 and arg_417_1.time_ < var_420_3 + var_420_8 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play115261103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 115261103
		arg_421_1.duration_ = 9.07

		local var_421_0 = {
			ja = 9.066,
			ko = 5.866,
			zh = 8.133,
			en = 6.5
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play115261104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0.575

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[310].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_1 = arg_421_1:GetWordFromCfg(115261103)
				local var_424_2 = arg_421_1:FormatText(var_424_1.content)

				arg_421_1.text_.text = var_424_2

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_4 = 23 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 23)

				if (23 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 23)) > 0 and var_424_0 < var_424_4 then
					arg_421_1.talkMaxDuration = var_424_4

					if var_424_4 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_4 + 0
					end
				end

				arg_421_1.text_.text = var_424_2
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261103", "story_v_out_115261.awb") ~= 0 then
					local var_424_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261103", "story_v_out_115261.awb") / 1000

					if var_424_5 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + 0
					end

					if var_424_1.prefab_name ~= "" and arg_421_1.actors_[var_424_1.prefab_name] ~= nil then
						local var_424_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_1.prefab_name].transform, "story_v_out_115261", "115261103", "story_v_out_115261.awb")

						arg_421_1:RecordAudio("115261103", var_424_6)
						arg_421_1:RecordAudio("115261103", var_424_6)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_115261", "115261103", "story_v_out_115261.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_115261", "115261103", "story_v_out_115261.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_7 and arg_421_1.time_ < 0 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play115261104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 115261104
		arg_425_1.duration_ = 6.87

		local var_425_0 = {
			ja = 6.833,
			ko = 6.866,
			zh = 6.166,
			en = 6.133
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
				arg_425_0:Play115261105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["10029"]) then
				local var_428_0 = arg_425_1.actors_["10029"]:GetComponent("Image")

				if var_428_0 then
					arg_425_1.var_.highlightMatValue10029 = var_428_0
				end
			end

			local var_428_1 = 0.2

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_1 and not isNil(arg_425_1.actors_["10029"]) then
				if arg_425_1.var_.highlightMatValue10029 then
					local var_428_2 = Mathf.Lerp(0.5, 1, (arg_425_1.time_ - 0) / var_428_1)

					arg_425_1.var_.highlightMatValue10029.color.r = var_428_2
					arg_425_1.var_.highlightMatValue10029.color.g = var_428_2
					arg_425_1.var_.highlightMatValue10029.color.b = var_428_2
					arg_425_1.var_.highlightMatValue10029.color = arg_425_1.var_.highlightMatValue10029.color
				end
			end

			if arg_425_1.time_ >= 0 + var_428_1 and arg_425_1.time_ < 0 + var_428_1 + arg_428_0 and not isNil(arg_425_1.actors_["10029"]) and arg_425_1.var_.highlightMatValue10029 then
				arg_425_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_425_1.var_.highlightMatValue10029.color.r = 1
				arg_425_1.var_.highlightMatValue10029.color.g = 1
				arg_425_1.var_.highlightMatValue10029.color.b = 1
				arg_425_1.var_.highlightMatValue10029.color = arg_425_1.var_.highlightMatValue10029.color
			end

			local var_428_3 = 0
			local var_428_4 = 0.625

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_3 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_5 = arg_425_1:GetWordFromCfg(115261104)
				local var_428_6 = arg_425_1:FormatText(var_428_5.content)

				arg_425_1.text_.text = var_428_6

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_8 = 24 <= 0 and var_428_4 or var_428_4 * (utf8.len(var_428_6) / 24)

				if (24 <= 0 and var_428_4 or var_428_4 * (utf8.len(var_428_6) / 24)) > 0 and var_428_4 < var_428_8 then
					arg_425_1.talkMaxDuration = var_428_8

					if var_428_8 + var_428_3 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_8 + var_428_3
					end
				end

				arg_425_1.text_.text = var_428_6
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261104", "story_v_out_115261.awb") ~= 0 then
					local var_428_9 = manager.audio:GetVoiceLength("story_v_out_115261", "115261104", "story_v_out_115261.awb") / 1000

					if var_428_9 + var_428_3 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_9 + var_428_3
					end

					if var_428_5.prefab_name ~= "" and arg_425_1.actors_[var_428_5.prefab_name] ~= nil then
						local var_428_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_5.prefab_name].transform, "story_v_out_115261", "115261104", "story_v_out_115261.awb")

						arg_425_1:RecordAudio("115261104", var_428_10)
						arg_425_1:RecordAudio("115261104", var_428_10)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_115261", "115261104", "story_v_out_115261.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_115261", "115261104", "story_v_out_115261.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_11 = math.max(var_428_4, arg_425_1.talkMaxDuration)

			if var_428_3 <= arg_425_1.time_ and arg_425_1.time_ < var_428_3 + var_428_11 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_3) / var_428_11

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_3 + var_428_11 and arg_425_1.time_ < var_428_3 + var_428_11 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play115261105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 115261105
		arg_429_1.duration_ = 8.7

		local var_429_0 = {
			ja = 8,
			ko = 8.7,
			zh = 7.8,
			en = 8.066
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play115261106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["10029"]) then
				local var_432_0 = arg_429_1.actors_["10029"]:GetComponent("Image")

				if var_432_0 then
					arg_429_1.var_.highlightMatValue10029 = var_432_0
				end
			end

			local var_432_1 = 0.2

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_1 and not isNil(arg_429_1.actors_["10029"]) then
				if arg_429_1.var_.highlightMatValue10029 then
					local var_432_2 = Mathf.Lerp(1, 0.5, (arg_429_1.time_ - 0) / var_432_1)

					arg_429_1.var_.highlightMatValue10029.color.r = var_432_2
					arg_429_1.var_.highlightMatValue10029.color.g = var_432_2
					arg_429_1.var_.highlightMatValue10029.color.b = var_432_2
					arg_429_1.var_.highlightMatValue10029.color = arg_429_1.var_.highlightMatValue10029.color
				end
			end

			if arg_429_1.time_ >= 0 + var_432_1 and arg_429_1.time_ < 0 + var_432_1 + arg_432_0 and not isNil(arg_429_1.actors_["10029"]) and arg_429_1.var_.highlightMatValue10029 then
				arg_429_1.var_.highlightMatValue10029.color.r = 0.5
				arg_429_1.var_.highlightMatValue10029.color.g = 0.5
				arg_429_1.var_.highlightMatValue10029.color.b = 0.5
				arg_429_1.var_.highlightMatValue10029.color = arg_429_1.var_.highlightMatValue10029.color
			end

			local var_432_3 = 0
			local var_432_4 = 0.7

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_3 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[310].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_5 = arg_429_1:GetWordFromCfg(115261105)
				local var_432_6 = arg_429_1:FormatText(var_432_5.content)

				arg_429_1.text_.text = var_432_6

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_8 = 28 <= 0 and var_432_4 or var_432_4 * (utf8.len(var_432_6) / 28)

				if (28 <= 0 and var_432_4 or var_432_4 * (utf8.len(var_432_6) / 28)) > 0 and var_432_4 < var_432_8 then
					arg_429_1.talkMaxDuration = var_432_8

					if var_432_8 + var_432_3 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_8 + var_432_3
					end
				end

				arg_429_1.text_.text = var_432_6
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261105", "story_v_out_115261.awb") ~= 0 then
					local var_432_9 = manager.audio:GetVoiceLength("story_v_out_115261", "115261105", "story_v_out_115261.awb") / 1000

					if var_432_9 + var_432_3 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_9 + var_432_3
					end

					if var_432_5.prefab_name ~= "" and arg_429_1.actors_[var_432_5.prefab_name] ~= nil then
						local var_432_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_5.prefab_name].transform, "story_v_out_115261", "115261105", "story_v_out_115261.awb")

						arg_429_1:RecordAudio("115261105", var_432_10)
						arg_429_1:RecordAudio("115261105", var_432_10)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_115261", "115261105", "story_v_out_115261.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_115261", "115261105", "story_v_out_115261.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_11 = math.max(var_432_4, arg_429_1.talkMaxDuration)

			if var_432_3 <= arg_429_1.time_ and arg_429_1.time_ < var_432_3 + var_432_11 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_3) / var_432_11

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_3 + var_432_11 and arg_429_1.time_ < var_432_3 + var_432_11 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play115261106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 115261106
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play115261107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0.6

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_1 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(115261106).content)

				arg_433_1.text_.text = var_436_1

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_3 = 24 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 24)

				if (24 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 24)) > 0 and var_436_0 < var_436_3 then
					arg_433_1.talkMaxDuration = var_436_3

					if var_436_3 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_3 + 0
					end
				end

				arg_433_1.text_.text = var_436_1
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_4 = math.max(var_436_0, arg_433_1.talkMaxDuration)

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - 0) / var_436_4

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play115261107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 115261107
		arg_437_1.duration_ = 17.57

		local var_437_0 = {
			ja = 11.533,
			ko = 17.566,
			zh = 17.333,
			en = 13.633
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play115261108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 1.15

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[310].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_1 = arg_437_1:GetWordFromCfg(115261107)
				local var_440_2 = arg_437_1:FormatText(var_440_1.content)

				arg_437_1.text_.text = var_440_2

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_4 = 45 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_2) / 45)

				if (45 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_2) / 45)) > 0 and var_440_0 < var_440_4 then
					arg_437_1.talkMaxDuration = var_440_4

					if var_440_4 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_4 + 0
					end
				end

				arg_437_1.text_.text = var_440_2
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261107", "story_v_out_115261.awb") ~= 0 then
					local var_440_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261107", "story_v_out_115261.awb") / 1000

					if var_440_5 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + 0
					end

					if var_440_1.prefab_name ~= "" and arg_437_1.actors_[var_440_1.prefab_name] ~= nil then
						local var_440_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_1.prefab_name].transform, "story_v_out_115261", "115261107", "story_v_out_115261.awb")

						arg_437_1:RecordAudio("115261107", var_440_6)
						arg_437_1:RecordAudio("115261107", var_440_6)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_115261", "115261107", "story_v_out_115261.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_115261", "115261107", "story_v_out_115261.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_7 = math.max(var_440_0, arg_437_1.talkMaxDuration)

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_7 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - 0) / var_440_7

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= 0 + var_440_7 and arg_437_1.time_ < 0 + var_440_7 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play115261108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 115261108
		arg_441_1.duration_ = 9

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play115261109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if arg_441_1.bgs_.ST22a == nil then
				local var_444_0 = Object.Instantiate(arg_441_1.paintGo_)

				var_444_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22a")
				var_444_0.name = "ST22a"
				var_444_0.transform.parent = arg_441_1.stage_.transform
				var_444_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_441_1.bgs_.ST22a = var_444_0
			end

			if 2 < arg_441_1.time_ and arg_441_1.time_ <= 2 + arg_444_0 then
				local var_444_1 = arg_441_1.bgs_.ST22a

				arg_441_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_444_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_444_2 = var_444_1:GetComponent("SpriteRenderer")

				if var_444_2 and var_444_2.sprite then
					local var_444_3 = 2 * (var_444_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_444_1.transform.localScale = Vector3.New(var_444_3 / var_444_2.sprite.bounds.size.y < var_444_3 * manager.ui.mainCameraCom_.aspect / var_444_2.sprite.bounds.size.x and var_444_3 * manager.ui.mainCameraCom_.aspect / var_444_2.sprite.bounds.size.x or var_444_3 / var_444_2.sprite.bounds.size.y, var_444_3 / var_444_2.sprite.bounds.size.y < var_444_3 * manager.ui.mainCameraCom_.aspect / var_444_2.sprite.bounds.size.x and var_444_3 * manager.ui.mainCameraCom_.aspect / var_444_2.sprite.bounds.size.x or var_444_3 / var_444_2.sprite.bounds.size.y, 0)
				end

				for iter_444_0, iter_444_1 in pairs(arg_441_1.bgs_) do
					if iter_444_0 ~= "ST22a" then
						iter_444_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_444_4 = 0

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_4 + arg_444_0 then
				arg_441_1.mask_.enabled = true
				arg_441_1.mask_.raycastTarget = false

				arg_441_1:SetGaussion(false)
			end

			local var_444_5 = 2

			if var_444_4 <= arg_441_1.time_ and arg_441_1.time_ < var_444_4 + var_444_5 then
				local var_444_6 = Color.New(0, 0, 0)

				var_444_6.a = Mathf.Lerp(0, 1, (arg_441_1.time_ - var_444_4) / var_444_5)
				arg_441_1.mask_.color = var_444_6
			end

			if arg_441_1.time_ >= var_444_4 + var_444_5 and arg_441_1.time_ < var_444_4 + var_444_5 + arg_444_0 then
				local var_444_7 = Color.New(0, 0, 0)

				var_444_7.a = 1
				arg_441_1.mask_.color = var_444_7
			end

			local var_444_8 = 2

			if 2 < arg_441_1.time_ and arg_441_1.time_ <= var_444_8 + arg_444_0 then
				arg_441_1.mask_.enabled = true
				arg_441_1.mask_.raycastTarget = false

				arg_441_1:SetGaussion(false)
			end

			local var_444_9 = 2

			if var_444_8 <= arg_441_1.time_ and arg_441_1.time_ < var_444_8 + var_444_9 then
				local var_444_10 = Color.New(0, 0, 0)

				var_444_10.a = Mathf.Lerp(1, 0, (arg_441_1.time_ - var_444_8) / var_444_9)
				arg_441_1.mask_.color = var_444_10
			end

			if arg_441_1.time_ >= var_444_8 + var_444_9 and arg_441_1.time_ < var_444_8 + var_444_9 + arg_444_0 then
				local var_444_11 = Color.New(0, 0, 0)

				arg_441_1.mask_.enabled = false
				var_444_11.a = 0
				arg_441_1.mask_.color = var_444_11
			end

			local var_444_12 = arg_441_1.actors_["10029"].transform

			if 2 < arg_441_1.time_ and arg_441_1.time_ <= 2 + arg_444_0 then
				arg_441_1.var_.moveOldPos10029 = var_444_12.localPosition
				var_444_12.localScale = Vector3.New(1, 1, 1)

				arg_441_1:CheckSpriteTmpPos("10029", 0)
			end

			local var_444_13 = 0.001

			if 2 <= arg_441_1.time_ and arg_441_1.time_ < 2 + var_444_13 then
				var_444_12.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos10029, Vector3.New(-1500, -350, -180), (arg_441_1.time_ - 2) / var_444_13)
			end

			if arg_441_1.time_ >= 2 + var_444_13 and arg_441_1.time_ < 2 + var_444_13 + arg_444_0 then
				var_444_12.localPosition = Vector3.New(-1500, -350, -180)
			end

			if arg_441_1.frameCnt_ <= 1 then
				arg_441_1.dialog_:SetActive(false)
			end

			local var_444_14 = 4
			local var_444_15 = 1.45

			if 4 < arg_441_1.time_ and arg_441_1.time_ <= var_444_14 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0

				arg_441_1.dialog_:SetActive(true)

				arg_441_1.dialogCg_.alpha = 0

				local var_444_16 = LeanTween.value(arg_441_1.dialog_, 0, 1, 0.3)

				var_444_16:setOnUpdate(LuaHelper.FloatAction(function(arg_445_0)
					arg_441_1.dialogCg_.alpha = arg_445_0
				end))
				var_444_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_441_1.dialog_)
					var_444_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_441_1.duration_ = arg_441_1.duration_ + 0.3

				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_17 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(115261108).content)

				arg_441_1.text_.text = var_444_17

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_19 = 58 <= 0 and var_444_15 or var_444_15 * (utf8.len(var_444_17) / 58)

				if (58 <= 0 and var_444_15 or var_444_15 * (utf8.len(var_444_17) / 58)) > 0 and var_444_15 < var_444_19 then
					arg_441_1.talkMaxDuration = var_444_19
					var_444_14 = var_444_14 + 0.3

					if var_444_19 + var_444_14 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_19 + var_444_14
					end
				end

				arg_441_1.text_.text = var_444_17
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_20 = var_444_14 + 0.3
			local var_444_21 = math.max(var_444_15, arg_441_1.talkMaxDuration)

			if var_444_14 + 0.3 <= arg_441_1.time_ and arg_441_1.time_ < var_444_20 + var_444_21 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_20) / var_444_21

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_20 + var_444_21 and arg_441_1.time_ < var_444_20 + var_444_21 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play115261109 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 115261109
		arg_447_1.duration_ = 5.7

		local var_447_0 = {
			ja = 5.7,
			ko = 3.366,
			zh = 3.766,
			en = 4.233
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play115261110(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos10030 = arg_447_1.actors_["10030"].transform.localPosition
				arg_447_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_447_1:CheckSpriteTmpPos("10030", 3)

				for iter_450_0 = 0, arg_447_1.actors_["10030"].transform.childCount - 1 do
					local var_450_0 = arg_447_1.actors_["10030"].transform:GetChild(iter_450_0)

					if var_450_0.name == "split_3" or not string.find(var_450_0.name, "split") then
						var_450_0.gameObject:SetActive(true)
					else
						var_450_0.gameObject:SetActive(false)
					end
				end
			end

			local var_450_1 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_1 then
				arg_447_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_447_1.time_ - 0) / var_450_1)
			end

			if arg_447_1.time_ >= 0 + var_450_1 and arg_447_1.time_ < 0 + var_450_1 + arg_450_0 then
				arg_447_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				local var_450_2 = arg_447_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_450_2 then
					arg_447_1.var_.alphaOldValue10030 = var_450_2.alpha
					arg_447_1.var_.characterEffect10030 = var_450_2
				end

				arg_447_1.var_.alphaOldValue10030 = 0
			end

			local var_450_3 = 0.325

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_3 then
				if arg_447_1.var_.characterEffect10030 then
					arg_447_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_447_1.var_.alphaOldValue10030, 1, (arg_447_1.time_ - 0) / var_450_3)
				end
			end

			if arg_447_1.time_ >= 0 + var_450_3 and arg_447_1.time_ < 0 + var_450_3 + arg_450_0 and arg_447_1.var_.characterEffect10030 then
				arg_447_1.var_.characterEffect10030.alpha = 1
			end

			local var_450_4 = 0
			local var_450_5 = 0.325

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_4 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_6 = arg_447_1:GetWordFromCfg(115261109)
				local var_450_7 = arg_447_1:FormatText(var_450_6.content)

				arg_447_1.text_.text = var_450_7

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_9 = 13 <= 0 and var_450_5 or var_450_5 * (utf8.len(var_450_7) / 13)

				if (13 <= 0 and var_450_5 or var_450_5 * (utf8.len(var_450_7) / 13)) > 0 and var_450_5 < var_450_9 then
					arg_447_1.talkMaxDuration = var_450_9

					if var_450_9 + var_450_4 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_9 + var_450_4
					end
				end

				arg_447_1.text_.text = var_450_7
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261109", "story_v_out_115261.awb") ~= 0 then
					local var_450_10 = manager.audio:GetVoiceLength("story_v_out_115261", "115261109", "story_v_out_115261.awb") / 1000

					if var_450_10 + var_450_4 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_10 + var_450_4
					end

					if var_450_6.prefab_name ~= "" and arg_447_1.actors_[var_450_6.prefab_name] ~= nil then
						local var_450_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_6.prefab_name].transform, "story_v_out_115261", "115261109", "story_v_out_115261.awb")

						arg_447_1:RecordAudio("115261109", var_450_11)
						arg_447_1:RecordAudio("115261109", var_450_11)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_115261", "115261109", "story_v_out_115261.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_115261", "115261109", "story_v_out_115261.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_12 = math.max(var_450_5, arg_447_1.talkMaxDuration)

			if var_450_4 <= arg_447_1.time_ and arg_447_1.time_ < var_450_4 + var_450_12 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_4) / var_450_12

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_4 + var_450_12 and arg_447_1.time_ < var_450_4 + var_450_12 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play115261110 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 115261110
		arg_451_1.duration_ = 12.6

		local var_451_0 = {
			ja = 12.6,
			ko = 7.566,
			zh = 9.7,
			en = 9.966
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play115261111(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos10030 = arg_451_1.actors_["10030"].transform.localPosition
				arg_451_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_451_1:CheckSpriteTmpPos("10030", 3)

				for iter_454_0 = 0, arg_451_1.actors_["10030"].transform.childCount - 1 do
					local var_454_0 = arg_451_1.actors_["10030"].transform:GetChild(iter_454_0)

					if var_454_0.name == "split_5" or not string.find(var_454_0.name, "split") then
						var_454_0.gameObject:SetActive(true)
					else
						var_454_0.gameObject:SetActive(false)
					end
				end
			end

			local var_454_1 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_1 then
				arg_451_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_451_1.time_ - 0) / var_454_1)
			end

			if arg_451_1.time_ >= 0 + var_454_1 and arg_451_1.time_ < 0 + var_454_1 + arg_454_0 then
				arg_451_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_454_2 = 0
			local var_454_3 = 0.7

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_2 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_4 = arg_451_1:GetWordFromCfg(115261110)
				local var_454_5 = arg_451_1:FormatText(var_454_4.content)

				arg_451_1.text_.text = var_454_5

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_7 = 28 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_5) / 28)

				if (28 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_5) / 28)) > 0 and var_454_3 < var_454_7 then
					arg_451_1.talkMaxDuration = var_454_7

					if var_454_7 + var_454_2 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_7 + var_454_2
					end
				end

				arg_451_1.text_.text = var_454_5
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261110", "story_v_out_115261.awb") ~= 0 then
					local var_454_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261110", "story_v_out_115261.awb") / 1000

					if var_454_8 + var_454_2 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_8 + var_454_2
					end

					if var_454_4.prefab_name ~= "" and arg_451_1.actors_[var_454_4.prefab_name] ~= nil then
						local var_454_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_4.prefab_name].transform, "story_v_out_115261", "115261110", "story_v_out_115261.awb")

						arg_451_1:RecordAudio("115261110", var_454_9)
						arg_451_1:RecordAudio("115261110", var_454_9)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_115261", "115261110", "story_v_out_115261.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_115261", "115261110", "story_v_out_115261.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_10 = math.max(var_454_3, arg_451_1.talkMaxDuration)

			if var_454_2 <= arg_451_1.time_ and arg_451_1.time_ < var_454_2 + var_454_10 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_2) / var_454_10

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_2 + var_454_10 and arg_451_1.time_ < var_454_2 + var_454_10 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play115261111 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 115261111
		arg_455_1.duration_ = 4.9

		local var_455_0 = {
			ja = 4.9,
			ko = 2.7,
			zh = 4.066,
			en = 3.9
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play115261112(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPos10030 = arg_455_1.actors_["10030"].transform.localPosition
				arg_455_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_455_1:CheckSpriteTmpPos("10030", 3)

				for iter_458_0 = 0, arg_455_1.actors_["10030"].transform.childCount - 1 do
					local var_458_0 = arg_455_1.actors_["10030"].transform:GetChild(iter_458_0)

					if var_458_0.name == "split_3" or not string.find(var_458_0.name, "split") then
						var_458_0.gameObject:SetActive(true)
					else
						var_458_0.gameObject:SetActive(false)
					end
				end
			end

			local var_458_1 = 0.001

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_1 then
				arg_455_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_455_1.time_ - 0) / var_458_1)
			end

			if arg_455_1.time_ >= 0 + var_458_1 and arg_455_1.time_ < 0 + var_458_1 + arg_458_0 then
				arg_455_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_458_2 = 0
			local var_458_3 = 0.175

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_2 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_4 = arg_455_1:GetWordFromCfg(115261111)
				local var_458_5 = arg_455_1:FormatText(var_458_4.content)

				arg_455_1.text_.text = var_458_5

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_7 = 7 <= 0 and var_458_3 or var_458_3 * (utf8.len(var_458_5) / 7)

				if (7 <= 0 and var_458_3 or var_458_3 * (utf8.len(var_458_5) / 7)) > 0 and var_458_3 < var_458_7 then
					arg_455_1.talkMaxDuration = var_458_7

					if var_458_7 + var_458_2 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_7 + var_458_2
					end
				end

				arg_455_1.text_.text = var_458_5
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261111", "story_v_out_115261.awb") ~= 0 then
					local var_458_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261111", "story_v_out_115261.awb") / 1000

					if var_458_8 + var_458_2 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_8 + var_458_2
					end

					if var_458_4.prefab_name ~= "" and arg_455_1.actors_[var_458_4.prefab_name] ~= nil then
						local var_458_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_4.prefab_name].transform, "story_v_out_115261", "115261111", "story_v_out_115261.awb")

						arg_455_1:RecordAudio("115261111", var_458_9)
						arg_455_1:RecordAudio("115261111", var_458_9)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_115261", "115261111", "story_v_out_115261.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_115261", "115261111", "story_v_out_115261.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_10 = math.max(var_458_3, arg_455_1.talkMaxDuration)

			if var_458_2 <= arg_455_1.time_ and arg_455_1.time_ < var_458_2 + var_458_10 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_2) / var_458_10

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_2 + var_458_10 and arg_455_1.time_ < var_458_2 + var_458_10 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play115261112 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 115261112
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play115261113(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				local var_462_0 = arg_459_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_462_0 then
					arg_459_1.var_.alphaOldValue10030 = var_462_0.alpha
					arg_459_1.var_.characterEffect10030 = var_462_0
				end

				arg_459_1.var_.alphaOldValue10030 = 1
			end

			local var_462_1 = 0.333333333333333

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_1 then
				if arg_459_1.var_.characterEffect10030 then
					arg_459_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_459_1.var_.alphaOldValue10030, 0, (arg_459_1.time_ - 0) / var_462_1)
				end
			end

			if arg_459_1.time_ >= 0 + var_462_1 and arg_459_1.time_ < 0 + var_462_1 + arg_462_0 and arg_459_1.var_.characterEffect10030 then
				arg_459_1.var_.characterEffect10030.alpha = 0
			end

			local var_462_2 = 0
			local var_462_3 = 0.975

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_2 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_4 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(115261112).content)

				arg_459_1.text_.text = var_462_4

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_6 = 39 <= 0 and var_462_3 or var_462_3 * (utf8.len(var_462_4) / 39)

				if (39 <= 0 and var_462_3 or var_462_3 * (utf8.len(var_462_4) / 39)) > 0 and var_462_3 < var_462_6 then
					arg_459_1.talkMaxDuration = var_462_6

					if var_462_6 + var_462_2 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_6 + var_462_2
					end
				end

				arg_459_1.text_.text = var_462_4
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_7 = math.max(var_462_3, arg_459_1.talkMaxDuration)

			if var_462_2 <= arg_459_1.time_ and arg_459_1.time_ < var_462_2 + var_462_7 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_2) / var_462_7

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_2 + var_462_7 and arg_459_1.time_ < var_462_2 + var_462_7 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play115261113 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 115261113
		arg_463_1.duration_ = 3.7

		local var_463_0 = {
			ja = 2.1,
			ko = 1.766,
			zh = 3.7,
			en = 1.1
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play115261114(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.var_.moveOldPos10030 = arg_463_1.actors_["10030"].transform.localPosition
				arg_463_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_463_1:CheckSpriteTmpPos("10030", 3)

				for iter_466_0 = 0, arg_463_1.actors_["10030"].transform.childCount - 1 do
					local var_466_0 = arg_463_1.actors_["10030"].transform:GetChild(iter_466_0)

					if var_466_0.name == "split_1" or not string.find(var_466_0.name, "split") then
						var_466_0.gameObject:SetActive(true)
					else
						var_466_0.gameObject:SetActive(false)
					end
				end
			end

			local var_466_1 = 0.001

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_1 then
				arg_463_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_463_1.time_ - 0) / var_466_1)
			end

			if arg_463_1.time_ >= 0 + var_466_1 and arg_463_1.time_ < 0 + var_466_1 + arg_466_0 then
				arg_463_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_466_2 = arg_463_1.actors_["10030"]

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(var_466_2) and arg_463_1.var_.actorSpriteComps10030 == nil then
				arg_463_1.var_.actorSpriteComps10030 = var_466_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_466_3 = 0.2

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_3 and not isNil(var_466_2) then
				if arg_463_1.var_.actorSpriteComps10030 then
					for iter_466_1, iter_466_2 in pairs(arg_463_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_466_2 then
							if arg_463_1.isInRecall_ then
								iter_466_2.color = Color.New(Mathf.Lerp(iter_466_2.color.r, arg_463_1.hightColor1.r, (arg_463_1.time_ - 0) / var_466_3), Mathf.Lerp(iter_466_2.color.g, arg_463_1.hightColor1.g, (arg_463_1.time_ - 0) / var_466_3), (Mathf.Lerp(iter_466_2.color.b, arg_463_1.hightColor1.b, (arg_463_1.time_ - 0) / var_466_3)))
							else
								local var_466_4 = Mathf.Lerp(iter_466_2.color.r, 1, (arg_463_1.time_ - 0) / var_466_3)

								iter_466_2.color = Color.New(var_466_4, var_466_4, var_466_4)
							end
						end
					end
				end
			end

			if arg_463_1.time_ >= 0 + var_466_3 and arg_463_1.time_ < 0 + var_466_3 + arg_466_0 and not isNil(var_466_2) and arg_463_1.var_.actorSpriteComps10030 then
				for iter_466_3, iter_466_4 in pairs(arg_463_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_466_4 then
						iter_466_4.color = arg_463_1.isInRecall_ and (arg_463_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_463_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				local var_466_5 = arg_463_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_466_5 then
					arg_463_1.var_.alphaOldValue10030 = var_466_5.alpha
					arg_463_1.var_.characterEffect10030 = var_466_5
				end

				arg_463_1.var_.alphaOldValue10030 = 0
			end

			local var_466_6 = 0.333333333333333

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_6 then
				if arg_463_1.var_.characterEffect10030 then
					arg_463_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_463_1.var_.alphaOldValue10030, 1, (arg_463_1.time_ - 0) / var_466_6)
				end
			end

			if arg_463_1.time_ >= 0 + var_466_6 and arg_463_1.time_ < 0 + var_466_6 + arg_466_0 and arg_463_1.var_.characterEffect10030 then
				arg_463_1.var_.characterEffect10030.alpha = 1
			end

			local var_466_7 = 0
			local var_466_8 = 0.125

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_7 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_9 = arg_463_1:GetWordFromCfg(115261113)
				local var_466_10 = arg_463_1:FormatText(var_466_9.content)

				arg_463_1.text_.text = var_466_10

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_12 = 5 <= 0 and var_466_8 or var_466_8 * (utf8.len(var_466_10) / 5)

				if (5 <= 0 and var_466_8 or var_466_8 * (utf8.len(var_466_10) / 5)) > 0 and var_466_8 < var_466_12 then
					arg_463_1.talkMaxDuration = var_466_12

					if var_466_12 + var_466_7 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_12 + var_466_7
					end
				end

				arg_463_1.text_.text = var_466_10
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261113", "story_v_out_115261.awb") ~= 0 then
					local var_466_13 = manager.audio:GetVoiceLength("story_v_out_115261", "115261113", "story_v_out_115261.awb") / 1000

					if var_466_13 + var_466_7 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_13 + var_466_7
					end

					if var_466_9.prefab_name ~= "" and arg_463_1.actors_[var_466_9.prefab_name] ~= nil then
						local var_466_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_9.prefab_name].transform, "story_v_out_115261", "115261113", "story_v_out_115261.awb")

						arg_463_1:RecordAudio("115261113", var_466_14)
						arg_463_1:RecordAudio("115261113", var_466_14)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_115261", "115261113", "story_v_out_115261.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_115261", "115261113", "story_v_out_115261.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_15 = math.max(var_466_8, arg_463_1.talkMaxDuration)

			if var_466_7 <= arg_463_1.time_ and arg_463_1.time_ < var_466_7 + var_466_15 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_7) / var_466_15

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_7 + var_466_15 and arg_463_1.time_ < var_466_7 + var_466_15 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_463_1:InitPlayNodeList()
	end,
	Play115261114 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 115261114
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play115261115(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				local var_470_0 = arg_467_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_470_0 then
					arg_467_1.var_.alphaOldValue10030 = var_470_0.alpha
					arg_467_1.var_.characterEffect10030 = var_470_0
				end

				arg_467_1.var_.alphaOldValue10030 = 1
			end

			local var_470_1 = 0.333333333333333

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_1 then
				if arg_467_1.var_.characterEffect10030 then
					arg_467_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_467_1.var_.alphaOldValue10030, 0, (arg_467_1.time_ - 0) / var_470_1)
				end
			end

			if arg_467_1.time_ >= 0 + var_470_1 and arg_467_1.time_ < 0 + var_470_1 + arg_470_0 and arg_467_1.var_.characterEffect10030 then
				arg_467_1.var_.characterEffect10030.alpha = 0
			end

			local var_470_2 = 0
			local var_470_3 = 0.6

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_2 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_4 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(115261114).content)

				arg_467_1.text_.text = var_470_4

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_6 = 24 <= 0 and var_470_3 or var_470_3 * (utf8.len(var_470_4) / 24)

				if (24 <= 0 and var_470_3 or var_470_3 * (utf8.len(var_470_4) / 24)) > 0 and var_470_3 < var_470_6 then
					arg_467_1.talkMaxDuration = var_470_6

					if var_470_6 + var_470_2 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_6 + var_470_2
					end
				end

				arg_467_1.text_.text = var_470_4
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_7 = math.max(var_470_3, arg_467_1.talkMaxDuration)

			if var_470_2 <= arg_467_1.time_ and arg_467_1.time_ < var_470_2 + var_470_7 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_2) / var_470_7

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_2 + var_470_7 and arg_467_1.time_ < var_470_2 + var_470_7 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play115261115 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 115261115
		arg_471_1.duration_ = 3.87

		local var_471_0 = {
			ja = 3.666,
			ko = 3.866,
			zh = 2.966,
			en = 3.366
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play115261116(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.var_.moveOldPos10029 = arg_471_1.actors_["10029"].transform.localPosition
				arg_471_1.actors_["10029"].transform.localScale = Vector3.New(1, 1, 1)

				arg_471_1:CheckSpriteTmpPos("10029", 3)
			end

			local var_474_0 = 0.001

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 then
				arg_471_1.actors_["10029"].transform.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos10029, Vector3.New(0, -350, -180), (arg_471_1.time_ - 0) / var_474_0)
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 then
				arg_471_1.actors_["10029"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_474_1 = arg_471_1.actors_["10029"]

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(var_474_1) then
				local var_474_2 = var_474_1:GetComponent("Image")

				if var_474_2 then
					arg_471_1.var_.highlightMatValue10029 = var_474_2
				end
			end

			local var_474_3 = 0.2

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_3 and not isNil(var_474_1) then
				if arg_471_1.var_.highlightMatValue10029 then
					local var_474_4 = Mathf.Lerp(0.5, 1, (arg_471_1.time_ - 0) / var_474_3)

					arg_471_1.var_.highlightMatValue10029.color.r = var_474_4
					arg_471_1.var_.highlightMatValue10029.color.g = var_474_4
					arg_471_1.var_.highlightMatValue10029.color.b = var_474_4
					arg_471_1.var_.highlightMatValue10029.color = arg_471_1.var_.highlightMatValue10029.color
				end
			end

			if arg_471_1.time_ >= 0 + var_474_3 and arg_471_1.time_ < 0 + var_474_3 + arg_474_0 and not isNil(var_474_1) and arg_471_1.var_.highlightMatValue10029 then
				var_474_1.transform:SetSiblingIndex(1)

				arg_471_1.var_.highlightMatValue10029.color.r = 1
				arg_471_1.var_.highlightMatValue10029.color.g = 1
				arg_471_1.var_.highlightMatValue10029.color.b = 1
				arg_471_1.var_.highlightMatValue10029.color = arg_471_1.var_.highlightMatValue10029.color
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				local var_474_5 = arg_471_1.actors_["10029"]:GetComponent("Image")

				if var_474_5 then
					arg_471_1.var_.alphaMatValue10029 = var_474_5
					arg_471_1.var_.alphaOldValue10029 = var_474_5.color.a
				end

				arg_471_1.var_.alphaOldValue10029 = 0
			end

			local var_474_6 = 0.333333333333333

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_6 then
				if arg_471_1.var_.alphaMatValue10029 then
					arg_471_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_471_1.var_.alphaOldValue10029, 1, (arg_471_1.time_ - 0) / var_474_6)
					arg_471_1.var_.alphaMatValue10029.color = arg_471_1.var_.alphaMatValue10029.color
				end
			end

			if arg_471_1.time_ >= 0 + var_474_6 and arg_471_1.time_ < 0 + var_474_6 + arg_474_0 and arg_471_1.var_.alphaMatValue10029 then
				arg_471_1.var_.alphaMatValue10029.color.a = 1
				arg_471_1.var_.alphaMatValue10029.color = arg_471_1.var_.alphaMatValue10029.color
			end

			local var_474_7 = 0
			local var_474_8 = 0.25

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_7 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_9 = arg_471_1:GetWordFromCfg(115261115)
				local var_474_10 = arg_471_1:FormatText(var_474_9.content)

				arg_471_1.text_.text = var_474_10

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_12 = 10 <= 0 and var_474_8 or var_474_8 * (utf8.len(var_474_10) / 10)

				if (10 <= 0 and var_474_8 or var_474_8 * (utf8.len(var_474_10) / 10)) > 0 and var_474_8 < var_474_12 then
					arg_471_1.talkMaxDuration = var_474_12

					if var_474_12 + var_474_7 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_12 + var_474_7
					end
				end

				arg_471_1.text_.text = var_474_10
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261115", "story_v_out_115261.awb") ~= 0 then
					local var_474_13 = manager.audio:GetVoiceLength("story_v_out_115261", "115261115", "story_v_out_115261.awb") / 1000

					if var_474_13 + var_474_7 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_13 + var_474_7
					end

					if var_474_9.prefab_name ~= "" and arg_471_1.actors_[var_474_9.prefab_name] ~= nil then
						local var_474_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_9.prefab_name].transform, "story_v_out_115261", "115261115", "story_v_out_115261.awb")

						arg_471_1:RecordAudio("115261115", var_474_14)
						arg_471_1:RecordAudio("115261115", var_474_14)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_115261", "115261115", "story_v_out_115261.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_115261", "115261115", "story_v_out_115261.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_15 = math.max(var_474_8, arg_471_1.talkMaxDuration)

			if var_474_7 <= arg_471_1.time_ and arg_471_1.time_ < var_474_7 + var_474_15 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_7) / var_474_15

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_7 + var_474_15 and arg_471_1.time_ < var_474_7 + var_474_15 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play115261116 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 115261116
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play115261117(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(arg_475_1.actors_["10029"]) then
				local var_478_0 = arg_475_1.actors_["10029"]:GetComponent("Image")

				if var_478_0 then
					arg_475_1.var_.highlightMatValue10029 = var_478_0
				end
			end

			local var_478_1 = 0.2

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_1 and not isNil(arg_475_1.actors_["10029"]) then
				if arg_475_1.var_.highlightMatValue10029 then
					local var_478_2 = Mathf.Lerp(1, 0.5, (arg_475_1.time_ - 0) / var_478_1)

					arg_475_1.var_.highlightMatValue10029.color.r = var_478_2
					arg_475_1.var_.highlightMatValue10029.color.g = var_478_2
					arg_475_1.var_.highlightMatValue10029.color.b = var_478_2
					arg_475_1.var_.highlightMatValue10029.color = arg_475_1.var_.highlightMatValue10029.color
				end
			end

			if arg_475_1.time_ >= 0 + var_478_1 and arg_475_1.time_ < 0 + var_478_1 + arg_478_0 and not isNil(arg_475_1.actors_["10029"]) and arg_475_1.var_.highlightMatValue10029 then
				arg_475_1.var_.highlightMatValue10029.color.r = 0.5
				arg_475_1.var_.highlightMatValue10029.color.g = 0.5
				arg_475_1.var_.highlightMatValue10029.color.b = 0.5
				arg_475_1.var_.highlightMatValue10029.color = arg_475_1.var_.highlightMatValue10029.color
			end

			local var_478_3 = 0
			local var_478_4 = 0.725

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_3 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, false)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_5 = arg_475_1:FormatText(arg_475_1:GetWordFromCfg(115261116).content)

				arg_475_1.text_.text = var_478_5

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_7 = 29 <= 0 and var_478_4 or var_478_4 * (utf8.len(var_478_5) / 29)

				if (29 <= 0 and var_478_4 or var_478_4 * (utf8.len(var_478_5) / 29)) > 0 and var_478_4 < var_478_7 then
					arg_475_1.talkMaxDuration = var_478_7

					if var_478_7 + var_478_3 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_3
					end
				end

				arg_475_1.text_.text = var_478_5
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_8 = math.max(var_478_4, arg_475_1.talkMaxDuration)

			if var_478_3 <= arg_475_1.time_ and arg_475_1.time_ < var_478_3 + var_478_8 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_3) / var_478_8

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_3 + var_478_8 and arg_475_1.time_ < var_478_3 + var_478_8 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play115261117 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 115261117
		arg_479_1.duration_ = 9.4

		local var_479_0 = {
			ja = 5.433,
			ko = 6.733,
			zh = 5.5,
			en = 9.4
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play115261118(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.var_.moveOldPos10029 = arg_479_1.actors_["10029"].transform.localPosition
				arg_479_1.actors_["10029"].transform.localScale = Vector3.New(1, 1, 1)

				arg_479_1:CheckSpriteTmpPos("10029", 3)
			end

			local var_482_0 = 0.001

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 then
				arg_479_1.actors_["10029"].transform.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos10029, Vector3.New(0, -350, -180), (arg_479_1.time_ - 0) / var_482_0)
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 then
				arg_479_1.actors_["10029"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_482_1 = arg_479_1.actors_["10029"]

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(var_482_1) then
				local var_482_2 = var_482_1:GetComponent("Image")

				if var_482_2 then
					arg_479_1.var_.highlightMatValue10029 = var_482_2
				end
			end

			local var_482_3 = 0.2

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_3 and not isNil(var_482_1) then
				if arg_479_1.var_.highlightMatValue10029 then
					local var_482_4 = Mathf.Lerp(0.5, 1, (arg_479_1.time_ - 0) / var_482_3)

					arg_479_1.var_.highlightMatValue10029.color.r = var_482_4
					arg_479_1.var_.highlightMatValue10029.color.g = var_482_4
					arg_479_1.var_.highlightMatValue10029.color.b = var_482_4
					arg_479_1.var_.highlightMatValue10029.color = arg_479_1.var_.highlightMatValue10029.color
				end
			end

			if arg_479_1.time_ >= 0 + var_482_3 and arg_479_1.time_ < 0 + var_482_3 + arg_482_0 and not isNil(var_482_1) and arg_479_1.var_.highlightMatValue10029 then
				var_482_1.transform:SetSiblingIndex(1)

				arg_479_1.var_.highlightMatValue10029.color.r = 1
				arg_479_1.var_.highlightMatValue10029.color.g = 1
				arg_479_1.var_.highlightMatValue10029.color.b = 1
				arg_479_1.var_.highlightMatValue10029.color = arg_479_1.var_.highlightMatValue10029.color
			end

			local var_482_5 = 0
			local var_482_6 = 0.65

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_5 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_7 = arg_479_1:GetWordFromCfg(115261117)
				local var_482_8 = arg_479_1:FormatText(var_482_7.content)

				arg_479_1.text_.text = var_482_8

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_10 = 26 <= 0 and var_482_6 or var_482_6 * (utf8.len(var_482_8) / 26)

				if (26 <= 0 and var_482_6 or var_482_6 * (utf8.len(var_482_8) / 26)) > 0 and var_482_6 < var_482_10 then
					arg_479_1.talkMaxDuration = var_482_10

					if var_482_10 + var_482_5 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_10 + var_482_5
					end
				end

				arg_479_1.text_.text = var_482_8
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261117", "story_v_out_115261.awb") ~= 0 then
					local var_482_11 = manager.audio:GetVoiceLength("story_v_out_115261", "115261117", "story_v_out_115261.awb") / 1000

					if var_482_11 + var_482_5 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_11 + var_482_5
					end

					if var_482_7.prefab_name ~= "" and arg_479_1.actors_[var_482_7.prefab_name] ~= nil then
						local var_482_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_7.prefab_name].transform, "story_v_out_115261", "115261117", "story_v_out_115261.awb")

						arg_479_1:RecordAudio("115261117", var_482_12)
						arg_479_1:RecordAudio("115261117", var_482_12)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_115261", "115261117", "story_v_out_115261.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_115261", "115261117", "story_v_out_115261.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_13 = math.max(var_482_6, arg_479_1.talkMaxDuration)

			if var_482_5 <= arg_479_1.time_ and arg_479_1.time_ < var_482_5 + var_482_13 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_5) / var_482_13

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_5 + var_482_13 and arg_479_1.time_ < var_482_5 + var_482_13 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play115261118 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 115261118
		arg_483_1.duration_ = 6.37

		local var_483_0 = {
			ja = 6.366,
			ko = 4.833,
			zh = 2.266,
			en = 4.133
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play115261119(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0.325

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_1 = arg_483_1:GetWordFromCfg(115261118)
				local var_486_2 = arg_483_1:FormatText(var_486_1.content)

				arg_483_1.text_.text = var_486_2

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_4 = 13 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_2) / 13)

				if (13 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_2) / 13)) > 0 and var_486_0 < var_486_4 then
					arg_483_1.talkMaxDuration = var_486_4

					if var_486_4 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_4 + 0
					end
				end

				arg_483_1.text_.text = var_486_2
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261118", "story_v_out_115261.awb") ~= 0 then
					local var_486_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261118", "story_v_out_115261.awb") / 1000

					if var_486_5 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_5 + 0
					end

					if var_486_1.prefab_name ~= "" and arg_483_1.actors_[var_486_1.prefab_name] ~= nil then
						local var_486_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_1.prefab_name].transform, "story_v_out_115261", "115261118", "story_v_out_115261.awb")

						arg_483_1:RecordAudio("115261118", var_486_6)
						arg_483_1:RecordAudio("115261118", var_486_6)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_115261", "115261118", "story_v_out_115261.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_115261", "115261118", "story_v_out_115261.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_0, arg_483_1.talkMaxDuration)

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - 0) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= 0 + var_486_7 and arg_483_1.time_ < 0 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play115261119 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 115261119
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play115261120(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0.299333333333333 < arg_487_1.time_ and arg_487_1.time_ <= 0.299333333333333 + arg_490_0 then
				arg_487_1.var_.moveOldPos10029 = arg_487_1.actors_["10029"].transform.localPosition
				arg_487_1.actors_["10029"].transform.localScale = Vector3.New(1, 1, 1)

				arg_487_1:CheckSpriteTmpPos("10029", 0)
			end

			local var_490_0 = 0.001

			if 0.299333333333333 <= arg_487_1.time_ and arg_487_1.time_ < 0.299333333333333 + var_490_0 then
				arg_487_1.actors_["10029"].transform.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos10029, Vector3.New(-1500, -350, -180), (arg_487_1.time_ - 0.299333333333333) / var_490_0)
			end

			if arg_487_1.time_ >= 0.299333333333333 + var_490_0 and arg_487_1.time_ < 0.299333333333333 + var_490_0 + arg_490_0 then
				arg_487_1.actors_["10029"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				local var_490_1 = arg_487_1.actors_["10029"]:GetComponent("Image")

				if var_490_1 then
					arg_487_1.var_.alphaMatValue10029 = var_490_1
					arg_487_1.var_.alphaOldValue10029 = var_490_1.color.a
				end

				arg_487_1.var_.alphaOldValue10029 = 1
			end

			local var_490_2 = 0.333333333333333

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_2 then
				if arg_487_1.var_.alphaMatValue10029 then
					arg_487_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_487_1.var_.alphaOldValue10029, 0, (arg_487_1.time_ - 0) / var_490_2)
					arg_487_1.var_.alphaMatValue10029.color = arg_487_1.var_.alphaMatValue10029.color
				end
			end

			if arg_487_1.time_ >= 0 + var_490_2 and arg_487_1.time_ < 0 + var_490_2 + arg_490_0 and arg_487_1.var_.alphaMatValue10029 then
				arg_487_1.var_.alphaMatValue10029.color.a = 0
				arg_487_1.var_.alphaMatValue10029.color = arg_487_1.var_.alphaMatValue10029.color
			end

			local var_490_3 = 0
			local var_490_4 = 0.575

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_3 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_5 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(115261119).content)

				arg_487_1.text_.text = var_490_5

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_7 = 23 <= 0 and var_490_4 or var_490_4 * (utf8.len(var_490_5) / 23)

				if (23 <= 0 and var_490_4 or var_490_4 * (utf8.len(var_490_5) / 23)) > 0 and var_490_4 < var_490_7 then
					arg_487_1.talkMaxDuration = var_490_7

					if var_490_7 + var_490_3 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_7 + var_490_3
					end
				end

				arg_487_1.text_.text = var_490_5
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_8 = math.max(var_490_4, arg_487_1.talkMaxDuration)

			if var_490_3 <= arg_487_1.time_ and arg_487_1.time_ < var_490_3 + var_490_8 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_3) / var_490_8

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_3 + var_490_8 and arg_487_1.time_ < var_490_3 + var_490_8 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.299333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_487_1:InitPlayNodeList()
	end,
	Play115261120 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 115261120
		arg_491_1.duration_ = 4.93

		local var_491_0 = {
			ja = 1.8,
			ko = 2.866,
			zh = 3.1,
			en = 4.933
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play115261121(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos10030 = arg_491_1.actors_["10030"].transform.localPosition
				arg_491_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("10030", 4)

				for iter_494_0 = 0, arg_491_1.actors_["10030"].transform.childCount - 1 do
					local var_494_0 = arg_491_1.actors_["10030"].transform:GetChild(iter_494_0)

					if var_494_0.name == "split_1" or not string.find(var_494_0.name, "split") then
						var_494_0.gameObject:SetActive(true)
					else
						var_494_0.gameObject:SetActive(false)
					end
				end
			end

			local var_494_1 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_1 then
				arg_491_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_491_1.time_ - 0) / var_494_1)
			end

			if arg_491_1.time_ >= 0 + var_494_1 and arg_491_1.time_ < 0 + var_494_1 + arg_494_0 then
				arg_491_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				local var_494_2 = arg_491_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_494_2 then
					arg_491_1.var_.alphaOldValue10030 = var_494_2.alpha
					arg_491_1.var_.characterEffect10030 = var_494_2
				end

				arg_491_1.var_.alphaOldValue10030 = 0
			end

			local var_494_3 = 0.333333333333333

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_3 then
				if arg_491_1.var_.characterEffect10030 then
					arg_491_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_491_1.var_.alphaOldValue10030, 1, (arg_491_1.time_ - 0) / var_494_3)
				end
			end

			if arg_491_1.time_ >= 0 + var_494_3 and arg_491_1.time_ < 0 + var_494_3 + arg_494_0 and arg_491_1.var_.characterEffect10030 then
				arg_491_1.var_.characterEffect10030.alpha = 1
			end

			local var_494_4 = arg_491_1.actors_["10029"].transform

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos10029 = var_494_4.localPosition
				var_494_4.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_494_5 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_5 then
				var_494_4.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10029, Vector3.New(-390, -350, -180), (arg_491_1.time_ - 0) / var_494_5)
			end

			if arg_491_1.time_ >= 0 + var_494_5 and arg_491_1.time_ < 0 + var_494_5 + arg_494_0 then
				var_494_4.localPosition = Vector3.New(-390, -350, -180)
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				local var_494_6 = arg_491_1.actors_["10029"]:GetComponent("Image")

				if var_494_6 then
					arg_491_1.var_.alphaMatValue10029 = var_494_6
					arg_491_1.var_.alphaOldValue10029 = var_494_6.color.a
				end

				arg_491_1.var_.alphaOldValue10029 = 0
			end

			local var_494_7 = 0.333333333333333

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_7 then
				if arg_491_1.var_.alphaMatValue10029 then
					arg_491_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_491_1.var_.alphaOldValue10029, 1, (arg_491_1.time_ - 0) / var_494_7)
					arg_491_1.var_.alphaMatValue10029.color = arg_491_1.var_.alphaMatValue10029.color
				end
			end

			if arg_491_1.time_ >= 0 + var_494_7 and arg_491_1.time_ < 0 + var_494_7 + arg_494_0 and arg_491_1.var_.alphaMatValue10029 then
				arg_491_1.var_.alphaMatValue10029.color.a = 1
				arg_491_1.var_.alphaMatValue10029.color = arg_491_1.var_.alphaMatValue10029.color
			end

			local var_494_8 = arg_491_1.actors_["10030"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_8) and arg_491_1.var_.actorSpriteComps10030 == nil then
				arg_491_1.var_.actorSpriteComps10030 = var_494_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_9 = 0.2

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_9 and not isNil(var_494_8) then
				if arg_491_1.var_.actorSpriteComps10030 then
					for iter_494_1, iter_494_2 in pairs(arg_491_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_494_2 then
							if arg_491_1.isInRecall_ then
								iter_494_2.color = Color.New(Mathf.Lerp(iter_494_2.color.r, arg_491_1.hightColor1.r, (arg_491_1.time_ - 0) / var_494_9), Mathf.Lerp(iter_494_2.color.g, arg_491_1.hightColor1.g, (arg_491_1.time_ - 0) / var_494_9), (Mathf.Lerp(iter_494_2.color.b, arg_491_1.hightColor1.b, (arg_491_1.time_ - 0) / var_494_9)))
							else
								local var_494_10 = Mathf.Lerp(iter_494_2.color.r, 1, (arg_491_1.time_ - 0) / var_494_9)

								iter_494_2.color = Color.New(var_494_10, var_494_10, var_494_10)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= 0 + var_494_9 and arg_491_1.time_ < 0 + var_494_9 + arg_494_0 and not isNil(var_494_8) and arg_491_1.var_.actorSpriteComps10030 then
				for iter_494_3, iter_494_4 in pairs(arg_491_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_494_4 then
						iter_494_4.color = arg_491_1.isInRecall_ and (arg_491_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_491_1.var_.actorSpriteComps10030 = nil
			end

			local var_494_11 = arg_491_1.actors_["10029"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_11) then
				local var_494_12 = var_494_11:GetComponent("Image")

				if var_494_12 then
					arg_491_1.var_.highlightMatValue10029 = var_494_12
				end
			end

			local var_494_13 = 0.2

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_13 and not isNil(var_494_11) then
				if arg_491_1.var_.highlightMatValue10029 then
					local var_494_14 = Mathf.Lerp(1, 0.5, (arg_491_1.time_ - 0) / var_494_13)

					arg_491_1.var_.highlightMatValue10029.color.r = var_494_14
					arg_491_1.var_.highlightMatValue10029.color.g = var_494_14
					arg_491_1.var_.highlightMatValue10029.color.b = var_494_14
					arg_491_1.var_.highlightMatValue10029.color = arg_491_1.var_.highlightMatValue10029.color
				end
			end

			if arg_491_1.time_ >= 0 + var_494_13 and arg_491_1.time_ < 0 + var_494_13 + arg_494_0 and not isNil(var_494_11) and arg_491_1.var_.highlightMatValue10029 then
				arg_491_1.var_.highlightMatValue10029.color.r = 0.5
				arg_491_1.var_.highlightMatValue10029.color.g = 0.5
				arg_491_1.var_.highlightMatValue10029.color.b = 0.5
				arg_491_1.var_.highlightMatValue10029.color = arg_491_1.var_.highlightMatValue10029.color
			end

			local var_494_15 = 0
			local var_494_16 = 0.225

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_15 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_17 = arg_491_1:GetWordFromCfg(115261120)
				local var_494_18 = arg_491_1:FormatText(var_494_17.content)

				arg_491_1.text_.text = var_494_18

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_20 = 9 <= 0 and var_494_16 or var_494_16 * (utf8.len(var_494_18) / 9)

				if (9 <= 0 and var_494_16 or var_494_16 * (utf8.len(var_494_18) / 9)) > 0 and var_494_16 < var_494_20 then
					arg_491_1.talkMaxDuration = var_494_20

					if var_494_20 + var_494_15 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_20 + var_494_15
					end
				end

				arg_491_1.text_.text = var_494_18
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261120", "story_v_out_115261.awb") ~= 0 then
					local var_494_21 = manager.audio:GetVoiceLength("story_v_out_115261", "115261120", "story_v_out_115261.awb") / 1000

					if var_494_21 + var_494_15 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_21 + var_494_15
					end

					if var_494_17.prefab_name ~= "" and arg_491_1.actors_[var_494_17.prefab_name] ~= nil then
						local var_494_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_17.prefab_name].transform, "story_v_out_115261", "115261120", "story_v_out_115261.awb")

						arg_491_1:RecordAudio("115261120", var_494_22)
						arg_491_1:RecordAudio("115261120", var_494_22)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_115261", "115261120", "story_v_out_115261.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_115261", "115261120", "story_v_out_115261.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_23 = math.max(var_494_16, arg_491_1.talkMaxDuration)

			if var_494_15 <= arg_491_1.time_ and arg_491_1.time_ < var_494_15 + var_494_23 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_15) / var_494_23

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_15 + var_494_23 and arg_491_1.time_ < var_494_15 + var_494_23 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_491_1:InitPlayNodeList()
	end,
	Play115261121 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 115261121
		arg_495_1.duration_ = 12.87

		local var_495_0 = {
			ja = 12.866,
			ko = 12.666,
			zh = 11.5,
			en = 11.833
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play115261122(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.var_.moveOldPos10029 = arg_495_1.actors_["10029"].transform.localPosition
				arg_495_1.actors_["10029"].transform.localScale = Vector3.New(1, 1, 1)

				arg_495_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_498_0 = 0.001

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 then
				arg_495_1.actors_["10029"].transform.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos10029, Vector3.New(-390, -350, -180), (arg_495_1.time_ - 0) / var_498_0)
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 then
				arg_495_1.actors_["10029"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_498_1 = arg_495_1.actors_["10030"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.actorSpriteComps10030 == nil then
				arg_495_1.var_.actorSpriteComps10030 = var_498_1:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_2 = 0.2

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_2 and not isNil(var_498_1) then
				if arg_495_1.var_.actorSpriteComps10030 then
					for iter_498_0, iter_498_1 in pairs(arg_495_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_498_1 then
							if arg_495_1.isInRecall_ then
								iter_498_1.color = Color.New(Mathf.Lerp(iter_498_1.color.r, arg_495_1.hightColor2.r, (arg_495_1.time_ - 0) / var_498_2), Mathf.Lerp(iter_498_1.color.g, arg_495_1.hightColor2.g, (arg_495_1.time_ - 0) / var_498_2), (Mathf.Lerp(iter_498_1.color.b, arg_495_1.hightColor2.b, (arg_495_1.time_ - 0) / var_498_2)))
							else
								local var_498_3 = Mathf.Lerp(iter_498_1.color.r, 0.5, (arg_495_1.time_ - 0) / var_498_2)

								iter_498_1.color = Color.New(var_498_3, var_498_3, var_498_3)
							end
						end
					end
				end
			end

			if arg_495_1.time_ >= 0 + var_498_2 and arg_495_1.time_ < 0 + var_498_2 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.actorSpriteComps10030 then
				for iter_498_2, iter_498_3 in pairs(arg_495_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_498_3 then
						iter_498_3.color = arg_495_1.isInRecall_ and (arg_495_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_495_1.var_.actorSpriteComps10030 = nil
			end

			local var_498_4 = arg_495_1.actors_["10029"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_4) then
				local var_498_5 = var_498_4:GetComponent("Image")

				if var_498_5 then
					arg_495_1.var_.highlightMatValue10029 = var_498_5
				end
			end

			local var_498_6 = 0.2

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_6 and not isNil(var_498_4) then
				if arg_495_1.var_.highlightMatValue10029 then
					local var_498_7 = Mathf.Lerp(0.5, 1, (arg_495_1.time_ - 0) / var_498_6)

					arg_495_1.var_.highlightMatValue10029.color.r = var_498_7
					arg_495_1.var_.highlightMatValue10029.color.g = var_498_7
					arg_495_1.var_.highlightMatValue10029.color.b = var_498_7
					arg_495_1.var_.highlightMatValue10029.color = arg_495_1.var_.highlightMatValue10029.color
				end
			end

			if arg_495_1.time_ >= 0 + var_498_6 and arg_495_1.time_ < 0 + var_498_6 + arg_498_0 and not isNil(var_498_4) and arg_495_1.var_.highlightMatValue10029 then
				var_498_4.transform:SetSiblingIndex(1)

				arg_495_1.var_.highlightMatValue10029.color.r = 1
				arg_495_1.var_.highlightMatValue10029.color.g = 1
				arg_495_1.var_.highlightMatValue10029.color.b = 1
				arg_495_1.var_.highlightMatValue10029.color = arg_495_1.var_.highlightMatValue10029.color
			end

			local var_498_8 = 0
			local var_498_9 = 1.1

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_8 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_10 = arg_495_1:GetWordFromCfg(115261121)
				local var_498_11 = arg_495_1:FormatText(var_498_10.content)

				arg_495_1.text_.text = var_498_11

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_13 = 44 <= 0 and var_498_9 or var_498_9 * (utf8.len(var_498_11) / 44)

				if (44 <= 0 and var_498_9 or var_498_9 * (utf8.len(var_498_11) / 44)) > 0 and var_498_9 < var_498_13 then
					arg_495_1.talkMaxDuration = var_498_13

					if var_498_13 + var_498_8 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_13 + var_498_8
					end
				end

				arg_495_1.text_.text = var_498_11
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261121", "story_v_out_115261.awb") ~= 0 then
					local var_498_14 = manager.audio:GetVoiceLength("story_v_out_115261", "115261121", "story_v_out_115261.awb") / 1000

					if var_498_14 + var_498_8 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_14 + var_498_8
					end

					if var_498_10.prefab_name ~= "" and arg_495_1.actors_[var_498_10.prefab_name] ~= nil then
						local var_498_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_10.prefab_name].transform, "story_v_out_115261", "115261121", "story_v_out_115261.awb")

						arg_495_1:RecordAudio("115261121", var_498_15)
						arg_495_1:RecordAudio("115261121", var_498_15)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_115261", "115261121", "story_v_out_115261.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_115261", "115261121", "story_v_out_115261.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_16 = math.max(var_498_9, arg_495_1.talkMaxDuration)

			if var_498_8 <= arg_495_1.time_ and arg_495_1.time_ < var_498_8 + var_498_16 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_8) / var_498_16

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_8 + var_498_16 and arg_495_1.time_ < var_498_8 + var_498_16 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play115261122 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 115261122
		arg_499_1.duration_ = 18.47

		local var_499_0 = {
			ja = 14.4,
			ko = 14.133,
			zh = 13.2,
			en = 18.466
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play115261123(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 1.375

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_1 = arg_499_1:GetWordFromCfg(115261122)
				local var_502_2 = arg_499_1:FormatText(var_502_1.content)

				arg_499_1.text_.text = var_502_2

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 54 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 54)

				if (54 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 54)) > 0 and var_502_0 < var_502_4 then
					arg_499_1.talkMaxDuration = var_502_4

					if var_502_4 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_4 + 0
					end
				end

				arg_499_1.text_.text = var_502_2
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261122", "story_v_out_115261.awb") ~= 0 then
					local var_502_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261122", "story_v_out_115261.awb") / 1000

					if var_502_5 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_5 + 0
					end

					if var_502_1.prefab_name ~= "" and arg_499_1.actors_[var_502_1.prefab_name] ~= nil then
						local var_502_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_1.prefab_name].transform, "story_v_out_115261", "115261122", "story_v_out_115261.awb")

						arg_499_1:RecordAudio("115261122", var_502_6)
						arg_499_1:RecordAudio("115261122", var_502_6)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_115261", "115261122", "story_v_out_115261.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_115261", "115261122", "story_v_out_115261.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_0, arg_499_1.talkMaxDuration)

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - 0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= 0 + var_502_7 and arg_499_1.time_ < 0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play115261123 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 115261123
		arg_503_1.duration_ = 13.4

		local var_503_0 = {
			ja = 9.133,
			ko = 9.1,
			zh = 9.4,
			en = 13.4
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play115261124(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0.975

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_1 = arg_503_1:GetWordFromCfg(115261123)
				local var_506_2 = arg_503_1:FormatText(var_506_1.content)

				arg_503_1.text_.text = var_506_2

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_4 = 38 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_2) / 38)

				if (38 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_2) / 38)) > 0 and var_506_0 < var_506_4 then
					arg_503_1.talkMaxDuration = var_506_4

					if var_506_4 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_4 + 0
					end
				end

				arg_503_1.text_.text = var_506_2
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261123", "story_v_out_115261.awb") ~= 0 then
					local var_506_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261123", "story_v_out_115261.awb") / 1000

					if var_506_5 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + 0
					end

					if var_506_1.prefab_name ~= "" and arg_503_1.actors_[var_506_1.prefab_name] ~= nil then
						local var_506_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_1.prefab_name].transform, "story_v_out_115261", "115261123", "story_v_out_115261.awb")

						arg_503_1:RecordAudio("115261123", var_506_6)
						arg_503_1:RecordAudio("115261123", var_506_6)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_115261", "115261123", "story_v_out_115261.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_115261", "115261123", "story_v_out_115261.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_7 = math.max(var_506_0, arg_503_1.talkMaxDuration)

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_7 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - 0) / var_506_7

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= 0 + var_506_7 and arg_503_1.time_ < 0 + var_506_7 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play115261124 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 115261124
		arg_507_1.duration_ = 11.7

		local var_507_0 = {
			ja = 11.133,
			ko = 9.566,
			zh = 9.9,
			en = 11.7
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play115261125(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0.95

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_1 = arg_507_1:GetWordFromCfg(115261124)
				local var_510_2 = arg_507_1:FormatText(var_510_1.content)

				arg_507_1.text_.text = var_510_2

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_4 = 38 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_2) / 38)

				if (38 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_2) / 38)) > 0 and var_510_0 < var_510_4 then
					arg_507_1.talkMaxDuration = var_510_4

					if var_510_4 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_4 + 0
					end
				end

				arg_507_1.text_.text = var_510_2
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261124", "story_v_out_115261.awb") ~= 0 then
					local var_510_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261124", "story_v_out_115261.awb") / 1000

					if var_510_5 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + 0
					end

					if var_510_1.prefab_name ~= "" and arg_507_1.actors_[var_510_1.prefab_name] ~= nil then
						local var_510_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_1.prefab_name].transform, "story_v_out_115261", "115261124", "story_v_out_115261.awb")

						arg_507_1:RecordAudio("115261124", var_510_6)
						arg_507_1:RecordAudio("115261124", var_510_6)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_115261", "115261124", "story_v_out_115261.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_115261", "115261124", "story_v_out_115261.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_7 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_7 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_7

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_7 and arg_507_1.time_ < 0 + var_510_7 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play115261125 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 115261125
		arg_511_1.duration_ = 4.77

		local var_511_0 = {
			ja = 1.9,
			ko = 3.8,
			zh = 4.3,
			en = 4.766
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play115261126(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos10030 = arg_511_1.actors_["10030"].transform.localPosition
				arg_511_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_511_1:CheckSpriteTmpPos("10030", 4)

				for iter_514_0 = 0, arg_511_1.actors_["10030"].transform.childCount - 1 do
					local var_514_0 = arg_511_1.actors_["10030"].transform:GetChild(iter_514_0)

					if var_514_0.name == "split_3" or not string.find(var_514_0.name, "split") then
						var_514_0.gameObject:SetActive(true)
					else
						var_514_0.gameObject:SetActive(false)
					end
				end
			end

			local var_514_1 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_1 then
				arg_511_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_511_1.time_ - 0) / var_514_1)
			end

			if arg_511_1.time_ >= 0 + var_514_1 and arg_511_1.time_ < 0 + var_514_1 + arg_514_0 then
				arg_511_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_514_2 = arg_511_1.actors_["10029"]

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(var_514_2) then
				local var_514_3 = var_514_2:GetComponent("Image")

				if var_514_3 then
					arg_511_1.var_.highlightMatValue10029 = var_514_3
				end
			end

			local var_514_4 = 0.2

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_4 and not isNil(var_514_2) then
				if arg_511_1.var_.highlightMatValue10029 then
					local var_514_5 = Mathf.Lerp(1, 0.5, (arg_511_1.time_ - 0) / var_514_4)

					arg_511_1.var_.highlightMatValue10029.color.r = var_514_5
					arg_511_1.var_.highlightMatValue10029.color.g = var_514_5
					arg_511_1.var_.highlightMatValue10029.color.b = var_514_5
					arg_511_1.var_.highlightMatValue10029.color = arg_511_1.var_.highlightMatValue10029.color
				end
			end

			if arg_511_1.time_ >= 0 + var_514_4 and arg_511_1.time_ < 0 + var_514_4 + arg_514_0 and not isNil(var_514_2) and arg_511_1.var_.highlightMatValue10029 then
				arg_511_1.var_.highlightMatValue10029.color.r = 0.5
				arg_511_1.var_.highlightMatValue10029.color.g = 0.5
				arg_511_1.var_.highlightMatValue10029.color.b = 0.5
				arg_511_1.var_.highlightMatValue10029.color = arg_511_1.var_.highlightMatValue10029.color
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				local var_514_6 = arg_511_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_514_6 then
					arg_511_1.var_.alphaOldValue10030 = var_514_6.alpha
					arg_511_1.var_.characterEffect10030 = var_514_6
				end

				arg_511_1.var_.alphaOldValue10030 = 0
			end

			local var_514_7 = 0.0166666666666667

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_7 then
				if arg_511_1.var_.characterEffect10030 then
					arg_511_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_511_1.var_.alphaOldValue10030, 1, (arg_511_1.time_ - 0) / var_514_7)
				end
			end

			if arg_511_1.time_ >= 0 + var_514_7 and arg_511_1.time_ < 0 + var_514_7 + arg_514_0 and arg_511_1.var_.characterEffect10030 then
				arg_511_1.var_.characterEffect10030.alpha = 1
			end

			local var_514_8 = 0
			local var_514_9 = 0.25

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_8 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_10 = arg_511_1:GetWordFromCfg(115261125)
				local var_514_11 = arg_511_1:FormatText(var_514_10.content)

				arg_511_1.text_.text = var_514_11

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_13 = 10 <= 0 and var_514_9 or var_514_9 * (utf8.len(var_514_11) / 10)

				if (10 <= 0 and var_514_9 or var_514_9 * (utf8.len(var_514_11) / 10)) > 0 and var_514_9 < var_514_13 then
					arg_511_1.talkMaxDuration = var_514_13

					if var_514_13 + var_514_8 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_13 + var_514_8
					end
				end

				arg_511_1.text_.text = var_514_11
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261125", "story_v_out_115261.awb") ~= 0 then
					local var_514_14 = manager.audio:GetVoiceLength("story_v_out_115261", "115261125", "story_v_out_115261.awb") / 1000

					if var_514_14 + var_514_8 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_14 + var_514_8
					end

					if var_514_10.prefab_name ~= "" and arg_511_1.actors_[var_514_10.prefab_name] ~= nil then
						local var_514_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_10.prefab_name].transform, "story_v_out_115261", "115261125", "story_v_out_115261.awb")

						arg_511_1:RecordAudio("115261125", var_514_15)
						arg_511_1:RecordAudio("115261125", var_514_15)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_115261", "115261125", "story_v_out_115261.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_115261", "115261125", "story_v_out_115261.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_16 = math.max(var_514_9, arg_511_1.talkMaxDuration)

			if var_514_8 <= arg_511_1.time_ and arg_511_1.time_ < var_514_8 + var_514_16 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_8) / var_514_16

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_8 + var_514_16 and arg_511_1.time_ < var_514_8 + var_514_16 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play115261126 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 115261126
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play115261127(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				local var_518_0 = arg_515_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_518_0 then
					arg_515_1.var_.alphaOldValue10030 = var_518_0.alpha
					arg_515_1.var_.characterEffect10030 = var_518_0
				end

				arg_515_1.var_.alphaOldValue10030 = 1
			end

			local var_518_1 = 0.333333333333333

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_1 then
				if arg_515_1.var_.characterEffect10030 then
					arg_515_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_515_1.var_.alphaOldValue10030, 0, (arg_515_1.time_ - 0) / var_518_1)
				end
			end

			if arg_515_1.time_ >= 0 + var_518_1 and arg_515_1.time_ < 0 + var_518_1 + arg_518_0 and arg_515_1.var_.characterEffect10030 then
				arg_515_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				local var_518_2 = arg_515_1.actors_["10029"]:GetComponent("Image")

				if var_518_2 then
					arg_515_1.var_.alphaMatValue10029 = var_518_2
					arg_515_1.var_.alphaOldValue10029 = var_518_2.color.a
				end

				arg_515_1.var_.alphaOldValue10029 = 1
			end

			local var_518_3 = 0.333333333333333

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_3 then
				if arg_515_1.var_.alphaMatValue10029 then
					arg_515_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_515_1.var_.alphaOldValue10029, 0, (arg_515_1.time_ - 0) / var_518_3)
					arg_515_1.var_.alphaMatValue10029.color = arg_515_1.var_.alphaMatValue10029.color
				end
			end

			if arg_515_1.time_ >= 0 + var_518_3 and arg_515_1.time_ < 0 + var_518_3 + arg_518_0 and arg_515_1.var_.alphaMatValue10029 then
				arg_515_1.var_.alphaMatValue10029.color.a = 0
				arg_515_1.var_.alphaMatValue10029.color = arg_515_1.var_.alphaMatValue10029.color
			end

			local var_518_4 = 0
			local var_518_5 = 1.325

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_4 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, false)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_6 = arg_515_1:FormatText(arg_515_1:GetWordFromCfg(115261126).content)

				arg_515_1.text_.text = var_518_6

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_8 = 53 <= 0 and var_518_5 or var_518_5 * (utf8.len(var_518_6) / 53)

				if (53 <= 0 and var_518_5 or var_518_5 * (utf8.len(var_518_6) / 53)) > 0 and var_518_5 < var_518_8 then
					arg_515_1.talkMaxDuration = var_518_8

					if var_518_8 + var_518_4 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_8 + var_518_4
					end
				end

				arg_515_1.text_.text = var_518_6
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_9 = math.max(var_518_5, arg_515_1.talkMaxDuration)

			if var_518_4 <= arg_515_1.time_ and arg_515_1.time_ < var_518_4 + var_518_9 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_4) / var_518_9

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_4 + var_518_9 and arg_515_1.time_ < var_518_4 + var_518_9 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play115261127 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 115261127
		arg_519_1.duration_ = 6.53

		local var_519_0 = {
			ja = 5.533,
			ko = 4.9,
			zh = 3.4,
			en = 6.533
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play115261128(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos10029 = arg_519_1.actors_["10029"].transform.localPosition
				arg_519_1.actors_["10029"].transform.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_522_0 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 then
				arg_519_1.actors_["10029"].transform.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10029, Vector3.New(-390, -350, -180), (arg_519_1.time_ - 0) / var_522_0)
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 then
				arg_519_1.actors_["10029"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_522_1 = arg_519_1.actors_["10029"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_1) then
				local var_522_2 = var_522_1:GetComponent("Image")

				if var_522_2 then
					arg_519_1.var_.highlightMatValue10029 = var_522_2
				end
			end

			local var_522_3 = 0.2

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_3 and not isNil(var_522_1) then
				if arg_519_1.var_.highlightMatValue10029 then
					local var_522_4 = Mathf.Lerp(0.5, 1, (arg_519_1.time_ - 0) / var_522_3)

					arg_519_1.var_.highlightMatValue10029.color.r = var_522_4
					arg_519_1.var_.highlightMatValue10029.color.g = var_522_4
					arg_519_1.var_.highlightMatValue10029.color.b = var_522_4
					arg_519_1.var_.highlightMatValue10029.color = arg_519_1.var_.highlightMatValue10029.color
				end
			end

			if arg_519_1.time_ >= 0 + var_522_3 and arg_519_1.time_ < 0 + var_522_3 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.highlightMatValue10029 then
				var_522_1.transform:SetSiblingIndex(1)

				arg_519_1.var_.highlightMatValue10029.color.r = 1
				arg_519_1.var_.highlightMatValue10029.color.g = 1
				arg_519_1.var_.highlightMatValue10029.color.b = 1
				arg_519_1.var_.highlightMatValue10029.color = arg_519_1.var_.highlightMatValue10029.color
			end

			local var_522_5 = arg_519_1.actors_["10030"].transform

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos10030 = var_522_5.localPosition
				var_522_5.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("10030", 4)

				for iter_522_0 = 0, var_522_5.childCount - 1 do
					local var_522_6 = var_522_5:GetChild(iter_522_0)

					if var_522_6.name == "split_3" or not string.find(var_522_6.name, "split") then
						var_522_6.gameObject:SetActive(true)
					else
						var_522_6.gameObject:SetActive(false)
					end
				end
			end

			local var_522_7 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_7 then
				var_522_5.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_519_1.time_ - 0) / var_522_7)
			end

			if arg_519_1.time_ >= 0 + var_522_7 and arg_519_1.time_ < 0 + var_522_7 + arg_522_0 then
				var_522_5.localPosition = Vector3.New(390, -390, 150)
			end

			local var_522_8 = arg_519_1.actors_["10030"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_8) and arg_519_1.var_.actorSpriteComps10030 == nil then
				arg_519_1.var_.actorSpriteComps10030 = var_522_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_9 = 0.2

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_9 and not isNil(var_522_8) then
				if arg_519_1.var_.actorSpriteComps10030 then
					for iter_522_1, iter_522_2 in pairs(arg_519_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_522_2 then
							if arg_519_1.isInRecall_ then
								iter_522_2.color = Color.New(Mathf.Lerp(iter_522_2.color.r, arg_519_1.hightColor2.r, (arg_519_1.time_ - 0) / var_522_9), Mathf.Lerp(iter_522_2.color.g, arg_519_1.hightColor2.g, (arg_519_1.time_ - 0) / var_522_9), (Mathf.Lerp(iter_522_2.color.b, arg_519_1.hightColor2.b, (arg_519_1.time_ - 0) / var_522_9)))
							else
								local var_522_10 = Mathf.Lerp(iter_522_2.color.r, 0.5, (arg_519_1.time_ - 0) / var_522_9)

								iter_522_2.color = Color.New(var_522_10, var_522_10, var_522_10)
							end
						end
					end
				end
			end

			if arg_519_1.time_ >= 0 + var_522_9 and arg_519_1.time_ < 0 + var_522_9 + arg_522_0 and not isNil(var_522_8) and arg_519_1.var_.actorSpriteComps10030 then
				for iter_522_3, iter_522_4 in pairs(arg_519_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_522_4 then
						iter_522_4.color = arg_519_1.isInRecall_ and (arg_519_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_519_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				local var_522_11 = arg_519_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_522_11 then
					arg_519_1.var_.alphaOldValue10030 = var_522_11.alpha
					arg_519_1.var_.characterEffect10030 = var_522_11
				end

				arg_519_1.var_.alphaOldValue10030 = 0
			end

			local var_522_12 = 0.333333333333333

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_12 then
				if arg_519_1.var_.characterEffect10030 then
					arg_519_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_519_1.var_.alphaOldValue10030, 1, (arg_519_1.time_ - 0) / var_522_12)
				end
			end

			if arg_519_1.time_ >= 0 + var_522_12 and arg_519_1.time_ < 0 + var_522_12 + arg_522_0 and arg_519_1.var_.characterEffect10030 then
				arg_519_1.var_.characterEffect10030.alpha = 1
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				local var_522_13 = arg_519_1.actors_["10029"]:GetComponent("Image")

				if var_522_13 then
					arg_519_1.var_.alphaMatValue10029 = var_522_13
					arg_519_1.var_.alphaOldValue10029 = var_522_13.color.a
				end

				arg_519_1.var_.alphaOldValue10029 = 0
			end

			local var_522_14 = 0.333333333333333

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_14 then
				if arg_519_1.var_.alphaMatValue10029 then
					arg_519_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_519_1.var_.alphaOldValue10029, 1, (arg_519_1.time_ - 0) / var_522_14)
					arg_519_1.var_.alphaMatValue10029.color = arg_519_1.var_.alphaMatValue10029.color
				end
			end

			if arg_519_1.time_ >= 0 + var_522_14 and arg_519_1.time_ < 0 + var_522_14 + arg_522_0 and arg_519_1.var_.alphaMatValue10029 then
				arg_519_1.var_.alphaMatValue10029.color.a = 1
				arg_519_1.var_.alphaMatValue10029.color = arg_519_1.var_.alphaMatValue10029.color
			end

			local var_522_15 = 0
			local var_522_16 = 0.325

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_15 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_17 = arg_519_1:GetWordFromCfg(115261127)
				local var_522_18 = arg_519_1:FormatText(var_522_17.content)

				arg_519_1.text_.text = var_522_18

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_20 = 13 <= 0 and var_522_16 or var_522_16 * (utf8.len(var_522_18) / 13)

				if (13 <= 0 and var_522_16 or var_522_16 * (utf8.len(var_522_18) / 13)) > 0 and var_522_16 < var_522_20 then
					arg_519_1.talkMaxDuration = var_522_20

					if var_522_20 + var_522_15 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_20 + var_522_15
					end
				end

				arg_519_1.text_.text = var_522_18
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261127", "story_v_out_115261.awb") ~= 0 then
					local var_522_21 = manager.audio:GetVoiceLength("story_v_out_115261", "115261127", "story_v_out_115261.awb") / 1000

					if var_522_21 + var_522_15 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_21 + var_522_15
					end

					if var_522_17.prefab_name ~= "" and arg_519_1.actors_[var_522_17.prefab_name] ~= nil then
						local var_522_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_17.prefab_name].transform, "story_v_out_115261", "115261127", "story_v_out_115261.awb")

						arg_519_1:RecordAudio("115261127", var_522_22)
						arg_519_1:RecordAudio("115261127", var_522_22)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_115261", "115261127", "story_v_out_115261.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_115261", "115261127", "story_v_out_115261.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_23 = math.max(var_522_16, arg_519_1.talkMaxDuration)

			if var_522_15 <= arg_519_1.time_ and arg_519_1.time_ < var_522_15 + var_522_23 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_15) / var_522_23

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_15 + var_522_23 and arg_519_1.time_ < var_522_15 + var_522_23 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play115261128 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 115261128
		arg_523_1.duration_ = 11.2

		local var_523_0 = {
			ja = 9.833,
			ko = 9.133,
			zh = 9.6,
			en = 11.2
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play115261129(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 1

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_1 = arg_523_1:GetWordFromCfg(115261128)
				local var_526_2 = arg_523_1:FormatText(var_526_1.content)

				arg_523_1.text_.text = var_526_2

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_4 = 40 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_2) / 40)

				if (40 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_2) / 40)) > 0 and var_526_0 < var_526_4 then
					arg_523_1.talkMaxDuration = var_526_4

					if var_526_4 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_4 + 0
					end
				end

				arg_523_1.text_.text = var_526_2
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261128", "story_v_out_115261.awb") ~= 0 then
					local var_526_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261128", "story_v_out_115261.awb") / 1000

					if var_526_5 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_5 + 0
					end

					if var_526_1.prefab_name ~= "" and arg_523_1.actors_[var_526_1.prefab_name] ~= nil then
						local var_526_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_1.prefab_name].transform, "story_v_out_115261", "115261128", "story_v_out_115261.awb")

						arg_523_1:RecordAudio("115261128", var_526_6)
						arg_523_1:RecordAudio("115261128", var_526_6)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_115261", "115261128", "story_v_out_115261.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_115261", "115261128", "story_v_out_115261.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_7 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_7 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_7

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_7 and arg_523_1.time_ < 0 + var_526_7 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play115261129 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 115261129
		arg_527_1.duration_ = 3.37

		local var_527_0 = {
			ja = 3.3,
			ko = 3.033,
			zh = 3.366,
			en = 2
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play115261130(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(arg_527_1.actors_["10030"]) and arg_527_1.var_.actorSpriteComps10030 == nil then
				arg_527_1.var_.actorSpriteComps10030 = arg_527_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_530_0 = 0.2

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 and not isNil(arg_527_1.actors_["10030"]) then
				if arg_527_1.var_.actorSpriteComps10030 then
					for iter_530_0, iter_530_1 in pairs(arg_527_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_530_1 then
							if arg_527_1.isInRecall_ then
								iter_530_1.color = Color.New(Mathf.Lerp(iter_530_1.color.r, arg_527_1.hightColor1.r, (arg_527_1.time_ - 0) / var_530_0), Mathf.Lerp(iter_530_1.color.g, arg_527_1.hightColor1.g, (arg_527_1.time_ - 0) / var_530_0), (Mathf.Lerp(iter_530_1.color.b, arg_527_1.hightColor1.b, (arg_527_1.time_ - 0) / var_530_0)))
							else
								local var_530_1 = Mathf.Lerp(iter_530_1.color.r, 1, (arg_527_1.time_ - 0) / var_530_0)

								iter_530_1.color = Color.New(var_530_1, var_530_1, var_530_1)
							end
						end
					end
				end
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 and not isNil(arg_527_1.actors_["10030"]) and arg_527_1.var_.actorSpriteComps10030 then
				for iter_530_2, iter_530_3 in pairs(arg_527_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_530_3 then
						iter_530_3.color = arg_527_1.isInRecall_ and (arg_527_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_527_1.var_.actorSpriteComps10030 = nil
			end

			local var_530_2 = arg_527_1.actors_["10029"]

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(var_530_2) then
				local var_530_3 = var_530_2:GetComponent("Image")

				if var_530_3 then
					arg_527_1.var_.highlightMatValue10029 = var_530_3
				end
			end

			local var_530_4 = 0.2

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_4 and not isNil(var_530_2) then
				if arg_527_1.var_.highlightMatValue10029 then
					local var_530_5 = Mathf.Lerp(1, 0.5, (arg_527_1.time_ - 0) / var_530_4)

					arg_527_1.var_.highlightMatValue10029.color.r = var_530_5
					arg_527_1.var_.highlightMatValue10029.color.g = var_530_5
					arg_527_1.var_.highlightMatValue10029.color.b = var_530_5
					arg_527_1.var_.highlightMatValue10029.color = arg_527_1.var_.highlightMatValue10029.color
				end
			end

			if arg_527_1.time_ >= 0 + var_530_4 and arg_527_1.time_ < 0 + var_530_4 + arg_530_0 and not isNil(var_530_2) and arg_527_1.var_.highlightMatValue10029 then
				arg_527_1.var_.highlightMatValue10029.color.r = 0.5
				arg_527_1.var_.highlightMatValue10029.color.g = 0.5
				arg_527_1.var_.highlightMatValue10029.color.b = 0.5
				arg_527_1.var_.highlightMatValue10029.color = arg_527_1.var_.highlightMatValue10029.color
			end

			local var_530_6 = arg_527_1.actors_["10030"].transform

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.moveOldPos10030 = var_530_6.localPosition
				var_530_6.localScale = Vector3.New(1, 1, 1)

				arg_527_1:CheckSpriteTmpPos("10030", 4)

				for iter_530_4 = 0, var_530_6.childCount - 1 do
					local var_530_7 = var_530_6:GetChild(iter_530_4)

					if var_530_7.name == "split_1" or not string.find(var_530_7.name, "split") then
						var_530_7.gameObject:SetActive(true)
					else
						var_530_7.gameObject:SetActive(false)
					end
				end
			end

			local var_530_8 = 0.001

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_8 then
				var_530_6.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_527_1.time_ - 0) / var_530_8)
			end

			if arg_527_1.time_ >= 0 + var_530_8 and arg_527_1.time_ < 0 + var_530_8 + arg_530_0 then
				var_530_6.localPosition = Vector3.New(390, -390, 150)
			end

			local var_530_9 = 0
			local var_530_10 = 0.2

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_9 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_11 = arg_527_1:GetWordFromCfg(115261129)
				local var_530_12 = arg_527_1:FormatText(var_530_11.content)

				arg_527_1.text_.text = var_530_12

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_14 = 8 <= 0 and var_530_10 or var_530_10 * (utf8.len(var_530_12) / 8)

				if (8 <= 0 and var_530_10 or var_530_10 * (utf8.len(var_530_12) / 8)) > 0 and var_530_10 < var_530_14 then
					arg_527_1.talkMaxDuration = var_530_14

					if var_530_14 + var_530_9 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_14 + var_530_9
					end
				end

				arg_527_1.text_.text = var_530_12
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261129", "story_v_out_115261.awb") ~= 0 then
					local var_530_15 = manager.audio:GetVoiceLength("story_v_out_115261", "115261129", "story_v_out_115261.awb") / 1000

					if var_530_15 + var_530_9 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_15 + var_530_9
					end

					if var_530_11.prefab_name ~= "" and arg_527_1.actors_[var_530_11.prefab_name] ~= nil then
						local var_530_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_11.prefab_name].transform, "story_v_out_115261", "115261129", "story_v_out_115261.awb")

						arg_527_1:RecordAudio("115261129", var_530_16)
						arg_527_1:RecordAudio("115261129", var_530_16)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_115261", "115261129", "story_v_out_115261.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_115261", "115261129", "story_v_out_115261.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_17 = math.max(var_530_10, arg_527_1.talkMaxDuration)

			if var_530_9 <= arg_527_1.time_ and arg_527_1.time_ < var_530_9 + var_530_17 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_9) / var_530_17

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_9 + var_530_17 and arg_527_1.time_ < var_530_9 + var_530_17 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_527_1:InitPlayNodeList()
	end,
	Play115261130 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 115261130
		arg_531_1.duration_ = 12.97

		local var_531_0 = {
			ja = 12.966,
			ko = 12.733,
			zh = 10.766,
			en = 12.533
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play115261131(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(arg_531_1.actors_["10030"]) and arg_531_1.var_.actorSpriteComps10030 == nil then
				arg_531_1.var_.actorSpriteComps10030 = arg_531_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_534_0 = 0.2

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 and not isNil(arg_531_1.actors_["10030"]) then
				if arg_531_1.var_.actorSpriteComps10030 then
					for iter_534_0, iter_534_1 in pairs(arg_531_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_534_1 then
							if arg_531_1.isInRecall_ then
								iter_534_1.color = Color.New(Mathf.Lerp(iter_534_1.color.r, arg_531_1.hightColor2.r, (arg_531_1.time_ - 0) / var_534_0), Mathf.Lerp(iter_534_1.color.g, arg_531_1.hightColor2.g, (arg_531_1.time_ - 0) / var_534_0), (Mathf.Lerp(iter_534_1.color.b, arg_531_1.hightColor2.b, (arg_531_1.time_ - 0) / var_534_0)))
							else
								local var_534_1 = Mathf.Lerp(iter_534_1.color.r, 0.5, (arg_531_1.time_ - 0) / var_534_0)

								iter_534_1.color = Color.New(var_534_1, var_534_1, var_534_1)
							end
						end
					end
				end
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 and not isNil(arg_531_1.actors_["10030"]) and arg_531_1.var_.actorSpriteComps10030 then
				for iter_534_2, iter_534_3 in pairs(arg_531_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_534_3 then
						iter_534_3.color = arg_531_1.isInRecall_ and (arg_531_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_531_1.var_.actorSpriteComps10030 = nil
			end

			local var_534_2 = arg_531_1.actors_["10029"]

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(var_534_2) then
				local var_534_3 = var_534_2:GetComponent("Image")

				if var_534_3 then
					arg_531_1.var_.highlightMatValue10029 = var_534_3
				end
			end

			local var_534_4 = 0.2

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_4 and not isNil(var_534_2) then
				if arg_531_1.var_.highlightMatValue10029 then
					local var_534_5 = Mathf.Lerp(0.5, 1, (arg_531_1.time_ - 0) / var_534_4)

					arg_531_1.var_.highlightMatValue10029.color.r = var_534_5
					arg_531_1.var_.highlightMatValue10029.color.g = var_534_5
					arg_531_1.var_.highlightMatValue10029.color.b = var_534_5
					arg_531_1.var_.highlightMatValue10029.color = arg_531_1.var_.highlightMatValue10029.color
				end
			end

			if arg_531_1.time_ >= 0 + var_534_4 and arg_531_1.time_ < 0 + var_534_4 + arg_534_0 and not isNil(var_534_2) and arg_531_1.var_.highlightMatValue10029 then
				var_534_2.transform:SetSiblingIndex(1)

				arg_531_1.var_.highlightMatValue10029.color.r = 1
				arg_531_1.var_.highlightMatValue10029.color.g = 1
				arg_531_1.var_.highlightMatValue10029.color.b = 1
				arg_531_1.var_.highlightMatValue10029.color = arg_531_1.var_.highlightMatValue10029.color
			end

			local var_534_6 = 0
			local var_534_7 = 1.15

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_6 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_8 = arg_531_1:GetWordFromCfg(115261130)
				local var_534_9 = arg_531_1:FormatText(var_534_8.content)

				arg_531_1.text_.text = var_534_9

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_11 = 46 <= 0 and var_534_7 or var_534_7 * (utf8.len(var_534_9) / 46)

				if (46 <= 0 and var_534_7 or var_534_7 * (utf8.len(var_534_9) / 46)) > 0 and var_534_7 < var_534_11 then
					arg_531_1.talkMaxDuration = var_534_11

					if var_534_11 + var_534_6 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_11 + var_534_6
					end
				end

				arg_531_1.text_.text = var_534_9
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261130", "story_v_out_115261.awb") ~= 0 then
					local var_534_12 = manager.audio:GetVoiceLength("story_v_out_115261", "115261130", "story_v_out_115261.awb") / 1000

					if var_534_12 + var_534_6 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_12 + var_534_6
					end

					if var_534_8.prefab_name ~= "" and arg_531_1.actors_[var_534_8.prefab_name] ~= nil then
						local var_534_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_8.prefab_name].transform, "story_v_out_115261", "115261130", "story_v_out_115261.awb")

						arg_531_1:RecordAudio("115261130", var_534_13)
						arg_531_1:RecordAudio("115261130", var_534_13)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_115261", "115261130", "story_v_out_115261.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_115261", "115261130", "story_v_out_115261.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_14 = math.max(var_534_7, arg_531_1.talkMaxDuration)

			if var_534_6 <= arg_531_1.time_ and arg_531_1.time_ < var_534_6 + var_534_14 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_6) / var_534_14

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_6 + var_534_14 and arg_531_1.time_ < var_534_6 + var_534_14 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play115261131 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 115261131
		arg_535_1.duration_ = 3.5

		local var_535_0 = {
			ja = 3.5,
			ko = 2.966,
			zh = 2.366,
			en = 3.333
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play115261132(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(arg_535_1.actors_["10030"]) and arg_535_1.var_.actorSpriteComps10030 == nil then
				arg_535_1.var_.actorSpriteComps10030 = arg_535_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_538_0 = 0.2

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 and not isNil(arg_535_1.actors_["10030"]) then
				if arg_535_1.var_.actorSpriteComps10030 then
					for iter_538_0, iter_538_1 in pairs(arg_535_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_538_1 then
							if arg_535_1.isInRecall_ then
								iter_538_1.color = Color.New(Mathf.Lerp(iter_538_1.color.r, arg_535_1.hightColor1.r, (arg_535_1.time_ - 0) / var_538_0), Mathf.Lerp(iter_538_1.color.g, arg_535_1.hightColor1.g, (arg_535_1.time_ - 0) / var_538_0), (Mathf.Lerp(iter_538_1.color.b, arg_535_1.hightColor1.b, (arg_535_1.time_ - 0) / var_538_0)))
							else
								local var_538_1 = Mathf.Lerp(iter_538_1.color.r, 1, (arg_535_1.time_ - 0) / var_538_0)

								iter_538_1.color = Color.New(var_538_1, var_538_1, var_538_1)
							end
						end
					end
				end
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 and not isNil(arg_535_1.actors_["10030"]) and arg_535_1.var_.actorSpriteComps10030 then
				for iter_538_2, iter_538_3 in pairs(arg_535_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_538_3 then
						iter_538_3.color = arg_535_1.isInRecall_ and (arg_535_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_535_1.var_.actorSpriteComps10030 = nil
			end

			local var_538_2 = arg_535_1.actors_["10029"]

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(var_538_2) then
				local var_538_3 = var_538_2:GetComponent("Image")

				if var_538_3 then
					arg_535_1.var_.highlightMatValue10029 = var_538_3
				end
			end

			local var_538_4 = 0.2

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_4 and not isNil(var_538_2) then
				if arg_535_1.var_.highlightMatValue10029 then
					local var_538_5 = Mathf.Lerp(1, 0.5, (arg_535_1.time_ - 0) / var_538_4)

					arg_535_1.var_.highlightMatValue10029.color.r = var_538_5
					arg_535_1.var_.highlightMatValue10029.color.g = var_538_5
					arg_535_1.var_.highlightMatValue10029.color.b = var_538_5
					arg_535_1.var_.highlightMatValue10029.color = arg_535_1.var_.highlightMatValue10029.color
				end
			end

			if arg_535_1.time_ >= 0 + var_538_4 and arg_535_1.time_ < 0 + var_538_4 + arg_538_0 and not isNil(var_538_2) and arg_535_1.var_.highlightMatValue10029 then
				arg_535_1.var_.highlightMatValue10029.color.r = 0.5
				arg_535_1.var_.highlightMatValue10029.color.g = 0.5
				arg_535_1.var_.highlightMatValue10029.color.b = 0.5
				arg_535_1.var_.highlightMatValue10029.color = arg_535_1.var_.highlightMatValue10029.color
			end

			local var_538_6 = arg_535_1.actors_["10030"].transform

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.var_.moveOldPos10030 = var_538_6.localPosition
				var_538_6.localScale = Vector3.New(1, 1, 1)

				arg_535_1:CheckSpriteTmpPos("10030", 4)

				for iter_538_4 = 0, var_538_6.childCount - 1 do
					local var_538_7 = var_538_6:GetChild(iter_538_4)

					if var_538_7.name == "split_3" or not string.find(var_538_7.name, "split") then
						var_538_7.gameObject:SetActive(true)
					else
						var_538_7.gameObject:SetActive(false)
					end
				end
			end

			local var_538_8 = 0.001

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_8 then
				var_538_6.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_535_1.time_ - 0) / var_538_8)
			end

			if arg_535_1.time_ >= 0 + var_538_8 and arg_535_1.time_ < 0 + var_538_8 + arg_538_0 then
				var_538_6.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				local var_538_9 = arg_535_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_538_9 then
					arg_535_1.var_.alphaOldValue10030 = var_538_9.alpha
					arg_535_1.var_.characterEffect10030 = var_538_9
				end

				arg_535_1.var_.alphaOldValue10030 = 0
			end

			local var_538_10 = 0.0166666666666667

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_10 then
				if arg_535_1.var_.characterEffect10030 then
					arg_535_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_535_1.var_.alphaOldValue10030, 1, (arg_535_1.time_ - 0) / var_538_10)
				end
			end

			if arg_535_1.time_ >= 0 + var_538_10 and arg_535_1.time_ < 0 + var_538_10 + arg_538_0 and arg_535_1.var_.characterEffect10030 then
				arg_535_1.var_.characterEffect10030.alpha = 1
			end

			local var_538_11 = 0
			local var_538_12 = 0.2

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_11 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_13 = arg_535_1:GetWordFromCfg(115261131)
				local var_538_14 = arg_535_1:FormatText(var_538_13.content)

				arg_535_1.text_.text = var_538_14

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_16 = 8 <= 0 and var_538_12 or var_538_12 * (utf8.len(var_538_14) / 8)

				if (8 <= 0 and var_538_12 or var_538_12 * (utf8.len(var_538_14) / 8)) > 0 and var_538_12 < var_538_16 then
					arg_535_1.talkMaxDuration = var_538_16

					if var_538_16 + var_538_11 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_16 + var_538_11
					end
				end

				arg_535_1.text_.text = var_538_14
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261131", "story_v_out_115261.awb") ~= 0 then
					local var_538_17 = manager.audio:GetVoiceLength("story_v_out_115261", "115261131", "story_v_out_115261.awb") / 1000

					if var_538_17 + var_538_11 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_17 + var_538_11
					end

					if var_538_13.prefab_name ~= "" and arg_535_1.actors_[var_538_13.prefab_name] ~= nil then
						local var_538_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_13.prefab_name].transform, "story_v_out_115261", "115261131", "story_v_out_115261.awb")

						arg_535_1:RecordAudio("115261131", var_538_18)
						arg_535_1:RecordAudio("115261131", var_538_18)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_115261", "115261131", "story_v_out_115261.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_115261", "115261131", "story_v_out_115261.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_19 = math.max(var_538_12, arg_535_1.talkMaxDuration)

			if var_538_11 <= arg_535_1.time_ and arg_535_1.time_ < var_538_11 + var_538_19 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_11) / var_538_19

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_11 + var_538_19 and arg_535_1.time_ < var_538_11 + var_538_19 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play115261132 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 115261132
		arg_539_1.duration_ = 7.67

		local var_539_0 = {
			ja = 6,
			ko = 6.7,
			zh = 7.1,
			en = 7.666
		}
		local var_539_1 = manager.audio:GetLocalizationFlag()

		if var_539_0[var_539_1] ~= nil then
			arg_539_1.duration_ = var_539_0[var_539_1]
		end

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play115261133(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(arg_539_1.actors_["10030"]) and arg_539_1.var_.actorSpriteComps10030 == nil then
				arg_539_1.var_.actorSpriteComps10030 = arg_539_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_542_0 = 0.2

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 and not isNil(arg_539_1.actors_["10030"]) then
				if arg_539_1.var_.actorSpriteComps10030 then
					for iter_542_0, iter_542_1 in pairs(arg_539_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_542_1 then
							if arg_539_1.isInRecall_ then
								iter_542_1.color = Color.New(Mathf.Lerp(iter_542_1.color.r, arg_539_1.hightColor2.r, (arg_539_1.time_ - 0) / var_542_0), Mathf.Lerp(iter_542_1.color.g, arg_539_1.hightColor2.g, (arg_539_1.time_ - 0) / var_542_0), (Mathf.Lerp(iter_542_1.color.b, arg_539_1.hightColor2.b, (arg_539_1.time_ - 0) / var_542_0)))
							else
								local var_542_1 = Mathf.Lerp(iter_542_1.color.r, 0.5, (arg_539_1.time_ - 0) / var_542_0)

								iter_542_1.color = Color.New(var_542_1, var_542_1, var_542_1)
							end
						end
					end
				end
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 and not isNil(arg_539_1.actors_["10030"]) and arg_539_1.var_.actorSpriteComps10030 then
				for iter_542_2, iter_542_3 in pairs(arg_539_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_542_3 then
						iter_542_3.color = arg_539_1.isInRecall_ and (arg_539_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_539_1.var_.actorSpriteComps10030 = nil
			end

			local var_542_2 = arg_539_1.actors_["10029"]

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(var_542_2) then
				local var_542_3 = var_542_2:GetComponent("Image")

				if var_542_3 then
					arg_539_1.var_.highlightMatValue10029 = var_542_3
				end
			end

			local var_542_4 = 0.2

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_4 and not isNil(var_542_2) then
				if arg_539_1.var_.highlightMatValue10029 then
					local var_542_5 = Mathf.Lerp(0.5, 1, (arg_539_1.time_ - 0) / var_542_4)

					arg_539_1.var_.highlightMatValue10029.color.r = var_542_5
					arg_539_1.var_.highlightMatValue10029.color.g = var_542_5
					arg_539_1.var_.highlightMatValue10029.color.b = var_542_5
					arg_539_1.var_.highlightMatValue10029.color = arg_539_1.var_.highlightMatValue10029.color
				end
			end

			if arg_539_1.time_ >= 0 + var_542_4 and arg_539_1.time_ < 0 + var_542_4 + arg_542_0 and not isNil(var_542_2) and arg_539_1.var_.highlightMatValue10029 then
				var_542_2.transform:SetSiblingIndex(1)

				arg_539_1.var_.highlightMatValue10029.color.r = 1
				arg_539_1.var_.highlightMatValue10029.color.g = 1
				arg_539_1.var_.highlightMatValue10029.color.b = 1
				arg_539_1.var_.highlightMatValue10029.color = arg_539_1.var_.highlightMatValue10029.color
			end

			local var_542_6 = 0
			local var_542_7 = 0.625

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_6 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_8 = arg_539_1:GetWordFromCfg(115261132)
				local var_542_9 = arg_539_1:FormatText(var_542_8.content)

				arg_539_1.text_.text = var_542_9

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_11 = 29 <= 0 and var_542_7 or var_542_7 * (utf8.len(var_542_9) / 29)

				if (29 <= 0 and var_542_7 or var_542_7 * (utf8.len(var_542_9) / 29)) > 0 and var_542_7 < var_542_11 then
					arg_539_1.talkMaxDuration = var_542_11

					if var_542_11 + var_542_6 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_11 + var_542_6
					end
				end

				arg_539_1.text_.text = var_542_9
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261132", "story_v_out_115261.awb") ~= 0 then
					local var_542_12 = manager.audio:GetVoiceLength("story_v_out_115261", "115261132", "story_v_out_115261.awb") / 1000

					if var_542_12 + var_542_6 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_12 + var_542_6
					end

					if var_542_8.prefab_name ~= "" and arg_539_1.actors_[var_542_8.prefab_name] ~= nil then
						local var_542_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_8.prefab_name].transform, "story_v_out_115261", "115261132", "story_v_out_115261.awb")

						arg_539_1:RecordAudio("115261132", var_542_13)
						arg_539_1:RecordAudio("115261132", var_542_13)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_115261", "115261132", "story_v_out_115261.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_115261", "115261132", "story_v_out_115261.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_14 = math.max(var_542_7, arg_539_1.talkMaxDuration)

			if var_542_6 <= arg_539_1.time_ and arg_539_1.time_ < var_542_6 + var_542_14 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_6) / var_542_14

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_6 + var_542_14 and arg_539_1.time_ < var_542_6 + var_542_14 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play115261133 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 115261133
		arg_543_1.duration_ = 17.3

		local var_543_0 = {
			ja = 10.9,
			ko = 16.4,
			zh = 12.533,
			en = 17.3
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play115261134(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 1.4

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_1 = arg_543_1:GetWordFromCfg(115261133)
				local var_546_2 = arg_543_1:FormatText(var_546_1.content)

				arg_543_1.text_.text = var_546_2

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_4 = 56 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_2) / 56)

				if (56 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_2) / 56)) > 0 and var_546_0 < var_546_4 then
					arg_543_1.talkMaxDuration = var_546_4

					if var_546_4 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_4 + 0
					end
				end

				arg_543_1.text_.text = var_546_2
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261133", "story_v_out_115261.awb") ~= 0 then
					local var_546_5 = manager.audio:GetVoiceLength("story_v_out_115261", "115261133", "story_v_out_115261.awb") / 1000

					if var_546_5 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_5 + 0
					end

					if var_546_1.prefab_name ~= "" and arg_543_1.actors_[var_546_1.prefab_name] ~= nil then
						local var_546_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_1.prefab_name].transform, "story_v_out_115261", "115261133", "story_v_out_115261.awb")

						arg_543_1:RecordAudio("115261133", var_546_6)
						arg_543_1:RecordAudio("115261133", var_546_6)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_115261", "115261133", "story_v_out_115261.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_115261", "115261133", "story_v_out_115261.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_7 = math.max(var_546_0, arg_543_1.talkMaxDuration)

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_7 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - 0) / var_546_7

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= 0 + var_546_7 and arg_543_1.time_ < 0 + var_546_7 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play115261134 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 115261134
		arg_547_1.duration_ = 6.53

		local var_547_0 = {
			ja = 6.533,
			ko = 6.533,
			zh = 5.166,
			en = 5.633
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play115261135(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(arg_547_1.actors_["10030"]) and arg_547_1.var_.actorSpriteComps10030 == nil then
				arg_547_1.var_.actorSpriteComps10030 = arg_547_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_550_0 = 0.2

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 and not isNil(arg_547_1.actors_["10030"]) then
				if arg_547_1.var_.actorSpriteComps10030 then
					for iter_550_0, iter_550_1 in pairs(arg_547_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_550_1 then
							if arg_547_1.isInRecall_ then
								iter_550_1.color = Color.New(Mathf.Lerp(iter_550_1.color.r, arg_547_1.hightColor1.r, (arg_547_1.time_ - 0) / var_550_0), Mathf.Lerp(iter_550_1.color.g, arg_547_1.hightColor1.g, (arg_547_1.time_ - 0) / var_550_0), (Mathf.Lerp(iter_550_1.color.b, arg_547_1.hightColor1.b, (arg_547_1.time_ - 0) / var_550_0)))
							else
								local var_550_1 = Mathf.Lerp(iter_550_1.color.r, 1, (arg_547_1.time_ - 0) / var_550_0)

								iter_550_1.color = Color.New(var_550_1, var_550_1, var_550_1)
							end
						end
					end
				end
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 and not isNil(arg_547_1.actors_["10030"]) and arg_547_1.var_.actorSpriteComps10030 then
				for iter_550_2, iter_550_3 in pairs(arg_547_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_550_3 then
						iter_550_3.color = arg_547_1.isInRecall_ and (arg_547_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_547_1.var_.actorSpriteComps10030 = nil
			end

			local var_550_2 = arg_547_1.actors_["10029"]

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(var_550_2) then
				local var_550_3 = var_550_2:GetComponent("Image")

				if var_550_3 then
					arg_547_1.var_.highlightMatValue10029 = var_550_3
				end
			end

			local var_550_4 = 0.2

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_4 and not isNil(var_550_2) then
				if arg_547_1.var_.highlightMatValue10029 then
					local var_550_5 = Mathf.Lerp(1, 0.5, (arg_547_1.time_ - 0) / var_550_4)

					arg_547_1.var_.highlightMatValue10029.color.r = var_550_5
					arg_547_1.var_.highlightMatValue10029.color.g = var_550_5
					arg_547_1.var_.highlightMatValue10029.color.b = var_550_5
					arg_547_1.var_.highlightMatValue10029.color = arg_547_1.var_.highlightMatValue10029.color
				end
			end

			if arg_547_1.time_ >= 0 + var_550_4 and arg_547_1.time_ < 0 + var_550_4 + arg_550_0 and not isNil(var_550_2) and arg_547_1.var_.highlightMatValue10029 then
				arg_547_1.var_.highlightMatValue10029.color.r = 0.5
				arg_547_1.var_.highlightMatValue10029.color.g = 0.5
				arg_547_1.var_.highlightMatValue10029.color.b = 0.5
				arg_547_1.var_.highlightMatValue10029.color = arg_547_1.var_.highlightMatValue10029.color
			end

			local var_550_6 = arg_547_1.actors_["10030"].transform

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.var_.moveOldPos10030 = var_550_6.localPosition
				var_550_6.localScale = Vector3.New(1, 1, 1)

				arg_547_1:CheckSpriteTmpPos("10030", 4)

				for iter_550_4 = 0, var_550_6.childCount - 1 do
					local var_550_7 = var_550_6:GetChild(iter_550_4)

					if var_550_7.name == "split_1" or not string.find(var_550_7.name, "split") then
						var_550_7.gameObject:SetActive(true)
					else
						var_550_7.gameObject:SetActive(false)
					end
				end
			end

			local var_550_8 = 0.001

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_8 then
				var_550_6.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_547_1.time_ - 0) / var_550_8)
			end

			if arg_547_1.time_ >= 0 + var_550_8 and arg_547_1.time_ < 0 + var_550_8 + arg_550_0 then
				var_550_6.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				local var_550_9 = arg_547_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_550_9 then
					arg_547_1.var_.alphaOldValue10030 = var_550_9.alpha
					arg_547_1.var_.characterEffect10030 = var_550_9
				end

				arg_547_1.var_.alphaOldValue10030 = 0
			end

			local var_550_10 = 0.0166666666666667

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_10 then
				if arg_547_1.var_.characterEffect10030 then
					arg_547_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_547_1.var_.alphaOldValue10030, 1, (arg_547_1.time_ - 0) / var_550_10)
				end
			end

			if arg_547_1.time_ >= 0 + var_550_10 and arg_547_1.time_ < 0 + var_550_10 + arg_550_0 and arg_547_1.var_.characterEffect10030 then
				arg_547_1.var_.characterEffect10030.alpha = 1
			end

			local var_550_11 = 0
			local var_550_12 = 0.5

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_11 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_13 = arg_547_1:GetWordFromCfg(115261134)
				local var_550_14 = arg_547_1:FormatText(var_550_13.content)

				arg_547_1.text_.text = var_550_14

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_16 = 20 <= 0 and var_550_12 or var_550_12 * (utf8.len(var_550_14) / 20)

				if (20 <= 0 and var_550_12 or var_550_12 * (utf8.len(var_550_14) / 20)) > 0 and var_550_12 < var_550_16 then
					arg_547_1.talkMaxDuration = var_550_16

					if var_550_16 + var_550_11 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_16 + var_550_11
					end
				end

				arg_547_1.text_.text = var_550_14
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261134", "story_v_out_115261.awb") ~= 0 then
					local var_550_17 = manager.audio:GetVoiceLength("story_v_out_115261", "115261134", "story_v_out_115261.awb") / 1000

					if var_550_17 + var_550_11 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_17 + var_550_11
					end

					if var_550_13.prefab_name ~= "" and arg_547_1.actors_[var_550_13.prefab_name] ~= nil then
						local var_550_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_13.prefab_name].transform, "story_v_out_115261", "115261134", "story_v_out_115261.awb")

						arg_547_1:RecordAudio("115261134", var_550_18)
						arg_547_1:RecordAudio("115261134", var_550_18)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_out_115261", "115261134", "story_v_out_115261.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_out_115261", "115261134", "story_v_out_115261.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_19 = math.max(var_550_12, arg_547_1.talkMaxDuration)

			if var_550_11 <= arg_547_1.time_ and arg_547_1.time_ < var_550_11 + var_550_19 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_11) / var_550_19

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_11 + var_550_19 and arg_547_1.time_ < var_550_11 + var_550_19 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	Play115261135 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 115261135
		arg_551_1.duration_ = 2.67

		local var_551_0 = {
			ja = 2.666,
			ko = 1.633,
			zh = 2,
			en = 2.533
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play115261136(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.var_.moveOldPos10030 = arg_551_1.actors_["10030"].transform.localPosition
				arg_551_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_551_1:CheckSpriteTmpPos("10030", 4)

				for iter_554_0 = 0, arg_551_1.actors_["10030"].transform.childCount - 1 do
					local var_554_0 = arg_551_1.actors_["10030"].transform:GetChild(iter_554_0)

					if var_554_0.name == "split_5" or not string.find(var_554_0.name, "split") then
						var_554_0.gameObject:SetActive(true)
					else
						var_554_0.gameObject:SetActive(false)
					end
				end
			end

			local var_554_1 = 0.001

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_1 then
				arg_551_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_551_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_551_1.time_ - 0) / var_554_1)
			end

			if arg_551_1.time_ >= 0 + var_554_1 and arg_551_1.time_ < 0 + var_554_1 + arg_554_0 then
				arg_551_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_554_2 = 0
			local var_554_3 = 0.15

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_2 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_4 = arg_551_1:GetWordFromCfg(115261135)
				local var_554_5 = arg_551_1:FormatText(var_554_4.content)

				arg_551_1.text_.text = var_554_5

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_7 = 6 <= 0 and var_554_3 or var_554_3 * (utf8.len(var_554_5) / 6)

				if (6 <= 0 and var_554_3 or var_554_3 * (utf8.len(var_554_5) / 6)) > 0 and var_554_3 < var_554_7 then
					arg_551_1.talkMaxDuration = var_554_7

					if var_554_7 + var_554_2 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_7 + var_554_2
					end
				end

				arg_551_1.text_.text = var_554_5
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115261", "115261135", "story_v_out_115261.awb") ~= 0 then
					local var_554_8 = manager.audio:GetVoiceLength("story_v_out_115261", "115261135", "story_v_out_115261.awb") / 1000

					if var_554_8 + var_554_2 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_8 + var_554_2
					end

					if var_554_4.prefab_name ~= "" and arg_551_1.actors_[var_554_4.prefab_name] ~= nil then
						local var_554_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_4.prefab_name].transform, "story_v_out_115261", "115261135", "story_v_out_115261.awb")

						arg_551_1:RecordAudio("115261135", var_554_9)
						arg_551_1:RecordAudio("115261135", var_554_9)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_115261", "115261135", "story_v_out_115261.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_115261", "115261135", "story_v_out_115261.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_10 = math.max(var_554_3, arg_551_1.talkMaxDuration)

			if var_554_2 <= arg_551_1.time_ and arg_551_1.time_ < var_554_2 + var_554_10 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_2) / var_554_10

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_2 + var_554_10 and arg_551_1.time_ < var_554_2 + var_554_10 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_551_1:InitPlayNodeList()
	end,
	Play115261136 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 115261136
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
			arg_555_1.auto_ = false
		end

		function arg_555_1.playNext_(arg_557_0)
			arg_555_1.onStoryFinished_()
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				local var_558_0 = arg_555_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_558_0 then
					arg_555_1.var_.alphaOldValue10030 = var_558_0.alpha
					arg_555_1.var_.characterEffect10030 = var_558_0
				end

				arg_555_1.var_.alphaOldValue10030 = 1
			end

			local var_558_1 = 0.333333333333333

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_1 then
				if arg_555_1.var_.characterEffect10030 then
					arg_555_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_555_1.var_.alphaOldValue10030, 0, (arg_555_1.time_ - 0) / var_558_1)
				end
			end

			if arg_555_1.time_ >= 0 + var_558_1 and arg_555_1.time_ < 0 + var_558_1 + arg_558_0 and arg_555_1.var_.characterEffect10030 then
				arg_555_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				local var_558_2 = arg_555_1.actors_["10029"]:GetComponent("Image")

				if var_558_2 then
					arg_555_1.var_.alphaMatValue10029 = var_558_2
					arg_555_1.var_.alphaOldValue10029 = var_558_2.color.a
				end

				arg_555_1.var_.alphaOldValue10029 = 1
			end

			local var_558_3 = 0.333333333333333

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_3 then
				if arg_555_1.var_.alphaMatValue10029 then
					arg_555_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_555_1.var_.alphaOldValue10029, 0, (arg_555_1.time_ - 0) / var_558_3)
					arg_555_1.var_.alphaMatValue10029.color = arg_555_1.var_.alphaMatValue10029.color
				end
			end

			if arg_555_1.time_ >= 0 + var_558_3 and arg_555_1.time_ < 0 + var_558_3 + arg_558_0 and arg_555_1.var_.alphaMatValue10029 then
				arg_555_1.var_.alphaMatValue10029.color.a = 0
				arg_555_1.var_.alphaMatValue10029.color = arg_555_1.var_.alphaMatValue10029.color
			end

			local var_558_4 = 0
			local var_558_5 = 0.825

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_4 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_6 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(115261136).content)

				arg_555_1.text_.text = var_558_6

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_8 = 33 <= 0 and var_558_5 or var_558_5 * (utf8.len(var_558_6) / 33)

				if (33 <= 0 and var_558_5 or var_558_5 * (utf8.len(var_558_6) / 33)) > 0 and var_558_5 < var_558_8 then
					arg_555_1.talkMaxDuration = var_558_8

					if var_558_8 + var_558_4 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_8 + var_558_4
					end
				end

				arg_555_1.text_.text = var_558_6
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_9 = math.max(var_558_5, arg_555_1.talkMaxDuration)

			if var_558_4 <= arg_555_1.time_ and arg_555_1.time_ < var_558_4 + var_558_9 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_4) / var_558_9

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_4 + var_558_9 and arg_555_1.time_ < var_558_4 + var_558_9 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST22",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/F01a",
		"TextureConfig/Background/ST27a",
		"TextureConfig/Background/ST22a"
	},
	voices = {
		"story_v_out_115261.awb"
	}
}
