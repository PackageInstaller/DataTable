return {
	Play114202001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114202001
		arg_1_1.duration_ = 4.9

		local var_1_0 = {
			ja = 4.9,
			ko = 3.866
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
				arg_1_0:Play114202002(arg_1_1)
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

			local var_4_3 = "F04"

			if arg_1_1.bgs_.F04 == nil then
				local var_4_4 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_3)
				var_4_4.name = var_4_3
				var_4_4.transform.parent = arg_1_1.stage_.transform
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_3] = var_4_4
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.F04

				arg_1_1.bgs_.F04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = 2 * (var_4_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_5.transform.localScale = Vector3.New(var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F04" then
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

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
			local var_4_15 = 0.05

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[234].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:GetWordFromCfg(114202001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 2 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 2)

				if (2 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 2)) > 0 and var_4_15 < var_4_20 then
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

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202001", "story_v_out_114202.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_114202", "114202001", "story_v_out_114202.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_114202", "114202001", "story_v_out_114202.awb")

						arg_1_1:RecordAudio("114202001", var_4_22)
						arg_1_1:RecordAudio("114202001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_114202", "114202001", "story_v_out_114202.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_114202", "114202001", "story_v_out_114202.awb")
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
	Play114202002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114202002
		arg_9_1.duration_ = 3.2

		local var_9_0 = {
			ja = 3.2,
			ko = 1.933,
			zh = 1.433,
			en = 1.1
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
				arg_9_0:Play114202003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.15

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[209].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(114202002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 6 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 6)

				if (6 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 6)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202002", "story_v_out_114202.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_114202", "114202002", "story_v_out_114202.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_114202", "114202002", "story_v_out_114202.awb")

						arg_9_1:RecordAudio("114202002", var_12_6)
						arg_9_1:RecordAudio("114202002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_114202", "114202002", "story_v_out_114202.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_114202", "114202002", "story_v_out_114202.awb")
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
	Play114202003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114202003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play114202004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.95

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(114202003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 38 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 38)

				if (38 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 38)) > 0 and var_16_0 < var_16_3 then
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
	Play114202004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114202004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play114202005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.65

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(114202004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 26 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 26)

				if (26 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 26)) > 0 and var_20_0 < var_20_3 then
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
	Play114202005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114202005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play114202006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.25

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(114202005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 50 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 50)

				if (50 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 50)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play114202006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114202006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play114202007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.65

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(114202006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 26)

				if (26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 26)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play114202007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114202007
		arg_29_1.duration_ = 4.53

		local var_29_0 = {
			ja = 2.6,
			ko = 1.833,
			zh = 1.766,
			en = 4.533
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
				arg_29_0:Play114202008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["10017"] == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.imageGo_, arg_29_1.canvasGo_.transform)

				var_32_0.transform:SetSiblingIndex(1)

				var_32_0.name = "10017"

				local var_32_1 = var_32_0:GetComponent(typeof(Image))

				var_32_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10017")

				var_32_1:SetNativeSize()

				var_32_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_29_1.actors_["10017"] = var_32_0
			end

			local var_32_2 = arg_29_1.actors_["10017"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10017 = var_32_2.localPosition
				var_32_2.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10017", 2)
			end

			local var_32_3 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 then
				var_32_2.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10017, Vector3.New(-390, -350, -180), (arg_29_1.time_ - 0) / var_32_3)
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 then
				var_32_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_32_4 = arg_29_1.actors_["10017"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_4) then
				local var_32_5 = var_32_4:GetComponent("Image")

				if var_32_5 then
					arg_29_1.var_.highlightMatValue10017 = var_32_5
				end
			end

			local var_32_6 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_4) then
				if arg_29_1.var_.highlightMatValue10017 then
					local var_32_7 = Mathf.Lerp(0.5, 1, (arg_29_1.time_ - 0) / var_32_6)

					arg_29_1.var_.highlightMatValue10017.color.r = var_32_7
					arg_29_1.var_.highlightMatValue10017.color.g = var_32_7
					arg_29_1.var_.highlightMatValue10017.color.b = var_32_7
					arg_29_1.var_.highlightMatValue10017.color = arg_29_1.var_.highlightMatValue10017.color
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.highlightMatValue10017 then
				var_32_4.transform:SetSiblingIndex(1)

				arg_29_1.var_.highlightMatValue10017.color.r = 1
				arg_29_1.var_.highlightMatValue10017.color.g = 1
				arg_29_1.var_.highlightMatValue10017.color.b = 1
				arg_29_1.var_.highlightMatValue10017.color = arg_29_1.var_.highlightMatValue10017.color
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_8 = arg_29_1.actors_["10017"]:GetComponent("Image")

				if var_32_8 then
					arg_29_1.var_.alphaMatValue10017 = var_32_8
					arg_29_1.var_.alphaOldValue10017 = var_32_8.color.a
				end

				arg_29_1.var_.alphaOldValue10017 = 0
			end

			local var_32_9 = 0.5

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_9 then
				if arg_29_1.var_.alphaMatValue10017 then
					arg_29_1.var_.alphaMatValue10017.color.a = Mathf.Lerp(arg_29_1.var_.alphaOldValue10017, 1, (arg_29_1.time_ - 0) / var_32_9)
					arg_29_1.var_.alphaMatValue10017.color = arg_29_1.var_.alphaMatValue10017.color
				end
			end

			if arg_29_1.time_ >= 0 + var_32_9 and arg_29_1.time_ < 0 + var_32_9 + arg_32_0 and arg_29_1.var_.alphaMatValue10017 then
				arg_29_1.var_.alphaMatValue10017.color.a = 1
				arg_29_1.var_.alphaMatValue10017.color = arg_29_1.var_.alphaMatValue10017.color
			end

			local var_32_10 = 0
			local var_32_11 = 0.175

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_12 = arg_29_1:GetWordFromCfg(114202007)
				local var_32_13 = arg_29_1:FormatText(var_32_12.content)

				arg_29_1.text_.text = var_32_13

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_15 = 7 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_13) / 7)

				if (7 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_13) / 7)) > 0 and var_32_11 < var_32_15 then
					arg_29_1.talkMaxDuration = var_32_15

					if var_32_15 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_10
					end
				end

				arg_29_1.text_.text = var_32_13
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202007", "story_v_out_114202.awb") ~= 0 then
					local var_32_16 = manager.audio:GetVoiceLength("story_v_out_114202", "114202007", "story_v_out_114202.awb") / 1000

					if var_32_16 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_10
					end

					if var_32_12.prefab_name ~= "" and arg_29_1.actors_[var_32_12.prefab_name] ~= nil then
						local var_32_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_12.prefab_name].transform, "story_v_out_114202", "114202007", "story_v_out_114202.awb")

						arg_29_1:RecordAudio("114202007", var_32_17)
						arg_29_1:RecordAudio("114202007", var_32_17)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_114202", "114202007", "story_v_out_114202.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_114202", "114202007", "story_v_out_114202.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_18 = math.max(var_32_11, arg_29_1.talkMaxDuration)

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_18 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_10) / var_32_18

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_10 + var_32_18 and arg_29_1.time_ < var_32_10 + var_32_18 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play114202008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114202008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play114202009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10017"]) then
				local var_36_0 = arg_33_1.actors_["10017"]:GetComponent("Image")

				if var_36_0 then
					arg_33_1.var_.highlightMatValue10017 = var_36_0
				end
			end

			local var_36_1 = 0.5

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 and not isNil(arg_33_1.actors_["10017"]) then
				if arg_33_1.var_.highlightMatValue10017 then
					local var_36_2 = Mathf.Lerp(1, 0.5, (arg_33_1.time_ - 0) / var_36_1)

					arg_33_1.var_.highlightMatValue10017.color.r = var_36_2
					arg_33_1.var_.highlightMatValue10017.color.g = var_36_2
					arg_33_1.var_.highlightMatValue10017.color.b = var_36_2
					arg_33_1.var_.highlightMatValue10017.color = arg_33_1.var_.highlightMatValue10017.color
				end
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 and not isNil(arg_33_1.actors_["10017"]) and arg_33_1.var_.highlightMatValue10017 then
				arg_33_1.var_.highlightMatValue10017.color.r = 0.5
				arg_33_1.var_.highlightMatValue10017.color.g = 0.5
				arg_33_1.var_.highlightMatValue10017.color.b = 0.5
				arg_33_1.var_.highlightMatValue10017.color = arg_33_1.var_.highlightMatValue10017.color
			end

			local var_36_3 = 0
			local var_36_4 = 1

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_5 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(114202008).content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 40 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 40)

				if (40 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 40)) > 0 and var_36_4 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_3
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_4, arg_33_1.talkMaxDuration)

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_3) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_3 + var_36_8 and arg_33_1.time_ < var_36_3 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114202009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114202009
		arg_37_1.duration_ = 1.23

		local var_37_0 = {
			ja = 1.233,
			ko = 1.1,
			zh = 1.133,
			en = 1.2
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
				arg_37_0:Play114202010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.actors_["10015"] == nil then
				local var_40_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10015")

				if not isNil(var_40_0) then
					local var_40_1 = Object.Instantiate(var_40_0, arg_37_1.canvasGo_.transform)

					var_40_1.transform:SetSiblingIndex(1)

					var_40_1.name = "10015"
					var_40_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_37_1.actors_["10015"] = var_40_1

					if arg_37_1.isInRecall_ then
						for iter_40_0, iter_40_1 in ipairs((var_40_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_40_1.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_40_2 = arg_37_1.actors_["10015"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10015 = var_40_2.localPosition
				var_40_2.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10015", 4)

				for iter_40_2 = 0, var_40_2.childCount - 1 do
					local var_40_3 = var_40_2:GetChild(iter_40_2)

					if var_40_3.name == "split_1" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_2.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_37_1.time_ - 0) / var_40_4)
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_40_5 = arg_37_1.actors_["10015"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.actorSpriteComps10015 == nil then
				arg_37_1.var_.actorSpriteComps10015 = var_40_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_6 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.actorSpriteComps10015 then
					for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_40_4 then
							if arg_37_1.isInRecall_ then
								iter_40_4.color = Color.New(Mathf.Lerp(iter_40_4.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_6), Mathf.Lerp(iter_40_4.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_6), (Mathf.Lerp(iter_40_4.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_6)))
							else
								local var_40_7 = Mathf.Lerp(iter_40_4.color.r, 1, (arg_37_1.time_ - 0) / var_40_6)

								iter_40_4.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.actorSpriteComps10015 then
				for iter_40_5, iter_40_6 in pairs(arg_37_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_40_6 then
						iter_40_6.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_8 = arg_37_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_40_8 then
					arg_37_1.var_.alphaOldValue10015 = var_40_8.alpha
					arg_37_1.var_.characterEffect10015 = var_40_8
				end

				arg_37_1.var_.alphaOldValue10015 = 0
			end

			local var_40_9 = 0.5

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_9 then
				if arg_37_1.var_.characterEffect10015 then
					arg_37_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_37_1.var_.alphaOldValue10015, 1, (arg_37_1.time_ - 0) / var_40_9)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_9 and arg_37_1.time_ < 0 + var_40_9 + arg_40_0 and arg_37_1.var_.characterEffect10015 then
				arg_37_1.var_.characterEffect10015.alpha = 1
			end

			local var_40_10 = 0
			local var_40_11 = 0.075

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_12 = arg_37_1:GetWordFromCfg(114202009)
				local var_40_13 = arg_37_1:FormatText(var_40_12.content)

				arg_37_1.text_.text = var_40_13

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_15 = 3 <= 0 and var_40_11 or var_40_11 * (utf8.len(var_40_13) / 3)

				if (3 <= 0 and var_40_11 or var_40_11 * (utf8.len(var_40_13) / 3)) > 0 and var_40_11 < var_40_15 then
					arg_37_1.talkMaxDuration = var_40_15

					if var_40_15 + var_40_10 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_15 + var_40_10
					end
				end

				arg_37_1.text_.text = var_40_13
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202009", "story_v_out_114202.awb") ~= 0 then
					local var_40_16 = manager.audio:GetVoiceLength("story_v_out_114202", "114202009", "story_v_out_114202.awb") / 1000

					if var_40_16 + var_40_10 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_16 + var_40_10
					end

					if var_40_12.prefab_name ~= "" and arg_37_1.actors_[var_40_12.prefab_name] ~= nil then
						local var_40_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_12.prefab_name].transform, "story_v_out_114202", "114202009", "story_v_out_114202.awb")

						arg_37_1:RecordAudio("114202009", var_40_17)
						arg_37_1:RecordAudio("114202009", var_40_17)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114202", "114202009", "story_v_out_114202.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114202", "114202009", "story_v_out_114202.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_18 = math.max(var_40_11, arg_37_1.talkMaxDuration)

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_18 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_10) / var_40_18

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_10 + var_40_18 and arg_37_1.time_ < var_40_10 + var_40_18 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play114202010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114202010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play114202011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10015"]) and arg_41_1.var_.actorSpriteComps10015 == nil then
				arg_41_1.var_.actorSpriteComps10015 = arg_41_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.034

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10015"]) then
				if arg_41_1.var_.actorSpriteComps10015 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								iter_44_1.color = Color.New(Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_0), Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_0), (Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_0)))
							else
								local var_44_1 = Mathf.Lerp(iter_44_1.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_0)

								iter_44_1.color = Color.New(var_44_1, var_44_1, var_44_1)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10015"]) and arg_41_1.var_.actorSpriteComps10015 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10015 = nil
			end

			local var_44_2 = 0
			local var_44_3 = 0.6

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(114202010).content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 24 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_4) / 24)

				if (24 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_4) / 24)) > 0 and var_44_3 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_7 and arg_41_1.time_ < var_44_2 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play114202011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114202011
		arg_45_1.duration_ = 3.1

		local var_45_0 = {
			ja = 3.1,
			ko = 2.466,
			zh = 1.5,
			en = 1.466
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
				arg_45_0:Play114202012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10015"]) and arg_45_1.var_.actorSpriteComps10015 == nil then
				arg_45_1.var_.actorSpriteComps10015 = arg_45_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10015"]) then
				if arg_45_1.var_.actorSpriteComps10015 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								iter_48_1.color = Color.New(Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_0), Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_0), (Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_0)))
							else
								local var_48_1 = Mathf.Lerp(iter_48_1.color.r, 1, (arg_45_1.time_ - 0) / var_48_0)

								iter_48_1.color = Color.New(var_48_1, var_48_1, var_48_1)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10015"]) and arg_45_1.var_.actorSpriteComps10015 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10015 = nil
			end

			local var_48_2 = arg_45_1.actors_["10015"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10015 = var_48_2.localPosition
				var_48_2.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10015", 4)

				for iter_48_4 = 0, var_48_2.childCount - 1 do
					local var_48_3 = var_48_2:GetChild(iter_48_4)

					if var_48_3.name == "split_2" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				var_48_2.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_45_1.time_ - 0) / var_48_4)
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				var_48_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_48_5 = 0
			local var_48_6 = 0.15

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(114202011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 6 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 6)

				if (6 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 6)) > 0 and var_48_6 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202011", "story_v_out_114202.awb") ~= 0 then
					local var_48_11 = manager.audio:GetVoiceLength("story_v_out_114202", "114202011", "story_v_out_114202.awb") / 1000

					if var_48_11 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_5
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_out_114202", "114202011", "story_v_out_114202.awb")

						arg_45_1:RecordAudio("114202011", var_48_12)
						arg_45_1:RecordAudio("114202011", var_48_12)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_114202", "114202011", "story_v_out_114202.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_114202", "114202011", "story_v_out_114202.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_13 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_13 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_13

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_13 and arg_45_1.time_ < var_48_5 + var_48_13 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play114202012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114202012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play114202013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10015"]) and arg_49_1.var_.actorSpriteComps10015 == nil then
				arg_49_1.var_.actorSpriteComps10015 = arg_49_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10015"]) then
				if arg_49_1.var_.actorSpriteComps10015 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								iter_52_1.color = Color.New(Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_0), Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_0), (Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_0)))
							else
								local var_52_1 = Mathf.Lerp(iter_52_1.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_0)

								iter_52_1.color = Color.New(var_52_1, var_52_1, var_52_1)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10015"]) and arg_49_1.var_.actorSpriteComps10015 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10015 = nil
			end

			local var_52_2 = 0
			local var_52_3 = 0.625

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(114202012).content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 25 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_4) / 25)

				if (25 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_4) / 25)) > 0 and var_52_3 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_7 and arg_49_1.time_ < var_52_2 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114202013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114202013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play114202014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10015 = arg_53_1.actors_["10015"].transform.localPosition
				arg_53_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10015", 7)

				for iter_56_0 = 0, arg_53_1.actors_["10015"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["10015"].transform:GetChild(iter_56_0)

					if var_56_0.name == "split_2" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10015, Vector3.New(0, -2000, -180), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["10015"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_56_2 = arg_53_1.actors_["10015"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10015 = var_56_2.localPosition
				var_56_2.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10015", 3)

				for iter_56_1 = 0, var_56_2.childCount - 1 do
					local var_56_3 = var_56_2:GetChild(iter_56_1)

					if var_56_3.name == "split_1" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10015, Vector3.New(0, -350, -180), (arg_53_1.time_ - 0) / var_56_4)
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_56_5 = arg_53_1.actors_["10017"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) then
				local var_56_6 = var_56_5:GetComponent("Image")

				if var_56_6 then
					arg_53_1.var_.highlightMatValue10017 = var_56_6
				end
			end

			local var_56_7 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 and not isNil(var_56_5) then
				if arg_53_1.var_.highlightMatValue10017 then
					local var_56_8 = Mathf.Lerp(1, 0.5, (arg_53_1.time_ - 0) / var_56_7)

					arg_53_1.var_.highlightMatValue10017.color.r = var_56_8
					arg_53_1.var_.highlightMatValue10017.color.g = var_56_8
					arg_53_1.var_.highlightMatValue10017.color.b = var_56_8
					arg_53_1.var_.highlightMatValue10017.color = arg_53_1.var_.highlightMatValue10017.color
				end
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.highlightMatValue10017 then
				arg_53_1.var_.highlightMatValue10017.color.r = 0.5
				arg_53_1.var_.highlightMatValue10017.color.g = 0.5
				arg_53_1.var_.highlightMatValue10017.color.b = 0.5
				arg_53_1.var_.highlightMatValue10017.color = arg_53_1.var_.highlightMatValue10017.color
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				local var_56_9 = arg_53_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_56_9 then
					arg_53_1.var_.alphaOldValue10015 = var_56_9.alpha
					arg_53_1.var_.characterEffect10015 = var_56_9
				end

				arg_53_1.var_.alphaOldValue10015 = 0
			end

			local var_56_10 = 0.5

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_10 then
				if arg_53_1.var_.characterEffect10015 then
					arg_53_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_53_1.var_.alphaOldValue10015, 1, (arg_53_1.time_ - 0) / var_56_10)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_10 and arg_53_1.time_ < 0 + var_56_10 + arg_56_0 and arg_53_1.var_.characterEffect10015 then
				arg_53_1.var_.characterEffect10015.alpha = 1
			end

			local var_56_11 = arg_53_1.actors_["10017"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10017 = var_56_11.localPosition
				var_56_11.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10017", 7)
			end

			local var_56_12 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_12 then
				var_56_11.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10017, Vector3.New(0, -2000, 300), (arg_53_1.time_ - 0) / var_56_12)
			end

			if arg_53_1.time_ >= 0 + var_56_12 and arg_53_1.time_ < 0 + var_56_12 + arg_56_0 then
				var_56_11.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_56_13 = arg_53_1.actors_["10015"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_13) and arg_53_1.var_.actorSpriteComps10015 == nil then
				arg_53_1.var_.actorSpriteComps10015 = var_56_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_14 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_14 and not isNil(var_56_13) then
				if arg_53_1.var_.actorSpriteComps10015 then
					for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_56_3 then
							if arg_53_1.isInRecall_ then
								iter_56_3.color = Color.New(Mathf.Lerp(iter_56_3.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_14), Mathf.Lerp(iter_56_3.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_14), (Mathf.Lerp(iter_56_3.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_14)))
							else
								local var_56_15 = Mathf.Lerp(iter_56_3.color.r, 1, (arg_53_1.time_ - 0) / var_56_14)

								iter_56_3.color = Color.New(var_56_15, var_56_15, var_56_15)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_14 and arg_53_1.time_ < 0 + var_56_14 + arg_56_0 and not isNil(var_56_13) and arg_53_1.var_.actorSpriteComps10015 then
				for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_56_5 then
						iter_56_5.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10015 = nil
			end

			local var_56_16 = 0
			local var_56_17 = 0.675

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(114202013).content)

				arg_53_1.text_.text = var_56_18

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 27 <= 0 and var_56_17 or var_56_17 * (utf8.len(var_56_18) / 27)

				if (27 <= 0 and var_56_17 or var_56_17 * (utf8.len(var_56_18) / 27)) > 0 and var_56_17 < var_56_20 then
					arg_53_1.talkMaxDuration = var_56_20

					if var_56_20 + var_56_16 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_20 + var_56_16
					end
				end

				arg_53_1.text_.text = var_56_18
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_21 = math.max(var_56_17, arg_53_1.talkMaxDuration)

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_21 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_16) / var_56_21

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_16 + var_56_21 and arg_53_1.time_ < var_56_16 + var_56_21 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play114202014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114202014
		arg_57_1.duration_ = 10.2

		local var_57_0 = {
			ja = 10.2,
			ko = 5.733,
			zh = 5.4,
			en = 6.833
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
				arg_57_0:Play114202015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10015"]) and arg_57_1.var_.actorSpriteComps10015 == nil then
				arg_57_1.var_.actorSpriteComps10015 = arg_57_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.034

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10015"]) then
				if arg_57_1.var_.actorSpriteComps10015 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								iter_60_1.color = Color.New(Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_0), Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_0), (Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_0)))
							else
								local var_60_1 = Mathf.Lerp(iter_60_1.color.r, 1, (arg_57_1.time_ - 0) / var_60_0)

								iter_60_1.color = Color.New(var_60_1, var_60_1, var_60_1)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10015"]) and arg_57_1.var_.actorSpriteComps10015 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10015 = nil
			end

			local var_60_2 = 0
			local var_60_3 = 0.7

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(114202014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 27 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 27)

				if (27 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 27)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202014", "story_v_out_114202.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_114202", "114202014", "story_v_out_114202.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_114202", "114202014", "story_v_out_114202.awb")

						arg_57_1:RecordAudio("114202014", var_60_9)
						arg_57_1:RecordAudio("114202014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_114202", "114202014", "story_v_out_114202.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_114202", "114202014", "story_v_out_114202.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114202015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114202015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play114202016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				local var_64_0 = arg_61_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_64_0 then
					arg_61_1.var_.alphaOldValue10015 = var_64_0.alpha
					arg_61_1.var_.characterEffect10015 = var_64_0
				end

				arg_61_1.var_.alphaOldValue10015 = 1
			end

			local var_64_1 = 0.5

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				if arg_61_1.var_.characterEffect10015 then
					arg_61_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_61_1.var_.alphaOldValue10015, 0, (arg_61_1.time_ - 0) / var_64_1)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 and arg_61_1.var_.characterEffect10015 then
				arg_61_1.var_.characterEffect10015.alpha = 0
			end

			local var_64_2 = 0
			local var_64_3 = 0.8

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(114202015).content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 32 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 32)

				if (32 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 32)) > 0 and var_64_3 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_7 and arg_61_1.time_ < var_64_2 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play114202016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114202016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play114202017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 1.175

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(114202016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 47 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 47)

				if (47 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 47)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play114202017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114202017
		arg_69_1.duration_ = 9

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play114202018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.bgs_.ST21 == nil then
				local var_72_0 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST21")
				var_72_0.name = "ST21"
				var_72_0.transform.parent = arg_69_1.stage_.transform
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_.ST21 = var_72_0
			end

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= 2 + arg_72_0 then
				local var_72_1 = arg_69_1.bgs_.ST21

				arg_69_1.bgs_.ST21.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_2 = var_72_1:GetComponent("SpriteRenderer")

				if var_72_2 and var_72_2.sprite then
					local var_72_3 = 2 * (var_72_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_1.transform.localScale = Vector3.New(var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "ST21" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_4 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_5 = 1.999999999999

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_5 then
				local var_72_6 = Color.New(0, 0, 0)

				var_72_6.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - var_72_4) / var_72_5)
				arg_69_1.mask_.color = var_72_6
			end

			if arg_69_1.time_ >= var_72_4 + var_72_5 and arg_69_1.time_ < var_72_4 + var_72_5 + arg_72_0 then
				local var_72_7 = Color.New(0, 0, 0)

				var_72_7.a = 1
				arg_69_1.mask_.color = var_72_7
			end

			local var_72_8 = 1.999999999999

			if 1.999999999999 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_9 = 2

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 then
				local var_72_10 = Color.New(0, 0, 0)

				var_72_10.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - var_72_8) / var_72_9)
				arg_69_1.mask_.color = var_72_10
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 then
				local var_72_11 = Color.New(0, 0, 0)

				arg_69_1.mask_.enabled = false
				var_72_11.a = 0
				arg_69_1.mask_.color = var_72_11
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_12 = 3.999999999999
			local var_72_13 = 0.175

			if 3.999999999999 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_14 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_14:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_15 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(114202017).content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 7 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 7)

				if (7 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 7)) > 0 and var_72_13 < var_72_17 then
					arg_69_1.talkMaxDuration = var_72_17
					var_72_12 = var_72_12 + 0.3

					if var_72_17 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_18 = var_72_12 + 0.3
			local var_72_19 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_18 + var_72_19 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_18) / var_72_19

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_18 + var_72_19 and arg_69_1.time_ < var_72_18 + var_72_19 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114202018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 114202018
		arg_75_1.duration_ = 6.53

		local var_75_0 = {
			ja = 6.533,
			ko = 5.766,
			zh = 3.866,
			en = 5.666
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
				arg_75_0:Play114202019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10017 = arg_75_1.actors_["10017"].transform.localPosition
				arg_75_1.actors_["10017"].transform.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("10017", 2)
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["10017"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10017, Vector3.New(-390, -350, -180), (arg_75_1.time_ - 0) / var_78_0)
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["10017"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_78_1 = arg_75_1.actors_["10017"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_1) then
				local var_78_2 = var_78_1:GetComponent("Image")

				if var_78_2 then
					arg_75_1.var_.highlightMatValue10017 = var_78_2
				end
			end

			local var_78_3 = 0.034

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_1) then
				if arg_75_1.var_.highlightMatValue10017 then
					local var_78_4 = Mathf.Lerp(0.5, 1, (arg_75_1.time_ - 0) / var_78_3)

					arg_75_1.var_.highlightMatValue10017.color.r = var_78_4
					arg_75_1.var_.highlightMatValue10017.color.g = var_78_4
					arg_75_1.var_.highlightMatValue10017.color.b = var_78_4
					arg_75_1.var_.highlightMatValue10017.color = arg_75_1.var_.highlightMatValue10017.color
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.highlightMatValue10017 then
				var_78_1.transform:SetSiblingIndex(1)

				arg_75_1.var_.highlightMatValue10017.color.r = 1
				arg_75_1.var_.highlightMatValue10017.color.g = 1
				arg_75_1.var_.highlightMatValue10017.color.b = 1
				arg_75_1.var_.highlightMatValue10017.color = arg_75_1.var_.highlightMatValue10017.color
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				local var_78_5 = arg_75_1.actors_["10017"]:GetComponent("Image")

				if var_78_5 then
					arg_75_1.var_.alphaMatValue10017 = var_78_5
					arg_75_1.var_.alphaOldValue10017 = var_78_5.color.a
				end

				arg_75_1.var_.alphaOldValue10017 = 0
			end

			local var_78_6 = 0.5

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_6 then
				if arg_75_1.var_.alphaMatValue10017 then
					arg_75_1.var_.alphaMatValue10017.color.a = Mathf.Lerp(arg_75_1.var_.alphaOldValue10017, 1, (arg_75_1.time_ - 0) / var_78_6)
					arg_75_1.var_.alphaMatValue10017.color = arg_75_1.var_.alphaMatValue10017.color
				end
			end

			if arg_75_1.time_ >= 0 + var_78_6 and arg_75_1.time_ < 0 + var_78_6 + arg_78_0 and arg_75_1.var_.alphaMatValue10017 then
				arg_75_1.var_.alphaMatValue10017.color.a = 1
				arg_75_1.var_.alphaMatValue10017.color = arg_75_1.var_.alphaMatValue10017.color
			end

			local var_78_7 = 0
			local var_78_8 = 0.4

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_7 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_9 = arg_75_1:GetWordFromCfg(114202018)
				local var_78_10 = arg_75_1:FormatText(var_78_9.content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_12 = 16 <= 0 and var_78_8 or var_78_8 * (utf8.len(var_78_10) / 16)

				if (16 <= 0 and var_78_8 or var_78_8 * (utf8.len(var_78_10) / 16)) > 0 and var_78_8 < var_78_12 then
					arg_75_1.talkMaxDuration = var_78_12

					if var_78_12 + var_78_7 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_12 + var_78_7
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202018", "story_v_out_114202.awb") ~= 0 then
					local var_78_13 = manager.audio:GetVoiceLength("story_v_out_114202", "114202018", "story_v_out_114202.awb") / 1000

					if var_78_13 + var_78_7 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_7
					end

					if var_78_9.prefab_name ~= "" and arg_75_1.actors_[var_78_9.prefab_name] ~= nil then
						local var_78_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_9.prefab_name].transform, "story_v_out_114202", "114202018", "story_v_out_114202.awb")

						arg_75_1:RecordAudio("114202018", var_78_14)
						arg_75_1:RecordAudio("114202018", var_78_14)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_114202", "114202018", "story_v_out_114202.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_114202", "114202018", "story_v_out_114202.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_15 = math.max(var_78_8, arg_75_1.talkMaxDuration)

			if var_78_7 <= arg_75_1.time_ and arg_75_1.time_ < var_78_7 + var_78_15 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_7) / var_78_15

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_7 + var_78_15 and arg_75_1.time_ < var_78_7 + var_78_15 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play114202019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 114202019
		arg_79_1.duration_ = 7.43

		local var_79_0 = {
			ja = 6.833,
			ko = 7.433,
			zh = 5.033,
			en = 5.266
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
				arg_79_0:Play114202020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10015 = arg_79_1.actors_["10015"].transform.localPosition
				arg_79_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10015", 4)

				for iter_82_0 = 0, arg_79_1.actors_["10015"].transform.childCount - 1 do
					local var_82_0 = arg_79_1.actors_["10015"].transform:GetChild(iter_82_0)

					if var_82_0.name == "split_1" or not string.find(var_82_0.name, "split") then
						var_82_0.gameObject:SetActive(true)
					else
						var_82_0.gameObject:SetActive(false)
					end
				end
			end

			local var_82_1 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 then
				arg_79_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_79_1.time_ - 0) / var_82_1)
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 then
				arg_79_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_82_2 = arg_79_1.actors_["10017"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) then
				local var_82_3 = var_82_2:GetComponent("Image")

				if var_82_3 then
					arg_79_1.var_.highlightMatValue10017 = var_82_3
				end
			end

			local var_82_4 = 0.034

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 and not isNil(var_82_2) then
				if arg_79_1.var_.highlightMatValue10017 then
					local var_82_5 = Mathf.Lerp(1, 0.5, (arg_79_1.time_ - 0) / var_82_4)

					arg_79_1.var_.highlightMatValue10017.color.r = var_82_5
					arg_79_1.var_.highlightMatValue10017.color.g = var_82_5
					arg_79_1.var_.highlightMatValue10017.color.b = var_82_5
					arg_79_1.var_.highlightMatValue10017.color = arg_79_1.var_.highlightMatValue10017.color
				end
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.highlightMatValue10017 then
				arg_79_1.var_.highlightMatValue10017.color.r = 0.5
				arg_79_1.var_.highlightMatValue10017.color.g = 0.5
				arg_79_1.var_.highlightMatValue10017.color.b = 0.5
				arg_79_1.var_.highlightMatValue10017.color = arg_79_1.var_.highlightMatValue10017.color
			end

			local var_82_6 = arg_79_1.actors_["10015"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.actorSpriteComps10015 == nil then
				arg_79_1.var_.actorSpriteComps10015 = var_82_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_7 = 0.034

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 and not isNil(var_82_6) then
				if arg_79_1.var_.actorSpriteComps10015 then
					for iter_82_1, iter_82_2 in pairs(arg_79_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_82_2 then
							if arg_79_1.isInRecall_ then
								iter_82_2.color = Color.New(Mathf.Lerp(iter_82_2.color.r, arg_79_1.hightColor1.r, (arg_79_1.time_ - 0) / var_82_7), Mathf.Lerp(iter_82_2.color.g, arg_79_1.hightColor1.g, (arg_79_1.time_ - 0) / var_82_7), (Mathf.Lerp(iter_82_2.color.b, arg_79_1.hightColor1.b, (arg_79_1.time_ - 0) / var_82_7)))
							else
								local var_82_8 = Mathf.Lerp(iter_82_2.color.r, 1, (arg_79_1.time_ - 0) / var_82_7)

								iter_82_2.color = Color.New(var_82_8, var_82_8, var_82_8)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.actorSpriteComps10015 then
				for iter_82_3, iter_82_4 in pairs(arg_79_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_82_4 then
						iter_82_4.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_79_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				local var_82_9 = arg_79_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_82_9 then
					arg_79_1.var_.alphaOldValue10015 = var_82_9.alpha
					arg_79_1.var_.characterEffect10015 = var_82_9
				end

				arg_79_1.var_.alphaOldValue10015 = 0
			end

			local var_82_10 = 0.5

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_10 then
				if arg_79_1.var_.characterEffect10015 then
					arg_79_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_79_1.var_.alphaOldValue10015, 1, (arg_79_1.time_ - 0) / var_82_10)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_10 and arg_79_1.time_ < 0 + var_82_10 + arg_82_0 and arg_79_1.var_.characterEffect10015 then
				arg_79_1.var_.characterEffect10015.alpha = 1
			end

			local var_82_11 = 0
			local var_82_12 = 0.6

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 then
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

				local var_82_13 = arg_79_1:GetWordFromCfg(114202019)
				local var_82_14 = arg_79_1:FormatText(var_82_13.content)

				arg_79_1.text_.text = var_82_14

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_16 = 24 <= 0 and var_82_12 or var_82_12 * (utf8.len(var_82_14) / 24)

				if (24 <= 0 and var_82_12 or var_82_12 * (utf8.len(var_82_14) / 24)) > 0 and var_82_12 < var_82_16 then
					arg_79_1.talkMaxDuration = var_82_16

					if var_82_16 + var_82_11 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_16 + var_82_11
					end
				end

				arg_79_1.text_.text = var_82_14
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202019", "story_v_out_114202.awb") ~= 0 then
					local var_82_17 = manager.audio:GetVoiceLength("story_v_out_114202", "114202019", "story_v_out_114202.awb") / 1000

					if var_82_17 + var_82_11 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_17 + var_82_11
					end

					if var_82_13.prefab_name ~= "" and arg_79_1.actors_[var_82_13.prefab_name] ~= nil then
						local var_82_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_13.prefab_name].transform, "story_v_out_114202", "114202019", "story_v_out_114202.awb")

						arg_79_1:RecordAudio("114202019", var_82_18)
						arg_79_1:RecordAudio("114202019", var_82_18)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_114202", "114202019", "story_v_out_114202.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_114202", "114202019", "story_v_out_114202.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_19 = math.max(var_82_12, arg_79_1.talkMaxDuration)

			if var_82_11 <= arg_79_1.time_ and arg_79_1.time_ < var_82_11 + var_82_19 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_11) / var_82_19

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_11 + var_82_19 and arg_79_1.time_ < var_82_11 + var_82_19 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play114202020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 114202020
		arg_83_1.duration_ = 7.63

		local var_83_0 = {
			ja = 7.633,
			ko = 3.833,
			zh = 2.933,
			en = 4.3
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
				arg_83_0:Play114202021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["10017"]) then
				local var_86_0 = arg_83_1.actors_["10017"]:GetComponent("Image")

				if var_86_0 then
					arg_83_1.var_.highlightMatValue10017 = var_86_0
				end
			end

			local var_86_1 = 0.034

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 and not isNil(arg_83_1.actors_["10017"]) then
				if arg_83_1.var_.highlightMatValue10017 then
					local var_86_2 = Mathf.Lerp(0.5, 1, (arg_83_1.time_ - 0) / var_86_1)

					arg_83_1.var_.highlightMatValue10017.color.r = var_86_2
					arg_83_1.var_.highlightMatValue10017.color.g = var_86_2
					arg_83_1.var_.highlightMatValue10017.color.b = var_86_2
					arg_83_1.var_.highlightMatValue10017.color = arg_83_1.var_.highlightMatValue10017.color
				end
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 and not isNil(arg_83_1.actors_["10017"]) and arg_83_1.var_.highlightMatValue10017 then
				arg_83_1.actors_["10017"].transform:SetSiblingIndex(1)

				arg_83_1.var_.highlightMatValue10017.color.r = 1
				arg_83_1.var_.highlightMatValue10017.color.g = 1
				arg_83_1.var_.highlightMatValue10017.color.b = 1
				arg_83_1.var_.highlightMatValue10017.color = arg_83_1.var_.highlightMatValue10017.color
			end

			local var_86_3 = arg_83_1.actors_["10015"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_3) and arg_83_1.var_.actorSpriteComps10015 == nil then
				arg_83_1.var_.actorSpriteComps10015 = var_86_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_4 = 0.034

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 and not isNil(var_86_3) then
				if arg_83_1.var_.actorSpriteComps10015 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								iter_86_1.color = Color.New(Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor2.r, (arg_83_1.time_ - 0) / var_86_4), Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor2.g, (arg_83_1.time_ - 0) / var_86_4), (Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor2.b, (arg_83_1.time_ - 0) / var_86_4)))
							else
								local var_86_5 = Mathf.Lerp(iter_86_1.color.r, 0.5, (arg_83_1.time_ - 0) / var_86_4)

								iter_86_1.color = Color.New(var_86_5, var_86_5, var_86_5)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 and not isNil(var_86_3) and arg_83_1.var_.actorSpriteComps10015 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_86_3 then
						iter_86_3.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_83_1.var_.actorSpriteComps10015 = nil
			end

			local var_86_6 = 0
			local var_86_7 = 0.35

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_8 = arg_83_1:GetWordFromCfg(114202020)
				local var_86_9 = arg_83_1:FormatText(var_86_8.content)

				arg_83_1.text_.text = var_86_9

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 14 <= 0 and var_86_7 or var_86_7 * (utf8.len(var_86_9) / 14)

				if (14 <= 0 and var_86_7 or var_86_7 * (utf8.len(var_86_9) / 14)) > 0 and var_86_7 < var_86_11 then
					arg_83_1.talkMaxDuration = var_86_11

					if var_86_11 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_9
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202020", "story_v_out_114202.awb") ~= 0 then
					local var_86_12 = manager.audio:GetVoiceLength("story_v_out_114202", "114202020", "story_v_out_114202.awb") / 1000

					if var_86_12 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_12 + var_86_6
					end

					if var_86_8.prefab_name ~= "" and arg_83_1.actors_[var_86_8.prefab_name] ~= nil then
						local var_86_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_8.prefab_name].transform, "story_v_out_114202", "114202020", "story_v_out_114202.awb")

						arg_83_1:RecordAudio("114202020", var_86_13)
						arg_83_1:RecordAudio("114202020", var_86_13)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_114202", "114202020", "story_v_out_114202.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_114202", "114202020", "story_v_out_114202.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_14 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_14 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_14

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_14 and arg_83_1.time_ < var_86_6 + var_86_14 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play114202021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 114202021
		arg_87_1.duration_ = 7.37

		local var_87_0 = {
			ja = 7.366,
			ko = 6.733,
			zh = 5.566,
			en = 5.9
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
				arg_87_0:Play114202022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["10017"]) then
				local var_90_0 = arg_87_1.actors_["10017"]:GetComponent("Image")

				if var_90_0 then
					arg_87_1.var_.highlightMatValue10017 = var_90_0
				end
			end

			local var_90_1 = 0.034

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 and not isNil(arg_87_1.actors_["10017"]) then
				if arg_87_1.var_.highlightMatValue10017 then
					local var_90_2 = Mathf.Lerp(1, 0.5, (arg_87_1.time_ - 0) / var_90_1)

					arg_87_1.var_.highlightMatValue10017.color.r = var_90_2
					arg_87_1.var_.highlightMatValue10017.color.g = var_90_2
					arg_87_1.var_.highlightMatValue10017.color.b = var_90_2
					arg_87_1.var_.highlightMatValue10017.color = arg_87_1.var_.highlightMatValue10017.color
				end
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 and not isNil(arg_87_1.actors_["10017"]) and arg_87_1.var_.highlightMatValue10017 then
				arg_87_1.var_.highlightMatValue10017.color.r = 0.5
				arg_87_1.var_.highlightMatValue10017.color.g = 0.5
				arg_87_1.var_.highlightMatValue10017.color.b = 0.5
				arg_87_1.var_.highlightMatValue10017.color = arg_87_1.var_.highlightMatValue10017.color
			end

			local var_90_3 = arg_87_1.actors_["10015"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_3) and arg_87_1.var_.actorSpriteComps10015 == nil then
				arg_87_1.var_.actorSpriteComps10015 = var_90_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_4 = 0.034

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 and not isNil(var_90_3) then
				if arg_87_1.var_.actorSpriteComps10015 then
					for iter_90_0, iter_90_1 in pairs(arg_87_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_90_1 then
							if arg_87_1.isInRecall_ then
								iter_90_1.color = Color.New(Mathf.Lerp(iter_90_1.color.r, arg_87_1.hightColor1.r, (arg_87_1.time_ - 0) / var_90_4), Mathf.Lerp(iter_90_1.color.g, arg_87_1.hightColor1.g, (arg_87_1.time_ - 0) / var_90_4), (Mathf.Lerp(iter_90_1.color.b, arg_87_1.hightColor1.b, (arg_87_1.time_ - 0) / var_90_4)))
							else
								local var_90_5 = Mathf.Lerp(iter_90_1.color.r, 1, (arg_87_1.time_ - 0) / var_90_4)

								iter_90_1.color = Color.New(var_90_5, var_90_5, var_90_5)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 and not isNil(var_90_3) and arg_87_1.var_.actorSpriteComps10015 then
				for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_90_3 then
						iter_90_3.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_87_1.var_.actorSpriteComps10015 = nil
			end

			local var_90_6 = 0
			local var_90_7 = 0.625

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
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

				local var_90_8 = arg_87_1:GetWordFromCfg(114202021)
				local var_90_9 = arg_87_1:FormatText(var_90_8.content)

				arg_87_1.text_.text = var_90_9

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_11 = 25 <= 0 and var_90_7 or var_90_7 * (utf8.len(var_90_9) / 25)

				if (25 <= 0 and var_90_7 or var_90_7 * (utf8.len(var_90_9) / 25)) > 0 and var_90_7 < var_90_11 then
					arg_87_1.talkMaxDuration = var_90_11

					if var_90_11 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_11 + var_90_6
					end
				end

				arg_87_1.text_.text = var_90_9
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202021", "story_v_out_114202.awb") ~= 0 then
					local var_90_12 = manager.audio:GetVoiceLength("story_v_out_114202", "114202021", "story_v_out_114202.awb") / 1000

					if var_90_12 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_12 + var_90_6
					end

					if var_90_8.prefab_name ~= "" and arg_87_1.actors_[var_90_8.prefab_name] ~= nil then
						local var_90_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_8.prefab_name].transform, "story_v_out_114202", "114202021", "story_v_out_114202.awb")

						arg_87_1:RecordAudio("114202021", var_90_13)
						arg_87_1:RecordAudio("114202021", var_90_13)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_114202", "114202021", "story_v_out_114202.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_114202", "114202021", "story_v_out_114202.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_14 = math.max(var_90_7, arg_87_1.talkMaxDuration)

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_14 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_6) / var_90_14

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_6 + var_90_14 and arg_87_1.time_ < var_90_6 + var_90_14 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play114202022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 114202022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play114202023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["10015"]) and arg_91_1.var_.actorSpriteComps10015 == nil then
				arg_91_1.var_.actorSpriteComps10015 = arg_91_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_0 = 0.034

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["10015"]) then
				if arg_91_1.var_.actorSpriteComps10015 then
					for iter_94_0, iter_94_1 in pairs(arg_91_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_94_1 then
							if arg_91_1.isInRecall_ then
								iter_94_1.color = Color.New(Mathf.Lerp(iter_94_1.color.r, arg_91_1.hightColor2.r, (arg_91_1.time_ - 0) / var_94_0), Mathf.Lerp(iter_94_1.color.g, arg_91_1.hightColor2.g, (arg_91_1.time_ - 0) / var_94_0), (Mathf.Lerp(iter_94_1.color.b, arg_91_1.hightColor2.b, (arg_91_1.time_ - 0) / var_94_0)))
							else
								local var_94_1 = Mathf.Lerp(iter_94_1.color.r, 0.5, (arg_91_1.time_ - 0) / var_94_0)

								iter_94_1.color = Color.New(var_94_1, var_94_1, var_94_1)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["10015"]) and arg_91_1.var_.actorSpriteComps10015 then
				for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_94_3 then
						iter_94_3.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_91_1.var_.actorSpriteComps10015 = nil
			end

			local var_94_2 = 0
			local var_94_3 = 1.35

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_4 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(114202022).content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_6 = 54 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_4) / 54)

				if (54 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_4) / 54)) > 0 and var_94_3 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_2
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_3, arg_91_1.talkMaxDuration)

			if var_94_2 <= arg_91_1.time_ and arg_91_1.time_ < var_94_2 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_2) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_2 + var_94_7 and arg_91_1.time_ < var_94_2 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play114202023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 114202023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play114202024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.875

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(114202023).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 35 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 35)

				if (35 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 35)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play114202024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 114202024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play114202025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.7

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(114202024).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 28 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 28)

				if (28 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 28)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play114202025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 114202025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play114202026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.225

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(114202025).content)

				arg_103_1.text_.text = var_106_1

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_3 = 9 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 9)

				if (9 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 9)) > 0 and var_106_0 < var_106_3 then
					arg_103_1.talkMaxDuration = var_106_3

					if var_106_3 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_3 + 0
					end
				end

				arg_103_1.text_.text = var_106_1
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_4 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_4

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play114202026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 114202026
		arg_107_1.duration_ = 7.73

		local var_107_0 = {
			ja = 4.2,
			ko = 5.666,
			zh = 7.733,
			en = 5.333
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
				arg_107_0:Play114202027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10017"]) then
				local var_110_0 = arg_107_1.actors_["10017"]:GetComponent("Image")

				if var_110_0 then
					arg_107_1.var_.highlightMatValue10017 = var_110_0
				end
			end

			local var_110_1 = 0.034

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 and not isNil(arg_107_1.actors_["10017"]) then
				if arg_107_1.var_.highlightMatValue10017 then
					local var_110_2 = Mathf.Lerp(0.5, 1, (arg_107_1.time_ - 0) / var_110_1)

					arg_107_1.var_.highlightMatValue10017.color.r = var_110_2
					arg_107_1.var_.highlightMatValue10017.color.g = var_110_2
					arg_107_1.var_.highlightMatValue10017.color.b = var_110_2
					arg_107_1.var_.highlightMatValue10017.color = arg_107_1.var_.highlightMatValue10017.color
				end
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 and not isNil(arg_107_1.actors_["10017"]) and arg_107_1.var_.highlightMatValue10017 then
				arg_107_1.actors_["10017"].transform:SetSiblingIndex(1)

				arg_107_1.var_.highlightMatValue10017.color.r = 1
				arg_107_1.var_.highlightMatValue10017.color.g = 1
				arg_107_1.var_.highlightMatValue10017.color.b = 1
				arg_107_1.var_.highlightMatValue10017.color = arg_107_1.var_.highlightMatValue10017.color
			end

			local var_110_3 = 0
			local var_110_4 = 0.7

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_5 = arg_107_1:GetWordFromCfg(114202026)
				local var_110_6 = arg_107_1:FormatText(var_110_5.content)

				arg_107_1.text_.text = var_110_6

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_8 = 28 <= 0 and var_110_4 or var_110_4 * (utf8.len(var_110_6) / 28)

				if (28 <= 0 and var_110_4 or var_110_4 * (utf8.len(var_110_6) / 28)) > 0 and var_110_4 < var_110_8 then
					arg_107_1.talkMaxDuration = var_110_8

					if var_110_8 + var_110_3 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_3
					end
				end

				arg_107_1.text_.text = var_110_6
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202026", "story_v_out_114202.awb") ~= 0 then
					local var_110_9 = manager.audio:GetVoiceLength("story_v_out_114202", "114202026", "story_v_out_114202.awb") / 1000

					if var_110_9 + var_110_3 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_3
					end

					if var_110_5.prefab_name ~= "" and arg_107_1.actors_[var_110_5.prefab_name] ~= nil then
						local var_110_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_5.prefab_name].transform, "story_v_out_114202", "114202026", "story_v_out_114202.awb")

						arg_107_1:RecordAudio("114202026", var_110_10)
						arg_107_1:RecordAudio("114202026", var_110_10)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_114202", "114202026", "story_v_out_114202.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_114202", "114202026", "story_v_out_114202.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_11 = math.max(var_110_4, arg_107_1.talkMaxDuration)

			if var_110_3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_3 + var_110_11 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_3) / var_110_11

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_3 + var_110_11 and arg_107_1.time_ < var_110_3 + var_110_11 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play114202027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 114202027
		arg_111_1.duration_ = 5.93

		local var_111_0 = {
			ja = 5.933,
			ko = 3.633,
			zh = 3.366,
			en = 3.8
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
				arg_111_0:Play114202028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.45

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:GetWordFromCfg(114202027)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 18 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 18)

				if (18 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 18)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202027", "story_v_out_114202.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_114202", "114202027", "story_v_out_114202.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_114202", "114202027", "story_v_out_114202.awb")

						arg_111_1:RecordAudio("114202027", var_114_6)
						arg_111_1:RecordAudio("114202027", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_114202", "114202027", "story_v_out_114202.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_114202", "114202027", "story_v_out_114202.awb")
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
	Play114202028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 114202028
		arg_115_1.duration_ = 11.17

		local var_115_0 = {
			ja = 9.5,
			ko = 8.666,
			zh = 7.3,
			en = 11.166
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
				arg_115_0:Play114202029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.85

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:GetWordFromCfg(114202028)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 34 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 34)

				if (34 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 34)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202028", "story_v_out_114202.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_114202", "114202028", "story_v_out_114202.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_114202", "114202028", "story_v_out_114202.awb")

						arg_115_1:RecordAudio("114202028", var_118_6)
						arg_115_1:RecordAudio("114202028", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_114202", "114202028", "story_v_out_114202.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_114202", "114202028", "story_v_out_114202.awb")
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
	Play114202029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 114202029
		arg_119_1.duration_ = 10.6

		local var_119_0 = {
			ja = 8.666,
			ko = 8.9,
			zh = 9.166,
			en = 10.6
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
				arg_119_0:Play114202030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["10017"]) then
				local var_122_0 = arg_119_1.actors_["10017"]:GetComponent("Image")

				if var_122_0 then
					arg_119_1.var_.highlightMatValue10017 = var_122_0
				end
			end

			local var_122_1 = 0.034

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 and not isNil(arg_119_1.actors_["10017"]) then
				if arg_119_1.var_.highlightMatValue10017 then
					local var_122_2 = Mathf.Lerp(1, 0.5, (arg_119_1.time_ - 0) / var_122_1)

					arg_119_1.var_.highlightMatValue10017.color.r = var_122_2
					arg_119_1.var_.highlightMatValue10017.color.g = var_122_2
					arg_119_1.var_.highlightMatValue10017.color.b = var_122_2
					arg_119_1.var_.highlightMatValue10017.color = arg_119_1.var_.highlightMatValue10017.color
				end
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 and not isNil(arg_119_1.actors_["10017"]) and arg_119_1.var_.highlightMatValue10017 then
				arg_119_1.var_.highlightMatValue10017.color.r = 0.5
				arg_119_1.var_.highlightMatValue10017.color.g = 0.5
				arg_119_1.var_.highlightMatValue10017.color.b = 0.5
				arg_119_1.var_.highlightMatValue10017.color = arg_119_1.var_.highlightMatValue10017.color
			end

			local var_122_3 = arg_119_1.actors_["10015"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_3) and arg_119_1.var_.actorSpriteComps10015 == nil then
				arg_119_1.var_.actorSpriteComps10015 = var_122_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_4 = 0.034

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 and not isNil(var_122_3) then
				if arg_119_1.var_.actorSpriteComps10015 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								iter_122_1.color = Color.New(Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor1.r, (arg_119_1.time_ - 0) / var_122_4), Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor1.g, (arg_119_1.time_ - 0) / var_122_4), (Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor1.b, (arg_119_1.time_ - 0) / var_122_4)))
							else
								local var_122_5 = Mathf.Lerp(iter_122_1.color.r, 1, (arg_119_1.time_ - 0) / var_122_4)

								iter_122_1.color = Color.New(var_122_5, var_122_5, var_122_5)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 and not isNil(var_122_3) and arg_119_1.var_.actorSpriteComps10015 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_122_3 then
						iter_122_3.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps10015 = nil
			end

			local var_122_6 = 0
			local var_122_7 = 1.025

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_8 = arg_119_1:GetWordFromCfg(114202029)
				local var_122_9 = arg_119_1:FormatText(var_122_8.content)

				arg_119_1.text_.text = var_122_9

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 41 <= 0 and var_122_7 or var_122_7 * (utf8.len(var_122_9) / 41)

				if (41 <= 0 and var_122_7 or var_122_7 * (utf8.len(var_122_9) / 41)) > 0 and var_122_7 < var_122_11 then
					arg_119_1.talkMaxDuration = var_122_11

					if var_122_11 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_9
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202029", "story_v_out_114202.awb") ~= 0 then
					local var_122_12 = manager.audio:GetVoiceLength("story_v_out_114202", "114202029", "story_v_out_114202.awb") / 1000

					if var_122_12 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_12 + var_122_6
					end

					if var_122_8.prefab_name ~= "" and arg_119_1.actors_[var_122_8.prefab_name] ~= nil then
						local var_122_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_8.prefab_name].transform, "story_v_out_114202", "114202029", "story_v_out_114202.awb")

						arg_119_1:RecordAudio("114202029", var_122_13)
						arg_119_1:RecordAudio("114202029", var_122_13)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_114202", "114202029", "story_v_out_114202.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_114202", "114202029", "story_v_out_114202.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_14 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_14 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_14

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_14 and arg_119_1.time_ < var_122_6 + var_122_14 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play114202030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 114202030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play114202031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				local var_126_0 = arg_123_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_126_0 then
					arg_123_1.var_.alphaOldValue10015 = var_126_0.alpha
					arg_123_1.var_.characterEffect10015 = var_126_0
				end

				arg_123_1.var_.alphaOldValue10015 = 1
			end

			local var_126_1 = 0.5

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				if arg_123_1.var_.characterEffect10015 then
					arg_123_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_123_1.var_.alphaOldValue10015, 0, (arg_123_1.time_ - 0) / var_126_1)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 and arg_123_1.var_.characterEffect10015 then
				arg_123_1.var_.characterEffect10015.alpha = 0
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				local var_126_2 = arg_123_1.actors_["10017"]:GetComponent("Image")

				if var_126_2 then
					arg_123_1.var_.alphaMatValue10017 = var_126_2
					arg_123_1.var_.alphaOldValue10017 = var_126_2.color.a
				end

				arg_123_1.var_.alphaOldValue10017 = 1
			end

			local var_126_3 = 0.5

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 then
				if arg_123_1.var_.alphaMatValue10017 then
					arg_123_1.var_.alphaMatValue10017.color.a = Mathf.Lerp(arg_123_1.var_.alphaOldValue10017, 0, (arg_123_1.time_ - 0) / var_126_3)
					arg_123_1.var_.alphaMatValue10017.color = arg_123_1.var_.alphaMatValue10017.color
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and arg_123_1.var_.alphaMatValue10017 then
				arg_123_1.var_.alphaMatValue10017.color.a = 0
				arg_123_1.var_.alphaMatValue10017.color = arg_123_1.var_.alphaMatValue10017.color
			end

			local var_126_4 = 0
			local var_126_5 = 0.9

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(114202030).content)

				arg_123_1.text_.text = var_126_6

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_8 = 36 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_6) / 36)

				if (36 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_6) / 36)) > 0 and var_126_5 < var_126_8 then
					arg_123_1.talkMaxDuration = var_126_8

					if var_126_8 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_6
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_9 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_9 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_9

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_9 and arg_123_1.time_ < var_126_4 + var_126_9 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play114202031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 114202031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play114202032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.7

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(114202031).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 28 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 28)

				if (28 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 28)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play114202032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 114202032
		arg_131_1.duration_ = 13.53

		local var_131_0 = {
			ja = 4.266,
			ko = 9.6,
			zh = 10.966,
			en = 13.533
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play114202033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10017 = arg_131_1.actors_["10017"].transform.localPosition
				arg_131_1.actors_["10017"].transform.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10017", 2)
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["10017"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10017, Vector3.New(-390, -350, -180), (arg_131_1.time_ - 0) / var_134_0)
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["10017"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_134_1 = arg_131_1.actors_["10017"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) then
				local var_134_2 = var_134_1:GetComponent("Image")

				if var_134_2 then
					arg_131_1.var_.highlightMatValue10017 = var_134_2
				end
			end

			local var_134_3 = 0.034

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_1) then
				if arg_131_1.var_.highlightMatValue10017 then
					local var_134_4 = Mathf.Lerp(0.5, 1, (arg_131_1.time_ - 0) / var_134_3)

					arg_131_1.var_.highlightMatValue10017.color.r = var_134_4
					arg_131_1.var_.highlightMatValue10017.color.g = var_134_4
					arg_131_1.var_.highlightMatValue10017.color.b = var_134_4
					arg_131_1.var_.highlightMatValue10017.color = arg_131_1.var_.highlightMatValue10017.color
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.highlightMatValue10017 then
				var_134_1.transform:SetSiblingIndex(1)

				arg_131_1.var_.highlightMatValue10017.color.r = 1
				arg_131_1.var_.highlightMatValue10017.color.g = 1
				arg_131_1.var_.highlightMatValue10017.color.b = 1
				arg_131_1.var_.highlightMatValue10017.color = arg_131_1.var_.highlightMatValue10017.color
			end

			local var_134_5 = arg_131_1.actors_["10017"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_5) then
				local var_134_6 = var_134_5:GetComponent("Image")

				if var_134_6 then
					arg_131_1.var_.highlightMatValue10017 = var_134_6
				end
			end

			local var_134_7 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 and not isNil(var_134_5) then
				if arg_131_1.var_.highlightMatValue10017 then
					local var_134_8 = Mathf.Lerp(0.5, 1, (arg_131_1.time_ - 0) / var_134_7)

					arg_131_1.var_.highlightMatValue10017.color.r = var_134_8
					arg_131_1.var_.highlightMatValue10017.color.g = var_134_8
					arg_131_1.var_.highlightMatValue10017.color.b = var_134_8
					arg_131_1.var_.highlightMatValue10017.color = arg_131_1.var_.highlightMatValue10017.color
				end
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.highlightMatValue10017 then
				var_134_5.transform:SetSiblingIndex(1)

				arg_131_1.var_.highlightMatValue10017.color.r = 1
				arg_131_1.var_.highlightMatValue10017.color.g = 1
				arg_131_1.var_.highlightMatValue10017.color.b = 1
				arg_131_1.var_.highlightMatValue10017.color = arg_131_1.var_.highlightMatValue10017.color
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				local var_134_9 = arg_131_1.actors_["10017"]:GetComponent("Image")

				if var_134_9 then
					arg_131_1.var_.alphaMatValue10017 = var_134_9
					arg_131_1.var_.alphaOldValue10017 = var_134_9.color.a
				end

				arg_131_1.var_.alphaOldValue10017 = 0
			end

			local var_134_10 = 0.5

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_10 then
				if arg_131_1.var_.alphaMatValue10017 then
					arg_131_1.var_.alphaMatValue10017.color.a = Mathf.Lerp(arg_131_1.var_.alphaOldValue10017, 1, (arg_131_1.time_ - 0) / var_134_10)
					arg_131_1.var_.alphaMatValue10017.color = arg_131_1.var_.alphaMatValue10017.color
				end
			end

			if arg_131_1.time_ >= 0 + var_134_10 and arg_131_1.time_ < 0 + var_134_10 + arg_134_0 and arg_131_1.var_.alphaMatValue10017 then
				arg_131_1.var_.alphaMatValue10017.color.a = 1
				arg_131_1.var_.alphaMatValue10017.color = arg_131_1.var_.alphaMatValue10017.color
			end

			local var_134_11 = 0
			local var_134_12 = 1

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_11 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_13 = arg_131_1:GetWordFromCfg(114202032)
				local var_134_14 = arg_131_1:FormatText(var_134_13.content)

				arg_131_1.text_.text = var_134_14

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_16 = 40 <= 0 and var_134_12 or var_134_12 * (utf8.len(var_134_14) / 40)

				if (40 <= 0 and var_134_12 or var_134_12 * (utf8.len(var_134_14) / 40)) > 0 and var_134_12 < var_134_16 then
					arg_131_1.talkMaxDuration = var_134_16

					if var_134_16 + var_134_11 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_16 + var_134_11
					end
				end

				arg_131_1.text_.text = var_134_14
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202032", "story_v_out_114202.awb") ~= 0 then
					local var_134_17 = manager.audio:GetVoiceLength("story_v_out_114202", "114202032", "story_v_out_114202.awb") / 1000

					if var_134_17 + var_134_11 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_17 + var_134_11
					end

					if var_134_13.prefab_name ~= "" and arg_131_1.actors_[var_134_13.prefab_name] ~= nil then
						local var_134_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_13.prefab_name].transform, "story_v_out_114202", "114202032", "story_v_out_114202.awb")

						arg_131_1:RecordAudio("114202032", var_134_18)
						arg_131_1:RecordAudio("114202032", var_134_18)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_114202", "114202032", "story_v_out_114202.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_114202", "114202032", "story_v_out_114202.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_19 = math.max(var_134_12, arg_131_1.talkMaxDuration)

			if var_134_11 <= arg_131_1.time_ and arg_131_1.time_ < var_134_11 + var_134_19 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_11) / var_134_19

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_11 + var_134_19 and arg_131_1.time_ < var_134_11 + var_134_19 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play114202033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 114202033
		arg_135_1.duration_ = 3.6

		local var_135_0 = {
			ja = 2.2,
			ko = 2.733,
			zh = 1.7,
			en = 3.6
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
				arg_135_0:Play114202034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10015 = arg_135_1.actors_["10015"].transform.localPosition
				arg_135_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10015", 4)

				for iter_138_0 = 0, arg_135_1.actors_["10015"].transform.childCount - 1 do
					local var_138_0 = arg_135_1.actors_["10015"].transform:GetChild(iter_138_0)

					if var_138_0.name == "split_1" or not string.find(var_138_0.name, "split") then
						var_138_0.gameObject:SetActive(true)
					else
						var_138_0.gameObject:SetActive(false)
					end
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_135_1.time_ - 0) / var_138_1)
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_138_2 = arg_135_1.actors_["10017"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) then
				local var_138_3 = var_138_2:GetComponent("Image")

				if var_138_3 then
					arg_135_1.var_.highlightMatValue10017 = var_138_3
				end
			end

			local var_138_4 = 0.034

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 and not isNil(var_138_2) then
				if arg_135_1.var_.highlightMatValue10017 then
					local var_138_5 = Mathf.Lerp(1, 0.5, (arg_135_1.time_ - 0) / var_138_4)

					arg_135_1.var_.highlightMatValue10017.color.r = var_138_5
					arg_135_1.var_.highlightMatValue10017.color.g = var_138_5
					arg_135_1.var_.highlightMatValue10017.color.b = var_138_5
					arg_135_1.var_.highlightMatValue10017.color = arg_135_1.var_.highlightMatValue10017.color
				end
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.highlightMatValue10017 then
				arg_135_1.var_.highlightMatValue10017.color.r = 0.5
				arg_135_1.var_.highlightMatValue10017.color.g = 0.5
				arg_135_1.var_.highlightMatValue10017.color.b = 0.5
				arg_135_1.var_.highlightMatValue10017.color = arg_135_1.var_.highlightMatValue10017.color
			end

			local var_138_6 = arg_135_1.actors_["10015"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.actorSpriteComps10015 == nil then
				arg_135_1.var_.actorSpriteComps10015 = var_138_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_7 = 0.034

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 and not isNil(var_138_6) then
				if arg_135_1.var_.actorSpriteComps10015 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								iter_138_2.color = Color.New(Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_7), Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_7), (Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_7)))
							else
								local var_138_8 = Mathf.Lerp(iter_138_2.color.r, 1, (arg_135_1.time_ - 0) / var_138_7)

								iter_138_2.color = Color.New(var_138_8, var_138_8, var_138_8)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.actorSpriteComps10015 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_138_4 then
						iter_138_4.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				local var_138_9 = arg_135_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_138_9 then
					arg_135_1.var_.alphaOldValue10015 = var_138_9.alpha
					arg_135_1.var_.characterEffect10015 = var_138_9
				end

				arg_135_1.var_.alphaOldValue10015 = 0
			end

			local var_138_10 = 0.5

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_10 then
				if arg_135_1.var_.characterEffect10015 then
					arg_135_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_135_1.var_.alphaOldValue10015, 1, (arg_135_1.time_ - 0) / var_138_10)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_10 and arg_135_1.time_ < 0 + var_138_10 + arg_138_0 and arg_135_1.var_.characterEffect10015 then
				arg_135_1.var_.characterEffect10015.alpha = 1
			end

			local var_138_11 = 0
			local var_138_12 = 0.275

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_13 = arg_135_1:GetWordFromCfg(114202033)
				local var_138_14 = arg_135_1:FormatText(var_138_13.content)

				arg_135_1.text_.text = var_138_14

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_16 = 11 <= 0 and var_138_12 or var_138_12 * (utf8.len(var_138_14) / 11)

				if (11 <= 0 and var_138_12 or var_138_12 * (utf8.len(var_138_14) / 11)) > 0 and var_138_12 < var_138_16 then
					arg_135_1.talkMaxDuration = var_138_16

					if var_138_16 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_11
					end
				end

				arg_135_1.text_.text = var_138_14
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202033", "story_v_out_114202.awb") ~= 0 then
					local var_138_17 = manager.audio:GetVoiceLength("story_v_out_114202", "114202033", "story_v_out_114202.awb") / 1000

					if var_138_17 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_17 + var_138_11
					end

					if var_138_13.prefab_name ~= "" and arg_135_1.actors_[var_138_13.prefab_name] ~= nil then
						local var_138_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_13.prefab_name].transform, "story_v_out_114202", "114202033", "story_v_out_114202.awb")

						arg_135_1:RecordAudio("114202033", var_138_18)
						arg_135_1:RecordAudio("114202033", var_138_18)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_114202", "114202033", "story_v_out_114202.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_114202", "114202033", "story_v_out_114202.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_19 = math.max(var_138_12, arg_135_1.talkMaxDuration)

			if var_138_11 <= arg_135_1.time_ and arg_135_1.time_ < var_138_11 + var_138_19 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_11) / var_138_19

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_11 + var_138_19 and arg_135_1.time_ < var_138_11 + var_138_19 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114202034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 114202034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play114202035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10015"]) and arg_139_1.var_.actorSpriteComps10015 == nil then
				arg_139_1.var_.actorSpriteComps10015 = arg_139_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.034

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10015"]) then
				if arg_139_1.var_.actorSpriteComps10015 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								iter_142_1.color = Color.New(Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_0), Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_0), (Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_0)))
							else
								local var_142_1 = Mathf.Lerp(iter_142_1.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_0)

								iter_142_1.color = Color.New(var_142_1, var_142_1, var_142_1)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10015"]) and arg_139_1.var_.actorSpriteComps10015 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps10015 = nil
			end

			local var_142_2 = 0
			local var_142_3 = 1.3

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_4 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(114202034).content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_6 = 52 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_4) / 52)

				if (52 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_4) / 52)) > 0 and var_142_3 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_7 and arg_139_1.time_ < var_142_2 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play114202035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 114202035
		arg_143_1.duration_ = 2.03

		local var_143_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 2.033,
			en = 1.133
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
				arg_143_0:Play114202036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["10017"]) then
				local var_146_0 = arg_143_1.actors_["10017"]:GetComponent("Image")

				if var_146_0 then
					arg_143_1.var_.highlightMatValue10017 = var_146_0
				end
			end

			local var_146_1 = 0.034

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_1 and not isNil(arg_143_1.actors_["10017"]) then
				if arg_143_1.var_.highlightMatValue10017 then
					local var_146_2 = Mathf.Lerp(0.5, 1, (arg_143_1.time_ - 0) / var_146_1)

					arg_143_1.var_.highlightMatValue10017.color.r = var_146_2
					arg_143_1.var_.highlightMatValue10017.color.g = var_146_2
					arg_143_1.var_.highlightMatValue10017.color.b = var_146_2
					arg_143_1.var_.highlightMatValue10017.color = arg_143_1.var_.highlightMatValue10017.color
				end
			end

			if arg_143_1.time_ >= 0 + var_146_1 and arg_143_1.time_ < 0 + var_146_1 + arg_146_0 and not isNil(arg_143_1.actors_["10017"]) and arg_143_1.var_.highlightMatValue10017 then
				arg_143_1.actors_["10017"].transform:SetSiblingIndex(1)

				arg_143_1.var_.highlightMatValue10017.color.r = 1
				arg_143_1.var_.highlightMatValue10017.color.g = 1
				arg_143_1.var_.highlightMatValue10017.color.b = 1
				arg_143_1.var_.highlightMatValue10017.color = arg_143_1.var_.highlightMatValue10017.color
			end

			local var_146_3 = arg_143_1.actors_["10015"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_3) and arg_143_1.var_.actorSpriteComps10015 == nil then
				arg_143_1.var_.actorSpriteComps10015 = var_146_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_4 = 0.034

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 and not isNil(var_146_3) then
				if arg_143_1.var_.actorSpriteComps10015 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								iter_146_1.color = Color.New(Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor2.r, (arg_143_1.time_ - 0) / var_146_4), Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor2.g, (arg_143_1.time_ - 0) / var_146_4), (Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor2.b, (arg_143_1.time_ - 0) / var_146_4)))
							else
								local var_146_5 = Mathf.Lerp(iter_146_1.color.r, 0.5, (arg_143_1.time_ - 0) / var_146_4)

								iter_146_1.color = Color.New(var_146_5, var_146_5, var_146_5)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 and not isNil(var_146_3) and arg_143_1.var_.actorSpriteComps10015 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_146_3 then
						iter_146_3.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_143_1.var_.actorSpriteComps10015 = nil
			end

			local var_146_6 = 0
			local var_146_7 = 0.075

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_8 = arg_143_1:GetWordFromCfg(114202035)
				local var_146_9 = arg_143_1:FormatText(var_146_8.content)

				arg_143_1.text_.text = var_146_9

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 3 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 3)

				if (3 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 3)) > 0 and var_146_7 < var_146_11 then
					arg_143_1.talkMaxDuration = var_146_11

					if var_146_11 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_9
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202035", "story_v_out_114202.awb") ~= 0 then
					local var_146_12 = manager.audio:GetVoiceLength("story_v_out_114202", "114202035", "story_v_out_114202.awb") / 1000

					if var_146_12 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_6
					end

					if var_146_8.prefab_name ~= "" and arg_143_1.actors_[var_146_8.prefab_name] ~= nil then
						local var_146_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_8.prefab_name].transform, "story_v_out_114202", "114202035", "story_v_out_114202.awb")

						arg_143_1:RecordAudio("114202035", var_146_13)
						arg_143_1:RecordAudio("114202035", var_146_13)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_114202", "114202035", "story_v_out_114202.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_114202", "114202035", "story_v_out_114202.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_14 and arg_143_1.time_ < var_146_6 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play114202036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 114202036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play114202037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["10017"]) then
				local var_150_0 = arg_147_1.actors_["10017"]:GetComponent("Image")

				if var_150_0 then
					arg_147_1.var_.highlightMatValue10017 = var_150_0
				end
			end

			local var_150_1 = 0.034

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 and not isNil(arg_147_1.actors_["10017"]) then
				if arg_147_1.var_.highlightMatValue10017 then
					local var_150_2 = Mathf.Lerp(1, 0.5, (arg_147_1.time_ - 0) / var_150_1)

					arg_147_1.var_.highlightMatValue10017.color.r = var_150_2
					arg_147_1.var_.highlightMatValue10017.color.g = var_150_2
					arg_147_1.var_.highlightMatValue10017.color.b = var_150_2
					arg_147_1.var_.highlightMatValue10017.color = arg_147_1.var_.highlightMatValue10017.color
				end
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 and not isNil(arg_147_1.actors_["10017"]) and arg_147_1.var_.highlightMatValue10017 then
				arg_147_1.var_.highlightMatValue10017.color.r = 0.5
				arg_147_1.var_.highlightMatValue10017.color.g = 0.5
				arg_147_1.var_.highlightMatValue10017.color.b = 0.5
				arg_147_1.var_.highlightMatValue10017.color = arg_147_1.var_.highlightMatValue10017.color
			end

			local var_150_3 = 0
			local var_150_4 = 1.475

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_3 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_5 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(114202036).content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 59 <= 0 and var_150_4 or var_150_4 * (utf8.len(var_150_5) / 59)

				if (59 <= 0 and var_150_4 or var_150_4 * (utf8.len(var_150_5) / 59)) > 0 and var_150_4 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_3 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_3
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_4, arg_147_1.talkMaxDuration)

			if var_150_3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_3 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_3) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_3 + var_150_8 and arg_147_1.time_ < var_150_3 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play114202037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 114202037
		arg_151_1.duration_ = 10.6

		local var_151_0 = {
			ja = 7.5,
			ko = 10.3,
			zh = 8.9,
			en = 10.6
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
				arg_151_0:Play114202038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10017"]) then
				local var_154_0 = arg_151_1.actors_["10017"]:GetComponent("Image")

				if var_154_0 then
					arg_151_1.var_.highlightMatValue10017 = var_154_0
				end
			end

			local var_154_1 = 0.034

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_1 and not isNil(arg_151_1.actors_["10017"]) then
				if arg_151_1.var_.highlightMatValue10017 then
					local var_154_2 = Mathf.Lerp(0.5, 1, (arg_151_1.time_ - 0) / var_154_1)

					arg_151_1.var_.highlightMatValue10017.color.r = var_154_2
					arg_151_1.var_.highlightMatValue10017.color.g = var_154_2
					arg_151_1.var_.highlightMatValue10017.color.b = var_154_2
					arg_151_1.var_.highlightMatValue10017.color = arg_151_1.var_.highlightMatValue10017.color
				end
			end

			if arg_151_1.time_ >= 0 + var_154_1 and arg_151_1.time_ < 0 + var_154_1 + arg_154_0 and not isNil(arg_151_1.actors_["10017"]) and arg_151_1.var_.highlightMatValue10017 then
				arg_151_1.actors_["10017"].transform:SetSiblingIndex(1)

				arg_151_1.var_.highlightMatValue10017.color.r = 1
				arg_151_1.var_.highlightMatValue10017.color.g = 1
				arg_151_1.var_.highlightMatValue10017.color.b = 1
				arg_151_1.var_.highlightMatValue10017.color = arg_151_1.var_.highlightMatValue10017.color
			end

			local var_154_3 = 0
			local var_154_4 = 1

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_3 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_5 = arg_151_1:GetWordFromCfg(114202037)
				local var_154_6 = arg_151_1:FormatText(var_154_5.content)

				arg_151_1.text_.text = var_154_6

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_8 = 40 <= 0 and var_154_4 or var_154_4 * (utf8.len(var_154_6) / 40)

				if (40 <= 0 and var_154_4 or var_154_4 * (utf8.len(var_154_6) / 40)) > 0 and var_154_4 < var_154_8 then
					arg_151_1.talkMaxDuration = var_154_8

					if var_154_8 + var_154_3 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_3
					end
				end

				arg_151_1.text_.text = var_154_6
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202037", "story_v_out_114202.awb") ~= 0 then
					local var_154_9 = manager.audio:GetVoiceLength("story_v_out_114202", "114202037", "story_v_out_114202.awb") / 1000

					if var_154_9 + var_154_3 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_3
					end

					if var_154_5.prefab_name ~= "" and arg_151_1.actors_[var_154_5.prefab_name] ~= nil then
						local var_154_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_5.prefab_name].transform, "story_v_out_114202", "114202037", "story_v_out_114202.awb")

						arg_151_1:RecordAudio("114202037", var_154_10)
						arg_151_1:RecordAudio("114202037", var_154_10)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_114202", "114202037", "story_v_out_114202.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_114202", "114202037", "story_v_out_114202.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_11 = math.max(var_154_4, arg_151_1.talkMaxDuration)

			if var_154_3 <= arg_151_1.time_ and arg_151_1.time_ < var_154_3 + var_154_11 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_3) / var_154_11

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_3 + var_154_11 and arg_151_1.time_ < var_154_3 + var_154_11 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play114202038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 114202038
		arg_155_1.duration_ = 14.03

		local var_155_0 = {
			ja = 10.466,
			ko = 12.3,
			zh = 10.966,
			en = 14.033
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
				arg_155_0:Play114202039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 1.325

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(114202038)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 53 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 53)

				if (53 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 53)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202038", "story_v_out_114202.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_114202", "114202038", "story_v_out_114202.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_114202", "114202038", "story_v_out_114202.awb")

						arg_155_1:RecordAudio("114202038", var_158_6)
						arg_155_1:RecordAudio("114202038", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_114202", "114202038", "story_v_out_114202.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_114202", "114202038", "story_v_out_114202.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play114202039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 114202039
		arg_159_1.duration_ = 12.4

		local var_159_0 = {
			ja = 9,
			ko = 10.233,
			zh = 12.4,
			en = 12.1
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
				arg_159_0:Play114202040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.225

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:GetWordFromCfg(114202039)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 49 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 49)

				if (49 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 49)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202039", "story_v_out_114202.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_114202", "114202039", "story_v_out_114202.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_114202", "114202039", "story_v_out_114202.awb")

						arg_159_1:RecordAudio("114202039", var_162_6)
						arg_159_1:RecordAudio("114202039", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_114202", "114202039", "story_v_out_114202.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_114202", "114202039", "story_v_out_114202.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play114202040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 114202040
		arg_163_1.duration_ = 2.47

		local var_163_0 = {
			ja = 2.466,
			ko = 1.5,
			zh = 0.999999999999,
			en = 1.266
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
				arg_163_0:Play114202041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10017"]) then
				local var_166_0 = arg_163_1.actors_["10017"]:GetComponent("Image")

				if var_166_0 then
					arg_163_1.var_.highlightMatValue10017 = var_166_0
				end
			end

			local var_166_1 = 0.034

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 and not isNil(arg_163_1.actors_["10017"]) then
				if arg_163_1.var_.highlightMatValue10017 then
					local var_166_2 = Mathf.Lerp(1, 0.5, (arg_163_1.time_ - 0) / var_166_1)

					arg_163_1.var_.highlightMatValue10017.color.r = var_166_2
					arg_163_1.var_.highlightMatValue10017.color.g = var_166_2
					arg_163_1.var_.highlightMatValue10017.color.b = var_166_2
					arg_163_1.var_.highlightMatValue10017.color = arg_163_1.var_.highlightMatValue10017.color
				end
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 and not isNil(arg_163_1.actors_["10017"]) and arg_163_1.var_.highlightMatValue10017 then
				arg_163_1.var_.highlightMatValue10017.color.r = 0.5
				arg_163_1.var_.highlightMatValue10017.color.g = 0.5
				arg_163_1.var_.highlightMatValue10017.color.b = 0.5
				arg_163_1.var_.highlightMatValue10017.color = arg_163_1.var_.highlightMatValue10017.color
			end

			local var_166_3 = arg_163_1.actors_["10015"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_3) and arg_163_1.var_.actorSpriteComps10015 == nil then
				arg_163_1.var_.actorSpriteComps10015 = var_166_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_4 = 0.034

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 and not isNil(var_166_3) then
				if arg_163_1.var_.actorSpriteComps10015 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								iter_166_1.color = Color.New(Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_4), Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_4), (Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_4)))
							else
								local var_166_5 = Mathf.Lerp(iter_166_1.color.r, 1, (arg_163_1.time_ - 0) / var_166_4)

								iter_166_1.color = Color.New(var_166_5, var_166_5, var_166_5)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 and not isNil(var_166_3) and arg_163_1.var_.actorSpriteComps10015 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps10015 = nil
			end

			local var_166_6 = 0
			local var_166_7 = 0.05

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_8 = arg_163_1:GetWordFromCfg(114202040)
				local var_166_9 = arg_163_1:FormatText(var_166_8.content)

				arg_163_1.text_.text = var_166_9

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 2 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 2)

				if (2 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 2)) > 0 and var_166_7 < var_166_11 then
					arg_163_1.talkMaxDuration = var_166_11

					if var_166_11 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_9
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202040", "story_v_out_114202.awb") ~= 0 then
					local var_166_12 = manager.audio:GetVoiceLength("story_v_out_114202", "114202040", "story_v_out_114202.awb") / 1000

					if var_166_12 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_6
					end

					if var_166_8.prefab_name ~= "" and arg_163_1.actors_[var_166_8.prefab_name] ~= nil then
						local var_166_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_8.prefab_name].transform, "story_v_out_114202", "114202040", "story_v_out_114202.awb")

						arg_163_1:RecordAudio("114202040", var_166_13)
						arg_163_1:RecordAudio("114202040", var_166_13)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_114202", "114202040", "story_v_out_114202.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_114202", "114202040", "story_v_out_114202.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_14 and arg_163_1.time_ < var_166_6 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play114202041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 114202041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play114202042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10015"]) and arg_167_1.var_.actorSpriteComps10015 == nil then
				arg_167_1.var_.actorSpriteComps10015 = arg_167_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.034

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10015"]) then
				if arg_167_1.var_.actorSpriteComps10015 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								iter_170_1.color = Color.New(Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_0), Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_0), (Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_0)))
							else
								local var_170_1 = Mathf.Lerp(iter_170_1.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_0)

								iter_170_1.color = Color.New(var_170_1, var_170_1, var_170_1)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10015"]) and arg_167_1.var_.actorSpriteComps10015 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps10015 = nil
			end

			local var_170_2 = 0
			local var_170_3 = 1.65

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_4 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(114202041).content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_6 = 66 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_4) / 66)

				if (66 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_4) / 66)) > 0 and var_170_3 < var_170_6 then
					arg_167_1.talkMaxDuration = var_170_6

					if var_170_6 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_6 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_7 and arg_167_1.time_ < var_170_2 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play114202042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 114202042
		arg_171_1.duration_ = 15.3

		local var_171_0 = {
			ja = 8.266,
			ko = 12.366,
			zh = 11.7,
			en = 15.3
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
				arg_171_0:Play114202043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 2 < arg_171_1.time_ and arg_171_1.time_ <= 2 + arg_174_0 then
				arg_171_1.var_.moveOldPos10017 = arg_171_1.actors_["10017"].transform.localPosition
				arg_171_1.actors_["10017"].transform.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10017", 3)
			end

			local var_174_0 = 0.001

			if 2 <= arg_171_1.time_ and arg_171_1.time_ < 2 + var_174_0 then
				arg_171_1.actors_["10017"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10017, Vector3.New(0, -350, -180), (arg_171_1.time_ - 2) / var_174_0)
			end

			if arg_171_1.time_ >= 2 + var_174_0 and arg_171_1.time_ < 2 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["10017"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_174_1 = arg_171_1.actors_["10017"]

			if 2 < arg_171_1.time_ and arg_171_1.time_ <= 2 + arg_174_0 and not isNil(var_174_1) then
				local var_174_2 = var_174_1:GetComponent("Image")

				if var_174_2 then
					arg_171_1.var_.highlightMatValue10017 = var_174_2
				end
			end

			local var_174_3 = 0.034

			if 2 <= arg_171_1.time_ and arg_171_1.time_ < 2 + var_174_3 and not isNil(var_174_1) then
				if arg_171_1.var_.highlightMatValue10017 then
					local var_174_4 = Mathf.Lerp(0.5, 1, (arg_171_1.time_ - 2) / var_174_3)

					arg_171_1.var_.highlightMatValue10017.color.r = var_174_4
					arg_171_1.var_.highlightMatValue10017.color.g = var_174_4
					arg_171_1.var_.highlightMatValue10017.color.b = var_174_4
					arg_171_1.var_.highlightMatValue10017.color = arg_171_1.var_.highlightMatValue10017.color
				end
			end

			if arg_171_1.time_ >= 2 + var_174_3 and arg_171_1.time_ < 2 + var_174_3 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.highlightMatValue10017 then
				var_174_1.transform:SetSiblingIndex(1)

				arg_171_1.var_.highlightMatValue10017.color.r = 1
				arg_171_1.var_.highlightMatValue10017.color.g = 1
				arg_171_1.var_.highlightMatValue10017.color.b = 1
				arg_171_1.var_.highlightMatValue10017.color = arg_171_1.var_.highlightMatValue10017.color
			end

			local var_174_5 = 0

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_6 = 2

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_6 then
				local var_174_7 = Color.New(1, 1, 1)

				var_174_7.a = Mathf.Lerp(1, 0, (arg_171_1.time_ - var_174_5) / var_174_6)
				arg_171_1.mask_.color = var_174_7
			end

			if arg_171_1.time_ >= var_174_5 + var_174_6 and arg_171_1.time_ < var_174_5 + var_174_6 + arg_174_0 then
				local var_174_8 = Color.New(1, 1, 1)

				arg_171_1.mask_.enabled = false
				var_174_8.a = 0
				arg_171_1.mask_.color = var_174_8
			end

			if 2 < arg_171_1.time_ and arg_171_1.time_ <= 2 + arg_174_0 then
				local var_174_9 = arg_171_1.actors_["10017"]:GetComponent("Image")

				if var_174_9 then
					arg_171_1.var_.alphaMatValue10017 = var_174_9
					arg_171_1.var_.alphaOldValue10017 = var_174_9.color.a
				end

				arg_171_1.var_.alphaOldValue10017 = 0
			end

			local var_174_10 = 0.5

			if 2 <= arg_171_1.time_ and arg_171_1.time_ < 2 + var_174_10 then
				if arg_171_1.var_.alphaMatValue10017 then
					arg_171_1.var_.alphaMatValue10017.color.a = Mathf.Lerp(arg_171_1.var_.alphaOldValue10017, 1, (arg_171_1.time_ - 2) / var_174_10)
					arg_171_1.var_.alphaMatValue10017.color = arg_171_1.var_.alphaMatValue10017.color
				end
			end

			if arg_171_1.time_ >= 2 + var_174_10 and arg_171_1.time_ < 2 + var_174_10 + arg_174_0 and arg_171_1.var_.alphaMatValue10017 then
				arg_171_1.var_.alphaMatValue10017.color.a = 1
				arg_171_1.var_.alphaMatValue10017.color = arg_171_1.var_.alphaMatValue10017.color
			end

			local var_174_11 = arg_171_1.actors_["10017"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10017 = var_174_11.localPosition
				var_174_11.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10017", 7)
			end

			local var_174_12 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_12 then
				var_174_11.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10017, Vector3.New(0, -2000, 300), (arg_171_1.time_ - 0) / var_174_12)
			end

			if arg_171_1.time_ >= 0 + var_174_12 and arg_171_1.time_ < 0 + var_174_12 + arg_174_0 then
				var_174_11.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_174_13 = arg_171_1.actors_["10015"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10015 = var_174_13.localPosition
				var_174_13.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10015", 7)

				for iter_174_0 = 0, var_174_13.childCount - 1 do
					local var_174_14 = var_174_13:GetChild(iter_174_0)

					if var_174_14.name == "split_1" or not string.find(var_174_14.name, "split") then
						var_174_14.gameObject:SetActive(true)
					else
						var_174_14.gameObject:SetActive(false)
					end
				end
			end

			local var_174_15 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_15 then
				var_174_13.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10015, Vector3.New(0, -2000, 300), (arg_171_1.time_ - 0) / var_174_15)
			end

			if arg_171_1.time_ >= 0 + var_174_15 and arg_171_1.time_ < 0 + var_174_15 + arg_174_0 then
				var_174_13.localPosition = Vector3.New(0, -2000, 300)
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				local var_174_16 = arg_171_1.bgs_.F04

				arg_171_1.bgs_.F04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_174_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_17 = var_174_16:GetComponent("SpriteRenderer")

				if var_174_17 and var_174_17.sprite then
					local var_174_18 = 2 * (var_174_16.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_174_16.transform.localScale = Vector3.New(var_174_18 / var_174_17.sprite.bounds.size.y < var_174_18 * manager.ui.mainCameraCom_.aspect / var_174_17.sprite.bounds.size.x and var_174_18 * manager.ui.mainCameraCom_.aspect / var_174_17.sprite.bounds.size.x or var_174_18 / var_174_17.sprite.bounds.size.y, var_174_18 / var_174_17.sprite.bounds.size.y < var_174_18 * manager.ui.mainCameraCom_.aspect / var_174_17.sprite.bounds.size.x and var_174_18 * manager.ui.mainCameraCom_.aspect / var_174_17.sprite.bounds.size.x or var_174_18 / var_174_17.sprite.bounds.size.y, 0)
				end

				for iter_174_1, iter_174_2 in pairs(arg_171_1.bgs_) do
					if iter_174_1 ~= "F04" then
						iter_174_2.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_19 = 2
			local var_174_20 = 1.125

			if 2 < arg_171_1.time_ and arg_171_1.time_ <= var_174_19 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_21 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_21:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_22 = arg_171_1:GetWordFromCfg(114202042)
				local var_174_23 = arg_171_1:FormatText(var_174_22.content)

				arg_171_1.text_.text = var_174_23

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_25 = 45 <= 0 and var_174_20 or var_174_20 * (utf8.len(var_174_23) / 45)

				if (45 <= 0 and var_174_20 or var_174_20 * (utf8.len(var_174_23) / 45)) > 0 and var_174_20 < var_174_25 then
					arg_171_1.talkMaxDuration = var_174_25
					var_174_19 = var_174_19 + 0.3

					if var_174_25 + var_174_19 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_25 + var_174_19
					end
				end

				arg_171_1.text_.text = var_174_23
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202042", "story_v_out_114202.awb") ~= 0 then
					local var_174_26 = manager.audio:GetVoiceLength("story_v_out_114202", "114202042", "story_v_out_114202.awb") / 1000

					if var_174_26 + var_174_19 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_26 + var_174_19
					end

					if var_174_22.prefab_name ~= "" and arg_171_1.actors_[var_174_22.prefab_name] ~= nil then
						local var_174_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_22.prefab_name].transform, "story_v_out_114202", "114202042", "story_v_out_114202.awb")

						arg_171_1:RecordAudio("114202042", var_174_27)
						arg_171_1:RecordAudio("114202042", var_174_27)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_114202", "114202042", "story_v_out_114202.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_114202", "114202042", "story_v_out_114202.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_28 = var_174_19 + 0.3
			local var_174_29 = math.max(var_174_20, arg_171_1.talkMaxDuration)

			if var_174_19 + 0.3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_28 + var_174_29 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_28) / var_174_29

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_28 + var_174_29 and arg_171_1.time_ < var_174_28 + var_174_29 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play114202043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 114202043
		arg_177_1.duration_ = 6.9

		local var_177_0 = {
			ja = 5.9,
			ko = 6.9,
			zh = 4.9,
			en = 5.466
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
				arg_177_0:Play114202044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10017"]) then
				local var_180_0 = arg_177_1.actors_["10017"]:GetComponent("Image")

				if var_180_0 then
					arg_177_1.var_.highlightMatValue10017 = var_180_0
				end
			end

			local var_180_1 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 and not isNil(arg_177_1.actors_["10017"]) then
				if arg_177_1.var_.highlightMatValue10017 then
					local var_180_2 = Mathf.Lerp(1, 0.5, (arg_177_1.time_ - 0) / var_180_1)

					arg_177_1.var_.highlightMatValue10017.color.r = var_180_2
					arg_177_1.var_.highlightMatValue10017.color.g = var_180_2
					arg_177_1.var_.highlightMatValue10017.color.b = var_180_2
					arg_177_1.var_.highlightMatValue10017.color = arg_177_1.var_.highlightMatValue10017.color
				end
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 and not isNil(arg_177_1.actors_["10017"]) and arg_177_1.var_.highlightMatValue10017 then
				arg_177_1.var_.highlightMatValue10017.color.r = 0.5
				arg_177_1.var_.highlightMatValue10017.color.g = 0.5
				arg_177_1.var_.highlightMatValue10017.color.b = 0.5
				arg_177_1.var_.highlightMatValue10017.color = arg_177_1.var_.highlightMatValue10017.color
			end

			local var_180_3 = 0
			local var_180_4 = 0.55

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_3 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[209].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_5 = arg_177_1:GetWordFromCfg(114202043)
				local var_180_6 = arg_177_1:FormatText(var_180_5.content)

				arg_177_1.text_.text = var_180_6

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_8 = 22 <= 0 and var_180_4 or var_180_4 * (utf8.len(var_180_6) / 22)

				if (22 <= 0 and var_180_4 or var_180_4 * (utf8.len(var_180_6) / 22)) > 0 and var_180_4 < var_180_8 then
					arg_177_1.talkMaxDuration = var_180_8

					if var_180_8 + var_180_3 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_3
					end
				end

				arg_177_1.text_.text = var_180_6
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202043", "story_v_out_114202.awb") ~= 0 then
					local var_180_9 = manager.audio:GetVoiceLength("story_v_out_114202", "114202043", "story_v_out_114202.awb") / 1000

					if var_180_9 + var_180_3 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_3
					end

					if var_180_5.prefab_name ~= "" and arg_177_1.actors_[var_180_5.prefab_name] ~= nil then
						local var_180_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_5.prefab_name].transform, "story_v_out_114202", "114202043", "story_v_out_114202.awb")

						arg_177_1:RecordAudio("114202043", var_180_10)
						arg_177_1:RecordAudio("114202043", var_180_10)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_114202", "114202043", "story_v_out_114202.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_114202", "114202043", "story_v_out_114202.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_11 = math.max(var_180_4, arg_177_1.talkMaxDuration)

			if var_180_3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_3 + var_180_11 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_3) / var_180_11

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_3 + var_180_11 and arg_177_1.time_ < var_180_3 + var_180_11 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play114202044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 114202044
		arg_181_1.duration_ = 5.43

		local var_181_0 = {
			ja = 5.433,
			ko = 4.9,
			zh = 4.466,
			en = 4.566
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
				arg_181_0:Play114202045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["10017"]) then
				local var_184_0 = arg_181_1.actors_["10017"]:GetComponent("Image")

				if var_184_0 then
					arg_181_1.var_.highlightMatValue10017 = var_184_0
				end
			end

			local var_184_1 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_1 and not isNil(arg_181_1.actors_["10017"]) then
				if arg_181_1.var_.highlightMatValue10017 then
					local var_184_2 = Mathf.Lerp(0.5, 1, (arg_181_1.time_ - 0) / var_184_1)

					arg_181_1.var_.highlightMatValue10017.color.r = var_184_2
					arg_181_1.var_.highlightMatValue10017.color.g = var_184_2
					arg_181_1.var_.highlightMatValue10017.color.b = var_184_2
					arg_181_1.var_.highlightMatValue10017.color = arg_181_1.var_.highlightMatValue10017.color
				end
			end

			if arg_181_1.time_ >= 0 + var_184_1 and arg_181_1.time_ < 0 + var_184_1 + arg_184_0 and not isNil(arg_181_1.actors_["10017"]) and arg_181_1.var_.highlightMatValue10017 then
				arg_181_1.actors_["10017"].transform:SetSiblingIndex(1)

				arg_181_1.var_.highlightMatValue10017.color.r = 1
				arg_181_1.var_.highlightMatValue10017.color.g = 1
				arg_181_1.var_.highlightMatValue10017.color.b = 1
				arg_181_1.var_.highlightMatValue10017.color = arg_181_1.var_.highlightMatValue10017.color
			end

			local var_184_3 = 0
			local var_184_4 = 0.425

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_3 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_5 = arg_181_1:GetWordFromCfg(114202044)
				local var_184_6 = arg_181_1:FormatText(var_184_5.content)

				arg_181_1.text_.text = var_184_6

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_8 = 17 <= 0 and var_184_4 or var_184_4 * (utf8.len(var_184_6) / 17)

				if (17 <= 0 and var_184_4 or var_184_4 * (utf8.len(var_184_6) / 17)) > 0 and var_184_4 < var_184_8 then
					arg_181_1.talkMaxDuration = var_184_8

					if var_184_8 + var_184_3 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_3
					end
				end

				arg_181_1.text_.text = var_184_6
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202044", "story_v_out_114202.awb") ~= 0 then
					local var_184_9 = manager.audio:GetVoiceLength("story_v_out_114202", "114202044", "story_v_out_114202.awb") / 1000

					if var_184_9 + var_184_3 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_3
					end

					if var_184_5.prefab_name ~= "" and arg_181_1.actors_[var_184_5.prefab_name] ~= nil then
						local var_184_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_5.prefab_name].transform, "story_v_out_114202", "114202044", "story_v_out_114202.awb")

						arg_181_1:RecordAudio("114202044", var_184_10)
						arg_181_1:RecordAudio("114202044", var_184_10)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_114202", "114202044", "story_v_out_114202.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_114202", "114202044", "story_v_out_114202.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_11 = math.max(var_184_4, arg_181_1.talkMaxDuration)

			if var_184_3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_3 + var_184_11 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_3) / var_184_11

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_3 + var_184_11 and arg_181_1.time_ < var_184_3 + var_184_11 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play114202045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 114202045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play114202046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				local var_188_0 = arg_185_1.actors_["10017"]:GetComponent("Image")

				if var_188_0 then
					arg_185_1.var_.alphaMatValue10017 = var_188_0
					arg_185_1.var_.alphaOldValue10017 = var_188_0.color.a
				end

				arg_185_1.var_.alphaOldValue10017 = 0
			end

			local var_188_1 = 0.5

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				if arg_185_1.var_.alphaMatValue10017 then
					arg_185_1.var_.alphaMatValue10017.color.a = Mathf.Lerp(arg_185_1.var_.alphaOldValue10017, 1, (arg_185_1.time_ - 0) / var_188_1)
					arg_185_1.var_.alphaMatValue10017.color = arg_185_1.var_.alphaMatValue10017.color
				end
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 and arg_185_1.var_.alphaMatValue10017 then
				arg_185_1.var_.alphaMatValue10017.color.a = 1
				arg_185_1.var_.alphaMatValue10017.color = arg_185_1.var_.alphaMatValue10017.color
			end

			local var_188_2 = 0
			local var_188_3 = 0.725

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_4 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(114202045).content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_6 = 29 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_4) / 29)

				if (29 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_4) / 29)) > 0 and var_188_3 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_3, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_2) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_7 and arg_185_1.time_ < var_188_2 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play114202046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 114202046
		arg_189_1.duration_ = 17.2

		local var_189_0 = {
			ja = 4.133,
			ko = 11.333,
			zh = 11.166,
			en = 17.2
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
				arg_189_0:Play114202047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10017 = arg_189_1.actors_["10017"].transform.localPosition
				arg_189_1.actors_["10017"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10017", 2)
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["10017"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10017, Vector3.New(-390, -350, -180), (arg_189_1.time_ - 0) / var_192_0)
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["10017"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_192_1 = arg_189_1.actors_["10017"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) then
				local var_192_2 = var_192_1:GetComponent("Image")

				if var_192_2 then
					arg_189_1.var_.highlightMatValue10017 = var_192_2
				end
			end

			local var_192_3 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_1) then
				if arg_189_1.var_.highlightMatValue10017 then
					local var_192_4 = Mathf.Lerp(0.5, 1, (arg_189_1.time_ - 0) / var_192_3)

					arg_189_1.var_.highlightMatValue10017.color.r = var_192_4
					arg_189_1.var_.highlightMatValue10017.color.g = var_192_4
					arg_189_1.var_.highlightMatValue10017.color.b = var_192_4
					arg_189_1.var_.highlightMatValue10017.color = arg_189_1.var_.highlightMatValue10017.color
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.highlightMatValue10017 then
				var_192_1.transform:SetSiblingIndex(1)

				arg_189_1.var_.highlightMatValue10017.color.r = 1
				arg_189_1.var_.highlightMatValue10017.color.g = 1
				arg_189_1.var_.highlightMatValue10017.color.b = 1
				arg_189_1.var_.highlightMatValue10017.color = arg_189_1.var_.highlightMatValue10017.color
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				local var_192_5 = arg_189_1.actors_["10017"]:GetComponent("Image")

				if var_192_5 then
					arg_189_1.var_.alphaMatValue10017 = var_192_5
					arg_189_1.var_.alphaOldValue10017 = var_192_5.color.a
				end

				arg_189_1.var_.alphaOldValue10017 = 0
			end

			local var_192_6 = 0.5

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 then
				if arg_189_1.var_.alphaMatValue10017 then
					arg_189_1.var_.alphaMatValue10017.color.a = Mathf.Lerp(arg_189_1.var_.alphaOldValue10017, 1, (arg_189_1.time_ - 0) / var_192_6)
					arg_189_1.var_.alphaMatValue10017.color = arg_189_1.var_.alphaMatValue10017.color
				end
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 and arg_189_1.var_.alphaMatValue10017 then
				arg_189_1.var_.alphaMatValue10017.color.a = 1
				arg_189_1.var_.alphaMatValue10017.color = arg_189_1.var_.alphaMatValue10017.color
			end

			local var_192_7 = 0
			local var_192_8 = 1.1

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_7 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_9 = arg_189_1:GetWordFromCfg(114202046)
				local var_192_10 = arg_189_1:FormatText(var_192_9.content)

				arg_189_1.text_.text = var_192_10

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_12 = 44 <= 0 and var_192_8 or var_192_8 * (utf8.len(var_192_10) / 44)

				if (44 <= 0 and var_192_8 or var_192_8 * (utf8.len(var_192_10) / 44)) > 0 and var_192_8 < var_192_12 then
					arg_189_1.talkMaxDuration = var_192_12

					if var_192_12 + var_192_7 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_7
					end
				end

				arg_189_1.text_.text = var_192_10
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202046", "story_v_out_114202.awb") ~= 0 then
					local var_192_13 = manager.audio:GetVoiceLength("story_v_out_114202", "114202046", "story_v_out_114202.awb") / 1000

					if var_192_13 + var_192_7 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_7
					end

					if var_192_9.prefab_name ~= "" and arg_189_1.actors_[var_192_9.prefab_name] ~= nil then
						local var_192_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_9.prefab_name].transform, "story_v_out_114202", "114202046", "story_v_out_114202.awb")

						arg_189_1:RecordAudio("114202046", var_192_14)
						arg_189_1:RecordAudio("114202046", var_192_14)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_114202", "114202046", "story_v_out_114202.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_114202", "114202046", "story_v_out_114202.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_15 = math.max(var_192_8, arg_189_1.talkMaxDuration)

			if var_192_7 <= arg_189_1.time_ and arg_189_1.time_ < var_192_7 + var_192_15 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_7) / var_192_15

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_7 + var_192_15 and arg_189_1.time_ < var_192_7 + var_192_15 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play114202047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 114202047
		arg_193_1.duration_ = 4.1

		local var_193_0 = {
			ja = 2.733,
			ko = 3.733,
			zh = 4.1,
			en = 3.266
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
				arg_193_0:Play114202048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10015 = arg_193_1.actors_["10015"].transform.localPosition
				arg_193_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10015", 4)

				for iter_196_0 = 0, arg_193_1.actors_["10015"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["10015"].transform:GetChild(iter_196_0)

					if var_196_0.name == "split_1" or not string.find(var_196_0.name, "split") then
						var_196_0.gameObject:SetActive(true)
					else
						var_196_0.gameObject:SetActive(false)
					end
				end
			end

			local var_196_1 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 then
				arg_193_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_193_1.time_ - 0) / var_196_1)
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 then
				arg_193_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_196_2 = arg_193_1.actors_["10017"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) then
				local var_196_3 = var_196_2:GetComponent("Image")

				if var_196_3 then
					arg_193_1.var_.highlightMatValue10017 = var_196_3
				end
			end

			local var_196_4 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 and not isNil(var_196_2) then
				if arg_193_1.var_.highlightMatValue10017 then
					local var_196_5 = Mathf.Lerp(1, 0.5, (arg_193_1.time_ - 0) / var_196_4)

					arg_193_1.var_.highlightMatValue10017.color.r = var_196_5
					arg_193_1.var_.highlightMatValue10017.color.g = var_196_5
					arg_193_1.var_.highlightMatValue10017.color.b = var_196_5
					arg_193_1.var_.highlightMatValue10017.color = arg_193_1.var_.highlightMatValue10017.color
				end
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.highlightMatValue10017 then
				arg_193_1.var_.highlightMatValue10017.color.r = 0.5
				arg_193_1.var_.highlightMatValue10017.color.g = 0.5
				arg_193_1.var_.highlightMatValue10017.color.b = 0.5
				arg_193_1.var_.highlightMatValue10017.color = arg_193_1.var_.highlightMatValue10017.color
			end

			local var_196_6 = arg_193_1.actors_["10015"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.actorSpriteComps10015 == nil then
				arg_193_1.var_.actorSpriteComps10015 = var_196_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_7 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 and not isNil(var_196_6) then
				if arg_193_1.var_.actorSpriteComps10015 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								iter_196_2.color = Color.New(Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_7), Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_7), (Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_7)))
							else
								local var_196_8 = Mathf.Lerp(iter_196_2.color.r, 1, (arg_193_1.time_ - 0) / var_196_7)

								iter_196_2.color = Color.New(var_196_8, var_196_8, var_196_8)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.actorSpriteComps10015 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_196_4 then
						iter_196_4.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				local var_196_9 = arg_193_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_196_9 then
					arg_193_1.var_.alphaOldValue10015 = var_196_9.alpha
					arg_193_1.var_.characterEffect10015 = var_196_9
				end

				arg_193_1.var_.alphaOldValue10015 = 0
			end

			local var_196_10 = 0.5

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_10 then
				if arg_193_1.var_.characterEffect10015 then
					arg_193_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_193_1.var_.alphaOldValue10015, 1, (arg_193_1.time_ - 0) / var_196_10)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_10 and arg_193_1.time_ < 0 + var_196_10 + arg_196_0 and arg_193_1.var_.characterEffect10015 then
				arg_193_1.var_.characterEffect10015.alpha = 1
			end

			local var_196_11 = 0
			local var_196_12 = 0.375

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_11 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_13 = arg_193_1:GetWordFromCfg(114202047)
				local var_196_14 = arg_193_1:FormatText(var_196_13.content)

				arg_193_1.text_.text = var_196_14

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_16 = 15 <= 0 and var_196_12 or var_196_12 * (utf8.len(var_196_14) / 15)

				if (15 <= 0 and var_196_12 or var_196_12 * (utf8.len(var_196_14) / 15)) > 0 and var_196_12 < var_196_16 then
					arg_193_1.talkMaxDuration = var_196_16

					if var_196_16 + var_196_11 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_16 + var_196_11
					end
				end

				arg_193_1.text_.text = var_196_14
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202047", "story_v_out_114202.awb") ~= 0 then
					local var_196_17 = manager.audio:GetVoiceLength("story_v_out_114202", "114202047", "story_v_out_114202.awb") / 1000

					if var_196_17 + var_196_11 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_17 + var_196_11
					end

					if var_196_13.prefab_name ~= "" and arg_193_1.actors_[var_196_13.prefab_name] ~= nil then
						local var_196_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_13.prefab_name].transform, "story_v_out_114202", "114202047", "story_v_out_114202.awb")

						arg_193_1:RecordAudio("114202047", var_196_18)
						arg_193_1:RecordAudio("114202047", var_196_18)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_114202", "114202047", "story_v_out_114202.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_114202", "114202047", "story_v_out_114202.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_19 = math.max(var_196_12, arg_193_1.talkMaxDuration)

			if var_196_11 <= arg_193_1.time_ and arg_193_1.time_ < var_196_11 + var_196_19 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_11) / var_196_19

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_11 + var_196_19 and arg_193_1.time_ < var_196_11 + var_196_19 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play114202048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 114202048
		arg_197_1.duration_ = 7.57

		local var_197_0 = {
			ja = 4.933,
			ko = 5.9,
			zh = 5.733,
			en = 7.566
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
				arg_197_0:Play114202049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["10017"]) then
				local var_200_0 = arg_197_1.actors_["10017"]:GetComponent("Image")

				if var_200_0 then
					arg_197_1.var_.highlightMatValue10017 = var_200_0
				end
			end

			local var_200_1 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 and not isNil(arg_197_1.actors_["10017"]) then
				if arg_197_1.var_.highlightMatValue10017 then
					local var_200_2 = Mathf.Lerp(0.5, 1, (arg_197_1.time_ - 0) / var_200_1)

					arg_197_1.var_.highlightMatValue10017.color.r = var_200_2
					arg_197_1.var_.highlightMatValue10017.color.g = var_200_2
					arg_197_1.var_.highlightMatValue10017.color.b = var_200_2
					arg_197_1.var_.highlightMatValue10017.color = arg_197_1.var_.highlightMatValue10017.color
				end
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 and not isNil(arg_197_1.actors_["10017"]) and arg_197_1.var_.highlightMatValue10017 then
				arg_197_1.actors_["10017"].transform:SetSiblingIndex(1)

				arg_197_1.var_.highlightMatValue10017.color.r = 1
				arg_197_1.var_.highlightMatValue10017.color.g = 1
				arg_197_1.var_.highlightMatValue10017.color.b = 1
				arg_197_1.var_.highlightMatValue10017.color = arg_197_1.var_.highlightMatValue10017.color
			end

			local var_200_3 = arg_197_1.actors_["10015"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_3) and arg_197_1.var_.actorSpriteComps10015 == nil then
				arg_197_1.var_.actorSpriteComps10015 = var_200_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_4 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 and not isNil(var_200_3) then
				if arg_197_1.var_.actorSpriteComps10015 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								iter_200_1.color = Color.New(Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_4), Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_4), (Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_4)))
							else
								local var_200_5 = Mathf.Lerp(iter_200_1.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_4)

								iter_200_1.color = Color.New(var_200_5, var_200_5, var_200_5)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 and not isNil(var_200_3) and arg_197_1.var_.actorSpriteComps10015 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_200_3 then
						iter_200_3.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps10015 = nil
			end

			local var_200_6 = 0
			local var_200_7 = 0.6

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_8 = arg_197_1:GetWordFromCfg(114202048)
				local var_200_9 = arg_197_1:FormatText(var_200_8.content)

				arg_197_1.text_.text = var_200_9

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 24 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 24)

				if (24 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 24)) > 0 and var_200_7 < var_200_11 then
					arg_197_1.talkMaxDuration = var_200_11

					if var_200_11 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_9
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202048", "story_v_out_114202.awb") ~= 0 then
					local var_200_12 = manager.audio:GetVoiceLength("story_v_out_114202", "114202048", "story_v_out_114202.awb") / 1000

					if var_200_12 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_12 + var_200_6
					end

					if var_200_8.prefab_name ~= "" and arg_197_1.actors_[var_200_8.prefab_name] ~= nil then
						local var_200_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_8.prefab_name].transform, "story_v_out_114202", "114202048", "story_v_out_114202.awb")

						arg_197_1:RecordAudio("114202048", var_200_13)
						arg_197_1:RecordAudio("114202048", var_200_13)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_114202", "114202048", "story_v_out_114202.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_114202", "114202048", "story_v_out_114202.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_14 and arg_197_1.time_ < var_200_6 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play114202049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 114202049
		arg_201_1.duration_ = 15.6

		local var_201_0 = {
			ja = 15.6,
			ko = 9.533,
			zh = 8.866,
			en = 8.7
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
				arg_201_0:Play114202050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.95

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[255].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(114202049)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 38 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 38)

				if (38 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 38)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202049", "story_v_out_114202.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_114202", "114202049", "story_v_out_114202.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_114202", "114202049", "story_v_out_114202.awb")

						arg_201_1:RecordAudio("114202049", var_204_6)
						arg_201_1:RecordAudio("114202049", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_114202", "114202049", "story_v_out_114202.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_114202", "114202049", "story_v_out_114202.awb")
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
	Play114202050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 114202050
		arg_205_1.duration_ = 2.33

		local var_205_0 = {
			ja = 2.333,
			ko = 2.266,
			zh = 1.4,
			en = 1.5
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
			arg_205_1.auto_ = false
		end

		function arg_205_1.playNext_(arg_207_0)
			arg_205_1.onStoryFinished_()
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10015 = arg_205_1.actors_["10015"].transform.localPosition
				arg_205_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10015", 7)

				for iter_208_0 = 0, arg_205_1.actors_["10015"].transform.childCount - 1 do
					local var_208_0 = arg_205_1.actors_["10015"].transform:GetChild(iter_208_0)

					if var_208_0.name == "split_1" or not string.find(var_208_0.name, "split") then
						var_208_0.gameObject:SetActive(true)
					else
						var_208_0.gameObject:SetActive(false)
					end
				end
			end

			local var_208_1 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 then
				arg_205_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10015, Vector3.New(0, -2000, 300), (arg_205_1.time_ - 0) / var_208_1)
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 then
				arg_205_1.actors_["10015"].transform.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_208_2 = arg_205_1.actors_["10017"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) then
				local var_208_3 = var_208_2:GetComponent("Image")

				if var_208_3 then
					arg_205_1.var_.highlightMatValue10017 = var_208_3
				end
			end

			local var_208_4 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 and not isNil(var_208_2) then
				if arg_205_1.var_.highlightMatValue10017 then
					local var_208_5 = Mathf.Lerp(1, 0.5, (arg_205_1.time_ - 0) / var_208_4)

					arg_205_1.var_.highlightMatValue10017.color.r = var_208_5
					arg_205_1.var_.highlightMatValue10017.color.g = var_208_5
					arg_205_1.var_.highlightMatValue10017.color.b = var_208_5
					arg_205_1.var_.highlightMatValue10017.color = arg_205_1.var_.highlightMatValue10017.color
				end
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.highlightMatValue10017 then
				arg_205_1.var_.highlightMatValue10017.color.r = 0.5
				arg_205_1.var_.highlightMatValue10017.color.g = 0.5
				arg_205_1.var_.highlightMatValue10017.color.b = 0.5
				arg_205_1.var_.highlightMatValue10017.color = arg_205_1.var_.highlightMatValue10017.color
			end

			local var_208_6 = arg_205_1.actors_["10015"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_6) and arg_205_1.var_.actorSpriteComps10015 == nil then
				arg_205_1.var_.actorSpriteComps10015 = var_208_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_7 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 and not isNil(var_208_6) then
				if arg_205_1.var_.actorSpriteComps10015 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								iter_208_2.color = Color.New(Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, (arg_205_1.time_ - 0) / var_208_7), Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, (arg_205_1.time_ - 0) / var_208_7), (Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, (arg_205_1.time_ - 0) / var_208_7)))
							else
								local var_208_8 = Mathf.Lerp(iter_208_2.color.r, 1, (arg_205_1.time_ - 0) / var_208_7)

								iter_208_2.color = Color.New(var_208_8, var_208_8, var_208_8)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 and not isNil(var_208_6) and arg_205_1.var_.actorSpriteComps10015 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_208_4 then
						iter_208_4.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps10015 = nil
			end

			local var_208_9 = arg_205_1.actors_["10015"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10015 = var_208_9.localPosition
				var_208_9.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10015", 4)

				for iter_208_5 = 0, var_208_9.childCount - 1 do
					local var_208_10 = var_208_9:GetChild(iter_208_5)

					if var_208_10.name == "split_5" or not string.find(var_208_10.name, "split") then
						var_208_10.gameObject:SetActive(true)
					else
						var_208_10.gameObject:SetActive(false)
					end
				end
			end

			local var_208_11 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_11 then
				var_208_9.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_205_1.time_ - 0) / var_208_11)
			end

			if arg_205_1.time_ >= 0 + var_208_11 and arg_205_1.time_ < 0 + var_208_11 + arg_208_0 then
				var_208_9.localPosition = Vector3.New(390, -350, -180)
			end

			local var_208_12 = 0
			local var_208_13 = 0.125

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_12 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_14 = arg_205_1:GetWordFromCfg(114202050)
				local var_208_15 = arg_205_1:FormatText(var_208_14.content)

				arg_205_1.text_.text = var_208_15

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_17 = 5 <= 0 and var_208_13 or var_208_13 * (utf8.len(var_208_15) / 5)

				if (5 <= 0 and var_208_13 or var_208_13 * (utf8.len(var_208_15) / 5)) > 0 and var_208_13 < var_208_17 then
					arg_205_1.talkMaxDuration = var_208_17

					if var_208_17 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_17 + var_208_12
					end
				end

				arg_205_1.text_.text = var_208_15
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114202", "114202050", "story_v_out_114202.awb") ~= 0 then
					local var_208_18 = manager.audio:GetVoiceLength("story_v_out_114202", "114202050", "story_v_out_114202.awb") / 1000

					if var_208_18 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_18 + var_208_12
					end

					if var_208_14.prefab_name ~= "" and arg_205_1.actors_[var_208_14.prefab_name] ~= nil then
						local var_208_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_14.prefab_name].transform, "story_v_out_114202", "114202050", "story_v_out_114202.awb")

						arg_205_1:RecordAudio("114202050", var_208_19)
						arg_205_1:RecordAudio("114202050", var_208_19)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_114202", "114202050", "story_v_out_114202.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_114202", "114202050", "story_v_out_114202.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_20 = math.max(var_208_13, arg_205_1.talkMaxDuration)

			if var_208_12 <= arg_205_1.time_ and arg_205_1.time_ < var_208_12 + var_208_20 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_12) / var_208_20

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_12 + var_208_20 and arg_205_1.time_ < var_208_12 + var_208_20 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F04",
		"TextureConfig/Background/ST21"
	},
	voices = {
		"story_v_out_114202.awb"
	}
}
