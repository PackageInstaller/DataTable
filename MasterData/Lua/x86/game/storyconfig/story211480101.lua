return {
	Play114801001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114801001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114801002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST02 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_4_0.name = "ST02"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST02 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST02

				arg_1_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST02" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.ST02:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueST02 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueST02 = var_4_4
				end

				arg_1_1.var_.alphaOldValueST02 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueST02 then
					arg_1_1.var_.alphaMatValueST02.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueST02, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueST02.color = arg_1_1.var_.alphaMatValueST02.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueST02 then
				arg_1_1.var_.alphaMatValueST02.color.a = 1
				arg_1_1.var_.alphaMatValueST02.color = arg_1_1.var_.alphaMatValueST02.color
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_11 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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

			local var_4_12 = 2
			local var_4_13 = 0.875

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
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

				local var_4_15 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(114801001).content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 35 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 35)

				if (35 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 35)) > 0 and var_4_13 < var_4_17 then
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
	Play114801002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114801002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play114801003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.8

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(114801002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 32 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 32)

				if (32 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 32)) > 0 and var_12_0 < var_12_3 then
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
	Play114801003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114801003
		arg_13_1.duration_ = 5.23

		local var_13_0 = {
			ja = 3.933,
			ko = 2.6,
			zh = 2.3,
			en = 5.233
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
				arg_13_0:Play114801004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.075

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(114801003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 3 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 3)

				if (3 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 3)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801003", "story_v_side_old_114801.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801003", "story_v_side_old_114801.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_side_old_114801", "114801003", "story_v_side_old_114801.awb")

						arg_13_1:RecordAudio("114801003", var_16_6)
						arg_13_1:RecordAudio("114801003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801003", "story_v_side_old_114801.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801003", "story_v_side_old_114801.awb")
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
	Play114801004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114801004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play114801005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.75

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(114801004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 30 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 30)

				if (30 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 30)) > 0 and var_20_0 < var_20_3 then
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
	Play114801005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114801005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play114801006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.125

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(114801005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 5 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 5)

				if (5 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 5)) > 0 and var_24_0 < var_24_3 then
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
	Play114801006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114801006
		arg_25_1.duration_ = 7.67

		local var_25_0 = {
			ja = 7.3,
			ko = 7.2,
			zh = 7.666,
			en = 6.133
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
				arg_25_0:Play114801007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "1148ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1148ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["1148ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["1148ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["1148ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.characterEffect1148ui_story == nil then
				arg_25_1.var_.characterEffect1148ui_story = var_28_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_4 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 and not isNil(var_28_3) then
				if arg_25_1.var_.characterEffect1148ui_story and not isNil(var_28_3) then
					arg_25_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.characterEffect1148ui_story then
				arg_25_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_28_6 = arg_25_1.actors_["1148ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1148ui_story = var_28_6.localPosition

				arg_25_1:ShowWeapon(arg_25_1.var_["1148ui_story" .. "Animator"].transform, false)
			end

			local var_28_7 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				var_28_6.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_25_1.time_ - 0) / var_28_7)
				var_28_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_6.position).x, (manager.ui.mainCamera.transform.position - var_28_6.position).y, (manager.ui.mainCamera.transform.position - var_28_6.position).z)
				var_28_6.localEulerAngles.z = 0
				var_28_6.localEulerAngles.x = 0
				var_28_6.localEulerAngles = var_28_6.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				var_28_6.localPosition = Vector3.New(0, -0.8, -6.2)
				var_28_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_6.position).x, (manager.ui.mainCamera.transform.position - var_28_6.position).y, (manager.ui.mainCamera.transform.position - var_28_6.position).z)
				var_28_6.localEulerAngles.z = 0
				var_28_6.localEulerAngles.x = 0
				var_28_6.localEulerAngles = var_28_6.localEulerAngles
			end

			if 0.0166666666666667 < arg_25_1.time_ and arg_25_1.time_ <= 0.0166666666666667 + arg_28_0 then
				arg_25_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_28_8 = 0
			local var_28_9 = 0.725

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(114801006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 29 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 29)

				if (29 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 29)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801006", "story_v_side_old_114801.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801006", "story_v_side_old_114801.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_side_old_114801", "114801006", "story_v_side_old_114801.awb")

						arg_25_1:RecordAudio("114801006", var_28_15)
						arg_25_1:RecordAudio("114801006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801006", "story_v_side_old_114801.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801006", "story_v_side_old_114801.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play114801007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114801007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play114801008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_32_0 = arg_29_1.actors_["1148ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1148ui_story == nil then
				arg_29_1.var_.characterEffect1148ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_1 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 and not isNil(var_32_0) then
				if arg_29_1.var_.characterEffect1148ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_1)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1148ui_story then
				arg_29_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_32_2 = 0
			local var_32_3 = 0.9

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(114801007).content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 36 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_4) / 36)

				if (36 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_4) / 36)) > 0 and var_32_3 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_7 and arg_29_1.time_ < var_32_2 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114801008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114801008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play114801009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_36_0 = 0
			local var_36_1 = 0.375

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_2 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(114801008).content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 15 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_2) / 15)

				if (15 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_2) / 15)) > 0 and var_36_1 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_5 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_5 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_5

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_5 and arg_33_1.time_ < var_36_0 + var_36_5 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114801009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114801009
		arg_37_1.duration_ = 5.57

		local var_37_0 = {
			ja = 4.733,
			ko = 5.566,
			zh = 3.166,
			en = 4.5
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
				arg_37_0:Play114801010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_40_0 = arg_37_1.actors_["1148ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1148ui_story == nil then
				arg_37_1.var_.characterEffect1148ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_1 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 and not isNil(var_40_0) then
				if arg_37_1.var_.characterEffect1148ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1148ui_story then
				arg_37_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_40_3 = arg_37_1.actors_["1148ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_3) and arg_37_1.var_.characterEffect1148ui_story == nil then
				arg_37_1.var_.characterEffect1148ui_story = var_40_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_4 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 and not isNil(var_40_3) then
				if arg_37_1.var_.characterEffect1148ui_story and not isNil(var_40_3) then
					arg_37_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 and not isNil(var_40_3) and arg_37_1.var_.characterEffect1148ui_story then
				arg_37_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_40_6 = 0
			local var_40_7 = 0.4

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(114801009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 16 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 16)

				if (16 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 16)) > 0 and var_40_7 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801009", "story_v_side_old_114801.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801009", "story_v_side_old_114801.awb") / 1000

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_side_old_114801", "114801009", "story_v_side_old_114801.awb")

						arg_37_1:RecordAudio("114801009", var_40_13)
						arg_37_1:RecordAudio("114801009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801009", "story_v_side_old_114801.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801009", "story_v_side_old_114801.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play114801010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114801010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play114801011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_44_0 = arg_41_1.actors_["1148ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1148ui_story == nil then
				arg_41_1.var_.characterEffect1148ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_1 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 and not isNil(var_44_0) then
				if arg_41_1.var_.characterEffect1148ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_1)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1148ui_story then
				arg_41_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_44_2 = 0
			local var_44_3 = 0.6

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_4 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(114801010).content)

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
	Play114801011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114801011
		arg_45_1.duration_ = 12.3

		local var_45_0 = {
			ja = 11.133,
			ko = 9.9,
			zh = 9.666,
			en = 12.3
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
				arg_45_0:Play114801012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_48_0 = arg_45_1.actors_["1148ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1148ui_story == nil then
				arg_45_1.var_.characterEffect1148ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_1 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 and not isNil(var_48_0) then
				if arg_45_1.var_.characterEffect1148ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_1)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1148ui_story then
				arg_45_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_48_2 = arg_45_1.actors_["1148ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect1148ui_story == nil then
				arg_45_1.var_.characterEffect1148ui_story = var_48_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_3 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.characterEffect1148ui_story and not isNil(var_48_2) then
					arg_45_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect1148ui_story then
				arg_45_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_48_5 = 0
			local var_48_6 = 1.275

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(114801011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 51 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 51)

				if (51 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 51)) > 0 and var_48_6 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801011", "story_v_side_old_114801.awb") ~= 0 then
					local var_48_11 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801011", "story_v_side_old_114801.awb") / 1000

					if var_48_11 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_5
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_side_old_114801", "114801011", "story_v_side_old_114801.awb")

						arg_45_1:RecordAudio("114801011", var_48_12)
						arg_45_1:RecordAudio("114801011", var_48_12)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801011", "story_v_side_old_114801.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801011", "story_v_side_old_114801.awb")
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

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114801012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114801012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play114801013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_52_0 = arg_49_1.actors_["1148ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1148ui_story == nil then
				arg_49_1.var_.characterEffect1148ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_1 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 and not isNil(var_52_0) then
				if arg_49_1.var_.characterEffect1148ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_1)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1148ui_story then
				arg_49_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_52_2 = 0
			local var_52_3 = 0.275

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_4 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(114801012).content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 11 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_4) / 11)

				if (11 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_4) / 11)) > 0 and var_52_3 < var_52_6 then
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
	Play114801013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114801013
		arg_53_1.duration_ = 5.67

		local var_53_0 = {
			ja = 5.666,
			ko = 4.8,
			zh = 3.1,
			en = 4.833
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
				arg_53_0:Play114801014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_2")
			end

			local var_56_0 = arg_53_1.actors_["1148ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1148ui_story == nil then
				arg_53_1.var_.characterEffect1148ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_1 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 and not isNil(var_56_0) then
				if arg_53_1.var_.characterEffect1148ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_1)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1148ui_story then
				arg_53_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_56_2 = arg_53_1.actors_["1148ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect1148ui_story == nil then
				arg_53_1.var_.characterEffect1148ui_story = var_56_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_3 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.characterEffect1148ui_story and not isNil(var_56_2) then
					arg_53_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect1148ui_story then
				arg_53_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_56_5 = 0
			local var_56_6 = 0.733333333333333

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(114801013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 15 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 15)

				if (15 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 15)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801013", "story_v_side_old_114801.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801013", "story_v_side_old_114801.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_side_old_114801", "114801013", "story_v_side_old_114801.awb")

						arg_53_1:RecordAudio("114801013", var_56_12)
						arg_53_1:RecordAudio("114801013", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801013", "story_v_side_old_114801.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801013", "story_v_side_old_114801.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_13 = math.max(var_56_6, arg_53_1.talkMaxDuration)

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_13 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_5) / var_56_13

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_5 + var_56_13 and arg_53_1.time_ < var_56_5 + var_56_13 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play114801014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114801014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play114801015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_60_0 = 0
			local var_60_1 = 1.1

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(114801014).content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 44 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_2) / 44)

				if (44 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_2) / 44)) > 0 and var_60_1 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_5 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_5 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_5

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_5 and arg_57_1.time_ < var_60_0 + var_60_5 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114801015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114801015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play114801016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_64_0 = arg_61_1.actors_["1148ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1148ui_story == nil then
				arg_61_1.var_.characterEffect1148ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_1 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 and not isNil(var_64_0) then
				if arg_61_1.var_.characterEffect1148ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_1)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1148ui_story then
				arg_61_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_64_2 = 0
			local var_64_3 = 0.55

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_4 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(114801015).content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 22 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 22)

				if (22 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 22)) > 0 and var_64_3 < var_64_6 then
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
	Play114801016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114801016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play114801017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_68_0 = arg_65_1.actors_["1148ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1148ui_story == nil then
				arg_65_1.var_.characterEffect1148ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_1 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 and not isNil(var_68_0) then
				if arg_65_1.var_.characterEffect1148ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1148ui_story then
				arg_65_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_68_3 = 0
			local var_68_4 = 1

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_3 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_5 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(114801016).content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 40 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_5) / 40)

				if (40 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_5) / 40)) > 0 and var_68_4 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_3 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_3
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_4, arg_65_1.talkMaxDuration)

			if var_68_3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_3 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_3) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_3 + var_68_8 and arg_65_1.time_ < var_68_3 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play114801017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114801017
		arg_69_1.duration_ = 16.7

		local var_69_0 = {
			ja = 16.7,
			ko = 9.833,
			zh = 9.1,
			en = 10.233
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
				arg_69_0:Play114801018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_72_0 = 0
			local var_72_1 = 1.05

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(114801017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 42 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 42)

				if (42 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 42)) > 0 and var_72_1 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801017", "story_v_side_old_114801.awb") ~= 0 then
					local var_72_6 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801017", "story_v_side_old_114801.awb") / 1000

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end

					if var_72_2.prefab_name ~= "" and arg_69_1.actors_[var_72_2.prefab_name] ~= nil then
						local var_72_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_2.prefab_name].transform, "story_v_side_old_114801", "114801017", "story_v_side_old_114801.awb")

						arg_69_1:RecordAudio("114801017", var_72_7)
						arg_69_1:RecordAudio("114801017", var_72_7)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801017", "story_v_side_old_114801.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801017", "story_v_side_old_114801.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114801018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114801018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play114801019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_76_0 = arg_73_1.actors_["1148ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1148ui_story == nil then
				arg_73_1.var_.characterEffect1148ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_1 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 and not isNil(var_76_0) then
				if arg_73_1.var_.characterEffect1148ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_1)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1148ui_story then
				arg_73_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_76_2 = 0
			local var_76_3 = 1.275

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(114801018).content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 51 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 51)

				if (51 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 51)) > 0 and var_76_3 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_7 and arg_73_1.time_ < var_76_2 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114801019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114801019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play114801020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_80_0 = 0
			local var_80_1 = 0.475

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(114801019).content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 19 <= 0 and var_80_1 or var_80_1 * (utf8.len(var_80_2) / 19)

				if (19 <= 0 and var_80_1 or var_80_1 * (utf8.len(var_80_2) / 19)) > 0 and var_80_1 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_5 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_5 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_5

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_5 and arg_77_1.time_ < var_80_0 + var_80_5 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play114801020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114801020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play114801021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_84_0 = 0
			local var_84_1 = 0.125

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_2 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(114801020).content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 5 <= 0 and var_84_1 or var_84_1 * (utf8.len(var_84_2) / 5)

				if (5 <= 0 and var_84_1 or var_84_1 * (utf8.len(var_84_2) / 5)) > 0 and var_84_1 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_5 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_5 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_5

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_5 and arg_81_1.time_ < var_84_0 + var_84_5 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play114801021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114801021
		arg_85_1.duration_ = 6.9

		local var_85_0 = {
			ja = 5,
			ko = 6.9,
			zh = 5.666,
			en = 6.733
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
				arg_85_0:Play114801022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_88_0 = arg_85_1.actors_["1148ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1148ui_story == nil then
				arg_85_1.var_.characterEffect1148ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_1 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 and not isNil(var_88_0) then
				if arg_85_1.var_.characterEffect1148ui_story and not isNil(var_88_0) then
					arg_85_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1148ui_story then
				arg_85_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_88_3 = 0
			local var_88_4 = 0.525

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_3 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_5 = arg_85_1:GetWordFromCfg(114801021)
				local var_88_6 = arg_85_1:FormatText(var_88_5.content)

				arg_85_1.text_.text = var_88_6

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_8 = 21 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_6) / 21)

				if (21 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_6) / 21)) > 0 and var_88_4 < var_88_8 then
					arg_85_1.talkMaxDuration = var_88_8

					if var_88_8 + var_88_3 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_3
					end
				end

				arg_85_1.text_.text = var_88_6
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801021", "story_v_side_old_114801.awb") ~= 0 then
					local var_88_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801021", "story_v_side_old_114801.awb") / 1000

					if var_88_9 + var_88_3 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_3
					end

					if var_88_5.prefab_name ~= "" and arg_85_1.actors_[var_88_5.prefab_name] ~= nil then
						local var_88_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_5.prefab_name].transform, "story_v_side_old_114801", "114801021", "story_v_side_old_114801.awb")

						arg_85_1:RecordAudio("114801021", var_88_10)
						arg_85_1:RecordAudio("114801021", var_88_10)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801021", "story_v_side_old_114801.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801021", "story_v_side_old_114801.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_11 = math.max(var_88_4, arg_85_1.talkMaxDuration)

			if var_88_3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_3 + var_88_11 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_3) / var_88_11

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_3 + var_88_11 and arg_85_1.time_ < var_88_3 + var_88_11 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play114801022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114801022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play114801023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_2")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_92_0 = arg_89_1.actors_["1148ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1148ui_story == nil then
				arg_89_1.var_.characterEffect1148ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_1 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 and not isNil(var_92_0) then
				if arg_89_1.var_.characterEffect1148ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_1)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1148ui_story then
				arg_89_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_92_2 = 0
			local var_92_3 = 0.125

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_4 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(114801022).content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_6 = 5 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_4) / 5)

				if (5 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_4) / 5)) > 0 and var_92_3 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_2
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_3, arg_89_1.talkMaxDuration)

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_2) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_2 + var_92_7 and arg_89_1.time_ < var_92_2 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play114801023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114801023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play114801024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_96_0 = 0
			local var_96_1 = 0.625

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(114801023).content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 25 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_2) / 25)

				if (25 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_2) / 25)) > 0 and var_96_1 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_5 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_5 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_5

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_5 and arg_93_1.time_ < var_96_0 + var_96_5 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play114801024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114801024
		arg_97_1.duration_ = 7.4

		local var_97_0 = {
			ja = 7.4,
			ko = 3.866,
			zh = 3.566,
			en = 3.2
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
				arg_97_0:Play114801025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_100_0 = arg_97_1.actors_["1148ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1148ui_story == nil then
				arg_97_1.var_.characterEffect1148ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_1 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 and not isNil(var_100_0) then
				if arg_97_1.var_.characterEffect1148ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1148ui_story then
				arg_97_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_100_3 = 0
			local var_100_4 = 0.3

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_3 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_5 = arg_97_1:GetWordFromCfg(114801024)
				local var_100_6 = arg_97_1:FormatText(var_100_5.content)

				arg_97_1.text_.text = var_100_6

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_8 = 12 <= 0 and var_100_4 or var_100_4 * (utf8.len(var_100_6) / 12)

				if (12 <= 0 and var_100_4 or var_100_4 * (utf8.len(var_100_6) / 12)) > 0 and var_100_4 < var_100_8 then
					arg_97_1.talkMaxDuration = var_100_8

					if var_100_8 + var_100_3 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_3
					end
				end

				arg_97_1.text_.text = var_100_6
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801024", "story_v_side_old_114801.awb") ~= 0 then
					local var_100_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801024", "story_v_side_old_114801.awb") / 1000

					if var_100_9 + var_100_3 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_3
					end

					if var_100_5.prefab_name ~= "" and arg_97_1.actors_[var_100_5.prefab_name] ~= nil then
						local var_100_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_5.prefab_name].transform, "story_v_side_old_114801", "114801024", "story_v_side_old_114801.awb")

						arg_97_1:RecordAudio("114801024", var_100_10)
						arg_97_1:RecordAudio("114801024", var_100_10)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801024", "story_v_side_old_114801.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801024", "story_v_side_old_114801.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_11 = math.max(var_100_4, arg_97_1.talkMaxDuration)

			if var_100_3 <= arg_97_1.time_ and arg_97_1.time_ < var_100_3 + var_100_11 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_3) / var_100_11

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_3 + var_100_11 and arg_97_1.time_ < var_100_3 + var_100_11 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play114801025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114801025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play114801026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_104_0 = arg_101_1.actors_["1148ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1148ui_story == nil then
				arg_101_1.var_.characterEffect1148ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_1 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 and not isNil(var_104_0) then
				if arg_101_1.var_.characterEffect1148ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_1)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1148ui_story then
				arg_101_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_104_2 = 0
			local var_104_3 = 0.75

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_4 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(114801025).content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_6 = 30 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_4) / 30)

				if (30 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_4) / 30)) > 0 and var_104_3 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_7 and arg_101_1.time_ < var_104_2 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play114801026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 114801026
		arg_105_1.duration_ = 7.8

		local var_105_0 = {
			ja = 5.933,
			ko = 4.733,
			zh = 5.333,
			en = 7.8
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, true)

		arg_105_1.tipsText_.text = StoryTipsCfg[114801].name

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"

			SetActive(arg_105_1.choicesGo_, true)

			for iter_106_0, iter_106_1 in ipairs(arg_105_1.choices_) do
				SetActive(iter_106_1.go, iter_106_0 <= 2)
			end

			arg_105_1.choices_[1].txt.text = arg_105_1:FormatText(StoryChoiceCfg[86].name)
			arg_105_1.choices_[2].txt.text = arg_105_1:FormatText(StoryChoiceCfg[87].name)
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				PlayerAction.UseStoryTrigger(1148011, 211480101, 114801026, 1)
				arg_105_0:Play114801028(arg_105_1)
			end

			if arg_107_0 == 2 then
				arg_105_0:Play114801033(arg_105_1)
			end

			arg_105_1:RecordChoiceLog(114801026, 86, 87)
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_108_0 = arg_105_1.actors_["1148ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1148ui_story == nil then
				arg_105_1.var_.characterEffect1148ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_1 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 and not isNil(var_108_0) then
				if arg_105_1.var_.characterEffect1148ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1148ui_story then
				arg_105_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_108_3 = 0
			local var_108_4 = 0.475

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_3 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_5 = arg_105_1:GetWordFromCfg(114801026)
				local var_108_6 = arg_105_1:FormatText(var_108_5.content)

				arg_105_1.text_.text = var_108_6

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_8 = 19 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_6) / 19)

				if (19 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_6) / 19)) > 0 and var_108_4 < var_108_8 then
					arg_105_1.talkMaxDuration = var_108_8

					if var_108_8 + var_108_3 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_3
					end
				end

				arg_105_1.text_.text = var_108_6
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801026", "story_v_side_old_114801.awb") ~= 0 then
					local var_108_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801026", "story_v_side_old_114801.awb") / 1000

					if var_108_9 + var_108_3 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_3
					end

					if var_108_5.prefab_name ~= "" and arg_105_1.actors_[var_108_5.prefab_name] ~= nil then
						local var_108_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_5.prefab_name].transform, "story_v_side_old_114801", "114801026", "story_v_side_old_114801.awb")

						arg_105_1:RecordAudio("114801026", var_108_10)
						arg_105_1:RecordAudio("114801026", var_108_10)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801026", "story_v_side_old_114801.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801026", "story_v_side_old_114801.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_11 = math.max(var_108_4, arg_105_1.talkMaxDuration)

			if var_108_3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_3 + var_108_11 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_3) / var_108_11

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_3 + var_108_11 and arg_105_1.time_ < var_108_3 + var_108_11 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play114801028 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 114801028
		arg_109_1.duration_ = 7.3

		local var_109_0 = {
			ja = 7.3,
			ko = 4.2,
			zh = 3.933,
			en = 5.833
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
				arg_109_0:Play114801029(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action435")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_112_0 = 0
			local var_112_1 = 0.275

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:GetWordFromCfg(114801028)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 17 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_3) / 17)

				if (17 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_3) / 17)) > 0 and var_112_1 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801028", "story_v_side_old_114801.awb") ~= 0 then
					local var_112_6 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801028", "story_v_side_old_114801.awb") / 1000

					if var_112_6 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_0
					end

					if var_112_2.prefab_name ~= "" and arg_109_1.actors_[var_112_2.prefab_name] ~= nil then
						local var_112_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_2.prefab_name].transform, "story_v_side_old_114801", "114801028", "story_v_side_old_114801.awb")

						arg_109_1:RecordAudio("114801028", var_112_7)
						arg_109_1:RecordAudio("114801028", var_112_7)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801028", "story_v_side_old_114801.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801028", "story_v_side_old_114801.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_8 and arg_109_1.time_ < var_112_0 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play114801029 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 114801029
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play114801030(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_116_0 = arg_113_1.actors_["1148ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1148ui_story == nil then
				arg_113_1.var_.characterEffect1148ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_1 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 and not isNil(var_116_0) then
				if arg_113_1.var_.characterEffect1148ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_1)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1148ui_story then
				arg_113_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_116_2 = 0
			local var_116_3 = 1.1

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_4 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(114801029).content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_6 = 44 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_4) / 44)

				if (44 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_4) / 44)) > 0 and var_116_3 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_7 and arg_113_1.time_ < var_116_2 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play114801030 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 114801030
		arg_117_1.duration_ = 11.8

		local var_117_0 = {
			ja = 11.8,
			ko = 9.633,
			zh = 7.9,
			en = 7.733
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
				arg_117_0:Play114801031(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_120_0 = arg_117_1.actors_["1148ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1148ui_story == nil then
				arg_117_1.var_.characterEffect1148ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_1 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 and not isNil(var_120_0) then
				if arg_117_1.var_.characterEffect1148ui_story and not isNil(var_120_0) then
					arg_117_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1148ui_story then
				arg_117_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_120_3 = 0
			local var_120_4 = 0.9

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_5 = arg_117_1:GetWordFromCfg(114801030)
				local var_120_6 = arg_117_1:FormatText(var_120_5.content)

				arg_117_1.text_.text = var_120_6

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_8 = 36 <= 0 and var_120_4 or var_120_4 * (utf8.len(var_120_6) / 36)

				if (36 <= 0 and var_120_4 or var_120_4 * (utf8.len(var_120_6) / 36)) > 0 and var_120_4 < var_120_8 then
					arg_117_1.talkMaxDuration = var_120_8

					if var_120_8 + var_120_3 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_3
					end
				end

				arg_117_1.text_.text = var_120_6
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801030", "story_v_side_old_114801.awb") ~= 0 then
					local var_120_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801030", "story_v_side_old_114801.awb") / 1000

					if var_120_9 + var_120_3 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_3
					end

					if var_120_5.prefab_name ~= "" and arg_117_1.actors_[var_120_5.prefab_name] ~= nil then
						local var_120_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_5.prefab_name].transform, "story_v_side_old_114801", "114801030", "story_v_side_old_114801.awb")

						arg_117_1:RecordAudio("114801030", var_120_10)
						arg_117_1:RecordAudio("114801030", var_120_10)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801030", "story_v_side_old_114801.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801030", "story_v_side_old_114801.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_11 = math.max(var_120_4, arg_117_1.talkMaxDuration)

			if var_120_3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_3 + var_120_11 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_3) / var_120_11

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_3 + var_120_11 and arg_117_1.time_ < var_120_3 + var_120_11 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play114801031 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 114801031
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play114801037(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_124_0 = arg_121_1.actors_["1148ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1148ui_story == nil then
				arg_121_1.var_.characterEffect1148ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_1 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 and not isNil(var_124_0) then
				if arg_121_1.var_.characterEffect1148ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_1)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1148ui_story then
				arg_121_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_124_2 = 0
			local var_124_3 = 0.15

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_4 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(114801031).content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 6 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_4) / 6)

				if (6 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_4) / 6)) > 0 and var_124_3 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_2 <= arg_121_1.time_ and arg_121_1.time_ < var_124_2 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_2) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_2 + var_124_7 and arg_121_1.time_ < var_124_2 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play114801037 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 114801037
		arg_125_1.duration_ = 4.33

		local var_125_0 = {
			ja = 4.333,
			ko = 2.466,
			zh = 3.266,
			en = 2.5
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
				arg_125_0:Play114801038(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_128_0 = arg_125_1.actors_["1148ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1148ui_story == nil then
				arg_125_1.var_.characterEffect1148ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_1 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 and not isNil(var_128_0) then
				if arg_125_1.var_.characterEffect1148ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1148ui_story then
				arg_125_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_128_3 = 0
			local var_128_4 = 0.2

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_3 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_5 = arg_125_1:GetWordFromCfg(114801037)
				local var_128_6 = arg_125_1:FormatText(var_128_5.content)

				arg_125_1.text_.text = var_128_6

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_8 = 8 <= 0 and var_128_4 or var_128_4 * (utf8.len(var_128_6) / 8)

				if (8 <= 0 and var_128_4 or var_128_4 * (utf8.len(var_128_6) / 8)) > 0 and var_128_4 < var_128_8 then
					arg_125_1.talkMaxDuration = var_128_8

					if var_128_8 + var_128_3 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_3
					end
				end

				arg_125_1.text_.text = var_128_6
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801037", "story_v_side_old_114801.awb") ~= 0 then
					local var_128_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801037", "story_v_side_old_114801.awb") / 1000

					if var_128_9 + var_128_3 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_3
					end

					if var_128_5.prefab_name ~= "" and arg_125_1.actors_[var_128_5.prefab_name] ~= nil then
						local var_128_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_5.prefab_name].transform, "story_v_side_old_114801", "114801037", "story_v_side_old_114801.awb")

						arg_125_1:RecordAudio("114801037", var_128_10)
						arg_125_1:RecordAudio("114801037", var_128_10)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801037", "story_v_side_old_114801.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801037", "story_v_side_old_114801.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_11 = math.max(var_128_4, arg_125_1.talkMaxDuration)

			if var_128_3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_3 + var_128_11 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_3) / var_128_11

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_3 + var_128_11 and arg_125_1.time_ < var_128_3 + var_128_11 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play114801038 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 114801038
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play114801039(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1148ui_story = arg_129_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1148ui_story"].transform.position).z)
				arg_129_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1148ui_story"].transform.localEulerAngles = arg_129_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1148ui_story"].transform.position).z)
				arg_129_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1148ui_story"].transform.localEulerAngles = arg_129_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_132_1 = 0
			local var_132_2 = 0.675

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(114801038).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 27 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 27)

				if (27 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 27)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play114801039 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 114801039
		arg_133_1.duration_ = 8.5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play114801040(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if arg_133_1.bgs_.ST01 == nil then
				local var_136_0 = Object.Instantiate(arg_133_1.paintGo_)

				var_136_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_136_0.name = "ST01"
				var_136_0.transform.parent = arg_133_1.stage_.transform
				var_136_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.bgs_.ST01 = var_136_0
			end

			if 1.5 < arg_133_1.time_ and arg_133_1.time_ <= 1.5 + arg_136_0 then
				local var_136_1 = arg_133_1.bgs_.ST01

				arg_133_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_136_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_2 = var_136_1:GetComponent("SpriteRenderer")

				if var_136_2 and var_136_2.sprite then
					local var_136_3 = 2 * (var_136_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_136_1.transform.localScale = Vector3.New(var_136_3 / var_136_2.sprite.bounds.size.y < var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x and var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x or var_136_3 / var_136_2.sprite.bounds.size.y, var_136_3 / var_136_2.sprite.bounds.size.y < var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x and var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x or var_136_3 / var_136_2.sprite.bounds.size.y, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "ST01" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				local var_136_4 = arg_133_1.bgs_.ST02:GetComponent("SpriteRenderer")

				if var_136_4 then
					arg_133_1.var_.alphaOldValueST02 = var_136_4.color.a
					arg_133_1.var_.alphaMatValueST02 = var_136_4
				end

				arg_133_1.var_.alphaOldValueST02 = 1
			end

			local var_136_5 = 1.5

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_5 then
				if arg_133_1.var_.alphaMatValueST02 then
					arg_133_1.var_.alphaMatValueST02.color.a = Mathf.Lerp(arg_133_1.var_.alphaOldValueST02, 0, (arg_133_1.time_ - 0) / var_136_5)
					arg_133_1.var_.alphaMatValueST02.color = arg_133_1.var_.alphaMatValueST02.color
				end
			end

			if arg_133_1.time_ >= 0 + var_136_5 and arg_133_1.time_ < 0 + var_136_5 + arg_136_0 and arg_133_1.var_.alphaMatValueST02 then
				arg_133_1.var_.alphaMatValueST02.color.a = 0
				arg_133_1.var_.alphaMatValueST02.color = arg_133_1.var_.alphaMatValueST02.color
			end

			if 1.5 < arg_133_1.time_ and arg_133_1.time_ <= 1.5 + arg_136_0 then
				local var_136_6 = arg_133_1.bgs_.ST01:GetComponent("SpriteRenderer")

				if var_136_6 then
					arg_133_1.var_.alphaOldValueST01 = var_136_6.color.a
					arg_133_1.var_.alphaMatValueST01 = var_136_6
				end

				arg_133_1.var_.alphaOldValueST01 = 0
			end

			local var_136_7 = 1.5

			if 1.5 <= arg_133_1.time_ and arg_133_1.time_ < 1.5 + var_136_7 then
				if arg_133_1.var_.alphaMatValueST01 then
					arg_133_1.var_.alphaMatValueST01.color.a = Mathf.Lerp(arg_133_1.var_.alphaOldValueST01, 1, (arg_133_1.time_ - 1.5) / var_136_7)
					arg_133_1.var_.alphaMatValueST01.color = arg_133_1.var_.alphaMatValueST01.color
				end
			end

			if arg_133_1.time_ >= 1.5 + var_136_7 and arg_133_1.time_ < 1.5 + var_136_7 + arg_136_0 and arg_133_1.var_.alphaMatValueST01 then
				arg_133_1.var_.alphaMatValueST01.color.a = 1
				arg_133_1.var_.alphaMatValueST01.color = arg_133_1.var_.alphaMatValueST01.color
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_8 = 3.5
			local var_136_9 = 1.35

			if 3.5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_10 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_10:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_11 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(114801039).content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 54 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 54)

				if (54 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 54)) > 0 and var_136_9 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13
					var_136_8 = var_136_8 + 0.3

					if var_136_13 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = var_136_8 + 0.3
			local var_136_15 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 + 0.3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_14 + var_136_15 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_14) / var_136_15

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_14 + var_136_15 and arg_133_1.time_ < var_136_14 + var_136_15 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play114801040 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 114801040
		arg_139_1.duration_ = 9.07

		local var_139_0 = {
			ja = 9.066,
			ko = 8.866,
			zh = 7.7,
			en = 7.666
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
				arg_139_0:Play114801041(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0.0166666666666667 < arg_139_1.time_ and arg_139_1.time_ <= 0.0166666666666667 + arg_142_0 and not isNil(arg_139_1.actors_["1148ui_story"]) and arg_139_1.var_.characterEffect1148ui_story == nil then
				arg_139_1.var_.characterEffect1148ui_story = arg_139_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.2

			if 0.0166666666666667 <= arg_139_1.time_ and arg_139_1.time_ < 0.0166666666666667 + var_142_0 and not isNil(arg_139_1.actors_["1148ui_story"]) then
				if arg_139_1.var_.characterEffect1148ui_story and not isNil(arg_139_1.actors_["1148ui_story"]) then
					arg_139_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0.0166666666666667 + var_142_0 and arg_139_1.time_ < 0.0166666666666667 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1148ui_story"]) and arg_139_1.var_.characterEffect1148ui_story then
				arg_139_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_142_2 = arg_139_1.actors_["1148ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1148ui_story = var_142_2.localPosition

				arg_139_1:ShowWeapon(arg_139_1.var_["1148ui_story" .. "Animator"].transform, false)
			end

			local var_142_3 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 then
				var_142_2.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_139_1.time_ - 0) / var_142_3)
				var_142_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_2.position).x, (manager.ui.mainCamera.transform.position - var_142_2.position).y, (manager.ui.mainCamera.transform.position - var_142_2.position).z)
				var_142_2.localEulerAngles.z = 0
				var_142_2.localEulerAngles.x = 0
				var_142_2.localEulerAngles = var_142_2.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 then
				var_142_2.localPosition = Vector3.New(0, -0.8, -6.2)
				var_142_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_2.position).x, (manager.ui.mainCamera.transform.position - var_142_2.position).y, (manager.ui.mainCamera.transform.position - var_142_2.position).z)
				var_142_2.localEulerAngles.z = 0
				var_142_2.localEulerAngles.x = 0
				var_142_2.localEulerAngles = var_142_2.localEulerAngles
			end

			if 0.0166666666666667 < arg_139_1.time_ and arg_139_1.time_ <= 0.0166666666666667 + arg_142_0 then
				arg_139_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0.0166666666666667 < arg_139_1.time_ and arg_139_1.time_ <= 0.0166666666666667 + arg_142_0 then
				arg_139_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_142_4 = 0
			local var_142_5 = 0.85

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(114801040)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 34 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 34)

				if (34 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 34)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801040", "story_v_side_old_114801.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801040", "story_v_side_old_114801.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_side_old_114801", "114801040", "story_v_side_old_114801.awb")

						arg_139_1:RecordAudio("114801040", var_142_11)
						arg_139_1:RecordAudio("114801040", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801040", "story_v_side_old_114801.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801040", "story_v_side_old_114801.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_12 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_12 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_12

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_12 and arg_139_1.time_ < var_142_4 + var_142_12 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play114801041 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 114801041
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play114801042(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_2")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_146_0 = 0
			local var_146_1 = 0.925

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_2 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(114801041).content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 37 <= 0 and var_146_1 or var_146_1 * (utf8.len(var_146_2) / 37)

				if (37 <= 0 and var_146_1 or var_146_1 * (utf8.len(var_146_2) / 37)) > 0 and var_146_1 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_5 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_5 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_5

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_5 and arg_143_1.time_ < var_146_0 + var_146_5 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play114801042 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 114801042
		arg_147_1.duration_ = 5.8

		local var_147_0 = {
			ja = 5.8,
			ko = 4.933,
			zh = 4.8,
			en = 4.9
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play114801043(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_150_0 = 0
			local var_150_1 = 0.375

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:GetWordFromCfg(114801042)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 15 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_3) / 15)

				if (15 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_3) / 15)) > 0 and var_150_1 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801042", "story_v_side_old_114801.awb") ~= 0 then
					local var_150_6 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801042", "story_v_side_old_114801.awb") / 1000

					if var_150_6 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_0
					end

					if var_150_2.prefab_name ~= "" and arg_147_1.actors_[var_150_2.prefab_name] ~= nil then
						local var_150_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_2.prefab_name].transform, "story_v_side_old_114801", "114801042", "story_v_side_old_114801.awb")

						arg_147_1:RecordAudio("114801042", var_150_7)
						arg_147_1:RecordAudio("114801042", var_150_7)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801042", "story_v_side_old_114801.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801042", "story_v_side_old_114801.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_8 and arg_147_1.time_ < var_150_0 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play114801043 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 114801043
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play114801044(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_2")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_154_0 = arg_151_1.actors_["1148ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1148ui_story == nil then
				arg_151_1.var_.characterEffect1148ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_1 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_1 and not isNil(var_154_0) then
				if arg_151_1.var_.characterEffect1148ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_1)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_1 and arg_151_1.time_ < 0 + var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1148ui_story then
				arg_151_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_154_2 = 0
			local var_154_3 = 0.15

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
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

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_4 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(114801043).content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_6 = 6 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_4) / 6)

				if (6 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_4) / 6)) > 0 and var_154_3 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_7 and arg_151_1.time_ < var_154_2 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play114801044 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 114801044
		arg_155_1.duration_ = 10.03

		local var_155_0 = {
			ja = 10.033,
			ko = 7.966,
			zh = 7.7,
			en = 8.3
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
				arg_155_0:Play114801045(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_158_0 = arg_155_1.actors_["1148ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1148ui_story == nil then
				arg_155_1.var_.characterEffect1148ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_1 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 and not isNil(var_158_0) then
				if arg_155_1.var_.characterEffect1148ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1148ui_story then
				arg_155_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_158_3 = 0
			local var_158_4 = 0.775

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_5 = arg_155_1:GetWordFromCfg(114801044)
				local var_158_6 = arg_155_1:FormatText(var_158_5.content)

				arg_155_1.text_.text = var_158_6

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_8 = 31 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_6) / 31)

				if (31 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_6) / 31)) > 0 and var_158_4 < var_158_8 then
					arg_155_1.talkMaxDuration = var_158_8

					if var_158_8 + var_158_3 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_3
					end
				end

				arg_155_1.text_.text = var_158_6
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801044", "story_v_side_old_114801.awb") ~= 0 then
					local var_158_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801044", "story_v_side_old_114801.awb") / 1000

					if var_158_9 + var_158_3 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_3
					end

					if var_158_5.prefab_name ~= "" and arg_155_1.actors_[var_158_5.prefab_name] ~= nil then
						local var_158_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_5.prefab_name].transform, "story_v_side_old_114801", "114801044", "story_v_side_old_114801.awb")

						arg_155_1:RecordAudio("114801044", var_158_10)
						arg_155_1:RecordAudio("114801044", var_158_10)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801044", "story_v_side_old_114801.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801044", "story_v_side_old_114801.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_11 = math.max(var_158_4, arg_155_1.talkMaxDuration)

			if var_158_3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_3 + var_158_11 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_3) / var_158_11

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_3 + var_158_11 and arg_155_1.time_ < var_158_3 + var_158_11 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play114801045 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 114801045
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play114801046(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_2")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_162_0 = arg_159_1.actors_["1148ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1148ui_story == nil then
				arg_159_1.var_.characterEffect1148ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_1 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 and not isNil(var_162_0) then
				if arg_159_1.var_.characterEffect1148ui_story and not isNil(var_162_0) then
					arg_159_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_1)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1148ui_story then
				arg_159_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_162_2 = 0
			local var_162_3 = 0.25

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_4 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(114801045).content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_6 = 10 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_4) / 10)

				if (10 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_4) / 10)) > 0 and var_162_3 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_7 and arg_159_1.time_ < var_162_2 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play114801046 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 114801046
		arg_163_1.duration_ = 3.63

		local var_163_0 = {
			ja = 3.4,
			ko = 3.633,
			zh = 1.999999999999,
			en = 3.333
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
				arg_163_0:Play114801047(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			local var_166_0 = arg_163_1.actors_["1148ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1148ui_story == nil then
				arg_163_1.var_.characterEffect1148ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_1 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 and not isNil(var_166_0) then
				if arg_163_1.var_.characterEffect1148ui_story and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1148ui_story then
				arg_163_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_166_3 = 0
			local var_166_4 = 0.2

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_3 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_5 = arg_163_1:GetWordFromCfg(114801046)
				local var_166_6 = arg_163_1:FormatText(var_166_5.content)

				arg_163_1.text_.text = var_166_6

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_8 = 8 <= 0 and var_166_4 or var_166_4 * (utf8.len(var_166_6) / 8)

				if (8 <= 0 and var_166_4 or var_166_4 * (utf8.len(var_166_6) / 8)) > 0 and var_166_4 < var_166_8 then
					arg_163_1.talkMaxDuration = var_166_8

					if var_166_8 + var_166_3 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_3
					end
				end

				arg_163_1.text_.text = var_166_6
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801046", "story_v_side_old_114801.awb") ~= 0 then
					local var_166_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801046", "story_v_side_old_114801.awb") / 1000

					if var_166_9 + var_166_3 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_3
					end

					if var_166_5.prefab_name ~= "" and arg_163_1.actors_[var_166_5.prefab_name] ~= nil then
						local var_166_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_5.prefab_name].transform, "story_v_side_old_114801", "114801046", "story_v_side_old_114801.awb")

						arg_163_1:RecordAudio("114801046", var_166_10)
						arg_163_1:RecordAudio("114801046", var_166_10)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801046", "story_v_side_old_114801.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801046", "story_v_side_old_114801.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_11 = math.max(var_166_4, arg_163_1.talkMaxDuration)

			if var_166_3 <= arg_163_1.time_ and arg_163_1.time_ < var_166_3 + var_166_11 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_3) / var_166_11

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_3 + var_166_11 and arg_163_1.time_ < var_166_3 + var_166_11 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play114801047 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 114801047
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play114801048(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_170_0 = arg_167_1.actors_["1148ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1148ui_story == nil then
				arg_167_1.var_.characterEffect1148ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_1 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 and not isNil(var_170_0) then
				if arg_167_1.var_.characterEffect1148ui_story and not isNil(var_170_0) then
					arg_167_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_1)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1148ui_story then
				arg_167_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_170_2 = 0
			local var_170_3 = 0.075

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_4 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(114801047).content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_6 = 3 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_4) / 3)

				if (3 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_4) / 3)) > 0 and var_170_3 < var_170_6 then
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
	Play114801048 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 114801048
		arg_171_1.duration_ = 7.6

		local var_171_0 = {
			ja = 7.233,
			ko = 6.2,
			zh = 5.766,
			en = 7.6
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
				arg_171_0:Play114801049(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_174_0 = arg_171_1.actors_["1148ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1148ui_story == nil then
				arg_171_1.var_.characterEffect1148ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_1 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 and not isNil(var_174_0) then
				if arg_171_1.var_.characterEffect1148ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1148ui_story then
				arg_171_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_174_3 = 0
			local var_174_4 = 0.625

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_3 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_5 = arg_171_1:GetWordFromCfg(114801048)
				local var_174_6 = arg_171_1:FormatText(var_174_5.content)

				arg_171_1.text_.text = var_174_6

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_8 = 25 <= 0 and var_174_4 or var_174_4 * (utf8.len(var_174_6) / 25)

				if (25 <= 0 and var_174_4 or var_174_4 * (utf8.len(var_174_6) / 25)) > 0 and var_174_4 < var_174_8 then
					arg_171_1.talkMaxDuration = var_174_8

					if var_174_8 + var_174_3 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_3
					end
				end

				arg_171_1.text_.text = var_174_6
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801048", "story_v_side_old_114801.awb") ~= 0 then
					local var_174_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801048", "story_v_side_old_114801.awb") / 1000

					if var_174_9 + var_174_3 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_3
					end

					if var_174_5.prefab_name ~= "" and arg_171_1.actors_[var_174_5.prefab_name] ~= nil then
						local var_174_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_5.prefab_name].transform, "story_v_side_old_114801", "114801048", "story_v_side_old_114801.awb")

						arg_171_1:RecordAudio("114801048", var_174_10)
						arg_171_1:RecordAudio("114801048", var_174_10)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801048", "story_v_side_old_114801.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801048", "story_v_side_old_114801.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_11 = math.max(var_174_4, arg_171_1.talkMaxDuration)

			if var_174_3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_3 + var_174_11 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_3) / var_174_11

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_3 + var_174_11 and arg_171_1.time_ < var_174_3 + var_174_11 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play114801049 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 114801049
		arg_175_1.duration_ = 5.5

		local var_175_0 = {
			ja = 5.5,
			ko = 4.5,
			zh = 3,
			en = 4.7
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
				arg_175_0:Play114801050(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_2")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_178_0 = 0
			local var_178_1 = 0.325

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_2 = arg_175_1:GetWordFromCfg(114801049)
				local var_178_3 = arg_175_1:FormatText(var_178_2.content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 13 <= 0 and var_178_1 or var_178_1 * (utf8.len(var_178_3) / 13)

				if (13 <= 0 and var_178_1 or var_178_1 * (utf8.len(var_178_3) / 13)) > 0 and var_178_1 < var_178_5 then
					arg_175_1.talkMaxDuration = var_178_5

					if var_178_5 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801049", "story_v_side_old_114801.awb") ~= 0 then
					local var_178_6 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801049", "story_v_side_old_114801.awb") / 1000

					if var_178_6 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_0
					end

					if var_178_2.prefab_name ~= "" and arg_175_1.actors_[var_178_2.prefab_name] ~= nil then
						local var_178_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_2.prefab_name].transform, "story_v_side_old_114801", "114801049", "story_v_side_old_114801.awb")

						arg_175_1:RecordAudio("114801049", var_178_7)
						arg_175_1:RecordAudio("114801049", var_178_7)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801049", "story_v_side_old_114801.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801049", "story_v_side_old_114801.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_8 and arg_175_1.time_ < var_178_0 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play114801050 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 114801050
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play114801051(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_182_0 = arg_179_1.actors_["1148ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1148ui_story == nil then
				arg_179_1.var_.characterEffect1148ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_1 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 and not isNil(var_182_0) then
				if arg_179_1.var_.characterEffect1148ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_1)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1148ui_story then
				arg_179_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_182_2 = 0
			local var_182_3 = 0.15

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
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

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_4 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(114801050).content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_6 = 6 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_4) / 6)

				if (6 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_4) / 6)) > 0 and var_182_3 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_7 and arg_179_1.time_ < var_182_2 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play114801051 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 114801051
		arg_183_1.duration_ = 7.83

		local var_183_0 = {
			ja = 7.833,
			ko = 5.666,
			zh = 5.033,
			en = 5.833
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play114801052(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_186_0 = arg_183_1.actors_["1148ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1148ui_story == nil then
				arg_183_1.var_.characterEffect1148ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_1 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_1 and not isNil(var_186_0) then
				if arg_183_1.var_.characterEffect1148ui_story and not isNil(var_186_0) then
					arg_183_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_1 and arg_183_1.time_ < 0 + var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1148ui_story then
				arg_183_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_186_3 = 0
			local var_186_4 = 0.45

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_5 = arg_183_1:GetWordFromCfg(114801051)
				local var_186_6 = arg_183_1:FormatText(var_186_5.content)

				arg_183_1.text_.text = var_186_6

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_8 = 18 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_6) / 18)

				if (18 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_6) / 18)) > 0 and var_186_4 < var_186_8 then
					arg_183_1.talkMaxDuration = var_186_8

					if var_186_8 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_3
					end
				end

				arg_183_1.text_.text = var_186_6
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801051", "story_v_side_old_114801.awb") ~= 0 then
					local var_186_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801051", "story_v_side_old_114801.awb") / 1000

					if var_186_9 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_3
					end

					if var_186_5.prefab_name ~= "" and arg_183_1.actors_[var_186_5.prefab_name] ~= nil then
						local var_186_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_5.prefab_name].transform, "story_v_side_old_114801", "114801051", "story_v_side_old_114801.awb")

						arg_183_1:RecordAudio("114801051", var_186_10)
						arg_183_1:RecordAudio("114801051", var_186_10)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801051", "story_v_side_old_114801.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801051", "story_v_side_old_114801.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_11 = math.max(var_186_4, arg_183_1.talkMaxDuration)

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_11 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_3) / var_186_11

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_3 + var_186_11 and arg_183_1.time_ < var_186_3 + var_186_11 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play114801052 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 114801052
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play114801053(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_2")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_190_0 = arg_187_1.actors_["1148ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1148ui_story == nil then
				arg_187_1.var_.characterEffect1148ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_1 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 and not isNil(var_190_0) then
				if arg_187_1.var_.characterEffect1148ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_1)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1148ui_story then
				arg_187_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_190_2 = 0
			local var_190_3 = 0.125

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_4 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(114801052).content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_6 = 5 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_4) / 5)

				if (5 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_4) / 5)) > 0 and var_190_3 < var_190_6 then
					arg_187_1.talkMaxDuration = var_190_6

					if var_190_6 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_2
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_3, arg_187_1.talkMaxDuration)

			if var_190_2 <= arg_187_1.time_ and arg_187_1.time_ < var_190_2 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_2) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_2 + var_190_7 and arg_187_1.time_ < var_190_2 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play114801053 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 114801053
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play114801054(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_194_0 = 0
			local var_194_1 = 0.5

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(114801053).content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 20 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_2) / 20)

				if (20 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_2) / 20)) > 0 and var_194_1 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_5 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_5 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_5

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_5 and arg_191_1.time_ < var_194_0 + var_194_5 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play114801054 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 114801054
		arg_195_1.duration_ = 3.13

		local var_195_0 = {
			ja = 3.133,
			ko = 2.266,
			zh = 1.999999999999,
			en = 2.666
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
				arg_195_0:Play114801055(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			local var_198_0 = arg_195_1.actors_["1148ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1148ui_story == nil then
				arg_195_1.var_.characterEffect1148ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_1 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_1 and not isNil(var_198_0) then
				if arg_195_1.var_.characterEffect1148ui_story and not isNil(var_198_0) then
					arg_195_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_1 and arg_195_1.time_ < 0 + var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1148ui_story then
				arg_195_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_198_3 = 0
			local var_198_4 = 0.2

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_3 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_5 = arg_195_1:GetWordFromCfg(114801054)
				local var_198_6 = arg_195_1:FormatText(var_198_5.content)

				arg_195_1.text_.text = var_198_6

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_8 = 8 <= 0 and var_198_4 or var_198_4 * (utf8.len(var_198_6) / 8)

				if (8 <= 0 and var_198_4 or var_198_4 * (utf8.len(var_198_6) / 8)) > 0 and var_198_4 < var_198_8 then
					arg_195_1.talkMaxDuration = var_198_8

					if var_198_8 + var_198_3 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_3
					end
				end

				arg_195_1.text_.text = var_198_6
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801054", "story_v_side_old_114801.awb") ~= 0 then
					local var_198_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801054", "story_v_side_old_114801.awb") / 1000

					if var_198_9 + var_198_3 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_3
					end

					if var_198_5.prefab_name ~= "" and arg_195_1.actors_[var_198_5.prefab_name] ~= nil then
						local var_198_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_5.prefab_name].transform, "story_v_side_old_114801", "114801054", "story_v_side_old_114801.awb")

						arg_195_1:RecordAudio("114801054", var_198_10)
						arg_195_1:RecordAudio("114801054", var_198_10)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801054", "story_v_side_old_114801.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801054", "story_v_side_old_114801.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_11 = math.max(var_198_4, arg_195_1.talkMaxDuration)

			if var_198_3 <= arg_195_1.time_ and arg_195_1.time_ < var_198_3 + var_198_11 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_3) / var_198_11

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_3 + var_198_11 and arg_195_1.time_ < var_198_3 + var_198_11 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play114801055 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 114801055
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play114801056(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_202_0 = 0
			local var_202_1 = 0.375

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_2 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(114801055).content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 15 <= 0 and var_202_1 or var_202_1 * (utf8.len(var_202_2) / 15)

				if (15 <= 0 and var_202_1 or var_202_1 * (utf8.len(var_202_2) / 15)) > 0 and var_202_1 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_5 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_5 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_5

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_5 and arg_199_1.time_ < var_202_0 + var_202_5 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play114801056 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 114801056
		arg_203_1.duration_ = 3.3

		local var_203_0 = {
			ja = 3.3,
			ko = 2.266,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_203_0:Play114801057(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_2")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_206_0 = 0
			local var_206_1 = 0.175

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_2 = arg_203_1:GetWordFromCfg(114801056)
				local var_206_3 = arg_203_1:FormatText(var_206_2.content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 7 <= 0 and var_206_1 or var_206_1 * (utf8.len(var_206_3) / 7)

				if (7 <= 0 and var_206_1 or var_206_1 * (utf8.len(var_206_3) / 7)) > 0 and var_206_1 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801056", "story_v_side_old_114801.awb") ~= 0 then
					local var_206_6 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801056", "story_v_side_old_114801.awb") / 1000

					if var_206_6 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_0
					end

					if var_206_2.prefab_name ~= "" and arg_203_1.actors_[var_206_2.prefab_name] ~= nil then
						local var_206_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_2.prefab_name].transform, "story_v_side_old_114801", "114801056", "story_v_side_old_114801.awb")

						arg_203_1:RecordAudio("114801056", var_206_7)
						arg_203_1:RecordAudio("114801056", var_206_7)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801056", "story_v_side_old_114801.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801056", "story_v_side_old_114801.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_8 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_8 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_8

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_8 and arg_203_1.time_ < var_206_0 + var_206_8 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play114801057 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 114801057
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play114801058(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_210_0 = arg_207_1.actors_["1148ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1148ui_story == nil then
				arg_207_1.var_.characterEffect1148ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_1 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_1 and not isNil(var_210_0) then
				if arg_207_1.var_.characterEffect1148ui_story and not isNil(var_210_0) then
					arg_207_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_1)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_1 and arg_207_1.time_ < 0 + var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1148ui_story then
				arg_207_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_210_2 = 0
			local var_210_3 = 0.1

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_4 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(114801057).content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_6 = 4 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_4) / 4)

				if (4 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_4) / 4)) > 0 and var_210_3 < var_210_6 then
					arg_207_1.talkMaxDuration = var_210_6

					if var_210_6 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_2
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_3, arg_207_1.talkMaxDuration)

			if var_210_2 <= arg_207_1.time_ and arg_207_1.time_ < var_210_2 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_2) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_2 + var_210_7 and arg_207_1.time_ < var_210_2 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play114801058 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 114801058
		arg_211_1.duration_ = 7.63

		local var_211_0 = {
			ja = 7.633,
			ko = 5.833,
			zh = 5.333,
			en = 4.866
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
				arg_211_0:Play114801059(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_214_0 = arg_211_1.actors_["1148ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1148ui_story == nil then
				arg_211_1.var_.characterEffect1148ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_1 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_1 and not isNil(var_214_0) then
				if arg_211_1.var_.characterEffect1148ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_1 and arg_211_1.time_ < 0 + var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1148ui_story then
				arg_211_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_214_3 = 0
			local var_214_4 = 0.475

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_3 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_5 = arg_211_1:GetWordFromCfg(114801058)
				local var_214_6 = arg_211_1:FormatText(var_214_5.content)

				arg_211_1.text_.text = var_214_6

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_8 = 19 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_6) / 19)

				if (19 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_6) / 19)) > 0 and var_214_4 < var_214_8 then
					arg_211_1.talkMaxDuration = var_214_8

					if var_214_8 + var_214_3 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_3
					end
				end

				arg_211_1.text_.text = var_214_6
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801058", "story_v_side_old_114801.awb") ~= 0 then
					local var_214_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801058", "story_v_side_old_114801.awb") / 1000

					if var_214_9 + var_214_3 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_3
					end

					if var_214_5.prefab_name ~= "" and arg_211_1.actors_[var_214_5.prefab_name] ~= nil then
						local var_214_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_5.prefab_name].transform, "story_v_side_old_114801", "114801058", "story_v_side_old_114801.awb")

						arg_211_1:RecordAudio("114801058", var_214_10)
						arg_211_1:RecordAudio("114801058", var_214_10)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801058", "story_v_side_old_114801.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801058", "story_v_side_old_114801.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_11 = math.max(var_214_4, arg_211_1.talkMaxDuration)

			if var_214_3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_3 + var_214_11 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_3) / var_214_11

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_3 + var_214_11 and arg_211_1.time_ < var_214_3 + var_214_11 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play114801059 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 114801059
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play114801060(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_218_0 = arg_215_1.actors_["1148ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1148ui_story == nil then
				arg_215_1.var_.characterEffect1148ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_1 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_1 and not isNil(var_218_0) then
				if arg_215_1.var_.characterEffect1148ui_story and not isNil(var_218_0) then
					arg_215_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_1)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_1 and arg_215_1.time_ < 0 + var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1148ui_story then
				arg_215_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_218_2 = 0
			local var_218_3 = 0.25

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_2 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_4 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(114801059).content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_6 = 10 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_4) / 10)

				if (10 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_4) / 10)) > 0 and var_218_3 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_2 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_2
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_3, arg_215_1.talkMaxDuration)

			if var_218_2 <= arg_215_1.time_ and arg_215_1.time_ < var_218_2 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_2) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_2 + var_218_7 and arg_215_1.time_ < var_218_2 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play114801060 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 114801060
		arg_219_1.duration_ = 6.3

		local var_219_0 = {
			ja = 6.3,
			ko = 4.2,
			zh = 5,
			en = 5.1
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
				arg_219_0:Play114801061(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action446")
			end

			local var_222_0 = arg_219_1.actors_["1148ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1148ui_story == nil then
				arg_219_1.var_.characterEffect1148ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_1 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_1 and not isNil(var_222_0) then
				if arg_219_1.var_.characterEffect1148ui_story and not isNil(var_222_0) then
					arg_219_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_1 and arg_219_1.time_ < 0 + var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1148ui_story then
				arg_219_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_222_3 = 0
			local var_222_4 = 0.45

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_3 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_5 = arg_219_1:GetWordFromCfg(114801060)
				local var_222_6 = arg_219_1:FormatText(var_222_5.content)

				arg_219_1.text_.text = var_222_6

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_8 = 18 <= 0 and var_222_4 or var_222_4 * (utf8.len(var_222_6) / 18)

				if (18 <= 0 and var_222_4 or var_222_4 * (utf8.len(var_222_6) / 18)) > 0 and var_222_4 < var_222_8 then
					arg_219_1.talkMaxDuration = var_222_8

					if var_222_8 + var_222_3 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_3
					end
				end

				arg_219_1.text_.text = var_222_6
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801060", "story_v_side_old_114801.awb") ~= 0 then
					local var_222_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801060", "story_v_side_old_114801.awb") / 1000

					if var_222_9 + var_222_3 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_3
					end

					if var_222_5.prefab_name ~= "" and arg_219_1.actors_[var_222_5.prefab_name] ~= nil then
						local var_222_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_5.prefab_name].transform, "story_v_side_old_114801", "114801060", "story_v_side_old_114801.awb")

						arg_219_1:RecordAudio("114801060", var_222_10)
						arg_219_1:RecordAudio("114801060", var_222_10)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801060", "story_v_side_old_114801.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801060", "story_v_side_old_114801.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_11 = math.max(var_222_4, arg_219_1.talkMaxDuration)

			if var_222_3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_3 + var_222_11 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_3) / var_222_11

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_3 + var_222_11 and arg_219_1.time_ < var_222_3 + var_222_11 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play114801061 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 114801061
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play114801062(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_226_0 = arg_223_1.actors_["1148ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1148ui_story == nil then
				arg_223_1.var_.characterEffect1148ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_1 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 and not isNil(var_226_0) then
				if arg_223_1.var_.characterEffect1148ui_story and not isNil(var_226_0) then
					arg_223_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_1)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1148ui_story then
				arg_223_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_226_2 = 0
			local var_226_3 = 0.125

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
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

				local var_226_4 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(114801061).content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_6 = 5 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_4) / 5)

				if (5 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_4) / 5)) > 0 and var_226_3 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_2
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_3, arg_223_1.talkMaxDuration)

			if var_226_2 <= arg_223_1.time_ and arg_223_1.time_ < var_226_2 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_2) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_2 + var_226_7 and arg_223_1.time_ < var_226_2 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play114801062 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 114801062
		arg_227_1.duration_ = 11.6

		local var_227_0 = {
			ja = 11.6,
			ko = 6.666,
			zh = 8,
			en = 9
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
				arg_227_0:Play114801063(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_2")
			end

			local var_230_0 = arg_227_1.actors_["1148ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1148ui_story == nil then
				arg_227_1.var_.characterEffect1148ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_1 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_1 and not isNil(var_230_0) then
				if arg_227_1.var_.characterEffect1148ui_story and not isNil(var_230_0) then
					arg_227_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_1 and arg_227_1.time_ < 0 + var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1148ui_story then
				arg_227_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_230_3 = 0
			local var_230_4 = 0.925

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_3 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_5 = arg_227_1:GetWordFromCfg(114801062)
				local var_230_6 = arg_227_1:FormatText(var_230_5.content)

				arg_227_1.text_.text = var_230_6

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_8 = 37 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_6) / 37)

				if (37 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_6) / 37)) > 0 and var_230_4 < var_230_8 then
					arg_227_1.talkMaxDuration = var_230_8

					if var_230_8 + var_230_3 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_3
					end
				end

				arg_227_1.text_.text = var_230_6
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801062", "story_v_side_old_114801.awb") ~= 0 then
					local var_230_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801062", "story_v_side_old_114801.awb") / 1000

					if var_230_9 + var_230_3 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_3
					end

					if var_230_5.prefab_name ~= "" and arg_227_1.actors_[var_230_5.prefab_name] ~= nil then
						local var_230_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_5.prefab_name].transform, "story_v_side_old_114801", "114801062", "story_v_side_old_114801.awb")

						arg_227_1:RecordAudio("114801062", var_230_10)
						arg_227_1:RecordAudio("114801062", var_230_10)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801062", "story_v_side_old_114801.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801062", "story_v_side_old_114801.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_11 = math.max(var_230_4, arg_227_1.talkMaxDuration)

			if var_230_3 <= arg_227_1.time_ and arg_227_1.time_ < var_230_3 + var_230_11 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_3) / var_230_11

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_3 + var_230_11 and arg_227_1.time_ < var_230_3 + var_230_11 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play114801063 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 114801063
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play114801064(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_234_0 = arg_231_1.actors_["1148ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1148ui_story == nil then
				arg_231_1.var_.characterEffect1148ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_1 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_1 and not isNil(var_234_0) then
				if arg_231_1.var_.characterEffect1148ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_1)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_1 and arg_231_1.time_ < 0 + var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1148ui_story then
				arg_231_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_234_2 = 0
			local var_234_3 = 0.25

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
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

				local var_234_4 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(114801063).content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_6 = 10 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_4) / 10)

				if (10 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_4) / 10)) > 0 and var_234_3 < var_234_6 then
					arg_231_1.talkMaxDuration = var_234_6

					if var_234_6 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_6 + var_234_2
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_3, arg_231_1.talkMaxDuration)

			if var_234_2 <= arg_231_1.time_ and arg_231_1.time_ < var_234_2 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_2) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_2 + var_234_7 and arg_231_1.time_ < var_234_2 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play114801064 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 114801064
		arg_235_1.duration_ = 7.03

		local var_235_0 = {
			ja = 7.033,
			ko = 3.533,
			zh = 5.766,
			en = 6.133
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
				arg_235_0:Play114801065(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_238_0 = arg_235_1.actors_["1148ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1148ui_story == nil then
				arg_235_1.var_.characterEffect1148ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_1 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_1 and not isNil(var_238_0) then
				if arg_235_1.var_.characterEffect1148ui_story and not isNil(var_238_0) then
					arg_235_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_1 and arg_235_1.time_ < 0 + var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1148ui_story then
				arg_235_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_238_3 = 0
			local var_238_4 = 0.55

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_3 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_5 = arg_235_1:GetWordFromCfg(114801064)
				local var_238_6 = arg_235_1:FormatText(var_238_5.content)

				arg_235_1.text_.text = var_238_6

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_8 = 22 <= 0 and var_238_4 or var_238_4 * (utf8.len(var_238_6) / 22)

				if (22 <= 0 and var_238_4 or var_238_4 * (utf8.len(var_238_6) / 22)) > 0 and var_238_4 < var_238_8 then
					arg_235_1.talkMaxDuration = var_238_8

					if var_238_8 + var_238_3 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_3
					end
				end

				arg_235_1.text_.text = var_238_6
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801064", "story_v_side_old_114801.awb") ~= 0 then
					local var_238_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801064", "story_v_side_old_114801.awb") / 1000

					if var_238_9 + var_238_3 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_3
					end

					if var_238_5.prefab_name ~= "" and arg_235_1.actors_[var_238_5.prefab_name] ~= nil then
						local var_238_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_5.prefab_name].transform, "story_v_side_old_114801", "114801064", "story_v_side_old_114801.awb")

						arg_235_1:RecordAudio("114801064", var_238_10)
						arg_235_1:RecordAudio("114801064", var_238_10)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801064", "story_v_side_old_114801.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801064", "story_v_side_old_114801.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_11 = math.max(var_238_4, arg_235_1.talkMaxDuration)

			if var_238_3 <= arg_235_1.time_ and arg_235_1.time_ < var_238_3 + var_238_11 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_3) / var_238_11

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_3 + var_238_11 and arg_235_1.time_ < var_238_3 + var_238_11 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play114801065 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 114801065
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play114801066(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_242_0 = arg_239_1.actors_["1148ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1148ui_story == nil then
				arg_239_1.var_.characterEffect1148ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_1 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_1 and not isNil(var_242_0) then
				if arg_239_1.var_.characterEffect1148ui_story and not isNil(var_242_0) then
					arg_239_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_1)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_1 and arg_239_1.time_ < 0 + var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1148ui_story then
				arg_239_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_242_2 = 0
			local var_242_3 = 0.2

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
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

				local var_242_4 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(114801065).content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_6 = 8 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_4) / 8)

				if (8 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_4) / 8)) > 0 and var_242_3 < var_242_6 then
					arg_239_1.talkMaxDuration = var_242_6

					if var_242_6 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_2
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_3, arg_239_1.talkMaxDuration)

			if var_242_2 <= arg_239_1.time_ and arg_239_1.time_ < var_242_2 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_2) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_2 + var_242_7 and arg_239_1.time_ < var_242_2 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play114801066 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 114801066
		arg_243_1.duration_ = 14.53

		local var_243_0 = {
			ja = 8.9,
			ko = 14.533,
			zh = 13.5,
			en = 10.533
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
				arg_243_0:Play114801067(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action445")
			end

			local var_246_0 = arg_243_1.actors_["1148ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1148ui_story == nil then
				arg_243_1.var_.characterEffect1148ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_1 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_1 and not isNil(var_246_0) then
				if arg_243_1.var_.characterEffect1148ui_story and not isNil(var_246_0) then
					arg_243_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_1 and arg_243_1.time_ < 0 + var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1148ui_story then
				arg_243_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_246_3 = 0
			local var_246_4 = 1.3

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_3 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_5 = arg_243_1:GetWordFromCfg(114801066)
				local var_246_6 = arg_243_1:FormatText(var_246_5.content)

				arg_243_1.text_.text = var_246_6

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_8 = 52 <= 0 and var_246_4 or var_246_4 * (utf8.len(var_246_6) / 52)

				if (52 <= 0 and var_246_4 or var_246_4 * (utf8.len(var_246_6) / 52)) > 0 and var_246_4 < var_246_8 then
					arg_243_1.talkMaxDuration = var_246_8

					if var_246_8 + var_246_3 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_3
					end
				end

				arg_243_1.text_.text = var_246_6
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801066", "story_v_side_old_114801.awb") ~= 0 then
					local var_246_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801066", "story_v_side_old_114801.awb") / 1000

					if var_246_9 + var_246_3 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_3
					end

					if var_246_5.prefab_name ~= "" and arg_243_1.actors_[var_246_5.prefab_name] ~= nil then
						local var_246_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_5.prefab_name].transform, "story_v_side_old_114801", "114801066", "story_v_side_old_114801.awb")

						arg_243_1:RecordAudio("114801066", var_246_10)
						arg_243_1:RecordAudio("114801066", var_246_10)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801066", "story_v_side_old_114801.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801066", "story_v_side_old_114801.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_11 = math.max(var_246_4, arg_243_1.talkMaxDuration)

			if var_246_3 <= arg_243_1.time_ and arg_243_1.time_ < var_246_3 + var_246_11 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_3) / var_246_11

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_3 + var_246_11 and arg_243_1.time_ < var_246_3 + var_246_11 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play114801067 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 114801067
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play114801068(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_250_0 = 0
			local var_250_1 = 0.8

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_2 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(114801067).content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 32 <= 0 and var_250_1 or var_250_1 * (utf8.len(var_250_2) / 32)

				if (32 <= 0 and var_250_1 or var_250_1 * (utf8.len(var_250_2) / 32)) > 0 and var_250_1 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_5 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_5 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_5

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_5 and arg_247_1.time_ < var_250_0 + var_250_5 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play114801068 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 114801068
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play114801069(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_254_0 = arg_251_1.actors_["1148ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1148ui_story == nil then
				arg_251_1.var_.characterEffect1148ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_1 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_1 and not isNil(var_254_0) then
				if arg_251_1.var_.characterEffect1148ui_story and not isNil(var_254_0) then
					arg_251_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_1)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_1 and arg_251_1.time_ < 0 + var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1148ui_story then
				arg_251_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_254_2 = 0
			local var_254_3 = 0.175

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
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

				local var_254_4 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(114801068).content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_6 = 7 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_4) / 7)

				if (7 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_4) / 7)) > 0 and var_254_3 < var_254_6 then
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
	Play114801069 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 114801069
		arg_255_1.duration_ = 12.4

		local var_255_0 = {
			ja = 12.4,
			ko = 9.066,
			zh = 9.266,
			en = 11.1
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
				arg_255_0:Play114801070(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action454")
			end

			local var_258_0 = arg_255_1.actors_["1148ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1148ui_story == nil then
				arg_255_1.var_.characterEffect1148ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_1 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_1 and not isNil(var_258_0) then
				if arg_255_1.var_.characterEffect1148ui_story and not isNil(var_258_0) then
					arg_255_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_1 and arg_255_1.time_ < 0 + var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1148ui_story then
				arg_255_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_258_3 = 0
			local var_258_4 = 0.975

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_3 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_5 = arg_255_1:GetWordFromCfg(114801069)
				local var_258_6 = arg_255_1:FormatText(var_258_5.content)

				arg_255_1.text_.text = var_258_6

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_8 = 39 <= 0 and var_258_4 or var_258_4 * (utf8.len(var_258_6) / 39)

				if (39 <= 0 and var_258_4 or var_258_4 * (utf8.len(var_258_6) / 39)) > 0 and var_258_4 < var_258_8 then
					arg_255_1.talkMaxDuration = var_258_8

					if var_258_8 + var_258_3 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_3
					end
				end

				arg_255_1.text_.text = var_258_6
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801069", "story_v_side_old_114801.awb") ~= 0 then
					local var_258_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801069", "story_v_side_old_114801.awb") / 1000

					if var_258_9 + var_258_3 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_9 + var_258_3
					end

					if var_258_5.prefab_name ~= "" and arg_255_1.actors_[var_258_5.prefab_name] ~= nil then
						local var_258_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_5.prefab_name].transform, "story_v_side_old_114801", "114801069", "story_v_side_old_114801.awb")

						arg_255_1:RecordAudio("114801069", var_258_10)
						arg_255_1:RecordAudio("114801069", var_258_10)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801069", "story_v_side_old_114801.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801069", "story_v_side_old_114801.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_11 = math.max(var_258_4, arg_255_1.talkMaxDuration)

			if var_258_3 <= arg_255_1.time_ and arg_255_1.time_ < var_258_3 + var_258_11 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_3) / var_258_11

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_3 + var_258_11 and arg_255_1.time_ < var_258_3 + var_258_11 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play114801070 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 114801070
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play114801071(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_262_0 = 0
			local var_262_1 = 0.65

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_2 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(114801070).content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 22 <= 0 and var_262_1 or var_262_1 * (utf8.len(var_262_2) / 22)

				if (22 <= 0 and var_262_1 or var_262_1 * (utf8.len(var_262_2) / 22)) > 0 and var_262_1 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_5 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_5 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_5

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_5 and arg_259_1.time_ < var_262_0 + var_262_5 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play114801071 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 114801071
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play114801072(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1148ui_story"]) and arg_263_1.var_.characterEffect1148ui_story == nil then
				arg_263_1.var_.characterEffect1148ui_story = arg_263_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1148ui_story"]) then
				if arg_263_1.var_.characterEffect1148ui_story and not isNil(arg_263_1.actors_["1148ui_story"]) then
					arg_263_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1148ui_story"]) and arg_263_1.var_.characterEffect1148ui_story then
				arg_263_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_266_1 = 0
			local var_266_2 = 0.4

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_3 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(114801071).content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 16 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 16)

				if (16 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 16)) > 0 and var_266_2 < var_266_5 then
					arg_263_1.talkMaxDuration = var_266_5

					if var_266_5 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + var_266_1
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_6 = math.max(var_266_2, arg_263_1.talkMaxDuration)

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_6 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_1) / var_266_6

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_1 + var_266_6 and arg_263_1.time_ < var_266_1 + var_266_6 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play114801072 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 114801072
		arg_267_1.duration_ = 4.6

		local var_267_0 = {
			ja = 4.6,
			ko = 4.6,
			zh = 4,
			en = 3.733
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
				arg_267_0:Play114801073(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action446")
			end

			local var_270_0 = arg_267_1.actors_["1148ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1148ui_story == nil then
				arg_267_1.var_.characterEffect1148ui_story = var_270_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_1 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_1 and not isNil(var_270_0) then
				if arg_267_1.var_.characterEffect1148ui_story and not isNil(var_270_0) then
					arg_267_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_1 and arg_267_1.time_ < 0 + var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1148ui_story then
				arg_267_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_270_3 = 0
			local var_270_4 = 0.375

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_3 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_5 = arg_267_1:GetWordFromCfg(114801072)
				local var_270_6 = arg_267_1:FormatText(var_270_5.content)

				arg_267_1.text_.text = var_270_6

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_8 = 15 <= 0 and var_270_4 or var_270_4 * (utf8.len(var_270_6) / 15)

				if (15 <= 0 and var_270_4 or var_270_4 * (utf8.len(var_270_6) / 15)) > 0 and var_270_4 < var_270_8 then
					arg_267_1.talkMaxDuration = var_270_8

					if var_270_8 + var_270_3 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_3
					end
				end

				arg_267_1.text_.text = var_270_6
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801072", "story_v_side_old_114801.awb") ~= 0 then
					local var_270_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801072", "story_v_side_old_114801.awb") / 1000

					if var_270_9 + var_270_3 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_3
					end

					if var_270_5.prefab_name ~= "" and arg_267_1.actors_[var_270_5.prefab_name] ~= nil then
						local var_270_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_5.prefab_name].transform, "story_v_side_old_114801", "114801072", "story_v_side_old_114801.awb")

						arg_267_1:RecordAudio("114801072", var_270_10)
						arg_267_1:RecordAudio("114801072", var_270_10)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801072", "story_v_side_old_114801.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801072", "story_v_side_old_114801.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_11 = math.max(var_270_4, arg_267_1.talkMaxDuration)

			if var_270_3 <= arg_267_1.time_ and arg_267_1.time_ < var_270_3 + var_270_11 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_3) / var_270_11

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_3 + var_270_11 and arg_267_1.time_ < var_270_3 + var_270_11 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play114801073 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 114801073
		arg_271_1.duration_ = 15.83

		local var_271_0 = {
			ja = 15.833,
			ko = 10.8,
			zh = 9.633,
			en = 11.766
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
				arg_271_0:Play114801074(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_2")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_274_0 = 0
			local var_274_1 = 1.1

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_2 = arg_271_1:GetWordFromCfg(114801073)
				local var_274_3 = arg_271_1:FormatText(var_274_2.content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 44 <= 0 and var_274_1 or var_274_1 * (utf8.len(var_274_3) / 44)

				if (44 <= 0 and var_274_1 or var_274_1 * (utf8.len(var_274_3) / 44)) > 0 and var_274_1 < var_274_5 then
					arg_271_1.talkMaxDuration = var_274_5

					if var_274_5 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801073", "story_v_side_old_114801.awb") ~= 0 then
					local var_274_6 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801073", "story_v_side_old_114801.awb") / 1000

					if var_274_6 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_6 + var_274_0
					end

					if var_274_2.prefab_name ~= "" and arg_271_1.actors_[var_274_2.prefab_name] ~= nil then
						local var_274_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_2.prefab_name].transform, "story_v_side_old_114801", "114801073", "story_v_side_old_114801.awb")

						arg_271_1:RecordAudio("114801073", var_274_7)
						arg_271_1:RecordAudio("114801073", var_274_7)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801073", "story_v_side_old_114801.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801073", "story_v_side_old_114801.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_8 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_8 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_8

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_8 and arg_271_1.time_ < var_274_0 + var_274_8 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play114801074 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 114801074
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play114801075(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_knock", "")
			end

			local var_278_1 = 0
			local var_278_2 = 0.6

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

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(114801074).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 24 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 24)

				if (24 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 24)) > 0 and var_278_2 < var_278_5 then
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
	Play114801075 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 114801075
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play114801076(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1148ui_story"]) and arg_279_1.var_.characterEffect1148ui_story == nil then
				arg_279_1.var_.characterEffect1148ui_story = arg_279_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1148ui_story"]) then
				if arg_279_1.var_.characterEffect1148ui_story and not isNil(arg_279_1.actors_["1148ui_story"]) then
					arg_279_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1148ui_story"]) and arg_279_1.var_.characterEffect1148ui_story then
				arg_279_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 0.8

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(114801075).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 32 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 32)

				if (32 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 32)) > 0 and var_282_2 < var_282_5 then
					arg_279_1.talkMaxDuration = var_282_5

					if var_282_5 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_6 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_6 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_6

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_6 and arg_279_1.time_ < var_282_1 + var_282_6 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play114801076 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 114801076
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play114801077(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.675

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
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

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(114801076).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 27 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 27)

				if (27 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 27)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play114801077 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 114801077
		arg_287_1.duration_ = 2

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play114801078(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_290_0 = arg_287_1.actors_["1148ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1148ui_story == nil then
				arg_287_1.var_.characterEffect1148ui_story = var_290_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_1 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_1 and not isNil(var_290_0) then
				if arg_287_1.var_.characterEffect1148ui_story and not isNil(var_290_0) then
					arg_287_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_1 and arg_287_1.time_ < 0 + var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1148ui_story then
				arg_287_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_290_3 = 0
			local var_290_4 = 0.075

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_3 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_5 = arg_287_1:GetWordFromCfg(114801077)
				local var_290_6 = arg_287_1:FormatText(var_290_5.content)

				arg_287_1.text_.text = var_290_6

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_8 = 3 <= 0 and var_290_4 or var_290_4 * (utf8.len(var_290_6) / 3)

				if (3 <= 0 and var_290_4 or var_290_4 * (utf8.len(var_290_6) / 3)) > 0 and var_290_4 < var_290_8 then
					arg_287_1.talkMaxDuration = var_290_8

					if var_290_8 + var_290_3 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_3
					end
				end

				arg_287_1.text_.text = var_290_6
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801077", "story_v_side_old_114801.awb") ~= 0 then
					local var_290_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801077", "story_v_side_old_114801.awb") / 1000

					if var_290_9 + var_290_3 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_3
					end

					if var_290_5.prefab_name ~= "" and arg_287_1.actors_[var_290_5.prefab_name] ~= nil then
						local var_290_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_5.prefab_name].transform, "story_v_side_old_114801", "114801077", "story_v_side_old_114801.awb")

						arg_287_1:RecordAudio("114801077", var_290_10)
						arg_287_1:RecordAudio("114801077", var_290_10)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801077", "story_v_side_old_114801.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801077", "story_v_side_old_114801.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_11 = math.max(var_290_4, arg_287_1.talkMaxDuration)

			if var_290_3 <= arg_287_1.time_ and arg_287_1.time_ < var_290_3 + var_290_11 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_3) / var_290_11

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_3 + var_290_11 and arg_287_1.time_ < var_290_3 + var_290_11 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play114801078 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 114801078
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play114801079(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_294_0 = 0
			local var_294_1 = 0.725

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_2 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(114801078).content)

				arg_291_1.text_.text = var_294_2

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 29 <= 0 and var_294_1 or var_294_1 * (utf8.len(var_294_2) / 29)

				if (29 <= 0 and var_294_1 or var_294_1 * (utf8.len(var_294_2) / 29)) > 0 and var_294_1 < var_294_4 then
					arg_291_1.talkMaxDuration = var_294_4

					if var_294_4 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_4 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_2
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_5 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_5 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_5

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_5 and arg_291_1.time_ < var_294_0 + var_294_5 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play114801079 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 114801079
		arg_295_1.duration_ = 15.7

		local var_295_0 = {
			ja = 15.7,
			ko = 13.633,
			zh = 13.066,
			en = 11.8
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
				arg_295_0:Play114801080(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_298_0 = 0
			local var_298_1 = 1.375

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_2 = arg_295_1:GetWordFromCfg(114801079)
				local var_298_3 = arg_295_1:FormatText(var_298_2.content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 55 <= 0 and var_298_1 or var_298_1 * (utf8.len(var_298_3) / 55)

				if (55 <= 0 and var_298_1 or var_298_1 * (utf8.len(var_298_3) / 55)) > 0 and var_298_1 < var_298_5 then
					arg_295_1.talkMaxDuration = var_298_5

					if var_298_5 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801079", "story_v_side_old_114801.awb") ~= 0 then
					local var_298_6 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801079", "story_v_side_old_114801.awb") / 1000

					if var_298_6 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_6 + var_298_0
					end

					if var_298_2.prefab_name ~= "" and arg_295_1.actors_[var_298_2.prefab_name] ~= nil then
						local var_298_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_2.prefab_name].transform, "story_v_side_old_114801", "114801079", "story_v_side_old_114801.awb")

						arg_295_1:RecordAudio("114801079", var_298_7)
						arg_295_1:RecordAudio("114801079", var_298_7)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801079", "story_v_side_old_114801.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801079", "story_v_side_old_114801.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_8 and arg_295_1.time_ < var_298_0 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play114801080 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 114801080
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play114801081(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1148ui_story"]) and arg_299_1.var_.characterEffect1148ui_story == nil then
				arg_299_1.var_.characterEffect1148ui_story = arg_299_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1148ui_story"]) then
				if arg_299_1.var_.characterEffect1148ui_story and not isNil(arg_299_1.actors_["1148ui_story"]) then
					arg_299_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_0)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1148ui_story"]) and arg_299_1.var_.characterEffect1148ui_story then
				arg_299_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_302_1 = 0
			local var_302_2 = 0.325

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_3 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(114801080).content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 13 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 13)

				if (13 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 13)) > 0 and var_302_2 < var_302_5 then
					arg_299_1.talkMaxDuration = var_302_5

					if var_302_5 + var_302_1 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + var_302_1
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_6 = math.max(var_302_2, arg_299_1.talkMaxDuration)

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_6 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_1) / var_302_6

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_1 + var_302_6 and arg_299_1.time_ < var_302_1 + var_302_6 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play114801081 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 114801081
		arg_303_1.duration_ = 8.2

		local var_303_0 = {
			ja = 8.2,
			ko = 5.666,
			zh = 5.366,
			en = 7.4
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
				arg_303_0:Play114801082(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action475")
			end

			local var_306_0 = arg_303_1.actors_["1148ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1148ui_story == nil then
				arg_303_1.var_.characterEffect1148ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_1 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_1 and not isNil(var_306_0) then
				if arg_303_1.var_.characterEffect1148ui_story and not isNil(var_306_0) then
					arg_303_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_1 and arg_303_1.time_ < 0 + var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1148ui_story then
				arg_303_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_306_3 = 0
			local var_306_4 = 0.6

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_3 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_5 = arg_303_1:GetWordFromCfg(114801081)
				local var_306_6 = arg_303_1:FormatText(var_306_5.content)

				arg_303_1.text_.text = var_306_6

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_8 = 24 <= 0 and var_306_4 or var_306_4 * (utf8.len(var_306_6) / 24)

				if (24 <= 0 and var_306_4 or var_306_4 * (utf8.len(var_306_6) / 24)) > 0 and var_306_4 < var_306_8 then
					arg_303_1.talkMaxDuration = var_306_8

					if var_306_8 + var_306_3 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_3
					end
				end

				arg_303_1.text_.text = var_306_6
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801081", "story_v_side_old_114801.awb") ~= 0 then
					local var_306_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801081", "story_v_side_old_114801.awb") / 1000

					if var_306_9 + var_306_3 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_9 + var_306_3
					end

					if var_306_5.prefab_name ~= "" and arg_303_1.actors_[var_306_5.prefab_name] ~= nil then
						local var_306_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_5.prefab_name].transform, "story_v_side_old_114801", "114801081", "story_v_side_old_114801.awb")

						arg_303_1:RecordAudio("114801081", var_306_10)
						arg_303_1:RecordAudio("114801081", var_306_10)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801081", "story_v_side_old_114801.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801081", "story_v_side_old_114801.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_11 = math.max(var_306_4, arg_303_1.talkMaxDuration)

			if var_306_3 <= arg_303_1.time_ and arg_303_1.time_ < var_306_3 + var_306_11 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_3) / var_306_11

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_3 + var_306_11 and arg_303_1.time_ < var_306_3 + var_306_11 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play114801082 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 114801082
		arg_307_1.duration_ = 12.47

		local var_307_0 = {
			ja = 12.466,
			ko = 6.766,
			zh = 8.8,
			en = 11.533
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
				arg_307_0:Play114801083(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action457")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_310_0 = 0
			local var_310_1 = 1.15

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_2 = arg_307_1:GetWordFromCfg(114801082)
				local var_310_3 = arg_307_1:FormatText(var_310_2.content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 46 <= 0 and var_310_1 or var_310_1 * (utf8.len(var_310_3) / 46)

				if (46 <= 0 and var_310_1 or var_310_1 * (utf8.len(var_310_3) / 46)) > 0 and var_310_1 < var_310_5 then
					arg_307_1.talkMaxDuration = var_310_5

					if var_310_5 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801082", "story_v_side_old_114801.awb") ~= 0 then
					local var_310_6 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801082", "story_v_side_old_114801.awb") / 1000

					if var_310_6 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_6 + var_310_0
					end

					if var_310_2.prefab_name ~= "" and arg_307_1.actors_[var_310_2.prefab_name] ~= nil then
						local var_310_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_2.prefab_name].transform, "story_v_side_old_114801", "114801082", "story_v_side_old_114801.awb")

						arg_307_1:RecordAudio("114801082", var_310_7)
						arg_307_1:RecordAudio("114801082", var_310_7)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801082", "story_v_side_old_114801.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801082", "story_v_side_old_114801.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_8 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_8 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_8

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_8 and arg_307_1.time_ < var_310_0 + var_310_8 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play114801083 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 114801083
		arg_311_1.duration_ = 4.73

		local var_311_0 = {
			ja = 4.733,
			ko = 3.1,
			zh = 3.3,
			en = 4.2
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
				arg_311_0:Play114801084(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_314_0 = 0
			local var_314_1 = 0.325

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_2 = arg_311_1:GetWordFromCfg(114801083)
				local var_314_3 = arg_311_1:FormatText(var_314_2.content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 13 <= 0 and var_314_1 or var_314_1 * (utf8.len(var_314_3) / 13)

				if (13 <= 0 and var_314_1 or var_314_1 * (utf8.len(var_314_3) / 13)) > 0 and var_314_1 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801083", "story_v_side_old_114801.awb") ~= 0 then
					local var_314_6 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801083", "story_v_side_old_114801.awb") / 1000

					if var_314_6 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_6 + var_314_0
					end

					if var_314_2.prefab_name ~= "" and arg_311_1.actors_[var_314_2.prefab_name] ~= nil then
						local var_314_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_2.prefab_name].transform, "story_v_side_old_114801", "114801083", "story_v_side_old_114801.awb")

						arg_311_1:RecordAudio("114801083", var_314_7)
						arg_311_1:RecordAudio("114801083", var_314_7)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801083", "story_v_side_old_114801.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801083", "story_v_side_old_114801.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_8 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_8 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_8

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_8 and arg_311_1.time_ < var_314_0 + var_314_8 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play114801084 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 114801084
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play114801085(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_318_0 = 0
			local var_318_1 = 0.4

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_2 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(114801084).content)

				arg_315_1.text_.text = var_318_2

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 16 <= 0 and var_318_1 or var_318_1 * (utf8.len(var_318_2) / 16)

				if (16 <= 0 and var_318_1 or var_318_1 * (utf8.len(var_318_2) / 16)) > 0 and var_318_1 < var_318_4 then
					arg_315_1.talkMaxDuration = var_318_4

					if var_318_4 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_4 + var_318_0
					end
				end

				arg_315_1.text_.text = var_318_2
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_5 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_5 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_5

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_5 and arg_315_1.time_ < var_318_0 + var_318_5 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play114801085 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 114801085
		arg_319_1.duration_ = 15.2

		local var_319_0 = {
			ja = 15.2,
			ko = 6.433,
			zh = 6.8,
			en = 5.8
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
				arg_319_0:Play114801086(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_322_0 = 0
			local var_322_1 = 0.55

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_2 = arg_319_1:GetWordFromCfg(114801085)
				local var_322_3 = arg_319_1:FormatText(var_322_2.content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 22 <= 0 and var_322_1 or var_322_1 * (utf8.len(var_322_3) / 22)

				if (22 <= 0 and var_322_1 or var_322_1 * (utf8.len(var_322_3) / 22)) > 0 and var_322_1 < var_322_5 then
					arg_319_1.talkMaxDuration = var_322_5

					if var_322_5 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + var_322_0
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801085", "story_v_side_old_114801.awb") ~= 0 then
					local var_322_6 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801085", "story_v_side_old_114801.awb") / 1000

					if var_322_6 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_6 + var_322_0
					end

					if var_322_2.prefab_name ~= "" and arg_319_1.actors_[var_322_2.prefab_name] ~= nil then
						local var_322_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_2.prefab_name].transform, "story_v_side_old_114801", "114801085", "story_v_side_old_114801.awb")

						arg_319_1:RecordAudio("114801085", var_322_7)
						arg_319_1:RecordAudio("114801085", var_322_7)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801085", "story_v_side_old_114801.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801085", "story_v_side_old_114801.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_8 = math.max(var_322_1, arg_319_1.talkMaxDuration)

			if var_322_0 <= arg_319_1.time_ and arg_319_1.time_ < var_322_0 + var_322_8 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_0) / var_322_8

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_0 + var_322_8 and arg_319_1.time_ < var_322_0 + var_322_8 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play114801086 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 114801086
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play114801087(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1148ui_story"]) and arg_323_1.var_.characterEffect1148ui_story == nil then
				arg_323_1.var_.characterEffect1148ui_story = arg_323_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1148ui_story"]) then
				if arg_323_1.var_.characterEffect1148ui_story and not isNil(arg_323_1.actors_["1148ui_story"]) then
					arg_323_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_0)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1148ui_story"]) and arg_323_1.var_.characterEffect1148ui_story then
				arg_323_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_326_1 = 0
			local var_326_2 = 0.075

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_3 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(114801086).content)

				arg_323_1.text_.text = var_326_3

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_5 = 3 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_3) / 3)

				if (3 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_3) / 3)) > 0 and var_326_2 < var_326_5 then
					arg_323_1.talkMaxDuration = var_326_5

					if var_326_5 + var_326_1 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_5 + var_326_1
					end
				end

				arg_323_1.text_.text = var_326_3
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_6 = math.max(var_326_2, arg_323_1.talkMaxDuration)

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_6 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_1) / var_326_6

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_1 + var_326_6 and arg_323_1.time_ < var_326_1 + var_326_6 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play114801087 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 114801087
		arg_327_1.duration_ = 12.67

		local var_327_0 = {
			ja = 12.666,
			ko = 9.166,
			zh = 7.7,
			en = 7.933
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
				arg_327_0:Play114801088(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action446")
			end

			local var_330_0 = arg_327_1.actors_["1148ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1148ui_story == nil then
				arg_327_1.var_.characterEffect1148ui_story = var_330_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_1 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_1 and not isNil(var_330_0) then
				if arg_327_1.var_.characterEffect1148ui_story and not isNil(var_330_0) then
					arg_327_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_1 and arg_327_1.time_ < 0 + var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1148ui_story then
				arg_327_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_330_3 = 0
			local var_330_4 = 0.9

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_3 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_5 = arg_327_1:GetWordFromCfg(114801087)
				local var_330_6 = arg_327_1:FormatText(var_330_5.content)

				arg_327_1.text_.text = var_330_6

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_8 = 36 <= 0 and var_330_4 or var_330_4 * (utf8.len(var_330_6) / 36)

				if (36 <= 0 and var_330_4 or var_330_4 * (utf8.len(var_330_6) / 36)) > 0 and var_330_4 < var_330_8 then
					arg_327_1.talkMaxDuration = var_330_8

					if var_330_8 + var_330_3 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_8 + var_330_3
					end
				end

				arg_327_1.text_.text = var_330_6
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801087", "story_v_side_old_114801.awb") ~= 0 then
					local var_330_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801087", "story_v_side_old_114801.awb") / 1000

					if var_330_9 + var_330_3 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_9 + var_330_3
					end

					if var_330_5.prefab_name ~= "" and arg_327_1.actors_[var_330_5.prefab_name] ~= nil then
						local var_330_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_5.prefab_name].transform, "story_v_side_old_114801", "114801087", "story_v_side_old_114801.awb")

						arg_327_1:RecordAudio("114801087", var_330_10)
						arg_327_1:RecordAudio("114801087", var_330_10)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801087", "story_v_side_old_114801.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801087", "story_v_side_old_114801.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_11 = math.max(var_330_4, arg_327_1.talkMaxDuration)

			if var_330_3 <= arg_327_1.time_ and arg_327_1.time_ < var_330_3 + var_330_11 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_3) / var_330_11

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_3 + var_330_11 and arg_327_1.time_ < var_330_3 + var_330_11 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play114801088 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 114801088
		arg_331_1.duration_ = 10.87

		local var_331_0 = {
			ja = 10.866,
			ko = 8.533,
			zh = 9.1,
			en = 10.533
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
				arg_331_0:Play114801089(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_334_0 = 0
			local var_334_1 = 0.975

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_2 = arg_331_1:GetWordFromCfg(114801088)
				local var_334_3 = arg_331_1:FormatText(var_334_2.content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 39 <= 0 and var_334_1 or var_334_1 * (utf8.len(var_334_3) / 39)

				if (39 <= 0 and var_334_1 or var_334_1 * (utf8.len(var_334_3) / 39)) > 0 and var_334_1 < var_334_5 then
					arg_331_1.talkMaxDuration = var_334_5

					if var_334_5 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801088", "story_v_side_old_114801.awb") ~= 0 then
					local var_334_6 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801088", "story_v_side_old_114801.awb") / 1000

					if var_334_6 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_6 + var_334_0
					end

					if var_334_2.prefab_name ~= "" and arg_331_1.actors_[var_334_2.prefab_name] ~= nil then
						local var_334_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_2.prefab_name].transform, "story_v_side_old_114801", "114801088", "story_v_side_old_114801.awb")

						arg_331_1:RecordAudio("114801088", var_334_7)
						arg_331_1:RecordAudio("114801088", var_334_7)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801088", "story_v_side_old_114801.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801088", "story_v_side_old_114801.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_8 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_8 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_8

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_8 and arg_331_1.time_ < var_334_0 + var_334_8 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play114801089 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 114801089
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play114801090(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1148ui_story"]) and arg_335_1.var_.characterEffect1148ui_story == nil then
				arg_335_1.var_.characterEffect1148ui_story = arg_335_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1148ui_story"]) then
				if arg_335_1.var_.characterEffect1148ui_story and not isNil(arg_335_1.actors_["1148ui_story"]) then
					arg_335_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_0)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1148ui_story"]) and arg_335_1.var_.characterEffect1148ui_story then
				arg_335_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_338_1 = 0
			local var_338_2 = 0.475

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

				local var_338_3 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(114801089).content)

				arg_335_1.text_.text = var_338_3

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 19 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 19)

				if (19 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 19)) > 0 and var_338_2 < var_338_5 then
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
	Play114801090 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 114801090
		arg_339_1.duration_ = 8.73

		local var_339_0 = {
			ja = 5.166,
			ko = 5.933,
			zh = 5.233,
			en = 8.733
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
				arg_339_0:Play114801091(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action467")
			end

			local var_342_0 = arg_339_1.actors_["1148ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1148ui_story == nil then
				arg_339_1.var_.characterEffect1148ui_story = var_342_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_1 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_1 and not isNil(var_342_0) then
				if arg_339_1.var_.characterEffect1148ui_story and not isNil(var_342_0) then
					arg_339_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_1 and arg_339_1.time_ < 0 + var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1148ui_story then
				arg_339_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_342_3 = 0
			local var_342_4 = 0.575

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_3 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_5 = arg_339_1:GetWordFromCfg(114801090)
				local var_342_6 = arg_339_1:FormatText(var_342_5.content)

				arg_339_1.text_.text = var_342_6

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_8 = 23 <= 0 and var_342_4 or var_342_4 * (utf8.len(var_342_6) / 23)

				if (23 <= 0 and var_342_4 or var_342_4 * (utf8.len(var_342_6) / 23)) > 0 and var_342_4 < var_342_8 then
					arg_339_1.talkMaxDuration = var_342_8

					if var_342_8 + var_342_3 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_3
					end
				end

				arg_339_1.text_.text = var_342_6
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801090", "story_v_side_old_114801.awb") ~= 0 then
					local var_342_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801090", "story_v_side_old_114801.awb") / 1000

					if var_342_9 + var_342_3 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_3
					end

					if var_342_5.prefab_name ~= "" and arg_339_1.actors_[var_342_5.prefab_name] ~= nil then
						local var_342_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_5.prefab_name].transform, "story_v_side_old_114801", "114801090", "story_v_side_old_114801.awb")

						arg_339_1:RecordAudio("114801090", var_342_10)
						arg_339_1:RecordAudio("114801090", var_342_10)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801090", "story_v_side_old_114801.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801090", "story_v_side_old_114801.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_11 = math.max(var_342_4, arg_339_1.talkMaxDuration)

			if var_342_3 <= arg_339_1.time_ and arg_339_1.time_ < var_342_3 + var_342_11 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_3) / var_342_11

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_3 + var_342_11 and arg_339_1.time_ < var_342_3 + var_342_11 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play114801091 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 114801091
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play114801092(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1148ui_story"]) and arg_343_1.var_.characterEffect1148ui_story == nil then
				arg_343_1.var_.characterEffect1148ui_story = arg_343_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1148ui_story"]) then
				if arg_343_1.var_.characterEffect1148ui_story and not isNil(arg_343_1.actors_["1148ui_story"]) then
					arg_343_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1148ui_story"]) and arg_343_1.var_.characterEffect1148ui_story then
				arg_343_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_346_1 = 0
			local var_346_2 = 0.25

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_3 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(114801091).content)

				arg_343_1.text_.text = var_346_3

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 10 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_3) / 10)

				if (10 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_3) / 10)) > 0 and var_346_2 < var_346_5 then
					arg_343_1.talkMaxDuration = var_346_5

					if var_346_5 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_3
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_6 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_6 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_6

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_6 and arg_343_1.time_ < var_346_1 + var_346_6 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play114801092 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 114801092
		arg_347_1.duration_ = 4.73

		local var_347_0 = {
			ja = 4.7,
			ko = 2.733,
			zh = 2.5,
			en = 4.733
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
				arg_347_0:Play114801093(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action475")
			end

			local var_350_0 = arg_347_1.actors_["1148ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1148ui_story == nil then
				arg_347_1.var_.characterEffect1148ui_story = var_350_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_1 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_1 and not isNil(var_350_0) then
				if arg_347_1.var_.characterEffect1148ui_story and not isNil(var_350_0) then
					arg_347_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_1 and arg_347_1.time_ < 0 + var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1148ui_story then
				arg_347_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_350_3 = 0
			local var_350_4 = 0.2

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_3 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_5 = arg_347_1:GetWordFromCfg(114801092)
				local var_350_6 = arg_347_1:FormatText(var_350_5.content)

				arg_347_1.text_.text = var_350_6

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_8 = 8 <= 0 and var_350_4 or var_350_4 * (utf8.len(var_350_6) / 8)

				if (8 <= 0 and var_350_4 or var_350_4 * (utf8.len(var_350_6) / 8)) > 0 and var_350_4 < var_350_8 then
					arg_347_1.talkMaxDuration = var_350_8

					if var_350_8 + var_350_3 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_3
					end
				end

				arg_347_1.text_.text = var_350_6
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801092", "story_v_side_old_114801.awb") ~= 0 then
					local var_350_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801092", "story_v_side_old_114801.awb") / 1000

					if var_350_9 + var_350_3 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_9 + var_350_3
					end

					if var_350_5.prefab_name ~= "" and arg_347_1.actors_[var_350_5.prefab_name] ~= nil then
						local var_350_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_5.prefab_name].transform, "story_v_side_old_114801", "114801092", "story_v_side_old_114801.awb")

						arg_347_1:RecordAudio("114801092", var_350_10)
						arg_347_1:RecordAudio("114801092", var_350_10)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801092", "story_v_side_old_114801.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801092", "story_v_side_old_114801.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_11 = math.max(var_350_4, arg_347_1.talkMaxDuration)

			if var_350_3 <= arg_347_1.time_ and arg_347_1.time_ < var_350_3 + var_350_11 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_3) / var_350_11

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_3 + var_350_11 and arg_347_1.time_ < var_350_3 + var_350_11 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play114801093 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 114801093
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play114801094(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1148ui_story"]) and arg_351_1.var_.characterEffect1148ui_story == nil then
				arg_351_1.var_.characterEffect1148ui_story = arg_351_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1148ui_story"]) then
				if arg_351_1.var_.characterEffect1148ui_story and not isNil(arg_351_1.actors_["1148ui_story"]) then
					arg_351_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1148ui_story"]) and arg_351_1.var_.characterEffect1148ui_story then
				arg_351_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_354_1 = 0
			local var_354_2 = 0.175

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(114801093).content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 7 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_3) / 7)

				if (7 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_3) / 7)) > 0 and var_354_2 < var_354_5 then
					arg_351_1.talkMaxDuration = var_354_5

					if var_354_5 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + var_354_1
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_6 = math.max(var_354_2, arg_351_1.talkMaxDuration)

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_6 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_1) / var_354_6

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_1 + var_354_6 and arg_351_1.time_ < var_354_1 + var_354_6 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play114801094 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 114801094
		arg_355_1.duration_ = 7.77

		local var_355_0 = {
			ja = 5.8,
			ko = 6.8,
			zh = 7.766,
			en = 6.3
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play114801095(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action454")
			end

			local var_358_0 = arg_355_1.actors_["1148ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1148ui_story == nil then
				arg_355_1.var_.characterEffect1148ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_1 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_1 and not isNil(var_358_0) then
				if arg_355_1.var_.characterEffect1148ui_story and not isNil(var_358_0) then
					arg_355_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_1 and arg_355_1.time_ < 0 + var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1148ui_story then
				arg_355_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_358_3 = 0
			local var_358_4 = 1

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_3 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_5 = arg_355_1:GetWordFromCfg(114801094)
				local var_358_6 = arg_355_1:FormatText(var_358_5.content)

				arg_355_1.text_.text = var_358_6

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_8 = 40 <= 0 and var_358_4 or var_358_4 * (utf8.len(var_358_6) / 40)

				if (40 <= 0 and var_358_4 or var_358_4 * (utf8.len(var_358_6) / 40)) > 0 and var_358_4 < var_358_8 then
					arg_355_1.talkMaxDuration = var_358_8

					if var_358_8 + var_358_3 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_8 + var_358_3
					end
				end

				arg_355_1.text_.text = var_358_6
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801094", "story_v_side_old_114801.awb") ~= 0 then
					local var_358_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801094", "story_v_side_old_114801.awb") / 1000

					if var_358_9 + var_358_3 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_3
					end

					if var_358_5.prefab_name ~= "" and arg_355_1.actors_[var_358_5.prefab_name] ~= nil then
						local var_358_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_5.prefab_name].transform, "story_v_side_old_114801", "114801094", "story_v_side_old_114801.awb")

						arg_355_1:RecordAudio("114801094", var_358_10)
						arg_355_1:RecordAudio("114801094", var_358_10)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801094", "story_v_side_old_114801.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801094", "story_v_side_old_114801.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_11 = math.max(var_358_4, arg_355_1.talkMaxDuration)

			if var_358_3 <= arg_355_1.time_ and arg_355_1.time_ < var_358_3 + var_358_11 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_3) / var_358_11

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_3 + var_358_11 and arg_355_1.time_ < var_358_3 + var_358_11 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play114801095 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 114801095
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play114801096(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["1148ui_story"]) and arg_359_1.var_.characterEffect1148ui_story == nil then
				arg_359_1.var_.characterEffect1148ui_story = arg_359_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.2

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["1148ui_story"]) then
				if arg_359_1.var_.characterEffect1148ui_story and not isNil(arg_359_1.actors_["1148ui_story"]) then
					arg_359_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_0)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["1148ui_story"]) and arg_359_1.var_.characterEffect1148ui_story then
				arg_359_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_362_1 = 0
			local var_362_2 = 0.125

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_3 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(114801095).content)

				arg_359_1.text_.text = var_362_3

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 5 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_3) / 5)

				if (5 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_3) / 5)) > 0 and var_362_2 < var_362_5 then
					arg_359_1.talkMaxDuration = var_362_5

					if var_362_5 + var_362_1 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + var_362_1
					end
				end

				arg_359_1.text_.text = var_362_3
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_6 = math.max(var_362_2, arg_359_1.talkMaxDuration)

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_6 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_1) / var_362_6

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_1 + var_362_6 and arg_359_1.time_ < var_362_1 + var_362_6 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play114801096 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 114801096
		arg_363_1.duration_ = 14.8

		local var_363_0 = {
			ja = 10.433,
			ko = 11.133,
			zh = 12,
			en = 14.8
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play114801097(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action445")
			end

			local var_366_0 = arg_363_1.actors_["1148ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1148ui_story == nil then
				arg_363_1.var_.characterEffect1148ui_story = var_366_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_1 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_1 and not isNil(var_366_0) then
				if arg_363_1.var_.characterEffect1148ui_story and not isNil(var_366_0) then
					arg_363_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_1 and arg_363_1.time_ < 0 + var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1148ui_story then
				arg_363_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_366_3 = 0
			local var_366_4 = 1.35

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_3 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_5 = arg_363_1:GetWordFromCfg(114801096)
				local var_366_6 = arg_363_1:FormatText(var_366_5.content)

				arg_363_1.text_.text = var_366_6

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_8 = 54 <= 0 and var_366_4 or var_366_4 * (utf8.len(var_366_6) / 54)

				if (54 <= 0 and var_366_4 or var_366_4 * (utf8.len(var_366_6) / 54)) > 0 and var_366_4 < var_366_8 then
					arg_363_1.talkMaxDuration = var_366_8

					if var_366_8 + var_366_3 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_3
					end
				end

				arg_363_1.text_.text = var_366_6
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801096", "story_v_side_old_114801.awb") ~= 0 then
					local var_366_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801096", "story_v_side_old_114801.awb") / 1000

					if var_366_9 + var_366_3 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_9 + var_366_3
					end

					if var_366_5.prefab_name ~= "" and arg_363_1.actors_[var_366_5.prefab_name] ~= nil then
						local var_366_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_5.prefab_name].transform, "story_v_side_old_114801", "114801096", "story_v_side_old_114801.awb")

						arg_363_1:RecordAudio("114801096", var_366_10)
						arg_363_1:RecordAudio("114801096", var_366_10)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801096", "story_v_side_old_114801.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801096", "story_v_side_old_114801.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_11 = math.max(var_366_4, arg_363_1.talkMaxDuration)

			if var_366_3 <= arg_363_1.time_ and arg_363_1.time_ < var_366_3 + var_366_11 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_3) / var_366_11

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_3 + var_366_11 and arg_363_1.time_ < var_366_3 + var_366_11 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play114801097 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 114801097
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
			arg_367_1.auto_ = false
		end

		function arg_367_1.playNext_(arg_369_0)
			arg_367_1.onStoryFinished_()
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_370_0 = 0
			local var_370_1 = 0.7

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_2 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(114801097).content)

				arg_367_1.text_.text = var_370_2

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 28 <= 0 and var_370_1 or var_370_1 * (utf8.len(var_370_2) / 28)

				if (28 <= 0 and var_370_1 or var_370_1 * (utf8.len(var_370_2) / 28)) > 0 and var_370_1 < var_370_4 then
					arg_367_1.talkMaxDuration = var_370_4

					if var_370_4 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_4 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_2
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_5 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_5 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_5

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_5 and arg_367_1.time_ < var_370_0 + var_370_5 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play114801033 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 114801033
		arg_371_1.duration_ = 7.2

		local var_371_0 = {
			ja = 7.2,
			ko = 4.666,
			zh = 4.266,
			en = 4.066
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play114801034(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if arg_371_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_374_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_371_1.stage_.transform)

				var_374_0.name = "1148ui_story"
				var_374_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_371_1.actors_["1148ui_story"] = var_374_0

				local var_374_1 = var_374_0:GetComponentInChildren(typeof(CharacterEffect))

				var_374_1.enabled = true

				local var_374_2 = GameObjectTools.GetOrAddComponent(var_374_0, typeof(DynamicBoneHelper))

				if var_374_2 then
					var_374_2:EnableDynamicBone(false)
				end

				arg_371_1:ShowWeapon(var_374_1.transform, false)

				arg_371_1.var_["1148ui_story" .. "Animator"] = var_374_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_371_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_371_1.var_["1148ui_story" .. "LipSync"] = var_374_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action437")
			end

			local var_374_3 = "1148ui_story"

			if arg_371_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_374_4 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_371_1.stage_.transform)

				var_374_4.name = var_374_3
				var_374_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_371_1.actors_[var_374_3] = var_374_4

				local var_374_5 = var_374_4:GetComponentInChildren(typeof(CharacterEffect))

				var_374_5.enabled = true

				local var_374_6 = GameObjectTools.GetOrAddComponent(var_374_4, typeof(DynamicBoneHelper))

				if var_374_6 then
					var_374_6:EnableDynamicBone(false)
				end

				arg_371_1:ShowWeapon(var_374_5.transform, false)

				arg_371_1.var_[var_374_3 .. "Animator"] = var_374_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_371_1.var_[var_374_3 .. "Animator"].applyRootMotion = true
				arg_371_1.var_[var_374_3 .. "LipSync"] = var_374_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_374_7 = 0
			local var_374_8 = 0.275

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_7 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_9 = arg_371_1:GetWordFromCfg(114801033)
				local var_374_10 = arg_371_1:FormatText(var_374_9.content)

				arg_371_1.text_.text = var_374_10

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_12 = 17 <= 0 and var_374_8 or var_374_8 * (utf8.len(var_374_10) / 17)

				if (17 <= 0 and var_374_8 or var_374_8 * (utf8.len(var_374_10) / 17)) > 0 and var_374_8 < var_374_12 then
					arg_371_1.talkMaxDuration = var_374_12

					if var_374_12 + var_374_7 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_12 + var_374_7
					end
				end

				arg_371_1.text_.text = var_374_10
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801033", "story_v_side_old_114801.awb") ~= 0 then
					local var_374_13 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801033", "story_v_side_old_114801.awb") / 1000

					if var_374_13 + var_374_7 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_13 + var_374_7
					end

					if var_374_9.prefab_name ~= "" and arg_371_1.actors_[var_374_9.prefab_name] ~= nil then
						local var_374_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_9.prefab_name].transform, "story_v_side_old_114801", "114801033", "story_v_side_old_114801.awb")

						arg_371_1:RecordAudio("114801033", var_374_14)
						arg_371_1:RecordAudio("114801033", var_374_14)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801033", "story_v_side_old_114801.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801033", "story_v_side_old_114801.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_15 = math.max(var_374_8, arg_371_1.talkMaxDuration)

			if var_374_7 <= arg_371_1.time_ and arg_371_1.time_ < var_374_7 + var_374_15 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_7) / var_374_15

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_7 + var_374_15 and arg_371_1.time_ < var_374_7 + var_374_15 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play114801034 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 114801034
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play114801035(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_378_0 = arg_375_1.actors_["1148ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect1148ui_story == nil then
				arg_375_1.var_.characterEffect1148ui_story = var_378_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_1 = 0.2

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_1 and not isNil(var_378_0) then
				if arg_375_1.var_.characterEffect1148ui_story and not isNil(var_378_0) then
					arg_375_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_375_1.time_ - 0) / var_378_1)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_1 and arg_375_1.time_ < 0 + var_378_1 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect1148ui_story then
				arg_375_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_378_2 = 0
			local var_378_3 = 0.95

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_2 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_4 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(114801034).content)

				arg_375_1.text_.text = var_378_4

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_6 = 38 <= 0 and var_378_3 or var_378_3 * (utf8.len(var_378_4) / 38)

				if (38 <= 0 and var_378_3 or var_378_3 * (utf8.len(var_378_4) / 38)) > 0 and var_378_3 < var_378_6 then
					arg_375_1.talkMaxDuration = var_378_6

					if var_378_6 + var_378_2 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_6 + var_378_2
					end
				end

				arg_375_1.text_.text = var_378_4
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_7 = math.max(var_378_3, arg_375_1.talkMaxDuration)

			if var_378_2 <= arg_375_1.time_ and arg_375_1.time_ < var_378_2 + var_378_7 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_2) / var_378_7

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_2 + var_378_7 and arg_375_1.time_ < var_378_2 + var_378_7 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play114801035 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 114801035
		arg_379_1.duration_ = 13.63

		local var_379_0 = {
			ja = 13.633,
			ko = 7.766,
			zh = 6.633,
			en = 9.366
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
				arg_379_0:Play114801036(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_382_0 = arg_379_1.actors_["1148ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1148ui_story == nil then
				arg_379_1.var_.characterEffect1148ui_story = var_382_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_1 = 2

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_1 and not isNil(var_382_0) then
				if arg_379_1.var_.characterEffect1148ui_story and not isNil(var_382_0) then
					arg_379_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_1 and arg_379_1.time_ < 0 + var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1148ui_story then
				arg_379_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_382_3 = 0
			local var_382_4 = 0.775

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_3 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_5 = arg_379_1:GetWordFromCfg(114801035)
				local var_382_6 = arg_379_1:FormatText(var_382_5.content)

				arg_379_1.text_.text = var_382_6

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_8 = 31 <= 0 and var_382_4 or var_382_4 * (utf8.len(var_382_6) / 31)

				if (31 <= 0 and var_382_4 or var_382_4 * (utf8.len(var_382_6) / 31)) > 0 and var_382_4 < var_382_8 then
					arg_379_1.talkMaxDuration = var_382_8

					if var_382_8 + var_382_3 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_8 + var_382_3
					end
				end

				arg_379_1.text_.text = var_382_6
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114801", "114801035", "story_v_side_old_114801.awb") ~= 0 then
					local var_382_9 = manager.audio:GetVoiceLength("story_v_side_old_114801", "114801035", "story_v_side_old_114801.awb") / 1000

					if var_382_9 + var_382_3 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_9 + var_382_3
					end

					if var_382_5.prefab_name ~= "" and arg_379_1.actors_[var_382_5.prefab_name] ~= nil then
						local var_382_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_5.prefab_name].transform, "story_v_side_old_114801", "114801035", "story_v_side_old_114801.awb")

						arg_379_1:RecordAudio("114801035", var_382_10)
						arg_379_1:RecordAudio("114801035", var_382_10)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_old_114801", "114801035", "story_v_side_old_114801.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_old_114801", "114801035", "story_v_side_old_114801.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_11 = math.max(var_382_4, arg_379_1.talkMaxDuration)

			if var_382_3 <= arg_379_1.time_ and arg_379_1.time_ < var_382_3 + var_382_11 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_3) / var_382_11

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_3 + var_382_11 and arg_379_1.time_ < var_382_3 + var_382_11 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play114801036 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 114801036
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play114801037(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_386_0 = arg_383_1.actors_["1148ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1148ui_story == nil then
				arg_383_1.var_.characterEffect1148ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_1 = 0.2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_1 and not isNil(var_386_0) then
				if arg_383_1.var_.characterEffect1148ui_story and not isNil(var_386_0) then
					arg_383_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_1)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_1 and arg_383_1.time_ < 0 + var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1148ui_story then
				arg_383_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_386_2 = 0
			local var_386_3 = 0.5

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_2 + arg_386_0 then
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

				local var_386_4 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(114801036).content)

				arg_383_1.text_.text = var_386_4

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_6 = 20 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_4) / 20)

				if (20 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_4) / 20)) > 0 and var_386_3 < var_386_6 then
					arg_383_1.talkMaxDuration = var_386_6

					if var_386_6 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_6 + var_386_2
					end
				end

				arg_383_1.text_.text = var_386_4
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_7 = math.max(var_386_3, arg_383_1.talkMaxDuration)

			if var_386_2 <= arg_383_1.time_ and arg_383_1.time_ < var_386_2 + var_386_7 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_2) / var_386_7

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_2 + var_386_7 and arg_383_1.time_ < var_386_2 + var_386_7 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/ST01"
	},
	voices = {
		"story_v_side_old_114801.awb"
	}
}
