return {
	Play103704001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103704001
		arg_1_1.duration_ = 6.5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play103704002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.S0903 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0903")
				var_4_0.name = "S0903"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.S0903 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_1 = arg_1_1.bgs_.S0903

				arg_1_1.bgs_.S0903.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0903" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.S0903:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueS0903 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueS0903 = var_4_4
				end

				arg_1_1.var_.alphaOldValueS0903 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueS0903 then
					arg_1_1.var_.alphaMatValueS0903.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueS0903, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueS0903.color = arg_1_1.var_.alphaMatValueS0903.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueS0903 then
				arg_1_1.var_.alphaMatValueS0903.color.a = 1
				arg_1_1.var_.alphaMatValueS0903.color = arg_1_1.var_.alphaMatValueS0903.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_8 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_11 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			local var_4_12 = 1.5
			local var_4_13 = 0.35

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_14 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_14:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_15 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(103704001).content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 14 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 14)

				if (14 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 14)) > 0 and var_4_13 < var_4_17 then
					arg_1_1.talkMaxDuration = var_4_17
					var_4_12 = var_4_12 + 0.3

					if var_4_17 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_12
					end
				end

				arg_1_1.text_.text = var_4_15
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_18 = var_4_12 + 0.3
			local var_4_19 = math.max(var_4_13, arg_1_1.talkMaxDuration)

			if var_4_12 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_18) / var_4_19

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play103704002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 103704002
		arg_9_1.duration_ = 2.9

		local var_9_0 = {
			ja = 2.9,
			ko = 1,
			en = 1.2
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
				arg_9_0:Play103704003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.075

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(103704002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 3 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 3)

				if (3 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 3)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704002", "story_v_side_old_103704.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704002", "story_v_side_old_103704.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_side_old_103704", "103704002", "story_v_side_old_103704.awb")

						arg_9_1:RecordAudio("103704002", var_12_6)
						arg_9_1:RecordAudio("103704002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704002", "story_v_side_old_103704.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704002", "story_v_side_old_103704.awb")
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
	Play103704003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 103704003
		arg_13_1.duration_ = 5.73

		local var_13_0 = {
			ja = 5.066,
			ko = 5.2,
			en = 5.733
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
				arg_13_0:Play103704004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.45

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(103704003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 18 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 18)

				if (18 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 18)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704003", "story_v_side_old_103704.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704003", "story_v_side_old_103704.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_side_old_103704", "103704003", "story_v_side_old_103704.awb")

						arg_13_1:RecordAudio("103704003", var_16_6)
						arg_13_1:RecordAudio("103704003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704003", "story_v_side_old_103704.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704003", "story_v_side_old_103704.awb")
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
	Play103704004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 103704004
		arg_17_1.duration_ = 8.57

		local var_17_0 = {
			ja = 8.566,
			ko = 6.2,
			en = 7.5
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
				arg_17_0:Play103704005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.575

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(103704004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 23 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 23)

				if (23 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 23)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704004", "story_v_side_old_103704.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704004", "story_v_side_old_103704.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_side_old_103704", "103704004", "story_v_side_old_103704.awb")

						arg_17_1:RecordAudio("103704004", var_20_6)
						arg_17_1:RecordAudio("103704004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704004", "story_v_side_old_103704.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704004", "story_v_side_old_103704.awb")
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
	Play103704005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 103704005
		arg_21_1.duration_ = 7.27

		local var_21_0 = {
			ja = 4.166,
			ko = 4.233,
			en = 7.266
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
				arg_21_0:Play103704006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.45

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(103704005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 18 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 18)

				if (18 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 18)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704005", "story_v_side_old_103704.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704005", "story_v_side_old_103704.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_side_old_103704", "103704005", "story_v_side_old_103704.awb")

						arg_21_1:RecordAudio("103704005", var_24_6)
						arg_21_1:RecordAudio("103704005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704005", "story_v_side_old_103704.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704005", "story_v_side_old_103704.awb")
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
	Play103704006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 103704006
		arg_25_1.duration_ = 7.23

		local var_25_0 = {
			ja = 7.233,
			ko = 5.233,
			en = 4.466
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
				arg_25_0:Play103704007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.675

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(103704006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 26)

				if (26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 26)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704006", "story_v_side_old_103704.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704006", "story_v_side_old_103704.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_side_old_103704", "103704006", "story_v_side_old_103704.awb")

						arg_25_1:RecordAudio("103704006", var_28_6)
						arg_25_1:RecordAudio("103704006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704006", "story_v_side_old_103704.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704006", "story_v_side_old_103704.awb")
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
	Play103704007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 103704007
		arg_29_1.duration_ = 3.4

		local var_29_0 = {
			ja = 3.4,
			ko = 2.233,
			en = 2.333
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
				arg_29_0:Play103704008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.25

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(103704007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 10 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 10)

				if (10 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 10)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704007", "story_v_side_old_103704.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704007", "story_v_side_old_103704.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_side_old_103704", "103704007", "story_v_side_old_103704.awb")

						arg_29_1:RecordAudio("103704007", var_32_6)
						arg_29_1:RecordAudio("103704007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704007", "story_v_side_old_103704.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704007", "story_v_side_old_103704.awb")
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
	Play103704008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 103704008
		arg_33_1.duration_ = 2.07

		local var_33_0 = {
			ja = 1.033,
			ko = 0.766,
			en = 2.066
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
				arg_33_0:Play103704009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.05

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(103704008)
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704008", "story_v_side_old_103704.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704008", "story_v_side_old_103704.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_side_old_103704", "103704008", "story_v_side_old_103704.awb")

						arg_33_1:RecordAudio("103704008", var_36_6)
						arg_33_1:RecordAudio("103704008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704008", "story_v_side_old_103704.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704008", "story_v_side_old_103704.awb")
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
	Play103704009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 103704009
		arg_37_1.duration_ = 10.33

		local var_37_0 = {
			ja = 10.333,
			ko = 9.4,
			en = 8.1
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
				arg_37_0:Play103704010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.95

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(103704009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 38 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 38)

				if (38 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 38)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704009", "story_v_side_old_103704.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704009", "story_v_side_old_103704.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_side_old_103704", "103704009", "story_v_side_old_103704.awb")

						arg_37_1:RecordAudio("103704009", var_40_6)
						arg_37_1:RecordAudio("103704009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704009", "story_v_side_old_103704.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704009", "story_v_side_old_103704.awb")
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
	Play103704010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 103704010
		arg_41_1.duration_ = 8.73

		local var_41_0 = {
			ja = 8.733,
			ko = 8.2,
			en = 6.9
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
				arg_41_0:Play103704011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.625

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(103704010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 25 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 25)

				if (25 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 25)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704010", "story_v_side_old_103704.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704010", "story_v_side_old_103704.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_side_old_103704", "103704010", "story_v_side_old_103704.awb")

						arg_41_1:RecordAudio("103704010", var_44_6)
						arg_41_1:RecordAudio("103704010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704010", "story_v_side_old_103704.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704010", "story_v_side_old_103704.awb")
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
	Play103704011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 103704011
		arg_45_1.duration_ = 7.03

		local var_45_0 = {
			ja = 7.033,
			ko = 6.2,
			en = 5.166
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
				arg_45_0:Play103704012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.65

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(103704011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 26 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 26)

				if (26 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 26)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704011", "story_v_side_old_103704.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704011", "story_v_side_old_103704.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_side_old_103704", "103704011", "story_v_side_old_103704.awb")

						arg_45_1:RecordAudio("103704011", var_48_6)
						arg_45_1:RecordAudio("103704011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704011", "story_v_side_old_103704.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704011", "story_v_side_old_103704.awb")
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
	Play103704012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 103704012
		arg_49_1.duration_ = 10.67

		local var_49_0 = {
			ja = 10.133,
			ko = 10.666,
			en = 10.266
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
				arg_49_0:Play103704013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(103704012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 40 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 40)

				if (40 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 40)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704012", "story_v_side_old_103704.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704012", "story_v_side_old_103704.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_side_old_103704", "103704012", "story_v_side_old_103704.awb")

						arg_49_1:RecordAudio("103704012", var_52_6)
						arg_49_1:RecordAudio("103704012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704012", "story_v_side_old_103704.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704012", "story_v_side_old_103704.awb")
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
	Play103704013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 103704013
		arg_53_1.duration_ = 5.37

		local var_53_0 = {
			ja = 5.366,
			ko = 4.366,
			en = 2.966
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
				arg_53_0:Play103704014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.35

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(103704013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 14 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 14)

				if (14 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 14)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704013", "story_v_side_old_103704.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704013", "story_v_side_old_103704.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_side_old_103704", "103704013", "story_v_side_old_103704.awb")

						arg_53_1:RecordAudio("103704013", var_56_6)
						arg_53_1:RecordAudio("103704013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704013", "story_v_side_old_103704.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704013", "story_v_side_old_103704.awb")
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
	Play103704014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 103704014
		arg_57_1.duration_ = 11.6

		local var_57_0 = {
			ja = 10.1,
			ko = 7.666,
			en = 11.6
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play103704015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.75

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(103704014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 30 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 30)

				if (30 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 30)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704014", "story_v_side_old_103704.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704014", "story_v_side_old_103704.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_side_old_103704", "103704014", "story_v_side_old_103704.awb")

						arg_57_1:RecordAudio("103704014", var_60_6)
						arg_57_1:RecordAudio("103704014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704014", "story_v_side_old_103704.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704014", "story_v_side_old_103704.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play103704015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 103704015
		arg_61_1.duration_ = 4.07

		local var_61_0 = {
			ja = 2.133,
			ko = 4.066,
			en = 3.1
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
				arg_61_0:Play103704016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.375

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(103704015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 15 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 15)

				if (15 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 15)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704015", "story_v_side_old_103704.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704015", "story_v_side_old_103704.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_side_old_103704", "103704015", "story_v_side_old_103704.awb")

						arg_61_1:RecordAudio("103704015", var_64_6)
						arg_61_1:RecordAudio("103704015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704015", "story_v_side_old_103704.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704015", "story_v_side_old_103704.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play103704016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 103704016
		arg_65_1.duration_ = 11.2

		local var_65_0 = {
			ja = 11.2,
			ko = 10.3,
			en = 9.033
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play103704017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.875

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(103704016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 35 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 35)

				if (35 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 35)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704016", "story_v_side_old_103704.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704016", "story_v_side_old_103704.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_side_old_103704", "103704016", "story_v_side_old_103704.awb")

						arg_65_1:RecordAudio("103704016", var_68_6)
						arg_65_1:RecordAudio("103704016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704016", "story_v_side_old_103704.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704016", "story_v_side_old_103704.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play103704017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 103704017
		arg_69_1.duration_ = 6.9

		local var_69_0 = {
			ja = 5.8,
			ko = 6.9,
			en = 4.5
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play103704018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.45

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:GetWordFromCfg(103704017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 18 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 18)

				if (18 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 18)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704017", "story_v_side_old_103704.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704017", "story_v_side_old_103704.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_side_old_103704", "103704017", "story_v_side_old_103704.awb")

						arg_69_1:RecordAudio("103704017", var_72_6)
						arg_69_1:RecordAudio("103704017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704017", "story_v_side_old_103704.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704017", "story_v_side_old_103704.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play103704018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 103704018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play103704019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.825

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(103704018).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 33 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 33)

				if (33 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 33)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play103704019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 103704019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play103704020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.775

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(103704019).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 31 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 31)

				if (31 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 31)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play103704020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 103704020
		arg_81_1.duration_ = 2.4

		local var_81_0 = {
			ja = 2.4,
			ko = 2.066,
			en = 1.6
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play103704021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.225

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(103704020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 9 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 9)

				if (9 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 9)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704020", "story_v_side_old_103704.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704020", "story_v_side_old_103704.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_side_old_103704", "103704020", "story_v_side_old_103704.awb")

						arg_81_1:RecordAudio("103704020", var_84_6)
						arg_81_1:RecordAudio("103704020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704020", "story_v_side_old_103704.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704020", "story_v_side_old_103704.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play103704021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 103704021
		arg_85_1.duration_ = 4.37

		local var_85_0 = {
			ja = 4.366,
			ko = 1.2,
			en = 1.033
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play103704022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.05

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:GetWordFromCfg(103704021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 2 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 2)

				if (2 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 2)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704021", "story_v_side_old_103704.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704021", "story_v_side_old_103704.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_side_old_103704", "103704021", "story_v_side_old_103704.awb")

						arg_85_1:RecordAudio("103704021", var_88_6)
						arg_85_1:RecordAudio("103704021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704021", "story_v_side_old_103704.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704021", "story_v_side_old_103704.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play103704022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 103704022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play103704023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.975

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(103704022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 39 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 39)

				if (39 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 39)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play103704023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 103704023
		arg_93_1.duration_ = 4.1

		local var_93_0 = {
			ja = 2.9,
			ko = 3.333,
			en = 4.1
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play103704024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.275

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(103704023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 11 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 11)

				if (11 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 11)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704023", "story_v_side_old_103704.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704023", "story_v_side_old_103704.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_side_old_103704", "103704023", "story_v_side_old_103704.awb")

						arg_93_1:RecordAudio("103704023", var_96_6)
						arg_93_1:RecordAudio("103704023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704023", "story_v_side_old_103704.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704023", "story_v_side_old_103704.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play103704024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 103704024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play103704025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 1.175

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(103704024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 47 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 47)

				if (47 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 47)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play103704025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 103704025
		arg_101_1.duration_ = 4.13

		local var_101_0 = {
			ja = 4.133,
			ko = 2.8,
			en = 4.133
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play103704026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.225

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(103704025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 9 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 9)

				if (9 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 9)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704025", "story_v_side_old_103704.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704025", "story_v_side_old_103704.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_side_old_103704", "103704025", "story_v_side_old_103704.awb")

						arg_101_1:RecordAudio("103704025", var_104_6)
						arg_101_1:RecordAudio("103704025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704025", "story_v_side_old_103704.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704025", "story_v_side_old_103704.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play103704026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 103704026
		arg_105_1.duration_ = 9.57

		local var_105_0 = {
			ja = 9.566,
			ko = 4.966,
			en = 4.866
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
				arg_105_0:Play103704027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.35

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:GetWordFromCfg(103704026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 14 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 14)

				if (14 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 14)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704026", "story_v_side_old_103704.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704026", "story_v_side_old_103704.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_side_old_103704", "103704026", "story_v_side_old_103704.awb")

						arg_105_1:RecordAudio("103704026", var_108_6)
						arg_105_1:RecordAudio("103704026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704026", "story_v_side_old_103704.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704026", "story_v_side_old_103704.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play103704027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 103704027
		arg_109_1.duration_ = 6.07

		local var_109_0 = {
			ja = 6.066,
			ko = 4.2,
			en = 2.966
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
				arg_109_0:Play103704028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.375

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(103704027)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 15 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 15)

				if (15 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 15)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704027", "story_v_side_old_103704.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704027", "story_v_side_old_103704.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_side_old_103704", "103704027", "story_v_side_old_103704.awb")

						arg_109_1:RecordAudio("103704027", var_112_6)
						arg_109_1:RecordAudio("103704027", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704027", "story_v_side_old_103704.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704027", "story_v_side_old_103704.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play103704028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 103704028
		arg_113_1.duration_ = 8.4

		local var_113_0 = {
			ja = 8.4,
			ko = 5.7,
			en = 4.233
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
				arg_113_0:Play103704029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.3

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:GetWordFromCfg(103704028)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 12 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 12)

				if (12 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 12)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704028", "story_v_side_old_103704.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704028", "story_v_side_old_103704.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_side_old_103704", "103704028", "story_v_side_old_103704.awb")

						arg_113_1:RecordAudio("103704028", var_116_6)
						arg_113_1:RecordAudio("103704028", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704028", "story_v_side_old_103704.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704028", "story_v_side_old_103704.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play103704029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 103704029
		arg_117_1.duration_ = 6.27

		local var_117_0 = {
			ja = 6.266,
			ko = 3.6,
			en = 5.933
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
				arg_117_0:Play103704030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.425

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(103704029)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 17 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 17)

				if (17 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 17)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704029", "story_v_side_old_103704.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704029", "story_v_side_old_103704.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_side_old_103704", "103704029", "story_v_side_old_103704.awb")

						arg_117_1:RecordAudio("103704029", var_120_6)
						arg_117_1:RecordAudio("103704029", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704029", "story_v_side_old_103704.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704029", "story_v_side_old_103704.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play103704030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 103704030
		arg_121_1.duration_ = 5.83

		local var_121_0 = {
			ja = 5.833,
			ko = 4.066,
			en = 5.833
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
				arg_121_0:Play103704031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.325

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:GetWordFromCfg(103704030)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 13 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 13)

				if (13 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 13)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704030", "story_v_side_old_103704.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704030", "story_v_side_old_103704.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_side_old_103704", "103704030", "story_v_side_old_103704.awb")

						arg_121_1:RecordAudio("103704030", var_124_6)
						arg_121_1:RecordAudio("103704030", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704030", "story_v_side_old_103704.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704030", "story_v_side_old_103704.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play103704031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 103704031
		arg_125_1.duration_ = 8.7

		local var_125_0 = {
			ja = 8.7,
			ko = 6.433,
			en = 7.1
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
				arg_125_0:Play103704032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.75

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(103704031)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 30 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 30)

				if (30 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 30)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704031", "story_v_side_old_103704.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704031", "story_v_side_old_103704.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_side_old_103704", "103704031", "story_v_side_old_103704.awb")

						arg_125_1:RecordAudio("103704031", var_128_6)
						arg_125_1:RecordAudio("103704031", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704031", "story_v_side_old_103704.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704031", "story_v_side_old_103704.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play103704032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 103704032
		arg_129_1.duration_ = 3.87

		local var_129_0 = {
			ja = 3.866,
			ko = 1.333,
			en = 1.4
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
				arg_129_0:Play103704033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.1

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:GetWordFromCfg(103704032)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 4 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 4)

				if (4 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 4)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704032", "story_v_side_old_103704.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704032", "story_v_side_old_103704.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_side_old_103704", "103704032", "story_v_side_old_103704.awb")

						arg_129_1:RecordAudio("103704032", var_132_6)
						arg_129_1:RecordAudio("103704032", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704032", "story_v_side_old_103704.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704032", "story_v_side_old_103704.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play103704033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 103704033
		arg_133_1.duration_ = 8.5

		local var_133_0 = {
			ja = 8.5,
			ko = 5.266,
			en = 7.2
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
				arg_133_0:Play103704034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.65

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(103704033)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 26 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 26)

				if (26 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 26)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704033", "story_v_side_old_103704.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704033", "story_v_side_old_103704.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_side_old_103704", "103704033", "story_v_side_old_103704.awb")

						arg_133_1:RecordAudio("103704033", var_136_6)
						arg_133_1:RecordAudio("103704033", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704033", "story_v_side_old_103704.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704033", "story_v_side_old_103704.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play103704034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 103704034
		arg_137_1.duration_ = 11.2

		local var_137_0 = {
			ja = 11.2,
			ko = 7.6,
			en = 7.366
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
				arg_137_0:Play103704035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.925

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(103704034)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 37 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 37)

				if (37 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 37)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704034", "story_v_side_old_103704.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704034", "story_v_side_old_103704.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_side_old_103704", "103704034", "story_v_side_old_103704.awb")

						arg_137_1:RecordAudio("103704034", var_140_6)
						arg_137_1:RecordAudio("103704034", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704034", "story_v_side_old_103704.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704034", "story_v_side_old_103704.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play103704035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 103704035
		arg_141_1.duration_ = 5.27

		local var_141_0 = {
			ja = 5.2,
			ko = 3.6,
			en = 5.266
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
				arg_141_0:Play103704036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.45

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:GetWordFromCfg(103704035)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 18 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 18)

				if (18 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 18)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704035", "story_v_side_old_103704.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704035", "story_v_side_old_103704.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_side_old_103704", "103704035", "story_v_side_old_103704.awb")

						arg_141_1:RecordAudio("103704035", var_144_6)
						arg_141_1:RecordAudio("103704035", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704035", "story_v_side_old_103704.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704035", "story_v_side_old_103704.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play103704036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 103704036
		arg_145_1.duration_ = 6.17

		local var_145_0 = {
			ja = 6.166,
			ko = 5.666,
			en = 4.866
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
				arg_145_0:Play103704037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.55

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:GetWordFromCfg(103704036)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 22 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 22)

				if (22 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 22)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704036", "story_v_side_old_103704.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704036", "story_v_side_old_103704.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_side_old_103704", "103704036", "story_v_side_old_103704.awb")

						arg_145_1:RecordAudio("103704036", var_148_6)
						arg_145_1:RecordAudio("103704036", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704036", "story_v_side_old_103704.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704036", "story_v_side_old_103704.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play103704037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 103704037
		arg_149_1.duration_ = 10.03

		local var_149_0 = {
			ja = 10.033,
			ko = 7.733,
			en = 8.266
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
				arg_149_0:Play103704038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.825

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:GetWordFromCfg(103704037)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 33 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 33)

				if (33 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 33)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704037", "story_v_side_old_103704.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704037", "story_v_side_old_103704.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_side_old_103704", "103704037", "story_v_side_old_103704.awb")

						arg_149_1:RecordAudio("103704037", var_152_6)
						arg_149_1:RecordAudio("103704037", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704037", "story_v_side_old_103704.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704037", "story_v_side_old_103704.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play103704038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 103704038
		arg_153_1.duration_ = 9

		local var_153_0 = {
			ja = 5.533,
			ko = 7.566,
			en = 9
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
				arg_153_0:Play103704039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.775

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(103704038)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 31 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 31)

				if (31 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 31)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704038", "story_v_side_old_103704.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704038", "story_v_side_old_103704.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_side_old_103704", "103704038", "story_v_side_old_103704.awb")

						arg_153_1:RecordAudio("103704038", var_156_6)
						arg_153_1:RecordAudio("103704038", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704038", "story_v_side_old_103704.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704038", "story_v_side_old_103704.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play103704039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 103704039
		arg_157_1.duration_ = 12.9

		local var_157_0 = {
			ja = 12.9,
			ko = 10.166,
			en = 8.2
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
				arg_157_0:Play103704040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 1

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:GetWordFromCfg(103704039)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 40 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 40)

				if (40 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 40)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704039", "story_v_side_old_103704.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704039", "story_v_side_old_103704.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_side_old_103704", "103704039", "story_v_side_old_103704.awb")

						arg_157_1:RecordAudio("103704039", var_160_6)
						arg_157_1:RecordAudio("103704039", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704039", "story_v_side_old_103704.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704039", "story_v_side_old_103704.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play103704040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 103704040
		arg_161_1.duration_ = 6.77

		local var_161_0 = {
			ja = 6.766,
			ko = 4.366,
			en = 5.3
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
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play103704041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.425

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(103704040)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 17 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 17)

				if (17 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 17)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704040", "story_v_side_old_103704.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704040", "story_v_side_old_103704.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_side_old_103704", "103704040", "story_v_side_old_103704.awb")

						arg_161_1:RecordAudio("103704040", var_164_6)
						arg_161_1:RecordAudio("103704040", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704040", "story_v_side_old_103704.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704040", "story_v_side_old_103704.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play103704041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 103704041
		arg_165_1.duration_ = 3.1

		local var_165_0 = {
			ja = 2.266,
			ko = 3.1,
			en = 1.366
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play103704042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.075

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:GetWordFromCfg(103704041)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 3 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 3)

				if (3 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 3)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704041", "story_v_side_old_103704.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704041", "story_v_side_old_103704.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_side_old_103704", "103704041", "story_v_side_old_103704.awb")

						arg_165_1:RecordAudio("103704041", var_168_6)
						arg_165_1:RecordAudio("103704041", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704041", "story_v_side_old_103704.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704041", "story_v_side_old_103704.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play103704042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 103704042
		arg_169_1.duration_ = 9.63

		local var_169_0 = {
			ja = 9.633,
			ko = 4.166,
			en = 5.8
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play103704043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.425

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(103704042)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 17 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 17)

				if (17 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 17)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704042", "story_v_side_old_103704.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704042", "story_v_side_old_103704.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_side_old_103704", "103704042", "story_v_side_old_103704.awb")

						arg_169_1:RecordAudio("103704042", var_172_6)
						arg_169_1:RecordAudio("103704042", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704042", "story_v_side_old_103704.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704042", "story_v_side_old_103704.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play103704043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 103704043
		arg_173_1.duration_ = 3.83

		local var_173_0 = {
			ja = 3.133,
			ko = 3.833,
			en = 3.2
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play103704044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.325

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:GetWordFromCfg(103704043)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 13 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 13)

				if (13 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 13)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704043", "story_v_side_old_103704.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704043", "story_v_side_old_103704.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_side_old_103704", "103704043", "story_v_side_old_103704.awb")

						arg_173_1:RecordAudio("103704043", var_176_6)
						arg_173_1:RecordAudio("103704043", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704043", "story_v_side_old_103704.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704043", "story_v_side_old_103704.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play103704044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 103704044
		arg_177_1.duration_ = 6.4

		local var_177_0 = {
			ja = 6.1,
			ko = 6.4,
			en = 6.366
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play103704045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.825

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(103704044)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 33 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 33)

				if (33 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 33)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704044", "story_v_side_old_103704.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704044", "story_v_side_old_103704.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_side_old_103704", "103704044", "story_v_side_old_103704.awb")

						arg_177_1:RecordAudio("103704044", var_180_6)
						arg_177_1:RecordAudio("103704044", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704044", "story_v_side_old_103704.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704044", "story_v_side_old_103704.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play103704045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 103704045
		arg_181_1.duration_ = 8.03

		local var_181_0 = {
			ja = 8.033,
			ko = 4.9,
			en = 8
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play103704046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.575

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(103704045)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 23 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 23)

				if (23 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 23)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704045", "story_v_side_old_103704.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704045", "story_v_side_old_103704.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_side_old_103704", "103704045", "story_v_side_old_103704.awb")

						arg_181_1:RecordAudio("103704045", var_184_6)
						arg_181_1:RecordAudio("103704045", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704045", "story_v_side_old_103704.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704045", "story_v_side_old_103704.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play103704046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 103704046
		arg_185_1.duration_ = 9.2

		local var_185_0 = {
			ja = 9.2,
			ko = 8.133,
			en = 7.1
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play103704047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.875

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(103704046)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 35 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 35)

				if (35 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 35)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704046", "story_v_side_old_103704.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704046", "story_v_side_old_103704.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_side_old_103704", "103704046", "story_v_side_old_103704.awb")

						arg_185_1:RecordAudio("103704046", var_188_6)
						arg_185_1:RecordAudio("103704046", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704046", "story_v_side_old_103704.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704046", "story_v_side_old_103704.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play103704047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 103704047
		arg_189_1.duration_ = 12

		local var_189_0 = {
			ja = 12,
			ko = 5.766,
			en = 5.333
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play103704048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.45

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:GetWordFromCfg(103704047)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 18 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 18)

				if (18 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 18)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704047", "story_v_side_old_103704.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704047", "story_v_side_old_103704.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_side_old_103704", "103704047", "story_v_side_old_103704.awb")

						arg_189_1:RecordAudio("103704047", var_192_6)
						arg_189_1:RecordAudio("103704047", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704047", "story_v_side_old_103704.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704047", "story_v_side_old_103704.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play103704048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 103704048
		arg_193_1.duration_ = 6.8

		local var_193_0 = {
			ja = 6.8,
			ko = 4.1,
			en = 5.9
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play103704049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.525

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:GetWordFromCfg(103704048)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 21 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 21)

				if (21 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 21)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704048", "story_v_side_old_103704.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704048", "story_v_side_old_103704.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_side_old_103704", "103704048", "story_v_side_old_103704.awb")

						arg_193_1:RecordAudio("103704048", var_196_6)
						arg_193_1:RecordAudio("103704048", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704048", "story_v_side_old_103704.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704048", "story_v_side_old_103704.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play103704049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 103704049
		arg_197_1.duration_ = 1.67

		local var_197_0 = {
			ja = 1.1,
			ko = 0.8,
			en = 1.666
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play103704050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.05

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_1 = arg_197_1:GetWordFromCfg(103704049)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 2 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 2)

				if (2 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 2)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704049", "story_v_side_old_103704.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704049", "story_v_side_old_103704.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_side_old_103704", "103704049", "story_v_side_old_103704.awb")

						arg_197_1:RecordAudio("103704049", var_200_6)
						arg_197_1:RecordAudio("103704049", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704049", "story_v_side_old_103704.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704049", "story_v_side_old_103704.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play103704050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 103704050
		arg_201_1.duration_ = 4.8

		local var_201_0 = {
			ja = 4.8,
			ko = 1.866,
			en = 3.366
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play103704051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.225

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(103704050)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 9 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 9)

				if (9 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 9)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704050", "story_v_side_old_103704.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704050", "story_v_side_old_103704.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_side_old_103704", "103704050", "story_v_side_old_103704.awb")

						arg_201_1:RecordAudio("103704050", var_204_6)
						arg_201_1:RecordAudio("103704050", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704050", "story_v_side_old_103704.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704050", "story_v_side_old_103704.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play103704051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 103704051
		arg_205_1.duration_ = 3.13

		local var_205_0 = {
			ja = 1.8,
			ko = 2.1,
			en = 3.133
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play103704052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.05

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:GetWordFromCfg(103704051)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 2 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 2)

				if (2 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 2)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704051", "story_v_side_old_103704.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704051", "story_v_side_old_103704.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_side_old_103704", "103704051", "story_v_side_old_103704.awb")

						arg_205_1:RecordAudio("103704051", var_208_6)
						arg_205_1:RecordAudio("103704051", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704051", "story_v_side_old_103704.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704051", "story_v_side_old_103704.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play103704052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 103704052
		arg_209_1.duration_ = 9.53

		local var_209_0 = {
			ja = 7.166,
			ko = 7.233,
			en = 9.533
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play103704053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.8

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:GetWordFromCfg(103704052)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 32 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 32)

				if (32 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 32)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704052", "story_v_side_old_103704.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704052", "story_v_side_old_103704.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_side_old_103704", "103704052", "story_v_side_old_103704.awb")

						arg_209_1:RecordAudio("103704052", var_212_6)
						arg_209_1:RecordAudio("103704052", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704052", "story_v_side_old_103704.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704052", "story_v_side_old_103704.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play103704053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 103704053
		arg_213_1.duration_ = 6.1

		local var_213_0 = {
			ja = 6.1,
			ko = 5.2,
			en = 5.333
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play103704054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.375

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_1 = arg_213_1:GetWordFromCfg(103704053)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 15 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 15)

				if (15 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 15)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704053", "story_v_side_old_103704.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704053", "story_v_side_old_103704.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_side_old_103704", "103704053", "story_v_side_old_103704.awb")

						arg_213_1:RecordAudio("103704053", var_216_6)
						arg_213_1:RecordAudio("103704053", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704053", "story_v_side_old_103704.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704053", "story_v_side_old_103704.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play103704054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 103704054
		arg_217_1.duration_ = 6.2

		local var_217_0 = {
			ja = 4.666,
			ko = 4.4,
			en = 6.2
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play103704055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.375

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(103704054)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 15 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 15)

				if (15 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 15)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704054", "story_v_side_old_103704.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704054", "story_v_side_old_103704.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_side_old_103704", "103704054", "story_v_side_old_103704.awb")

						arg_217_1:RecordAudio("103704054", var_220_6)
						arg_217_1:RecordAudio("103704054", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704054", "story_v_side_old_103704.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704054", "story_v_side_old_103704.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play103704055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 103704055
		arg_221_1.duration_ = 2.33

		local var_221_0 = {
			ja = 2.333,
			ko = 1.333,
			en = 1.7
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play103704056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.075

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:GetWordFromCfg(103704055)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 3 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 3)

				if (3 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 3)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704055", "story_v_side_old_103704.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704055", "story_v_side_old_103704.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_side_old_103704", "103704055", "story_v_side_old_103704.awb")

						arg_221_1:RecordAudio("103704055", var_224_6)
						arg_221_1:RecordAudio("103704055", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704055", "story_v_side_old_103704.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704055", "story_v_side_old_103704.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play103704056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 103704056
		arg_225_1.duration_ = 12.03

		local var_225_0 = {
			ja = 9.633,
			ko = 7.766,
			en = 12.033
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play103704057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 1.025

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:GetWordFromCfg(103704056)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 41 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 41)

				if (41 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 41)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704056", "story_v_side_old_103704.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704056", "story_v_side_old_103704.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_side_old_103704", "103704056", "story_v_side_old_103704.awb")

						arg_225_1:RecordAudio("103704056", var_228_6)
						arg_225_1:RecordAudio("103704056", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704056", "story_v_side_old_103704.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704056", "story_v_side_old_103704.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play103704057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 103704057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play103704058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.35

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(103704057).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 14 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 14)

				if (14 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 14)) > 0 and var_232_0 < var_232_3 then
					arg_229_1.talkMaxDuration = var_232_3

					if var_232_3 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_3 + 0
					end
				end

				arg_229_1.text_.text = var_232_1
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_4 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_4

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play103704058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 103704058
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play103704060(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.4

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(103704058).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 16 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 16)

				if (16 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 16)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play103704060 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 103704060
		arg_237_1.duration_ = 5.87

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play103704061(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if arg_237_1.bgs_.ST12 == nil then
				local var_240_0 = Object.Instantiate(arg_237_1.paintGo_)

				var_240_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_240_0.name = "ST12"
				var_240_0.transform.parent = arg_237_1.stage_.transform
				var_240_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.bgs_.ST12 = var_240_0
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				local var_240_1 = arg_237_1.bgs_.ST12

				arg_237_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_240_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_240_2 = var_240_1:GetComponent("SpriteRenderer")

				if var_240_2 and var_240_2.sprite then
					local var_240_3 = 2 * (var_240_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_240_1.transform.localScale = Vector3.New(var_240_3 / var_240_2.sprite.bounds.size.y < var_240_3 * manager.ui.mainCameraCom_.aspect / var_240_2.sprite.bounds.size.x and var_240_3 * manager.ui.mainCameraCom_.aspect / var_240_2.sprite.bounds.size.x or var_240_3 / var_240_2.sprite.bounds.size.y, var_240_3 / var_240_2.sprite.bounds.size.y < var_240_3 * manager.ui.mainCameraCom_.aspect / var_240_2.sprite.bounds.size.x and var_240_3 * manager.ui.mainCameraCom_.aspect / var_240_2.sprite.bounds.size.x or var_240_3 / var_240_2.sprite.bounds.size.y, 0)
				end

				for iter_240_0, iter_240_1 in pairs(arg_237_1.bgs_) do
					if iter_240_0 ~= "ST12" then
						iter_240_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				local var_240_4 = arg_237_1.bgs_.S0903:GetComponent("SpriteRenderer")

				if var_240_4 then
					arg_237_1.var_.alphaOldValueS0903 = var_240_4.color.a
					arg_237_1.var_.alphaMatValueS0903 = var_240_4
				end

				arg_237_1.var_.alphaOldValueS0903 = 1
			end

			local var_240_5 = 1.5

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_5 then
				if arg_237_1.var_.alphaMatValueS0903 then
					arg_237_1.var_.alphaMatValueS0903.color.a = Mathf.Lerp(arg_237_1.var_.alphaOldValueS0903, 0, (arg_237_1.time_ - 0) / var_240_5)
					arg_237_1.var_.alphaMatValueS0903.color = arg_237_1.var_.alphaMatValueS0903.color
				end
			end

			if arg_237_1.time_ >= 0 + var_240_5 and arg_237_1.time_ < 0 + var_240_5 + arg_240_0 and arg_237_1.var_.alphaMatValueS0903 then
				arg_237_1.var_.alphaMatValueS0903.color.a = 0
				arg_237_1.var_.alphaMatValueS0903.color = arg_237_1.var_.alphaMatValueS0903.color
			end

			if 1.5 < arg_237_1.time_ and arg_237_1.time_ <= 1.5 + arg_240_0 then
				local var_240_6 = arg_237_1.bgs_.ST12:GetComponent("SpriteRenderer")

				if var_240_6 then
					arg_237_1.var_.alphaOldValueST12 = var_240_6.color.a
					arg_237_1.var_.alphaMatValueST12 = var_240_6
				end

				arg_237_1.var_.alphaOldValueST12 = 0
			end

			local var_240_7 = 1.5

			if 1.5 <= arg_237_1.time_ and arg_237_1.time_ < 1.5 + var_240_7 then
				if arg_237_1.var_.alphaMatValueST12 then
					arg_237_1.var_.alphaMatValueST12.color.a = Mathf.Lerp(arg_237_1.var_.alphaOldValueST12, 1, (arg_237_1.time_ - 1.5) / var_240_7)
					arg_237_1.var_.alphaMatValueST12.color = arg_237_1.var_.alphaMatValueST12.color
				end
			end

			if arg_237_1.time_ >= 1.5 + var_240_7 and arg_237_1.time_ < 1.5 + var_240_7 + arg_240_0 and arg_237_1.var_.alphaMatValueST12 then
				arg_237_1.var_.alphaMatValueST12.color.a = 1
				arg_237_1.var_.alphaMatValueST12.color = arg_237_1.var_.alphaMatValueST12.color
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_240_10 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_237_1.bgmTxt_.text ~= var_240_10 and arg_237_1.bgmTxt_.text ~= "" then
						if arg_237_1.bgmTxt2_.text ~= "" then
							arg_237_1.bgmTxt_.text = arg_237_1.bgmTxt2_.text
						end

						arg_237_1.bgmTxt2_.text = var_240_10

						arg_237_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_237_1.bgmTxt_.text = var_240_10
						arg_237_1.bgmTxt2_.text = var_240_10
					end

					if arg_237_1.bgmTimer then
						arg_237_1.bgmTimer:Stop()

						arg_237_1.bgmTimer = nil
					end

					if arg_237_1.settingData.show_music_name == 1 then
						arg_237_1.musicController:SetSelectedState("show")
						arg_237_1.musicAnimator_:Play("open", 0, 0)

						if arg_237_1.settingData.music_time ~= 0 then
							arg_237_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_237_1.settingData.music_time), function()
								if arg_237_1 == nil or isNil(arg_237_1.bgmTxt_) then
									return
								end

								arg_237_1.musicController:SetSelectedState("hide")
								arg_237_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_237_1.frameCnt_ <= 1 then
				arg_237_1.dialog_:SetActive(false)
			end

			local var_240_11 = 0.866666666666667
			local var_240_12 = 0.3

			if 0.866666666666667 < arg_237_1.time_ and arg_237_1.time_ <= var_240_11 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				arg_237_1.dialog_:SetActive(true)

				arg_237_1.dialogCg_.alpha = 0

				local var_240_13 = LeanTween.value(arg_237_1.dialog_, 0, 1, 0.3)

				var_240_13:setOnUpdate(LuaHelper.FloatAction(function(arg_242_0)
					arg_237_1.dialogCg_.alpha = arg_242_0
				end))
				var_240_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_237_1.dialog_)
					var_240_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_237_1.duration_ = arg_237_1.duration_ + 0.3

				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_14 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(103704060).content)

				arg_237_1.text_.text = var_240_14

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_16 = 12 <= 0 and var_240_12 or var_240_12 * (utf8.len(var_240_14) / 12)

				if (12 <= 0 and var_240_12 or var_240_12 * (utf8.len(var_240_14) / 12)) > 0 and var_240_12 < var_240_16 then
					arg_237_1.talkMaxDuration = var_240_16
					var_240_11 = var_240_11 + 0.3

					if var_240_16 + var_240_11 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_16 + var_240_11
					end
				end

				arg_237_1.text_.text = var_240_14
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_17 = var_240_11 + 0.3
			local var_240_18 = math.max(var_240_12, arg_237_1.talkMaxDuration)

			if var_240_11 + 0.3 <= arg_237_1.time_ and arg_237_1.time_ < var_240_17 + var_240_18 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_17) / var_240_18

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_17 + var_240_18 and arg_237_1.time_ < var_240_17 + var_240_18 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play103704061 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 103704061
		arg_244_1.duration_ = 4.5

		local var_244_0 = {
			ja = 4.5,
			ko = 1.933,
			en = 3.566
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play103704062(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.325

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_1 = arg_244_1:GetWordFromCfg(103704061)
				local var_247_2 = arg_244_1:FormatText(var_247_1.content)

				arg_244_1.text_.text = var_247_2

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 13 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 13)

				if (13 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 13)) > 0 and var_247_0 < var_247_4 then
					arg_244_1.talkMaxDuration = var_247_4

					if var_247_4 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_4 + 0
					end
				end

				arg_244_1.text_.text = var_247_2
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704061", "story_v_side_old_103704.awb") ~= 0 then
					local var_247_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704061", "story_v_side_old_103704.awb") / 1000

					if var_247_5 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + 0
					end

					if var_247_1.prefab_name ~= "" and arg_244_1.actors_[var_247_1.prefab_name] ~= nil then
						local var_247_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_1.prefab_name].transform, "story_v_side_old_103704", "103704061", "story_v_side_old_103704.awb")

						arg_244_1:RecordAudio("103704061", var_247_6)
						arg_244_1:RecordAudio("103704061", var_247_6)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704061", "story_v_side_old_103704.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704061", "story_v_side_old_103704.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_7 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_7

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play103704062 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 103704062
		arg_248_1.duration_ = 11.67

		local var_248_0 = {
			ja = 11.666,
			ko = 5.7,
			en = 7.366
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
				arg_248_0:Play103704063(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if arg_248_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_251_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_248_1.stage_.transform)

				var_251_0.name = "1037ui_story"
				var_251_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_248_1.actors_["1037ui_story"] = var_251_0

				local var_251_1 = var_251_0:GetComponentInChildren(typeof(CharacterEffect))

				var_251_1.enabled = true

				local var_251_2 = GameObjectTools.GetOrAddComponent(var_251_0, typeof(DynamicBoneHelper))

				if var_251_2 then
					var_251_2:EnableDynamicBone(false)
				end

				arg_248_1:ShowWeapon(var_251_1.transform, false)

				arg_248_1.var_["1037ui_story" .. "Animator"] = var_251_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_248_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_248_1.var_["1037ui_story" .. "LipSync"] = var_251_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_251_3 = arg_248_1.actors_["1037ui_story"].transform

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1037ui_story = var_251_3.localPosition
			end

			local var_251_4 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				var_251_3.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_248_1.time_ - 0) / var_251_4)
				var_251_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_3.position).x, (manager.ui.mainCamera.transform.position - var_251_3.position).y, (manager.ui.mainCamera.transform.position - var_251_3.position).z)
				var_251_3.localEulerAngles.z = 0
				var_251_3.localEulerAngles.x = 0
				var_251_3.localEulerAngles = var_251_3.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				var_251_3.localPosition = Vector3.New(0, -1.09, -5.81)
				var_251_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_3.position).x, (manager.ui.mainCamera.transform.position - var_251_3.position).y, (manager.ui.mainCamera.transform.position - var_251_3.position).z)
				var_251_3.localEulerAngles.z = 0
				var_251_3.localEulerAngles.x = 0
				var_251_3.localEulerAngles = var_251_3.localEulerAngles
			end

			local var_251_5 = arg_248_1.actors_["1037ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_5) and arg_248_1.var_.characterEffect1037ui_story == nil then
				arg_248_1.var_.characterEffect1037ui_story = var_251_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_6 = 0.2

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_6 and not isNil(var_251_5) then
				if arg_248_1.var_.characterEffect1037ui_story and not isNil(var_251_5) then
					arg_248_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_6 and arg_248_1.time_ < 0 + var_251_6 + arg_251_0 and not isNil(var_251_5) and arg_248_1.var_.characterEffect1037ui_story then
				arg_248_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_251_8 = 0
			local var_251_9 = 0.875

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_8 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_10 = arg_248_1:GetWordFromCfg(103704062)
				local var_251_11 = arg_248_1:FormatText(var_251_10.content)

				arg_248_1.text_.text = var_251_11

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_13 = 35 <= 0 and var_251_9 or var_251_9 * (utf8.len(var_251_11) / 35)

				if (35 <= 0 and var_251_9 or var_251_9 * (utf8.len(var_251_11) / 35)) > 0 and var_251_9 < var_251_13 then
					arg_248_1.talkMaxDuration = var_251_13

					if var_251_13 + var_251_8 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_13 + var_251_8
					end
				end

				arg_248_1.text_.text = var_251_11
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704062", "story_v_side_old_103704.awb") ~= 0 then
					local var_251_14 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704062", "story_v_side_old_103704.awb") / 1000

					if var_251_14 + var_251_8 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_14 + var_251_8
					end

					if var_251_10.prefab_name ~= "" and arg_248_1.actors_[var_251_10.prefab_name] ~= nil then
						local var_251_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_10.prefab_name].transform, "story_v_side_old_103704", "103704062", "story_v_side_old_103704.awb")

						arg_248_1:RecordAudio("103704062", var_251_15)
						arg_248_1:RecordAudio("103704062", var_251_15)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704062", "story_v_side_old_103704.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704062", "story_v_side_old_103704.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_16 = math.max(var_251_9, arg_248_1.talkMaxDuration)

			if var_251_8 <= arg_248_1.time_ and arg_248_1.time_ < var_251_8 + var_251_16 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_8) / var_251_16

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_8 + var_251_16 and arg_248_1.time_ < var_251_8 + var_251_16 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play103704063 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 103704063
		arg_252_1.duration_ = 2.2

		local var_252_0 = {
			ja = 2.2,
			ko = 1.4,
			en = 1.8
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
				arg_252_0:Play103704064(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["1037ui_story"]) and arg_252_1.var_.characterEffect1037ui_story == nil then
				arg_252_1.var_.characterEffect1037ui_story = arg_252_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_0 = 0.2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["1037ui_story"]) then
				if arg_252_1.var_.characterEffect1037ui_story and not isNil(arg_252_1.actors_["1037ui_story"]) then
					arg_252_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_0)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["1037ui_story"]) and arg_252_1.var_.characterEffect1037ui_story then
				arg_252_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_255_1 = 0
			local var_255_2 = 0.125

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_3 = arg_252_1:GetWordFromCfg(103704063)
				local var_255_4 = arg_252_1:FormatText(var_255_3.content)

				arg_252_1.text_.text = var_255_4

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_6 = 5 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_4) / 5)

				if (5 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_4) / 5)) > 0 and var_255_2 < var_255_6 then
					arg_252_1.talkMaxDuration = var_255_6

					if var_255_6 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_6 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_4
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704063", "story_v_side_old_103704.awb") ~= 0 then
					local var_255_7 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704063", "story_v_side_old_103704.awb") / 1000

					if var_255_7 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_1
					end

					if var_255_3.prefab_name ~= "" and arg_252_1.actors_[var_255_3.prefab_name] ~= nil then
						local var_255_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_3.prefab_name].transform, "story_v_side_old_103704", "103704063", "story_v_side_old_103704.awb")

						arg_252_1:RecordAudio("103704063", var_255_8)
						arg_252_1:RecordAudio("103704063", var_255_8)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704063", "story_v_side_old_103704.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704063", "story_v_side_old_103704.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_9 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_9 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_9

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_9 and arg_252_1.time_ < var_255_1 + var_255_9 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play103704064 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 103704064
		arg_256_1.duration_ = 4.6

		local var_256_0 = {
			ja = 3.133,
			ko = 4.6,
			en = 3.566
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
				arg_256_0:Play103704065(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["1037ui_story"]) and arg_256_1.var_.characterEffect1037ui_story == nil then
				arg_256_1.var_.characterEffect1037ui_story = arg_256_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["1037ui_story"]) then
				if arg_256_1.var_.characterEffect1037ui_story and not isNil(arg_256_1.actors_["1037ui_story"]) then
					arg_256_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["1037ui_story"]) and arg_256_1.var_.characterEffect1037ui_story then
				arg_256_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_259_2 = 0
			local var_259_3 = 0.55

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_2 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_4 = arg_256_1:GetWordFromCfg(103704064)
				local var_259_5 = arg_256_1:FormatText(var_259_4.content)

				arg_256_1.text_.text = var_259_5

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_7 = 22 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_5) / 22)

				if (22 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_5) / 22)) > 0 and var_259_3 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_2
					end
				end

				arg_256_1.text_.text = var_259_5
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704064", "story_v_side_old_103704.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704064", "story_v_side_old_103704.awb") / 1000

					if var_259_8 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_2
					end

					if var_259_4.prefab_name ~= "" and arg_256_1.actors_[var_259_4.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_4.prefab_name].transform, "story_v_side_old_103704", "103704064", "story_v_side_old_103704.awb")

						arg_256_1:RecordAudio("103704064", var_259_9)
						arg_256_1:RecordAudio("103704064", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704064", "story_v_side_old_103704.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704064", "story_v_side_old_103704.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_3, arg_256_1.talkMaxDuration)

			if var_259_2 <= arg_256_1.time_ and arg_256_1.time_ < var_259_2 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_2) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_2 + var_259_10 and arg_256_1.time_ < var_259_2 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play103704065 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 103704065
		arg_260_1.duration_ = 7.93

		local var_260_0 = {
			ja = 7.933,
			ko = 3.233,
			en = 4.1
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
				arg_260_0:Play103704066(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["1037ui_story"]) and arg_260_1.var_.characterEffect1037ui_story == nil then
				arg_260_1.var_.characterEffect1037ui_story = arg_260_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_0 = 0.2

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["1037ui_story"]) then
				if arg_260_1.var_.characterEffect1037ui_story and not isNil(arg_260_1.actors_["1037ui_story"]) then
					arg_260_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["1037ui_story"]) and arg_260_1.var_.characterEffect1037ui_story then
				arg_260_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_263_2 = 0
			local var_263_3 = 0.375

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_2 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_4 = arg_260_1:GetWordFromCfg(103704065)
				local var_263_5 = arg_260_1:FormatText(var_263_4.content)

				arg_260_1.text_.text = var_263_5

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_7 = 15 <= 0 and var_263_3 or var_263_3 * (utf8.len(var_263_5) / 15)

				if (15 <= 0 and var_263_3 or var_263_3 * (utf8.len(var_263_5) / 15)) > 0 and var_263_3 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_2 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_2
					end
				end

				arg_260_1.text_.text = var_263_5
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704065", "story_v_side_old_103704.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704065", "story_v_side_old_103704.awb") / 1000

					if var_263_8 + var_263_2 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_2
					end

					if var_263_4.prefab_name ~= "" and arg_260_1.actors_[var_263_4.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_4.prefab_name].transform, "story_v_side_old_103704", "103704065", "story_v_side_old_103704.awb")

						arg_260_1:RecordAudio("103704065", var_263_9)
						arg_260_1:RecordAudio("103704065", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704065", "story_v_side_old_103704.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704065", "story_v_side_old_103704.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_3, arg_260_1.talkMaxDuration)

			if var_263_2 <= arg_260_1.time_ and arg_260_1.time_ < var_263_2 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_2) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_2 + var_263_10 and arg_260_1.time_ < var_263_2 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play103704066 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 103704066
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play103704067(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["1037ui_story"]) and arg_264_1.var_.characterEffect1037ui_story == nil then
				arg_264_1.var_.characterEffect1037ui_story = arg_264_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_0 = 0.2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["1037ui_story"]) then
				if arg_264_1.var_.characterEffect1037ui_story and not isNil(arg_264_1.actors_["1037ui_story"]) then
					arg_264_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_264_1.time_ - 0) / var_267_0)
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["1037ui_story"]) and arg_264_1.var_.characterEffect1037ui_story then
				arg_264_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_267_1 = 0
			local var_267_2 = 0.925

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_3 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(103704066).content)

				arg_264_1.text_.text = var_267_3

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 37 <= 0 and var_267_2 or var_267_2 * (utf8.len(var_267_3) / 37)

				if (37 <= 0 and var_267_2 or var_267_2 * (utf8.len(var_267_3) / 37)) > 0 and var_267_2 < var_267_5 then
					arg_264_1.talkMaxDuration = var_267_5

					if var_267_5 + var_267_1 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + var_267_1
					end
				end

				arg_264_1.text_.text = var_267_3
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_6 = math.max(var_267_2, arg_264_1.talkMaxDuration)

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_6 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_1) / var_267_6

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_1 + var_267_6 and arg_264_1.time_ < var_267_1 + var_267_6 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play103704067 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 103704067
		arg_268_1.duration_ = 13.27

		local var_268_0 = {
			ja = 13.266,
			ko = 9.033,
			en = 11.066
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
				arg_268_0:Play103704068(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1037ui_story"]) and arg_268_1.var_.characterEffect1037ui_story == nil then
				arg_268_1.var_.characterEffect1037ui_story = arg_268_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1037ui_story"]) then
				if arg_268_1.var_.characterEffect1037ui_story and not isNil(arg_268_1.actors_["1037ui_story"]) then
					arg_268_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1037ui_story"]) and arg_268_1.var_.characterEffect1037ui_story then
				arg_268_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_271_2 = 0
			local var_271_3 = 1.15

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_2 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_4 = arg_268_1:GetWordFromCfg(103704067)
				local var_271_5 = arg_268_1:FormatText(var_271_4.content)

				arg_268_1.text_.text = var_271_5

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_7 = 46 <= 0 and var_271_3 or var_271_3 * (utf8.len(var_271_5) / 46)

				if (46 <= 0 and var_271_3 or var_271_3 * (utf8.len(var_271_5) / 46)) > 0 and var_271_3 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_2 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_2
					end
				end

				arg_268_1.text_.text = var_271_5
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704067", "story_v_side_old_103704.awb") ~= 0 then
					local var_271_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704067", "story_v_side_old_103704.awb") / 1000

					if var_271_8 + var_271_2 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_2
					end

					if var_271_4.prefab_name ~= "" and arg_268_1.actors_[var_271_4.prefab_name] ~= nil then
						local var_271_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_4.prefab_name].transform, "story_v_side_old_103704", "103704067", "story_v_side_old_103704.awb")

						arg_268_1:RecordAudio("103704067", var_271_9)
						arg_268_1:RecordAudio("103704067", var_271_9)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704067", "story_v_side_old_103704.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704067", "story_v_side_old_103704.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_10 = math.max(var_271_3, arg_268_1.talkMaxDuration)

			if var_271_2 <= arg_268_1.time_ and arg_268_1.time_ < var_271_2 + var_271_10 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_2) / var_271_10

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_2 + var_271_10 and arg_268_1.time_ < var_271_2 + var_271_10 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play103704068 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 103704068
		arg_272_1.duration_ = 15.3

		local var_272_0 = {
			ja = 15.3,
			ko = 6.5,
			en = 9.733
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
				arg_272_0:Play103704069(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_275_0 = 0
			local var_275_1 = 0.925

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_2 = arg_272_1:GetWordFromCfg(103704068)
				local var_275_3 = arg_272_1:FormatText(var_275_2.content)

				arg_272_1.text_.text = var_275_3

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 37 <= 0 and var_275_1 or var_275_1 * (utf8.len(var_275_3) / 37)

				if (37 <= 0 and var_275_1 or var_275_1 * (utf8.len(var_275_3) / 37)) > 0 and var_275_1 < var_275_5 then
					arg_272_1.talkMaxDuration = var_275_5

					if var_275_5 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_3
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704068", "story_v_side_old_103704.awb") ~= 0 then
					local var_275_6 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704068", "story_v_side_old_103704.awb") / 1000

					if var_275_6 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_6 + var_275_0
					end

					if var_275_2.prefab_name ~= "" and arg_272_1.actors_[var_275_2.prefab_name] ~= nil then
						local var_275_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_2.prefab_name].transform, "story_v_side_old_103704", "103704068", "story_v_side_old_103704.awb")

						arg_272_1:RecordAudio("103704068", var_275_7)
						arg_272_1:RecordAudio("103704068", var_275_7)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704068", "story_v_side_old_103704.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704068", "story_v_side_old_103704.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_8 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_8 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_8

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_8 and arg_272_1.time_ < var_275_0 + var_275_8 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play103704069 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 103704069
		arg_276_1.duration_ = 15.27

		local var_276_0 = {
			ja = 15.266,
			ko = 7.6,
			en = 12.4
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
				arg_276_0:Play103704070(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_279_0 = 0
			local var_279_1 = 1.15

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
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

				local var_279_2 = arg_276_1:GetWordFromCfg(103704069)
				local var_279_3 = arg_276_1:FormatText(var_279_2.content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 46 <= 0 and var_279_1 or var_279_1 * (utf8.len(var_279_3) / 46)

				if (46 <= 0 and var_279_1 or var_279_1 * (utf8.len(var_279_3) / 46)) > 0 and var_279_1 < var_279_5 then
					arg_276_1.talkMaxDuration = var_279_5

					if var_279_5 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + var_279_0
					end
				end

				arg_276_1.text_.text = var_279_3
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704069", "story_v_side_old_103704.awb") ~= 0 then
					local var_279_6 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704069", "story_v_side_old_103704.awb") / 1000

					if var_279_6 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_6 + var_279_0
					end

					if var_279_2.prefab_name ~= "" and arg_276_1.actors_[var_279_2.prefab_name] ~= nil then
						local var_279_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_2.prefab_name].transform, "story_v_side_old_103704", "103704069", "story_v_side_old_103704.awb")

						arg_276_1:RecordAudio("103704069", var_279_7)
						arg_276_1:RecordAudio("103704069", var_279_7)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704069", "story_v_side_old_103704.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704069", "story_v_side_old_103704.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_8 = math.max(var_279_1, arg_276_1.talkMaxDuration)

			if var_279_0 <= arg_276_1.time_ and arg_276_1.time_ < var_279_0 + var_279_8 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_0) / var_279_8

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_0 + var_279_8 and arg_276_1.time_ < var_279_0 + var_279_8 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play103704070 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 103704070
		arg_280_1.duration_ = 7.8

		local var_280_0 = {
			ja = 4.4,
			ko = 6.766,
			en = 7.8
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
				arg_280_0:Play103704071(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_2")
			end

			local var_283_0 = 0
			local var_283_1 = 0.825

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_2 = arg_280_1:GetWordFromCfg(103704070)
				local var_283_3 = arg_280_1:FormatText(var_283_2.content)

				arg_280_1.text_.text = var_283_3

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 33 <= 0 and var_283_1 or var_283_1 * (utf8.len(var_283_3) / 33)

				if (33 <= 0 and var_283_1 or var_283_1 * (utf8.len(var_283_3) / 33)) > 0 and var_283_1 < var_283_5 then
					arg_280_1.talkMaxDuration = var_283_5

					if var_283_5 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_5 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_3
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704070", "story_v_side_old_103704.awb") ~= 0 then
					local var_283_6 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704070", "story_v_side_old_103704.awb") / 1000

					if var_283_6 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_0
					end

					if var_283_2.prefab_name ~= "" and arg_280_1.actors_[var_283_2.prefab_name] ~= nil then
						local var_283_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_2.prefab_name].transform, "story_v_side_old_103704", "103704070", "story_v_side_old_103704.awb")

						arg_280_1:RecordAudio("103704070", var_283_7)
						arg_280_1:RecordAudio("103704070", var_283_7)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704070", "story_v_side_old_103704.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704070", "story_v_side_old_103704.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_8 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_8 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_8

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_8 and arg_280_1.time_ < var_283_0 + var_283_8 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play103704071 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 103704071
		arg_284_1.duration_ = 2.97

		local var_284_0 = {
			ja = 2.7,
			ko = 2.966,
			en = 2.266
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
				arg_284_0:Play103704072(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["1037ui_story"]) and arg_284_1.var_.characterEffect1037ui_story == nil then
				arg_284_1.var_.characterEffect1037ui_story = arg_284_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_0 = 0.2

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["1037ui_story"]) then
				if arg_284_1.var_.characterEffect1037ui_story and not isNil(arg_284_1.actors_["1037ui_story"]) then
					arg_284_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 0) / var_287_0)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["1037ui_story"]) and arg_284_1.var_.characterEffect1037ui_story then
				arg_284_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_287_1 = 0
			local var_287_2 = 0.3

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_3 = arg_284_1:GetWordFromCfg(103704071)
				local var_287_4 = arg_284_1:FormatText(var_287_3.content)

				arg_284_1.text_.text = var_287_4

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_6 = 12 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_4) / 12)

				if (12 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_4) / 12)) > 0 and var_287_2 < var_287_6 then
					arg_284_1.talkMaxDuration = var_287_6

					if var_287_6 + var_287_1 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_6 + var_287_1
					end
				end

				arg_284_1.text_.text = var_287_4
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704071", "story_v_side_old_103704.awb") ~= 0 then
					local var_287_7 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704071", "story_v_side_old_103704.awb") / 1000

					if var_287_7 + var_287_1 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_1
					end

					if var_287_3.prefab_name ~= "" and arg_284_1.actors_[var_287_3.prefab_name] ~= nil then
						local var_287_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_3.prefab_name].transform, "story_v_side_old_103704", "103704071", "story_v_side_old_103704.awb")

						arg_284_1:RecordAudio("103704071", var_287_8)
						arg_284_1:RecordAudio("103704071", var_287_8)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704071", "story_v_side_old_103704.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704071", "story_v_side_old_103704.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_9 = math.max(var_287_2, arg_284_1.talkMaxDuration)

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_9 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_1) / var_287_9

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_1 + var_287_9 and arg_284_1.time_ < var_287_1 + var_287_9 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play103704072 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 103704072
		arg_288_1.duration_ = 6

		local var_288_0 = {
			ja = 4.4,
			ko = 5.3,
			en = 6
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
				arg_288_0:Play103704073(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0.75

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_1 = arg_288_1:GetWordFromCfg(103704072)
				local var_291_2 = arg_288_1:FormatText(var_291_1.content)

				arg_288_1.text_.text = var_291_2

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_4 = 30 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 30)

				if (30 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 30)) > 0 and var_291_0 < var_291_4 then
					arg_288_1.talkMaxDuration = var_291_4

					if var_291_4 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_4 + 0
					end
				end

				arg_288_1.text_.text = var_291_2
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704072", "story_v_side_old_103704.awb") ~= 0 then
					local var_291_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704072", "story_v_side_old_103704.awb") / 1000

					if var_291_5 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + 0
					end

					if var_291_1.prefab_name ~= "" and arg_288_1.actors_[var_291_1.prefab_name] ~= nil then
						local var_291_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_1.prefab_name].transform, "story_v_side_old_103704", "103704072", "story_v_side_old_103704.awb")

						arg_288_1:RecordAudio("103704072", var_291_6)
						arg_288_1:RecordAudio("103704072", var_291_6)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704072", "story_v_side_old_103704.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704072", "story_v_side_old_103704.awb")
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
	Play103704073 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 103704073
		arg_292_1.duration_ = 7.87

		local var_292_0 = {
			ja = 6.9,
			ko = 7.866,
			en = 6.533
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
				arg_292_0:Play103704074(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0.925

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_1 = arg_292_1:GetWordFromCfg(103704073)
				local var_295_2 = arg_292_1:FormatText(var_295_1.content)

				arg_292_1.text_.text = var_295_2

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_4 = 37 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 37)

				if (37 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 37)) > 0 and var_295_0 < var_295_4 then
					arg_292_1.talkMaxDuration = var_295_4

					if var_295_4 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_4 + 0
					end
				end

				arg_292_1.text_.text = var_295_2
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704073", "story_v_side_old_103704.awb") ~= 0 then
					local var_295_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704073", "story_v_side_old_103704.awb") / 1000

					if var_295_5 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + 0
					end

					if var_295_1.prefab_name ~= "" and arg_292_1.actors_[var_295_1.prefab_name] ~= nil then
						local var_295_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_1.prefab_name].transform, "story_v_side_old_103704", "103704073", "story_v_side_old_103704.awb")

						arg_292_1:RecordAudio("103704073", var_295_6)
						arg_292_1:RecordAudio("103704073", var_295_6)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704073", "story_v_side_old_103704.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704073", "story_v_side_old_103704.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_7 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_7 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_7

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_7 and arg_292_1.time_ < 0 + var_295_7 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play103704074 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 103704074
		arg_296_1.duration_ = 4.33

		local var_296_0 = {
			ja = 4.333,
			ko = 2.266,
			en = 1.999999999999
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
				arg_296_0:Play103704075(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["1037ui_story"]) and arg_296_1.var_.characterEffect1037ui_story == nil then
				arg_296_1.var_.characterEffect1037ui_story = arg_296_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_0 = 0.2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["1037ui_story"]) then
				if arg_296_1.var_.characterEffect1037ui_story and not isNil(arg_296_1.actors_["1037ui_story"]) then
					arg_296_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["1037ui_story"]) and arg_296_1.var_.characterEffect1037ui_story then
				arg_296_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_299_2 = 0
			local var_299_3 = 0.2

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_2 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_4 = arg_296_1:GetWordFromCfg(103704074)
				local var_299_5 = arg_296_1:FormatText(var_299_4.content)

				arg_296_1.text_.text = var_299_5

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_7 = 8 <= 0 and var_299_3 or var_299_3 * (utf8.len(var_299_5) / 8)

				if (8 <= 0 and var_299_3 or var_299_3 * (utf8.len(var_299_5) / 8)) > 0 and var_299_3 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_2 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_2
					end
				end

				arg_296_1.text_.text = var_299_5
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704074", "story_v_side_old_103704.awb") ~= 0 then
					local var_299_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704074", "story_v_side_old_103704.awb") / 1000

					if var_299_8 + var_299_2 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_8 + var_299_2
					end

					if var_299_4.prefab_name ~= "" and arg_296_1.actors_[var_299_4.prefab_name] ~= nil then
						local var_299_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_4.prefab_name].transform, "story_v_side_old_103704", "103704074", "story_v_side_old_103704.awb")

						arg_296_1:RecordAudio("103704074", var_299_9)
						arg_296_1:RecordAudio("103704074", var_299_9)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704074", "story_v_side_old_103704.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704074", "story_v_side_old_103704.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_10 = math.max(var_299_3, arg_296_1.talkMaxDuration)

			if var_299_2 <= arg_296_1.time_ and arg_296_1.time_ < var_299_2 + var_299_10 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_2) / var_299_10

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_2 + var_299_10 and arg_296_1.time_ < var_299_2 + var_299_10 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play103704075 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 103704075
		arg_300_1.duration_ = 3.97

		local var_300_0 = {
			ja = 3.966,
			ko = 2.1,
			en = 2.1
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
				arg_300_0:Play103704076(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["1037ui_story"]) and arg_300_1.var_.characterEffect1037ui_story == nil then
				arg_300_1.var_.characterEffect1037ui_story = arg_300_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_0 = 0.2

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["1037ui_story"]) then
				if arg_300_1.var_.characterEffect1037ui_story and not isNil(arg_300_1.actors_["1037ui_story"]) then
					arg_300_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_300_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_300_1.time_ - 0) / var_303_0)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["1037ui_story"]) and arg_300_1.var_.characterEffect1037ui_story then
				arg_300_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_300_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_303_1 = 0
			local var_303_2 = 0.225

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_3 = arg_300_1:GetWordFromCfg(103704075)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_6 = 9 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_4) / 9)

				if (9 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_4) / 9)) > 0 and var_303_2 < var_303_6 then
					arg_300_1.talkMaxDuration = var_303_6

					if var_303_6 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_1
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704075", "story_v_side_old_103704.awb") ~= 0 then
					local var_303_7 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704075", "story_v_side_old_103704.awb") / 1000

					if var_303_7 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_1
					end

					if var_303_3.prefab_name ~= "" and arg_300_1.actors_[var_303_3.prefab_name] ~= nil then
						local var_303_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_3.prefab_name].transform, "story_v_side_old_103704", "103704075", "story_v_side_old_103704.awb")

						arg_300_1:RecordAudio("103704075", var_303_8)
						arg_300_1:RecordAudio("103704075", var_303_8)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704075", "story_v_side_old_103704.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704075", "story_v_side_old_103704.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_9 = math.max(var_303_2, arg_300_1.talkMaxDuration)

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_9 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_1) / var_303_9

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_1 + var_303_9 and arg_300_1.time_ < var_303_1 + var_303_9 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play103704076 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 103704076
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play103704077(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1037ui_story = arg_304_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_307_0 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 then
				arg_304_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_304_1.time_ - 0) / var_307_0)
				arg_304_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1037ui_story"].transform.position).z)
				arg_304_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1037ui_story"].transform.localEulerAngles = arg_304_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 then
				arg_304_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_304_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1037ui_story"].transform.position).z)
				arg_304_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1037ui_story"].transform.localEulerAngles = arg_304_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_307_1 = 0
			local var_307_2 = 0.55

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_3 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(103704076).content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 22 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 22)

				if (22 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 22)) > 0 and var_307_2 < var_307_5 then
					arg_304_1.talkMaxDuration = var_307_5

					if var_307_5 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + var_307_1
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_6 = math.max(var_307_2, arg_304_1.talkMaxDuration)

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_6 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_1) / var_307_6

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_1 + var_307_6 and arg_304_1.time_ < var_307_1 + var_307_6 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play103704077 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 103704077
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play103704078(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0.7

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_1 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(103704077).content)

				arg_308_1.text_.text = var_311_1

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_3 = 28 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 28)

				if (28 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 28)) > 0 and var_311_0 < var_311_3 then
					arg_308_1.talkMaxDuration = var_311_3

					if var_311_3 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_3 + 0
					end
				end

				arg_308_1.text_.text = var_311_1
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_4 = math.max(var_311_0, arg_308_1.talkMaxDuration)

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - 0) / var_311_4

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play103704078 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 103704078
		arg_312_1.duration_ = 5.17

		local var_312_0 = {
			ja = 4.1,
			ko = 3.766,
			en = 5.166
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
				arg_312_0:Play103704079(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0.325

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_1 = arg_312_1:GetWordFromCfg(103704078)
				local var_315_2 = arg_312_1:FormatText(var_315_1.content)

				arg_312_1.text_.text = var_315_2

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_4 = 13 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 13)

				if (13 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 13)) > 0 and var_315_0 < var_315_4 then
					arg_312_1.talkMaxDuration = var_315_4

					if var_315_4 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_4 + 0
					end
				end

				arg_312_1.text_.text = var_315_2
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704078", "story_v_side_old_103704.awb") ~= 0 then
					local var_315_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704078", "story_v_side_old_103704.awb") / 1000

					if var_315_5 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_5 + 0
					end

					if var_315_1.prefab_name ~= "" and arg_312_1.actors_[var_315_1.prefab_name] ~= nil then
						local var_315_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_1.prefab_name].transform, "story_v_side_old_103704", "103704078", "story_v_side_old_103704.awb")

						arg_312_1:RecordAudio("103704078", var_315_6)
						arg_312_1:RecordAudio("103704078", var_315_6)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704078", "story_v_side_old_103704.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704078", "story_v_side_old_103704.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_7 = math.max(var_315_0, arg_312_1.talkMaxDuration)

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - 0) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= 0 + var_315_7 and arg_312_1.time_ < 0 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play103704079 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 103704079
		arg_316_1.duration_ = 8.93

		local var_316_0 = {
			ja = 8.633,
			ko = 8.933,
			en = 8.4
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
				arg_316_0:Play103704080(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos1037ui_story = arg_316_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_319_0 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 then
				arg_316_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_316_1.time_ - 0) / var_319_0)
				arg_316_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1037ui_story"].transform.position).z)
				arg_316_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["1037ui_story"].transform.localEulerAngles = arg_316_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 then
				arg_316_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_316_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1037ui_story"].transform.position).z)
				arg_316_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["1037ui_story"].transform.localEulerAngles = arg_316_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_319_1 = arg_316_1.actors_["1037ui_story"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_1) and arg_316_1.var_.characterEffect1037ui_story == nil then
				arg_316_1.var_.characterEffect1037ui_story = var_319_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.2

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_2 and not isNil(var_319_1) then
				if arg_316_1.var_.characterEffect1037ui_story and not isNil(var_319_1) then
					arg_316_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= 0 + var_319_2 and arg_316_1.time_ < 0 + var_319_2 + arg_319_0 and not isNil(var_319_1) and arg_316_1.var_.characterEffect1037ui_story then
				arg_316_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action6_1")
			end

			local var_319_4 = 0
			local var_319_5 = 0.825

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_4 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_6 = arg_316_1:GetWordFromCfg(103704079)
				local var_319_7 = arg_316_1:FormatText(var_319_6.content)

				arg_316_1.text_.text = var_319_7

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_9 = 33 <= 0 and var_319_5 or var_319_5 * (utf8.len(var_319_7) / 33)

				if (33 <= 0 and var_319_5 or var_319_5 * (utf8.len(var_319_7) / 33)) > 0 and var_319_5 < var_319_9 then
					arg_316_1.talkMaxDuration = var_319_9

					if var_319_9 + var_319_4 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_9 + var_319_4
					end
				end

				arg_316_1.text_.text = var_319_7
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704079", "story_v_side_old_103704.awb") ~= 0 then
					local var_319_10 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704079", "story_v_side_old_103704.awb") / 1000

					if var_319_10 + var_319_4 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_10 + var_319_4
					end

					if var_319_6.prefab_name ~= "" and arg_316_1.actors_[var_319_6.prefab_name] ~= nil then
						local var_319_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_6.prefab_name].transform, "story_v_side_old_103704", "103704079", "story_v_side_old_103704.awb")

						arg_316_1:RecordAudio("103704079", var_319_11)
						arg_316_1:RecordAudio("103704079", var_319_11)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704079", "story_v_side_old_103704.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704079", "story_v_side_old_103704.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_12 = math.max(var_319_5, arg_316_1.talkMaxDuration)

			if var_319_4 <= arg_316_1.time_ and arg_316_1.time_ < var_319_4 + var_319_12 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_4) / var_319_12

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_4 + var_319_12 and arg_316_1.time_ < var_319_4 + var_319_12 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play103704080 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 103704080
		arg_320_1.duration_ = 6.3

		local var_320_0 = {
			ja = 2.566,
			ko = 5.566,
			en = 6.3
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
				arg_320_0:Play103704081(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(arg_320_1.actors_["1037ui_story"]) and arg_320_1.var_.characterEffect1037ui_story == nil then
				arg_320_1.var_.characterEffect1037ui_story = arg_320_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_0 = 0.2

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 and not isNil(arg_320_1.actors_["1037ui_story"]) then
				if arg_320_1.var_.characterEffect1037ui_story and not isNil(arg_320_1.actors_["1037ui_story"]) then
					arg_320_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_320_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_320_1.time_ - 0) / var_323_0)
				end
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 and not isNil(arg_320_1.actors_["1037ui_story"]) and arg_320_1.var_.characterEffect1037ui_story then
				arg_320_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_320_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_323_1 = 0
			local var_323_2 = 0.5

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_3 = arg_320_1:GetWordFromCfg(103704080)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_6 = 20 <= 0 and var_323_2 or var_323_2 * (utf8.len(var_323_4) / 20)

				if (20 <= 0 and var_323_2 or var_323_2 * (utf8.len(var_323_4) / 20)) > 0 and var_323_2 < var_323_6 then
					arg_320_1.talkMaxDuration = var_323_6

					if var_323_6 + var_323_1 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_6 + var_323_1
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704080", "story_v_side_old_103704.awb") ~= 0 then
					local var_323_7 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704080", "story_v_side_old_103704.awb") / 1000

					if var_323_7 + var_323_1 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_1
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_side_old_103704", "103704080", "story_v_side_old_103704.awb")

						arg_320_1:RecordAudio("103704080", var_323_8)
						arg_320_1:RecordAudio("103704080", var_323_8)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704080", "story_v_side_old_103704.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704080", "story_v_side_old_103704.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_9 = math.max(var_323_2, arg_320_1.talkMaxDuration)

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_9 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_1) / var_323_9

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_1 + var_323_9 and arg_320_1.time_ < var_323_1 + var_323_9 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play103704081 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 103704081
		arg_324_1.duration_ = 6.4

		local var_324_0 = {
			ja = 6.4,
			ko = 4.533,
			en = 3.7
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
				arg_324_0:Play103704082(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["1037ui_story"]) and arg_324_1.var_.characterEffect1037ui_story == nil then
				arg_324_1.var_.characterEffect1037ui_story = arg_324_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_0 = 0.2

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["1037ui_story"]) then
				if arg_324_1.var_.characterEffect1037ui_story and not isNil(arg_324_1.actors_["1037ui_story"]) then
					arg_324_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["1037ui_story"]) and arg_324_1.var_.characterEffect1037ui_story then
				arg_324_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action464")
			end

			local var_327_2 = 0
			local var_327_3 = 0.275

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_2 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_4 = arg_324_1:GetWordFromCfg(103704081)
				local var_327_5 = arg_324_1:FormatText(var_327_4.content)

				arg_324_1.text_.text = var_327_5

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_7 = 11 <= 0 and var_327_3 or var_327_3 * (utf8.len(var_327_5) / 11)

				if (11 <= 0 and var_327_3 or var_327_3 * (utf8.len(var_327_5) / 11)) > 0 and var_327_3 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_2 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_2
					end
				end

				arg_324_1.text_.text = var_327_5
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704081", "story_v_side_old_103704.awb") ~= 0 then
					local var_327_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704081", "story_v_side_old_103704.awb") / 1000

					if var_327_8 + var_327_2 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_8 + var_327_2
					end

					if var_327_4.prefab_name ~= "" and arg_324_1.actors_[var_327_4.prefab_name] ~= nil then
						local var_327_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_4.prefab_name].transform, "story_v_side_old_103704", "103704081", "story_v_side_old_103704.awb")

						arg_324_1:RecordAudio("103704081", var_327_9)
						arg_324_1:RecordAudio("103704081", var_327_9)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704081", "story_v_side_old_103704.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704081", "story_v_side_old_103704.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_10 = math.max(var_327_3, arg_324_1.talkMaxDuration)

			if var_327_2 <= arg_324_1.time_ and arg_324_1.time_ < var_327_2 + var_327_10 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_2) / var_327_10

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_2 + var_327_10 and arg_324_1.time_ < var_327_2 + var_327_10 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play103704082 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 103704082
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play103704083(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["1037ui_story"]) and arg_328_1.var_.characterEffect1037ui_story == nil then
				arg_328_1.var_.characterEffect1037ui_story = arg_328_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_0 = 0.2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["1037ui_story"]) then
				if arg_328_1.var_.characterEffect1037ui_story and not isNil(arg_328_1.actors_["1037ui_story"]) then
					arg_328_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_328_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_328_1.time_ - 0) / var_331_0)
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["1037ui_story"]) and arg_328_1.var_.characterEffect1037ui_story then
				arg_328_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_328_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_331_1 = 0
			local var_331_2 = 1.25

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_3 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(103704082).content)

				arg_328_1.text_.text = var_331_3

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 50 <= 0 and var_331_2 or var_331_2 * (utf8.len(var_331_3) / 50)

				if (50 <= 0 and var_331_2 or var_331_2 * (utf8.len(var_331_3) / 50)) > 0 and var_331_2 < var_331_5 then
					arg_328_1.talkMaxDuration = var_331_5

					if var_331_5 + var_331_1 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_5 + var_331_1
					end
				end

				arg_328_1.text_.text = var_331_3
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_6 = math.max(var_331_2, arg_328_1.talkMaxDuration)

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_6 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_1) / var_331_6

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_1 + var_331_6 and arg_328_1.time_ < var_331_1 + var_331_6 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play103704083 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 103704083
		arg_332_1.duration_ = 3.7

		local var_332_0 = {
			ja = 3.7,
			ko = 2.6,
			en = 1.866
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
				arg_332_0:Play103704084(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0.225

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_1 = arg_332_1:GetWordFromCfg(103704083)
				local var_335_2 = arg_332_1:FormatText(var_335_1.content)

				arg_332_1.text_.text = var_335_2

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_4 = 9 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 9)

				if (9 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 9)) > 0 and var_335_0 < var_335_4 then
					arg_332_1.talkMaxDuration = var_335_4

					if var_335_4 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_4 + 0
					end
				end

				arg_332_1.text_.text = var_335_2
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704083", "story_v_side_old_103704.awb") ~= 0 then
					local var_335_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704083", "story_v_side_old_103704.awb") / 1000

					if var_335_5 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_5 + 0
					end

					if var_335_1.prefab_name ~= "" and arg_332_1.actors_[var_335_1.prefab_name] ~= nil then
						local var_335_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_1.prefab_name].transform, "story_v_side_old_103704", "103704083", "story_v_side_old_103704.awb")

						arg_332_1:RecordAudio("103704083", var_335_6)
						arg_332_1:RecordAudio("103704083", var_335_6)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704083", "story_v_side_old_103704.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704083", "story_v_side_old_103704.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_7 = math.max(var_335_0, arg_332_1.talkMaxDuration)

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_7 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - 0) / var_335_7

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= 0 + var_335_7 and arg_332_1.time_ < 0 + var_335_7 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play103704084 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 103704084
		arg_336_1.duration_ = 2.6

		local var_336_0 = {
			ja = 1.833,
			ko = 1.766,
			en = 2.6
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
				arg_336_0:Play103704085(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos1037ui_story = arg_336_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_339_0 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 then
				arg_336_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_336_1.time_ - 0) / var_339_0)
				arg_336_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1037ui_story"].transform.position).z)
				arg_336_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1037ui_story"].transform.localEulerAngles = arg_336_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 then
				arg_336_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_336_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1037ui_story"].transform.position).z)
				arg_336_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1037ui_story"].transform.localEulerAngles = arg_336_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:AudioAction("play", "effect", "se_story_side_1037", "se_story_1037_electric", "")
			end

			local var_339_2 = 0
			local var_339_3 = 0.3

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_2 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[190].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_4 = arg_336_1:GetWordFromCfg(103704084)
				local var_339_5 = arg_336_1:FormatText(var_339_4.content)

				arg_336_1.text_.text = var_339_5

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_7 = 12 <= 0 and var_339_3 or var_339_3 * (utf8.len(var_339_5) / 12)

				if (12 <= 0 and var_339_3 or var_339_3 * (utf8.len(var_339_5) / 12)) > 0 and var_339_3 < var_339_7 then
					arg_336_1.talkMaxDuration = var_339_7

					if var_339_7 + var_339_2 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_2
					end
				end

				arg_336_1.text_.text = var_339_5
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704084", "story_v_side_old_103704.awb") ~= 0 then
					local var_339_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704084", "story_v_side_old_103704.awb") / 1000

					if var_339_8 + var_339_2 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_8 + var_339_2
					end

					if var_339_4.prefab_name ~= "" and arg_336_1.actors_[var_339_4.prefab_name] ~= nil then
						local var_339_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_4.prefab_name].transform, "story_v_side_old_103704", "103704084", "story_v_side_old_103704.awb")

						arg_336_1:RecordAudio("103704084", var_339_9)
						arg_336_1:RecordAudio("103704084", var_339_9)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704084", "story_v_side_old_103704.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704084", "story_v_side_old_103704.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_10 = math.max(var_339_3, arg_336_1.talkMaxDuration)

			if var_339_2 <= arg_336_1.time_ and arg_336_1.time_ < var_339_2 + var_339_10 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_2) / var_339_10

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_2 + var_339_10 and arg_336_1.time_ < var_339_2 + var_339_10 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play103704085 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 103704085
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play103704086(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0.333333333333333 < arg_340_1.time_ and arg_340_1.time_ <= 0.333333333333333 + arg_343_0 then
				arg_340_1:AudioAction("play", "effect", "se_story_side_1037", "se_story_1037_fall", "")
			end

			local var_343_1 = 0
			local var_343_2 = 0.875

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_3 = arg_340_1:FormatText(arg_340_1:GetWordFromCfg(103704085).content)

				arg_340_1.text_.text = var_343_3

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_5 = 35 <= 0 and var_343_2 or var_343_2 * (utf8.len(var_343_3) / 35)

				if (35 <= 0 and var_343_2 or var_343_2 * (utf8.len(var_343_3) / 35)) > 0 and var_343_2 < var_343_5 then
					arg_340_1.talkMaxDuration = var_343_5

					if var_343_5 + var_343_1 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_5 + var_343_1
					end
				end

				arg_340_1.text_.text = var_343_3
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_6 = math.max(var_343_2, arg_340_1.talkMaxDuration)

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_6 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_1) / var_343_6

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_1 + var_343_6 and arg_340_1.time_ < var_343_1 + var_343_6 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play103704086 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 103704086
		arg_344_1.duration_ = 2.4

		local var_344_0 = {
			ja = 2.3,
			ko = 2.4,
			en = 2.266
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
				arg_344_0:Play103704087(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0.225

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_1 = arg_344_1:GetWordFromCfg(103704086)
				local var_347_2 = arg_344_1:FormatText(var_347_1.content)

				arg_344_1.text_.text = var_347_2

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_4 = 9 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_2) / 9)

				if (9 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_2) / 9)) > 0 and var_347_0 < var_347_4 then
					arg_344_1.talkMaxDuration = var_347_4

					if var_347_4 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_4 + 0
					end
				end

				arg_344_1.text_.text = var_347_2
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704086", "story_v_side_old_103704.awb") ~= 0 then
					local var_347_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704086", "story_v_side_old_103704.awb") / 1000

					if var_347_5 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + 0
					end

					if var_347_1.prefab_name ~= "" and arg_344_1.actors_[var_347_1.prefab_name] ~= nil then
						local var_347_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_1.prefab_name].transform, "story_v_side_old_103704", "103704086", "story_v_side_old_103704.awb")

						arg_344_1:RecordAudio("103704086", var_347_6)
						arg_344_1:RecordAudio("103704086", var_347_6)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704086", "story_v_side_old_103704.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704086", "story_v_side_old_103704.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_7 = math.max(var_347_0, arg_344_1.talkMaxDuration)

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_7 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - 0) / var_347_7

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= 0 + var_347_7 and arg_344_1.time_ < 0 + var_347_7 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play103704087 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 103704087
		arg_348_1.duration_ = 2

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play103704088(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPos1037ui_story = arg_348_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_351_0 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 then
				arg_348_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_348_1.time_ - 0) / var_351_0)
				arg_348_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_348_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1037ui_story"].transform.position).z)
				arg_348_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_348_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_348_1.actors_["1037ui_story"].transform.localEulerAngles = arg_348_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 then
				arg_348_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_348_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_348_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1037ui_story"].transform.position).z)
				arg_348_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_348_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_348_1.actors_["1037ui_story"].transform.localEulerAngles = arg_348_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_351_1 = arg_348_1.actors_["1037ui_story"]

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(var_351_1) and arg_348_1.var_.characterEffect1037ui_story == nil then
				arg_348_1.var_.characterEffect1037ui_story = var_351_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_2 = 0.2

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_2 and not isNil(var_351_1) then
				if arg_348_1.var_.characterEffect1037ui_story and not isNil(var_351_1) then
					arg_348_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= 0 + var_351_2 and arg_348_1.time_ < 0 + var_351_2 + arg_351_0 and not isNil(var_351_1) and arg_348_1.var_.characterEffect1037ui_story then
				arg_348_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_1")
			end

			local var_351_4 = 0
			local var_351_5 = 0.15

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_4 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_6 = arg_348_1:GetWordFromCfg(103704087)
				local var_351_7 = arg_348_1:FormatText(var_351_6.content)

				arg_348_1.text_.text = var_351_7

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_9 = 6 <= 0 and var_351_5 or var_351_5 * (utf8.len(var_351_7) / 6)

				if (6 <= 0 and var_351_5 or var_351_5 * (utf8.len(var_351_7) / 6)) > 0 and var_351_5 < var_351_9 then
					arg_348_1.talkMaxDuration = var_351_9

					if var_351_9 + var_351_4 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_9 + var_351_4
					end
				end

				arg_348_1.text_.text = var_351_7
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704087", "story_v_side_old_103704.awb") ~= 0 then
					local var_351_10 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704087", "story_v_side_old_103704.awb") / 1000

					if var_351_10 + var_351_4 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_10 + var_351_4
					end

					if var_351_6.prefab_name ~= "" and arg_348_1.actors_[var_351_6.prefab_name] ~= nil then
						local var_351_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_6.prefab_name].transform, "story_v_side_old_103704", "103704087", "story_v_side_old_103704.awb")

						arg_348_1:RecordAudio("103704087", var_351_11)
						arg_348_1:RecordAudio("103704087", var_351_11)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704087", "story_v_side_old_103704.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704087", "story_v_side_old_103704.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_12 = math.max(var_351_5, arg_348_1.talkMaxDuration)

			if var_351_4 <= arg_348_1.time_ and arg_348_1.time_ < var_351_4 + var_351_12 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_4) / var_351_12

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_4 + var_351_12 and arg_348_1.time_ < var_351_4 + var_351_12 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play103704088 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 103704088
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play103704089(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["1037ui_story"]) and arg_352_1.var_.characterEffect1037ui_story == nil then
				arg_352_1.var_.characterEffect1037ui_story = arg_352_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_0 = 0.2

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["1037ui_story"]) then
				if arg_352_1.var_.characterEffect1037ui_story and not isNil(arg_352_1.actors_["1037ui_story"]) then
					arg_352_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_352_1.time_ - 0) / var_355_0)
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["1037ui_story"]) and arg_352_1.var_.characterEffect1037ui_story then
				arg_352_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_355_1 = 0
			local var_355_2 = 0.525

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, false)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_3 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(103704088).content)

				arg_352_1.text_.text = var_355_3

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 21 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 21)

				if (21 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 21)) > 0 and var_355_2 < var_355_5 then
					arg_352_1.talkMaxDuration = var_355_5

					if var_355_5 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + var_355_1
					end
				end

				arg_352_1.text_.text = var_355_3
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_6 = math.max(var_355_2, arg_352_1.talkMaxDuration)

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_6 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_1) / var_355_6

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_1 + var_355_6 and arg_352_1.time_ < var_355_1 + var_355_6 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play103704089 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 103704089
		arg_356_1.duration_ = 7.03

		local var_356_0 = {
			ja = 4.533,
			ko = 7.033,
			en = 3.533
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
				arg_356_0:Play103704090(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(arg_356_1.actors_["1037ui_story"]) and arg_356_1.var_.characterEffect1037ui_story == nil then
				arg_356_1.var_.characterEffect1037ui_story = arg_356_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_0 = 0.2

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 and not isNil(arg_356_1.actors_["1037ui_story"]) then
				if arg_356_1.var_.characterEffect1037ui_story and not isNil(arg_356_1.actors_["1037ui_story"]) then
					arg_356_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 and not isNil(arg_356_1.actors_["1037ui_story"]) and arg_356_1.var_.characterEffect1037ui_story then
				arg_356_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action443")
			end

			local var_359_2 = 0
			local var_359_3 = 0.525

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_2 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_4 = arg_356_1:GetWordFromCfg(103704089)
				local var_359_5 = arg_356_1:FormatText(var_359_4.content)

				arg_356_1.text_.text = var_359_5

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_7 = 21 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_5) / 21)

				if (21 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_5) / 21)) > 0 and var_359_3 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_2 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_2
					end
				end

				arg_356_1.text_.text = var_359_5
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704089", "story_v_side_old_103704.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704089", "story_v_side_old_103704.awb") / 1000

					if var_359_8 + var_359_2 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_2
					end

					if var_359_4.prefab_name ~= "" and arg_356_1.actors_[var_359_4.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_4.prefab_name].transform, "story_v_side_old_103704", "103704089", "story_v_side_old_103704.awb")

						arg_356_1:RecordAudio("103704089", var_359_9)
						arg_356_1:RecordAudio("103704089", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704089", "story_v_side_old_103704.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704089", "story_v_side_old_103704.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_3, arg_356_1.talkMaxDuration)

			if var_359_2 <= arg_356_1.time_ and arg_356_1.time_ < var_359_2 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_2) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_2 + var_359_10 and arg_356_1.time_ < var_359_2 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play103704090 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 103704090
		arg_360_1.duration_ = 4.7

		local var_360_0 = {
			ja = 4.633,
			ko = 4.7,
			en = 4.5
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
				arg_360_0:Play103704091(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_363_0 = 0
			local var_363_1 = 0.575

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_2 = arg_360_1:GetWordFromCfg(103704090)
				local var_363_3 = arg_360_1:FormatText(var_363_2.content)

				arg_360_1.text_.text = var_363_3

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 23 <= 0 and var_363_1 or var_363_1 * (utf8.len(var_363_3) / 23)

				if (23 <= 0 and var_363_1 or var_363_1 * (utf8.len(var_363_3) / 23)) > 0 and var_363_1 < var_363_5 then
					arg_360_1.talkMaxDuration = var_363_5

					if var_363_5 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_3
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704090", "story_v_side_old_103704.awb") ~= 0 then
					local var_363_6 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704090", "story_v_side_old_103704.awb") / 1000

					if var_363_6 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_6 + var_363_0
					end

					if var_363_2.prefab_name ~= "" and arg_360_1.actors_[var_363_2.prefab_name] ~= nil then
						local var_363_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_2.prefab_name].transform, "story_v_side_old_103704", "103704090", "story_v_side_old_103704.awb")

						arg_360_1:RecordAudio("103704090", var_363_7)
						arg_360_1:RecordAudio("103704090", var_363_7)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704090", "story_v_side_old_103704.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704090", "story_v_side_old_103704.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_8 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_8 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_8

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_8 and arg_360_1.time_ < var_363_0 + var_363_8 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play103704091 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 103704091
		arg_364_1.duration_ = 7.4

		local var_364_0 = {
			ja = 7.4,
			ko = 4.8,
			en = 4.666
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
				arg_364_0:Play103704092(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos1037ui_story = arg_364_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_367_0 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_0 then
				arg_364_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1037ui_story, Vector3.New(-0.7, -1.09, -5.81), (arg_364_1.time_ - 0) / var_367_0)
				arg_364_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_364_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1037ui_story"].transform.position).z)
				arg_364_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_364_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_364_1.actors_["1037ui_story"].transform.localEulerAngles = arg_364_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_364_1.time_ >= 0 + var_367_0 and arg_364_1.time_ < 0 + var_367_0 + arg_367_0 then
				arg_364_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.09, -5.81)
				arg_364_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_364_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1037ui_story"].transform.position).z)
				arg_364_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_364_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_364_1.actors_["1037ui_story"].transform.localEulerAngles = arg_364_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_367_1 = "1036ui_story"

			if arg_364_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_367_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_364_1.stage_.transform)

				var_367_2.name = var_367_1
				var_367_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_364_1.actors_[var_367_1] = var_367_2

				local var_367_3 = var_367_2:GetComponentInChildren(typeof(CharacterEffect))

				var_367_3.enabled = true

				local var_367_4 = GameObjectTools.GetOrAddComponent(var_367_2, typeof(DynamicBoneHelper))

				if var_367_4 then
					var_367_4:EnableDynamicBone(false)
				end

				arg_364_1:ShowWeapon(var_367_3.transform, false)

				arg_364_1.var_[var_367_1 .. "Animator"] = var_367_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_364_1.var_[var_367_1 .. "Animator"].applyRootMotion = true
				arg_364_1.var_[var_367_1 .. "LipSync"] = var_367_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_367_5 = arg_364_1.actors_["1036ui_story"].transform

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos1036ui_story = var_367_5.localPosition
			end

			local var_367_6 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_6 then
				var_367_5.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1036ui_story, Vector3.New(0.7, -1.09, -5.78), (arg_364_1.time_ - 0) / var_367_6)
				var_367_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_367_5.position).x, (manager.ui.mainCamera.transform.position - var_367_5.position).y, (manager.ui.mainCamera.transform.position - var_367_5.position).z)
				var_367_5.localEulerAngles.z = 0
				var_367_5.localEulerAngles.x = 0
				var_367_5.localEulerAngles = var_367_5.localEulerAngles
			end

			if arg_364_1.time_ >= 0 + var_367_6 and arg_364_1.time_ < 0 + var_367_6 + arg_367_0 then
				var_367_5.localPosition = Vector3.New(0.7, -1.09, -5.78)
				var_367_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_367_5.position).x, (manager.ui.mainCamera.transform.position - var_367_5.position).y, (manager.ui.mainCamera.transform.position - var_367_5.position).z)
				var_367_5.localEulerAngles.z = 0
				var_367_5.localEulerAngles.x = 0
				var_367_5.localEulerAngles = var_367_5.localEulerAngles
			end

			local var_367_7 = arg_364_1.actors_["1037ui_story"]

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(var_367_7) and arg_364_1.var_.characterEffect1037ui_story == nil then
				arg_364_1.var_.characterEffect1037ui_story = var_367_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_8 = 0.2

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_8 and not isNil(var_367_7) then
				if arg_364_1.var_.characterEffect1037ui_story and not isNil(var_367_7) then
					arg_364_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_364_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_364_1.time_ - 0) / var_367_8)
				end
			end

			if arg_364_1.time_ >= 0 + var_367_8 and arg_364_1.time_ < 0 + var_367_8 + arg_367_0 and not isNil(var_367_7) and arg_364_1.var_.characterEffect1037ui_story then
				arg_364_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_364_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_367_9 = arg_364_1.actors_["1036ui_story"]

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(var_367_9) and arg_364_1.var_.characterEffect1036ui_story == nil then
				arg_364_1.var_.characterEffect1036ui_story = var_367_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_10 = 0.2

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_10 and not isNil(var_367_9) then
				if arg_364_1.var_.characterEffect1036ui_story and not isNil(var_367_9) then
					arg_364_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_364_1.time_ >= 0 + var_367_10 and arg_364_1.time_ < 0 + var_367_10 + arg_367_0 and not isNil(var_367_9) and arg_364_1.var_.characterEffect1036ui_story then
				arg_364_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_367_12 = 0
			local var_367_13 = 0.55

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_12 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_14 = arg_364_1:GetWordFromCfg(103704091)
				local var_367_15 = arg_364_1:FormatText(var_367_14.content)

				arg_364_1.text_.text = var_367_15

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_17 = 22 <= 0 and var_367_13 or var_367_13 * (utf8.len(var_367_15) / 22)

				if (22 <= 0 and var_367_13 or var_367_13 * (utf8.len(var_367_15) / 22)) > 0 and var_367_13 < var_367_17 then
					arg_364_1.talkMaxDuration = var_367_17

					if var_367_17 + var_367_12 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_17 + var_367_12
					end
				end

				arg_364_1.text_.text = var_367_15
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704091", "story_v_side_old_103704.awb") ~= 0 then
					local var_367_18 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704091", "story_v_side_old_103704.awb") / 1000

					if var_367_18 + var_367_12 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_18 + var_367_12
					end

					if var_367_14.prefab_name ~= "" and arg_364_1.actors_[var_367_14.prefab_name] ~= nil then
						local var_367_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_14.prefab_name].transform, "story_v_side_old_103704", "103704091", "story_v_side_old_103704.awb")

						arg_364_1:RecordAudio("103704091", var_367_19)
						arg_364_1:RecordAudio("103704091", var_367_19)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704091", "story_v_side_old_103704.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704091", "story_v_side_old_103704.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_20 = math.max(var_367_13, arg_364_1.talkMaxDuration)

			if var_367_12 <= arg_364_1.time_ and arg_364_1.time_ < var_367_12 + var_367_20 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_12) / var_367_20

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_12 + var_367_20 and arg_364_1.time_ < var_367_12 + var_367_20 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play103704092 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 103704092
		arg_368_1.duration_ = 10.07

		local var_368_0 = {
			ja = 10.066,
			ko = 6.533,
			en = 6.366
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
				arg_368_0:Play103704093(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_371_0 = 0
			local var_371_1 = 0.75

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_2 = arg_368_1:GetWordFromCfg(103704092)
				local var_371_3 = arg_368_1:FormatText(var_371_2.content)

				arg_368_1.text_.text = var_371_3

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 30 <= 0 and var_371_1 or var_371_1 * (utf8.len(var_371_3) / 30)

				if (30 <= 0 and var_371_1 or var_371_1 * (utf8.len(var_371_3) / 30)) > 0 and var_371_1 < var_371_5 then
					arg_368_1.talkMaxDuration = var_371_5

					if var_371_5 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_3
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704092", "story_v_side_old_103704.awb") ~= 0 then
					local var_371_6 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704092", "story_v_side_old_103704.awb") / 1000

					if var_371_6 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_6 + var_371_0
					end

					if var_371_2.prefab_name ~= "" and arg_368_1.actors_[var_371_2.prefab_name] ~= nil then
						local var_371_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_2.prefab_name].transform, "story_v_side_old_103704", "103704092", "story_v_side_old_103704.awb")

						arg_368_1:RecordAudio("103704092", var_371_7)
						arg_368_1:RecordAudio("103704092", var_371_7)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704092", "story_v_side_old_103704.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704092", "story_v_side_old_103704.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_8 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_8 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_8

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_8 and arg_368_1.time_ < var_371_0 + var_371_8 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play103704093 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 103704093
		arg_372_1.duration_ = 9.87

		local var_372_0 = {
			ja = 7.366,
			ko = 9.866,
			en = 7.1
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
				arg_372_0:Play103704094(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["1036ui_story"]) and arg_372_1.var_.characterEffect1036ui_story == nil then
				arg_372_1.var_.characterEffect1036ui_story = arg_372_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_0 = 0.2

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["1036ui_story"]) then
				if arg_372_1.var_.characterEffect1036ui_story and not isNil(arg_372_1.actors_["1036ui_story"]) then
					arg_372_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_372_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_372_1.time_ - 0) / var_375_0)
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["1036ui_story"]) and arg_372_1.var_.characterEffect1036ui_story then
				arg_372_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_372_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_375_1 = 0
			local var_375_2 = 0.675

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[52].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6061")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_3 = arg_372_1:GetWordFromCfg(103704093)
				local var_375_4 = arg_372_1:FormatText(var_375_3.content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_6 = 27 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_4) / 27)

				if (27 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_4) / 27)) > 0 and var_375_2 < var_375_6 then
					arg_372_1.talkMaxDuration = var_375_6

					if var_375_6 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_6 + var_375_1
					end
				end

				arg_372_1.text_.text = var_375_4
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704093", "story_v_side_old_103704.awb") ~= 0 then
					local var_375_7 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704093", "story_v_side_old_103704.awb") / 1000

					if var_375_7 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_7 + var_375_1
					end

					if var_375_3.prefab_name ~= "" and arg_372_1.actors_[var_375_3.prefab_name] ~= nil then
						local var_375_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_3.prefab_name].transform, "story_v_side_old_103704", "103704093", "story_v_side_old_103704.awb")

						arg_372_1:RecordAudio("103704093", var_375_8)
						arg_372_1:RecordAudio("103704093", var_375_8)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704093", "story_v_side_old_103704.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704093", "story_v_side_old_103704.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_9 = math.max(var_375_2, arg_372_1.talkMaxDuration)

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_9 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_1) / var_375_9

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_1 + var_375_9 and arg_372_1.time_ < var_375_1 + var_375_9 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play103704094 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 103704094
		arg_376_1.duration_ = 4.33

		local var_376_0 = {
			ja = 2.933,
			ko = 4.333,
			en = 3.133
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
				arg_376_0:Play103704095(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["1036ui_story"]) and arg_376_1.var_.characterEffect1036ui_story == nil then
				arg_376_1.var_.characterEffect1036ui_story = arg_376_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_0 = 0.2

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["1036ui_story"]) then
				if arg_376_1.var_.characterEffect1036ui_story and not isNil(arg_376_1.actors_["1036ui_story"]) then
					arg_376_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["1036ui_story"]) and arg_376_1.var_.characterEffect1036ui_story then
				arg_376_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_379_2 = 0
			local var_379_3 = 0.35

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_2 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_4 = arg_376_1:GetWordFromCfg(103704094)
				local var_379_5 = arg_376_1:FormatText(var_379_4.content)

				arg_376_1.text_.text = var_379_5

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_7 = 14 <= 0 and var_379_3 or var_379_3 * (utf8.len(var_379_5) / 14)

				if (14 <= 0 and var_379_3 or var_379_3 * (utf8.len(var_379_5) / 14)) > 0 and var_379_3 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_2 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_2
					end
				end

				arg_376_1.text_.text = var_379_5
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704094", "story_v_side_old_103704.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704094", "story_v_side_old_103704.awb") / 1000

					if var_379_8 + var_379_2 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_2
					end

					if var_379_4.prefab_name ~= "" and arg_376_1.actors_[var_379_4.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_4.prefab_name].transform, "story_v_side_old_103704", "103704094", "story_v_side_old_103704.awb")

						arg_376_1:RecordAudio("103704094", var_379_9)
						arg_376_1:RecordAudio("103704094", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704094", "story_v_side_old_103704.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704094", "story_v_side_old_103704.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_10 = math.max(var_379_3, arg_376_1.talkMaxDuration)

			if var_379_2 <= arg_376_1.time_ and arg_376_1.time_ < var_379_2 + var_379_10 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_2) / var_379_10

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_2 + var_379_10 and arg_376_1.time_ < var_379_2 + var_379_10 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play103704095 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 103704095
		arg_380_1.duration_ = 5.77

		local var_380_0 = {
			ja = 4.666,
			ko = 5.766,
			en = 2.666
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play103704096(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["1036ui_story"]) and arg_380_1.var_.characterEffect1036ui_story == nil then
				arg_380_1.var_.characterEffect1036ui_story = arg_380_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_0 = 0.2

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["1036ui_story"]) then
				if arg_380_1.var_.characterEffect1036ui_story and not isNil(arg_380_1.actors_["1036ui_story"]) then
					arg_380_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_380_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_380_1.time_ - 0) / var_383_0)
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["1036ui_story"]) and arg_380_1.var_.characterEffect1036ui_story then
				arg_380_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_380_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_383_1 = arg_380_1.actors_["1037ui_story"]

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(var_383_1) and arg_380_1.var_.characterEffect1037ui_story == nil then
				arg_380_1.var_.characterEffect1037ui_story = var_383_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.2

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_2 and not isNil(var_383_1) then
				if arg_380_1.var_.characterEffect1037ui_story and not isNil(var_383_1) then
					arg_380_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= 0 + var_383_2 and arg_380_1.time_ < 0 + var_383_2 + arg_383_0 and not isNil(var_383_1) and arg_380_1.var_.characterEffect1037ui_story then
				arg_380_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action432")
			end

			local var_383_4 = 0
			local var_383_5 = 0.4

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_4 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_6 = arg_380_1:GetWordFromCfg(103704095)
				local var_383_7 = arg_380_1:FormatText(var_383_6.content)

				arg_380_1.text_.text = var_383_7

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_9 = 16 <= 0 and var_383_5 or var_383_5 * (utf8.len(var_383_7) / 16)

				if (16 <= 0 and var_383_5 or var_383_5 * (utf8.len(var_383_7) / 16)) > 0 and var_383_5 < var_383_9 then
					arg_380_1.talkMaxDuration = var_383_9

					if var_383_9 + var_383_4 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_9 + var_383_4
					end
				end

				arg_380_1.text_.text = var_383_7
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704095", "story_v_side_old_103704.awb") ~= 0 then
					local var_383_10 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704095", "story_v_side_old_103704.awb") / 1000

					if var_383_10 + var_383_4 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_10 + var_383_4
					end

					if var_383_6.prefab_name ~= "" and arg_380_1.actors_[var_383_6.prefab_name] ~= nil then
						local var_383_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_6.prefab_name].transform, "story_v_side_old_103704", "103704095", "story_v_side_old_103704.awb")

						arg_380_1:RecordAudio("103704095", var_383_11)
						arg_380_1:RecordAudio("103704095", var_383_11)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704095", "story_v_side_old_103704.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704095", "story_v_side_old_103704.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_12 = math.max(var_383_5, arg_380_1.talkMaxDuration)

			if var_383_4 <= arg_380_1.time_ and arg_380_1.time_ < var_383_4 + var_383_12 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_4) / var_383_12

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_4 + var_383_12 and arg_380_1.time_ < var_383_4 + var_383_12 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play103704096 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 103704096
		arg_384_1.duration_ = 7.07

		local var_384_0 = {
			ja = 7.066,
			ko = 5.166,
			en = 5.266
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
				arg_384_0:Play103704097(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(arg_384_1.actors_["1037ui_story"]) and arg_384_1.var_.characterEffect1037ui_story == nil then
				arg_384_1.var_.characterEffect1037ui_story = arg_384_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_0 = 0.2

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 and not isNil(arg_384_1.actors_["1037ui_story"]) then
				if arg_384_1.var_.characterEffect1037ui_story and not isNil(arg_384_1.actors_["1037ui_story"]) then
					arg_384_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_384_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_384_1.time_ - 0) / var_387_0)
				end
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 and not isNil(arg_384_1.actors_["1037ui_story"]) and arg_384_1.var_.characterEffect1037ui_story then
				arg_384_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_384_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_387_1 = arg_384_1.actors_["1036ui_story"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_1) and arg_384_1.var_.characterEffect1036ui_story == nil then
				arg_384_1.var_.characterEffect1036ui_story = var_387_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.2

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_2 and not isNil(var_387_1) then
				if arg_384_1.var_.characterEffect1036ui_story and not isNil(var_387_1) then
					arg_384_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= 0 + var_387_2 and arg_384_1.time_ < 0 + var_387_2 + arg_387_0 and not isNil(var_387_1) and arg_384_1.var_.characterEffect1036ui_story then
				arg_384_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action454")
			end

			local var_387_4 = 0
			local var_387_5 = 0.5

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_4 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_6 = arg_384_1:GetWordFromCfg(103704096)
				local var_387_7 = arg_384_1:FormatText(var_387_6.content)

				arg_384_1.text_.text = var_387_7

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_9 = 20 <= 0 and var_387_5 or var_387_5 * (utf8.len(var_387_7) / 20)

				if (20 <= 0 and var_387_5 or var_387_5 * (utf8.len(var_387_7) / 20)) > 0 and var_387_5 < var_387_9 then
					arg_384_1.talkMaxDuration = var_387_9

					if var_387_9 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_9 + var_387_4
					end
				end

				arg_384_1.text_.text = var_387_7
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704096", "story_v_side_old_103704.awb") ~= 0 then
					local var_387_10 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704096", "story_v_side_old_103704.awb") / 1000

					if var_387_10 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_10 + var_387_4
					end

					if var_387_6.prefab_name ~= "" and arg_384_1.actors_[var_387_6.prefab_name] ~= nil then
						local var_387_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_6.prefab_name].transform, "story_v_side_old_103704", "103704096", "story_v_side_old_103704.awb")

						arg_384_1:RecordAudio("103704096", var_387_11)
						arg_384_1:RecordAudio("103704096", var_387_11)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704096", "story_v_side_old_103704.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704096", "story_v_side_old_103704.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_12 = math.max(var_387_5, arg_384_1.talkMaxDuration)

			if var_387_4 <= arg_384_1.time_ and arg_384_1.time_ < var_387_4 + var_387_12 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_4) / var_387_12

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_4 + var_387_12 and arg_384_1.time_ < var_387_4 + var_387_12 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play103704097 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 103704097
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play103704098(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["1036ui_story"]) and arg_388_1.var_.characterEffect1036ui_story == nil then
				arg_388_1.var_.characterEffect1036ui_story = arg_388_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_0 = 0.2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["1036ui_story"]) then
				if arg_388_1.var_.characterEffect1036ui_story and not isNil(arg_388_1.actors_["1036ui_story"]) then
					arg_388_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_388_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_388_1.time_ - 0) / var_391_0)
				end
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["1036ui_story"]) and arg_388_1.var_.characterEffect1036ui_story then
				arg_388_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_388_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_391_1 = 0
			local var_391_2 = 0.75

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_3 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(103704097).content)

				arg_388_1.text_.text = var_391_3

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_5 = 30 <= 0 and var_391_2 or var_391_2 * (utf8.len(var_391_3) / 30)

				if (30 <= 0 and var_391_2 or var_391_2 * (utf8.len(var_391_3) / 30)) > 0 and var_391_2 < var_391_5 then
					arg_388_1.talkMaxDuration = var_391_5

					if var_391_5 + var_391_1 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_5 + var_391_1
					end
				end

				arg_388_1.text_.text = var_391_3
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_6 = math.max(var_391_2, arg_388_1.talkMaxDuration)

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_6 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_1) / var_391_6

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_1 + var_391_6 and arg_388_1.time_ < var_391_1 + var_391_6 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play103704098 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 103704098
		arg_392_1.duration_ = 6.77

		local var_392_0 = {
			ja = 4.8,
			ko = 4.9,
			en = 6.766
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
				arg_392_0:Play103704099(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["1036ui_story"]) and arg_392_1.var_.characterEffect1036ui_story == nil then
				arg_392_1.var_.characterEffect1036ui_story = arg_392_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_0 = 0.2

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["1036ui_story"]) then
				if arg_392_1.var_.characterEffect1036ui_story and not isNil(arg_392_1.actors_["1036ui_story"]) then
					arg_392_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["1036ui_story"]) and arg_392_1.var_.characterEffect1036ui_story then
				arg_392_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action446")
			end

			local var_395_2 = 0
			local var_395_3 = 0.375

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_2 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_4 = arg_392_1:GetWordFromCfg(103704098)
				local var_395_5 = arg_392_1:FormatText(var_395_4.content)

				arg_392_1.text_.text = var_395_5

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_7 = 15 <= 0 and var_395_3 or var_395_3 * (utf8.len(var_395_5) / 15)

				if (15 <= 0 and var_395_3 or var_395_3 * (utf8.len(var_395_5) / 15)) > 0 and var_395_3 < var_395_7 then
					arg_392_1.talkMaxDuration = var_395_7

					if var_395_7 + var_395_2 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_2
					end
				end

				arg_392_1.text_.text = var_395_5
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704098", "story_v_side_old_103704.awb") ~= 0 then
					local var_395_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704098", "story_v_side_old_103704.awb") / 1000

					if var_395_8 + var_395_2 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_8 + var_395_2
					end

					if var_395_4.prefab_name ~= "" and arg_392_1.actors_[var_395_4.prefab_name] ~= nil then
						local var_395_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_4.prefab_name].transform, "story_v_side_old_103704", "103704098", "story_v_side_old_103704.awb")

						arg_392_1:RecordAudio("103704098", var_395_9)
						arg_392_1:RecordAudio("103704098", var_395_9)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704098", "story_v_side_old_103704.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704098", "story_v_side_old_103704.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_10 = math.max(var_395_3, arg_392_1.talkMaxDuration)

			if var_395_2 <= arg_392_1.time_ and arg_392_1.time_ < var_395_2 + var_395_10 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_2) / var_395_10

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_2 + var_395_10 and arg_392_1.time_ < var_395_2 + var_395_10 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play103704099 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 103704099
		arg_396_1.duration_ = 6

		local var_396_0 = {
			ja = 5.7,
			ko = 6,
			en = 5.4
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play103704100(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.var_.moveOldPos1037ui_story = arg_396_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_399_0 = 0.001

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 then
				arg_396_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_396_1.time_ - 0) / var_399_0)
				arg_396_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_396_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["1037ui_story"].transform.position).z)
				arg_396_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_396_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_396_1.actors_["1037ui_story"].transform.localEulerAngles = arg_396_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 then
				arg_396_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_396_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_396_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_396_1.actors_["1037ui_story"].transform.position).z)
				arg_396_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_396_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_396_1.actors_["1037ui_story"].transform.localEulerAngles = arg_396_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_399_1 = arg_396_1.actors_["1036ui_story"].transform

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.var_.moveOldPos1036ui_story = var_399_1.localPosition
			end

			local var_399_2 = 0.001

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_2 then
				var_399_1.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_396_1.time_ - 0) / var_399_2)
				var_399_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_399_1.position).x, (manager.ui.mainCamera.transform.position - var_399_1.position).y, (manager.ui.mainCamera.transform.position - var_399_1.position).z)
				var_399_1.localEulerAngles.z = 0
				var_399_1.localEulerAngles.x = 0
				var_399_1.localEulerAngles = var_399_1.localEulerAngles
			end

			if arg_396_1.time_ >= 0 + var_399_2 and arg_396_1.time_ < 0 + var_399_2 + arg_399_0 then
				var_399_1.localPosition = Vector3.New(0, 100, 0)
				var_399_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_399_1.position).x, (manager.ui.mainCamera.transform.position - var_399_1.position).y, (manager.ui.mainCamera.transform.position - var_399_1.position).z)
				var_399_1.localEulerAngles.z = 0
				var_399_1.localEulerAngles.x = 0
				var_399_1.localEulerAngles = var_399_1.localEulerAngles
			end

			local var_399_3 = 0
			local var_399_4 = 0.6

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_3 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[52].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6061")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_5 = arg_396_1:GetWordFromCfg(103704099)
				local var_399_6 = arg_396_1:FormatText(var_399_5.content)

				arg_396_1.text_.text = var_399_6

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_8 = 24 <= 0 and var_399_4 or var_399_4 * (utf8.len(var_399_6) / 24)

				if (24 <= 0 and var_399_4 or var_399_4 * (utf8.len(var_399_6) / 24)) > 0 and var_399_4 < var_399_8 then
					arg_396_1.talkMaxDuration = var_399_8

					if var_399_8 + var_399_3 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_8 + var_399_3
					end
				end

				arg_396_1.text_.text = var_399_6
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704099", "story_v_side_old_103704.awb") ~= 0 then
					local var_399_9 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704099", "story_v_side_old_103704.awb") / 1000

					if var_399_9 + var_399_3 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_9 + var_399_3
					end

					if var_399_5.prefab_name ~= "" and arg_396_1.actors_[var_399_5.prefab_name] ~= nil then
						local var_399_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_5.prefab_name].transform, "story_v_side_old_103704", "103704099", "story_v_side_old_103704.awb")

						arg_396_1:RecordAudio("103704099", var_399_10)
						arg_396_1:RecordAudio("103704099", var_399_10)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704099", "story_v_side_old_103704.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704099", "story_v_side_old_103704.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_11 = math.max(var_399_4, arg_396_1.talkMaxDuration)

			if var_399_3 <= arg_396_1.time_ and arg_396_1.time_ < var_399_3 + var_399_11 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_3) / var_399_11

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_3 + var_399_11 and arg_396_1.time_ < var_399_3 + var_399_11 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play103704100 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 103704100
		arg_400_1.duration_ = 7.43

		local var_400_0 = {
			ja = 7.433,
			ko = 3.9,
			en = 6.133
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play103704101(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0.3

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_1 = arg_400_1:GetWordFromCfg(103704100)
				local var_403_2 = arg_400_1:FormatText(var_403_1.content)

				arg_400_1.text_.text = var_403_2

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_4 = 12 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_2) / 12)

				if (12 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_2) / 12)) > 0 and var_403_0 < var_403_4 then
					arg_400_1.talkMaxDuration = var_403_4

					if var_403_4 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_4 + 0
					end
				end

				arg_400_1.text_.text = var_403_2
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704100", "story_v_side_old_103704.awb") ~= 0 then
					local var_403_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704100", "story_v_side_old_103704.awb") / 1000

					if var_403_5 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_5 + 0
					end

					if var_403_1.prefab_name ~= "" and arg_400_1.actors_[var_403_1.prefab_name] ~= nil then
						local var_403_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_1.prefab_name].transform, "story_v_side_old_103704", "103704100", "story_v_side_old_103704.awb")

						arg_400_1:RecordAudio("103704100", var_403_6)
						arg_400_1:RecordAudio("103704100", var_403_6)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704100", "story_v_side_old_103704.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704100", "story_v_side_old_103704.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_7 = math.max(var_403_0, arg_400_1.talkMaxDuration)

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_7 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - 0) / var_403_7

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= 0 + var_403_7 and arg_400_1.time_ < 0 + var_403_7 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play103704101 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 103704101
		arg_404_1.duration_ = 2.17

		local var_404_0 = {
			ja = 1.3,
			ko = 2.166,
			en = 1.166
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play103704102(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0.075

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_1 = arg_404_1:GetWordFromCfg(103704101)
				local var_407_2 = arg_404_1:FormatText(var_407_1.content)

				arg_404_1.text_.text = var_407_2

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 3 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 3)

				if (3 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 3)) > 0 and var_407_0 < var_407_4 then
					arg_404_1.talkMaxDuration = var_407_4

					if var_407_4 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_4 + 0
					end
				end

				arg_404_1.text_.text = var_407_2
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704101", "story_v_side_old_103704.awb") ~= 0 then
					local var_407_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704101", "story_v_side_old_103704.awb") / 1000

					if var_407_5 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_5 + 0
					end

					if var_407_1.prefab_name ~= "" and arg_404_1.actors_[var_407_1.prefab_name] ~= nil then
						local var_407_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_1.prefab_name].transform, "story_v_side_old_103704", "103704101", "story_v_side_old_103704.awb")

						arg_404_1:RecordAudio("103704101", var_407_6)
						arg_404_1:RecordAudio("103704101", var_407_6)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704101", "story_v_side_old_103704.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704101", "story_v_side_old_103704.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_0, arg_404_1.talkMaxDuration)

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - 0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= 0 + var_407_7 and arg_404_1.time_ < 0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play103704102 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 103704102
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play103704103(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0.75

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_1 = arg_408_1:FormatText(arg_408_1:GetWordFromCfg(103704102).content)

				arg_408_1.text_.text = var_411_1

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_3 = 30 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_1) / 30)

				if (30 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_1) / 30)) > 0 and var_411_0 < var_411_3 then
					arg_408_1.talkMaxDuration = var_411_3

					if var_411_3 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_3 + 0
					end
				end

				arg_408_1.text_.text = var_411_1
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_4 = math.max(var_411_0, arg_408_1.talkMaxDuration)

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_4 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - 0) / var_411_4

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= 0 + var_411_4 and arg_408_1.time_ < 0 + var_411_4 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play103704103 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 103704103
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play103704104(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 1.2

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_1 = arg_412_1:FormatText(arg_412_1:GetWordFromCfg(103704103).content)

				arg_412_1.text_.text = var_415_1

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_3 = 48 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_1) / 48)

				if (48 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_1) / 48)) > 0 and var_415_0 < var_415_3 then
					arg_412_1.talkMaxDuration = var_415_3

					if var_415_3 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_3 + 0
					end
				end

				arg_412_1.text_.text = var_415_1
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_4 = math.max(var_415_0, arg_412_1.talkMaxDuration)

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_4 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - 0) / var_415_4

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= 0 + var_415_4 and arg_412_1.time_ < 0 + var_415_4 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play103704104 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 103704104
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play103704105(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 1.275

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, false)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_1 = arg_416_1:FormatText(arg_416_1:GetWordFromCfg(103704104).content)

				arg_416_1.text_.text = var_419_1

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_3 = 51 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_1) / 51)

				if (51 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_1) / 51)) > 0 and var_419_0 < var_419_3 then
					arg_416_1.talkMaxDuration = var_419_3

					if var_419_3 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_3 + 0
					end
				end

				arg_416_1.text_.text = var_419_1
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_4 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_4 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_4

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_4 and arg_416_1.time_ < 0 + var_419_4 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play103704105 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 103704105
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play103704106(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0.975

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_1 = arg_420_1:FormatText(arg_420_1:GetWordFromCfg(103704105).content)

				arg_420_1.text_.text = var_423_1

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_3 = 39 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_1) / 39)

				if (39 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_1) / 39)) > 0 and var_423_0 < var_423_3 then
					arg_420_1.talkMaxDuration = var_423_3

					if var_423_3 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_3 + 0
					end
				end

				arg_420_1.text_.text = var_423_1
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_4 = math.max(var_423_0, arg_420_1.talkMaxDuration)

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_4 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - 0) / var_423_4

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= 0 + var_423_4 and arg_420_1.time_ < 0 + var_423_4 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play103704106 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 103704106
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play103704107(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0.925

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_1 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(103704106).content)

				arg_424_1.text_.text = var_427_1

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_3 = 37 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_1) / 37)

				if (37 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_1) / 37)) > 0 and var_427_0 < var_427_3 then
					arg_424_1.talkMaxDuration = var_427_3

					if var_427_3 + 0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_3 + 0
					end
				end

				arg_424_1.text_.text = var_427_1
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_4 = math.max(var_427_0, arg_424_1.talkMaxDuration)

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_4 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - 0) / var_427_4

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= 0 + var_427_4 and arg_424_1.time_ < 0 + var_427_4 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play103704107 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 103704107
		arg_428_1.duration_ = 13.2

		local var_428_0 = {
			ja = 13.2,
			ko = 11.6,
			en = 12.7
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play103704108(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if arg_428_1.bgs_.A00 == nil then
				local var_431_0 = Object.Instantiate(arg_428_1.paintGo_)

				var_431_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_431_0.name = "A00"
				var_431_0.transform.parent = arg_428_1.stage_.transform
				var_431_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_428_1.bgs_.A00 = var_431_0
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				local var_431_1 = arg_428_1.bgs_.A00

				arg_428_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_431_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_431_2 = var_431_1:GetComponent("SpriteRenderer")

				if var_431_2 and var_431_2.sprite then
					local var_431_3 = 2 * (var_431_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_431_1.transform.localScale = Vector3.New(var_431_3 / var_431_2.sprite.bounds.size.y < var_431_3 * manager.ui.mainCameraCom_.aspect / var_431_2.sprite.bounds.size.x and var_431_3 * manager.ui.mainCameraCom_.aspect / var_431_2.sprite.bounds.size.x or var_431_3 / var_431_2.sprite.bounds.size.y, var_431_3 / var_431_2.sprite.bounds.size.y < var_431_3 * manager.ui.mainCameraCom_.aspect / var_431_2.sprite.bounds.size.x and var_431_3 * manager.ui.mainCameraCom_.aspect / var_431_2.sprite.bounds.size.x or var_431_3 / var_431_2.sprite.bounds.size.y, 0)
				end

				for iter_431_0, iter_431_1 in pairs(arg_428_1.bgs_) do
					if iter_431_0 ~= "A00" then
						iter_431_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				local var_431_4 = arg_428_1.bgs_.ST12:GetComponent("SpriteRenderer")

				if var_431_4 then
					arg_428_1.var_.alphaOldValueST12 = var_431_4.color.a
					arg_428_1.var_.alphaMatValueST12 = var_431_4
				end

				arg_428_1.var_.alphaOldValueST12 = 1
			end

			local var_431_5 = 1.5

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_5 then
				if arg_428_1.var_.alphaMatValueST12 then
					arg_428_1.var_.alphaMatValueST12.color.a = Mathf.Lerp(arg_428_1.var_.alphaOldValueST12, 0, (arg_428_1.time_ - 0) / var_431_5)
					arg_428_1.var_.alphaMatValueST12.color = arg_428_1.var_.alphaMatValueST12.color
				end
			end

			if arg_428_1.time_ >= 0 + var_431_5 and arg_428_1.time_ < 0 + var_431_5 + arg_431_0 and arg_428_1.var_.alphaMatValueST12 then
				arg_428_1.var_.alphaMatValueST12.color.a = 0
				arg_428_1.var_.alphaMatValueST12.color = arg_428_1.var_.alphaMatValueST12.color
			end

			if 1.5 < arg_428_1.time_ and arg_428_1.time_ <= 1.5 + arg_431_0 then
				local var_431_6 = arg_428_1.bgs_.A00:GetComponent("SpriteRenderer")

				if var_431_6 then
					arg_428_1.var_.alphaOldValueA00 = var_431_6.color.a
					arg_428_1.var_.alphaMatValueA00 = var_431_6
				end

				arg_428_1.var_.alphaOldValueA00 = 0
			end

			local var_431_7 = 1.5

			if 1.5 <= arg_428_1.time_ and arg_428_1.time_ < 1.5 + var_431_7 then
				if arg_428_1.var_.alphaMatValueA00 then
					arg_428_1.var_.alphaMatValueA00.color.a = Mathf.Lerp(arg_428_1.var_.alphaOldValueA00, 1, (arg_428_1.time_ - 1.5) / var_431_7)
					arg_428_1.var_.alphaMatValueA00.color = arg_428_1.var_.alphaMatValueA00.color
				end
			end

			if arg_428_1.time_ >= 1.5 + var_431_7 and arg_428_1.time_ < 1.5 + var_431_7 + arg_431_0 and arg_428_1.var_.alphaMatValueA00 then
				arg_428_1.var_.alphaMatValueA00.color.a = 1
				arg_428_1.var_.alphaMatValueA00.color = arg_428_1.var_.alphaMatValueA00.color
			end

			if arg_428_1.frameCnt_ <= 1 then
				arg_428_1.dialog_:SetActive(false)
			end

			local var_431_8 = 3
			local var_431_9 = 1.075

			if 3 < arg_428_1.time_ and arg_428_1.time_ <= var_431_8 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0

				arg_428_1.dialog_:SetActive(true)

				arg_428_1.dialogCg_.alpha = 0

				local var_431_10 = LeanTween.value(arg_428_1.dialog_, 0, 1, 0.3)

				var_431_10:setOnUpdate(LuaHelper.FloatAction(function(arg_432_0)
					arg_428_1.dialogCg_.alpha = arg_432_0
				end))
				var_431_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_428_1.dialog_)
					var_431_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_428_1.duration_ = arg_428_1.duration_ + 0.3

				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_11 = arg_428_1:GetWordFromCfg(103704107)
				local var_431_12 = arg_428_1:FormatText(var_431_11.content)

				arg_428_1.text_.text = var_431_12

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_14 = 43 <= 0 and var_431_9 or var_431_9 * (utf8.len(var_431_12) / 43)

				if (43 <= 0 and var_431_9 or var_431_9 * (utf8.len(var_431_12) / 43)) > 0 and var_431_9 < var_431_14 then
					arg_428_1.talkMaxDuration = var_431_14
					var_431_8 = var_431_8 + 0.3

					if var_431_14 + var_431_8 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_14 + var_431_8
					end
				end

				arg_428_1.text_.text = var_431_12
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704107", "story_v_side_old_103704.awb") ~= 0 then
					local var_431_15 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704107", "story_v_side_old_103704.awb") / 1000

					if var_431_15 + var_431_8 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_15 + var_431_8
					end

					if var_431_11.prefab_name ~= "" and arg_428_1.actors_[var_431_11.prefab_name] ~= nil then
						local var_431_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_11.prefab_name].transform, "story_v_side_old_103704", "103704107", "story_v_side_old_103704.awb")

						arg_428_1:RecordAudio("103704107", var_431_16)
						arg_428_1:RecordAudio("103704107", var_431_16)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704107", "story_v_side_old_103704.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704107", "story_v_side_old_103704.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_17 = var_431_8 + 0.3
			local var_431_18 = math.max(var_431_9, arg_428_1.talkMaxDuration)

			if var_431_8 + 0.3 <= arg_428_1.time_ and arg_428_1.time_ < var_431_17 + var_431_18 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_17) / var_431_18

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_17 + var_431_18 and arg_428_1.time_ < var_431_17 + var_431_18 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play103704108 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 103704108
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play103704109(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0.733333333333333

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
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

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_1 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(103704108).content)

				arg_434_1.text_.text = var_437_1

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_3 = 15 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_1) / 15)

				if (15 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_1) / 15)) > 0 and var_437_0 < var_437_3 then
					arg_434_1.talkMaxDuration = var_437_3

					if var_437_3 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_3 + 0
					end
				end

				arg_434_1.text_.text = var_437_1
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_4 = math.max(var_437_0, arg_434_1.talkMaxDuration)

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_4 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - 0) / var_437_4

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= 0 + var_437_4 and arg_434_1.time_ < 0 + var_437_4 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play103704109 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 103704109
		arg_438_1.duration_ = 6.57

		local var_438_0 = {
			ja = 6.466,
			ko = 6.133,
			en = 6.566
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
				arg_438_0:Play103704110(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0.525

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_1 = arg_438_1:GetWordFromCfg(103704109)
				local var_441_2 = arg_438_1:FormatText(var_441_1.content)

				arg_438_1.text_.text = var_441_2

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_4 = 21 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 21)

				if (21 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 21)) > 0 and var_441_0 < var_441_4 then
					arg_438_1.talkMaxDuration = var_441_4

					if var_441_4 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_4 + 0
					end
				end

				arg_438_1.text_.text = var_441_2
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704109", "story_v_side_old_103704.awb") ~= 0 then
					local var_441_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704109", "story_v_side_old_103704.awb") / 1000

					if var_441_5 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_5 + 0
					end

					if var_441_1.prefab_name ~= "" and arg_438_1.actors_[var_441_1.prefab_name] ~= nil then
						local var_441_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_1.prefab_name].transform, "story_v_side_old_103704", "103704109", "story_v_side_old_103704.awb")

						arg_438_1:RecordAudio("103704109", var_441_6)
						arg_438_1:RecordAudio("103704109", var_441_6)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704109", "story_v_side_old_103704.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704109", "story_v_side_old_103704.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_7 = math.max(var_441_0, arg_438_1.talkMaxDuration)

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_7 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - 0) / var_441_7

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= 0 + var_441_7 and arg_438_1.time_ < 0 + var_441_7 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play103704110 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 103704110
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play103704111(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0.85

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, false)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_1 = arg_442_1:FormatText(arg_442_1:GetWordFromCfg(103704110).content)

				arg_442_1.text_.text = var_445_1

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_3 = 34 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_1) / 34)

				if (34 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_1) / 34)) > 0 and var_445_0 < var_445_3 then
					arg_442_1.talkMaxDuration = var_445_3

					if var_445_3 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_3 + 0
					end
				end

				arg_442_1.text_.text = var_445_1
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_4 = math.max(var_445_0, arg_442_1.talkMaxDuration)

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_4 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - 0) / var_445_4

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= 0 + var_445_4 and arg_442_1.time_ < 0 + var_445_4 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play103704111 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 103704111
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play103704112(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0.55

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_1 = arg_446_1:FormatText(arg_446_1:GetWordFromCfg(103704111).content)

				arg_446_1.text_.text = var_449_1

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_3 = 22 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_1) / 22)

				if (22 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_1) / 22)) > 0 and var_449_0 < var_449_3 then
					arg_446_1.talkMaxDuration = var_449_3

					if var_449_3 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_3 + 0
					end
				end

				arg_446_1.text_.text = var_449_1
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_4 = math.max(var_449_0, arg_446_1.talkMaxDuration)

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_4 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - 0) / var_449_4

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= 0 + var_449_4 and arg_446_1.time_ < 0 + var_449_4 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play103704112 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 103704112
		arg_450_1.duration_ = 5.87

		local var_450_0 = {
			ja = 5.866,
			ko = 3.833,
			en = 3.8
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play103704113(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.var_.moveOldPos1037ui_story = arg_450_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_453_0 = 0.001

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 then
				arg_450_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_450_1.time_ - 0) / var_453_0)
				arg_450_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_450_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["1037ui_story"].transform.position).z)
				arg_450_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_450_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_450_1.actors_["1037ui_story"].transform.localEulerAngles = arg_450_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 then
				arg_450_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_450_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_450_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["1037ui_story"].transform.position).z)
				arg_450_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_450_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_450_1.actors_["1037ui_story"].transform.localEulerAngles = arg_450_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_453_1 = arg_450_1.actors_["1037ui_story"]

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(var_453_1) and arg_450_1.var_.characterEffect1037ui_story == nil then
				arg_450_1.var_.characterEffect1037ui_story = var_453_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_2 = 0.2

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_2 and not isNil(var_453_1) then
				if arg_450_1.var_.characterEffect1037ui_story and not isNil(var_453_1) then
					arg_450_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_450_1.time_ >= 0 + var_453_2 and arg_450_1.time_ < 0 + var_453_2 + arg_453_0 and not isNil(var_453_1) and arg_450_1.var_.characterEffect1037ui_story then
				arg_450_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_453_4 = 0
			local var_453_5 = 0.425

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_4 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_6 = arg_450_1:GetWordFromCfg(103704112)
				local var_453_7 = arg_450_1:FormatText(var_453_6.content)

				arg_450_1.text_.text = var_453_7

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_9 = 17 <= 0 and var_453_5 or var_453_5 * (utf8.len(var_453_7) / 17)

				if (17 <= 0 and var_453_5 or var_453_5 * (utf8.len(var_453_7) / 17)) > 0 and var_453_5 < var_453_9 then
					arg_450_1.talkMaxDuration = var_453_9

					if var_453_9 + var_453_4 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_9 + var_453_4
					end
				end

				arg_450_1.text_.text = var_453_7
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704112", "story_v_side_old_103704.awb") ~= 0 then
					local var_453_10 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704112", "story_v_side_old_103704.awb") / 1000

					if var_453_10 + var_453_4 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_10 + var_453_4
					end

					if var_453_6.prefab_name ~= "" and arg_450_1.actors_[var_453_6.prefab_name] ~= nil then
						local var_453_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_6.prefab_name].transform, "story_v_side_old_103704", "103704112", "story_v_side_old_103704.awb")

						arg_450_1:RecordAudio("103704112", var_453_11)
						arg_450_1:RecordAudio("103704112", var_453_11)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704112", "story_v_side_old_103704.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704112", "story_v_side_old_103704.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_12 = math.max(var_453_5, arg_450_1.talkMaxDuration)

			if var_453_4 <= arg_450_1.time_ and arg_450_1.time_ < var_453_4 + var_453_12 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_4) / var_453_12

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_4 + var_453_12 and arg_450_1.time_ < var_453_4 + var_453_12 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_450_1:InitPlayNodeList()
	end,
	Play103704113 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 103704113
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play103704114(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(arg_454_1.actors_["1037ui_story"]) and arg_454_1.var_.characterEffect1037ui_story == nil then
				arg_454_1.var_.characterEffect1037ui_story = arg_454_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_0 = 0.2

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 and not isNil(arg_454_1.actors_["1037ui_story"]) then
				if arg_454_1.var_.characterEffect1037ui_story and not isNil(arg_454_1.actors_["1037ui_story"]) then
					arg_454_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_454_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_454_1.time_ - 0) / var_457_0)
				end
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 and not isNil(arg_454_1.actors_["1037ui_story"]) and arg_454_1.var_.characterEffect1037ui_story then
				arg_454_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_454_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_457_1 = 0
			local var_457_2 = 0.325

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_3 = arg_454_1:FormatText(arg_454_1:GetWordFromCfg(103704113).content)

				arg_454_1.text_.text = var_457_3

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_5 = 13 <= 0 and var_457_2 or var_457_2 * (utf8.len(var_457_3) / 13)

				if (13 <= 0 and var_457_2 or var_457_2 * (utf8.len(var_457_3) / 13)) > 0 and var_457_2 < var_457_5 then
					arg_454_1.talkMaxDuration = var_457_5

					if var_457_5 + var_457_1 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_5 + var_457_1
					end
				end

				arg_454_1.text_.text = var_457_3
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_6 = math.max(var_457_2, arg_454_1.talkMaxDuration)

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_6 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_1) / var_457_6

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_1 + var_457_6 and arg_454_1.time_ < var_457_1 + var_457_6 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play103704114 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 103704114
		arg_458_1.duration_ = 11.97

		local var_458_0 = {
			ja = 7.833,
			ko = 8.9,
			en = 11.966
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play103704115(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["1037ui_story"]) and arg_458_1.var_.characterEffect1037ui_story == nil then
				arg_458_1.var_.characterEffect1037ui_story = arg_458_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_0 = 0.2

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["1037ui_story"]) then
				if arg_458_1.var_.characterEffect1037ui_story and not isNil(arg_458_1.actors_["1037ui_story"]) then
					arg_458_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["1037ui_story"]) and arg_458_1.var_.characterEffect1037ui_story then
				arg_458_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_461_2 = 0
			local var_461_3 = 0.85

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_2 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_4 = arg_458_1:GetWordFromCfg(103704114)
				local var_461_5 = arg_458_1:FormatText(var_461_4.content)

				arg_458_1.text_.text = var_461_5

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_7 = 34 <= 0 and var_461_3 or var_461_3 * (utf8.len(var_461_5) / 34)

				if (34 <= 0 and var_461_3 or var_461_3 * (utf8.len(var_461_5) / 34)) > 0 and var_461_3 < var_461_7 then
					arg_458_1.talkMaxDuration = var_461_7

					if var_461_7 + var_461_2 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_7 + var_461_2
					end
				end

				arg_458_1.text_.text = var_461_5
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704114", "story_v_side_old_103704.awb") ~= 0 then
					local var_461_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704114", "story_v_side_old_103704.awb") / 1000

					if var_461_8 + var_461_2 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_8 + var_461_2
					end

					if var_461_4.prefab_name ~= "" and arg_458_1.actors_[var_461_4.prefab_name] ~= nil then
						local var_461_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_4.prefab_name].transform, "story_v_side_old_103704", "103704114", "story_v_side_old_103704.awb")

						arg_458_1:RecordAudio("103704114", var_461_9)
						arg_458_1:RecordAudio("103704114", var_461_9)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704114", "story_v_side_old_103704.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704114", "story_v_side_old_103704.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_10 = math.max(var_461_3, arg_458_1.talkMaxDuration)

			if var_461_2 <= arg_458_1.time_ and arg_458_1.time_ < var_461_2 + var_461_10 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_2) / var_461_10

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_2 + var_461_10 and arg_458_1.time_ < var_461_2 + var_461_10 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play103704115 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 103704115
		arg_462_1.duration_ = 21.03

		local var_462_0 = {
			ja = 21.033,
			ko = 6.8,
			en = 9.466
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play103704116(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_465_0 = 0
			local var_465_1 = 0.875

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_2 = arg_462_1:GetWordFromCfg(103704115)
				local var_465_3 = arg_462_1:FormatText(var_465_2.content)

				arg_462_1.text_.text = var_465_3

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_5 = 35 <= 0 and var_465_1 or var_465_1 * (utf8.len(var_465_3) / 35)

				if (35 <= 0 and var_465_1 or var_465_1 * (utf8.len(var_465_3) / 35)) > 0 and var_465_1 < var_465_5 then
					arg_462_1.talkMaxDuration = var_465_5

					if var_465_5 + var_465_0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_5 + var_465_0
					end
				end

				arg_462_1.text_.text = var_465_3
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704115", "story_v_side_old_103704.awb") ~= 0 then
					local var_465_6 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704115", "story_v_side_old_103704.awb") / 1000

					if var_465_6 + var_465_0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_6 + var_465_0
					end

					if var_465_2.prefab_name ~= "" and arg_462_1.actors_[var_465_2.prefab_name] ~= nil then
						local var_465_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_2.prefab_name].transform, "story_v_side_old_103704", "103704115", "story_v_side_old_103704.awb")

						arg_462_1:RecordAudio("103704115", var_465_7)
						arg_462_1:RecordAudio("103704115", var_465_7)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704115", "story_v_side_old_103704.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704115", "story_v_side_old_103704.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_8 = math.max(var_465_1, arg_462_1.talkMaxDuration)

			if var_465_0 <= arg_462_1.time_ and arg_462_1.time_ < var_465_0 + var_465_8 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_0) / var_465_8

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_0 + var_465_8 and arg_462_1.time_ < var_465_0 + var_465_8 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play103704116 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 103704116
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play103704117(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["1037ui_story"]) and arg_466_1.var_.characterEffect1037ui_story == nil then
				arg_466_1.var_.characterEffect1037ui_story = arg_466_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_0 = 0.2

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["1037ui_story"]) then
				if arg_466_1.var_.characterEffect1037ui_story and not isNil(arg_466_1.actors_["1037ui_story"]) then
					arg_466_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_466_1.time_ - 0) / var_469_0)
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["1037ui_story"]) and arg_466_1.var_.characterEffect1037ui_story then
				arg_466_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_469_1 = 0
			local var_469_2 = 0.25

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_3 = arg_466_1:FormatText(arg_466_1:GetWordFromCfg(103704116).content)

				arg_466_1.text_.text = var_469_3

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_5 = 10 <= 0 and var_469_2 or var_469_2 * (utf8.len(var_469_3) / 10)

				if (10 <= 0 and var_469_2 or var_469_2 * (utf8.len(var_469_3) / 10)) > 0 and var_469_2 < var_469_5 then
					arg_466_1.talkMaxDuration = var_469_5

					if var_469_5 + var_469_1 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_5 + var_469_1
					end
				end

				arg_466_1.text_.text = var_469_3
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_6 = math.max(var_469_2, arg_466_1.talkMaxDuration)

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_6 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_1) / var_469_6

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_1 + var_469_6 and arg_466_1.time_ < var_469_1 + var_469_6 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play103704117 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 103704117
		arg_470_1.duration_ = 6.13

		local var_470_0 = {
			ja = 5.933,
			ko = 5.8,
			en = 6.133
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play103704118(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos1037ui_story = arg_470_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_473_0 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 then
				arg_470_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_470_1.time_ - 0) / var_473_0)
				arg_470_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1037ui_story"].transform.position).z)
				arg_470_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1037ui_story"].transform.localEulerAngles = arg_470_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 then
				arg_470_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_470_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1037ui_story"].transform.position).z)
				arg_470_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1037ui_story"].transform.localEulerAngles = arg_470_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_473_1 = 0
			local var_473_2 = 0.6

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, true)
				arg_470_1.iconController_:SetSelectedState("hero")

				arg_470_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_470_1.callingController_:SetSelectedState("normal")

				arg_470_1.keyicon_.color = Color.New(1, 1, 1)
				arg_470_1.icon_.color = Color.New(1, 1, 1)

				local var_473_3 = arg_470_1:GetWordFromCfg(103704117)
				local var_473_4 = arg_470_1:FormatText(var_473_3.content)

				arg_470_1.text_.text = var_473_4

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_6 = 24 <= 0 and var_473_2 or var_473_2 * (utf8.len(var_473_4) / 24)

				if (24 <= 0 and var_473_2 or var_473_2 * (utf8.len(var_473_4) / 24)) > 0 and var_473_2 < var_473_6 then
					arg_470_1.talkMaxDuration = var_473_6

					if var_473_6 + var_473_1 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_6 + var_473_1
					end
				end

				arg_470_1.text_.text = var_473_4
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704117", "story_v_side_old_103704.awb") ~= 0 then
					local var_473_7 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704117", "story_v_side_old_103704.awb") / 1000

					if var_473_7 + var_473_1 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_7 + var_473_1
					end

					if var_473_3.prefab_name ~= "" and arg_470_1.actors_[var_473_3.prefab_name] ~= nil then
						local var_473_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_3.prefab_name].transform, "story_v_side_old_103704", "103704117", "story_v_side_old_103704.awb")

						arg_470_1:RecordAudio("103704117", var_473_8)
						arg_470_1:RecordAudio("103704117", var_473_8)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704117", "story_v_side_old_103704.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704117", "story_v_side_old_103704.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_9 = math.max(var_473_2, arg_470_1.talkMaxDuration)

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_9 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_1) / var_473_9

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_1 + var_473_9 and arg_470_1.time_ < var_473_1 + var_473_9 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play103704118 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 103704118
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play103704119(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0.55

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_1 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(103704118).content)

				arg_474_1.text_.text = var_477_1

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_3 = 22 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_1) / 22)

				if (22 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_1) / 22)) > 0 and var_477_0 < var_477_3 then
					arg_474_1.talkMaxDuration = var_477_3

					if var_477_3 + 0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_3 + 0
					end
				end

				arg_474_1.text_.text = var_477_1
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_4 = math.max(var_477_0, arg_474_1.talkMaxDuration)

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_4 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - 0) / var_477_4

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= 0 + var_477_4 and arg_474_1.time_ < 0 + var_477_4 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play103704119 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 103704119
		arg_478_1.duration_ = 9.43

		local var_478_0 = {
			ja = 9.433,
			ko = 3.666,
			en = 3.166
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play103704120(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0.425

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_1 = arg_478_1:GetWordFromCfg(103704119)
				local var_481_2 = arg_478_1:FormatText(var_481_1.content)

				arg_478_1.text_.text = var_481_2

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_4 = 17 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_2) / 17)

				if (17 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_2) / 17)) > 0 and var_481_0 < var_481_4 then
					arg_478_1.talkMaxDuration = var_481_4

					if var_481_4 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_4 + 0
					end
				end

				arg_478_1.text_.text = var_481_2
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704119", "story_v_side_old_103704.awb") ~= 0 then
					local var_481_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704119", "story_v_side_old_103704.awb") / 1000

					if var_481_5 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_5 + 0
					end

					if var_481_1.prefab_name ~= "" and arg_478_1.actors_[var_481_1.prefab_name] ~= nil then
						local var_481_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_1.prefab_name].transform, "story_v_side_old_103704", "103704119", "story_v_side_old_103704.awb")

						arg_478_1:RecordAudio("103704119", var_481_6)
						arg_478_1:RecordAudio("103704119", var_481_6)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704119", "story_v_side_old_103704.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704119", "story_v_side_old_103704.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_7 = math.max(var_481_0, arg_478_1.talkMaxDuration)

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_7 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - 0) / var_481_7

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= 0 + var_481_7 and arg_478_1.time_ < 0 + var_481_7 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play103704120 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 103704120
		arg_482_1.duration_ = 8

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play103704121(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if arg_482_1.bgs_.ST16 == nil then
				local var_485_0 = Object.Instantiate(arg_482_1.paintGo_)

				var_485_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST16")
				var_485_0.name = "ST16"
				var_485_0.transform.parent = arg_482_1.stage_.transform
				var_485_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_482_1.bgs_.ST16 = var_485_0
			end

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				local var_485_1 = arg_482_1.bgs_.ST16

				arg_482_1.bgs_.ST16.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_485_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_485_2 = var_485_1:GetComponent("SpriteRenderer")

				if var_485_2 and var_485_2.sprite then
					local var_485_3 = 2 * (var_485_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_485_1.transform.localScale = Vector3.New(var_485_3 / var_485_2.sprite.bounds.size.y < var_485_3 * manager.ui.mainCameraCom_.aspect / var_485_2.sprite.bounds.size.x and var_485_3 * manager.ui.mainCameraCom_.aspect / var_485_2.sprite.bounds.size.x or var_485_3 / var_485_2.sprite.bounds.size.y, var_485_3 / var_485_2.sprite.bounds.size.y < var_485_3 * manager.ui.mainCameraCom_.aspect / var_485_2.sprite.bounds.size.x and var_485_3 * manager.ui.mainCameraCom_.aspect / var_485_2.sprite.bounds.size.x or var_485_3 / var_485_2.sprite.bounds.size.y, 0)
				end

				for iter_485_0, iter_485_1 in pairs(arg_482_1.bgs_) do
					if iter_485_0 ~= "ST16" then
						iter_485_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				local var_485_4 = arg_482_1.bgs_.A00:GetComponent("SpriteRenderer")

				if var_485_4 then
					arg_482_1.var_.alphaOldValueA00 = var_485_4.color.a
					arg_482_1.var_.alphaMatValueA00 = var_485_4
				end

				arg_482_1.var_.alphaOldValueA00 = 1
			end

			local var_485_5 = 1.5

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_5 then
				if arg_482_1.var_.alphaMatValueA00 then
					arg_482_1.var_.alphaMatValueA00.color.a = Mathf.Lerp(arg_482_1.var_.alphaOldValueA00, 0, (arg_482_1.time_ - 0) / var_485_5)
					arg_482_1.var_.alphaMatValueA00.color = arg_482_1.var_.alphaMatValueA00.color
				end
			end

			if arg_482_1.time_ >= 0 + var_485_5 and arg_482_1.time_ < 0 + var_485_5 + arg_485_0 and arg_482_1.var_.alphaMatValueA00 then
				arg_482_1.var_.alphaMatValueA00.color.a = 0
				arg_482_1.var_.alphaMatValueA00.color = arg_482_1.var_.alphaMatValueA00.color
			end

			if 1.5 < arg_482_1.time_ and arg_482_1.time_ <= 1.5 + arg_485_0 then
				local var_485_6 = arg_482_1.bgs_.ST16:GetComponent("SpriteRenderer")

				if var_485_6 then
					arg_482_1.var_.alphaOldValueST16 = var_485_6.color.a
					arg_482_1.var_.alphaMatValueST16 = var_485_6
				end

				arg_482_1.var_.alphaOldValueST16 = 0
			end

			local var_485_7 = 1.5

			if 1.5 <= arg_482_1.time_ and arg_482_1.time_ < 1.5 + var_485_7 then
				if arg_482_1.var_.alphaMatValueST16 then
					arg_482_1.var_.alphaMatValueST16.color.a = Mathf.Lerp(arg_482_1.var_.alphaOldValueST16, 1, (arg_482_1.time_ - 1.5) / var_485_7)
					arg_482_1.var_.alphaMatValueST16.color = arg_482_1.var_.alphaMatValueST16.color
				end
			end

			if arg_482_1.time_ >= 1.5 + var_485_7 and arg_482_1.time_ < 1.5 + var_485_7 + arg_485_0 and arg_482_1.var_.alphaMatValueST16 then
				arg_482_1.var_.alphaMatValueST16.color.a = 1
				arg_482_1.var_.alphaMatValueST16.color = arg_482_1.var_.alphaMatValueST16.color
			end

			if arg_482_1.frameCnt_ <= 1 then
				arg_482_1.dialog_:SetActive(false)
			end

			local var_485_8 = 3
			local var_485_9 = 1

			if 3 < arg_482_1.time_ and arg_482_1.time_ <= var_485_8 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0

				arg_482_1.dialog_:SetActive(true)

				arg_482_1.dialogCg_.alpha = 0

				local var_485_10 = LeanTween.value(arg_482_1.dialog_, 0, 1, 0.3)

				var_485_10:setOnUpdate(LuaHelper.FloatAction(function(arg_486_0)
					arg_482_1.dialogCg_.alpha = arg_486_0
				end))
				var_485_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_482_1.dialog_)
					var_485_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_482_1.duration_ = arg_482_1.duration_ + 0.3

				SetActive(arg_482_1.leftNameGo_, false)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_11 = arg_482_1:FormatText(arg_482_1:GetWordFromCfg(103704120).content)

				arg_482_1.text_.text = var_485_11

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_13 = 41 <= 0 and var_485_9 or var_485_9 * (utf8.len(var_485_11) / 41)

				if (41 <= 0 and var_485_9 or var_485_9 * (utf8.len(var_485_11) / 41)) > 0 and var_485_9 < var_485_13 then
					arg_482_1.talkMaxDuration = var_485_13
					var_485_8 = var_485_8 + 0.3

					if var_485_13 + var_485_8 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_13 + var_485_8
					end
				end

				arg_482_1.text_.text = var_485_11
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_14 = var_485_8 + 0.3
			local var_485_15 = math.max(var_485_9, arg_482_1.talkMaxDuration)

			if var_485_8 + 0.3 <= arg_482_1.time_ and arg_482_1.time_ < var_485_14 + var_485_15 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_14) / var_485_15

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_14 + var_485_15 and arg_482_1.time_ < var_485_14 + var_485_15 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play103704121 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 103704121
		arg_488_1.duration_ = 8.63

		local var_488_0 = {
			ja = 8.633,
			ko = 5.933,
			en = 5.9
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play103704122(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.var_.moveOldPos1037ui_story = arg_488_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_491_0 = 0.001

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 then
				arg_488_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_488_1.time_ - 0) / var_491_0)
				arg_488_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_488_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1037ui_story"].transform.position).z)
				arg_488_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_488_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_488_1.actors_["1037ui_story"].transform.localEulerAngles = arg_488_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 then
				arg_488_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_488_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_488_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1037ui_story"].transform.position).z)
				arg_488_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_488_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_488_1.actors_["1037ui_story"].transform.localEulerAngles = arg_488_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_491_1 = arg_488_1.actors_["1037ui_story"]

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(var_491_1) and arg_488_1.var_.characterEffect1037ui_story == nil then
				arg_488_1.var_.characterEffect1037ui_story = var_491_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_2 = 0.2

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_2 and not isNil(var_491_1) then
				if arg_488_1.var_.characterEffect1037ui_story and not isNil(var_491_1) then
					arg_488_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_488_1.time_ >= 0 + var_491_2 and arg_488_1.time_ < 0 + var_491_2 + arg_491_0 and not isNil(var_491_1) and arg_488_1.var_.characterEffect1037ui_story then
				arg_488_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_491_4 = 0
			local var_491_5 = 0.45

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_4 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_6 = arg_488_1:GetWordFromCfg(103704121)
				local var_491_7 = arg_488_1:FormatText(var_491_6.content)

				arg_488_1.text_.text = var_491_7

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_9 = 18 <= 0 and var_491_5 or var_491_5 * (utf8.len(var_491_7) / 18)

				if (18 <= 0 and var_491_5 or var_491_5 * (utf8.len(var_491_7) / 18)) > 0 and var_491_5 < var_491_9 then
					arg_488_1.talkMaxDuration = var_491_9

					if var_491_9 + var_491_4 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_9 + var_491_4
					end
				end

				arg_488_1.text_.text = var_491_7
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704121", "story_v_side_old_103704.awb") ~= 0 then
					local var_491_10 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704121", "story_v_side_old_103704.awb") / 1000

					if var_491_10 + var_491_4 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_10 + var_491_4
					end

					if var_491_6.prefab_name ~= "" and arg_488_1.actors_[var_491_6.prefab_name] ~= nil then
						local var_491_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_6.prefab_name].transform, "story_v_side_old_103704", "103704121", "story_v_side_old_103704.awb")

						arg_488_1:RecordAudio("103704121", var_491_11)
						arg_488_1:RecordAudio("103704121", var_491_11)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704121", "story_v_side_old_103704.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704121", "story_v_side_old_103704.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_12 = math.max(var_491_5, arg_488_1.talkMaxDuration)

			if var_491_4 <= arg_488_1.time_ and arg_488_1.time_ < var_491_4 + var_491_12 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_4) / var_491_12

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_4 + var_491_12 and arg_488_1.time_ < var_491_4 + var_491_12 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play103704122 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 103704122
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play103704123(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(arg_492_1.actors_["1037ui_story"]) and arg_492_1.var_.characterEffect1037ui_story == nil then
				arg_492_1.var_.characterEffect1037ui_story = arg_492_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_0 = 0.2

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_0 and not isNil(arg_492_1.actors_["1037ui_story"]) then
				if arg_492_1.var_.characterEffect1037ui_story and not isNil(arg_492_1.actors_["1037ui_story"]) then
					arg_492_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_492_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_492_1.time_ - 0) / var_495_0)
				end
			end

			if arg_492_1.time_ >= 0 + var_495_0 and arg_492_1.time_ < 0 + var_495_0 + arg_495_0 and not isNil(arg_492_1.actors_["1037ui_story"]) and arg_492_1.var_.characterEffect1037ui_story then
				arg_492_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_492_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_495_1 = 0
			local var_495_2 = 0.625

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, true)
				arg_492_1.iconController_:SetSelectedState("hero")

				arg_492_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_492_1.callingController_:SetSelectedState("normal")

				arg_492_1.keyicon_.color = Color.New(1, 1, 1)
				arg_492_1.icon_.color = Color.New(1, 1, 1)

				local var_495_3 = arg_492_1:FormatText(arg_492_1:GetWordFromCfg(103704122).content)

				arg_492_1.text_.text = var_495_3

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_5 = 25 <= 0 and var_495_2 or var_495_2 * (utf8.len(var_495_3) / 25)

				if (25 <= 0 and var_495_2 or var_495_2 * (utf8.len(var_495_3) / 25)) > 0 and var_495_2 < var_495_5 then
					arg_492_1.talkMaxDuration = var_495_5

					if var_495_5 + var_495_1 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_5 + var_495_1
					end
				end

				arg_492_1.text_.text = var_495_3
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_6 = math.max(var_495_2, arg_492_1.talkMaxDuration)

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_6 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_1) / var_495_6

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_1 + var_495_6 and arg_492_1.time_ < var_495_1 + var_495_6 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play103704123 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 103704123
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play103704124(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0.6

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_1 = arg_496_1:FormatText(arg_496_1:GetWordFromCfg(103704123).content)

				arg_496_1.text_.text = var_499_1

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_3 = 24 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_1) / 24)

				if (24 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_1) / 24)) > 0 and var_499_0 < var_499_3 then
					arg_496_1.talkMaxDuration = var_499_3

					if var_499_3 + 0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_3 + 0
					end
				end

				arg_496_1.text_.text = var_499_1
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_4 = math.max(var_499_0, arg_496_1.talkMaxDuration)

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_4 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - 0) / var_499_4

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= 0 + var_499_4 and arg_496_1.time_ < 0 + var_499_4 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play103704124 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 103704124
		arg_500_1.duration_ = 11

		local var_500_0 = {
			ja = 11,
			ko = 7.966,
			en = 10.366
		}
		local var_500_1 = manager.audio:GetLocalizationFlag()

		if var_500_0[var_500_1] ~= nil then
			arg_500_1.duration_ = var_500_0[var_500_1]
		end

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play103704125(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(arg_500_1.actors_["1037ui_story"]) and arg_500_1.var_.characterEffect1037ui_story == nil then
				arg_500_1.var_.characterEffect1037ui_story = arg_500_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_0 = 0.2

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_0 and not isNil(arg_500_1.actors_["1037ui_story"]) then
				if arg_500_1.var_.characterEffect1037ui_story and not isNil(arg_500_1.actors_["1037ui_story"]) then
					arg_500_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_500_1.time_ >= 0 + var_503_0 and arg_500_1.time_ < 0 + var_503_0 + arg_503_0 and not isNil(arg_500_1.actors_["1037ui_story"]) and arg_500_1.var_.characterEffect1037ui_story then
				arg_500_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_1")
			end

			local var_503_2 = 0
			local var_503_3 = 0.575

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_2 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_4 = arg_500_1:GetWordFromCfg(103704124)
				local var_503_5 = arg_500_1:FormatText(var_503_4.content)

				arg_500_1.text_.text = var_503_5

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_7 = 23 <= 0 and var_503_3 or var_503_3 * (utf8.len(var_503_5) / 23)

				if (23 <= 0 and var_503_3 or var_503_3 * (utf8.len(var_503_5) / 23)) > 0 and var_503_3 < var_503_7 then
					arg_500_1.talkMaxDuration = var_503_7

					if var_503_7 + var_503_2 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_7 + var_503_2
					end
				end

				arg_500_1.text_.text = var_503_5
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704124", "story_v_side_old_103704.awb") ~= 0 then
					local var_503_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704124", "story_v_side_old_103704.awb") / 1000

					if var_503_8 + var_503_2 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_8 + var_503_2
					end

					if var_503_4.prefab_name ~= "" and arg_500_1.actors_[var_503_4.prefab_name] ~= nil then
						local var_503_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_4.prefab_name].transform, "story_v_side_old_103704", "103704124", "story_v_side_old_103704.awb")

						arg_500_1:RecordAudio("103704124", var_503_9)
						arg_500_1:RecordAudio("103704124", var_503_9)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704124", "story_v_side_old_103704.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704124", "story_v_side_old_103704.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_10 = math.max(var_503_3, arg_500_1.talkMaxDuration)

			if var_503_2 <= arg_500_1.time_ and arg_500_1.time_ < var_503_2 + var_503_10 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_2) / var_503_10

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_2 + var_503_10 and arg_500_1.time_ < var_503_2 + var_503_10 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play103704125 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 103704125
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play103704126(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 and not isNil(arg_504_1.actors_["1037ui_story"]) and arg_504_1.var_.characterEffect1037ui_story == nil then
				arg_504_1.var_.characterEffect1037ui_story = arg_504_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_0 = 0.2

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_0 and not isNil(arg_504_1.actors_["1037ui_story"]) then
				if arg_504_1.var_.characterEffect1037ui_story and not isNil(arg_504_1.actors_["1037ui_story"]) then
					arg_504_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_504_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_504_1.time_ - 0) / var_507_0)
				end
			end

			if arg_504_1.time_ >= 0 + var_507_0 and arg_504_1.time_ < 0 + var_507_0 + arg_507_0 and not isNil(arg_504_1.actors_["1037ui_story"]) and arg_504_1.var_.characterEffect1037ui_story then
				arg_504_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_504_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_507_1 = 0
			local var_507_2 = 0.8

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_1 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, true)
				arg_504_1.iconController_:SetSelectedState("hero")

				arg_504_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_504_1.callingController_:SetSelectedState("normal")

				arg_504_1.keyicon_.color = Color.New(1, 1, 1)
				arg_504_1.icon_.color = Color.New(1, 1, 1)

				local var_507_3 = arg_504_1:FormatText(arg_504_1:GetWordFromCfg(103704125).content)

				arg_504_1.text_.text = var_507_3

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 32 <= 0 and var_507_2 or var_507_2 * (utf8.len(var_507_3) / 32)

				if (32 <= 0 and var_507_2 or var_507_2 * (utf8.len(var_507_3) / 32)) > 0 and var_507_2 < var_507_5 then
					arg_504_1.talkMaxDuration = var_507_5

					if var_507_5 + var_507_1 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_5 + var_507_1
					end
				end

				arg_504_1.text_.text = var_507_3
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_6 = math.max(var_507_2, arg_504_1.talkMaxDuration)

			if var_507_1 <= arg_504_1.time_ and arg_504_1.time_ < var_507_1 + var_507_6 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_1) / var_507_6

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_1 + var_507_6 and arg_504_1.time_ < var_507_1 + var_507_6 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play103704126 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 103704126
		arg_508_1.duration_ = 5.7

		local var_508_0 = {
			ja = 5.666,
			ko = 5.7,
			en = 5.5
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play103704127(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 and not isNil(arg_508_1.actors_["1037ui_story"]) and arg_508_1.var_.characterEffect1037ui_story == nil then
				arg_508_1.var_.characterEffect1037ui_story = arg_508_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_0 = 0.2

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_0 and not isNil(arg_508_1.actors_["1037ui_story"]) then
				if arg_508_1.var_.characterEffect1037ui_story and not isNil(arg_508_1.actors_["1037ui_story"]) then
					arg_508_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_508_1.time_ >= 0 + var_511_0 and arg_508_1.time_ < 0 + var_511_0 + arg_511_0 and not isNil(arg_508_1.actors_["1037ui_story"]) and arg_508_1.var_.characterEffect1037ui_story then
				arg_508_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action452")
			end

			local var_511_2 = 0
			local var_511_3 = 0.625

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_2 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_4 = arg_508_1:GetWordFromCfg(103704126)
				local var_511_5 = arg_508_1:FormatText(var_511_4.content)

				arg_508_1.text_.text = var_511_5

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_7 = 25 <= 0 and var_511_3 or var_511_3 * (utf8.len(var_511_5) / 25)

				if (25 <= 0 and var_511_3 or var_511_3 * (utf8.len(var_511_5) / 25)) > 0 and var_511_3 < var_511_7 then
					arg_508_1.talkMaxDuration = var_511_7

					if var_511_7 + var_511_2 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_7 + var_511_2
					end
				end

				arg_508_1.text_.text = var_511_5
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704126", "story_v_side_old_103704.awb") ~= 0 then
					local var_511_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704126", "story_v_side_old_103704.awb") / 1000

					if var_511_8 + var_511_2 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_8 + var_511_2
					end

					if var_511_4.prefab_name ~= "" and arg_508_1.actors_[var_511_4.prefab_name] ~= nil then
						local var_511_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_4.prefab_name].transform, "story_v_side_old_103704", "103704126", "story_v_side_old_103704.awb")

						arg_508_1:RecordAudio("103704126", var_511_9)
						arg_508_1:RecordAudio("103704126", var_511_9)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704126", "story_v_side_old_103704.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704126", "story_v_side_old_103704.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_10 = math.max(var_511_3, arg_508_1.talkMaxDuration)

			if var_511_2 <= arg_508_1.time_ and arg_508_1.time_ < var_511_2 + var_511_10 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_2) / var_511_10

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_2 + var_511_10 and arg_508_1.time_ < var_511_2 + var_511_10 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play103704127 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 103704127
		arg_512_1.duration_ = 11.5

		local var_512_0 = {
			ja = 7.9,
			ko = 7.9,
			en = 11.5
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play103704128(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_515_0 = 0
			local var_515_1 = 0.7

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_0 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_2 = arg_512_1:GetWordFromCfg(103704127)
				local var_515_3 = arg_512_1:FormatText(var_515_2.content)

				arg_512_1.text_.text = var_515_3

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_5 = 28 <= 0 and var_515_1 or var_515_1 * (utf8.len(var_515_3) / 28)

				if (28 <= 0 and var_515_1 or var_515_1 * (utf8.len(var_515_3) / 28)) > 0 and var_515_1 < var_515_5 then
					arg_512_1.talkMaxDuration = var_515_5

					if var_515_5 + var_515_0 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_5 + var_515_0
					end
				end

				arg_512_1.text_.text = var_515_3
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704127", "story_v_side_old_103704.awb") ~= 0 then
					local var_515_6 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704127", "story_v_side_old_103704.awb") / 1000

					if var_515_6 + var_515_0 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_6 + var_515_0
					end

					if var_515_2.prefab_name ~= "" and arg_512_1.actors_[var_515_2.prefab_name] ~= nil then
						local var_515_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_2.prefab_name].transform, "story_v_side_old_103704", "103704127", "story_v_side_old_103704.awb")

						arg_512_1:RecordAudio("103704127", var_515_7)
						arg_512_1:RecordAudio("103704127", var_515_7)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704127", "story_v_side_old_103704.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704127", "story_v_side_old_103704.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_8 = math.max(var_515_1, arg_512_1.talkMaxDuration)

			if var_515_0 <= arg_512_1.time_ and arg_512_1.time_ < var_515_0 + var_515_8 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_0) / var_515_8

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_0 + var_515_8 and arg_512_1.time_ < var_515_0 + var_515_8 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play103704128 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 103704128
		arg_516_1.duration_ = 8

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play103704129(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			if arg_516_1.bgs_.R3701 == nil then
				local var_519_0 = Object.Instantiate(arg_516_1.paintGo_)

				var_519_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R3701")
				var_519_0.name = "R3701"
				var_519_0.transform.parent = arg_516_1.stage_.transform
				var_519_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_516_1.bgs_.R3701 = var_519_0
			end

			if 1.5 < arg_516_1.time_ and arg_516_1.time_ <= 1.5 + arg_519_0 then
				local var_519_1 = arg_516_1.bgs_.R3701

				arg_516_1.bgs_.R3701.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_519_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_519_2 = var_519_1:GetComponent("SpriteRenderer")

				if var_519_2 and var_519_2.sprite then
					local var_519_3 = 2 * (var_519_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_519_1.transform.localScale = Vector3.New(var_519_3 / var_519_2.sprite.bounds.size.y < var_519_3 * manager.ui.mainCameraCom_.aspect / var_519_2.sprite.bounds.size.x and var_519_3 * manager.ui.mainCameraCom_.aspect / var_519_2.sprite.bounds.size.x or var_519_3 / var_519_2.sprite.bounds.size.y, var_519_3 / var_519_2.sprite.bounds.size.y < var_519_3 * manager.ui.mainCameraCom_.aspect / var_519_2.sprite.bounds.size.x and var_519_3 * manager.ui.mainCameraCom_.aspect / var_519_2.sprite.bounds.size.x or var_519_3 / var_519_2.sprite.bounds.size.y, 0)
				end

				for iter_519_0, iter_519_1 in pairs(arg_516_1.bgs_) do
					if iter_519_0 ~= "R3701" then
						iter_519_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				local var_519_4 = arg_516_1.bgs_.ST16:GetComponent("SpriteRenderer")

				if var_519_4 then
					arg_516_1.var_.alphaOldValueST16 = var_519_4.color.a
					arg_516_1.var_.alphaMatValueST16 = var_519_4
				end

				arg_516_1.var_.alphaOldValueST16 = 1
			end

			local var_519_5 = 1.5

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_5 then
				if arg_516_1.var_.alphaMatValueST16 then
					arg_516_1.var_.alphaMatValueST16.color.a = Mathf.Lerp(arg_516_1.var_.alphaOldValueST16, 0, (arg_516_1.time_ - 0) / var_519_5)
					arg_516_1.var_.alphaMatValueST16.color = arg_516_1.var_.alphaMatValueST16.color
				end
			end

			if arg_516_1.time_ >= 0 + var_519_5 and arg_516_1.time_ < 0 + var_519_5 + arg_519_0 and arg_516_1.var_.alphaMatValueST16 then
				arg_516_1.var_.alphaMatValueST16.color.a = 0
				arg_516_1.var_.alphaMatValueST16.color = arg_516_1.var_.alphaMatValueST16.color
			end

			if 1.5 < arg_516_1.time_ and arg_516_1.time_ <= 1.5 + arg_519_0 then
				local var_519_6 = arg_516_1.bgs_.R3701:GetComponent("SpriteRenderer")

				if var_519_6 then
					arg_516_1.var_.alphaOldValueR3701 = var_519_6.color.a
					arg_516_1.var_.alphaMatValueR3701 = var_519_6
				end

				arg_516_1.var_.alphaOldValueR3701 = 0
			end

			local var_519_7 = 1.5

			if 1.5 <= arg_516_1.time_ and arg_516_1.time_ < 1.5 + var_519_7 then
				if arg_516_1.var_.alphaMatValueR3701 then
					arg_516_1.var_.alphaMatValueR3701.color.a = Mathf.Lerp(arg_516_1.var_.alphaOldValueR3701, 1, (arg_516_1.time_ - 1.5) / var_519_7)
					arg_516_1.var_.alphaMatValueR3701.color = arg_516_1.var_.alphaMatValueR3701.color
				end
			end

			if arg_516_1.time_ >= 1.5 + var_519_7 and arg_516_1.time_ < 1.5 + var_519_7 + arg_519_0 and arg_516_1.var_.alphaMatValueR3701 then
				arg_516_1.var_.alphaMatValueR3701.color.a = 1
				arg_516_1.var_.alphaMatValueR3701.color = arg_516_1.var_.alphaMatValueR3701.color
			end

			local var_519_8 = arg_516_1.actors_["1037ui_story"].transform

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1.var_.moveOldPos1037ui_story = var_519_8.localPosition
			end

			local var_519_9 = 0.001

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_9 then
				var_519_8.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_516_1.time_ - 0) / var_519_9)
				var_519_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_519_8.position).x, (manager.ui.mainCamera.transform.position - var_519_8.position).y, (manager.ui.mainCamera.transform.position - var_519_8.position).z)
				var_519_8.localEulerAngles.z = 0
				var_519_8.localEulerAngles.x = 0
				var_519_8.localEulerAngles = var_519_8.localEulerAngles
			end

			if arg_516_1.time_ >= 0 + var_519_9 and arg_516_1.time_ < 0 + var_519_9 + arg_519_0 then
				var_519_8.localPosition = Vector3.New(0, 100, 0)
				var_519_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_519_8.position).x, (manager.ui.mainCamera.transform.position - var_519_8.position).y, (manager.ui.mainCamera.transform.position - var_519_8.position).z)
				var_519_8.localEulerAngles.z = 0
				var_519_8.localEulerAngles.x = 0
				var_519_8.localEulerAngles = var_519_8.localEulerAngles
			end

			local var_519_10 = 3
			local var_519_11 = 0.05

			if 3 < arg_516_1.time_ and arg_516_1.time_ <= var_519_10 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				arg_516_1.leftNameTxt_.text = arg_516_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, true)
				arg_516_1.iconController_:SetSelectedState("hero")

				arg_516_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_516_1.callingController_:SetSelectedState("normal")

				arg_516_1.keyicon_.color = Color.New(1, 1, 1)
				arg_516_1.icon_.color = Color.New(1, 1, 1)

				local var_519_12 = arg_516_1:FormatText(arg_516_1:GetWordFromCfg(103704128).content)

				arg_516_1.text_.text = var_519_12

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_14 = 2 <= 0 and var_519_11 or var_519_11 * (utf8.len(var_519_12) / 2)

				if (2 <= 0 and var_519_11 or var_519_11 * (utf8.len(var_519_12) / 2)) > 0 and var_519_11 < var_519_14 then
					arg_516_1.talkMaxDuration = var_519_14

					if var_519_14 + var_519_10 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_14 + var_519_10
					end
				end

				arg_516_1.text_.text = var_519_12
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_15 = math.max(var_519_11, arg_516_1.talkMaxDuration)

			if var_519_10 <= arg_516_1.time_ and arg_516_1.time_ < var_519_10 + var_519_15 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_10) / var_519_15

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_10 + var_519_15 and arg_516_1.time_ < var_519_10 + var_519_15 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play103704129 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 103704129
		arg_520_1.duration_ = 8.73

		local var_520_0 = {
			ja = 6.733,
			ko = 6.566,
			en = 8.733
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play103704130(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1:AudioAction("play", "effect", "se_story_side_1037", "se_story_1037_shoot", "")
			end

			local var_523_1 = 0
			local var_523_2 = 0.825

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_1 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_3 = arg_520_1:GetWordFromCfg(103704129)
				local var_523_4 = arg_520_1:FormatText(var_523_3.content)

				arg_520_1.text_.text = var_523_4

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_6 = 33 <= 0 and var_523_2 or var_523_2 * (utf8.len(var_523_4) / 33)

				if (33 <= 0 and var_523_2 or var_523_2 * (utf8.len(var_523_4) / 33)) > 0 and var_523_2 < var_523_6 then
					arg_520_1.talkMaxDuration = var_523_6

					if var_523_6 + var_523_1 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_6 + var_523_1
					end
				end

				arg_520_1.text_.text = var_523_4
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704129", "story_v_side_old_103704.awb") ~= 0 then
					local var_523_7 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704129", "story_v_side_old_103704.awb") / 1000

					if var_523_7 + var_523_1 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_7 + var_523_1
					end

					if var_523_3.prefab_name ~= "" and arg_520_1.actors_[var_523_3.prefab_name] ~= nil then
						local var_523_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_3.prefab_name].transform, "story_v_side_old_103704", "103704129", "story_v_side_old_103704.awb")

						arg_520_1:RecordAudio("103704129", var_523_8)
						arg_520_1:RecordAudio("103704129", var_523_8)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704129", "story_v_side_old_103704.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704129", "story_v_side_old_103704.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_9 = math.max(var_523_2, arg_520_1.talkMaxDuration)

			if var_523_1 <= arg_520_1.time_ and arg_520_1.time_ < var_523_1 + var_523_9 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_1) / var_523_9

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_1 + var_523_9 and arg_520_1.time_ < var_523_1 + var_523_9 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play103704130 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 103704130
		arg_524_1.duration_ = 11.43

		local var_524_0 = {
			ja = 11.433,
			ko = 9.6,
			en = 8.2
		}
		local var_524_1 = manager.audio:GetLocalizationFlag()

		if var_524_0[var_524_1] ~= nil then
			arg_524_1.duration_ = var_524_0[var_524_1]
		end

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play103704131(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0.825

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				arg_524_1.leftNameTxt_.text = arg_524_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_1 = arg_524_1:GetWordFromCfg(103704130)
				local var_527_2 = arg_524_1:FormatText(var_527_1.content)

				arg_524_1.text_.text = var_527_2

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_4 = 33 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_2) / 33)

				if (33 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_2) / 33)) > 0 and var_527_0 < var_527_4 then
					arg_524_1.talkMaxDuration = var_527_4

					if var_527_4 + 0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_4 + 0
					end
				end

				arg_524_1.text_.text = var_527_2
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704130", "story_v_side_old_103704.awb") ~= 0 then
					local var_527_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704130", "story_v_side_old_103704.awb") / 1000

					if var_527_5 + 0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_5 + 0
					end

					if var_527_1.prefab_name ~= "" and arg_524_1.actors_[var_527_1.prefab_name] ~= nil then
						local var_527_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_1.prefab_name].transform, "story_v_side_old_103704", "103704130", "story_v_side_old_103704.awb")

						arg_524_1:RecordAudio("103704130", var_527_6)
						arg_524_1:RecordAudio("103704130", var_527_6)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704130", "story_v_side_old_103704.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704130", "story_v_side_old_103704.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_7 = math.max(var_527_0, arg_524_1.talkMaxDuration)

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_7 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - 0) / var_527_7

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= 0 + var_527_7 and arg_524_1.time_ < 0 + var_527_7 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play103704131 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 103704131
		arg_528_1.duration_ = 16.1

		local var_528_0 = {
			ja = 16.1,
			ko = 10.266,
			en = 12.733
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play103704132(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0.975

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_1 = arg_528_1:GetWordFromCfg(103704131)
				local var_531_2 = arg_528_1:FormatText(var_531_1.content)

				arg_528_1.text_.text = var_531_2

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_4 = 39 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_2) / 39)

				if (39 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_2) / 39)) > 0 and var_531_0 < var_531_4 then
					arg_528_1.talkMaxDuration = var_531_4

					if var_531_4 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_4 + 0
					end
				end

				arg_528_1.text_.text = var_531_2
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704131", "story_v_side_old_103704.awb") ~= 0 then
					local var_531_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704131", "story_v_side_old_103704.awb") / 1000

					if var_531_5 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_5 + 0
					end

					if var_531_1.prefab_name ~= "" and arg_528_1.actors_[var_531_1.prefab_name] ~= nil then
						local var_531_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_1.prefab_name].transform, "story_v_side_old_103704", "103704131", "story_v_side_old_103704.awb")

						arg_528_1:RecordAudio("103704131", var_531_6)
						arg_528_1:RecordAudio("103704131", var_531_6)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704131", "story_v_side_old_103704.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704131", "story_v_side_old_103704.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_7 = math.max(var_531_0, arg_528_1.talkMaxDuration)

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_7 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - 0) / var_531_7

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= 0 + var_531_7 and arg_528_1.time_ < 0 + var_531_7 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play103704132 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 103704132
		arg_532_1.duration_ = 13.87

		local var_532_0 = {
			ja = 13.866,
			ko = 9.7,
			en = 8.966
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play103704133(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0.8

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_1 = arg_532_1:GetWordFromCfg(103704132)
				local var_535_2 = arg_532_1:FormatText(var_535_1.content)

				arg_532_1.text_.text = var_535_2

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_4 = 32 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_2) / 32)

				if (32 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_2) / 32)) > 0 and var_535_0 < var_535_4 then
					arg_532_1.talkMaxDuration = var_535_4

					if var_535_4 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_4 + 0
					end
				end

				arg_532_1.text_.text = var_535_2
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704132", "story_v_side_old_103704.awb") ~= 0 then
					local var_535_5 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704132", "story_v_side_old_103704.awb") / 1000

					if var_535_5 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_5 + 0
					end

					if var_535_1.prefab_name ~= "" and arg_532_1.actors_[var_535_1.prefab_name] ~= nil then
						local var_535_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_1.prefab_name].transform, "story_v_side_old_103704", "103704132", "story_v_side_old_103704.awb")

						arg_532_1:RecordAudio("103704132", var_535_6)
						arg_532_1:RecordAudio("103704132", var_535_6)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704132", "story_v_side_old_103704.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704132", "story_v_side_old_103704.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_7 = math.max(var_535_0, arg_532_1.talkMaxDuration)

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_7 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - 0) / var_535_7

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= 0 + var_535_7 and arg_532_1.time_ < 0 + var_535_7 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play103704133 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 103704133
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play103704134(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1:AudioAction("play", "effect", "se_story_side_1037", "se_story_1037_release", "")
			end

			if 0.766666666666667 < arg_536_1.time_ and arg_536_1.time_ <= 0.766666666666667 + arg_539_0 then
				arg_536_1:AudioAction("play", "effect", "se_story_side_1037", "se_story_1037_hit", "")
			end

			local var_539_2 = 0
			local var_539_3 = 0.425

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_2 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, false)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_4 = arg_536_1:FormatText(arg_536_1:GetWordFromCfg(103704133).content)

				arg_536_1.text_.text = var_539_4

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_6 = 17 <= 0 and var_539_3 or var_539_3 * (utf8.len(var_539_4) / 17)

				if (17 <= 0 and var_539_3 or var_539_3 * (utf8.len(var_539_4) / 17)) > 0 and var_539_3 < var_539_6 then
					arg_536_1.talkMaxDuration = var_539_6

					if var_539_6 + var_539_2 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_6 + var_539_2
					end
				end

				arg_536_1.text_.text = var_539_4
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_7 = math.max(var_539_3, arg_536_1.talkMaxDuration)

			if var_539_2 <= arg_536_1.time_ and arg_536_1.time_ < var_539_2 + var_539_7 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_2) / var_539_7

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_2 + var_539_7 and arg_536_1.time_ < var_539_2 + var_539_7 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play103704134 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 103704134
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
			arg_540_1.auto_ = false
		end

		function arg_540_1.playNext_(arg_542_0)
			arg_540_1.onStoryFinished_()
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0.125

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_1 = arg_540_1:FormatText(arg_540_1:GetWordFromCfg(103704134).content)

				arg_540_1.text_.text = var_543_1

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_3 = 5 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_1) / 5)

				if (5 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_1) / 5)) > 0 and var_543_0 < var_543_3 then
					arg_540_1.talkMaxDuration = var_543_3

					if var_543_3 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_3 + 0
					end
				end

				arg_540_1.text_.text = var_543_1
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_4 = math.max(var_543_0, arg_540_1.talkMaxDuration)

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_4 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - 0) / var_543_4

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= 0 + var_543_4 and arg_540_1.time_ < 0 + var_543_4 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0903",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/A00",
		"TextureConfig/Background/ST16",
		"TextureConfig/Background/R3701"
	},
	voices = {
		"story_v_side_old_103704.awb"
	}
}
