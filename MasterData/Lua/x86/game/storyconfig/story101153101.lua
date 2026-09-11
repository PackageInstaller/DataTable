return {
	Play115311001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115311001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115311002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST22a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22a")
				var_4_0.name = "ST22a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST22a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST22a

				arg_1_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST22a" then
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
				arg_1_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(115311001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 5 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 5)

				if (5 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 5)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play115311002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115311002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play115311003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.025

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(115311002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 41 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 41)

				if (41 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 41)) > 0 and var_12_0 < var_12_3 then
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
	Play115311003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115311003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play115311004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.225

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(115311003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 49 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 49)

				if (49 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 49)) > 0 and var_16_0 < var_16_3 then
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
	Play115311004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115311004
		arg_17_1.duration_ = 11.37

		local var_17_0 = {
			ja = 9.933,
			ko = 10.533,
			zh = 8.933,
			en = 11.366
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
				arg_17_0:Play115311005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.625

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[224].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(115311004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 25 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 25)

				if (25 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 25)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311004", "story_v_out_115311.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311004", "story_v_out_115311.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_115311", "115311004", "story_v_out_115311.awb")

						arg_17_1:RecordAudio("115311004", var_20_6)
						arg_17_1:RecordAudio("115311004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_115311", "115311004", "story_v_out_115311.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_115311", "115311004", "story_v_out_115311.awb")
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
	Play115311005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115311005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play115311006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.05

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(115311005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 42 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 42)

				if (42 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 42)) > 0 and var_24_0 < var_24_3 then
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
	Play115311006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 115311006
		arg_25_1.duration_ = 9.2

		local var_25_0 = {
			ja = 7.766,
			ko = 8.2,
			zh = 7.066,
			en = 9.2
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
				arg_25_0:Play115311007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.85

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(115311006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 34 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 34)

				if (34 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 34)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311006", "story_v_out_115311.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311006", "story_v_out_115311.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_115311", "115311006", "story_v_out_115311.awb")

						arg_25_1:RecordAudio("115311006", var_28_6)
						arg_25_1:RecordAudio("115311006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_115311", "115311006", "story_v_out_115311.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_115311", "115311006", "story_v_out_115311.awb")
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
	Play115311007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 115311007
		arg_29_1.duration_ = 6.87

		local var_29_0 = {
			ja = 6.6,
			ko = 6.7,
			zh = 5.4,
			en = 6.866
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
				arg_29_0:Play115311008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.725

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[105].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(115311007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 29 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 29)

				if (29 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 29)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311007", "story_v_out_115311.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311007", "story_v_out_115311.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_115311", "115311007", "story_v_out_115311.awb")

						arg_29_1:RecordAudio("115311007", var_32_6)
						arg_29_1:RecordAudio("115311007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_115311", "115311007", "story_v_out_115311.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_115311", "115311007", "story_v_out_115311.awb")
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
	Play115311008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 115311008
		arg_33_1.duration_ = 9.17

		local var_33_0 = {
			ja = 8.2,
			ko = 7.533,
			zh = 9.166,
			en = 8.3
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
				arg_33_0:Play115311009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.875

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[105].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(115311008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 35 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 35)

				if (35 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 35)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311008", "story_v_out_115311.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311008", "story_v_out_115311.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_115311", "115311008", "story_v_out_115311.awb")

						arg_33_1:RecordAudio("115311008", var_36_6)
						arg_33_1:RecordAudio("115311008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_115311", "115311008", "story_v_out_115311.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_115311", "115311008", "story_v_out_115311.awb")
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
	Play115311009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 115311009
		arg_37_1.duration_ = 9.53

		local var_37_0 = {
			ja = 9.3,
			ko = 9.533,
			zh = 9,
			en = 9.533
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
				arg_37_0:Play115311010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.975

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(115311009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 39 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 39)

				if (39 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 39)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311009", "story_v_out_115311.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311009", "story_v_out_115311.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_115311", "115311009", "story_v_out_115311.awb")

						arg_37_1:RecordAudio("115311009", var_40_6)
						arg_37_1:RecordAudio("115311009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_115311", "115311009", "story_v_out_115311.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_115311", "115311009", "story_v_out_115311.awb")
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
	Play115311010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 115311010
		arg_41_1.duration_ = 11.4

		local var_41_0 = {
			ja = 8.7,
			ko = 10.766,
			zh = 8.8,
			en = 11.4
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
				arg_41_0:Play115311011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.975

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(115311010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 39 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 39)

				if (39 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 39)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311010", "story_v_out_115311.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311010", "story_v_out_115311.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_115311", "115311010", "story_v_out_115311.awb")

						arg_41_1:RecordAudio("115311010", var_44_6)
						arg_41_1:RecordAudio("115311010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_115311", "115311010", "story_v_out_115311.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_115311", "115311010", "story_v_out_115311.awb")
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
	Play115311011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 115311011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play115311012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.125

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(115311011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 45 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 45)

				if (45 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 45)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play115311012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 115311012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play115311013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.7

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(115311012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 28 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 28)

				if (28 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 28)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play115311013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 115311013
		arg_53_1.duration_ = 4.57

		local var_53_0 = {
			ja = 3.5,
			ko = 4.566,
			zh = 3.7,
			en = 4.333
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
				arg_53_0:Play115311014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_56_0 = 0.6

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				local var_56_1, var_56_2 = math.modf((arg_53_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_56_2 * 0.13, var_56_2 * 0.13, var_56_2 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				manager.ui.mainCamera.transform.localPosition = arg_53_1.var_.shakeOldPos
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:AudioAction("stop", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks_loop", "")
			end

			local var_56_4 = 0

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			if arg_53_1.time_ >= var_56_4 + 0.6 and arg_53_1.time_ < var_56_4 + 0.6 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_5 = 0
			local var_56_6 = 0.375

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[306].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(115311013)
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

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311013", "story_v_out_115311.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_115311", "115311013", "story_v_out_115311.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_115311", "115311013", "story_v_out_115311.awb")

						arg_53_1:RecordAudio("115311013", var_56_12)
						arg_53_1:RecordAudio("115311013", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_115311", "115311013", "story_v_out_115311.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_115311", "115311013", "story_v_out_115311.awb")
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
	Play115311014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 115311014
		arg_57_1.duration_ = 4.3

		local var_57_0 = {
			ja = 3.366,
			ko = 4.3,
			zh = 2.733,
			en = 3.8
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
				arg_57_0:Play115311015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_60_0 = 0.6

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				local var_60_1, var_60_2 = math.modf((arg_57_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_60_2 * 0.13, var_60_2 * 0.13, var_60_2 * 0.13) + arg_57_1.var_.shakeOldPos
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				manager.ui.mainCamera.transform.localPosition = arg_57_1.var_.shakeOldPos
			end

			local var_60_3 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			if arg_57_1.time_ >= var_60_3 + 0.6 and arg_57_1.time_ < var_60_3 + 0.6 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			local var_60_4 = 0
			local var_60_5 = 0.325

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[306].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(115311014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 13 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 13)

				if (13 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 13)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311014", "story_v_out_115311.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_115311", "115311014", "story_v_out_115311.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_115311", "115311014", "story_v_out_115311.awb")

						arg_57_1:RecordAudio("115311014", var_60_11)
						arg_57_1:RecordAudio("115311014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_115311", "115311014", "story_v_out_115311.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_115311", "115311014", "story_v_out_115311.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play115311015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 115311015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play115311016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.575

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(115311015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 63 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 63)

				if (63 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 63)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play115311016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 115311016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play115311017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.575

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

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(115311016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 23 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 23)

				if (23 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 23)) > 0 and var_68_0 < var_68_3 then
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
	Play115311017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 115311017
		arg_69_1.duration_ = 5.27

		local var_69_0 = {
			ja = 5.266,
			ko = 4.2,
			zh = 5.1,
			en = 4.4
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
				arg_69_0:Play115311018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.525

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:GetWordFromCfg(115311017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 21 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 21)

				if (21 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 21)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311017", "story_v_out_115311.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311017", "story_v_out_115311.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_115311", "115311017", "story_v_out_115311.awb")

						arg_69_1:RecordAudio("115311017", var_72_6)
						arg_69_1:RecordAudio("115311017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_115311", "115311017", "story_v_out_115311.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_115311", "115311017", "story_v_out_115311.awb")
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
	Play115311018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 115311018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play115311019(arg_73_1)
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

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(115311018).content)

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
	Play115311019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 115311019
		arg_77_1.duration_ = 3.3

		local var_77_0 = {
			ja = 3.3,
			ko = 2.2,
			zh = 2.166,
			en = 2.2
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play115311020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if arg_77_1.actors_["10030"] == nil then
				local var_80_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10030")

				if not isNil(var_80_0) then
					local var_80_1 = Object.Instantiate(var_80_0, arg_77_1.canvasGo_.transform)

					var_80_1.transform:SetSiblingIndex(1)

					var_80_1.name = "10030"
					var_80_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_77_1.actors_["10030"] = var_80_1

					if arg_77_1.isInRecall_ then
						for iter_80_0, iter_80_1 in ipairs((var_80_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_80_1.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_80_2 = arg_77_1.actors_["10030"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10030 = var_80_2.localPosition
				var_80_2.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10030", 3)

				for iter_80_2 = 0, var_80_2.childCount - 1 do
					local var_80_3 = var_80_2:GetChild(iter_80_2)

					if var_80_3.name == "split_2" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				var_80_2.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_77_1.time_ - 0) / var_80_4)
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				var_80_2.localPosition = Vector3.New(0, -390, 150)
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				local var_80_5 = arg_77_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_80_5 then
					arg_77_1.var_.alphaOldValue10030 = var_80_5.alpha
					arg_77_1.var_.characterEffect10030 = var_80_5
				end

				arg_77_1.var_.alphaOldValue10030 = 0
			end

			local var_80_6 = 0.5

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 then
				if arg_77_1.var_.characterEffect10030 then
					arg_77_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_77_1.var_.alphaOldValue10030, 1, (arg_77_1.time_ - 0) / var_80_6)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 and arg_77_1.var_.characterEffect10030 then
				arg_77_1.var_.characterEffect10030.alpha = 1
			end

			local var_80_7 = arg_77_1.actors_["10030"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10030 == nil then
				arg_77_1.var_.actorSpriteComps10030 = var_80_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_8 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_8 and not isNil(var_80_7) then
				if arg_77_1.var_.actorSpriteComps10030 then
					for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_80_4 then
							if arg_77_1.isInRecall_ then
								iter_80_4.color = Color.New(Mathf.Lerp(iter_80_4.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_8), Mathf.Lerp(iter_80_4.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_8), (Mathf.Lerp(iter_80_4.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_8)))
							else
								local var_80_9 = Mathf.Lerp(iter_80_4.color.r, 1, (arg_77_1.time_ - 0) / var_80_8)

								iter_80_4.color = Color.New(var_80_9, var_80_9, var_80_9)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_8 and arg_77_1.time_ < 0 + var_80_8 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10030 then
				for iter_80_5, iter_80_6 in pairs(arg_77_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_80_6 then
						iter_80_6.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10030 = nil
			end

			local var_80_10 = 0
			local var_80_11 = 0.175

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_12 = arg_77_1:GetWordFromCfg(115311019)
				local var_80_13 = arg_77_1:FormatText(var_80_12.content)

				arg_77_1.text_.text = var_80_13

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_15 = 7 <= 0 and var_80_11 or var_80_11 * (utf8.len(var_80_13) / 7)

				if (7 <= 0 and var_80_11 or var_80_11 * (utf8.len(var_80_13) / 7)) > 0 and var_80_11 < var_80_15 then
					arg_77_1.talkMaxDuration = var_80_15

					if var_80_15 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_15 + var_80_10
					end
				end

				arg_77_1.text_.text = var_80_13
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311019", "story_v_out_115311.awb") ~= 0 then
					local var_80_16 = manager.audio:GetVoiceLength("story_v_out_115311", "115311019", "story_v_out_115311.awb") / 1000

					if var_80_16 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_10
					end

					if var_80_12.prefab_name ~= "" and arg_77_1.actors_[var_80_12.prefab_name] ~= nil then
						local var_80_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_12.prefab_name].transform, "story_v_out_115311", "115311019", "story_v_out_115311.awb")

						arg_77_1:RecordAudio("115311019", var_80_17)
						arg_77_1:RecordAudio("115311019", var_80_17)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_115311", "115311019", "story_v_out_115311.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_115311", "115311019", "story_v_out_115311.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_18 = math.max(var_80_11, arg_77_1.talkMaxDuration)

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_18 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_10) / var_80_18

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_10 + var_80_18 and arg_77_1.time_ < var_80_10 + var_80_18 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play115311020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 115311020
		arg_81_1.duration_ = 4.97

		local var_81_0 = {
			ja = 4.966,
			ko = 4.966,
			zh = 4.2,
			en = 4.933
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
				arg_81_0:Play115311021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10030"]) and arg_81_1.var_.actorSpriteComps10030 == nil then
				arg_81_1.var_.actorSpriteComps10030 = arg_81_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10030"]) then
				if arg_81_1.var_.actorSpriteComps10030 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								iter_84_1.color = Color.New(Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_0), Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_0), (Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_0)))
							else
								local var_84_1 = Mathf.Lerp(iter_84_1.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_0)

								iter_84_1.color = Color.New(var_84_1, var_84_1, var_84_1)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10030"]) and arg_81_1.var_.actorSpriteComps10030 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10030 = nil
			end

			local var_84_2 = 0
			local var_84_3 = 0.525

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_4 = arg_81_1:GetWordFromCfg(115311020)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 21 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 21)

				if (21 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 21)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311020", "story_v_out_115311.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311020", "story_v_out_115311.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_115311", "115311020", "story_v_out_115311.awb")

						arg_81_1:RecordAudio("115311020", var_84_9)
						arg_81_1:RecordAudio("115311020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_115311", "115311020", "story_v_out_115311.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_115311", "115311020", "story_v_out_115311.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_10 and arg_81_1.time_ < var_84_2 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play115311021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 115311021
		arg_85_1.duration_ = 2.37

		local var_85_0 = {
			ja = 1.6,
			ko = 1.866,
			zh = 2.366,
			en = 1.9
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
				arg_85_0:Play115311022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.175

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[105].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:GetWordFromCfg(115311021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 7 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 7)

				if (7 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 7)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311021", "story_v_out_115311.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311021", "story_v_out_115311.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_115311", "115311021", "story_v_out_115311.awb")

						arg_85_1:RecordAudio("115311021", var_88_6)
						arg_85_1:RecordAudio("115311021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_115311", "115311021", "story_v_out_115311.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_115311", "115311021", "story_v_out_115311.awb")
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
	Play115311022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 115311022
		arg_89_1.duration_ = 4.4

		local var_89_0 = {
			ja = 3.866,
			ko = 3.9,
			zh = 4.4,
			en = 4.366
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play115311023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10030 = arg_89_1.actors_["10030"].transform.localPosition
				arg_89_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10030", 3)

				for iter_92_0 = 0, arg_89_1.actors_["10030"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["10030"].transform:GetChild(iter_92_0)

					if var_92_0.name == "split_3" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_92_2 = arg_89_1.actors_["10030"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10030 == nil then
				arg_89_1.var_.actorSpriteComps10030 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_3 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.actorSpriteComps10030 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_92_2 then
							if arg_89_1.isInRecall_ then
								iter_92_2.color = Color.New(Mathf.Lerp(iter_92_2.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_3), Mathf.Lerp(iter_92_2.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_3), (Mathf.Lerp(iter_92_2.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_3)))
							else
								local var_92_4 = Mathf.Lerp(iter_92_2.color.r, 1, (arg_89_1.time_ - 0) / var_92_3)

								iter_92_2.color = Color.New(var_92_4, var_92_4, var_92_4)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10030 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_92_4 then
						iter_92_4.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps10030 = nil
			end

			local var_92_5 = 0
			local var_92_6 = 0.3

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_7 = arg_89_1:GetWordFromCfg(115311022)
				local var_92_8 = arg_89_1:FormatText(var_92_7.content)

				arg_89_1.text_.text = var_92_8

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 12 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_8) / 12)

				if (12 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_8) / 12)) > 0 and var_92_6 < var_92_10 then
					arg_89_1.talkMaxDuration = var_92_10

					if var_92_10 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_5
					end
				end

				arg_89_1.text_.text = var_92_8
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311022", "story_v_out_115311.awb") ~= 0 then
					local var_92_11 = manager.audio:GetVoiceLength("story_v_out_115311", "115311022", "story_v_out_115311.awb") / 1000

					if var_92_11 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_5
					end

					if var_92_7.prefab_name ~= "" and arg_89_1.actors_[var_92_7.prefab_name] ~= nil then
						local var_92_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_7.prefab_name].transform, "story_v_out_115311", "115311022", "story_v_out_115311.awb")

						arg_89_1:RecordAudio("115311022", var_92_12)
						arg_89_1:RecordAudio("115311022", var_92_12)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_115311", "115311022", "story_v_out_115311.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_115311", "115311022", "story_v_out_115311.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_6, arg_89_1.talkMaxDuration)

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_5) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_5 + var_92_13 and arg_89_1.time_ < var_92_5 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play115311023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 115311023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play115311024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10030"]) and arg_93_1.var_.actorSpriteComps10030 == nil then
				arg_93_1.var_.actorSpriteComps10030 = arg_93_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10030"]) then
				if arg_93_1.var_.actorSpriteComps10030 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								iter_96_1.color = Color.New(Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_0), Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_0), (Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_0)))
							else
								local var_96_1 = Mathf.Lerp(iter_96_1.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_0)

								iter_96_1.color = Color.New(var_96_1, var_96_1, var_96_1)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10030"]) and arg_93_1.var_.actorSpriteComps10030 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10030 = nil
			end

			local var_96_2 = 0
			local var_96_3 = 0.8

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(115311023).content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 32 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_4) / 32)

				if (32 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_4) / 32)) > 0 and var_96_3 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_7 and arg_93_1.time_ < var_96_2 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play115311024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 115311024
		arg_97_1.duration_ = 10.73

		local var_97_0 = {
			ja = 10.2,
			ko = 7.7,
			zh = 7.033,
			en = 10.733
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
				arg_97_0:Play115311025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10030 = arg_97_1.actors_["10030"].transform.localPosition
				arg_97_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10030", 3)

				for iter_100_0 = 0, arg_97_1.actors_["10030"].transform.childCount - 1 do
					local var_100_0 = arg_97_1.actors_["10030"].transform:GetChild(iter_100_0)

					if var_100_0.name == "split_2" or not string.find(var_100_0.name, "split") then
						var_100_0.gameObject:SetActive(true)
					else
						var_100_0.gameObject:SetActive(false)
					end
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_97_1.time_ - 0) / var_100_1)
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_100_2 = arg_97_1.actors_["10030"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10030 == nil then
				arg_97_1.var_.actorSpriteComps10030 = var_100_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_3 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.actorSpriteComps10030 then
					for iter_100_1, iter_100_2 in pairs(arg_97_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_100_2 then
							if arg_97_1.isInRecall_ then
								iter_100_2.color = Color.New(Mathf.Lerp(iter_100_2.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_3), Mathf.Lerp(iter_100_2.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_3), (Mathf.Lerp(iter_100_2.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_3)))
							else
								local var_100_4 = Mathf.Lerp(iter_100_2.color.r, 1, (arg_97_1.time_ - 0) / var_100_3)

								iter_100_2.color = Color.New(var_100_4, var_100_4, var_100_4)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10030 then
				for iter_100_3, iter_100_4 in pairs(arg_97_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_100_4 then
						iter_100_4.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps10030 = nil
			end

			local var_100_5 = 0
			local var_100_6 = 0.75

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_7 = arg_97_1:GetWordFromCfg(115311024)
				local var_100_8 = arg_97_1:FormatText(var_100_7.content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 29 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 29)

				if (29 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 29)) > 0 and var_100_6 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311024", "story_v_out_115311.awb") ~= 0 then
					local var_100_11 = manager.audio:GetVoiceLength("story_v_out_115311", "115311024", "story_v_out_115311.awb") / 1000

					if var_100_11 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_5
					end

					if var_100_7.prefab_name ~= "" and arg_97_1.actors_[var_100_7.prefab_name] ~= nil then
						local var_100_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_7.prefab_name].transform, "story_v_out_115311", "115311024", "story_v_out_115311.awb")

						arg_97_1:RecordAudio("115311024", var_100_12)
						arg_97_1:RecordAudio("115311024", var_100_12)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_115311", "115311024", "story_v_out_115311.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_115311", "115311024", "story_v_out_115311.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_13 and arg_97_1.time_ < var_100_5 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play115311025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 115311025
		arg_101_1.duration_ = 2.47

		local var_101_0 = {
			ja = 1.333,
			ko = 2.466,
			zh = 2.066,
			en = 2.1
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
				arg_101_0:Play115311026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10030"]) and arg_101_1.var_.actorSpriteComps10030 == nil then
				arg_101_1.var_.actorSpriteComps10030 = arg_101_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10030"]) then
				if arg_101_1.var_.actorSpriteComps10030 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								iter_104_1.color = Color.New(Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_0), Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_0), (Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_0)))
							else
								local var_104_1 = Mathf.Lerp(iter_104_1.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_0)

								iter_104_1.color = Color.New(var_104_1, var_104_1, var_104_1)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10030"]) and arg_101_1.var_.actorSpriteComps10030 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_104_3 then
						iter_104_3.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps10030 = nil
			end

			local var_104_2 = 0
			local var_104_3 = 0.275

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[105].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_4 = arg_101_1:GetWordFromCfg(115311025)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 11 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 11)

				if (11 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 11)) > 0 and var_104_3 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311025", "story_v_out_115311.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311025", "story_v_out_115311.awb") / 1000

					if var_104_8 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_2
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_115311", "115311025", "story_v_out_115311.awb")

						arg_101_1:RecordAudio("115311025", var_104_9)
						arg_101_1:RecordAudio("115311025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_115311", "115311025", "story_v_out_115311.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_115311", "115311025", "story_v_out_115311.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_10 and arg_101_1.time_ < var_104_2 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play115311026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 115311026
		arg_105_1.duration_ = 10.2

		local var_105_0 = {
			ja = 9.566,
			ko = 10.2,
			zh = 7.8,
			en = 9.866
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
				arg_105_0:Play115311027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.025

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[105].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:GetWordFromCfg(115311026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 41 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 41)

				if (41 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 41)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311026", "story_v_out_115311.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311026", "story_v_out_115311.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_115311", "115311026", "story_v_out_115311.awb")

						arg_105_1:RecordAudio("115311026", var_108_6)
						arg_105_1:RecordAudio("115311026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_115311", "115311026", "story_v_out_115311.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_115311", "115311026", "story_v_out_115311.awb")
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
	Play115311027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 115311027
		arg_109_1.duration_ = 8.93

		local var_109_0 = {
			ja = 8.933,
			ko = 7.033,
			zh = 5.233,
			en = 8.1
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
				arg_109_0:Play115311028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10030 = arg_109_1.actors_["10030"].transform.localPosition
				arg_109_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10030", 3)

				for iter_112_0 = 0, arg_109_1.actors_["10030"].transform.childCount - 1 do
					local var_112_0 = arg_109_1.actors_["10030"].transform:GetChild(iter_112_0)

					if var_112_0.name == "split_3" or not string.find(var_112_0.name, "split") then
						var_112_0.gameObject:SetActive(true)
					else
						var_112_0.gameObject:SetActive(false)
					end
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_109_1.time_ - 0) / var_112_1)
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_112_2 = arg_109_1.actors_["10030"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps10030 == nil then
				arg_109_1.var_.actorSpriteComps10030 = var_112_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_3 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.actorSpriteComps10030 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								iter_112_2.color = Color.New(Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_3), Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_3), (Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_3)))
							else
								local var_112_4 = Mathf.Lerp(iter_112_2.color.r, 1, (arg_109_1.time_ - 0) / var_112_3)

								iter_112_2.color = Color.New(var_112_4, var_112_4, var_112_4)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps10030 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_112_4 then
						iter_112_4.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps10030 = nil
			end

			local var_112_5 = 0
			local var_112_6 = 0.5

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_7 = arg_109_1:GetWordFromCfg(115311027)
				local var_112_8 = arg_109_1:FormatText(var_112_7.content)

				arg_109_1.text_.text = var_112_8

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 20 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 20)

				if (20 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 20)) > 0 and var_112_6 < var_112_10 then
					arg_109_1.talkMaxDuration = var_112_10

					if var_112_10 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_5
					end
				end

				arg_109_1.text_.text = var_112_8
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311027", "story_v_out_115311.awb") ~= 0 then
					local var_112_11 = manager.audio:GetVoiceLength("story_v_out_115311", "115311027", "story_v_out_115311.awb") / 1000

					if var_112_11 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_5
					end

					if var_112_7.prefab_name ~= "" and arg_109_1.actors_[var_112_7.prefab_name] ~= nil then
						local var_112_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_7.prefab_name].transform, "story_v_out_115311", "115311027", "story_v_out_115311.awb")

						arg_109_1:RecordAudio("115311027", var_112_12)
						arg_109_1:RecordAudio("115311027", var_112_12)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_115311", "115311027", "story_v_out_115311.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_115311", "115311027", "story_v_out_115311.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_13 = math.max(var_112_6, arg_109_1.talkMaxDuration)

			if var_112_5 <= arg_109_1.time_ and arg_109_1.time_ < var_112_5 + var_112_13 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_5) / var_112_13

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_5 + var_112_13 and arg_109_1.time_ < var_112_5 + var_112_13 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play115311028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 115311028
		arg_113_1.duration_ = 9.17

		local var_113_0 = {
			ja = 9.166,
			ko = 8.8,
			zh = 6,
			en = 9.033
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
				arg_113_0:Play115311029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10030"]) and arg_113_1.var_.actorSpriteComps10030 == nil then
				arg_113_1.var_.actorSpriteComps10030 = arg_113_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["10030"]) then
				if arg_113_1.var_.actorSpriteComps10030 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								iter_116_1.color = Color.New(Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 0) / var_116_0), Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 0) / var_116_0), (Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 0) / var_116_0)))
							else
								local var_116_1 = Mathf.Lerp(iter_116_1.color.r, 0.5, (arg_113_1.time_ - 0) / var_116_0)

								iter_116_1.color = Color.New(var_116_1, var_116_1, var_116_1)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["10030"]) and arg_113_1.var_.actorSpriteComps10030 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_116_3 then
						iter_116_3.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps10030 = nil
			end

			local var_116_2 = 0
			local var_116_3 = 0.825

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_4 = arg_113_1:GetWordFromCfg(115311028)
				local var_116_5 = arg_113_1:FormatText(var_116_4.content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 33 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 33)

				if (33 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 33)) > 0 and var_116_3 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311028", "story_v_out_115311.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311028", "story_v_out_115311.awb") / 1000

					if var_116_8 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_2
					end

					if var_116_4.prefab_name ~= "" and arg_113_1.actors_[var_116_4.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_4.prefab_name].transform, "story_v_out_115311", "115311028", "story_v_out_115311.awb")

						arg_113_1:RecordAudio("115311028", var_116_9)
						arg_113_1:RecordAudio("115311028", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_115311", "115311028", "story_v_out_115311.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_115311", "115311028", "story_v_out_115311.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_10 and arg_113_1.time_ < var_116_2 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play115311029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 115311029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play115311030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.9

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(115311029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 36 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 36)

				if (36 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 36)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play115311030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 115311030
		arg_121_1.duration_ = 11.03

		local var_121_0 = {
			ja = 11.033,
			ko = 8,
			zh = 6.9,
			en = 7.433
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
				arg_121_0:Play115311031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10030"]) and arg_121_1.var_.actorSpriteComps10030 == nil then
				arg_121_1.var_.actorSpriteComps10030 = arg_121_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10030"]) then
				if arg_121_1.var_.actorSpriteComps10030 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								iter_124_1.color = Color.New(Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_0), Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_0), (Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_0)))
							else
								local var_124_1 = Mathf.Lerp(iter_124_1.color.r, 1, (arg_121_1.time_ - 0) / var_124_0)

								iter_124_1.color = Color.New(var_124_1, var_124_1, var_124_1)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10030"]) and arg_121_1.var_.actorSpriteComps10030 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_124_3 then
						iter_124_3.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps10030 = nil
			end

			local var_124_2 = 0
			local var_124_3 = 0.6

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_4 = arg_121_1:GetWordFromCfg(115311030)
				local var_124_5 = arg_121_1:FormatText(var_124_4.content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_7 = 24 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_5) / 24)

				if (24 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_5) / 24)) > 0 and var_124_3 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311030", "story_v_out_115311.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311030", "story_v_out_115311.awb") / 1000

					if var_124_8 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_2
					end

					if var_124_4.prefab_name ~= "" and arg_121_1.actors_[var_124_4.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_4.prefab_name].transform, "story_v_out_115311", "115311030", "story_v_out_115311.awb")

						arg_121_1:RecordAudio("115311030", var_124_9)
						arg_121_1:RecordAudio("115311030", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_115311", "115311030", "story_v_out_115311.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_115311", "115311030", "story_v_out_115311.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_2 <= arg_121_1.time_ and arg_121_1.time_ < var_124_2 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_2) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_2 + var_124_10 and arg_121_1.time_ < var_124_2 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play115311031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 115311031
		arg_125_1.duration_ = 9.73

		local var_125_0 = {
			ja = 9.733,
			ko = 8.4,
			zh = 8.7,
			en = 9.4
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
				arg_125_0:Play115311032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10030"]) and arg_125_1.var_.actorSpriteComps10030 == nil then
				arg_125_1.var_.actorSpriteComps10030 = arg_125_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_0 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10030"]) then
				if arg_125_1.var_.actorSpriteComps10030 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								iter_128_1.color = Color.New(Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor2.r, (arg_125_1.time_ - 0) / var_128_0), Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor2.g, (arg_125_1.time_ - 0) / var_128_0), (Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor2.b, (arg_125_1.time_ - 0) / var_128_0)))
							else
								local var_128_1 = Mathf.Lerp(iter_128_1.color.r, 0.5, (arg_125_1.time_ - 0) / var_128_0)

								iter_128_1.color = Color.New(var_128_1, var_128_1, var_128_1)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10030"]) and arg_125_1.var_.actorSpriteComps10030 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_128_3 then
						iter_128_3.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps10030 = nil
			end

			local var_128_2 = 0
			local var_128_3 = 1.175

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_4 = arg_125_1:GetWordFromCfg(115311031)
				local var_128_5 = arg_125_1:FormatText(var_128_4.content)

				arg_125_1.text_.text = var_128_5

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 47 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 47)

				if (47 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 47)) > 0 and var_128_3 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_2
					end
				end

				arg_125_1.text_.text = var_128_5
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311031", "story_v_out_115311.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311031", "story_v_out_115311.awb") / 1000

					if var_128_8 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_2
					end

					if var_128_4.prefab_name ~= "" and arg_125_1.actors_[var_128_4.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_4.prefab_name].transform, "story_v_out_115311", "115311031", "story_v_out_115311.awb")

						arg_125_1:RecordAudio("115311031", var_128_9)
						arg_125_1:RecordAudio("115311031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_115311", "115311031", "story_v_out_115311.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_115311", "115311031", "story_v_out_115311.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_3, arg_125_1.talkMaxDuration)

			if var_128_2 <= arg_125_1.time_ and arg_125_1.time_ < var_128_2 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_2) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_2 + var_128_10 and arg_125_1.time_ < var_128_2 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play115311032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 115311032
		arg_129_1.duration_ = 6.27

		local var_129_0 = {
			ja = 6.266,
			ko = 3.633,
			zh = 3.666,
			en = 3.866
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
				arg_129_0:Play115311033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.525

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:GetWordFromCfg(115311032)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 21 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 21)

				if (21 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 21)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311032", "story_v_out_115311.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311032", "story_v_out_115311.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_115311", "115311032", "story_v_out_115311.awb")

						arg_129_1:RecordAudio("115311032", var_132_6)
						arg_129_1:RecordAudio("115311032", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_115311", "115311032", "story_v_out_115311.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_115311", "115311032", "story_v_out_115311.awb")
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
	Play115311033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 115311033
		arg_133_1.duration_ = 9

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play115311034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if arg_133_1.bgs_.ST28a == nil then
				local var_136_0 = Object.Instantiate(arg_133_1.paintGo_)

				var_136_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST28a")
				var_136_0.name = "ST28a"
				var_136_0.transform.parent = arg_133_1.stage_.transform
				var_136_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.bgs_.ST28a = var_136_0
			end

			if 2 < arg_133_1.time_ and arg_133_1.time_ <= 2 + arg_136_0 then
				local var_136_1 = arg_133_1.bgs_.ST28a

				arg_133_1.bgs_.ST28a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_136_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_2 = var_136_1:GetComponent("SpriteRenderer")

				if var_136_2 and var_136_2.sprite then
					local var_136_3 = 2 * (var_136_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_136_1.transform.localScale = Vector3.New(var_136_3 / var_136_2.sprite.bounds.size.y < var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x and var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x or var_136_3 / var_136_2.sprite.bounds.size.y, var_136_3 / var_136_2.sprite.bounds.size.y < var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x and var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x or var_136_3 / var_136_2.sprite.bounds.size.y, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "ST28a" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_4 = 0

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_5 = 2

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_5 then
				local var_136_6 = Color.New(0, 0, 0)

				var_136_6.a = Mathf.Lerp(0, 1, (arg_133_1.time_ - var_136_4) / var_136_5)
				arg_133_1.mask_.color = var_136_6
			end

			if arg_133_1.time_ >= var_136_4 + var_136_5 and arg_133_1.time_ < var_136_4 + var_136_5 + arg_136_0 then
				local var_136_7 = Color.New(0, 0, 0)

				var_136_7.a = 1
				arg_133_1.mask_.color = var_136_7
			end

			local var_136_8 = 2

			if 2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_9 = 2

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_9 then
				local var_136_10 = Color.New(0, 0, 0)

				var_136_10.a = Mathf.Lerp(1, 0, (arg_133_1.time_ - var_136_8) / var_136_9)
				arg_133_1.mask_.color = var_136_10
			end

			if arg_133_1.time_ >= var_136_8 + var_136_9 and arg_133_1.time_ < var_136_8 + var_136_9 + arg_136_0 then
				local var_136_11 = Color.New(0, 0, 0)

				arg_133_1.mask_.enabled = false
				var_136_11.a = 0
				arg_133_1.mask_.color = var_136_11
			end

			local var_136_12 = arg_133_1.actors_["10030"].transform

			if 1.966 < arg_133_1.time_ and arg_133_1.time_ <= 1.966 + arg_136_0 then
				arg_133_1.var_.moveOldPos10030 = var_136_12.localPosition
				var_136_12.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10030", 7)

				for iter_136_2 = 0, var_136_12.childCount - 1 do
					local var_136_13 = var_136_12:GetChild(iter_136_2)

					if var_136_13.name == "split_3" or not string.find(var_136_13.name, "split") then
						var_136_13.gameObject:SetActive(true)
					else
						var_136_13.gameObject:SetActive(false)
					end
				end
			end

			local var_136_14 = 0.001

			if 1.966 <= arg_133_1.time_ and arg_133_1.time_ < 1.966 + var_136_14 then
				var_136_12.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10030, Vector3.New(0, -2000, -180), (arg_133_1.time_ - 1.966) / var_136_14)
			end

			if arg_133_1.time_ >= 1.966 + var_136_14 and arg_133_1.time_ < 1.966 + var_136_14 + arg_136_0 then
				var_136_12.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_15 = 4
			local var_136_16 = 1.325

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_17 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_17:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_18 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(115311033).content)

				arg_133_1.text_.text = var_136_18

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_20 = 53 <= 0 and var_136_16 or var_136_16 * (utf8.len(var_136_18) / 53)

				if (53 <= 0 and var_136_16 or var_136_16 * (utf8.len(var_136_18) / 53)) > 0 and var_136_16 < var_136_20 then
					arg_133_1.talkMaxDuration = var_136_20
					var_136_15 = var_136_15 + 0.3

					if var_136_20 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_20 + var_136_15
					end
				end

				arg_133_1.text_.text = var_136_18
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_21 = var_136_15 + 0.3
			local var_136_22 = math.max(var_136_16, arg_133_1.talkMaxDuration)

			if var_136_15 + 0.3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_21 + var_136_22 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_21) / var_136_22

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_21 + var_136_22 and arg_133_1.time_ < var_136_21 + var_136_22 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play115311034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 115311034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play115311035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 1.2

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(115311034).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 48 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 48)

				if (48 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 48)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play115311035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 115311035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play115311036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 1.375

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(115311035).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 55 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 55)

				if (55 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 55)) > 0 and var_146_0 < var_146_3 then
					arg_143_1.talkMaxDuration = var_146_3

					if var_146_3 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_3 + 0
					end
				end

				arg_143_1.text_.text = var_146_1
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_4 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_4

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play115311036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 115311036
		arg_147_1.duration_ = 11

		local var_147_0 = {
			ja = 7.2,
			ko = 7.3,
			zh = 7.466,
			en = 11
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
				arg_147_0:Play115311037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if arg_147_1.actors_["10029"] == nil then
				local var_150_0 = Object.Instantiate(arg_147_1.imageGo_, arg_147_1.canvasGo_.transform)

				var_150_0.transform:SetSiblingIndex(1)

				var_150_0.name = "10029"

				local var_150_1 = var_150_0:GetComponent(typeof(Image))

				var_150_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10029")

				var_150_1:SetNativeSize()

				var_150_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_147_1.actors_["10029"] = var_150_0
			end

			local var_150_2 = arg_147_1.actors_["10029"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10029 = var_150_2.localPosition
				var_150_2.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_150_3 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 then
				var_150_2.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10029, Vector3.New(-390, -350, -180), (arg_147_1.time_ - 0) / var_150_3)
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 then
				var_150_2.localPosition = Vector3.New(-390, -350, -180)
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				local var_150_4 = arg_147_1.actors_["10029"]:GetComponent("Image")

				if var_150_4 then
					arg_147_1.var_.alphaMatValue10029 = var_150_4
					arg_147_1.var_.alphaOldValue10029 = var_150_4.color.a
				end

				arg_147_1.var_.alphaOldValue10029 = 0
			end

			local var_150_5 = 0.5

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_5 then
				if arg_147_1.var_.alphaMatValue10029 then
					arg_147_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_147_1.var_.alphaOldValue10029, 1, (arg_147_1.time_ - 0) / var_150_5)
					arg_147_1.var_.alphaMatValue10029.color = arg_147_1.var_.alphaMatValue10029.color
				end
			end

			if arg_147_1.time_ >= 0 + var_150_5 and arg_147_1.time_ < 0 + var_150_5 + arg_150_0 and arg_147_1.var_.alphaMatValue10029 then
				arg_147_1.var_.alphaMatValue10029.color.a = 1
				arg_147_1.var_.alphaMatValue10029.color = arg_147_1.var_.alphaMatValue10029.color
			end

			local var_150_6 = arg_147_1.actors_["10029"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_6) then
				local var_150_7 = var_150_6:GetComponent("Image")

				if var_150_7 then
					arg_147_1.var_.highlightMatValue10029 = var_150_7
				end
			end

			local var_150_8 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_8 and not isNil(var_150_6) then
				if arg_147_1.var_.highlightMatValue10029 then
					local var_150_9 = Mathf.Lerp(0.5, 1, (arg_147_1.time_ - 0) / var_150_8)

					arg_147_1.var_.highlightMatValue10029.color.r = var_150_9
					arg_147_1.var_.highlightMatValue10029.color.g = var_150_9
					arg_147_1.var_.highlightMatValue10029.color.b = var_150_9
					arg_147_1.var_.highlightMatValue10029.color = arg_147_1.var_.highlightMatValue10029.color
				end
			end

			if arg_147_1.time_ >= 0 + var_150_8 and arg_147_1.time_ < 0 + var_150_8 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.highlightMatValue10029 then
				var_150_6.transform:SetSiblingIndex(1)

				arg_147_1.var_.highlightMatValue10029.color.r = 1
				arg_147_1.var_.highlightMatValue10029.color.g = 1
				arg_147_1.var_.highlightMatValue10029.color.b = 1
				arg_147_1.var_.highlightMatValue10029.color = arg_147_1.var_.highlightMatValue10029.color
			end

			local var_150_10 = 0
			local var_150_11 = 0.775

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_12 = arg_147_1:GetWordFromCfg(115311036)
				local var_150_13 = arg_147_1:FormatText(var_150_12.content)

				arg_147_1.text_.text = var_150_13

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_15 = 31 <= 0 and var_150_11 or var_150_11 * (utf8.len(var_150_13) / 31)

				if (31 <= 0 and var_150_11 or var_150_11 * (utf8.len(var_150_13) / 31)) > 0 and var_150_11 < var_150_15 then
					arg_147_1.talkMaxDuration = var_150_15

					if var_150_15 + var_150_10 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_15 + var_150_10
					end
				end

				arg_147_1.text_.text = var_150_13
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311036", "story_v_out_115311.awb") ~= 0 then
					local var_150_16 = manager.audio:GetVoiceLength("story_v_out_115311", "115311036", "story_v_out_115311.awb") / 1000

					if var_150_16 + var_150_10 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_16 + var_150_10
					end

					if var_150_12.prefab_name ~= "" and arg_147_1.actors_[var_150_12.prefab_name] ~= nil then
						local var_150_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_12.prefab_name].transform, "story_v_out_115311", "115311036", "story_v_out_115311.awb")

						arg_147_1:RecordAudio("115311036", var_150_17)
						arg_147_1:RecordAudio("115311036", var_150_17)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_115311", "115311036", "story_v_out_115311.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_115311", "115311036", "story_v_out_115311.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_18 = math.max(var_150_11, arg_147_1.talkMaxDuration)

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_18 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_10) / var_150_18

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_10 + var_150_18 and arg_147_1.time_ < var_150_10 + var_150_18 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play115311037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 115311037
		arg_151_1.duration_ = 8.57

		local var_151_0 = {
			ja = 8.566,
			ko = 4.9,
			zh = 4.8,
			en = 6.6
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
				arg_151_0:Play115311038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.6

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(115311037)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 24 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 24)

				if (24 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 24)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311037", "story_v_out_115311.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311037", "story_v_out_115311.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_115311", "115311037", "story_v_out_115311.awb")

						arg_151_1:RecordAudio("115311037", var_154_6)
						arg_151_1:RecordAudio("115311037", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_115311", "115311037", "story_v_out_115311.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_115311", "115311037", "story_v_out_115311.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play115311038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 115311038
		arg_155_1.duration_ = 17.63

		local var_155_0 = {
			ja = 17.633,
			ko = 10.2,
			zh = 10.2,
			en = 10.5
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
				arg_155_0:Play115311039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if arg_155_1.actors_["113801_1"] == nil then
				local var_158_0 = Object.Instantiate(arg_155_1.imageGo_, arg_155_1.canvasGo_.transform)

				var_158_0.transform:SetSiblingIndex(1)

				var_158_0.name = "113801_1"

				local var_158_1 = var_158_0:GetComponent(typeof(Image))

				var_158_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "113801_1")

				var_158_1:SetNativeSize()

				var_158_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_155_1.actors_["113801_1"] = var_158_0
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				local var_158_2 = arg_155_1.actors_["113801_1"]:GetComponent("Image")

				if var_158_2 then
					arg_155_1.var_.alphaMatValue113801_1 = var_158_2
					arg_155_1.var_.alphaOldValue113801_1 = var_158_2.color.a
				end

				arg_155_1.var_.alphaOldValue113801_1 = 0
			end

			local var_158_3 = 0.5

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 then
				if arg_155_1.var_.alphaMatValue113801_1 then
					arg_155_1.var_.alphaMatValue113801_1.color.a = Mathf.Lerp(arg_155_1.var_.alphaOldValue113801_1, 1, (arg_155_1.time_ - 0) / var_158_3)
					arg_155_1.var_.alphaMatValue113801_1.color = arg_155_1.var_.alphaMatValue113801_1.color
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and arg_155_1.var_.alphaMatValue113801_1 then
				arg_155_1.var_.alphaMatValue113801_1.color.a = 1
				arg_155_1.var_.alphaMatValue113801_1.color = arg_155_1.var_.alphaMatValue113801_1.color
			end

			local var_158_4 = arg_155_1.actors_["113801_1"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_4) then
				local var_158_5 = var_158_4:GetComponent("Image")

				if var_158_5 then
					arg_155_1.var_.highlightMatValue113801_1 = var_158_5
				end
			end

			local var_158_6 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_6 and not isNil(var_158_4) then
				if arg_155_1.var_.highlightMatValue113801_1 then
					local var_158_7 = Mathf.Lerp(0.5, 1, (arg_155_1.time_ - 0) / var_158_6)

					arg_155_1.var_.highlightMatValue113801_1.color.r = var_158_7
					arg_155_1.var_.highlightMatValue113801_1.color.g = var_158_7
					arg_155_1.var_.highlightMatValue113801_1.color.b = var_158_7
					arg_155_1.var_.highlightMatValue113801_1.color = arg_155_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_155_1.time_ >= 0 + var_158_6 and arg_155_1.time_ < 0 + var_158_6 + arg_158_0 and not isNil(var_158_4) and arg_155_1.var_.highlightMatValue113801_1 then
				var_158_4.transform:SetSiblingIndex(1)

				arg_155_1.var_.highlightMatValue113801_1.color.r = 1
				arg_155_1.var_.highlightMatValue113801_1.color.g = 1
				arg_155_1.var_.highlightMatValue113801_1.color.b = 1
				arg_155_1.var_.highlightMatValue113801_1.color = arg_155_1.var_.highlightMatValue113801_1.color
			end

			local var_158_8 = arg_155_1.actors_["113801_1"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos113801_1 = var_158_8.localPosition
				var_158_8.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("113801_1", 4)
			end

			local var_158_9 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_9 then
				var_158_8.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos113801_1, Vector3.New(390, -310, -370), (arg_155_1.time_ - 0) / var_158_9)
			end

			if arg_155_1.time_ >= 0 + var_158_9 and arg_155_1.time_ < 0 + var_158_9 + arg_158_0 then
				var_158_8.localPosition = Vector3.New(390, -310, -370)
			end

			local var_158_10 = arg_155_1.actors_["10029"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_10) then
				local var_158_11 = var_158_10:GetComponent("Image")

				if var_158_11 then
					arg_155_1.var_.highlightMatValue10029 = var_158_11
				end
			end

			local var_158_12 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_12 and not isNil(var_158_10) then
				if arg_155_1.var_.highlightMatValue10029 then
					local var_158_13 = Mathf.Lerp(1, 0.5, (arg_155_1.time_ - 0) / var_158_12)

					arg_155_1.var_.highlightMatValue10029.color.r = var_158_13
					arg_155_1.var_.highlightMatValue10029.color.g = var_158_13
					arg_155_1.var_.highlightMatValue10029.color.b = var_158_13
					arg_155_1.var_.highlightMatValue10029.color = arg_155_1.var_.highlightMatValue10029.color
				end
			end

			if arg_155_1.time_ >= 0 + var_158_12 and arg_155_1.time_ < 0 + var_158_12 + arg_158_0 and not isNil(var_158_10) and arg_155_1.var_.highlightMatValue10029 then
				arg_155_1.var_.highlightMatValue10029.color.r = 0.5
				arg_155_1.var_.highlightMatValue10029.color.g = 0.5
				arg_155_1.var_.highlightMatValue10029.color.b = 0.5
				arg_155_1.var_.highlightMatValue10029.color = arg_155_1.var_.highlightMatValue10029.color
			end

			local var_158_14 = 0
			local var_158_15 = 1

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_14 + arg_158_0 then
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

				local var_158_16 = arg_155_1:GetWordFromCfg(115311038)
				local var_158_17 = arg_155_1:FormatText(var_158_16.content)

				arg_155_1.text_.text = var_158_17

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_19 = 40 <= 0 and var_158_15 or var_158_15 * (utf8.len(var_158_17) / 40)

				if (40 <= 0 and var_158_15 or var_158_15 * (utf8.len(var_158_17) / 40)) > 0 and var_158_15 < var_158_19 then
					arg_155_1.talkMaxDuration = var_158_19

					if var_158_19 + var_158_14 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_19 + var_158_14
					end
				end

				arg_155_1.text_.text = var_158_17
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311038", "story_v_out_115311.awb") ~= 0 then
					local var_158_20 = manager.audio:GetVoiceLength("story_v_out_115311", "115311038", "story_v_out_115311.awb") / 1000

					if var_158_20 + var_158_14 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_20 + var_158_14
					end

					if var_158_16.prefab_name ~= "" and arg_155_1.actors_[var_158_16.prefab_name] ~= nil then
						local var_158_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_16.prefab_name].transform, "story_v_out_115311", "115311038", "story_v_out_115311.awb")

						arg_155_1:RecordAudio("115311038", var_158_21)
						arg_155_1:RecordAudio("115311038", var_158_21)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_115311", "115311038", "story_v_out_115311.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_115311", "115311038", "story_v_out_115311.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_22 = math.max(var_158_15, arg_155_1.talkMaxDuration)

			if var_158_14 <= arg_155_1.time_ and arg_155_1.time_ < var_158_14 + var_158_22 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_14) / var_158_22

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_14 + var_158_22 and arg_155_1.time_ < var_158_14 + var_158_22 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "113801_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play115311039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 115311039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play115311040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["113801_1"]) then
				local var_162_0 = arg_159_1.actors_["113801_1"]:GetComponent("Image")

				if var_162_0 then
					arg_159_1.var_.highlightMatValue113801_1 = var_162_0
				end
			end

			local var_162_1 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 and not isNil(arg_159_1.actors_["113801_1"]) then
				if arg_159_1.var_.highlightMatValue113801_1 then
					local var_162_2 = Mathf.Lerp(1, 0.5, (arg_159_1.time_ - 0) / var_162_1)

					arg_159_1.var_.highlightMatValue113801_1.color.r = var_162_2
					arg_159_1.var_.highlightMatValue113801_1.color.g = var_162_2
					arg_159_1.var_.highlightMatValue113801_1.color.b = var_162_2
					arg_159_1.var_.highlightMatValue113801_1.color = arg_159_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 and not isNil(arg_159_1.actors_["113801_1"]) and arg_159_1.var_.highlightMatValue113801_1 then
				arg_159_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_159_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_159_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_159_1.var_.highlightMatValue113801_1.color = arg_159_1.var_.highlightMatValue113801_1.color
			end

			local var_162_3 = 0
			local var_162_4 = 1.325

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_3 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_5 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(115311039).content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 53 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_5) / 53)

				if (53 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_5) / 53)) > 0 and var_162_4 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_3 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_3
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_4, arg_159_1.talkMaxDuration)

			if var_162_3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_3 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_3) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_3 + var_162_8 and arg_159_1.time_ < var_162_3 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play115311040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 115311040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play115311041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 1.15

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(115311040).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 46 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 46)

				if (46 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 46)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play115311041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 115311041
		arg_167_1.duration_ = 13.9

		local var_167_0 = {
			ja = 13.9,
			ko = 12.2,
			zh = 12.033,
			en = 13
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
				arg_167_0:Play115311042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10029"]) then
				local var_170_0 = arg_167_1.actors_["10029"]:GetComponent("Image")

				if var_170_0 then
					arg_167_1.var_.highlightMatValue10029 = var_170_0
				end
			end

			local var_170_1 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 and not isNil(arg_167_1.actors_["10029"]) then
				if arg_167_1.var_.highlightMatValue10029 then
					local var_170_2 = Mathf.Lerp(0.5, 1, (arg_167_1.time_ - 0) / var_170_1)

					arg_167_1.var_.highlightMatValue10029.color.r = var_170_2
					arg_167_1.var_.highlightMatValue10029.color.g = var_170_2
					arg_167_1.var_.highlightMatValue10029.color.b = var_170_2
					arg_167_1.var_.highlightMatValue10029.color = arg_167_1.var_.highlightMatValue10029.color
				end
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 and not isNil(arg_167_1.actors_["10029"]) and arg_167_1.var_.highlightMatValue10029 then
				arg_167_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_167_1.var_.highlightMatValue10029.color.r = 1
				arg_167_1.var_.highlightMatValue10029.color.g = 1
				arg_167_1.var_.highlightMatValue10029.color.b = 1
				arg_167_1.var_.highlightMatValue10029.color = arg_167_1.var_.highlightMatValue10029.color
			end

			local var_170_3 = 0
			local var_170_4 = 1.2

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_3 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_5 = arg_167_1:GetWordFromCfg(115311041)
				local var_170_6 = arg_167_1:FormatText(var_170_5.content)

				arg_167_1.text_.text = var_170_6

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_8 = 48 <= 0 and var_170_4 or var_170_4 * (utf8.len(var_170_6) / 48)

				if (48 <= 0 and var_170_4 or var_170_4 * (utf8.len(var_170_6) / 48)) > 0 and var_170_4 < var_170_8 then
					arg_167_1.talkMaxDuration = var_170_8

					if var_170_8 + var_170_3 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_3
					end
				end

				arg_167_1.text_.text = var_170_6
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311041", "story_v_out_115311.awb") ~= 0 then
					local var_170_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311041", "story_v_out_115311.awb") / 1000

					if var_170_9 + var_170_3 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_3
					end

					if var_170_5.prefab_name ~= "" and arg_167_1.actors_[var_170_5.prefab_name] ~= nil then
						local var_170_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_5.prefab_name].transform, "story_v_out_115311", "115311041", "story_v_out_115311.awb")

						arg_167_1:RecordAudio("115311041", var_170_10)
						arg_167_1:RecordAudio("115311041", var_170_10)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_115311", "115311041", "story_v_out_115311.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_115311", "115311041", "story_v_out_115311.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_11 = math.max(var_170_4, arg_167_1.talkMaxDuration)

			if var_170_3 <= arg_167_1.time_ and arg_167_1.time_ < var_170_3 + var_170_11 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_3) / var_170_11

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_3 + var_170_11 and arg_167_1.time_ < var_170_3 + var_170_11 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play115311042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 115311042
		arg_171_1.duration_ = 14

		local var_171_0 = {
			ja = 14,
			ko = 12.633,
			zh = 11.466,
			en = 13.8
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
				arg_171_0:Play115311043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 1.2

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(115311042)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 48 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 48)

				if (48 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 48)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311042", "story_v_out_115311.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311042", "story_v_out_115311.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_115311", "115311042", "story_v_out_115311.awb")

						arg_171_1:RecordAudio("115311042", var_174_6)
						arg_171_1:RecordAudio("115311042", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_115311", "115311042", "story_v_out_115311.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_115311", "115311042", "story_v_out_115311.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play115311043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 115311043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play115311044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["10029"]) then
				local var_178_0 = arg_175_1.actors_["10029"]:GetComponent("Image")

				if var_178_0 then
					arg_175_1.var_.highlightMatValue10029 = var_178_0
				end
			end

			local var_178_1 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_1 and not isNil(arg_175_1.actors_["10029"]) then
				if arg_175_1.var_.highlightMatValue10029 then
					local var_178_2 = Mathf.Lerp(1, 0.5, (arg_175_1.time_ - 0) / var_178_1)

					arg_175_1.var_.highlightMatValue10029.color.r = var_178_2
					arg_175_1.var_.highlightMatValue10029.color.g = var_178_2
					arg_175_1.var_.highlightMatValue10029.color.b = var_178_2
					arg_175_1.var_.highlightMatValue10029.color = arg_175_1.var_.highlightMatValue10029.color
				end
			end

			if arg_175_1.time_ >= 0 + var_178_1 and arg_175_1.time_ < 0 + var_178_1 + arg_178_0 and not isNil(arg_175_1.actors_["10029"]) and arg_175_1.var_.highlightMatValue10029 then
				arg_175_1.var_.highlightMatValue10029.color.r = 0.5
				arg_175_1.var_.highlightMatValue10029.color.g = 0.5
				arg_175_1.var_.highlightMatValue10029.color.b = 0.5
				arg_175_1.var_.highlightMatValue10029.color = arg_175_1.var_.highlightMatValue10029.color
			end

			local var_178_3 = 0
			local var_178_4 = 1.2

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_5 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(115311043).content)

				arg_175_1.text_.text = var_178_5

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_7 = 47 <= 0 and var_178_4 or var_178_4 * (utf8.len(var_178_5) / 47)

				if (47 <= 0 and var_178_4 or var_178_4 * (utf8.len(var_178_5) / 47)) > 0 and var_178_4 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_3 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_3
					end
				end

				arg_175_1.text_.text = var_178_5
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_4, arg_175_1.talkMaxDuration)

			if var_178_3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_3 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_3) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_3 + var_178_8 and arg_175_1.time_ < var_178_3 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play115311044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 115311044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play115311045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.8

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(115311044).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 32 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 32)

				if (32 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 32)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play115311045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 115311045
		arg_183_1.duration_ = 11.87

		local var_183_0 = {
			ja = 11.866,
			ko = 8.066,
			zh = 8.633,
			en = 9.3
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
				arg_183_0:Play115311046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["113801_1"]) then
				local var_186_0 = arg_183_1.actors_["113801_1"]:GetComponent("Image")

				if var_186_0 then
					arg_183_1.var_.highlightMatValue113801_1 = var_186_0
				end
			end

			local var_186_1 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_1 and not isNil(arg_183_1.actors_["113801_1"]) then
				if arg_183_1.var_.highlightMatValue113801_1 then
					local var_186_2 = Mathf.Lerp(0.5, 1, (arg_183_1.time_ - 0) / var_186_1)

					arg_183_1.var_.highlightMatValue113801_1.color.r = var_186_2
					arg_183_1.var_.highlightMatValue113801_1.color.g = var_186_2
					arg_183_1.var_.highlightMatValue113801_1.color.b = var_186_2
					arg_183_1.var_.highlightMatValue113801_1.color = arg_183_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_183_1.time_ >= 0 + var_186_1 and arg_183_1.time_ < 0 + var_186_1 + arg_186_0 and not isNil(arg_183_1.actors_["113801_1"]) and arg_183_1.var_.highlightMatValue113801_1 then
				arg_183_1.actors_["113801_1"].transform:SetSiblingIndex(1)

				arg_183_1.var_.highlightMatValue113801_1.color.r = 1
				arg_183_1.var_.highlightMatValue113801_1.color.g = 1
				arg_183_1.var_.highlightMatValue113801_1.color.b = 1
				arg_183_1.var_.highlightMatValue113801_1.color = arg_183_1.var_.highlightMatValue113801_1.color
			end

			local var_186_3 = 0
			local var_186_4 = 0.7

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_5 = arg_183_1:GetWordFromCfg(115311045)
				local var_186_6 = arg_183_1:FormatText(var_186_5.content)

				arg_183_1.text_.text = var_186_6

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_8 = 28 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_6) / 28)

				if (28 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_6) / 28)) > 0 and var_186_4 < var_186_8 then
					arg_183_1.talkMaxDuration = var_186_8

					if var_186_8 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_3
					end
				end

				arg_183_1.text_.text = var_186_6
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311045", "story_v_out_115311.awb") ~= 0 then
					local var_186_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311045", "story_v_out_115311.awb") / 1000

					if var_186_9 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_3
					end

					if var_186_5.prefab_name ~= "" and arg_183_1.actors_[var_186_5.prefab_name] ~= nil then
						local var_186_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_5.prefab_name].transform, "story_v_out_115311", "115311045", "story_v_out_115311.awb")

						arg_183_1:RecordAudio("115311045", var_186_10)
						arg_183_1:RecordAudio("115311045", var_186_10)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_115311", "115311045", "story_v_out_115311.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_115311", "115311045", "story_v_out_115311.awb")
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
	Play115311046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 115311046
		arg_187_1.duration_ = 10.03

		local var_187_0 = {
			ja = 8.9,
			ko = 5.433,
			zh = 6.6,
			en = 10.033
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play115311047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["10029"]) then
				local var_190_0 = arg_187_1.actors_["10029"]:GetComponent("Image")

				if var_190_0 then
					arg_187_1.var_.highlightMatValue10029 = var_190_0
				end
			end

			local var_190_1 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 and not isNil(arg_187_1.actors_["10029"]) then
				if arg_187_1.var_.highlightMatValue10029 then
					local var_190_2 = Mathf.Lerp(0.5, 1, (arg_187_1.time_ - 0) / var_190_1)

					arg_187_1.var_.highlightMatValue10029.color.r = var_190_2
					arg_187_1.var_.highlightMatValue10029.color.g = var_190_2
					arg_187_1.var_.highlightMatValue10029.color.b = var_190_2
					arg_187_1.var_.highlightMatValue10029.color = arg_187_1.var_.highlightMatValue10029.color
				end
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 and not isNil(arg_187_1.actors_["10029"]) and arg_187_1.var_.highlightMatValue10029 then
				arg_187_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_187_1.var_.highlightMatValue10029.color.r = 1
				arg_187_1.var_.highlightMatValue10029.color.g = 1
				arg_187_1.var_.highlightMatValue10029.color.b = 1
				arg_187_1.var_.highlightMatValue10029.color = arg_187_1.var_.highlightMatValue10029.color
			end

			local var_190_3 = arg_187_1.actors_["113801_1"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_3) then
				local var_190_4 = var_190_3:GetComponent("Image")

				if var_190_4 then
					arg_187_1.var_.highlightMatValue113801_1 = var_190_4
				end
			end

			local var_190_5 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_5 and not isNil(var_190_3) then
				if arg_187_1.var_.highlightMatValue113801_1 then
					local var_190_6 = Mathf.Lerp(1, 0.5, (arg_187_1.time_ - 0) / var_190_5)

					arg_187_1.var_.highlightMatValue113801_1.color.r = var_190_6
					arg_187_1.var_.highlightMatValue113801_1.color.g = var_190_6
					arg_187_1.var_.highlightMatValue113801_1.color.b = var_190_6
					arg_187_1.var_.highlightMatValue113801_1.color = arg_187_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_187_1.time_ >= 0 + var_190_5 and arg_187_1.time_ < 0 + var_190_5 + arg_190_0 and not isNil(var_190_3) and arg_187_1.var_.highlightMatValue113801_1 then
				arg_187_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_187_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_187_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_187_1.var_.highlightMatValue113801_1.color = arg_187_1.var_.highlightMatValue113801_1.color
			end

			local var_190_7 = 0
			local var_190_8 = 0.625

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_7 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_9 = arg_187_1:GetWordFromCfg(115311046)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_12 = 25 <= 0 and var_190_8 or var_190_8 * (utf8.len(var_190_10) / 25)

				if (25 <= 0 and var_190_8 or var_190_8 * (utf8.len(var_190_10) / 25)) > 0 and var_190_8 < var_190_12 then
					arg_187_1.talkMaxDuration = var_190_12

					if var_190_12 + var_190_7 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_12 + var_190_7
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311046", "story_v_out_115311.awb") ~= 0 then
					local var_190_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311046", "story_v_out_115311.awb") / 1000

					if var_190_13 + var_190_7 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_7
					end

					if var_190_9.prefab_name ~= "" and arg_187_1.actors_[var_190_9.prefab_name] ~= nil then
						local var_190_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_9.prefab_name].transform, "story_v_out_115311", "115311046", "story_v_out_115311.awb")

						arg_187_1:RecordAudio("115311046", var_190_14)
						arg_187_1:RecordAudio("115311046", var_190_14)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_115311", "115311046", "story_v_out_115311.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_115311", "115311046", "story_v_out_115311.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_15 = math.max(var_190_8, arg_187_1.talkMaxDuration)

			if var_190_7 <= arg_187_1.time_ and arg_187_1.time_ < var_190_7 + var_190_15 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_7) / var_190_15

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_7 + var_190_15 and arg_187_1.time_ < var_190_7 + var_190_15 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play115311047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 115311047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play115311048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["10029"]) then
				local var_194_0 = arg_191_1.actors_["10029"]:GetComponent("Image")

				if var_194_0 then
					arg_191_1.var_.highlightMatValue10029 = var_194_0
				end
			end

			local var_194_1 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_1 and not isNil(arg_191_1.actors_["10029"]) then
				if arg_191_1.var_.highlightMatValue10029 then
					local var_194_2 = Mathf.Lerp(1, 0.5, (arg_191_1.time_ - 0) / var_194_1)

					arg_191_1.var_.highlightMatValue10029.color.r = var_194_2
					arg_191_1.var_.highlightMatValue10029.color.g = var_194_2
					arg_191_1.var_.highlightMatValue10029.color.b = var_194_2
					arg_191_1.var_.highlightMatValue10029.color = arg_191_1.var_.highlightMatValue10029.color
				end
			end

			if arg_191_1.time_ >= 0 + var_194_1 and arg_191_1.time_ < 0 + var_194_1 + arg_194_0 and not isNil(arg_191_1.actors_["10029"]) and arg_191_1.var_.highlightMatValue10029 then
				arg_191_1.var_.highlightMatValue10029.color.r = 0.5
				arg_191_1.var_.highlightMatValue10029.color.g = 0.5
				arg_191_1.var_.highlightMatValue10029.color.b = 0.5
				arg_191_1.var_.highlightMatValue10029.color = arg_191_1.var_.highlightMatValue10029.color
			end

			local var_194_3 = 0
			local var_194_4 = 1.525

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_3 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_5 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(115311047).content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 61 <= 0 and var_194_4 or var_194_4 * (utf8.len(var_194_5) / 61)

				if (61 <= 0 and var_194_4 or var_194_4 * (utf8.len(var_194_5) / 61)) > 0 and var_194_4 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_3 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_3
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_4, arg_191_1.talkMaxDuration)

			if var_194_3 <= arg_191_1.time_ and arg_191_1.time_ < var_194_3 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_3) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_3 + var_194_8 and arg_191_1.time_ < var_194_3 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play115311048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 115311048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play115311049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.9

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(115311048).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 36 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 36)

				if (36 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 36)) > 0 and var_198_0 < var_198_3 then
					arg_195_1.talkMaxDuration = var_198_3

					if var_198_3 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_3 + 0
					end
				end

				arg_195_1.text_.text = var_198_1
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_4 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_4

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play115311049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 115311049
		arg_199_1.duration_ = 14.13

		local var_199_0 = {
			ja = 14.133,
			ko = 9.466,
			zh = 9.233,
			en = 10.4
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
				arg_199_0:Play115311050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["113801_1"]) then
				local var_202_0 = arg_199_1.actors_["113801_1"]:GetComponent("Image")

				if var_202_0 then
					arg_199_1.var_.highlightMatValue113801_1 = var_202_0
				end
			end

			local var_202_1 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 and not isNil(arg_199_1.actors_["113801_1"]) then
				if arg_199_1.var_.highlightMatValue113801_1 then
					local var_202_2 = Mathf.Lerp(0.5, 1, (arg_199_1.time_ - 0) / var_202_1)

					arg_199_1.var_.highlightMatValue113801_1.color.r = var_202_2
					arg_199_1.var_.highlightMatValue113801_1.color.g = var_202_2
					arg_199_1.var_.highlightMatValue113801_1.color.b = var_202_2
					arg_199_1.var_.highlightMatValue113801_1.color = arg_199_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 and not isNil(arg_199_1.actors_["113801_1"]) and arg_199_1.var_.highlightMatValue113801_1 then
				arg_199_1.actors_["113801_1"].transform:SetSiblingIndex(1)

				arg_199_1.var_.highlightMatValue113801_1.color.r = 1
				arg_199_1.var_.highlightMatValue113801_1.color.g = 1
				arg_199_1.var_.highlightMatValue113801_1.color.b = 1
				arg_199_1.var_.highlightMatValue113801_1.color = arg_199_1.var_.highlightMatValue113801_1.color
			end

			local var_202_3 = 0
			local var_202_4 = 0.9

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_3 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_5 = arg_199_1:GetWordFromCfg(115311049)
				local var_202_6 = arg_199_1:FormatText(var_202_5.content)

				arg_199_1.text_.text = var_202_6

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_8 = 35 <= 0 and var_202_4 or var_202_4 * (utf8.len(var_202_6) / 35)

				if (35 <= 0 and var_202_4 or var_202_4 * (utf8.len(var_202_6) / 35)) > 0 and var_202_4 < var_202_8 then
					arg_199_1.talkMaxDuration = var_202_8

					if var_202_8 + var_202_3 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_3
					end
				end

				arg_199_1.text_.text = var_202_6
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311049", "story_v_out_115311.awb") ~= 0 then
					local var_202_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311049", "story_v_out_115311.awb") / 1000

					if var_202_9 + var_202_3 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_3
					end

					if var_202_5.prefab_name ~= "" and arg_199_1.actors_[var_202_5.prefab_name] ~= nil then
						local var_202_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_5.prefab_name].transform, "story_v_out_115311", "115311049", "story_v_out_115311.awb")

						arg_199_1:RecordAudio("115311049", var_202_10)
						arg_199_1:RecordAudio("115311049", var_202_10)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_115311", "115311049", "story_v_out_115311.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_115311", "115311049", "story_v_out_115311.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_11 = math.max(var_202_4, arg_199_1.talkMaxDuration)

			if var_202_3 <= arg_199_1.time_ and arg_199_1.time_ < var_202_3 + var_202_11 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_3) / var_202_11

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_3 + var_202_11 and arg_199_1.time_ < var_202_3 + var_202_11 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play115311050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 115311050
		arg_203_1.duration_ = 3.13

		local var_203_0 = {
			ja = 2.9,
			ko = 2.9,
			zh = 2.766,
			en = 3.133
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
				arg_203_0:Play115311051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["10029"]) then
				local var_206_0 = arg_203_1.actors_["10029"]:GetComponent("Image")

				if var_206_0 then
					arg_203_1.var_.highlightMatValue10029 = var_206_0
				end
			end

			local var_206_1 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_1 and not isNil(arg_203_1.actors_["10029"]) then
				if arg_203_1.var_.highlightMatValue10029 then
					local var_206_2 = Mathf.Lerp(0.5, 1, (arg_203_1.time_ - 0) / var_206_1)

					arg_203_1.var_.highlightMatValue10029.color.r = var_206_2
					arg_203_1.var_.highlightMatValue10029.color.g = var_206_2
					arg_203_1.var_.highlightMatValue10029.color.b = var_206_2
					arg_203_1.var_.highlightMatValue10029.color = arg_203_1.var_.highlightMatValue10029.color
				end
			end

			if arg_203_1.time_ >= 0 + var_206_1 and arg_203_1.time_ < 0 + var_206_1 + arg_206_0 and not isNil(arg_203_1.actors_["10029"]) and arg_203_1.var_.highlightMatValue10029 then
				arg_203_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_203_1.var_.highlightMatValue10029.color.r = 1
				arg_203_1.var_.highlightMatValue10029.color.g = 1
				arg_203_1.var_.highlightMatValue10029.color.b = 1
				arg_203_1.var_.highlightMatValue10029.color = arg_203_1.var_.highlightMatValue10029.color
			end

			local var_206_3 = arg_203_1.actors_["113801_1"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_3) then
				local var_206_4 = var_206_3:GetComponent("Image")

				if var_206_4 then
					arg_203_1.var_.highlightMatValue113801_1 = var_206_4
				end
			end

			local var_206_5 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_5 and not isNil(var_206_3) then
				if arg_203_1.var_.highlightMatValue113801_1 then
					local var_206_6 = Mathf.Lerp(1, 0.5, (arg_203_1.time_ - 0) / var_206_5)

					arg_203_1.var_.highlightMatValue113801_1.color.r = var_206_6
					arg_203_1.var_.highlightMatValue113801_1.color.g = var_206_6
					arg_203_1.var_.highlightMatValue113801_1.color.b = var_206_6
					arg_203_1.var_.highlightMatValue113801_1.color = arg_203_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_203_1.time_ >= 0 + var_206_5 and arg_203_1.time_ < 0 + var_206_5 + arg_206_0 and not isNil(var_206_3) and arg_203_1.var_.highlightMatValue113801_1 then
				arg_203_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_203_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_203_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_203_1.var_.highlightMatValue113801_1.color = arg_203_1.var_.highlightMatValue113801_1.color
			end

			local var_206_7 = 0
			local var_206_8 = 0.175

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_7 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_9 = arg_203_1:GetWordFromCfg(115311050)
				local var_206_10 = arg_203_1:FormatText(var_206_9.content)

				arg_203_1.text_.text = var_206_10

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_12 = 7 <= 0 and var_206_8 or var_206_8 * (utf8.len(var_206_10) / 7)

				if (7 <= 0 and var_206_8 or var_206_8 * (utf8.len(var_206_10) / 7)) > 0 and var_206_8 < var_206_12 then
					arg_203_1.talkMaxDuration = var_206_12

					if var_206_12 + var_206_7 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_7
					end
				end

				arg_203_1.text_.text = var_206_10
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311050", "story_v_out_115311.awb") ~= 0 then
					local var_206_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311050", "story_v_out_115311.awb") / 1000

					if var_206_13 + var_206_7 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_7
					end

					if var_206_9.prefab_name ~= "" and arg_203_1.actors_[var_206_9.prefab_name] ~= nil then
						local var_206_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_9.prefab_name].transform, "story_v_out_115311", "115311050", "story_v_out_115311.awb")

						arg_203_1:RecordAudio("115311050", var_206_14)
						arg_203_1:RecordAudio("115311050", var_206_14)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_115311", "115311050", "story_v_out_115311.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_115311", "115311050", "story_v_out_115311.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_15 = math.max(var_206_8, arg_203_1.talkMaxDuration)

			if var_206_7 <= arg_203_1.time_ and arg_203_1.time_ < var_206_7 + var_206_15 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_7) / var_206_15

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_7 + var_206_15 and arg_203_1.time_ < var_206_7 + var_206_15 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play115311051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 115311051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play115311052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				local var_210_0 = arg_207_1.actors_["10029"]:GetComponent("Image")

				if var_210_0 then
					arg_207_1.var_.alphaMatValue10029 = var_210_0
					arg_207_1.var_.alphaOldValue10029 = var_210_0.color.a
				end

				arg_207_1.var_.alphaOldValue10029 = 1
			end

			local var_210_1 = 0.5

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_1 then
				if arg_207_1.var_.alphaMatValue10029 then
					arg_207_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_207_1.var_.alphaOldValue10029, 0, (arg_207_1.time_ - 0) / var_210_1)
					arg_207_1.var_.alphaMatValue10029.color = arg_207_1.var_.alphaMatValue10029.color
				end
			end

			if arg_207_1.time_ >= 0 + var_210_1 and arg_207_1.time_ < 0 + var_210_1 + arg_210_0 and arg_207_1.var_.alphaMatValue10029 then
				arg_207_1.var_.alphaMatValue10029.color.a = 0
				arg_207_1.var_.alphaMatValue10029.color = arg_207_1.var_.alphaMatValue10029.color
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				local var_210_2 = arg_207_1.actors_["113801_1"]:GetComponent("Image")

				if var_210_2 then
					arg_207_1.var_.alphaMatValue113801_1 = var_210_2
					arg_207_1.var_.alphaOldValue113801_1 = var_210_2.color.a
				end

				arg_207_1.var_.alphaOldValue113801_1 = 1
			end

			local var_210_3 = 0.5

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 then
				if arg_207_1.var_.alphaMatValue113801_1 then
					arg_207_1.var_.alphaMatValue113801_1.color.a = Mathf.Lerp(arg_207_1.var_.alphaOldValue113801_1, 0, (arg_207_1.time_ - 0) / var_210_3)
					arg_207_1.var_.alphaMatValue113801_1.color = arg_207_1.var_.alphaMatValue113801_1.color
				end
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and arg_207_1.var_.alphaMatValue113801_1 then
				arg_207_1.var_.alphaMatValue113801_1.color.a = 0
				arg_207_1.var_.alphaMatValue113801_1.color = arg_207_1.var_.alphaMatValue113801_1.color
			end

			local var_210_4 = 0
			local var_210_5 = 0.95

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_6 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(115311051).content)

				arg_207_1.text_.text = var_210_6

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_8 = 38 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_6) / 38)

				if (38 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_6) / 38)) > 0 and var_210_5 < var_210_8 then
					arg_207_1.talkMaxDuration = var_210_8

					if var_210_8 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_6
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_9 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_9 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_9

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_9 and arg_207_1.time_ < var_210_4 + var_210_9 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play115311052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 115311052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play115311053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 1.35

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(115311052).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 54 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 54)

				if (54 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 54)) > 0 and var_214_0 < var_214_3 then
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
	Play115311053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 115311053
		arg_215_1.duration_ = 7.03

		local var_215_0 = {
			ja = 7.033,
			ko = 3.9,
			zh = 4.8,
			en = 6.333
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
				arg_215_0:Play115311054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				local var_218_0 = arg_215_1.actors_["10029"]:GetComponent("Image")

				if var_218_0 then
					arg_215_1.var_.alphaMatValue10029 = var_218_0
					arg_215_1.var_.alphaOldValue10029 = var_218_0.color.a
				end

				arg_215_1.var_.alphaOldValue10029 = 0
			end

			local var_218_1 = 0.5

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_1 then
				if arg_215_1.var_.alphaMatValue10029 then
					arg_215_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_215_1.var_.alphaOldValue10029, 1, (arg_215_1.time_ - 0) / var_218_1)
					arg_215_1.var_.alphaMatValue10029.color = arg_215_1.var_.alphaMatValue10029.color
				end
			end

			if arg_215_1.time_ >= 0 + var_218_1 and arg_215_1.time_ < 0 + var_218_1 + arg_218_0 and arg_215_1.var_.alphaMatValue10029 then
				arg_215_1.var_.alphaMatValue10029.color.a = 1
				arg_215_1.var_.alphaMatValue10029.color = arg_215_1.var_.alphaMatValue10029.color
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				local var_218_2 = arg_215_1.actors_["113801_1"]:GetComponent("Image")

				if var_218_2 then
					arg_215_1.var_.alphaMatValue113801_1 = var_218_2
					arg_215_1.var_.alphaOldValue113801_1 = var_218_2.color.a
				end

				arg_215_1.var_.alphaOldValue113801_1 = 0
			end

			local var_218_3 = 0.5

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_3 then
				if arg_215_1.var_.alphaMatValue113801_1 then
					arg_215_1.var_.alphaMatValue113801_1.color.a = Mathf.Lerp(arg_215_1.var_.alphaOldValue113801_1, 1, (arg_215_1.time_ - 0) / var_218_3)
					arg_215_1.var_.alphaMatValue113801_1.color = arg_215_1.var_.alphaMatValue113801_1.color
				end
			end

			if arg_215_1.time_ >= 0 + var_218_3 and arg_215_1.time_ < 0 + var_218_3 + arg_218_0 and arg_215_1.var_.alphaMatValue113801_1 then
				arg_215_1.var_.alphaMatValue113801_1.color.a = 1
				arg_215_1.var_.alphaMatValue113801_1.color = arg_215_1.var_.alphaMatValue113801_1.color
			end

			local var_218_4 = arg_215_1.actors_["10029"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_4) then
				local var_218_5 = var_218_4:GetComponent("Image")

				if var_218_5 then
					arg_215_1.var_.highlightMatValue10029 = var_218_5
				end
			end

			local var_218_6 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_6 and not isNil(var_218_4) then
				if arg_215_1.var_.highlightMatValue10029 then
					local var_218_7 = Mathf.Lerp(0.5, 1, (arg_215_1.time_ - 0) / var_218_6)

					arg_215_1.var_.highlightMatValue10029.color.r = var_218_7
					arg_215_1.var_.highlightMatValue10029.color.g = var_218_7
					arg_215_1.var_.highlightMatValue10029.color.b = var_218_7
					arg_215_1.var_.highlightMatValue10029.color = arg_215_1.var_.highlightMatValue10029.color
				end
			end

			if arg_215_1.time_ >= 0 + var_218_6 and arg_215_1.time_ < 0 + var_218_6 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.highlightMatValue10029 then
				var_218_4.transform:SetSiblingIndex(1)

				arg_215_1.var_.highlightMatValue10029.color.r = 1
				arg_215_1.var_.highlightMatValue10029.color.g = 1
				arg_215_1.var_.highlightMatValue10029.color.b = 1
				arg_215_1.var_.highlightMatValue10029.color = arg_215_1.var_.highlightMatValue10029.color
			end

			local var_218_8 = 0
			local var_218_9 = 0.425

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_10 = arg_215_1:GetWordFromCfg(115311053)
				local var_218_11 = arg_215_1:FormatText(var_218_10.content)

				arg_215_1.text_.text = var_218_11

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_13 = 17 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 17)

				if (17 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 17)) > 0 and var_218_9 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_8
					end
				end

				arg_215_1.text_.text = var_218_11
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311053", "story_v_out_115311.awb") ~= 0 then
					local var_218_14 = manager.audio:GetVoiceLength("story_v_out_115311", "115311053", "story_v_out_115311.awb") / 1000

					if var_218_14 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_14 + var_218_8
					end

					if var_218_10.prefab_name ~= "" and arg_215_1.actors_[var_218_10.prefab_name] ~= nil then
						local var_218_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_10.prefab_name].transform, "story_v_out_115311", "115311053", "story_v_out_115311.awb")

						arg_215_1:RecordAudio("115311053", var_218_15)
						arg_215_1:RecordAudio("115311053", var_218_15)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_115311", "115311053", "story_v_out_115311.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_115311", "115311053", "story_v_out_115311.awb")
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

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play115311054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 115311054
		arg_219_1.duration_ = 10.5

		local var_219_0 = {
			ja = 10.5,
			ko = 8.5,
			zh = 7.133,
			en = 10.166
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
				arg_219_0:Play115311055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["10029"]) then
				local var_222_0 = arg_219_1.actors_["10029"]:GetComponent("Image")

				if var_222_0 then
					arg_219_1.var_.highlightMatValue10029 = var_222_0
				end
			end

			local var_222_1 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_1 and not isNil(arg_219_1.actors_["10029"]) then
				if arg_219_1.var_.highlightMatValue10029 then
					local var_222_2 = Mathf.Lerp(1, 0.5, (arg_219_1.time_ - 0) / var_222_1)

					arg_219_1.var_.highlightMatValue10029.color.r = var_222_2
					arg_219_1.var_.highlightMatValue10029.color.g = var_222_2
					arg_219_1.var_.highlightMatValue10029.color.b = var_222_2
					arg_219_1.var_.highlightMatValue10029.color = arg_219_1.var_.highlightMatValue10029.color
				end
			end

			if arg_219_1.time_ >= 0 + var_222_1 and arg_219_1.time_ < 0 + var_222_1 + arg_222_0 and not isNil(arg_219_1.actors_["10029"]) and arg_219_1.var_.highlightMatValue10029 then
				arg_219_1.var_.highlightMatValue10029.color.r = 0.5
				arg_219_1.var_.highlightMatValue10029.color.g = 0.5
				arg_219_1.var_.highlightMatValue10029.color.b = 0.5
				arg_219_1.var_.highlightMatValue10029.color = arg_219_1.var_.highlightMatValue10029.color
			end

			local var_222_3 = arg_219_1.actors_["113801_1"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_3) then
				local var_222_4 = var_222_3:GetComponent("Image")

				if var_222_4 then
					arg_219_1.var_.highlightMatValue113801_1 = var_222_4
				end
			end

			local var_222_5 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_5 and not isNil(var_222_3) then
				if arg_219_1.var_.highlightMatValue113801_1 then
					local var_222_6 = Mathf.Lerp(0.5, 1, (arg_219_1.time_ - 0) / var_222_5)

					arg_219_1.var_.highlightMatValue113801_1.color.r = var_222_6
					arg_219_1.var_.highlightMatValue113801_1.color.g = var_222_6
					arg_219_1.var_.highlightMatValue113801_1.color.b = var_222_6
					arg_219_1.var_.highlightMatValue113801_1.color = arg_219_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_219_1.time_ >= 0 + var_222_5 and arg_219_1.time_ < 0 + var_222_5 + arg_222_0 and not isNil(var_222_3) and arg_219_1.var_.highlightMatValue113801_1 then
				var_222_3.transform:SetSiblingIndex(1)

				arg_219_1.var_.highlightMatValue113801_1.color.r = 1
				arg_219_1.var_.highlightMatValue113801_1.color.g = 1
				arg_219_1.var_.highlightMatValue113801_1.color.b = 1
				arg_219_1.var_.highlightMatValue113801_1.color = arg_219_1.var_.highlightMatValue113801_1.color
			end

			local var_222_7 = 0
			local var_222_8 = 0.775

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_7 + arg_222_0 then
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

				local var_222_9 = arg_219_1:GetWordFromCfg(115311054)
				local var_222_10 = arg_219_1:FormatText(var_222_9.content)

				arg_219_1.text_.text = var_222_10

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_12 = 31 <= 0 and var_222_8 or var_222_8 * (utf8.len(var_222_10) / 31)

				if (31 <= 0 and var_222_8 or var_222_8 * (utf8.len(var_222_10) / 31)) > 0 and var_222_8 < var_222_12 then
					arg_219_1.talkMaxDuration = var_222_12

					if var_222_12 + var_222_7 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_7
					end
				end

				arg_219_1.text_.text = var_222_10
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311054", "story_v_out_115311.awb") ~= 0 then
					local var_222_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311054", "story_v_out_115311.awb") / 1000

					if var_222_13 + var_222_7 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_7
					end

					if var_222_9.prefab_name ~= "" and arg_219_1.actors_[var_222_9.prefab_name] ~= nil then
						local var_222_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_9.prefab_name].transform, "story_v_out_115311", "115311054", "story_v_out_115311.awb")

						arg_219_1:RecordAudio("115311054", var_222_14)
						arg_219_1:RecordAudio("115311054", var_222_14)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_115311", "115311054", "story_v_out_115311.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_115311", "115311054", "story_v_out_115311.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_15 = math.max(var_222_8, arg_219_1.talkMaxDuration)

			if var_222_7 <= arg_219_1.time_ and arg_219_1.time_ < var_222_7 + var_222_15 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_7) / var_222_15

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_7 + var_222_15 and arg_219_1.time_ < var_222_7 + var_222_15 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play115311055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 115311055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play115311056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["113801_1"]) then
				local var_226_0 = arg_223_1.actors_["113801_1"]:GetComponent("Image")

				if var_226_0 then
					arg_223_1.var_.highlightMatValue113801_1 = var_226_0
				end
			end

			local var_226_1 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 and not isNil(arg_223_1.actors_["113801_1"]) then
				if arg_223_1.var_.highlightMatValue113801_1 then
					local var_226_2 = Mathf.Lerp(1, 0.5, (arg_223_1.time_ - 0) / var_226_1)

					arg_223_1.var_.highlightMatValue113801_1.color.r = var_226_2
					arg_223_1.var_.highlightMatValue113801_1.color.g = var_226_2
					arg_223_1.var_.highlightMatValue113801_1.color.b = var_226_2
					arg_223_1.var_.highlightMatValue113801_1.color = arg_223_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 and not isNil(arg_223_1.actors_["113801_1"]) and arg_223_1.var_.highlightMatValue113801_1 then
				arg_223_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_223_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_223_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_223_1.var_.highlightMatValue113801_1.color = arg_223_1.var_.highlightMatValue113801_1.color
			end

			local var_226_3 = 0
			local var_226_4 = 1.05

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_3 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_5 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(115311055).content)

				arg_223_1.text_.text = var_226_5

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_7 = 42 <= 0 and var_226_4 or var_226_4 * (utf8.len(var_226_5) / 42)

				if (42 <= 0 and var_226_4 or var_226_4 * (utf8.len(var_226_5) / 42)) > 0 and var_226_4 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_3 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_3
					end
				end

				arg_223_1.text_.text = var_226_5
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_8 = math.max(var_226_4, arg_223_1.talkMaxDuration)

			if var_226_3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_3 + var_226_8 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_3) / var_226_8

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_3 + var_226_8 and arg_223_1.time_ < var_226_3 + var_226_8 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play115311056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 115311056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play115311057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.4

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(115311056).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 16 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 16)

				if (16 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 16)) > 0 and var_230_0 < var_230_3 then
					arg_227_1.talkMaxDuration = var_230_3

					if var_230_3 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_3 + 0
					end
				end

				arg_227_1.text_.text = var_230_1
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_4 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_4

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play115311057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 115311057
		arg_231_1.duration_ = 9.9

		local var_231_0 = {
			ja = 9.9,
			ko = 7.1,
			zh = 6.066,
			en = 8.533
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play115311058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["10029"]) then
				local var_234_0 = arg_231_1.actors_["10029"]:GetComponent("Image")

				if var_234_0 then
					arg_231_1.var_.highlightMatValue10029 = var_234_0
				end
			end

			local var_234_1 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_1 and not isNil(arg_231_1.actors_["10029"]) then
				if arg_231_1.var_.highlightMatValue10029 then
					local var_234_2 = Mathf.Lerp(0.5, 1, (arg_231_1.time_ - 0) / var_234_1)

					arg_231_1.var_.highlightMatValue10029.color.r = var_234_2
					arg_231_1.var_.highlightMatValue10029.color.g = var_234_2
					arg_231_1.var_.highlightMatValue10029.color.b = var_234_2
					arg_231_1.var_.highlightMatValue10029.color = arg_231_1.var_.highlightMatValue10029.color
				end
			end

			if arg_231_1.time_ >= 0 + var_234_1 and arg_231_1.time_ < 0 + var_234_1 + arg_234_0 and not isNil(arg_231_1.actors_["10029"]) and arg_231_1.var_.highlightMatValue10029 then
				arg_231_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_231_1.var_.highlightMatValue10029.color.r = 1
				arg_231_1.var_.highlightMatValue10029.color.g = 1
				arg_231_1.var_.highlightMatValue10029.color.b = 1
				arg_231_1.var_.highlightMatValue10029.color = arg_231_1.var_.highlightMatValue10029.color
			end

			local var_234_3 = 0
			local var_234_4 = 0.725

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_3 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_5 = arg_231_1:GetWordFromCfg(115311057)
				local var_234_6 = arg_231_1:FormatText(var_234_5.content)

				arg_231_1.text_.text = var_234_6

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_8 = 29 <= 0 and var_234_4 or var_234_4 * (utf8.len(var_234_6) / 29)

				if (29 <= 0 and var_234_4 or var_234_4 * (utf8.len(var_234_6) / 29)) > 0 and var_234_4 < var_234_8 then
					arg_231_1.talkMaxDuration = var_234_8

					if var_234_8 + var_234_3 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_3
					end
				end

				arg_231_1.text_.text = var_234_6
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311057", "story_v_out_115311.awb") ~= 0 then
					local var_234_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311057", "story_v_out_115311.awb") / 1000

					if var_234_9 + var_234_3 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_3
					end

					if var_234_5.prefab_name ~= "" and arg_231_1.actors_[var_234_5.prefab_name] ~= nil then
						local var_234_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_5.prefab_name].transform, "story_v_out_115311", "115311057", "story_v_out_115311.awb")

						arg_231_1:RecordAudio("115311057", var_234_10)
						arg_231_1:RecordAudio("115311057", var_234_10)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_115311", "115311057", "story_v_out_115311.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_115311", "115311057", "story_v_out_115311.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_11 = math.max(var_234_4, arg_231_1.talkMaxDuration)

			if var_234_3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_3 + var_234_11 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_3) / var_234_11

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_3 + var_234_11 and arg_231_1.time_ < var_234_3 + var_234_11 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play115311058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 115311058
		arg_235_1.duration_ = 10.7

		local var_235_0 = {
			ja = 8.8,
			ko = 7.1,
			zh = 7.433,
			en = 10.7
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
				arg_235_0:Play115311059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["10029"]) then
				local var_238_0 = arg_235_1.actors_["10029"]:GetComponent("Image")

				if var_238_0 then
					arg_235_1.var_.highlightMatValue10029 = var_238_0
				end
			end

			local var_238_1 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_1 and not isNil(arg_235_1.actors_["10029"]) then
				if arg_235_1.var_.highlightMatValue10029 then
					local var_238_2 = Mathf.Lerp(1, 0.5, (arg_235_1.time_ - 0) / var_238_1)

					arg_235_1.var_.highlightMatValue10029.color.r = var_238_2
					arg_235_1.var_.highlightMatValue10029.color.g = var_238_2
					arg_235_1.var_.highlightMatValue10029.color.b = var_238_2
					arg_235_1.var_.highlightMatValue10029.color = arg_235_1.var_.highlightMatValue10029.color
				end
			end

			if arg_235_1.time_ >= 0 + var_238_1 and arg_235_1.time_ < 0 + var_238_1 + arg_238_0 and not isNil(arg_235_1.actors_["10029"]) and arg_235_1.var_.highlightMatValue10029 then
				arg_235_1.var_.highlightMatValue10029.color.r = 0.5
				arg_235_1.var_.highlightMatValue10029.color.g = 0.5
				arg_235_1.var_.highlightMatValue10029.color.b = 0.5
				arg_235_1.var_.highlightMatValue10029.color = arg_235_1.var_.highlightMatValue10029.color
			end

			local var_238_3 = arg_235_1.actors_["113801_1"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_3) then
				local var_238_4 = var_238_3:GetComponent("Image")

				if var_238_4 then
					arg_235_1.var_.highlightMatValue113801_1 = var_238_4
				end
			end

			local var_238_5 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_5 and not isNil(var_238_3) then
				if arg_235_1.var_.highlightMatValue113801_1 then
					local var_238_6 = Mathf.Lerp(0.5, 1, (arg_235_1.time_ - 0) / var_238_5)

					arg_235_1.var_.highlightMatValue113801_1.color.r = var_238_6
					arg_235_1.var_.highlightMatValue113801_1.color.g = var_238_6
					arg_235_1.var_.highlightMatValue113801_1.color.b = var_238_6
					arg_235_1.var_.highlightMatValue113801_1.color = arg_235_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_235_1.time_ >= 0 + var_238_5 and arg_235_1.time_ < 0 + var_238_5 + arg_238_0 and not isNil(var_238_3) and arg_235_1.var_.highlightMatValue113801_1 then
				var_238_3.transform:SetSiblingIndex(1)

				arg_235_1.var_.highlightMatValue113801_1.color.r = 1
				arg_235_1.var_.highlightMatValue113801_1.color.g = 1
				arg_235_1.var_.highlightMatValue113801_1.color.b = 1
				arg_235_1.var_.highlightMatValue113801_1.color = arg_235_1.var_.highlightMatValue113801_1.color
			end

			local var_238_7 = 0
			local var_238_8 = 0.6

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_7 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_9 = arg_235_1:GetWordFromCfg(115311058)
				local var_238_10 = arg_235_1:FormatText(var_238_9.content)

				arg_235_1.text_.text = var_238_10

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_12 = 24 <= 0 and var_238_8 or var_238_8 * (utf8.len(var_238_10) / 24)

				if (24 <= 0 and var_238_8 or var_238_8 * (utf8.len(var_238_10) / 24)) > 0 and var_238_8 < var_238_12 then
					arg_235_1.talkMaxDuration = var_238_12

					if var_238_12 + var_238_7 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_12 + var_238_7
					end
				end

				arg_235_1.text_.text = var_238_10
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311058", "story_v_out_115311.awb") ~= 0 then
					local var_238_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311058", "story_v_out_115311.awb") / 1000

					if var_238_13 + var_238_7 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_7
					end

					if var_238_9.prefab_name ~= "" and arg_235_1.actors_[var_238_9.prefab_name] ~= nil then
						local var_238_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_9.prefab_name].transform, "story_v_out_115311", "115311058", "story_v_out_115311.awb")

						arg_235_1:RecordAudio("115311058", var_238_14)
						arg_235_1:RecordAudio("115311058", var_238_14)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_115311", "115311058", "story_v_out_115311.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_115311", "115311058", "story_v_out_115311.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_15 = math.max(var_238_8, arg_235_1.talkMaxDuration)

			if var_238_7 <= arg_235_1.time_ and arg_235_1.time_ < var_238_7 + var_238_15 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_7) / var_238_15

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_7 + var_238_15 and arg_235_1.time_ < var_238_7 + var_238_15 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play115311059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 115311059
		arg_239_1.duration_ = 19.5

		local var_239_0 = {
			ja = 19.5,
			ko = 6.433,
			zh = 7.366,
			en = 6.033
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
				arg_239_0:Play115311060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.725

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
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

				local var_242_1 = arg_239_1:GetWordFromCfg(115311059)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 29 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 29)

				if (29 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 29)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311059", "story_v_out_115311.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311059", "story_v_out_115311.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_115311", "115311059", "story_v_out_115311.awb")

						arg_239_1:RecordAudio("115311059", var_242_6)
						arg_239_1:RecordAudio("115311059", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_115311", "115311059", "story_v_out_115311.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_115311", "115311059", "story_v_out_115311.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play115311060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 115311060
		arg_243_1.duration_ = 1.57

		local var_243_0 = {
			ja = 1.133,
			ko = 1.2,
			zh = 1.533,
			en = 1.566
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
				arg_243_0:Play115311061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["10029"]) then
				local var_246_0 = arg_243_1.actors_["10029"]:GetComponent("Image")

				if var_246_0 then
					arg_243_1.var_.highlightMatValue10029 = var_246_0
				end
			end

			local var_246_1 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_1 and not isNil(arg_243_1.actors_["10029"]) then
				if arg_243_1.var_.highlightMatValue10029 then
					local var_246_2 = Mathf.Lerp(0.5, 1, (arg_243_1.time_ - 0) / var_246_1)

					arg_243_1.var_.highlightMatValue10029.color.r = var_246_2
					arg_243_1.var_.highlightMatValue10029.color.g = var_246_2
					arg_243_1.var_.highlightMatValue10029.color.b = var_246_2
					arg_243_1.var_.highlightMatValue10029.color = arg_243_1.var_.highlightMatValue10029.color
				end
			end

			if arg_243_1.time_ >= 0 + var_246_1 and arg_243_1.time_ < 0 + var_246_1 + arg_246_0 and not isNil(arg_243_1.actors_["10029"]) and arg_243_1.var_.highlightMatValue10029 then
				arg_243_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_243_1.var_.highlightMatValue10029.color.r = 1
				arg_243_1.var_.highlightMatValue10029.color.g = 1
				arg_243_1.var_.highlightMatValue10029.color.b = 1
				arg_243_1.var_.highlightMatValue10029.color = arg_243_1.var_.highlightMatValue10029.color
			end

			local var_246_3 = arg_243_1.actors_["113801_1"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_3) then
				local var_246_4 = var_246_3:GetComponent("Image")

				if var_246_4 then
					arg_243_1.var_.highlightMatValue113801_1 = var_246_4
				end
			end

			local var_246_5 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_5 and not isNil(var_246_3) then
				if arg_243_1.var_.highlightMatValue113801_1 then
					local var_246_6 = Mathf.Lerp(1, 0.5, (arg_243_1.time_ - 0) / var_246_5)

					arg_243_1.var_.highlightMatValue113801_1.color.r = var_246_6
					arg_243_1.var_.highlightMatValue113801_1.color.g = var_246_6
					arg_243_1.var_.highlightMatValue113801_1.color.b = var_246_6
					arg_243_1.var_.highlightMatValue113801_1.color = arg_243_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_243_1.time_ >= 0 + var_246_5 and arg_243_1.time_ < 0 + var_246_5 + arg_246_0 and not isNil(var_246_3) and arg_243_1.var_.highlightMatValue113801_1 then
				arg_243_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_243_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_243_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_243_1.var_.highlightMatValue113801_1.color = arg_243_1.var_.highlightMatValue113801_1.color
			end

			local var_246_7 = 0
			local var_246_8 = 0.075

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_7 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_9 = arg_243_1:GetWordFromCfg(115311060)
				local var_246_10 = arg_243_1:FormatText(var_246_9.content)

				arg_243_1.text_.text = var_246_10

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_12 = 3 <= 0 and var_246_8 or var_246_8 * (utf8.len(var_246_10) / 3)

				if (3 <= 0 and var_246_8 or var_246_8 * (utf8.len(var_246_10) / 3)) > 0 and var_246_8 < var_246_12 then
					arg_243_1.talkMaxDuration = var_246_12

					if var_246_12 + var_246_7 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_12 + var_246_7
					end
				end

				arg_243_1.text_.text = var_246_10
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311060", "story_v_out_115311.awb") ~= 0 then
					local var_246_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311060", "story_v_out_115311.awb") / 1000

					if var_246_13 + var_246_7 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_7
					end

					if var_246_9.prefab_name ~= "" and arg_243_1.actors_[var_246_9.prefab_name] ~= nil then
						local var_246_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_9.prefab_name].transform, "story_v_out_115311", "115311060", "story_v_out_115311.awb")

						arg_243_1:RecordAudio("115311060", var_246_14)
						arg_243_1:RecordAudio("115311060", var_246_14)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_115311", "115311060", "story_v_out_115311.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_115311", "115311060", "story_v_out_115311.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_15 = math.max(var_246_8, arg_243_1.talkMaxDuration)

			if var_246_7 <= arg_243_1.time_ and arg_243_1.time_ < var_246_7 + var_246_15 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_7) / var_246_15

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_7 + var_246_15 and arg_243_1.time_ < var_246_7 + var_246_15 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play115311061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 115311061
		arg_247_1.duration_ = 8.2

		local var_247_0 = {
			ja = 8.2,
			ko = 7.4,
			zh = 7.7,
			en = 8
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
				arg_247_0:Play115311062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["10029"]) then
				local var_250_0 = arg_247_1.actors_["10029"]:GetComponent("Image")

				if var_250_0 then
					arg_247_1.var_.highlightMatValue10029 = var_250_0
				end
			end

			local var_250_1 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_1 and not isNil(arg_247_1.actors_["10029"]) then
				if arg_247_1.var_.highlightMatValue10029 then
					local var_250_2 = Mathf.Lerp(1, 0.5, (arg_247_1.time_ - 0) / var_250_1)

					arg_247_1.var_.highlightMatValue10029.color.r = var_250_2
					arg_247_1.var_.highlightMatValue10029.color.g = var_250_2
					arg_247_1.var_.highlightMatValue10029.color.b = var_250_2
					arg_247_1.var_.highlightMatValue10029.color = arg_247_1.var_.highlightMatValue10029.color
				end
			end

			if arg_247_1.time_ >= 0 + var_250_1 and arg_247_1.time_ < 0 + var_250_1 + arg_250_0 and not isNil(arg_247_1.actors_["10029"]) and arg_247_1.var_.highlightMatValue10029 then
				arg_247_1.var_.highlightMatValue10029.color.r = 0.5
				arg_247_1.var_.highlightMatValue10029.color.g = 0.5
				arg_247_1.var_.highlightMatValue10029.color.b = 0.5
				arg_247_1.var_.highlightMatValue10029.color = arg_247_1.var_.highlightMatValue10029.color
			end

			local var_250_3 = arg_247_1.actors_["113801_1"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_3) then
				local var_250_4 = var_250_3:GetComponent("Image")

				if var_250_4 then
					arg_247_1.var_.highlightMatValue113801_1 = var_250_4
				end
			end

			local var_250_5 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_5 and not isNil(var_250_3) then
				if arg_247_1.var_.highlightMatValue113801_1 then
					local var_250_6 = Mathf.Lerp(0.5, 1, (arg_247_1.time_ - 0) / var_250_5)

					arg_247_1.var_.highlightMatValue113801_1.color.r = var_250_6
					arg_247_1.var_.highlightMatValue113801_1.color.g = var_250_6
					arg_247_1.var_.highlightMatValue113801_1.color.b = var_250_6
					arg_247_1.var_.highlightMatValue113801_1.color = arg_247_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_247_1.time_ >= 0 + var_250_5 and arg_247_1.time_ < 0 + var_250_5 + arg_250_0 and not isNil(var_250_3) and arg_247_1.var_.highlightMatValue113801_1 then
				var_250_3.transform:SetSiblingIndex(1)

				arg_247_1.var_.highlightMatValue113801_1.color.r = 1
				arg_247_1.var_.highlightMatValue113801_1.color.g = 1
				arg_247_1.var_.highlightMatValue113801_1.color.b = 1
				arg_247_1.var_.highlightMatValue113801_1.color = arg_247_1.var_.highlightMatValue113801_1.color
			end

			local var_250_7 = 0
			local var_250_8 = 0.7

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_7 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_9 = arg_247_1:GetWordFromCfg(115311061)
				local var_250_10 = arg_247_1:FormatText(var_250_9.content)

				arg_247_1.text_.text = var_250_10

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_12 = 28 <= 0 and var_250_8 or var_250_8 * (utf8.len(var_250_10) / 28)

				if (28 <= 0 and var_250_8 or var_250_8 * (utf8.len(var_250_10) / 28)) > 0 and var_250_8 < var_250_12 then
					arg_247_1.talkMaxDuration = var_250_12

					if var_250_12 + var_250_7 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_12 + var_250_7
					end
				end

				arg_247_1.text_.text = var_250_10
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311061", "story_v_out_115311.awb") ~= 0 then
					local var_250_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311061", "story_v_out_115311.awb") / 1000

					if var_250_13 + var_250_7 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_7
					end

					if var_250_9.prefab_name ~= "" and arg_247_1.actors_[var_250_9.prefab_name] ~= nil then
						local var_250_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_9.prefab_name].transform, "story_v_out_115311", "115311061", "story_v_out_115311.awb")

						arg_247_1:RecordAudio("115311061", var_250_14)
						arg_247_1:RecordAudio("115311061", var_250_14)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_115311", "115311061", "story_v_out_115311.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_115311", "115311061", "story_v_out_115311.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_15 = math.max(var_250_8, arg_247_1.talkMaxDuration)

			if var_250_7 <= arg_247_1.time_ and arg_247_1.time_ < var_250_7 + var_250_15 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_7) / var_250_15

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_7 + var_250_15 and arg_247_1.time_ < var_250_7 + var_250_15 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play115311062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 115311062
		arg_251_1.duration_ = 12.4

		local var_251_0 = {
			ja = 11.6,
			ko = 10.6,
			zh = 10.066,
			en = 12.4
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play115311063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["10029"]) then
				local var_254_0 = arg_251_1.actors_["10029"]:GetComponent("Image")

				if var_254_0 then
					arg_251_1.var_.highlightMatValue10029 = var_254_0
				end
			end

			local var_254_1 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_1 and not isNil(arg_251_1.actors_["10029"]) then
				if arg_251_1.var_.highlightMatValue10029 then
					local var_254_2 = Mathf.Lerp(0.5, 1, (arg_251_1.time_ - 0) / var_254_1)

					arg_251_1.var_.highlightMatValue10029.color.r = var_254_2
					arg_251_1.var_.highlightMatValue10029.color.g = var_254_2
					arg_251_1.var_.highlightMatValue10029.color.b = var_254_2
					arg_251_1.var_.highlightMatValue10029.color = arg_251_1.var_.highlightMatValue10029.color
				end
			end

			if arg_251_1.time_ >= 0 + var_254_1 and arg_251_1.time_ < 0 + var_254_1 + arg_254_0 and not isNil(arg_251_1.actors_["10029"]) and arg_251_1.var_.highlightMatValue10029 then
				arg_251_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_251_1.var_.highlightMatValue10029.color.r = 1
				arg_251_1.var_.highlightMatValue10029.color.g = 1
				arg_251_1.var_.highlightMatValue10029.color.b = 1
				arg_251_1.var_.highlightMatValue10029.color = arg_251_1.var_.highlightMatValue10029.color
			end

			local var_254_3 = arg_251_1.actors_["113801_1"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_3) then
				local var_254_4 = var_254_3:GetComponent("Image")

				if var_254_4 then
					arg_251_1.var_.highlightMatValue113801_1 = var_254_4
				end
			end

			local var_254_5 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_5 and not isNil(var_254_3) then
				if arg_251_1.var_.highlightMatValue113801_1 then
					local var_254_6 = Mathf.Lerp(1, 0.5, (arg_251_1.time_ - 0) / var_254_5)

					arg_251_1.var_.highlightMatValue113801_1.color.r = var_254_6
					arg_251_1.var_.highlightMatValue113801_1.color.g = var_254_6
					arg_251_1.var_.highlightMatValue113801_1.color.b = var_254_6
					arg_251_1.var_.highlightMatValue113801_1.color = arg_251_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_251_1.time_ >= 0 + var_254_5 and arg_251_1.time_ < 0 + var_254_5 + arg_254_0 and not isNil(var_254_3) and arg_251_1.var_.highlightMatValue113801_1 then
				arg_251_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_251_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_251_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_251_1.var_.highlightMatValue113801_1.color = arg_251_1.var_.highlightMatValue113801_1.color
			end

			local var_254_7 = 0
			local var_254_8 = 1

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_7 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_9 = arg_251_1:GetWordFromCfg(115311062)
				local var_254_10 = arg_251_1:FormatText(var_254_9.content)

				arg_251_1.text_.text = var_254_10

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_12 = 40 <= 0 and var_254_8 or var_254_8 * (utf8.len(var_254_10) / 40)

				if (40 <= 0 and var_254_8 or var_254_8 * (utf8.len(var_254_10) / 40)) > 0 and var_254_8 < var_254_12 then
					arg_251_1.talkMaxDuration = var_254_12

					if var_254_12 + var_254_7 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_12 + var_254_7
					end
				end

				arg_251_1.text_.text = var_254_10
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311062", "story_v_out_115311.awb") ~= 0 then
					local var_254_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311062", "story_v_out_115311.awb") / 1000

					if var_254_13 + var_254_7 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_7
					end

					if var_254_9.prefab_name ~= "" and arg_251_1.actors_[var_254_9.prefab_name] ~= nil then
						local var_254_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_9.prefab_name].transform, "story_v_out_115311", "115311062", "story_v_out_115311.awb")

						arg_251_1:RecordAudio("115311062", var_254_14)
						arg_251_1:RecordAudio("115311062", var_254_14)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_115311", "115311062", "story_v_out_115311.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_115311", "115311062", "story_v_out_115311.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_15 = math.max(var_254_8, arg_251_1.talkMaxDuration)

			if var_254_7 <= arg_251_1.time_ and arg_251_1.time_ < var_254_7 + var_254_15 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_7) / var_254_15

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_7 + var_254_15 and arg_251_1.time_ < var_254_7 + var_254_15 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play115311063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 115311063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play115311064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["10029"]) then
				local var_258_0 = arg_255_1.actors_["10029"]:GetComponent("Image")

				if var_258_0 then
					arg_255_1.var_.highlightMatValue10029 = var_258_0
				end
			end

			local var_258_1 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_1 and not isNil(arg_255_1.actors_["10029"]) then
				if arg_255_1.var_.highlightMatValue10029 then
					local var_258_2 = Mathf.Lerp(1, 0.5, (arg_255_1.time_ - 0) / var_258_1)

					arg_255_1.var_.highlightMatValue10029.color.r = var_258_2
					arg_255_1.var_.highlightMatValue10029.color.g = var_258_2
					arg_255_1.var_.highlightMatValue10029.color.b = var_258_2
					arg_255_1.var_.highlightMatValue10029.color = arg_255_1.var_.highlightMatValue10029.color
				end
			end

			if arg_255_1.time_ >= 0 + var_258_1 and arg_255_1.time_ < 0 + var_258_1 + arg_258_0 and not isNil(arg_255_1.actors_["10029"]) and arg_255_1.var_.highlightMatValue10029 then
				arg_255_1.var_.highlightMatValue10029.color.r = 0.5
				arg_255_1.var_.highlightMatValue10029.color.g = 0.5
				arg_255_1.var_.highlightMatValue10029.color.b = 0.5
				arg_255_1.var_.highlightMatValue10029.color = arg_255_1.var_.highlightMatValue10029.color
			end

			local var_258_3 = 0
			local var_258_4 = 1.05

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_3 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_5 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(115311063).content)

				arg_255_1.text_.text = var_258_5

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_7 = 42 <= 0 and var_258_4 or var_258_4 * (utf8.len(var_258_5) / 42)

				if (42 <= 0 and var_258_4 or var_258_4 * (utf8.len(var_258_5) / 42)) > 0 and var_258_4 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_3 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_3
					end
				end

				arg_255_1.text_.text = var_258_5
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_8 = math.max(var_258_4, arg_255_1.talkMaxDuration)

			if var_258_3 <= arg_255_1.time_ and arg_255_1.time_ < var_258_3 + var_258_8 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_3) / var_258_8

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_3 + var_258_8 and arg_255_1.time_ < var_258_3 + var_258_8 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play115311064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 115311064
		arg_259_1.duration_ = 6.37

		local var_259_0 = {
			ja = 6.166,
			ko = 6.366,
			zh = 5.266,
			en = 5.866
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
				arg_259_0:Play115311065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["10029"]) then
				local var_262_0 = arg_259_1.actors_["10029"]:GetComponent("Image")

				if var_262_0 then
					arg_259_1.var_.highlightMatValue10029 = var_262_0
				end
			end

			local var_262_1 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_1 and not isNil(arg_259_1.actors_["10029"]) then
				if arg_259_1.var_.highlightMatValue10029 then
					local var_262_2 = Mathf.Lerp(0.5, 1, (arg_259_1.time_ - 0) / var_262_1)

					arg_259_1.var_.highlightMatValue10029.color.r = var_262_2
					arg_259_1.var_.highlightMatValue10029.color.g = var_262_2
					arg_259_1.var_.highlightMatValue10029.color.b = var_262_2
					arg_259_1.var_.highlightMatValue10029.color = arg_259_1.var_.highlightMatValue10029.color
				end
			end

			if arg_259_1.time_ >= 0 + var_262_1 and arg_259_1.time_ < 0 + var_262_1 + arg_262_0 and not isNil(arg_259_1.actors_["10029"]) and arg_259_1.var_.highlightMatValue10029 then
				arg_259_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_259_1.var_.highlightMatValue10029.color.r = 1
				arg_259_1.var_.highlightMatValue10029.color.g = 1
				arg_259_1.var_.highlightMatValue10029.color.b = 1
				arg_259_1.var_.highlightMatValue10029.color = arg_259_1.var_.highlightMatValue10029.color
			end

			local var_262_3 = 0
			local var_262_4 = 0.75

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_3 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_5 = arg_259_1:GetWordFromCfg(115311064)
				local var_262_6 = arg_259_1:FormatText(var_262_5.content)

				arg_259_1.text_.text = var_262_6

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_8 = 30 <= 0 and var_262_4 or var_262_4 * (utf8.len(var_262_6) / 30)

				if (30 <= 0 and var_262_4 or var_262_4 * (utf8.len(var_262_6) / 30)) > 0 and var_262_4 < var_262_8 then
					arg_259_1.talkMaxDuration = var_262_8

					if var_262_8 + var_262_3 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_3
					end
				end

				arg_259_1.text_.text = var_262_6
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311064", "story_v_out_115311.awb") ~= 0 then
					local var_262_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311064", "story_v_out_115311.awb") / 1000

					if var_262_9 + var_262_3 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_3
					end

					if var_262_5.prefab_name ~= "" and arg_259_1.actors_[var_262_5.prefab_name] ~= nil then
						local var_262_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_5.prefab_name].transform, "story_v_out_115311", "115311064", "story_v_out_115311.awb")

						arg_259_1:RecordAudio("115311064", var_262_10)
						arg_259_1:RecordAudio("115311064", var_262_10)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_115311", "115311064", "story_v_out_115311.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_115311", "115311064", "story_v_out_115311.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_11 = math.max(var_262_4, arg_259_1.talkMaxDuration)

			if var_262_3 <= arg_259_1.time_ and arg_259_1.time_ < var_262_3 + var_262_11 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_3) / var_262_11

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_3 + var_262_11 and arg_259_1.time_ < var_262_3 + var_262_11 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play115311065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 115311065
		arg_263_1.duration_ = 2.37

		local var_263_0 = {
			ja = 1.9,
			ko = 0.999999999999,
			zh = 2.366,
			en = 1.6
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
				arg_263_0:Play115311066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["10029"]) then
				local var_266_0 = arg_263_1.actors_["10029"]:GetComponent("Image")

				if var_266_0 then
					arg_263_1.var_.highlightMatValue10029 = var_266_0
				end
			end

			local var_266_1 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_1 and not isNil(arg_263_1.actors_["10029"]) then
				if arg_263_1.var_.highlightMatValue10029 then
					local var_266_2 = Mathf.Lerp(1, 0.5, (arg_263_1.time_ - 0) / var_266_1)

					arg_263_1.var_.highlightMatValue10029.color.r = var_266_2
					arg_263_1.var_.highlightMatValue10029.color.g = var_266_2
					arg_263_1.var_.highlightMatValue10029.color.b = var_266_2
					arg_263_1.var_.highlightMatValue10029.color = arg_263_1.var_.highlightMatValue10029.color
				end
			end

			if arg_263_1.time_ >= 0 + var_266_1 and arg_263_1.time_ < 0 + var_266_1 + arg_266_0 and not isNil(arg_263_1.actors_["10029"]) and arg_263_1.var_.highlightMatValue10029 then
				arg_263_1.var_.highlightMatValue10029.color.r = 0.5
				arg_263_1.var_.highlightMatValue10029.color.g = 0.5
				arg_263_1.var_.highlightMatValue10029.color.b = 0.5
				arg_263_1.var_.highlightMatValue10029.color = arg_263_1.var_.highlightMatValue10029.color
			end

			local var_266_3 = 0
			local var_266_4 = 0.125

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_3 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[316].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_5 = arg_263_1:GetWordFromCfg(115311065)
				local var_266_6 = arg_263_1:FormatText(var_266_5.content)

				arg_263_1.text_.text = var_266_6

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_8 = 5 <= 0 and var_266_4 or var_266_4 * (utf8.len(var_266_6) / 5)

				if (5 <= 0 and var_266_4 or var_266_4 * (utf8.len(var_266_6) / 5)) > 0 and var_266_4 < var_266_8 then
					arg_263_1.talkMaxDuration = var_266_8

					if var_266_8 + var_266_3 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_3
					end
				end

				arg_263_1.text_.text = var_266_6
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311065", "story_v_out_115311.awb") ~= 0 then
					local var_266_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311065", "story_v_out_115311.awb") / 1000

					if var_266_9 + var_266_3 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_3
					end

					if var_266_5.prefab_name ~= "" and arg_263_1.actors_[var_266_5.prefab_name] ~= nil then
						local var_266_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_5.prefab_name].transform, "story_v_out_115311", "115311065", "story_v_out_115311.awb")

						arg_263_1:RecordAudio("115311065", var_266_10)
						arg_263_1:RecordAudio("115311065", var_266_10)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_115311", "115311065", "story_v_out_115311.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_115311", "115311065", "story_v_out_115311.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_11 = math.max(var_266_4, arg_263_1.talkMaxDuration)

			if var_266_3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_3 + var_266_11 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_3) / var_266_11

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_3 + var_266_11 and arg_263_1.time_ < var_266_3 + var_266_11 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play115311066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 115311066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play115311067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 1.125

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(115311066).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 45 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 45)

				if (45 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 45)) > 0 and var_270_0 < var_270_3 then
					arg_267_1.talkMaxDuration = var_270_3

					if var_270_3 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_3 + 0
					end
				end

				arg_267_1.text_.text = var_270_1
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_4 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_4

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play115311067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 115311067
		arg_271_1.duration_ = 4.6

		local var_271_0 = {
			ja = 3.366,
			ko = 4.566,
			zh = 3.166,
			en = 4.6
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
				arg_271_0:Play115311068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.4

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[316].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:GetWordFromCfg(115311067)
				local var_274_2 = arg_271_1:FormatText(var_274_1.content)

				arg_271_1.text_.text = var_274_2

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 16 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 16)

				if (16 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 16)) > 0 and var_274_0 < var_274_4 then
					arg_271_1.talkMaxDuration = var_274_4

					if var_274_4 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_4 + 0
					end
				end

				arg_271_1.text_.text = var_274_2
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311067", "story_v_out_115311.awb") ~= 0 then
					local var_274_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311067", "story_v_out_115311.awb") / 1000

					if var_274_5 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + 0
					end

					if var_274_1.prefab_name ~= "" and arg_271_1.actors_[var_274_1.prefab_name] ~= nil then
						local var_274_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_1.prefab_name].transform, "story_v_out_115311", "115311067", "story_v_out_115311.awb")

						arg_271_1:RecordAudio("115311067", var_274_6)
						arg_271_1:RecordAudio("115311067", var_274_6)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_115311", "115311067", "story_v_out_115311.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_115311", "115311067", "story_v_out_115311.awb")
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
	Play115311068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 115311068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play115311069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 1.45

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(115311068).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 58 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 58)

				if (58 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 58)) > 0 and var_278_0 < var_278_3 then
					arg_275_1.talkMaxDuration = var_278_3

					if var_278_3 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_3 + 0
					end
				end

				arg_275_1.text_.text = var_278_1
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_4 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_4

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play115311069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 115311069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play115311070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.875

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(115311069).content)

				arg_279_1.text_.text = var_282_1

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_3 = 35 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 35)

				if (35 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 35)) > 0 and var_282_0 < var_282_3 then
					arg_279_1.talkMaxDuration = var_282_3

					if var_282_3 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_3 + 0
					end
				end

				arg_279_1.text_.text = var_282_1
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_4 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_4

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play115311070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 115311070
		arg_283_1.duration_ = 17.7

		local var_283_0 = {
			ja = 17.333,
			ko = 13,
			zh = 13.4,
			en = 17.7
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
				arg_283_0:Play115311071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["113801_1"]) then
				local var_286_0 = arg_283_1.actors_["113801_1"]:GetComponent("Image")

				if var_286_0 then
					arg_283_1.var_.highlightMatValue113801_1 = var_286_0
				end
			end

			local var_286_1 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_1 and not isNil(arg_283_1.actors_["113801_1"]) then
				if arg_283_1.var_.highlightMatValue113801_1 then
					local var_286_2 = Mathf.Lerp(0.5, 1, (arg_283_1.time_ - 0) / var_286_1)

					arg_283_1.var_.highlightMatValue113801_1.color.r = var_286_2
					arg_283_1.var_.highlightMatValue113801_1.color.g = var_286_2
					arg_283_1.var_.highlightMatValue113801_1.color.b = var_286_2
					arg_283_1.var_.highlightMatValue113801_1.color = arg_283_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_283_1.time_ >= 0 + var_286_1 and arg_283_1.time_ < 0 + var_286_1 + arg_286_0 and not isNil(arg_283_1.actors_["113801_1"]) and arg_283_1.var_.highlightMatValue113801_1 then
				arg_283_1.actors_["113801_1"].transform:SetSiblingIndex(1)

				arg_283_1.var_.highlightMatValue113801_1.color.r = 1
				arg_283_1.var_.highlightMatValue113801_1.color.g = 1
				arg_283_1.var_.highlightMatValue113801_1.color.b = 1
				arg_283_1.var_.highlightMatValue113801_1.color = arg_283_1.var_.highlightMatValue113801_1.color
			end

			local var_286_3 = 0
			local var_286_4 = 1.2

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_3 + arg_286_0 then
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

				local var_286_5 = arg_283_1:GetWordFromCfg(115311070)
				local var_286_6 = arg_283_1:FormatText(var_286_5.content)

				arg_283_1.text_.text = var_286_6

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_8 = 48 <= 0 and var_286_4 or var_286_4 * (utf8.len(var_286_6) / 48)

				if (48 <= 0 and var_286_4 or var_286_4 * (utf8.len(var_286_6) / 48)) > 0 and var_286_4 < var_286_8 then
					arg_283_1.talkMaxDuration = var_286_8

					if var_286_8 + var_286_3 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_3
					end
				end

				arg_283_1.text_.text = var_286_6
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311070", "story_v_out_115311.awb") ~= 0 then
					local var_286_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311070", "story_v_out_115311.awb") / 1000

					if var_286_9 + var_286_3 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_3
					end

					if var_286_5.prefab_name ~= "" and arg_283_1.actors_[var_286_5.prefab_name] ~= nil then
						local var_286_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_5.prefab_name].transform, "story_v_out_115311", "115311070", "story_v_out_115311.awb")

						arg_283_1:RecordAudio("115311070", var_286_10)
						arg_283_1:RecordAudio("115311070", var_286_10)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_115311", "115311070", "story_v_out_115311.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_115311", "115311070", "story_v_out_115311.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_11 = math.max(var_286_4, arg_283_1.talkMaxDuration)

			if var_286_3 <= arg_283_1.time_ and arg_283_1.time_ < var_286_3 + var_286_11 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_3) / var_286_11

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_3 + var_286_11 and arg_283_1.time_ < var_286_3 + var_286_11 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play115311071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 115311071
		arg_287_1.duration_ = 9.03

		local var_287_0 = {
			ja = 8.733,
			ko = 9.033,
			zh = 8.433,
			en = 9
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
				arg_287_0:Play115311072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["113801_1"]) then
				local var_290_0 = arg_287_1.actors_["113801_1"]:GetComponent("Image")

				if var_290_0 then
					arg_287_1.var_.highlightMatValue113801_1 = var_290_0
				end
			end

			local var_290_1 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_1 and not isNil(arg_287_1.actors_["113801_1"]) then
				if arg_287_1.var_.highlightMatValue113801_1 then
					local var_290_2 = Mathf.Lerp(1, 0.5, (arg_287_1.time_ - 0) / var_290_1)

					arg_287_1.var_.highlightMatValue113801_1.color.r = var_290_2
					arg_287_1.var_.highlightMatValue113801_1.color.g = var_290_2
					arg_287_1.var_.highlightMatValue113801_1.color.b = var_290_2
					arg_287_1.var_.highlightMatValue113801_1.color = arg_287_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_287_1.time_ >= 0 + var_290_1 and arg_287_1.time_ < 0 + var_290_1 + arg_290_0 and not isNil(arg_287_1.actors_["113801_1"]) and arg_287_1.var_.highlightMatValue113801_1 then
				arg_287_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_287_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_287_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_287_1.var_.highlightMatValue113801_1.color = arg_287_1.var_.highlightMatValue113801_1.color
			end

			local var_290_3 = arg_287_1.actors_["10029"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_3) then
				local var_290_4 = var_290_3:GetComponent("Image")

				if var_290_4 then
					arg_287_1.var_.highlightMatValue10029 = var_290_4
				end
			end

			local var_290_5 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_5 and not isNil(var_290_3) then
				if arg_287_1.var_.highlightMatValue10029 then
					local var_290_6 = Mathf.Lerp(0.5, 1, (arg_287_1.time_ - 0) / var_290_5)

					arg_287_1.var_.highlightMatValue10029.color.r = var_290_6
					arg_287_1.var_.highlightMatValue10029.color.g = var_290_6
					arg_287_1.var_.highlightMatValue10029.color.b = var_290_6
					arg_287_1.var_.highlightMatValue10029.color = arg_287_1.var_.highlightMatValue10029.color
				end
			end

			if arg_287_1.time_ >= 0 + var_290_5 and arg_287_1.time_ < 0 + var_290_5 + arg_290_0 and not isNil(var_290_3) and arg_287_1.var_.highlightMatValue10029 then
				var_290_3.transform:SetSiblingIndex(1)

				arg_287_1.var_.highlightMatValue10029.color.r = 1
				arg_287_1.var_.highlightMatValue10029.color.g = 1
				arg_287_1.var_.highlightMatValue10029.color.b = 1
				arg_287_1.var_.highlightMatValue10029.color = arg_287_1.var_.highlightMatValue10029.color
			end

			local var_290_7 = 0
			local var_290_8 = 0.925

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_7 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_9 = arg_287_1:GetWordFromCfg(115311071)
				local var_290_10 = arg_287_1:FormatText(var_290_9.content)

				arg_287_1.text_.text = var_290_10

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_12 = 37 <= 0 and var_290_8 or var_290_8 * (utf8.len(var_290_10) / 37)

				if (37 <= 0 and var_290_8 or var_290_8 * (utf8.len(var_290_10) / 37)) > 0 and var_290_8 < var_290_12 then
					arg_287_1.talkMaxDuration = var_290_12

					if var_290_12 + var_290_7 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_12 + var_290_7
					end
				end

				arg_287_1.text_.text = var_290_10
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311071", "story_v_out_115311.awb") ~= 0 then
					local var_290_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311071", "story_v_out_115311.awb") / 1000

					if var_290_13 + var_290_7 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_13 + var_290_7
					end

					if var_290_9.prefab_name ~= "" and arg_287_1.actors_[var_290_9.prefab_name] ~= nil then
						local var_290_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_9.prefab_name].transform, "story_v_out_115311", "115311071", "story_v_out_115311.awb")

						arg_287_1:RecordAudio("115311071", var_290_14)
						arg_287_1:RecordAudio("115311071", var_290_14)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_115311", "115311071", "story_v_out_115311.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_115311", "115311071", "story_v_out_115311.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_15 = math.max(var_290_8, arg_287_1.talkMaxDuration)

			if var_290_7 <= arg_287_1.time_ and arg_287_1.time_ < var_290_7 + var_290_15 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_7) / var_290_15

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_7 + var_290_15 and arg_287_1.time_ < var_290_7 + var_290_15 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play115311072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 115311072
		arg_291_1.duration_ = 5.33

		local var_291_0 = {
			ja = 3,
			ko = 2.866,
			zh = 5.333,
			en = 4.133
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
				arg_291_0:Play115311073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["113801_1"]) then
				local var_294_0 = arg_291_1.actors_["113801_1"]:GetComponent("Image")

				if var_294_0 then
					arg_291_1.var_.highlightMatValue113801_1 = var_294_0
				end
			end

			local var_294_1 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_1 and not isNil(arg_291_1.actors_["113801_1"]) then
				if arg_291_1.var_.highlightMatValue113801_1 then
					local var_294_2 = Mathf.Lerp(0.5, 1, (arg_291_1.time_ - 0) / var_294_1)

					arg_291_1.var_.highlightMatValue113801_1.color.r = var_294_2
					arg_291_1.var_.highlightMatValue113801_1.color.g = var_294_2
					arg_291_1.var_.highlightMatValue113801_1.color.b = var_294_2
					arg_291_1.var_.highlightMatValue113801_1.color = arg_291_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_291_1.time_ >= 0 + var_294_1 and arg_291_1.time_ < 0 + var_294_1 + arg_294_0 and not isNil(arg_291_1.actors_["113801_1"]) and arg_291_1.var_.highlightMatValue113801_1 then
				arg_291_1.actors_["113801_1"].transform:SetSiblingIndex(1)

				arg_291_1.var_.highlightMatValue113801_1.color.r = 1
				arg_291_1.var_.highlightMatValue113801_1.color.g = 1
				arg_291_1.var_.highlightMatValue113801_1.color.b = 1
				arg_291_1.var_.highlightMatValue113801_1.color = arg_291_1.var_.highlightMatValue113801_1.color
			end

			local var_294_3 = arg_291_1.actors_["10029"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_3) then
				local var_294_4 = var_294_3:GetComponent("Image")

				if var_294_4 then
					arg_291_1.var_.highlightMatValue10029 = var_294_4
				end
			end

			local var_294_5 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_5 and not isNil(var_294_3) then
				if arg_291_1.var_.highlightMatValue10029 then
					local var_294_6 = Mathf.Lerp(1, 0.5, (arg_291_1.time_ - 0) / var_294_5)

					arg_291_1.var_.highlightMatValue10029.color.r = var_294_6
					arg_291_1.var_.highlightMatValue10029.color.g = var_294_6
					arg_291_1.var_.highlightMatValue10029.color.b = var_294_6
					arg_291_1.var_.highlightMatValue10029.color = arg_291_1.var_.highlightMatValue10029.color
				end
			end

			if arg_291_1.time_ >= 0 + var_294_5 and arg_291_1.time_ < 0 + var_294_5 + arg_294_0 and not isNil(var_294_3) and arg_291_1.var_.highlightMatValue10029 then
				arg_291_1.var_.highlightMatValue10029.color.r = 0.5
				arg_291_1.var_.highlightMatValue10029.color.g = 0.5
				arg_291_1.var_.highlightMatValue10029.color.b = 0.5
				arg_291_1.var_.highlightMatValue10029.color = arg_291_1.var_.highlightMatValue10029.color
			end

			local var_294_7 = 0
			local var_294_8 = 0.4

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

				local var_294_9 = arg_291_1:GetWordFromCfg(115311072)
				local var_294_10 = arg_291_1:FormatText(var_294_9.content)

				arg_291_1.text_.text = var_294_10

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_12 = 16 <= 0 and var_294_8 or var_294_8 * (utf8.len(var_294_10) / 16)

				if (16 <= 0 and var_294_8 or var_294_8 * (utf8.len(var_294_10) / 16)) > 0 and var_294_8 < var_294_12 then
					arg_291_1.talkMaxDuration = var_294_12

					if var_294_12 + var_294_7 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_12 + var_294_7
					end
				end

				arg_291_1.text_.text = var_294_10
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311072", "story_v_out_115311.awb") ~= 0 then
					local var_294_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311072", "story_v_out_115311.awb") / 1000

					if var_294_13 + var_294_7 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_13 + var_294_7
					end

					if var_294_9.prefab_name ~= "" and arg_291_1.actors_[var_294_9.prefab_name] ~= nil then
						local var_294_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_9.prefab_name].transform, "story_v_out_115311", "115311072", "story_v_out_115311.awb")

						arg_291_1:RecordAudio("115311072", var_294_14)
						arg_291_1:RecordAudio("115311072", var_294_14)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_115311", "115311072", "story_v_out_115311.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_115311", "115311072", "story_v_out_115311.awb")
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

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play115311073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 115311073
		arg_295_1.duration_ = 5.13

		local var_295_0 = {
			ja = 1.4,
			ko = 3.633,
			zh = 3.8,
			en = 5.133
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
				arg_295_0:Play115311074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["113801_1"]) then
				local var_298_0 = arg_295_1.actors_["113801_1"]:GetComponent("Image")

				if var_298_0 then
					arg_295_1.var_.highlightMatValue113801_1 = var_298_0
				end
			end

			local var_298_1 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_1 and not isNil(arg_295_1.actors_["113801_1"]) then
				if arg_295_1.var_.highlightMatValue113801_1 then
					local var_298_2 = Mathf.Lerp(1, 0.5, (arg_295_1.time_ - 0) / var_298_1)

					arg_295_1.var_.highlightMatValue113801_1.color.r = var_298_2
					arg_295_1.var_.highlightMatValue113801_1.color.g = var_298_2
					arg_295_1.var_.highlightMatValue113801_1.color.b = var_298_2
					arg_295_1.var_.highlightMatValue113801_1.color = arg_295_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_295_1.time_ >= 0 + var_298_1 and arg_295_1.time_ < 0 + var_298_1 + arg_298_0 and not isNil(arg_295_1.actors_["113801_1"]) and arg_295_1.var_.highlightMatValue113801_1 then
				arg_295_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_295_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_295_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_295_1.var_.highlightMatValue113801_1.color = arg_295_1.var_.highlightMatValue113801_1.color
			end

			local var_298_3 = arg_295_1.actors_["10029"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_3) then
				local var_298_4 = var_298_3:GetComponent("Image")

				if var_298_4 then
					arg_295_1.var_.highlightMatValue10029 = var_298_4
				end
			end

			local var_298_5 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_5 and not isNil(var_298_3) then
				if arg_295_1.var_.highlightMatValue10029 then
					local var_298_6 = Mathf.Lerp(0.5, 1, (arg_295_1.time_ - 0) / var_298_5)

					arg_295_1.var_.highlightMatValue10029.color.r = var_298_6
					arg_295_1.var_.highlightMatValue10029.color.g = var_298_6
					arg_295_1.var_.highlightMatValue10029.color.b = var_298_6
					arg_295_1.var_.highlightMatValue10029.color = arg_295_1.var_.highlightMatValue10029.color
				end
			end

			if arg_295_1.time_ >= 0 + var_298_5 and arg_295_1.time_ < 0 + var_298_5 + arg_298_0 and not isNil(var_298_3) and arg_295_1.var_.highlightMatValue10029 then
				var_298_3.transform:SetSiblingIndex(1)

				arg_295_1.var_.highlightMatValue10029.color.r = 1
				arg_295_1.var_.highlightMatValue10029.color.g = 1
				arg_295_1.var_.highlightMatValue10029.color.b = 1
				arg_295_1.var_.highlightMatValue10029.color = arg_295_1.var_.highlightMatValue10029.color
			end

			local var_298_7 = 0
			local var_298_8 = 0.35

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_7 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_9 = arg_295_1:GetWordFromCfg(115311073)
				local var_298_10 = arg_295_1:FormatText(var_298_9.content)

				arg_295_1.text_.text = var_298_10

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_12 = 14 <= 0 and var_298_8 or var_298_8 * (utf8.len(var_298_10) / 14)

				if (14 <= 0 and var_298_8 or var_298_8 * (utf8.len(var_298_10) / 14)) > 0 and var_298_8 < var_298_12 then
					arg_295_1.talkMaxDuration = var_298_12

					if var_298_12 + var_298_7 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_12 + var_298_7
					end
				end

				arg_295_1.text_.text = var_298_10
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311073", "story_v_out_115311.awb") ~= 0 then
					local var_298_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311073", "story_v_out_115311.awb") / 1000

					if var_298_13 + var_298_7 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_13 + var_298_7
					end

					if var_298_9.prefab_name ~= "" and arg_295_1.actors_[var_298_9.prefab_name] ~= nil then
						local var_298_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_9.prefab_name].transform, "story_v_out_115311", "115311073", "story_v_out_115311.awb")

						arg_295_1:RecordAudio("115311073", var_298_14)
						arg_295_1:RecordAudio("115311073", var_298_14)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_115311", "115311073", "story_v_out_115311.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_115311", "115311073", "story_v_out_115311.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_15 = math.max(var_298_8, arg_295_1.talkMaxDuration)

			if var_298_7 <= arg_295_1.time_ and arg_295_1.time_ < var_298_7 + var_298_15 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_7) / var_298_15

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_7 + var_298_15 and arg_295_1.time_ < var_298_7 + var_298_15 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play115311074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 115311074
		arg_299_1.duration_ = 11.4

		local var_299_0 = {
			ja = 9.233,
			ko = 11.033,
			zh = 11.4,
			en = 10.2
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
				arg_299_0:Play115311075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["113801_1"]) then
				local var_302_0 = arg_299_1.actors_["113801_1"]:GetComponent("Image")

				if var_302_0 then
					arg_299_1.var_.highlightMatValue113801_1 = var_302_0
				end
			end

			local var_302_1 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_1 and not isNil(arg_299_1.actors_["113801_1"]) then
				if arg_299_1.var_.highlightMatValue113801_1 then
					local var_302_2 = Mathf.Lerp(0.5, 1, (arg_299_1.time_ - 0) / var_302_1)

					arg_299_1.var_.highlightMatValue113801_1.color.r = var_302_2
					arg_299_1.var_.highlightMatValue113801_1.color.g = var_302_2
					arg_299_1.var_.highlightMatValue113801_1.color.b = var_302_2
					arg_299_1.var_.highlightMatValue113801_1.color = arg_299_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_299_1.time_ >= 0 + var_302_1 and arg_299_1.time_ < 0 + var_302_1 + arg_302_0 and not isNil(arg_299_1.actors_["113801_1"]) and arg_299_1.var_.highlightMatValue113801_1 then
				arg_299_1.actors_["113801_1"].transform:SetSiblingIndex(1)

				arg_299_1.var_.highlightMatValue113801_1.color.r = 1
				arg_299_1.var_.highlightMatValue113801_1.color.g = 1
				arg_299_1.var_.highlightMatValue113801_1.color.b = 1
				arg_299_1.var_.highlightMatValue113801_1.color = arg_299_1.var_.highlightMatValue113801_1.color
			end

			local var_302_3 = arg_299_1.actors_["10029"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_3) then
				local var_302_4 = var_302_3:GetComponent("Image")

				if var_302_4 then
					arg_299_1.var_.highlightMatValue10029 = var_302_4
				end
			end

			local var_302_5 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_5 and not isNil(var_302_3) then
				if arg_299_1.var_.highlightMatValue10029 then
					local var_302_6 = Mathf.Lerp(1, 0.5, (arg_299_1.time_ - 0) / var_302_5)

					arg_299_1.var_.highlightMatValue10029.color.r = var_302_6
					arg_299_1.var_.highlightMatValue10029.color.g = var_302_6
					arg_299_1.var_.highlightMatValue10029.color.b = var_302_6
					arg_299_1.var_.highlightMatValue10029.color = arg_299_1.var_.highlightMatValue10029.color
				end
			end

			if arg_299_1.time_ >= 0 + var_302_5 and arg_299_1.time_ < 0 + var_302_5 + arg_302_0 and not isNil(var_302_3) and arg_299_1.var_.highlightMatValue10029 then
				arg_299_1.var_.highlightMatValue10029.color.r = 0.5
				arg_299_1.var_.highlightMatValue10029.color.g = 0.5
				arg_299_1.var_.highlightMatValue10029.color.b = 0.5
				arg_299_1.var_.highlightMatValue10029.color = arg_299_1.var_.highlightMatValue10029.color
			end

			local var_302_7 = 0
			local var_302_8 = 1.1

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_7 + arg_302_0 then
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

				local var_302_9 = arg_299_1:GetWordFromCfg(115311074)
				local var_302_10 = arg_299_1:FormatText(var_302_9.content)

				arg_299_1.text_.text = var_302_10

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_12 = 44 <= 0 and var_302_8 or var_302_8 * (utf8.len(var_302_10) / 44)

				if (44 <= 0 and var_302_8 or var_302_8 * (utf8.len(var_302_10) / 44)) > 0 and var_302_8 < var_302_12 then
					arg_299_1.talkMaxDuration = var_302_12

					if var_302_12 + var_302_7 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_12 + var_302_7
					end
				end

				arg_299_1.text_.text = var_302_10
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311074", "story_v_out_115311.awb") ~= 0 then
					local var_302_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311074", "story_v_out_115311.awb") / 1000

					if var_302_13 + var_302_7 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_13 + var_302_7
					end

					if var_302_9.prefab_name ~= "" and arg_299_1.actors_[var_302_9.prefab_name] ~= nil then
						local var_302_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_9.prefab_name].transform, "story_v_out_115311", "115311074", "story_v_out_115311.awb")

						arg_299_1:RecordAudio("115311074", var_302_14)
						arg_299_1:RecordAudio("115311074", var_302_14)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_115311", "115311074", "story_v_out_115311.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_115311", "115311074", "story_v_out_115311.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_15 = math.max(var_302_8, arg_299_1.talkMaxDuration)

			if var_302_7 <= arg_299_1.time_ and arg_299_1.time_ < var_302_7 + var_302_15 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_7) / var_302_15

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_7 + var_302_15 and arg_299_1.time_ < var_302_7 + var_302_15 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play115311075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 115311075
		arg_303_1.duration_ = 11.7

		local var_303_0 = {
			ja = 11.7,
			ko = 7.033,
			zh = 5.6,
			en = 7.2
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
				arg_303_0:Play115311076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.6

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

				local var_306_1 = arg_303_1:GetWordFromCfg(115311075)
				local var_306_2 = arg_303_1:FormatText(var_306_1.content)

				arg_303_1.text_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 24 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 24)

				if (24 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 24)) > 0 and var_306_0 < var_306_4 then
					arg_303_1.talkMaxDuration = var_306_4

					if var_306_4 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_4 + 0
					end
				end

				arg_303_1.text_.text = var_306_2
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311075", "story_v_out_115311.awb") ~= 0 then
					local var_306_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311075", "story_v_out_115311.awb") / 1000

					if var_306_5 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + 0
					end

					if var_306_1.prefab_name ~= "" and arg_303_1.actors_[var_306_1.prefab_name] ~= nil then
						local var_306_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_1.prefab_name].transform, "story_v_out_115311", "115311075", "story_v_out_115311.awb")

						arg_303_1:RecordAudio("115311075", var_306_6)
						arg_303_1:RecordAudio("115311075", var_306_6)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_115311", "115311075", "story_v_out_115311.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_115311", "115311075", "story_v_out_115311.awb")
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
	Play115311076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 115311076
		arg_307_1.duration_ = 11.83

		local var_307_0 = {
			ja = 8.9,
			ko = 11.833,
			zh = 9.866,
			en = 11.633
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
				arg_307_0:Play115311077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["113801_1"]) then
				local var_310_0 = arg_307_1.actors_["113801_1"]:GetComponent("Image")

				if var_310_0 then
					arg_307_1.var_.highlightMatValue113801_1 = var_310_0
				end
			end

			local var_310_1 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_1 and not isNil(arg_307_1.actors_["113801_1"]) then
				if arg_307_1.var_.highlightMatValue113801_1 then
					local var_310_2 = Mathf.Lerp(1, 0.5, (arg_307_1.time_ - 0) / var_310_1)

					arg_307_1.var_.highlightMatValue113801_1.color.r = var_310_2
					arg_307_1.var_.highlightMatValue113801_1.color.g = var_310_2
					arg_307_1.var_.highlightMatValue113801_1.color.b = var_310_2
					arg_307_1.var_.highlightMatValue113801_1.color = arg_307_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_307_1.time_ >= 0 + var_310_1 and arg_307_1.time_ < 0 + var_310_1 + arg_310_0 and not isNil(arg_307_1.actors_["113801_1"]) and arg_307_1.var_.highlightMatValue113801_1 then
				arg_307_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_307_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_307_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_307_1.var_.highlightMatValue113801_1.color = arg_307_1.var_.highlightMatValue113801_1.color
			end

			local var_310_3 = arg_307_1.actors_["10029"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_3) then
				local var_310_4 = var_310_3:GetComponent("Image")

				if var_310_4 then
					arg_307_1.var_.highlightMatValue10029 = var_310_4
				end
			end

			local var_310_5 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_5 and not isNil(var_310_3) then
				if arg_307_1.var_.highlightMatValue10029 then
					local var_310_6 = Mathf.Lerp(0.5, 1, (arg_307_1.time_ - 0) / var_310_5)

					arg_307_1.var_.highlightMatValue10029.color.r = var_310_6
					arg_307_1.var_.highlightMatValue10029.color.g = var_310_6
					arg_307_1.var_.highlightMatValue10029.color.b = var_310_6
					arg_307_1.var_.highlightMatValue10029.color = arg_307_1.var_.highlightMatValue10029.color
				end
			end

			if arg_307_1.time_ >= 0 + var_310_5 and arg_307_1.time_ < 0 + var_310_5 + arg_310_0 and not isNil(var_310_3) and arg_307_1.var_.highlightMatValue10029 then
				var_310_3.transform:SetSiblingIndex(1)

				arg_307_1.var_.highlightMatValue10029.color.r = 1
				arg_307_1.var_.highlightMatValue10029.color.g = 1
				arg_307_1.var_.highlightMatValue10029.color.b = 1
				arg_307_1.var_.highlightMatValue10029.color = arg_307_1.var_.highlightMatValue10029.color
			end

			local var_310_7 = 0
			local var_310_8 = 0.925

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_7 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_9 = arg_307_1:GetWordFromCfg(115311076)
				local var_310_10 = arg_307_1:FormatText(var_310_9.content)

				arg_307_1.text_.text = var_310_10

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_12 = 37 <= 0 and var_310_8 or var_310_8 * (utf8.len(var_310_10) / 37)

				if (37 <= 0 and var_310_8 or var_310_8 * (utf8.len(var_310_10) / 37)) > 0 and var_310_8 < var_310_12 then
					arg_307_1.talkMaxDuration = var_310_12

					if var_310_12 + var_310_7 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_12 + var_310_7
					end
				end

				arg_307_1.text_.text = var_310_10
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311076", "story_v_out_115311.awb") ~= 0 then
					local var_310_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311076", "story_v_out_115311.awb") / 1000

					if var_310_13 + var_310_7 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_13 + var_310_7
					end

					if var_310_9.prefab_name ~= "" and arg_307_1.actors_[var_310_9.prefab_name] ~= nil then
						local var_310_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_9.prefab_name].transform, "story_v_out_115311", "115311076", "story_v_out_115311.awb")

						arg_307_1:RecordAudio("115311076", var_310_14)
						arg_307_1:RecordAudio("115311076", var_310_14)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_115311", "115311076", "story_v_out_115311.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_115311", "115311076", "story_v_out_115311.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_15 = math.max(var_310_8, arg_307_1.talkMaxDuration)

			if var_310_7 <= arg_307_1.time_ and arg_307_1.time_ < var_310_7 + var_310_15 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_7) / var_310_15

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_7 + var_310_15 and arg_307_1.time_ < var_310_7 + var_310_15 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play115311077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 115311077
		arg_311_1.duration_ = 12

		local var_311_0 = {
			ja = 12,
			ko = 7.466,
			zh = 7.266,
			en = 8.9
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
				arg_311_0:Play115311078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["113801_1"]) then
				local var_314_0 = arg_311_1.actors_["113801_1"]:GetComponent("Image")

				if var_314_0 then
					arg_311_1.var_.highlightMatValue113801_1 = var_314_0
				end
			end

			local var_314_1 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_1 and not isNil(arg_311_1.actors_["113801_1"]) then
				if arg_311_1.var_.highlightMatValue113801_1 then
					local var_314_2 = Mathf.Lerp(0.5, 1, (arg_311_1.time_ - 0) / var_314_1)

					arg_311_1.var_.highlightMatValue113801_1.color.r = var_314_2
					arg_311_1.var_.highlightMatValue113801_1.color.g = var_314_2
					arg_311_1.var_.highlightMatValue113801_1.color.b = var_314_2
					arg_311_1.var_.highlightMatValue113801_1.color = arg_311_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_311_1.time_ >= 0 + var_314_1 and arg_311_1.time_ < 0 + var_314_1 + arg_314_0 and not isNil(arg_311_1.actors_["113801_1"]) and arg_311_1.var_.highlightMatValue113801_1 then
				arg_311_1.actors_["113801_1"].transform:SetSiblingIndex(1)

				arg_311_1.var_.highlightMatValue113801_1.color.r = 1
				arg_311_1.var_.highlightMatValue113801_1.color.g = 1
				arg_311_1.var_.highlightMatValue113801_1.color.b = 1
				arg_311_1.var_.highlightMatValue113801_1.color = arg_311_1.var_.highlightMatValue113801_1.color
			end

			local var_314_3 = arg_311_1.actors_["10029"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_3) then
				local var_314_4 = var_314_3:GetComponent("Image")

				if var_314_4 then
					arg_311_1.var_.highlightMatValue10029 = var_314_4
				end
			end

			local var_314_5 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_5 and not isNil(var_314_3) then
				if arg_311_1.var_.highlightMatValue10029 then
					local var_314_6 = Mathf.Lerp(1, 0.5, (arg_311_1.time_ - 0) / var_314_5)

					arg_311_1.var_.highlightMatValue10029.color.r = var_314_6
					arg_311_1.var_.highlightMatValue10029.color.g = var_314_6
					arg_311_1.var_.highlightMatValue10029.color.b = var_314_6
					arg_311_1.var_.highlightMatValue10029.color = arg_311_1.var_.highlightMatValue10029.color
				end
			end

			if arg_311_1.time_ >= 0 + var_314_5 and arg_311_1.time_ < 0 + var_314_5 + arg_314_0 and not isNil(var_314_3) and arg_311_1.var_.highlightMatValue10029 then
				arg_311_1.var_.highlightMatValue10029.color.r = 0.5
				arg_311_1.var_.highlightMatValue10029.color.g = 0.5
				arg_311_1.var_.highlightMatValue10029.color.b = 0.5
				arg_311_1.var_.highlightMatValue10029.color = arg_311_1.var_.highlightMatValue10029.color
			end

			local var_314_7 = 0
			local var_314_8 = 0.7

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_7 + arg_314_0 then
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

				local var_314_9 = arg_311_1:GetWordFromCfg(115311077)
				local var_314_10 = arg_311_1:FormatText(var_314_9.content)

				arg_311_1.text_.text = var_314_10

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_12 = 28 <= 0 and var_314_8 or var_314_8 * (utf8.len(var_314_10) / 28)

				if (28 <= 0 and var_314_8 or var_314_8 * (utf8.len(var_314_10) / 28)) > 0 and var_314_8 < var_314_12 then
					arg_311_1.talkMaxDuration = var_314_12

					if var_314_12 + var_314_7 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_12 + var_314_7
					end
				end

				arg_311_1.text_.text = var_314_10
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311077", "story_v_out_115311.awb") ~= 0 then
					local var_314_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311077", "story_v_out_115311.awb") / 1000

					if var_314_13 + var_314_7 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_13 + var_314_7
					end

					if var_314_9.prefab_name ~= "" and arg_311_1.actors_[var_314_9.prefab_name] ~= nil then
						local var_314_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_9.prefab_name].transform, "story_v_out_115311", "115311077", "story_v_out_115311.awb")

						arg_311_1:RecordAudio("115311077", var_314_14)
						arg_311_1:RecordAudio("115311077", var_314_14)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_115311", "115311077", "story_v_out_115311.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_115311", "115311077", "story_v_out_115311.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_15 = math.max(var_314_8, arg_311_1.talkMaxDuration)

			if var_314_7 <= arg_311_1.time_ and arg_311_1.time_ < var_314_7 + var_314_15 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_7) / var_314_15

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_7 + var_314_15 and arg_311_1.time_ < var_314_7 + var_314_15 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play115311078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 115311078
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play115311079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["113801_1"]) then
				local var_318_0 = arg_315_1.actors_["113801_1"]:GetComponent("Image")

				if var_318_0 then
					arg_315_1.var_.highlightMatValue113801_1 = var_318_0
				end
			end

			local var_318_1 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_1 and not isNil(arg_315_1.actors_["113801_1"]) then
				if arg_315_1.var_.highlightMatValue113801_1 then
					local var_318_2 = Mathf.Lerp(1, 0.5, (arg_315_1.time_ - 0) / var_318_1)

					arg_315_1.var_.highlightMatValue113801_1.color.r = var_318_2
					arg_315_1.var_.highlightMatValue113801_1.color.g = var_318_2
					arg_315_1.var_.highlightMatValue113801_1.color.b = var_318_2
					arg_315_1.var_.highlightMatValue113801_1.color = arg_315_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_315_1.time_ >= 0 + var_318_1 and arg_315_1.time_ < 0 + var_318_1 + arg_318_0 and not isNil(arg_315_1.actors_["113801_1"]) and arg_315_1.var_.highlightMatValue113801_1 then
				arg_315_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_315_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_315_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_315_1.var_.highlightMatValue113801_1.color = arg_315_1.var_.highlightMatValue113801_1.color
			end

			local var_318_3 = 0
			local var_318_4 = 1.4

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_3 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_5 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(115311078).content)

				arg_315_1.text_.text = var_318_5

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_7 = 56 <= 0 and var_318_4 or var_318_4 * (utf8.len(var_318_5) / 56)

				if (56 <= 0 and var_318_4 or var_318_4 * (utf8.len(var_318_5) / 56)) > 0 and var_318_4 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_3 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_3
					end
				end

				arg_315_1.text_.text = var_318_5
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_8 = math.max(var_318_4, arg_315_1.talkMaxDuration)

			if var_318_3 <= arg_315_1.time_ and arg_315_1.time_ < var_318_3 + var_318_8 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_3) / var_318_8

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_3 + var_318_8 and arg_315_1.time_ < var_318_3 + var_318_8 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play115311079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 115311079
		arg_319_1.duration_ = 7.23

		local var_319_0 = {
			ja = 6.2,
			ko = 7.233,
			zh = 7.2,
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
				arg_319_0:Play115311080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["113801_1"]) then
				local var_322_0 = arg_319_1.actors_["113801_1"]:GetComponent("Image")

				if var_322_0 then
					arg_319_1.var_.highlightMatValue113801_1 = var_322_0
				end
			end

			local var_322_1 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_1 and not isNil(arg_319_1.actors_["113801_1"]) then
				if arg_319_1.var_.highlightMatValue113801_1 then
					local var_322_2 = Mathf.Lerp(0.5, 1, (arg_319_1.time_ - 0) / var_322_1)

					arg_319_1.var_.highlightMatValue113801_1.color.r = var_322_2
					arg_319_1.var_.highlightMatValue113801_1.color.g = var_322_2
					arg_319_1.var_.highlightMatValue113801_1.color.b = var_322_2
					arg_319_1.var_.highlightMatValue113801_1.color = arg_319_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_319_1.time_ >= 0 + var_322_1 and arg_319_1.time_ < 0 + var_322_1 + arg_322_0 and not isNil(arg_319_1.actors_["113801_1"]) and arg_319_1.var_.highlightMatValue113801_1 then
				arg_319_1.actors_["113801_1"].transform:SetSiblingIndex(1)

				arg_319_1.var_.highlightMatValue113801_1.color.r = 1
				arg_319_1.var_.highlightMatValue113801_1.color.g = 1
				arg_319_1.var_.highlightMatValue113801_1.color.b = 1
				arg_319_1.var_.highlightMatValue113801_1.color = arg_319_1.var_.highlightMatValue113801_1.color
			end

			local var_322_3 = 0
			local var_322_4 = 0.675

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_3 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_5 = arg_319_1:GetWordFromCfg(115311079)
				local var_322_6 = arg_319_1:FormatText(var_322_5.content)

				arg_319_1.text_.text = var_322_6

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_8 = 27 <= 0 and var_322_4 or var_322_4 * (utf8.len(var_322_6) / 27)

				if (27 <= 0 and var_322_4 or var_322_4 * (utf8.len(var_322_6) / 27)) > 0 and var_322_4 < var_322_8 then
					arg_319_1.talkMaxDuration = var_322_8

					if var_322_8 + var_322_3 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_8 + var_322_3
					end
				end

				arg_319_1.text_.text = var_322_6
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311079", "story_v_out_115311.awb") ~= 0 then
					local var_322_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311079", "story_v_out_115311.awb") / 1000

					if var_322_9 + var_322_3 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_3
					end

					if var_322_5.prefab_name ~= "" and arg_319_1.actors_[var_322_5.prefab_name] ~= nil then
						local var_322_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_5.prefab_name].transform, "story_v_out_115311", "115311079", "story_v_out_115311.awb")

						arg_319_1:RecordAudio("115311079", var_322_10)
						arg_319_1:RecordAudio("115311079", var_322_10)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_115311", "115311079", "story_v_out_115311.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_115311", "115311079", "story_v_out_115311.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_11 = math.max(var_322_4, arg_319_1.talkMaxDuration)

			if var_322_3 <= arg_319_1.time_ and arg_319_1.time_ < var_322_3 + var_322_11 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_3) / var_322_11

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_3 + var_322_11 and arg_319_1.time_ < var_322_3 + var_322_11 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play115311080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 115311080
		arg_323_1.duration_ = 7.47

		local var_323_0 = {
			ja = 4.066,
			ko = 6.433,
			zh = 5.8,
			en = 7.466
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
				arg_323_0:Play115311081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["113801_1"]) then
				local var_326_0 = arg_323_1.actors_["113801_1"]:GetComponent("Image")

				if var_326_0 then
					arg_323_1.var_.highlightMatValue113801_1 = var_326_0
				end
			end

			local var_326_1 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_1 and not isNil(arg_323_1.actors_["113801_1"]) then
				if arg_323_1.var_.highlightMatValue113801_1 then
					local var_326_2 = Mathf.Lerp(1, 0.5, (arg_323_1.time_ - 0) / var_326_1)

					arg_323_1.var_.highlightMatValue113801_1.color.r = var_326_2
					arg_323_1.var_.highlightMatValue113801_1.color.g = var_326_2
					arg_323_1.var_.highlightMatValue113801_1.color.b = var_326_2
					arg_323_1.var_.highlightMatValue113801_1.color = arg_323_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_323_1.time_ >= 0 + var_326_1 and arg_323_1.time_ < 0 + var_326_1 + arg_326_0 and not isNil(arg_323_1.actors_["113801_1"]) and arg_323_1.var_.highlightMatValue113801_1 then
				arg_323_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_323_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_323_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_323_1.var_.highlightMatValue113801_1.color = arg_323_1.var_.highlightMatValue113801_1.color
			end

			local var_326_3 = arg_323_1.actors_["10029"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_3) then
				local var_326_4 = var_326_3:GetComponent("Image")

				if var_326_4 then
					arg_323_1.var_.highlightMatValue10029 = var_326_4
				end
			end

			local var_326_5 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_5 and not isNil(var_326_3) then
				if arg_323_1.var_.highlightMatValue10029 then
					local var_326_6 = Mathf.Lerp(0.5, 1, (arg_323_1.time_ - 0) / var_326_5)

					arg_323_1.var_.highlightMatValue10029.color.r = var_326_6
					arg_323_1.var_.highlightMatValue10029.color.g = var_326_6
					arg_323_1.var_.highlightMatValue10029.color.b = var_326_6
					arg_323_1.var_.highlightMatValue10029.color = arg_323_1.var_.highlightMatValue10029.color
				end
			end

			if arg_323_1.time_ >= 0 + var_326_5 and arg_323_1.time_ < 0 + var_326_5 + arg_326_0 and not isNil(var_326_3) and arg_323_1.var_.highlightMatValue10029 then
				var_326_3.transform:SetSiblingIndex(1)

				arg_323_1.var_.highlightMatValue10029.color.r = 1
				arg_323_1.var_.highlightMatValue10029.color.g = 1
				arg_323_1.var_.highlightMatValue10029.color.b = 1
				arg_323_1.var_.highlightMatValue10029.color = arg_323_1.var_.highlightMatValue10029.color
			end

			local var_326_7 = 0
			local var_326_8 = 0.5

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_7 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_9 = arg_323_1:GetWordFromCfg(115311080)
				local var_326_10 = arg_323_1:FormatText(var_326_9.content)

				arg_323_1.text_.text = var_326_10

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_12 = 20 <= 0 and var_326_8 or var_326_8 * (utf8.len(var_326_10) / 20)

				if (20 <= 0 and var_326_8 or var_326_8 * (utf8.len(var_326_10) / 20)) > 0 and var_326_8 < var_326_12 then
					arg_323_1.talkMaxDuration = var_326_12

					if var_326_12 + var_326_7 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_12 + var_326_7
					end
				end

				arg_323_1.text_.text = var_326_10
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311080", "story_v_out_115311.awb") ~= 0 then
					local var_326_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311080", "story_v_out_115311.awb") / 1000

					if var_326_13 + var_326_7 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_7
					end

					if var_326_9.prefab_name ~= "" and arg_323_1.actors_[var_326_9.prefab_name] ~= nil then
						local var_326_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_9.prefab_name].transform, "story_v_out_115311", "115311080", "story_v_out_115311.awb")

						arg_323_1:RecordAudio("115311080", var_326_14)
						arg_323_1:RecordAudio("115311080", var_326_14)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_115311", "115311080", "story_v_out_115311.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_115311", "115311080", "story_v_out_115311.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_15 = math.max(var_326_8, arg_323_1.talkMaxDuration)

			if var_326_7 <= arg_323_1.time_ and arg_323_1.time_ < var_326_7 + var_326_15 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_7) / var_326_15

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_7 + var_326_15 and arg_323_1.time_ < var_326_7 + var_326_15 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play115311081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 115311081
		arg_327_1.duration_ = 14.33

		local var_327_0 = {
			ja = 12.9,
			ko = 14.333,
			zh = 10.066,
			en = 13
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
				arg_327_0:Play115311082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 1.15

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_1 = arg_327_1:GetWordFromCfg(115311081)
				local var_330_2 = arg_327_1:FormatText(var_330_1.content)

				arg_327_1.text_.text = var_330_2

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 45 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 45)

				if (45 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 45)) > 0 and var_330_0 < var_330_4 then
					arg_327_1.talkMaxDuration = var_330_4

					if var_330_4 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_4 + 0
					end
				end

				arg_327_1.text_.text = var_330_2
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311081", "story_v_out_115311.awb") ~= 0 then
					local var_330_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311081", "story_v_out_115311.awb") / 1000

					if var_330_5 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + 0
					end

					if var_330_1.prefab_name ~= "" and arg_327_1.actors_[var_330_1.prefab_name] ~= nil then
						local var_330_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_1.prefab_name].transform, "story_v_out_115311", "115311081", "story_v_out_115311.awb")

						arg_327_1:RecordAudio("115311081", var_330_6)
						arg_327_1:RecordAudio("115311081", var_330_6)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_115311", "115311081", "story_v_out_115311.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_115311", "115311081", "story_v_out_115311.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play115311082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 115311082
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play115311083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["10029"]) then
				local var_334_0 = arg_331_1.actors_["10029"]:GetComponent("Image")

				if var_334_0 then
					arg_331_1.var_.highlightMatValue10029 = var_334_0
				end
			end

			local var_334_1 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_1 and not isNil(arg_331_1.actors_["10029"]) then
				if arg_331_1.var_.highlightMatValue10029 then
					local var_334_2 = Mathf.Lerp(1, 0.5, (arg_331_1.time_ - 0) / var_334_1)

					arg_331_1.var_.highlightMatValue10029.color.r = var_334_2
					arg_331_1.var_.highlightMatValue10029.color.g = var_334_2
					arg_331_1.var_.highlightMatValue10029.color.b = var_334_2
					arg_331_1.var_.highlightMatValue10029.color = arg_331_1.var_.highlightMatValue10029.color
				end
			end

			if arg_331_1.time_ >= 0 + var_334_1 and arg_331_1.time_ < 0 + var_334_1 + arg_334_0 and not isNil(arg_331_1.actors_["10029"]) and arg_331_1.var_.highlightMatValue10029 then
				arg_331_1.var_.highlightMatValue10029.color.r = 0.5
				arg_331_1.var_.highlightMatValue10029.color.g = 0.5
				arg_331_1.var_.highlightMatValue10029.color.b = 0.5
				arg_331_1.var_.highlightMatValue10029.color = arg_331_1.var_.highlightMatValue10029.color
			end

			local var_334_3 = 0
			local var_334_4 = 1

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_3 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_5 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(115311082).content)

				arg_331_1.text_.text = var_334_5

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_7 = 40 <= 0 and var_334_4 or var_334_4 * (utf8.len(var_334_5) / 40)

				if (40 <= 0 and var_334_4 or var_334_4 * (utf8.len(var_334_5) / 40)) > 0 and var_334_4 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_3 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_3
					end
				end

				arg_331_1.text_.text = var_334_5
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_8 = math.max(var_334_4, arg_331_1.talkMaxDuration)

			if var_334_3 <= arg_331_1.time_ and arg_331_1.time_ < var_334_3 + var_334_8 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_3) / var_334_8

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_3 + var_334_8 and arg_331_1.time_ < var_334_3 + var_334_8 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play115311083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 115311083
		arg_335_1.duration_ = 2.87

		local var_335_0 = {
			ja = 2.866,
			ko = 2.533,
			zh = 2.566,
			en = 2.3
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
				arg_335_0:Play115311084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				local var_338_0 = arg_335_1.actors_["10029"]:GetComponent("Image")

				if var_338_0 then
					arg_335_1.var_.alphaMatValue10029 = var_338_0
					arg_335_1.var_.alphaOldValue10029 = var_338_0.color.a
				end

				arg_335_1.var_.alphaOldValue10029 = 1
			end

			local var_338_1 = 0.5

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_1 then
				if arg_335_1.var_.alphaMatValue10029 then
					arg_335_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_335_1.var_.alphaOldValue10029, 0, (arg_335_1.time_ - 0) / var_338_1)
					arg_335_1.var_.alphaMatValue10029.color = arg_335_1.var_.alphaMatValue10029.color
				end
			end

			if arg_335_1.time_ >= 0 + var_338_1 and arg_335_1.time_ < 0 + var_338_1 + arg_338_0 and arg_335_1.var_.alphaMatValue10029 then
				arg_335_1.var_.alphaMatValue10029.color.a = 0
				arg_335_1.var_.alphaMatValue10029.color = arg_335_1.var_.alphaMatValue10029.color
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				local var_338_2 = arg_335_1.actors_["113801_1"]:GetComponent("Image")

				if var_338_2 then
					arg_335_1.var_.alphaMatValue113801_1 = var_338_2
					arg_335_1.var_.alphaOldValue113801_1 = var_338_2.color.a
				end

				arg_335_1.var_.alphaOldValue113801_1 = 1
			end

			local var_338_3 = 0.5

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_3 then
				if arg_335_1.var_.alphaMatValue113801_1 then
					arg_335_1.var_.alphaMatValue113801_1.color.a = Mathf.Lerp(arg_335_1.var_.alphaOldValue113801_1, 0, (arg_335_1.time_ - 0) / var_338_3)
					arg_335_1.var_.alphaMatValue113801_1.color = arg_335_1.var_.alphaMatValue113801_1.color
				end
			end

			if arg_335_1.time_ >= 0 + var_338_3 and arg_335_1.time_ < 0 + var_338_3 + arg_338_0 and arg_335_1.var_.alphaMatValue113801_1 then
				arg_335_1.var_.alphaMatValue113801_1.color.a = 0
				arg_335_1.var_.alphaMatValue113801_1.color = arg_335_1.var_.alphaMatValue113801_1.color
			end

			local var_338_4 = 0
			local var_338_5 = 0.225

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_4 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[316].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_6 = arg_335_1:GetWordFromCfg(115311083)
				local var_338_7 = arg_335_1:FormatText(var_338_6.content)

				arg_335_1.text_.text = var_338_7

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_9 = 9 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_7) / 9)

				if (9 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_7) / 9)) > 0 and var_338_5 < var_338_9 then
					arg_335_1.talkMaxDuration = var_338_9

					if var_338_9 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_9 + var_338_4
					end
				end

				arg_335_1.text_.text = var_338_7
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311083", "story_v_out_115311.awb") ~= 0 then
					local var_338_10 = manager.audio:GetVoiceLength("story_v_out_115311", "115311083", "story_v_out_115311.awb") / 1000

					if var_338_10 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_10 + var_338_4
					end

					if var_338_6.prefab_name ~= "" and arg_335_1.actors_[var_338_6.prefab_name] ~= nil then
						local var_338_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_6.prefab_name].transform, "story_v_out_115311", "115311083", "story_v_out_115311.awb")

						arg_335_1:RecordAudio("115311083", var_338_11)
						arg_335_1:RecordAudio("115311083", var_338_11)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_115311", "115311083", "story_v_out_115311.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_115311", "115311083", "story_v_out_115311.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_12 = math.max(var_338_5, arg_335_1.talkMaxDuration)

			if var_338_4 <= arg_335_1.time_ and arg_335_1.time_ < var_338_4 + var_338_12 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_4) / var_338_12

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_4 + var_338_12 and arg_335_1.time_ < var_338_4 + var_338_12 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play115311084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 115311084
		arg_339_1.duration_ = 6.1

		local var_339_0 = {
			ja = 6.1,
			ko = 5.366,
			zh = 4,
			en = 5.366
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
				arg_339_0:Play115311085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.55

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_1 = arg_339_1:GetWordFromCfg(115311084)
				local var_342_2 = arg_339_1:FormatText(var_342_1.content)

				arg_339_1.text_.text = var_342_2

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 22 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 22)

				if (22 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 22)) > 0 and var_342_0 < var_342_4 then
					arg_339_1.talkMaxDuration = var_342_4

					if var_342_4 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_4 + 0
					end
				end

				arg_339_1.text_.text = var_342_2
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311084", "story_v_out_115311.awb") ~= 0 then
					local var_342_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311084", "story_v_out_115311.awb") / 1000

					if var_342_5 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + 0
					end

					if var_342_1.prefab_name ~= "" and arg_339_1.actors_[var_342_1.prefab_name] ~= nil then
						local var_342_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_1.prefab_name].transform, "story_v_out_115311", "115311084", "story_v_out_115311.awb")

						arg_339_1:RecordAudio("115311084", var_342_6)
						arg_339_1:RecordAudio("115311084", var_342_6)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_115311", "115311084", "story_v_out_115311.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_115311", "115311084", "story_v_out_115311.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_7 and arg_339_1.time_ < 0 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play115311085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 115311085
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play115311086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 1.5

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_1 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(115311085).content)

				arg_343_1.text_.text = var_346_1

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_3 = 60 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 60)

				if (60 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 60)) > 0 and var_346_0 < var_346_3 then
					arg_343_1.talkMaxDuration = var_346_3

					if var_346_3 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_3 + 0
					end
				end

				arg_343_1.text_.text = var_346_1
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_4 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_4

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play115311086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 115311086
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play115311087(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 1.15

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_1 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(115311086).content)

				arg_347_1.text_.text = var_350_1

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_3 = 46 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_1) / 46)

				if (46 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_1) / 46)) > 0 and var_350_0 < var_350_3 then
					arg_347_1.talkMaxDuration = var_350_3

					if var_350_3 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_3 + 0
					end
				end

				arg_347_1.text_.text = var_350_1
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_4 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_4 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_4

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_4 and arg_347_1.time_ < 0 + var_350_4 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play115311087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 115311087
		arg_351_1.duration_ = 7.77

		local var_351_0 = {
			ja = 6.7,
			ko = 7.766,
			zh = 7.166,
			en = 5.366
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
				arg_351_0:Play115311088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				local var_354_0 = arg_351_1.actors_["10029"]:GetComponent("Image")

				if var_354_0 then
					arg_351_1.var_.alphaMatValue10029 = var_354_0
					arg_351_1.var_.alphaOldValue10029 = var_354_0.color.a
				end

				arg_351_1.var_.alphaOldValue10029 = 0
			end

			local var_354_1 = 0.5

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_1 then
				if arg_351_1.var_.alphaMatValue10029 then
					arg_351_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_351_1.var_.alphaOldValue10029, 1, (arg_351_1.time_ - 0) / var_354_1)
					arg_351_1.var_.alphaMatValue10029.color = arg_351_1.var_.alphaMatValue10029.color
				end
			end

			if arg_351_1.time_ >= 0 + var_354_1 and arg_351_1.time_ < 0 + var_354_1 + arg_354_0 and arg_351_1.var_.alphaMatValue10029 then
				arg_351_1.var_.alphaMatValue10029.color.a = 1
				arg_351_1.var_.alphaMatValue10029.color = arg_351_1.var_.alphaMatValue10029.color
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				local var_354_2 = arg_351_1.actors_["113801_1"]:GetComponent("Image")

				if var_354_2 then
					arg_351_1.var_.alphaMatValue113801_1 = var_354_2
					arg_351_1.var_.alphaOldValue113801_1 = var_354_2.color.a
				end

				arg_351_1.var_.alphaOldValue113801_1 = 0
			end

			local var_354_3 = 0.5

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_3 then
				if arg_351_1.var_.alphaMatValue113801_1 then
					arg_351_1.var_.alphaMatValue113801_1.color.a = Mathf.Lerp(arg_351_1.var_.alphaOldValue113801_1, 1, (arg_351_1.time_ - 0) / var_354_3)
					arg_351_1.var_.alphaMatValue113801_1.color = arg_351_1.var_.alphaMatValue113801_1.color
				end
			end

			if arg_351_1.time_ >= 0 + var_354_3 and arg_351_1.time_ < 0 + var_354_3 + arg_354_0 and arg_351_1.var_.alphaMatValue113801_1 then
				arg_351_1.var_.alphaMatValue113801_1.color.a = 1
				arg_351_1.var_.alphaMatValue113801_1.color = arg_351_1.var_.alphaMatValue113801_1.color
			end

			local var_354_4 = arg_351_1.actors_["113801_1"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_4) then
				local var_354_5 = var_354_4:GetComponent("Image")

				if var_354_5 then
					arg_351_1.var_.highlightMatValue113801_1 = var_354_5
				end
			end

			local var_354_6 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_6 and not isNil(var_354_4) then
				if arg_351_1.var_.highlightMatValue113801_1 then
					local var_354_7 = Mathf.Lerp(0.5, 1, (arg_351_1.time_ - 0) / var_354_6)

					arg_351_1.var_.highlightMatValue113801_1.color.r = var_354_7
					arg_351_1.var_.highlightMatValue113801_1.color.g = var_354_7
					arg_351_1.var_.highlightMatValue113801_1.color.b = var_354_7
					arg_351_1.var_.highlightMatValue113801_1.color = arg_351_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_351_1.time_ >= 0 + var_354_6 and arg_351_1.time_ < 0 + var_354_6 + arg_354_0 and not isNil(var_354_4) and arg_351_1.var_.highlightMatValue113801_1 then
				var_354_4.transform:SetSiblingIndex(1)

				arg_351_1.var_.highlightMatValue113801_1.color.r = 1
				arg_351_1.var_.highlightMatValue113801_1.color.g = 1
				arg_351_1.var_.highlightMatValue113801_1.color.b = 1
				arg_351_1.var_.highlightMatValue113801_1.color = arg_351_1.var_.highlightMatValue113801_1.color
			end

			local var_354_8 = 0
			local var_354_9 = 0.575

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_8 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_10 = arg_351_1:GetWordFromCfg(115311087)
				local var_354_11 = arg_351_1:FormatText(var_354_10.content)

				arg_351_1.text_.text = var_354_11

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_13 = 23 <= 0 and var_354_9 or var_354_9 * (utf8.len(var_354_11) / 23)

				if (23 <= 0 and var_354_9 or var_354_9 * (utf8.len(var_354_11) / 23)) > 0 and var_354_9 < var_354_13 then
					arg_351_1.talkMaxDuration = var_354_13

					if var_354_13 + var_354_8 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_13 + var_354_8
					end
				end

				arg_351_1.text_.text = var_354_11
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311087", "story_v_out_115311.awb") ~= 0 then
					local var_354_14 = manager.audio:GetVoiceLength("story_v_out_115311", "115311087", "story_v_out_115311.awb") / 1000

					if var_354_14 + var_354_8 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_14 + var_354_8
					end

					if var_354_10.prefab_name ~= "" and arg_351_1.actors_[var_354_10.prefab_name] ~= nil then
						local var_354_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_10.prefab_name].transform, "story_v_out_115311", "115311087", "story_v_out_115311.awb")

						arg_351_1:RecordAudio("115311087", var_354_15)
						arg_351_1:RecordAudio("115311087", var_354_15)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_115311", "115311087", "story_v_out_115311.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_115311", "115311087", "story_v_out_115311.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_16 = math.max(var_354_9, arg_351_1.talkMaxDuration)

			if var_354_8 <= arg_351_1.time_ and arg_351_1.time_ < var_354_8 + var_354_16 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_8) / var_354_16

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_8 + var_354_16 and arg_351_1.time_ < var_354_8 + var_354_16 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play115311088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 115311088
		arg_355_1.duration_ = 20.53

		local var_355_0 = {
			ja = 20.533,
			ko = 12.133,
			zh = 14.733,
			en = 16.2
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
				arg_355_0:Play115311089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1.2

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:GetWordFromCfg(115311088)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 48 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 48)

				if (48 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 48)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311088", "story_v_out_115311.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311088", "story_v_out_115311.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_out_115311", "115311088", "story_v_out_115311.awb")

						arg_355_1:RecordAudio("115311088", var_358_6)
						arg_355_1:RecordAudio("115311088", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_115311", "115311088", "story_v_out_115311.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_115311", "115311088", "story_v_out_115311.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_7 and arg_355_1.time_ < 0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play115311089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 115311089
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play115311090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["113801_1"]) then
				local var_362_0 = arg_359_1.actors_["113801_1"]:GetComponent("Image")

				if var_362_0 then
					arg_359_1.var_.highlightMatValue113801_1 = var_362_0
				end
			end

			local var_362_1 = 0.2

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_1 and not isNil(arg_359_1.actors_["113801_1"]) then
				if arg_359_1.var_.highlightMatValue113801_1 then
					local var_362_2 = Mathf.Lerp(1, 0.5, (arg_359_1.time_ - 0) / var_362_1)

					arg_359_1.var_.highlightMatValue113801_1.color.r = var_362_2
					arg_359_1.var_.highlightMatValue113801_1.color.g = var_362_2
					arg_359_1.var_.highlightMatValue113801_1.color.b = var_362_2
					arg_359_1.var_.highlightMatValue113801_1.color = arg_359_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_359_1.time_ >= 0 + var_362_1 and arg_359_1.time_ < 0 + var_362_1 + arg_362_0 and not isNil(arg_359_1.actors_["113801_1"]) and arg_359_1.var_.highlightMatValue113801_1 then
				arg_359_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_359_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_359_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_359_1.var_.highlightMatValue113801_1.color = arg_359_1.var_.highlightMatValue113801_1.color
			end

			local var_362_3 = 0
			local var_362_4 = 1.325

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_3 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_5 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(115311089).content)

				arg_359_1.text_.text = var_362_5

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_7 = 53 <= 0 and var_362_4 or var_362_4 * (utf8.len(var_362_5) / 53)

				if (53 <= 0 and var_362_4 or var_362_4 * (utf8.len(var_362_5) / 53)) > 0 and var_362_4 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_3 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_3
					end
				end

				arg_359_1.text_.text = var_362_5
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_8 = math.max(var_362_4, arg_359_1.talkMaxDuration)

			if var_362_3 <= arg_359_1.time_ and arg_359_1.time_ < var_362_3 + var_362_8 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_3) / var_362_8

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_3 + var_362_8 and arg_359_1.time_ < var_362_3 + var_362_8 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play115311090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 115311090
		arg_363_1.duration_ = 3.1

		local var_363_0 = {
			ja = 1.266,
			ko = 1.666,
			zh = 1.8,
			en = 3.1
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
				arg_363_0:Play115311091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["10029"]) then
				local var_366_0 = arg_363_1.actors_["10029"]:GetComponent("Image")

				if var_366_0 then
					arg_363_1.var_.highlightMatValue10029 = var_366_0
				end
			end

			local var_366_1 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_1 and not isNil(arg_363_1.actors_["10029"]) then
				if arg_363_1.var_.highlightMatValue10029 then
					local var_366_2 = Mathf.Lerp(0.5, 1, (arg_363_1.time_ - 0) / var_366_1)

					arg_363_1.var_.highlightMatValue10029.color.r = var_366_2
					arg_363_1.var_.highlightMatValue10029.color.g = var_366_2
					arg_363_1.var_.highlightMatValue10029.color.b = var_366_2
					arg_363_1.var_.highlightMatValue10029.color = arg_363_1.var_.highlightMatValue10029.color
				end
			end

			if arg_363_1.time_ >= 0 + var_366_1 and arg_363_1.time_ < 0 + var_366_1 + arg_366_0 and not isNil(arg_363_1.actors_["10029"]) and arg_363_1.var_.highlightMatValue10029 then
				arg_363_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_363_1.var_.highlightMatValue10029.color.r = 1
				arg_363_1.var_.highlightMatValue10029.color.g = 1
				arg_363_1.var_.highlightMatValue10029.color.b = 1
				arg_363_1.var_.highlightMatValue10029.color = arg_363_1.var_.highlightMatValue10029.color
			end

			local var_366_3 = 0
			local var_366_4 = 0.1

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_3 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_5 = arg_363_1:GetWordFromCfg(115311090)
				local var_366_6 = arg_363_1:FormatText(var_366_5.content)

				arg_363_1.text_.text = var_366_6

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_8 = 4 <= 0 and var_366_4 or var_366_4 * (utf8.len(var_366_6) / 4)

				if (4 <= 0 and var_366_4 or var_366_4 * (utf8.len(var_366_6) / 4)) > 0 and var_366_4 < var_366_8 then
					arg_363_1.talkMaxDuration = var_366_8

					if var_366_8 + var_366_3 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_3
					end
				end

				arg_363_1.text_.text = var_366_6
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311090", "story_v_out_115311.awb") ~= 0 then
					local var_366_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311090", "story_v_out_115311.awb") / 1000

					if var_366_9 + var_366_3 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_9 + var_366_3
					end

					if var_366_5.prefab_name ~= "" and arg_363_1.actors_[var_366_5.prefab_name] ~= nil then
						local var_366_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_5.prefab_name].transform, "story_v_out_115311", "115311090", "story_v_out_115311.awb")

						arg_363_1:RecordAudio("115311090", var_366_10)
						arg_363_1:RecordAudio("115311090", var_366_10)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_115311", "115311090", "story_v_out_115311.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_115311", "115311090", "story_v_out_115311.awb")
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
	Play115311091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 115311091
		arg_367_1.duration_ = 5.67

		local var_367_0 = {
			ja = 5,
			ko = 4.733,
			zh = 3.133,
			en = 5.666
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
				arg_367_0:Play115311092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["10029"]) then
				local var_370_0 = arg_367_1.actors_["10029"]:GetComponent("Image")

				if var_370_0 then
					arg_367_1.var_.highlightMatValue10029 = var_370_0
				end
			end

			local var_370_1 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_1 and not isNil(arg_367_1.actors_["10029"]) then
				if arg_367_1.var_.highlightMatValue10029 then
					local var_370_2 = Mathf.Lerp(1, 0.5, (arg_367_1.time_ - 0) / var_370_1)

					arg_367_1.var_.highlightMatValue10029.color.r = var_370_2
					arg_367_1.var_.highlightMatValue10029.color.g = var_370_2
					arg_367_1.var_.highlightMatValue10029.color.b = var_370_2
					arg_367_1.var_.highlightMatValue10029.color = arg_367_1.var_.highlightMatValue10029.color
				end
			end

			if arg_367_1.time_ >= 0 + var_370_1 and arg_367_1.time_ < 0 + var_370_1 + arg_370_0 and not isNil(arg_367_1.actors_["10029"]) and arg_367_1.var_.highlightMatValue10029 then
				arg_367_1.var_.highlightMatValue10029.color.r = 0.5
				arg_367_1.var_.highlightMatValue10029.color.g = 0.5
				arg_367_1.var_.highlightMatValue10029.color.b = 0.5
				arg_367_1.var_.highlightMatValue10029.color = arg_367_1.var_.highlightMatValue10029.color
			end

			local var_370_3 = 0
			local var_370_4 = 0.325

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_3 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_5 = arg_367_1:GetWordFromCfg(115311091)
				local var_370_6 = arg_367_1:FormatText(var_370_5.content)

				arg_367_1.text_.text = var_370_6

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_8 = 13 <= 0 and var_370_4 or var_370_4 * (utf8.len(var_370_6) / 13)

				if (13 <= 0 and var_370_4 or var_370_4 * (utf8.len(var_370_6) / 13)) > 0 and var_370_4 < var_370_8 then
					arg_367_1.talkMaxDuration = var_370_8

					if var_370_8 + var_370_3 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_8 + var_370_3
					end
				end

				arg_367_1.text_.text = var_370_6
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311091", "story_v_out_115311.awb") ~= 0 then
					local var_370_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311091", "story_v_out_115311.awb") / 1000

					if var_370_9 + var_370_3 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_3
					end

					if var_370_5.prefab_name ~= "" and arg_367_1.actors_[var_370_5.prefab_name] ~= nil then
						local var_370_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_5.prefab_name].transform, "story_v_out_115311", "115311091", "story_v_out_115311.awb")

						arg_367_1:RecordAudio("115311091", var_370_10)
						arg_367_1:RecordAudio("115311091", var_370_10)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_115311", "115311091", "story_v_out_115311.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_115311", "115311091", "story_v_out_115311.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_11 = math.max(var_370_4, arg_367_1.talkMaxDuration)

			if var_370_3 <= arg_367_1.time_ and arg_367_1.time_ < var_370_3 + var_370_11 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_3) / var_370_11

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_3 + var_370_11 and arg_367_1.time_ < var_370_3 + var_370_11 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play115311092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 115311092
		arg_371_1.duration_ = 2.33

		local var_371_0 = {
			ja = 1.666,
			ko = 1.766,
			zh = 1.933,
			en = 2.333
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
				arg_371_0:Play115311093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.2

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[316].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_1 = arg_371_1:GetWordFromCfg(115311092)
				local var_374_2 = arg_371_1:FormatText(var_374_1.content)

				arg_371_1.text_.text = var_374_2

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 8 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 8)

				if (8 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 8)) > 0 and var_374_0 < var_374_4 then
					arg_371_1.talkMaxDuration = var_374_4

					if var_374_4 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_4 + 0
					end
				end

				arg_371_1.text_.text = var_374_2
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311092", "story_v_out_115311.awb") ~= 0 then
					local var_374_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311092", "story_v_out_115311.awb") / 1000

					if var_374_5 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + 0
					end

					if var_374_1.prefab_name ~= "" and arg_371_1.actors_[var_374_1.prefab_name] ~= nil then
						local var_374_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_1.prefab_name].transform, "story_v_out_115311", "115311092", "story_v_out_115311.awb")

						arg_371_1:RecordAudio("115311092", var_374_6)
						arg_371_1:RecordAudio("115311092", var_374_6)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_115311", "115311092", "story_v_out_115311.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_115311", "115311092", "story_v_out_115311.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_7 and arg_371_1.time_ < 0 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play115311093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 115311093
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play115311094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 1.1

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_1 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(115311093).content)

				arg_375_1.text_.text = var_378_1

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_3 = 44 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 44)

				if (44 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 44)) > 0 and var_378_0 < var_378_3 then
					arg_375_1.talkMaxDuration = var_378_3

					if var_378_3 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_3 + 0
					end
				end

				arg_375_1.text_.text = var_378_1
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_4 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_4

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play115311094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 115311094
		arg_379_1.duration_ = 21.9

		local var_379_0 = {
			ja = 17.566,
			ko = 20.1,
			zh = 17,
			en = 21.9
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
				arg_379_0:Play115311095(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["113801_1"]) then
				local var_382_0 = arg_379_1.actors_["113801_1"]:GetComponent("Image")

				if var_382_0 then
					arg_379_1.var_.highlightMatValue113801_1 = var_382_0
				end
			end

			local var_382_1 = 0.2

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_1 and not isNil(arg_379_1.actors_["113801_1"]) then
				if arg_379_1.var_.highlightMatValue113801_1 then
					local var_382_2 = Mathf.Lerp(0.5, 1, (arg_379_1.time_ - 0) / var_382_1)

					arg_379_1.var_.highlightMatValue113801_1.color.r = var_382_2
					arg_379_1.var_.highlightMatValue113801_1.color.g = var_382_2
					arg_379_1.var_.highlightMatValue113801_1.color.b = var_382_2
					arg_379_1.var_.highlightMatValue113801_1.color = arg_379_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_379_1.time_ >= 0 + var_382_1 and arg_379_1.time_ < 0 + var_382_1 + arg_382_0 and not isNil(arg_379_1.actors_["113801_1"]) and arg_379_1.var_.highlightMatValue113801_1 then
				arg_379_1.actors_["113801_1"].transform:SetSiblingIndex(1)

				arg_379_1.var_.highlightMatValue113801_1.color.r = 1
				arg_379_1.var_.highlightMatValue113801_1.color.g = 1
				arg_379_1.var_.highlightMatValue113801_1.color.b = 1
				arg_379_1.var_.highlightMatValue113801_1.color = arg_379_1.var_.highlightMatValue113801_1.color
			end

			local var_382_3 = 0
			local var_382_4 = 1.725

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_3 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_5 = arg_379_1:GetWordFromCfg(115311094)
				local var_382_6 = arg_379_1:FormatText(var_382_5.content)

				arg_379_1.text_.text = var_382_6

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_8 = 69 <= 0 and var_382_4 or var_382_4 * (utf8.len(var_382_6) / 69)

				if (69 <= 0 and var_382_4 or var_382_4 * (utf8.len(var_382_6) / 69)) > 0 and var_382_4 < var_382_8 then
					arg_379_1.talkMaxDuration = var_382_8

					if var_382_8 + var_382_3 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_8 + var_382_3
					end
				end

				arg_379_1.text_.text = var_382_6
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311094", "story_v_out_115311.awb") ~= 0 then
					local var_382_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311094", "story_v_out_115311.awb") / 1000

					if var_382_9 + var_382_3 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_9 + var_382_3
					end

					if var_382_5.prefab_name ~= "" and arg_379_1.actors_[var_382_5.prefab_name] ~= nil then
						local var_382_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_5.prefab_name].transform, "story_v_out_115311", "115311094", "story_v_out_115311.awb")

						arg_379_1:RecordAudio("115311094", var_382_10)
						arg_379_1:RecordAudio("115311094", var_382_10)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_115311", "115311094", "story_v_out_115311.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_115311", "115311094", "story_v_out_115311.awb")
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
	Play115311095 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 115311095
		arg_383_1.duration_ = 19.23

		local var_383_0 = {
			ja = 11.4,
			ko = 13.866,
			zh = 15.4,
			en = 19.233
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play115311096(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 1.375

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_1 = arg_383_1:GetWordFromCfg(115311095)
				local var_386_2 = arg_383_1:FormatText(var_386_1.content)

				arg_383_1.text_.text = var_386_2

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_4 = 55 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 55)

				if (55 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 55)) > 0 and var_386_0 < var_386_4 then
					arg_383_1.talkMaxDuration = var_386_4

					if var_386_4 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_4 + 0
					end
				end

				arg_383_1.text_.text = var_386_2
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311095", "story_v_out_115311.awb") ~= 0 then
					local var_386_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311095", "story_v_out_115311.awb") / 1000

					if var_386_5 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + 0
					end

					if var_386_1.prefab_name ~= "" and arg_383_1.actors_[var_386_1.prefab_name] ~= nil then
						local var_386_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_1.prefab_name].transform, "story_v_out_115311", "115311095", "story_v_out_115311.awb")

						arg_383_1:RecordAudio("115311095", var_386_6)
						arg_383_1:RecordAudio("115311095", var_386_6)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_115311", "115311095", "story_v_out_115311.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_115311", "115311095", "story_v_out_115311.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_7 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_7 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_7

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_7 and arg_383_1.time_ < 0 + var_386_7 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play115311096 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 115311096
		arg_387_1.duration_ = 18.33

		local var_387_0 = {
			ja = 18.333,
			ko = 14.133,
			zh = 14.933,
			en = 17.866
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play115311097(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 1.35

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:GetWordFromCfg(115311096)
				local var_390_2 = arg_387_1:FormatText(var_390_1.content)

				arg_387_1.text_.text = var_390_2

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_4 = 54 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 54)

				if (54 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 54)) > 0 and var_390_0 < var_390_4 then
					arg_387_1.talkMaxDuration = var_390_4

					if var_390_4 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_4 + 0
					end
				end

				arg_387_1.text_.text = var_390_2
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311096", "story_v_out_115311.awb") ~= 0 then
					local var_390_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311096", "story_v_out_115311.awb") / 1000

					if var_390_5 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + 0
					end

					if var_390_1.prefab_name ~= "" and arg_387_1.actors_[var_390_1.prefab_name] ~= nil then
						local var_390_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_1.prefab_name].transform, "story_v_out_115311", "115311096", "story_v_out_115311.awb")

						arg_387_1:RecordAudio("115311096", var_390_6)
						arg_387_1:RecordAudio("115311096", var_390_6)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_115311", "115311096", "story_v_out_115311.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_115311", "115311096", "story_v_out_115311.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_7 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_7 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_7

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_7 and arg_387_1.time_ < 0 + var_390_7 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play115311097 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 115311097
		arg_391_1.duration_ = 14.97

		local var_391_0 = {
			ja = 11.466,
			ko = 14.966,
			zh = 14.266,
			en = 14.2
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play115311098(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 1.4

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_1 = arg_391_1:GetWordFromCfg(115311097)
				local var_394_2 = arg_391_1:FormatText(var_394_1.content)

				arg_391_1.text_.text = var_394_2

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 56 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 56)

				if (56 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 56)) > 0 and var_394_0 < var_394_4 then
					arg_391_1.talkMaxDuration = var_394_4

					if var_394_4 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_4 + 0
					end
				end

				arg_391_1.text_.text = var_394_2
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311097", "story_v_out_115311.awb") ~= 0 then
					local var_394_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311097", "story_v_out_115311.awb") / 1000

					if var_394_5 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + 0
					end

					if var_394_1.prefab_name ~= "" and arg_391_1.actors_[var_394_1.prefab_name] ~= nil then
						local var_394_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_1.prefab_name].transform, "story_v_out_115311", "115311097", "story_v_out_115311.awb")

						arg_391_1:RecordAudio("115311097", var_394_6)
						arg_391_1:RecordAudio("115311097", var_394_6)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_115311", "115311097", "story_v_out_115311.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_115311", "115311097", "story_v_out_115311.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_7 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_7 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_7

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_7 and arg_391_1.time_ < 0 + var_394_7 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play115311098 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 115311098
		arg_395_1.duration_ = 16.6

		local var_395_0 = {
			ja = 13.433,
			ko = 12.733,
			zh = 13.6,
			en = 16.6
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
				arg_395_0:Play115311099(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 1.25

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_1 = arg_395_1:GetWordFromCfg(115311098)
				local var_398_2 = arg_395_1:FormatText(var_398_1.content)

				arg_395_1.text_.text = var_398_2

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_4 = 50 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 50)

				if (50 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 50)) > 0 and var_398_0 < var_398_4 then
					arg_395_1.talkMaxDuration = var_398_4

					if var_398_4 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_4 + 0
					end
				end

				arg_395_1.text_.text = var_398_2
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311098", "story_v_out_115311.awb") ~= 0 then
					local var_398_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311098", "story_v_out_115311.awb") / 1000

					if var_398_5 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_5 + 0
					end

					if var_398_1.prefab_name ~= "" and arg_395_1.actors_[var_398_1.prefab_name] ~= nil then
						local var_398_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_1.prefab_name].transform, "story_v_out_115311", "115311098", "story_v_out_115311.awb")

						arg_395_1:RecordAudio("115311098", var_398_6)
						arg_395_1:RecordAudio("115311098", var_398_6)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_115311", "115311098", "story_v_out_115311.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_115311", "115311098", "story_v_out_115311.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_7 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_7 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_7

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_7 and arg_395_1.time_ < 0 + var_398_7 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play115311099 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 115311099
		arg_399_1.duration_ = 2.27

		local var_399_0 = {
			ja = 2.266,
			ko = 1.3,
			zh = 1.333,
			en = 1.733
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play115311100(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["113801_1"]) then
				local var_402_0 = arg_399_1.actors_["113801_1"]:GetComponent("Image")

				if var_402_0 then
					arg_399_1.var_.highlightMatValue113801_1 = var_402_0
				end
			end

			local var_402_1 = 0.2

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_1 and not isNil(arg_399_1.actors_["113801_1"]) then
				if arg_399_1.var_.highlightMatValue113801_1 then
					local var_402_2 = Mathf.Lerp(1, 0.5, (arg_399_1.time_ - 0) / var_402_1)

					arg_399_1.var_.highlightMatValue113801_1.color.r = var_402_2
					arg_399_1.var_.highlightMatValue113801_1.color.g = var_402_2
					arg_399_1.var_.highlightMatValue113801_1.color.b = var_402_2
					arg_399_1.var_.highlightMatValue113801_1.color = arg_399_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_399_1.time_ >= 0 + var_402_1 and arg_399_1.time_ < 0 + var_402_1 + arg_402_0 and not isNil(arg_399_1.actors_["113801_1"]) and arg_399_1.var_.highlightMatValue113801_1 then
				arg_399_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_399_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_399_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_399_1.var_.highlightMatValue113801_1.color = arg_399_1.var_.highlightMatValue113801_1.color
			end

			local var_402_3 = 0
			local var_402_4 = 0.075

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_3 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_5 = arg_399_1:GetWordFromCfg(115311099)
				local var_402_6 = arg_399_1:FormatText(var_402_5.content)

				arg_399_1.text_.text = var_402_6

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_8 = 3 <= 0 and var_402_4 or var_402_4 * (utf8.len(var_402_6) / 3)

				if (3 <= 0 and var_402_4 or var_402_4 * (utf8.len(var_402_6) / 3)) > 0 and var_402_4 < var_402_8 then
					arg_399_1.talkMaxDuration = var_402_8

					if var_402_8 + var_402_3 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_8 + var_402_3
					end
				end

				arg_399_1.text_.text = var_402_6
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311099", "story_v_out_115311.awb") ~= 0 then
					local var_402_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311099", "story_v_out_115311.awb") / 1000

					if var_402_9 + var_402_3 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_9 + var_402_3
					end

					if var_402_5.prefab_name ~= "" and arg_399_1.actors_[var_402_5.prefab_name] ~= nil then
						local var_402_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_5.prefab_name].transform, "story_v_out_115311", "115311099", "story_v_out_115311.awb")

						arg_399_1:RecordAudio("115311099", var_402_10)
						arg_399_1:RecordAudio("115311099", var_402_10)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_115311", "115311099", "story_v_out_115311.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_115311", "115311099", "story_v_out_115311.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_11 = math.max(var_402_4, arg_399_1.talkMaxDuration)

			if var_402_3 <= arg_399_1.time_ and arg_399_1.time_ < var_402_3 + var_402_11 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_3) / var_402_11

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_3 + var_402_11 and arg_399_1.time_ < var_402_3 + var_402_11 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play115311100 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 115311100
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play115311101(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				local var_406_0 = arg_403_1.actors_["10029"]:GetComponent("Image")

				if var_406_0 then
					arg_403_1.var_.alphaMatValue10029 = var_406_0
					arg_403_1.var_.alphaOldValue10029 = var_406_0.color.a
				end

				arg_403_1.var_.alphaOldValue10029 = 1
			end

			local var_406_1 = 0.5

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_1 then
				if arg_403_1.var_.alphaMatValue10029 then
					arg_403_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_403_1.var_.alphaOldValue10029, 0, (arg_403_1.time_ - 0) / var_406_1)
					arg_403_1.var_.alphaMatValue10029.color = arg_403_1.var_.alphaMatValue10029.color
				end
			end

			if arg_403_1.time_ >= 0 + var_406_1 and arg_403_1.time_ < 0 + var_406_1 + arg_406_0 and arg_403_1.var_.alphaMatValue10029 then
				arg_403_1.var_.alphaMatValue10029.color.a = 0
				arg_403_1.var_.alphaMatValue10029.color = arg_403_1.var_.alphaMatValue10029.color
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				local var_406_2 = arg_403_1.actors_["113801_1"]:GetComponent("Image")

				if var_406_2 then
					arg_403_1.var_.alphaMatValue113801_1 = var_406_2
					arg_403_1.var_.alphaOldValue113801_1 = var_406_2.color.a
				end

				arg_403_1.var_.alphaOldValue113801_1 = 1
			end

			local var_406_3 = 0.5

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_3 then
				if arg_403_1.var_.alphaMatValue113801_1 then
					arg_403_1.var_.alphaMatValue113801_1.color.a = Mathf.Lerp(arg_403_1.var_.alphaOldValue113801_1, 0, (arg_403_1.time_ - 0) / var_406_3)
					arg_403_1.var_.alphaMatValue113801_1.color = arg_403_1.var_.alphaMatValue113801_1.color
				end
			end

			if arg_403_1.time_ >= 0 + var_406_3 and arg_403_1.time_ < 0 + var_406_3 + arg_406_0 and arg_403_1.var_.alphaMatValue113801_1 then
				arg_403_1.var_.alphaMatValue113801_1.color.a = 0
				arg_403_1.var_.alphaMatValue113801_1.color = arg_403_1.var_.alphaMatValue113801_1.color
			end

			local var_406_4 = 0
			local var_406_5 = 1.025

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_6 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(115311100).content)

				arg_403_1.text_.text = var_406_6

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_8 = 41 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_6) / 41)

				if (41 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_6) / 41)) > 0 and var_406_5 < var_406_8 then
					arg_403_1.talkMaxDuration = var_406_8

					if var_406_8 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_4
					end
				end

				arg_403_1.text_.text = var_406_6
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_9 = math.max(var_406_5, arg_403_1.talkMaxDuration)

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_9 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_4) / var_406_9

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_4 + var_406_9 and arg_403_1.time_ < var_406_4 + var_406_9 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play115311101 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 115311101
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play115311102(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 1.35

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_1 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(115311101).content)

				arg_407_1.text_.text = var_410_1

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_3 = 54 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 54)

				if (54 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 54)) > 0 and var_410_0 < var_410_3 then
					arg_407_1.talkMaxDuration = var_410_3

					if var_410_3 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_3 + 0
					end
				end

				arg_407_1.text_.text = var_410_1
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_4 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_4 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_4

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_4 and arg_407_1.time_ < 0 + var_410_4 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play115311102 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 115311102
		arg_411_1.duration_ = 20.7

		local var_411_0 = {
			ja = 20.7,
			ko = 14.8,
			zh = 14.2,
			en = 17.066
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
				arg_411_0:Play115311103(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				local var_414_0 = arg_411_1.actors_["10029"]:GetComponent("Image")

				if var_414_0 then
					arg_411_1.var_.alphaMatValue10029 = var_414_0
					arg_411_1.var_.alphaOldValue10029 = var_414_0.color.a
				end

				arg_411_1.var_.alphaOldValue10029 = 0
			end

			local var_414_1 = 0.5

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_1 then
				if arg_411_1.var_.alphaMatValue10029 then
					arg_411_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_411_1.var_.alphaOldValue10029, 1, (arg_411_1.time_ - 0) / var_414_1)
					arg_411_1.var_.alphaMatValue10029.color = arg_411_1.var_.alphaMatValue10029.color
				end
			end

			if arg_411_1.time_ >= 0 + var_414_1 and arg_411_1.time_ < 0 + var_414_1 + arg_414_0 and arg_411_1.var_.alphaMatValue10029 then
				arg_411_1.var_.alphaMatValue10029.color.a = 1
				arg_411_1.var_.alphaMatValue10029.color = arg_411_1.var_.alphaMatValue10029.color
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				local var_414_2 = arg_411_1.actors_["113801_1"]:GetComponent("Image")

				if var_414_2 then
					arg_411_1.var_.alphaMatValue113801_1 = var_414_2
					arg_411_1.var_.alphaOldValue113801_1 = var_414_2.color.a
				end

				arg_411_1.var_.alphaOldValue113801_1 = 0
			end

			local var_414_3 = 0.5

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_3 then
				if arg_411_1.var_.alphaMatValue113801_1 then
					arg_411_1.var_.alphaMatValue113801_1.color.a = Mathf.Lerp(arg_411_1.var_.alphaOldValue113801_1, 1, (arg_411_1.time_ - 0) / var_414_3)
					arg_411_1.var_.alphaMatValue113801_1.color = arg_411_1.var_.alphaMatValue113801_1.color
				end
			end

			if arg_411_1.time_ >= 0 + var_414_3 and arg_411_1.time_ < 0 + var_414_3 + arg_414_0 and arg_411_1.var_.alphaMatValue113801_1 then
				arg_411_1.var_.alphaMatValue113801_1.color.a = 1
				arg_411_1.var_.alphaMatValue113801_1.color = arg_411_1.var_.alphaMatValue113801_1.color
			end

			local var_414_4 = arg_411_1.actors_["113801_1"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_4) then
				local var_414_5 = var_414_4:GetComponent("Image")

				if var_414_5 then
					arg_411_1.var_.highlightMatValue113801_1 = var_414_5
				end
			end

			local var_414_6 = 0.2

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_6 and not isNil(var_414_4) then
				if arg_411_1.var_.highlightMatValue113801_1 then
					local var_414_7 = Mathf.Lerp(0.5, 1, (arg_411_1.time_ - 0) / var_414_6)

					arg_411_1.var_.highlightMatValue113801_1.color.r = var_414_7
					arg_411_1.var_.highlightMatValue113801_1.color.g = var_414_7
					arg_411_1.var_.highlightMatValue113801_1.color.b = var_414_7
					arg_411_1.var_.highlightMatValue113801_1.color = arg_411_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_411_1.time_ >= 0 + var_414_6 and arg_411_1.time_ < 0 + var_414_6 + arg_414_0 and not isNil(var_414_4) and arg_411_1.var_.highlightMatValue113801_1 then
				var_414_4.transform:SetSiblingIndex(1)

				arg_411_1.var_.highlightMatValue113801_1.color.r = 1
				arg_411_1.var_.highlightMatValue113801_1.color.g = 1
				arg_411_1.var_.highlightMatValue113801_1.color.b = 1
				arg_411_1.var_.highlightMatValue113801_1.color = arg_411_1.var_.highlightMatValue113801_1.color
			end

			local var_414_8 = 0
			local var_414_9 = 1.5

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_8 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_10 = arg_411_1:GetWordFromCfg(115311102)
				local var_414_11 = arg_411_1:FormatText(var_414_10.content)

				arg_411_1.text_.text = var_414_11

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_13 = 60 <= 0 and var_414_9 or var_414_9 * (utf8.len(var_414_11) / 60)

				if (60 <= 0 and var_414_9 or var_414_9 * (utf8.len(var_414_11) / 60)) > 0 and var_414_9 < var_414_13 then
					arg_411_1.talkMaxDuration = var_414_13

					if var_414_13 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_13 + var_414_8
					end
				end

				arg_411_1.text_.text = var_414_11
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311102", "story_v_out_115311.awb") ~= 0 then
					local var_414_14 = manager.audio:GetVoiceLength("story_v_out_115311", "115311102", "story_v_out_115311.awb") / 1000

					if var_414_14 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_14 + var_414_8
					end

					if var_414_10.prefab_name ~= "" and arg_411_1.actors_[var_414_10.prefab_name] ~= nil then
						local var_414_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_10.prefab_name].transform, "story_v_out_115311", "115311102", "story_v_out_115311.awb")

						arg_411_1:RecordAudio("115311102", var_414_15)
						arg_411_1:RecordAudio("115311102", var_414_15)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_115311", "115311102", "story_v_out_115311.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_115311", "115311102", "story_v_out_115311.awb")
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

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play115311103 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 115311103
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play115311104(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["113801_1"]) then
				local var_418_0 = arg_415_1.actors_["113801_1"]:GetComponent("Image")

				if var_418_0 then
					arg_415_1.var_.highlightMatValue113801_1 = var_418_0
				end
			end

			local var_418_1 = 0.2

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_1 and not isNil(arg_415_1.actors_["113801_1"]) then
				if arg_415_1.var_.highlightMatValue113801_1 then
					local var_418_2 = Mathf.Lerp(1, 0.5, (arg_415_1.time_ - 0) / var_418_1)

					arg_415_1.var_.highlightMatValue113801_1.color.r = var_418_2
					arg_415_1.var_.highlightMatValue113801_1.color.g = var_418_2
					arg_415_1.var_.highlightMatValue113801_1.color.b = var_418_2
					arg_415_1.var_.highlightMatValue113801_1.color = arg_415_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_415_1.time_ >= 0 + var_418_1 and arg_415_1.time_ < 0 + var_418_1 + arg_418_0 and not isNil(arg_415_1.actors_["113801_1"]) and arg_415_1.var_.highlightMatValue113801_1 then
				arg_415_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_415_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_415_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_415_1.var_.highlightMatValue113801_1.color = arg_415_1.var_.highlightMatValue113801_1.color
			end

			local var_418_3 = 0
			local var_418_4 = 0.725

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_3 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_5 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(115311103).content)

				arg_415_1.text_.text = var_418_5

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_7 = 29 <= 0 and var_418_4 or var_418_4 * (utf8.len(var_418_5) / 29)

				if (29 <= 0 and var_418_4 or var_418_4 * (utf8.len(var_418_5) / 29)) > 0 and var_418_4 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_3 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_3
					end
				end

				arg_415_1.text_.text = var_418_5
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_8 = math.max(var_418_4, arg_415_1.talkMaxDuration)

			if var_418_3 <= arg_415_1.time_ and arg_415_1.time_ < var_418_3 + var_418_8 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_3) / var_418_8

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_3 + var_418_8 and arg_415_1.time_ < var_418_3 + var_418_8 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play115311104 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 115311104
		arg_419_1.duration_ = 14.7

		local var_419_0 = {
			ja = 14.7,
			ko = 8.6,
			zh = 8.033,
			en = 7.5
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play115311105(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["113801_1"]) then
				local var_422_0 = arg_419_1.actors_["113801_1"]:GetComponent("Image")

				if var_422_0 then
					arg_419_1.var_.highlightMatValue113801_1 = var_422_0
				end
			end

			local var_422_1 = 0.2

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_1 and not isNil(arg_419_1.actors_["113801_1"]) then
				if arg_419_1.var_.highlightMatValue113801_1 then
					local var_422_2 = Mathf.Lerp(0.5, 1, (arg_419_1.time_ - 0) / var_422_1)

					arg_419_1.var_.highlightMatValue113801_1.color.r = var_422_2
					arg_419_1.var_.highlightMatValue113801_1.color.g = var_422_2
					arg_419_1.var_.highlightMatValue113801_1.color.b = var_422_2
					arg_419_1.var_.highlightMatValue113801_1.color = arg_419_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_419_1.time_ >= 0 + var_422_1 and arg_419_1.time_ < 0 + var_422_1 + arg_422_0 and not isNil(arg_419_1.actors_["113801_1"]) and arg_419_1.var_.highlightMatValue113801_1 then
				arg_419_1.actors_["113801_1"].transform:SetSiblingIndex(1)

				arg_419_1.var_.highlightMatValue113801_1.color.r = 1
				arg_419_1.var_.highlightMatValue113801_1.color.g = 1
				arg_419_1.var_.highlightMatValue113801_1.color.b = 1
				arg_419_1.var_.highlightMatValue113801_1.color = arg_419_1.var_.highlightMatValue113801_1.color
			end

			local var_422_3 = 0
			local var_422_4 = 0.75

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_3 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_5 = arg_419_1:GetWordFromCfg(115311104)
				local var_422_6 = arg_419_1:FormatText(var_422_5.content)

				arg_419_1.text_.text = var_422_6

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_8 = 30 <= 0 and var_422_4 or var_422_4 * (utf8.len(var_422_6) / 30)

				if (30 <= 0 and var_422_4 or var_422_4 * (utf8.len(var_422_6) / 30)) > 0 and var_422_4 < var_422_8 then
					arg_419_1.talkMaxDuration = var_422_8

					if var_422_8 + var_422_3 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_3
					end
				end

				arg_419_1.text_.text = var_422_6
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311104", "story_v_out_115311.awb") ~= 0 then
					local var_422_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311104", "story_v_out_115311.awb") / 1000

					if var_422_9 + var_422_3 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_9 + var_422_3
					end

					if var_422_5.prefab_name ~= "" and arg_419_1.actors_[var_422_5.prefab_name] ~= nil then
						local var_422_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_5.prefab_name].transform, "story_v_out_115311", "115311104", "story_v_out_115311.awb")

						arg_419_1:RecordAudio("115311104", var_422_10)
						arg_419_1:RecordAudio("115311104", var_422_10)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_115311", "115311104", "story_v_out_115311.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_115311", "115311104", "story_v_out_115311.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_11 = math.max(var_422_4, arg_419_1.talkMaxDuration)

			if var_422_3 <= arg_419_1.time_ and arg_419_1.time_ < var_422_3 + var_422_11 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_3) / var_422_11

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_3 + var_422_11 and arg_419_1.time_ < var_422_3 + var_422_11 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play115311105 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 115311105
		arg_423_1.duration_ = 12.07

		local var_423_0 = {
			ja = 8,
			ko = 10.366,
			zh = 12.066,
			en = 7.166
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play115311106(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 1.225

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_1 = arg_423_1:GetWordFromCfg(115311105)
				local var_426_2 = arg_423_1:FormatText(var_426_1.content)

				arg_423_1.text_.text = var_426_2

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_4 = 49 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_2) / 49)

				if (49 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_2) / 49)) > 0 and var_426_0 < var_426_4 then
					arg_423_1.talkMaxDuration = var_426_4

					if var_426_4 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_4 + 0
					end
				end

				arg_423_1.text_.text = var_426_2
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311105", "story_v_out_115311.awb") ~= 0 then
					local var_426_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311105", "story_v_out_115311.awb") / 1000

					if var_426_5 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_5 + 0
					end

					if var_426_1.prefab_name ~= "" and arg_423_1.actors_[var_426_1.prefab_name] ~= nil then
						local var_426_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_1.prefab_name].transform, "story_v_out_115311", "115311105", "story_v_out_115311.awb")

						arg_423_1:RecordAudio("115311105", var_426_6)
						arg_423_1:RecordAudio("115311105", var_426_6)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_115311", "115311105", "story_v_out_115311.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_115311", "115311105", "story_v_out_115311.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_7 = math.max(var_426_0, arg_423_1.talkMaxDuration)

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_7 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - 0) / var_426_7

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= 0 + var_426_7 and arg_423_1.time_ < 0 + var_426_7 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play115311106 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 115311106
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play115311107(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["113801_1"]) then
				local var_430_0 = arg_427_1.actors_["113801_1"]:GetComponent("Image")

				if var_430_0 then
					arg_427_1.var_.highlightMatValue113801_1 = var_430_0
				end
			end

			local var_430_1 = 0.2

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_1 and not isNil(arg_427_1.actors_["113801_1"]) then
				if arg_427_1.var_.highlightMatValue113801_1 then
					local var_430_2 = Mathf.Lerp(1, 0.5, (arg_427_1.time_ - 0) / var_430_1)

					arg_427_1.var_.highlightMatValue113801_1.color.r = var_430_2
					arg_427_1.var_.highlightMatValue113801_1.color.g = var_430_2
					arg_427_1.var_.highlightMatValue113801_1.color.b = var_430_2
					arg_427_1.var_.highlightMatValue113801_1.color = arg_427_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_427_1.time_ >= 0 + var_430_1 and arg_427_1.time_ < 0 + var_430_1 + arg_430_0 and not isNil(arg_427_1.actors_["113801_1"]) and arg_427_1.var_.highlightMatValue113801_1 then
				arg_427_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_427_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_427_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_427_1.var_.highlightMatValue113801_1.color = arg_427_1.var_.highlightMatValue113801_1.color
			end

			local var_430_3 = 0
			local var_430_4 = 1.225

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_3 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_5 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(115311106).content)

				arg_427_1.text_.text = var_430_5

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_7 = 49 <= 0 and var_430_4 or var_430_4 * (utf8.len(var_430_5) / 49)

				if (49 <= 0 and var_430_4 or var_430_4 * (utf8.len(var_430_5) / 49)) > 0 and var_430_4 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_3 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_3
					end
				end

				arg_427_1.text_.text = var_430_5
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_8 = math.max(var_430_4, arg_427_1.talkMaxDuration)

			if var_430_3 <= arg_427_1.time_ and arg_427_1.time_ < var_430_3 + var_430_8 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_3) / var_430_8

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_3 + var_430_8 and arg_427_1.time_ < var_430_3 + var_430_8 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play115311107 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 115311107
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play115311108(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 1.1

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(115311107).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 44 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 44)

				if (44 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 44)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play115311108 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 115311108
		arg_435_1.duration_ = 8.87

		local var_435_0 = {
			ja = 8.866,
			ko = 5.366,
			zh = 6.633,
			en = 8.866
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play115311109(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["113801_1"]) then
				local var_438_0 = arg_435_1.actors_["113801_1"]:GetComponent("Image")

				if var_438_0 then
					arg_435_1.var_.highlightMatValue113801_1 = var_438_0
				end
			end

			local var_438_1 = 0.2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_1 and not isNil(arg_435_1.actors_["113801_1"]) then
				if arg_435_1.var_.highlightMatValue113801_1 then
					local var_438_2 = Mathf.Lerp(0.5, 1, (arg_435_1.time_ - 0) / var_438_1)

					arg_435_1.var_.highlightMatValue113801_1.color.r = var_438_2
					arg_435_1.var_.highlightMatValue113801_1.color.g = var_438_2
					arg_435_1.var_.highlightMatValue113801_1.color.b = var_438_2
					arg_435_1.var_.highlightMatValue113801_1.color = arg_435_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_435_1.time_ >= 0 + var_438_1 and arg_435_1.time_ < 0 + var_438_1 + arg_438_0 and not isNil(arg_435_1.actors_["113801_1"]) and arg_435_1.var_.highlightMatValue113801_1 then
				arg_435_1.actors_["113801_1"].transform:SetSiblingIndex(1)

				arg_435_1.var_.highlightMatValue113801_1.color.r = 1
				arg_435_1.var_.highlightMatValue113801_1.color.g = 1
				arg_435_1.var_.highlightMatValue113801_1.color.b = 1
				arg_435_1.var_.highlightMatValue113801_1.color = arg_435_1.var_.highlightMatValue113801_1.color
			end

			local var_438_3 = 0
			local var_438_4 = 0.675

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_3 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_5 = arg_435_1:GetWordFromCfg(115311108)
				local var_438_6 = arg_435_1:FormatText(var_438_5.content)

				arg_435_1.text_.text = var_438_6

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_8 = 25 <= 0 and var_438_4 or var_438_4 * (utf8.len(var_438_6) / 25)

				if (25 <= 0 and var_438_4 or var_438_4 * (utf8.len(var_438_6) / 25)) > 0 and var_438_4 < var_438_8 then
					arg_435_1.talkMaxDuration = var_438_8

					if var_438_8 + var_438_3 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_8 + var_438_3
					end
				end

				arg_435_1.text_.text = var_438_6
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311108", "story_v_out_115311.awb") ~= 0 then
					local var_438_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311108", "story_v_out_115311.awb") / 1000

					if var_438_9 + var_438_3 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_9 + var_438_3
					end

					if var_438_5.prefab_name ~= "" and arg_435_1.actors_[var_438_5.prefab_name] ~= nil then
						local var_438_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_5.prefab_name].transform, "story_v_out_115311", "115311108", "story_v_out_115311.awb")

						arg_435_1:RecordAudio("115311108", var_438_10)
						arg_435_1:RecordAudio("115311108", var_438_10)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_115311", "115311108", "story_v_out_115311.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_115311", "115311108", "story_v_out_115311.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_11 = math.max(var_438_4, arg_435_1.talkMaxDuration)

			if var_438_3 <= arg_435_1.time_ and arg_435_1.time_ < var_438_3 + var_438_11 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_3) / var_438_11

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_3 + var_438_11 and arg_435_1.time_ < var_438_3 + var_438_11 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play115311109 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 115311109
		arg_439_1.duration_ = 15.6

		local var_439_0 = {
			ja = 15.6,
			ko = 9.866,
			zh = 10.566,
			en = 10.666
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play115311110(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0.9

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_1 = arg_439_1:GetWordFromCfg(115311109)
				local var_442_2 = arg_439_1:FormatText(var_442_1.content)

				arg_439_1.text_.text = var_442_2

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_4 = 36 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_2) / 36)

				if (36 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_2) / 36)) > 0 and var_442_0 < var_442_4 then
					arg_439_1.talkMaxDuration = var_442_4

					if var_442_4 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_4 + 0
					end
				end

				arg_439_1.text_.text = var_442_2
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311109", "story_v_out_115311.awb") ~= 0 then
					local var_442_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311109", "story_v_out_115311.awb") / 1000

					if var_442_5 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + 0
					end

					if var_442_1.prefab_name ~= "" and arg_439_1.actors_[var_442_1.prefab_name] ~= nil then
						local var_442_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_1.prefab_name].transform, "story_v_out_115311", "115311109", "story_v_out_115311.awb")

						arg_439_1:RecordAudio("115311109", var_442_6)
						arg_439_1:RecordAudio("115311109", var_442_6)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_115311", "115311109", "story_v_out_115311.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_115311", "115311109", "story_v_out_115311.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_7 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_7 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_7

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_7 and arg_439_1.time_ < 0 + var_442_7 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play115311110 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 115311110
		arg_443_1.duration_ = 6.1

		local var_443_0 = {
			ja = 5.3,
			ko = 5.766,
			zh = 6.1,
			en = 5.766
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play115311111(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 2 < arg_443_1.time_ and arg_443_1.time_ <= 2 + arg_446_0 then
				local var_446_0 = arg_443_1.bgs_.ST22a

				arg_443_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_446_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_446_1 = var_446_0:GetComponent("SpriteRenderer")

				if var_446_1 and var_446_1.sprite then
					local var_446_2 = 2 * (var_446_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_446_0.transform.localScale = Vector3.New(var_446_2 / var_446_1.sprite.bounds.size.y < var_446_2 * manager.ui.mainCameraCom_.aspect / var_446_1.sprite.bounds.size.x and var_446_2 * manager.ui.mainCameraCom_.aspect / var_446_1.sprite.bounds.size.x or var_446_2 / var_446_1.sprite.bounds.size.y, var_446_2 / var_446_1.sprite.bounds.size.y < var_446_2 * manager.ui.mainCameraCom_.aspect / var_446_1.sprite.bounds.size.x and var_446_2 * manager.ui.mainCameraCom_.aspect / var_446_1.sprite.bounds.size.x or var_446_2 / var_446_1.sprite.bounds.size.y, 0)
				end

				for iter_446_0, iter_446_1 in pairs(arg_443_1.bgs_) do
					if iter_446_0 ~= "ST22a" then
						iter_446_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_446_3 = 0

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_3 + arg_446_0 then
				arg_443_1.mask_.enabled = true
				arg_443_1.mask_.raycastTarget = true

				arg_443_1:SetGaussion(false)
			end

			local var_446_4 = 2

			if var_446_3 <= arg_443_1.time_ and arg_443_1.time_ < var_446_3 + var_446_4 then
				local var_446_5 = Color.New(0, 0, 0)

				var_446_5.a = Mathf.Lerp(0, 1, (arg_443_1.time_ - var_446_3) / var_446_4)
				arg_443_1.mask_.color = var_446_5
			end

			if arg_443_1.time_ >= var_446_3 + var_446_4 and arg_443_1.time_ < var_446_3 + var_446_4 + arg_446_0 then
				local var_446_6 = Color.New(0, 0, 0)

				var_446_6.a = 1
				arg_443_1.mask_.color = var_446_6
			end

			local var_446_7 = 2

			if 2 < arg_443_1.time_ and arg_443_1.time_ <= var_446_7 + arg_446_0 then
				arg_443_1.mask_.enabled = true
				arg_443_1.mask_.raycastTarget = true

				arg_443_1:SetGaussion(false)
			end

			local var_446_8 = 2

			if var_446_7 <= arg_443_1.time_ and arg_443_1.time_ < var_446_7 + var_446_8 then
				local var_446_9 = Color.New(0, 0, 0)

				var_446_9.a = Mathf.Lerp(1, 0, (arg_443_1.time_ - var_446_7) / var_446_8)
				arg_443_1.mask_.color = var_446_9
			end

			if arg_443_1.time_ >= var_446_7 + var_446_8 and arg_443_1.time_ < var_446_7 + var_446_8 + arg_446_0 then
				local var_446_10 = Color.New(0, 0, 0)

				arg_443_1.mask_.enabled = false
				var_446_10.a = 0
				arg_443_1.mask_.color = var_446_10
			end

			local var_446_11 = arg_443_1.actors_["113801_1"].transform

			if 1.966 < arg_443_1.time_ and arg_443_1.time_ <= 1.966 + arg_446_0 then
				arg_443_1.var_.moveOldPos113801_1 = var_446_11.localPosition
				var_446_11.localScale = Vector3.New(1, 1, 1)

				arg_443_1:CheckSpriteTmpPos("113801_1", 7)
			end

			local var_446_12 = 0.001

			if 1.966 <= arg_443_1.time_ and arg_443_1.time_ < 1.966 + var_446_12 then
				var_446_11.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos113801_1, Vector3.New(0, -2000, -370), (arg_443_1.time_ - 1.966) / var_446_12)
			end

			if arg_443_1.time_ >= 1.966 + var_446_12 and arg_443_1.time_ < 1.966 + var_446_12 + arg_446_0 then
				var_446_11.localPosition = Vector3.New(0, -2000, -370)
			end

			local var_446_13 = arg_443_1.actors_["10029"].transform

			if 1.966 < arg_443_1.time_ and arg_443_1.time_ <= 1.966 + arg_446_0 then
				arg_443_1.var_.moveOldPos10029 = var_446_13.localPosition
				var_446_13.localScale = Vector3.New(1, 1, 1)

				arg_443_1:CheckSpriteTmpPos("10029", 7)
			end

			local var_446_14 = 0.001

			if 1.966 <= arg_443_1.time_ and arg_443_1.time_ < 1.966 + var_446_14 then
				var_446_13.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos10029, Vector3.New(0, -2000, -180), (arg_443_1.time_ - 1.966) / var_446_14)
			end

			if arg_443_1.time_ >= 1.966 + var_446_14 and arg_443_1.time_ < 1.966 + var_446_14 + arg_446_0 then
				var_446_13.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_446_15 = arg_443_1.actors_["10030"].transform

			if 3.8 < arg_443_1.time_ and arg_443_1.time_ <= 3.8 + arg_446_0 then
				arg_443_1.var_.moveOldPos10030 = var_446_15.localPosition
				var_446_15.localScale = Vector3.New(1, 1, 1)

				arg_443_1:CheckSpriteTmpPos("10030", 3)

				for iter_446_2 = 0, var_446_15.childCount - 1 do
					local var_446_16 = var_446_15:GetChild(iter_446_2)

					if var_446_16.name == "split_2" or not string.find(var_446_16.name, "split") then
						var_446_16.gameObject:SetActive(true)
					else
						var_446_16.gameObject:SetActive(false)
					end
				end
			end

			local var_446_17 = 0.001

			if 3.8 <= arg_443_1.time_ and arg_443_1.time_ < 3.8 + var_446_17 then
				var_446_15.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_443_1.time_ - 3.8) / var_446_17)
			end

			if arg_443_1.time_ >= 3.8 + var_446_17 and arg_443_1.time_ < 3.8 + var_446_17 + arg_446_0 then
				var_446_15.localPosition = Vector3.New(0, -390, 150)
			end

			if 3.8 < arg_443_1.time_ and arg_443_1.time_ <= 3.8 + arg_446_0 then
				local var_446_18 = arg_443_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_446_18 then
					arg_443_1.var_.alphaOldValue10030 = var_446_18.alpha
					arg_443_1.var_.characterEffect10030 = var_446_18
				end

				arg_443_1.var_.alphaOldValue10030 = 0
			end

			local var_446_19 = 0.5

			if 3.8 <= arg_443_1.time_ and arg_443_1.time_ < 3.8 + var_446_19 then
				if arg_443_1.var_.characterEffect10030 then
					arg_443_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_443_1.var_.alphaOldValue10030, 1, (arg_443_1.time_ - 3.8) / var_446_19)
				end
			end

			if arg_443_1.time_ >= 3.8 + var_446_19 and arg_443_1.time_ < 3.8 + var_446_19 + arg_446_0 and arg_443_1.var_.characterEffect10030 then
				arg_443_1.var_.characterEffect10030.alpha = 1
			end

			local var_446_20 = arg_443_1.actors_["10030"]

			if 3.8 < arg_443_1.time_ and arg_443_1.time_ <= 3.8 + arg_446_0 and not isNil(var_446_20) and arg_443_1.var_.actorSpriteComps10030 == nil then
				arg_443_1.var_.actorSpriteComps10030 = var_446_20:GetComponentsInChildren(typeof(Image), true)
			end

			local var_446_21 = 0.2

			if 3.8 <= arg_443_1.time_ and arg_443_1.time_ < 3.8 + var_446_21 and not isNil(var_446_20) then
				if arg_443_1.var_.actorSpriteComps10030 then
					for iter_446_3, iter_446_4 in pairs(arg_443_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_446_4 then
							if arg_443_1.isInRecall_ then
								iter_446_4.color = Color.New(Mathf.Lerp(iter_446_4.color.r, arg_443_1.hightColor1.r, (arg_443_1.time_ - 3.8) / var_446_21), Mathf.Lerp(iter_446_4.color.g, arg_443_1.hightColor1.g, (arg_443_1.time_ - 3.8) / var_446_21), (Mathf.Lerp(iter_446_4.color.b, arg_443_1.hightColor1.b, (arg_443_1.time_ - 3.8) / var_446_21)))
							else
								local var_446_22 = Mathf.Lerp(iter_446_4.color.r, 1, (arg_443_1.time_ - 3.8) / var_446_21)

								iter_446_4.color = Color.New(var_446_22, var_446_22, var_446_22)
							end
						end
					end
				end
			end

			if arg_443_1.time_ >= 3.8 + var_446_21 and arg_443_1.time_ < 3.8 + var_446_21 + arg_446_0 and not isNil(var_446_20) and arg_443_1.var_.actorSpriteComps10030 then
				for iter_446_5, iter_446_6 in pairs(arg_443_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_446_6 then
						iter_446_6.color = arg_443_1.isInRecall_ and (arg_443_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_443_1.var_.actorSpriteComps10030 = nil
			end

			if arg_443_1.frameCnt_ <= 1 then
				arg_443_1.dialog_:SetActive(false)
			end

			local var_446_23 = 4
			local var_446_24 = 0.15

			if 4 < arg_443_1.time_ and arg_443_1.time_ <= var_446_23 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0

				arg_443_1.dialog_:SetActive(true)

				arg_443_1.dialogCg_.alpha = 0

				local var_446_25 = LeanTween.value(arg_443_1.dialog_, 0, 1, 0.3)

				var_446_25:setOnUpdate(LuaHelper.FloatAction(function(arg_447_0)
					arg_443_1.dialogCg_.alpha = arg_447_0
				end))
				var_446_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_443_1.dialog_)
					var_446_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_443_1.duration_ = arg_443_1.duration_ + 0.3

				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_26 = arg_443_1:GetWordFromCfg(115311110)
				local var_446_27 = arg_443_1:FormatText(var_446_26.content)

				arg_443_1.text_.text = var_446_27

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_29 = 6 <= 0 and var_446_24 or var_446_24 * (utf8.len(var_446_27) / 6)

				if (6 <= 0 and var_446_24 or var_446_24 * (utf8.len(var_446_27) / 6)) > 0 and var_446_24 < var_446_29 then
					arg_443_1.talkMaxDuration = var_446_29
					var_446_23 = var_446_23 + 0.3

					if var_446_29 + var_446_23 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_29 + var_446_23
					end
				end

				arg_443_1.text_.text = var_446_27
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311110", "story_v_out_115311.awb") ~= 0 then
					local var_446_30 = manager.audio:GetVoiceLength("story_v_out_115311", "115311110", "story_v_out_115311.awb") / 1000

					if var_446_30 + var_446_23 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_30 + var_446_23
					end

					if var_446_26.prefab_name ~= "" and arg_443_1.actors_[var_446_26.prefab_name] ~= nil then
						local var_446_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_26.prefab_name].transform, "story_v_out_115311", "115311110", "story_v_out_115311.awb")

						arg_443_1:RecordAudio("115311110", var_446_31)
						arg_443_1:RecordAudio("115311110", var_446_31)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_115311", "115311110", "story_v_out_115311.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_115311", "115311110", "story_v_out_115311.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_32 = var_446_23 + 0.3
			local var_446_33 = math.max(var_446_24, arg_443_1.talkMaxDuration)

			if var_446_23 + 0.3 <= arg_443_1.time_ and arg_443_1.time_ < var_446_32 + var_446_33 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_32) / var_446_33

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_32 + var_446_33 and arg_443_1.time_ < var_446_32 + var_446_33 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "113801_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play115311111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 115311111
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play115311112(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				local var_452_0 = arg_449_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_452_0 then
					arg_449_1.var_.alphaOldValue10030 = var_452_0.alpha
					arg_449_1.var_.characterEffect10030 = var_452_0
				end

				arg_449_1.var_.alphaOldValue10030 = 1
			end

			local var_452_1 = 0.5

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_1 then
				if arg_449_1.var_.characterEffect10030 then
					arg_449_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_449_1.var_.alphaOldValue10030, 0, (arg_449_1.time_ - 0) / var_452_1)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_1 and arg_449_1.time_ < 0 + var_452_1 + arg_452_0 and arg_449_1.var_.characterEffect10030 then
				arg_449_1.var_.characterEffect10030.alpha = 0
			end

			local var_452_2 = 0
			local var_452_3 = 1.15

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_2 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, false)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_4 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(115311111).content)

				arg_449_1.text_.text = var_452_4

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_6 = 46 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_4) / 46)

				if (46 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_4) / 46)) > 0 and var_452_3 < var_452_6 then
					arg_449_1.talkMaxDuration = var_452_6

					if var_452_6 + var_452_2 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_6 + var_452_2
					end
				end

				arg_449_1.text_.text = var_452_4
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_7 = math.max(var_452_3, arg_449_1.talkMaxDuration)

			if var_452_2 <= arg_449_1.time_ and arg_449_1.time_ < var_452_2 + var_452_7 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_2) / var_452_7

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_2 + var_452_7 and arg_449_1.time_ < var_452_2 + var_452_7 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play115311112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 115311112
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play115311113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 1

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_1 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(115311112).content)

				arg_453_1.text_.text = var_456_1

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_3 = 40 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_1) / 40)

				if (40 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_1) / 40)) > 0 and var_456_0 < var_456_3 then
					arg_453_1.talkMaxDuration = var_456_3

					if var_456_3 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_3 + 0
					end
				end

				arg_453_1.text_.text = var_456_1
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_4 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_4 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_4

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_4 and arg_453_1.time_ < 0 + var_456_4 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play115311113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 115311113
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play115311114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0.65

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_1 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(115311113).content)

				arg_457_1.text_.text = var_460_1

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_3 = 26 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 26)

				if (26 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 26)) > 0 and var_460_0 < var_460_3 then
					arg_457_1.talkMaxDuration = var_460_3

					if var_460_3 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_3 + 0
					end
				end

				arg_457_1.text_.text = var_460_1
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_4 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_4 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_4

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_4 and arg_457_1.time_ < 0 + var_460_4 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play115311114 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 115311114
		arg_461_1.duration_ = 5.1

		local var_461_0 = {
			ja = 5,
			ko = 4.033,
			zh = 5.1,
			en = 4.233
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play115311115(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				local var_464_0 = arg_461_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_464_0 then
					arg_461_1.var_.alphaOldValue10030 = var_464_0.alpha
					arg_461_1.var_.characterEffect10030 = var_464_0
				end

				arg_461_1.var_.alphaOldValue10030 = 0
			end

			local var_464_1 = 0.5

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_1 then
				if arg_461_1.var_.characterEffect10030 then
					arg_461_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_461_1.var_.alphaOldValue10030, 1, (arg_461_1.time_ - 0) / var_464_1)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_1 and arg_461_1.time_ < 0 + var_464_1 + arg_464_0 and arg_461_1.var_.characterEffect10030 then
				arg_461_1.var_.characterEffect10030.alpha = 1
			end

			local var_464_2 = arg_461_1.actors_["10030"]

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(var_464_2) and arg_461_1.var_.actorSpriteComps10030 == nil then
				arg_461_1.var_.actorSpriteComps10030 = var_464_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_464_3 = 0.2

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_3 and not isNil(var_464_2) then
				if arg_461_1.var_.actorSpriteComps10030 then
					for iter_464_0, iter_464_1 in pairs(arg_461_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_464_1 then
							if arg_461_1.isInRecall_ then
								iter_464_1.color = Color.New(Mathf.Lerp(iter_464_1.color.r, arg_461_1.hightColor1.r, (arg_461_1.time_ - 0) / var_464_3), Mathf.Lerp(iter_464_1.color.g, arg_461_1.hightColor1.g, (arg_461_1.time_ - 0) / var_464_3), (Mathf.Lerp(iter_464_1.color.b, arg_461_1.hightColor1.b, (arg_461_1.time_ - 0) / var_464_3)))
							else
								local var_464_4 = Mathf.Lerp(iter_464_1.color.r, 1, (arg_461_1.time_ - 0) / var_464_3)

								iter_464_1.color = Color.New(var_464_4, var_464_4, var_464_4)
							end
						end
					end
				end
			end

			if arg_461_1.time_ >= 0 + var_464_3 and arg_461_1.time_ < 0 + var_464_3 + arg_464_0 and not isNil(var_464_2) and arg_461_1.var_.actorSpriteComps10030 then
				for iter_464_2, iter_464_3 in pairs(arg_461_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_464_3 then
						iter_464_3.color = arg_461_1.isInRecall_ and (arg_461_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_461_1.var_.actorSpriteComps10030 = nil
			end

			local var_464_5 = arg_461_1.actors_["10030"].transform

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos10030 = var_464_5.localPosition
				var_464_5.localScale = Vector3.New(1, 1, 1)

				arg_461_1:CheckSpriteTmpPos("10030", 3)

				for iter_464_4 = 0, var_464_5.childCount - 1 do
					local var_464_6 = var_464_5:GetChild(iter_464_4)

					if var_464_6.name == "split_1" or not string.find(var_464_6.name, "split") then
						var_464_6.gameObject:SetActive(true)
					else
						var_464_6.gameObject:SetActive(false)
					end
				end
			end

			local var_464_7 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_7 then
				var_464_5.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_461_1.time_ - 0) / var_464_7)
			end

			if arg_461_1.time_ >= 0 + var_464_7 and arg_461_1.time_ < 0 + var_464_7 + arg_464_0 then
				var_464_5.localPosition = Vector3.New(0, -390, 150)
			end

			local var_464_8 = 0
			local var_464_9 = 0.375

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_8 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_10 = arg_461_1:GetWordFromCfg(115311114)
				local var_464_11 = arg_461_1:FormatText(var_464_10.content)

				arg_461_1.text_.text = var_464_11

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_13 = 15 <= 0 and var_464_9 or var_464_9 * (utf8.len(var_464_11) / 15)

				if (15 <= 0 and var_464_9 or var_464_9 * (utf8.len(var_464_11) / 15)) > 0 and var_464_9 < var_464_13 then
					arg_461_1.talkMaxDuration = var_464_13

					if var_464_13 + var_464_8 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_13 + var_464_8
					end
				end

				arg_461_1.text_.text = var_464_11
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311114", "story_v_out_115311.awb") ~= 0 then
					local var_464_14 = manager.audio:GetVoiceLength("story_v_out_115311", "115311114", "story_v_out_115311.awb") / 1000

					if var_464_14 + var_464_8 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_14 + var_464_8
					end

					if var_464_10.prefab_name ~= "" and arg_461_1.actors_[var_464_10.prefab_name] ~= nil then
						local var_464_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_10.prefab_name].transform, "story_v_out_115311", "115311114", "story_v_out_115311.awb")

						arg_461_1:RecordAudio("115311114", var_464_15)
						arg_461_1:RecordAudio("115311114", var_464_15)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_115311", "115311114", "story_v_out_115311.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_115311", "115311114", "story_v_out_115311.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_16 = math.max(var_464_9, arg_461_1.talkMaxDuration)

			if var_464_8 <= arg_461_1.time_ and arg_461_1.time_ < var_464_8 + var_464_16 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_8) / var_464_16

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_8 + var_464_16 and arg_461_1.time_ < var_464_8 + var_464_16 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
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

		arg_461_1:InitPlayNodeList()
	end,
	Play115311115 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 115311115
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play115311116(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				local var_468_0 = arg_465_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_468_0 then
					arg_465_1.var_.alphaOldValue10030 = var_468_0.alpha
					arg_465_1.var_.characterEffect10030 = var_468_0
				end

				arg_465_1.var_.alphaOldValue10030 = 1
			end

			local var_468_1 = 0.5

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_1 then
				if arg_465_1.var_.characterEffect10030 then
					arg_465_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_465_1.var_.alphaOldValue10030, 0, (arg_465_1.time_ - 0) / var_468_1)
				end
			end

			if arg_465_1.time_ >= 0 + var_468_1 and arg_465_1.time_ < 0 + var_468_1 + arg_468_0 and arg_465_1.var_.characterEffect10030 then
				arg_465_1.var_.characterEffect10030.alpha = 0
			end

			local var_468_2 = 0
			local var_468_3 = 0.875

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_2 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_4 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(115311115).content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_6 = 35 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_4) / 35)

				if (35 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_4) / 35)) > 0 and var_468_3 < var_468_6 then
					arg_465_1.talkMaxDuration = var_468_6

					if var_468_6 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_6 + var_468_2
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_3, arg_465_1.talkMaxDuration)

			if var_468_2 <= arg_465_1.time_ and arg_465_1.time_ < var_468_2 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_2) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_2 + var_468_7 and arg_465_1.time_ < var_468_2 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play115311116 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 115311116
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play115311117(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.825

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_1 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(115311116).content)

				arg_469_1.text_.text = var_472_1

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_3 = 33 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 33)

				if (33 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 33)) > 0 and var_472_0 < var_472_3 then
					arg_469_1.talkMaxDuration = var_472_3

					if var_472_3 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_3 + 0
					end
				end

				arg_469_1.text_.text = var_472_1
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_4 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_4 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_4

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_4 and arg_469_1.time_ < 0 + var_472_4 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play115311117 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 115311117
		arg_473_1.duration_ = 5.53

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play115311118(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPosST22a = arg_473_1.bgs_.ST22a.transform.localPosition
			end

			local var_476_0 = 4.5

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 then
				arg_473_1.bgs_.ST22a.transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPosST22a, Vector3.New(0, 1, 9.5), (arg_473_1.time_ - 0) / var_476_0)
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 then
				arg_473_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_476_1 = 0

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.allBtn_.enabled = false
			end

			if arg_473_1.time_ >= var_476_1 + 4.5 and arg_473_1.time_ < var_476_1 + 4.5 + arg_476_0 then
				arg_473_1.allBtn_.enabled = true
			end

			local var_476_2 = 0
			local var_476_3 = 0.45

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_2 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_4 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(115311117).content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_6 = 18 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_4) / 18)

				if (18 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_4) / 18)) > 0 and var_476_3 < var_476_6 then
					arg_473_1.talkMaxDuration = var_476_6

					if var_476_6 + var_476_2 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_6 + var_476_2
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_3, arg_473_1.talkMaxDuration)

			if var_476_2 <= arg_473_1.time_ and arg_473_1.time_ < var_476_2 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_2) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_2 + var_476_7 and arg_473_1.time_ < var_476_2 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST22a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play115311118 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 115311118
		arg_477_1.duration_ = 7.87

		local var_477_0 = {
			ja = 6.866,
			ko = 6.766,
			zh = 7.866,
			en = 7.6
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play115311119(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 2 < arg_477_1.time_ and arg_477_1.time_ <= 2 + arg_480_0 then
				local var_480_0 = arg_477_1.bgs_.ST28a

				arg_477_1.bgs_.ST28a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_480_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_480_1 = var_480_0:GetComponent("SpriteRenderer")

				if var_480_1 and var_480_1.sprite then
					local var_480_2 = 2 * (var_480_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_480_0.transform.localScale = Vector3.New(var_480_2 / var_480_1.sprite.bounds.size.y < var_480_2 * manager.ui.mainCameraCom_.aspect / var_480_1.sprite.bounds.size.x and var_480_2 * manager.ui.mainCameraCom_.aspect / var_480_1.sprite.bounds.size.x or var_480_2 / var_480_1.sprite.bounds.size.y, var_480_2 / var_480_1.sprite.bounds.size.y < var_480_2 * manager.ui.mainCameraCom_.aspect / var_480_1.sprite.bounds.size.x and var_480_2 * manager.ui.mainCameraCom_.aspect / var_480_1.sprite.bounds.size.x or var_480_2 / var_480_1.sprite.bounds.size.y, 0)
				end

				for iter_480_0, iter_480_1 in pairs(arg_477_1.bgs_) do
					if iter_480_0 ~= "ST28a" then
						iter_480_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_480_3 = 0

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_3 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = true

				arg_477_1:SetGaussion(false)
			end

			local var_480_4 = 2

			if var_480_3 <= arg_477_1.time_ and arg_477_1.time_ < var_480_3 + var_480_4 then
				local var_480_5 = Color.New(0, 0, 0)

				var_480_5.a = Mathf.Lerp(0, 1, (arg_477_1.time_ - var_480_3) / var_480_4)
				arg_477_1.mask_.color = var_480_5
			end

			if arg_477_1.time_ >= var_480_3 + var_480_4 and arg_477_1.time_ < var_480_3 + var_480_4 + arg_480_0 then
				local var_480_6 = Color.New(0, 0, 0)

				var_480_6.a = 1
				arg_477_1.mask_.color = var_480_6
			end

			local var_480_7 = 2

			if 2 < arg_477_1.time_ and arg_477_1.time_ <= var_480_7 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = true

				arg_477_1:SetGaussion(false)
			end

			local var_480_8 = 2

			if var_480_7 <= arg_477_1.time_ and arg_477_1.time_ < var_480_7 + var_480_8 then
				local var_480_9 = Color.New(0, 0, 0)

				var_480_9.a = Mathf.Lerp(1, 0, (arg_477_1.time_ - var_480_7) / var_480_8)
				arg_477_1.mask_.color = var_480_9
			end

			if arg_477_1.time_ >= var_480_7 + var_480_8 and arg_477_1.time_ < var_480_7 + var_480_8 + arg_480_0 then
				local var_480_10 = Color.New(0, 0, 0)

				arg_477_1.mask_.enabled = false
				var_480_10.a = 0
				arg_477_1.mask_.color = var_480_10
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_480_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_477_1.bgmTxt_.text ~= var_480_13 and arg_477_1.bgmTxt_.text ~= "" then
						if arg_477_1.bgmTxt2_.text ~= "" then
							arg_477_1.bgmTxt_.text = arg_477_1.bgmTxt2_.text
						end

						arg_477_1.bgmTxt2_.text = var_480_13

						arg_477_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_477_1.bgmTxt_.text = var_480_13
						arg_477_1.bgmTxt2_.text = var_480_13
					end

					if arg_477_1.bgmTimer then
						arg_477_1.bgmTimer:Stop()

						arg_477_1.bgmTimer = nil
					end

					if arg_477_1.settingData.show_music_name == 1 then
						arg_477_1.musicController:SetSelectedState("show")
						arg_477_1.musicAnimator_:Play("open", 0, 0)

						if arg_477_1.settingData.music_time ~= 0 then
							arg_477_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_477_1.settingData.music_time), function()
								if arg_477_1 == nil or isNil(arg_477_1.bgmTxt_) then
									return
								end

								arg_477_1.musicController:SetSelectedState("hide")
								arg_477_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 4 < arg_477_1.time_ and arg_477_1.time_ <= 4 + arg_480_0 then
				arg_477_1:AudioAction("play", "music", "bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess.awb")

				local var_480_16 = manager.audio:GetAudioName("bgm_activity_1_3_warchess", "bgm_activity_1_3_warchess")

				if "" ~= "" then
					if arg_477_1.bgmTxt_.text ~= var_480_16 and arg_477_1.bgmTxt_.text ~= "" then
						if arg_477_1.bgmTxt2_.text ~= "" then
							arg_477_1.bgmTxt_.text = arg_477_1.bgmTxt2_.text
						end

						arg_477_1.bgmTxt2_.text = var_480_16

						arg_477_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_477_1.bgmTxt_.text = var_480_16
						arg_477_1.bgmTxt2_.text = var_480_16
					end

					if arg_477_1.bgmTimer then
						arg_477_1.bgmTimer:Stop()

						arg_477_1.bgmTimer = nil
					end

					if arg_477_1.settingData.show_music_name == 1 then
						arg_477_1.musicController:SetSelectedState("show")
						arg_477_1.musicAnimator_:Play("open", 0, 0)

						if arg_477_1.settingData.music_time ~= 0 then
							arg_477_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_477_1.settingData.music_time), function()
								if arg_477_1 == nil or isNil(arg_477_1.bgmTxt_) then
									return
								end

								arg_477_1.musicController:SetSelectedState("hide")
								arg_477_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_477_1.frameCnt_ <= 1 then
				arg_477_1.dialog_:SetActive(false)
			end

			local var_480_17 = 4
			local var_480_18 = 0.3

			if 4 < arg_477_1.time_ and arg_477_1.time_ <= var_480_17 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0

				arg_477_1.dialog_:SetActive(true)

				arg_477_1.dialogCg_.alpha = 0

				local var_480_19 = LeanTween.value(arg_477_1.dialog_, 0, 1, 0.3)

				var_480_19:setOnUpdate(LuaHelper.FloatAction(function(arg_483_0)
					arg_477_1.dialogCg_.alpha = arg_483_0
				end))
				var_480_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_477_1.dialog_)
					var_480_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_477_1.duration_ = arg_477_1.duration_ + 0.3

				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_20 = arg_477_1:GetWordFromCfg(115311118)
				local var_480_21 = arg_477_1:FormatText(var_480_20.content)

				arg_477_1.text_.text = var_480_21

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_23 = 12 <= 0 and var_480_18 or var_480_18 * (utf8.len(var_480_21) / 12)

				if (12 <= 0 and var_480_18 or var_480_18 * (utf8.len(var_480_21) / 12)) > 0 and var_480_18 < var_480_23 then
					arg_477_1.talkMaxDuration = var_480_23
					var_480_17 = var_480_17 + 0.3

					if var_480_23 + var_480_17 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_23 + var_480_17
					end
				end

				arg_477_1.text_.text = var_480_21
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311118", "story_v_out_115311.awb") ~= 0 then
					local var_480_24 = manager.audio:GetVoiceLength("story_v_out_115311", "115311118", "story_v_out_115311.awb") / 1000

					if var_480_24 + var_480_17 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_24 + var_480_17
					end

					if var_480_20.prefab_name ~= "" and arg_477_1.actors_[var_480_20.prefab_name] ~= nil then
						local var_480_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_20.prefab_name].transform, "story_v_out_115311", "115311118", "story_v_out_115311.awb")

						arg_477_1:RecordAudio("115311118", var_480_25)
						arg_477_1:RecordAudio("115311118", var_480_25)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_115311", "115311118", "story_v_out_115311.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_115311", "115311118", "story_v_out_115311.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_26 = var_480_17 + 0.3
			local var_480_27 = math.max(var_480_18, arg_477_1.talkMaxDuration)

			if var_480_17 + 0.3 <= arg_477_1.time_ and arg_477_1.time_ < var_480_26 + var_480_27 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_26) / var_480_27

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_26 + var_480_27 and arg_477_1.time_ < var_480_26 + var_480_27 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play115311119 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 115311119
		arg_485_1.duration_ = 6.6

		local var_485_0 = {
			ja = 5,
			ko = 6.6,
			zh = 5.8,
			en = 6.1
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play115311120(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0.5

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[105].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_1 = arg_485_1:GetWordFromCfg(115311119)
				local var_488_2 = arg_485_1:FormatText(var_488_1.content)

				arg_485_1.text_.text = var_488_2

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_4 = 20 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 20)

				if (20 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 20)) > 0 and var_488_0 < var_488_4 then
					arg_485_1.talkMaxDuration = var_488_4

					if var_488_4 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_4 + 0
					end
				end

				arg_485_1.text_.text = var_488_2
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311119", "story_v_out_115311.awb") ~= 0 then
					local var_488_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311119", "story_v_out_115311.awb") / 1000

					if var_488_5 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_5 + 0
					end

					if var_488_1.prefab_name ~= "" and arg_485_1.actors_[var_488_1.prefab_name] ~= nil then
						local var_488_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_1.prefab_name].transform, "story_v_out_115311", "115311119", "story_v_out_115311.awb")

						arg_485_1:RecordAudio("115311119", var_488_6)
						arg_485_1:RecordAudio("115311119", var_488_6)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_115311", "115311119", "story_v_out_115311.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_115311", "115311119", "story_v_out_115311.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_7 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_7 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_7

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_7 and arg_485_1.time_ < 0 + var_488_7 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play115311120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 115311120
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play115311121(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.725

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_1 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(115311120).content)

				arg_489_1.text_.text = var_492_1

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_3 = 29 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 29)

				if (29 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 29)) > 0 and var_492_0 < var_492_3 then
					arg_489_1.talkMaxDuration = var_492_3

					if var_492_3 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_3 + 0
					end
				end

				arg_489_1.text_.text = var_492_1
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_4 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_4 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_4

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_4 and arg_489_1.time_ < 0 + var_492_4 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play115311121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 115311121
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play115311122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 1.4

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_1 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(115311121).content)

				arg_493_1.text_.text = var_496_1

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_3 = 56 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 56)

				if (56 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 56)) > 0 and var_496_0 < var_496_3 then
					arg_493_1.talkMaxDuration = var_496_3

					if var_496_3 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_3 + 0
					end
				end

				arg_493_1.text_.text = var_496_1
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_4 = math.max(var_496_0, arg_493_1.talkMaxDuration)

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_4 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - 0) / var_496_4

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= 0 + var_496_4 and arg_493_1.time_ < 0 + var_496_4 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play115311122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 115311122
		arg_497_1.duration_ = 7

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play115311123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.mask_.enabled = true
				arg_497_1.mask_.raycastTarget = true

				arg_497_1:SetGaussion(false)
			end

			local var_500_0 = 2

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 then
				local var_500_1 = Color.New(1, 1, 1)

				var_500_1.a = Mathf.Lerp(1, 0, (arg_497_1.time_ - 0) / var_500_0)
				arg_497_1.mask_.color = var_500_1
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 then
				local var_500_2 = Color.New(1, 1, 1)

				arg_497_1.mask_.enabled = false
				var_500_2.a = 0
				arg_497_1.mask_.color = var_500_2
			end

			if arg_497_1.frameCnt_ <= 1 then
				arg_497_1.dialog_:SetActive(false)
			end

			local var_500_3 = 2
			local var_500_4 = 1.15

			if 2 < arg_497_1.time_ and arg_497_1.time_ <= var_500_3 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0

				arg_497_1.dialog_:SetActive(true)

				arg_497_1.dialogCg_.alpha = 0

				local var_500_5 = LeanTween.value(arg_497_1.dialog_, 0, 1, 0.3)

				var_500_5:setOnUpdate(LuaHelper.FloatAction(function(arg_501_0)
					arg_497_1.dialogCg_.alpha = arg_501_0
				end))
				var_500_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_497_1.dialog_)
					var_500_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_497_1.duration_ = arg_497_1.duration_ + 0.3

				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_6 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(115311122).content)

				arg_497_1.text_.text = var_500_6

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_8 = 46 <= 0 and var_500_4 or var_500_4 * (utf8.len(var_500_6) / 46)

				if (46 <= 0 and var_500_4 or var_500_4 * (utf8.len(var_500_6) / 46)) > 0 and var_500_4 < var_500_8 then
					arg_497_1.talkMaxDuration = var_500_8
					var_500_3 = var_500_3 + 0.3

					if var_500_8 + var_500_3 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_8 + var_500_3
					end
				end

				arg_497_1.text_.text = var_500_6
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_9 = var_500_3 + 0.3
			local var_500_10 = math.max(var_500_4, arg_497_1.talkMaxDuration)

			if var_500_3 + 0.3 <= arg_497_1.time_ and arg_497_1.time_ < var_500_9 + var_500_10 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_9) / var_500_10

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_9 + var_500_10 and arg_497_1.time_ < var_500_9 + var_500_10 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play115311123 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 115311123
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play115311124(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 1.725

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_1 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(115311123).content)

				arg_503_1.text_.text = var_506_1

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_3 = 69 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_1) / 69)

				if (69 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_1) / 69)) > 0 and var_506_0 < var_506_3 then
					arg_503_1.talkMaxDuration = var_506_3

					if var_506_3 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_3 + 0
					end
				end

				arg_503_1.text_.text = var_506_1
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_4 = math.max(var_506_0, arg_503_1.talkMaxDuration)

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_4 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - 0) / var_506_4

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= 0 + var_506_4 and arg_503_1.time_ < 0 + var_506_4 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play115311124 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 115311124
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play115311125(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 1.8

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_1 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(115311124).content)

				arg_507_1.text_.text = var_510_1

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_3 = 72 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 72)

				if (72 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 72)) > 0 and var_510_0 < var_510_3 then
					arg_507_1.talkMaxDuration = var_510_3

					if var_510_3 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_3 + 0
					end
				end

				arg_507_1.text_.text = var_510_1
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_4 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_4 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_4

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_4 and arg_507_1.time_ < 0 + var_510_4 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play115311125 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 115311125
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play115311126(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 1.25

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_1 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(115311125).content)

				arg_511_1.text_.text = var_514_1

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_3 = 50 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 50)

				if (50 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 50)) > 0 and var_514_0 < var_514_3 then
					arg_511_1.talkMaxDuration = var_514_3

					if var_514_3 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_3 + 0
					end
				end

				arg_511_1.text_.text = var_514_1
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_4 = math.max(var_514_0, arg_511_1.talkMaxDuration)

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_4 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - 0) / var_514_4

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= 0 + var_514_4 and arg_511_1.time_ < 0 + var_514_4 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play115311126 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 115311126
		arg_515_1.duration_ = 6.77

		local var_515_0 = {
			ja = 6.766,
			ko = 5.566,
			zh = 5.633,
			en = 5.9
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play115311127(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0.6

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[316].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_1 = arg_515_1:GetWordFromCfg(115311126)
				local var_518_2 = arg_515_1:FormatText(var_518_1.content)

				arg_515_1.text_.text = var_518_2

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_4 = 24 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 24)

				if (24 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 24)) > 0 and var_518_0 < var_518_4 then
					arg_515_1.talkMaxDuration = var_518_4

					if var_518_4 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_4 + 0
					end
				end

				arg_515_1.text_.text = var_518_2
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311126", "story_v_out_115311.awb") ~= 0 then
					local var_518_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311126", "story_v_out_115311.awb") / 1000

					if var_518_5 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_5 + 0
					end

					if var_518_1.prefab_name ~= "" and arg_515_1.actors_[var_518_1.prefab_name] ~= nil then
						local var_518_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_1.prefab_name].transform, "story_v_out_115311", "115311126", "story_v_out_115311.awb")

						arg_515_1:RecordAudio("115311126", var_518_6)
						arg_515_1:RecordAudio("115311126", var_518_6)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_115311", "115311126", "story_v_out_115311.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_115311", "115311126", "story_v_out_115311.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_7 = math.max(var_518_0, arg_515_1.talkMaxDuration)

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_7 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - 0) / var_518_7

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= 0 + var_518_7 and arg_515_1.time_ < 0 + var_518_7 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play115311127 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 115311127
		arg_519_1.duration_ = 8.1

		local var_519_0 = {
			ja = 8.1,
			ko = 6.566,
			zh = 4.7,
			en = 6.566
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
				arg_519_0:Play115311128(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0.625

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundedd")

				arg_519_1.callingController_:SetSelectedState("normal")

				arg_519_1.keyicon_.color = Color.New(1, 1, 1)
				arg_519_1.icon_.color = Color.New(1, 1, 1)

				local var_522_1 = arg_519_1:GetWordFromCfg(115311127)
				local var_522_2 = arg_519_1:FormatText(var_522_1.content)

				arg_519_1.text_.text = var_522_2

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_4 = 25 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_2) / 25)

				if (25 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_2) / 25)) > 0 and var_522_0 < var_522_4 then
					arg_519_1.talkMaxDuration = var_522_4

					if var_522_4 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_4 + 0
					end
				end

				arg_519_1.text_.text = var_522_2
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311127", "story_v_out_115311.awb") ~= 0 then
					local var_522_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311127", "story_v_out_115311.awb") / 1000

					if var_522_5 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_5 + 0
					end

					if var_522_1.prefab_name ~= "" and arg_519_1.actors_[var_522_1.prefab_name] ~= nil then
						local var_522_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_1.prefab_name].transform, "story_v_out_115311", "115311127", "story_v_out_115311.awb")

						arg_519_1:RecordAudio("115311127", var_522_6)
						arg_519_1:RecordAudio("115311127", var_522_6)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_115311", "115311127", "story_v_out_115311.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_115311", "115311127", "story_v_out_115311.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_7 = math.max(var_522_0, arg_519_1.talkMaxDuration)

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_7 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - 0) / var_522_7

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= 0 + var_522_7 and arg_519_1.time_ < 0 + var_522_7 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play115311128 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 115311128
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play115311129(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 1

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_1 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(115311128).content)

				arg_523_1.text_.text = var_526_1

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_3 = 40 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 40)

				if (40 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 40)) > 0 and var_526_0 < var_526_3 then
					arg_523_1.talkMaxDuration = var_526_3

					if var_526_3 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_3 + 0
					end
				end

				arg_523_1.text_.text = var_526_1
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_4 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_4

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play115311129 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 115311129
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play115311130(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 1.15

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, false)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_1 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(115311129).content)

				arg_527_1.text_.text = var_530_1

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_3 = 46 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 46)

				if (46 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 46)) > 0 and var_530_0 < var_530_3 then
					arg_527_1.talkMaxDuration = var_530_3

					if var_530_3 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_3 + 0
					end
				end

				arg_527_1.text_.text = var_530_1
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_4 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_4 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_4

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_4 and arg_527_1.time_ < 0 + var_530_4 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play115311130 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 115311130
		arg_531_1.duration_ = 4.67

		local var_531_0 = {
			ja = 4.666,
			ko = 2.533,
			zh = 3.5,
			en = 2.566
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
				arg_531_0:Play115311131(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.var_.moveOldPos113801_1 = arg_531_1.actors_["113801_1"].transform.localPosition
				arg_531_1.actors_["113801_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_531_1:CheckSpriteTmpPos("113801_1", 3)
			end

			local var_534_0 = 0.001

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 then
				arg_531_1.actors_["113801_1"].transform.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos113801_1, Vector3.New(0, -310, -370), (arg_531_1.time_ - 0) / var_534_0)
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 then
				arg_531_1.actors_["113801_1"].transform.localPosition = Vector3.New(0, -310, -370)
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				local var_534_1 = arg_531_1.actors_["113801_1"]:GetComponent("Image")

				if var_534_1 then
					arg_531_1.var_.alphaMatValue113801_1 = var_534_1
					arg_531_1.var_.alphaOldValue113801_1 = var_534_1.color.a
				end

				arg_531_1.var_.alphaOldValue113801_1 = 0
			end

			local var_534_2 = 0.5

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_2 then
				if arg_531_1.var_.alphaMatValue113801_1 then
					arg_531_1.var_.alphaMatValue113801_1.color.a = Mathf.Lerp(arg_531_1.var_.alphaOldValue113801_1, 1, (arg_531_1.time_ - 0) / var_534_2)
					arg_531_1.var_.alphaMatValue113801_1.color = arg_531_1.var_.alphaMatValue113801_1.color
				end
			end

			if arg_531_1.time_ >= 0 + var_534_2 and arg_531_1.time_ < 0 + var_534_2 + arg_534_0 and arg_531_1.var_.alphaMatValue113801_1 then
				arg_531_1.var_.alphaMatValue113801_1.color.a = 1
				arg_531_1.var_.alphaMatValue113801_1.color = arg_531_1.var_.alphaMatValue113801_1.color
			end

			local var_534_3 = arg_531_1.actors_["113801_1"]

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(var_534_3) then
				local var_534_4 = var_534_3:GetComponent("Image")

				if var_534_4 then
					arg_531_1.var_.highlightMatValue113801_1 = var_534_4
				end
			end

			local var_534_5 = 0.2

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_5 and not isNil(var_534_3) then
				if arg_531_1.var_.highlightMatValue113801_1 then
					local var_534_6 = Mathf.Lerp(0.5, 1, (arg_531_1.time_ - 0) / var_534_5)

					arg_531_1.var_.highlightMatValue113801_1.color.r = var_534_6
					arg_531_1.var_.highlightMatValue113801_1.color.g = var_534_6
					arg_531_1.var_.highlightMatValue113801_1.color.b = var_534_6
					arg_531_1.var_.highlightMatValue113801_1.color = arg_531_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_531_1.time_ >= 0 + var_534_5 and arg_531_1.time_ < 0 + var_534_5 + arg_534_0 and not isNil(var_534_3) and arg_531_1.var_.highlightMatValue113801_1 then
				var_534_3.transform:SetSiblingIndex(1)

				arg_531_1.var_.highlightMatValue113801_1.color.r = 1
				arg_531_1.var_.highlightMatValue113801_1.color.g = 1
				arg_531_1.var_.highlightMatValue113801_1.color.b = 1
				arg_531_1.var_.highlightMatValue113801_1.color = arg_531_1.var_.highlightMatValue113801_1.color
			end

			local var_534_7 = 0
			local var_534_8 = 0.25

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_7 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_9 = arg_531_1:GetWordFromCfg(115311130)
				local var_534_10 = arg_531_1:FormatText(var_534_9.content)

				arg_531_1.text_.text = var_534_10

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_12 = 10 <= 0 and var_534_8 or var_534_8 * (utf8.len(var_534_10) / 10)

				if (10 <= 0 and var_534_8 or var_534_8 * (utf8.len(var_534_10) / 10)) > 0 and var_534_8 < var_534_12 then
					arg_531_1.talkMaxDuration = var_534_12

					if var_534_12 + var_534_7 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_12 + var_534_7
					end
				end

				arg_531_1.text_.text = var_534_10
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311130", "story_v_out_115311.awb") ~= 0 then
					local var_534_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311130", "story_v_out_115311.awb") / 1000

					if var_534_13 + var_534_7 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_13 + var_534_7
					end

					if var_534_9.prefab_name ~= "" and arg_531_1.actors_[var_534_9.prefab_name] ~= nil then
						local var_534_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_9.prefab_name].transform, "story_v_out_115311", "115311130", "story_v_out_115311.awb")

						arg_531_1:RecordAudio("115311130", var_534_14)
						arg_531_1:RecordAudio("115311130", var_534_14)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_115311", "115311130", "story_v_out_115311.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_115311", "115311130", "story_v_out_115311.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_15 = math.max(var_534_8, arg_531_1.talkMaxDuration)

			if var_534_7 <= arg_531_1.time_ and arg_531_1.time_ < var_534_7 + var_534_15 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_7) / var_534_15

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_7 + var_534_15 and arg_531_1.time_ < var_534_7 + var_534_15 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "113801_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play115311131 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 115311131
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play115311132(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(arg_535_1.actors_["113801_1"]) then
				local var_538_0 = arg_535_1.actors_["113801_1"]:GetComponent("Image")

				if var_538_0 then
					arg_535_1.var_.highlightMatValue113801_1 = var_538_0
				end
			end

			local var_538_1 = 0.2

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_1 and not isNil(arg_535_1.actors_["113801_1"]) then
				if arg_535_1.var_.highlightMatValue113801_1 then
					local var_538_2 = Mathf.Lerp(1, 0.5, (arg_535_1.time_ - 0) / var_538_1)

					arg_535_1.var_.highlightMatValue113801_1.color.r = var_538_2
					arg_535_1.var_.highlightMatValue113801_1.color.g = var_538_2
					arg_535_1.var_.highlightMatValue113801_1.color.b = var_538_2
					arg_535_1.var_.highlightMatValue113801_1.color = arg_535_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_535_1.time_ >= 0 + var_538_1 and arg_535_1.time_ < 0 + var_538_1 + arg_538_0 and not isNil(arg_535_1.actors_["113801_1"]) and arg_535_1.var_.highlightMatValue113801_1 then
				arg_535_1.var_.highlightMatValue113801_1.color.r = 0.5
				arg_535_1.var_.highlightMatValue113801_1.color.g = 0.5
				arg_535_1.var_.highlightMatValue113801_1.color.b = 0.5
				arg_535_1.var_.highlightMatValue113801_1.color = arg_535_1.var_.highlightMatValue113801_1.color
			end

			local var_538_3 = 0
			local var_538_4 = 1.7

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_3 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_5 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(115311131).content)

				arg_535_1.text_.text = var_538_5

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_7 = 68 <= 0 and var_538_4 or var_538_4 * (utf8.len(var_538_5) / 68)

				if (68 <= 0 and var_538_4 or var_538_4 * (utf8.len(var_538_5) / 68)) > 0 and var_538_4 < var_538_7 then
					arg_535_1.talkMaxDuration = var_538_7

					if var_538_7 + var_538_3 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_7 + var_538_3
					end
				end

				arg_535_1.text_.text = var_538_5
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_8 = math.max(var_538_4, arg_535_1.talkMaxDuration)

			if var_538_3 <= arg_535_1.time_ and arg_535_1.time_ < var_538_3 + var_538_8 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_3) / var_538_8

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_3 + var_538_8 and arg_535_1.time_ < var_538_3 + var_538_8 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play115311132 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 115311132
		arg_539_1.duration_ = 4.57

		local var_539_0 = {
			ja = 2.666,
			ko = 3.733,
			zh = 4.566,
			en = 3.8
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
				arg_539_0:Play115311133(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(arg_539_1.actors_["113801_1"]) then
				local var_542_0 = arg_539_1.actors_["113801_1"]:GetComponent("Image")

				if var_542_0 then
					arg_539_1.var_.highlightMatValue113801_1 = var_542_0
				end
			end

			local var_542_1 = 0.2

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_1 and not isNil(arg_539_1.actors_["113801_1"]) then
				if arg_539_1.var_.highlightMatValue113801_1 then
					local var_542_2 = Mathf.Lerp(0.5, 1, (arg_539_1.time_ - 0) / var_542_1)

					arg_539_1.var_.highlightMatValue113801_1.color.r = var_542_2
					arg_539_1.var_.highlightMatValue113801_1.color.g = var_542_2
					arg_539_1.var_.highlightMatValue113801_1.color.b = var_542_2
					arg_539_1.var_.highlightMatValue113801_1.color = arg_539_1.var_.highlightMatValue113801_1.color
				end
			end

			if arg_539_1.time_ >= 0 + var_542_1 and arg_539_1.time_ < 0 + var_542_1 + arg_542_0 and not isNil(arg_539_1.actors_["113801_1"]) and arg_539_1.var_.highlightMatValue113801_1 then
				arg_539_1.actors_["113801_1"].transform:SetSiblingIndex(1)

				arg_539_1.var_.highlightMatValue113801_1.color.r = 1
				arg_539_1.var_.highlightMatValue113801_1.color.g = 1
				arg_539_1.var_.highlightMatValue113801_1.color.b = 1
				arg_539_1.var_.highlightMatValue113801_1.color = arg_539_1.var_.highlightMatValue113801_1.color
			end

			local var_542_3 = 0
			local var_542_4 = 0.275

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_3 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_5 = arg_539_1:GetWordFromCfg(115311132)
				local var_542_6 = arg_539_1:FormatText(var_542_5.content)

				arg_539_1.text_.text = var_542_6

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_8 = 11 <= 0 and var_542_4 or var_542_4 * (utf8.len(var_542_6) / 11)

				if (11 <= 0 and var_542_4 or var_542_4 * (utf8.len(var_542_6) / 11)) > 0 and var_542_4 < var_542_8 then
					arg_539_1.talkMaxDuration = var_542_8

					if var_542_8 + var_542_3 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_8 + var_542_3
					end
				end

				arg_539_1.text_.text = var_542_6
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311132", "story_v_out_115311.awb") ~= 0 then
					local var_542_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311132", "story_v_out_115311.awb") / 1000

					if var_542_9 + var_542_3 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_9 + var_542_3
					end

					if var_542_5.prefab_name ~= "" and arg_539_1.actors_[var_542_5.prefab_name] ~= nil then
						local var_542_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_5.prefab_name].transform, "story_v_out_115311", "115311132", "story_v_out_115311.awb")

						arg_539_1:RecordAudio("115311132", var_542_10)
						arg_539_1:RecordAudio("115311132", var_542_10)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_115311", "115311132", "story_v_out_115311.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_115311", "115311132", "story_v_out_115311.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_11 = math.max(var_542_4, arg_539_1.talkMaxDuration)

			if var_542_3 <= arg_539_1.time_ and arg_539_1.time_ < var_542_3 + var_542_11 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_3) / var_542_11

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_3 + var_542_11 and arg_539_1.time_ < var_542_3 + var_542_11 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play115311133 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 115311133
		arg_543_1.duration_ = 9

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play115311134(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 2 < arg_543_1.time_ and arg_543_1.time_ <= 2 + arg_546_0 then
				local var_546_0 = arg_543_1.bgs_.ST22a

				arg_543_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_546_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_546_1 = var_546_0:GetComponent("SpriteRenderer")

				if var_546_1 and var_546_1.sprite then
					local var_546_2 = 2 * (var_546_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_546_0.transform.localScale = Vector3.New(var_546_2 / var_546_1.sprite.bounds.size.y < var_546_2 * manager.ui.mainCameraCom_.aspect / var_546_1.sprite.bounds.size.x and var_546_2 * manager.ui.mainCameraCom_.aspect / var_546_1.sprite.bounds.size.x or var_546_2 / var_546_1.sprite.bounds.size.y, var_546_2 / var_546_1.sprite.bounds.size.y < var_546_2 * manager.ui.mainCameraCom_.aspect / var_546_1.sprite.bounds.size.x and var_546_2 * manager.ui.mainCameraCom_.aspect / var_546_1.sprite.bounds.size.x or var_546_2 / var_546_1.sprite.bounds.size.y, 0)
				end

				for iter_546_0, iter_546_1 in pairs(arg_543_1.bgs_) do
					if iter_546_0 ~= "ST22a" then
						iter_546_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_546_3 = 0

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_3 + arg_546_0 then
				arg_543_1.mask_.enabled = true
				arg_543_1.mask_.raycastTarget = true

				arg_543_1:SetGaussion(false)
			end

			local var_546_4 = 2

			if var_546_3 <= arg_543_1.time_ and arg_543_1.time_ < var_546_3 + var_546_4 then
				local var_546_5 = Color.New(0, 0, 0)

				var_546_5.a = Mathf.Lerp(0, 1, (arg_543_1.time_ - var_546_3) / var_546_4)
				arg_543_1.mask_.color = var_546_5
			end

			if arg_543_1.time_ >= var_546_3 + var_546_4 and arg_543_1.time_ < var_546_3 + var_546_4 + arg_546_0 then
				local var_546_6 = Color.New(0, 0, 0)

				var_546_6.a = 1
				arg_543_1.mask_.color = var_546_6
			end

			local var_546_7 = 2

			if 2 < arg_543_1.time_ and arg_543_1.time_ <= var_546_7 + arg_546_0 then
				arg_543_1.mask_.enabled = true
				arg_543_1.mask_.raycastTarget = true

				arg_543_1:SetGaussion(false)
			end

			local var_546_8 = 2

			if var_546_7 <= arg_543_1.time_ and arg_543_1.time_ < var_546_7 + var_546_8 then
				local var_546_9 = Color.New(0, 0, 0)

				var_546_9.a = Mathf.Lerp(1, 0, (arg_543_1.time_ - var_546_7) / var_546_8)
				arg_543_1.mask_.color = var_546_9
			end

			if arg_543_1.time_ >= var_546_7 + var_546_8 and arg_543_1.time_ < var_546_7 + var_546_8 + arg_546_0 then
				local var_546_10 = Color.New(0, 0, 0)

				arg_543_1.mask_.enabled = false
				var_546_10.a = 0
				arg_543_1.mask_.color = var_546_10
			end

			local var_546_11 = arg_543_1.actors_["113801_1"].transform

			if 1.966 < arg_543_1.time_ and arg_543_1.time_ <= 1.966 + arg_546_0 then
				arg_543_1.var_.moveOldPos113801_1 = var_546_11.localPosition
				var_546_11.localScale = Vector3.New(1, 1, 1)

				arg_543_1:CheckSpriteTmpPos("113801_1", 7)
			end

			local var_546_12 = 0.001

			if 1.966 <= arg_543_1.time_ and arg_543_1.time_ < 1.966 + var_546_12 then
				var_546_11.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos113801_1, Vector3.New(0, -2000, -370), (arg_543_1.time_ - 1.966) / var_546_12)
			end

			if arg_543_1.time_ >= 1.966 + var_546_12 and arg_543_1.time_ < 1.966 + var_546_12 + arg_546_0 then
				var_546_11.localPosition = Vector3.New(0, -2000, -370)
			end

			if arg_543_1.frameCnt_ <= 1 then
				arg_543_1.dialog_:SetActive(false)
			end

			local var_546_13 = 4
			local var_546_14 = 0.575

			if 4 < arg_543_1.time_ and arg_543_1.time_ <= var_546_13 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0

				arg_543_1.dialog_:SetActive(true)

				arg_543_1.dialogCg_.alpha = 0

				local var_546_15 = LeanTween.value(arg_543_1.dialog_, 0, 1, 0.3)

				var_546_15:setOnUpdate(LuaHelper.FloatAction(function(arg_547_0)
					arg_543_1.dialogCg_.alpha = arg_547_0
				end))
				var_546_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_543_1.dialog_)
					var_546_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_543_1.duration_ = arg_543_1.duration_ + 0.3

				SetActive(arg_543_1.leftNameGo_, false)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_16 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(115311133).content)

				arg_543_1.text_.text = var_546_16

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_18 = 23 <= 0 and var_546_14 or var_546_14 * (utf8.len(var_546_16) / 23)

				if (23 <= 0 and var_546_14 or var_546_14 * (utf8.len(var_546_16) / 23)) > 0 and var_546_14 < var_546_18 then
					arg_543_1.talkMaxDuration = var_546_18
					var_546_13 = var_546_13 + 0.3

					if var_546_18 + var_546_13 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_18 + var_546_13
					end
				end

				arg_543_1.text_.text = var_546_16
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_19 = var_546_13 + 0.3
			local var_546_20 = math.max(var_546_14, arg_543_1.talkMaxDuration)

			if var_546_13 + 0.3 <= arg_543_1.time_ and arg_543_1.time_ < var_546_19 + var_546_20 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_19) / var_546_20

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_19 + var_546_20 and arg_543_1.time_ < var_546_19 + var_546_20 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "113801_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play115311134 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 115311134
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play115311135(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0.75

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, false)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_1 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(115311134).content)

				arg_549_1.text_.text = var_552_1

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_3 = 30 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_1) / 30)

				if (30 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_1) / 30)) > 0 and var_552_0 < var_552_3 then
					arg_549_1.talkMaxDuration = var_552_3

					if var_552_3 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_3 + 0
					end
				end

				arg_549_1.text_.text = var_552_1
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_4 = math.max(var_552_0, arg_549_1.talkMaxDuration)

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_4 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - 0) / var_552_4

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= 0 + var_552_4 and arg_549_1.time_ < 0 + var_552_4 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play115311135 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 115311135
		arg_553_1.duration_ = 12.83

		local var_553_0 = {
			ja = 12.833,
			ko = 5.466,
			zh = 8.133,
			en = 6.966
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play115311136(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				local var_556_0 = arg_553_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_556_0 then
					arg_553_1.var_.alphaOldValue10030 = var_556_0.alpha
					arg_553_1.var_.characterEffect10030 = var_556_0
				end

				arg_553_1.var_.alphaOldValue10030 = 0
			end

			local var_556_1 = 0.5

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_1 then
				if arg_553_1.var_.characterEffect10030 then
					arg_553_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_553_1.var_.alphaOldValue10030, 1, (arg_553_1.time_ - 0) / var_556_1)
				end
			end

			if arg_553_1.time_ >= 0 + var_556_1 and arg_553_1.time_ < 0 + var_556_1 + arg_556_0 and arg_553_1.var_.characterEffect10030 then
				arg_553_1.var_.characterEffect10030.alpha = 1
			end

			local var_556_2 = arg_553_1.actors_["10030"]

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(var_556_2) and arg_553_1.var_.actorSpriteComps10030 == nil then
				arg_553_1.var_.actorSpriteComps10030 = var_556_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_3 = 0.2

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_3 and not isNil(var_556_2) then
				if arg_553_1.var_.actorSpriteComps10030 then
					for iter_556_0, iter_556_1 in pairs(arg_553_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_556_1 then
							if arg_553_1.isInRecall_ then
								iter_556_1.color = Color.New(Mathf.Lerp(iter_556_1.color.r, arg_553_1.hightColor1.r, (arg_553_1.time_ - 0) / var_556_3), Mathf.Lerp(iter_556_1.color.g, arg_553_1.hightColor1.g, (arg_553_1.time_ - 0) / var_556_3), (Mathf.Lerp(iter_556_1.color.b, arg_553_1.hightColor1.b, (arg_553_1.time_ - 0) / var_556_3)))
							else
								local var_556_4 = Mathf.Lerp(iter_556_1.color.r, 1, (arg_553_1.time_ - 0) / var_556_3)

								iter_556_1.color = Color.New(var_556_4, var_556_4, var_556_4)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= 0 + var_556_3 and arg_553_1.time_ < 0 + var_556_3 + arg_556_0 and not isNil(var_556_2) and arg_553_1.var_.actorSpriteComps10030 then
				for iter_556_2, iter_556_3 in pairs(arg_553_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_556_3 then
						iter_556_3.color = arg_553_1.isInRecall_ and (arg_553_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_553_1.var_.actorSpriteComps10030 = nil
			end

			local var_556_5 = arg_553_1.actors_["10030"].transform

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.var_.moveOldPos10030 = var_556_5.localPosition
				var_556_5.localScale = Vector3.New(1, 1, 1)

				arg_553_1:CheckSpriteTmpPos("10030", 3)

				for iter_556_4 = 0, var_556_5.childCount - 1 do
					local var_556_6 = var_556_5:GetChild(iter_556_4)

					if var_556_6.name == "split_2" or not string.find(var_556_6.name, "split") then
						var_556_6.gameObject:SetActive(true)
					else
						var_556_6.gameObject:SetActive(false)
					end
				end
			end

			local var_556_7 = 0.001

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_7 then
				var_556_5.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_553_1.time_ - 0) / var_556_7)
			end

			if arg_553_1.time_ >= 0 + var_556_7 and arg_553_1.time_ < 0 + var_556_7 + arg_556_0 then
				var_556_5.localPosition = Vector3.New(0, -390, 150)
			end

			local var_556_8 = 0
			local var_556_9 = 0.525

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_8 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_10 = arg_553_1:GetWordFromCfg(115311135)
				local var_556_11 = arg_553_1:FormatText(var_556_10.content)

				arg_553_1.text_.text = var_556_11

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_13 = 21 <= 0 and var_556_9 or var_556_9 * (utf8.len(var_556_11) / 21)

				if (21 <= 0 and var_556_9 or var_556_9 * (utf8.len(var_556_11) / 21)) > 0 and var_556_9 < var_556_13 then
					arg_553_1.talkMaxDuration = var_556_13

					if var_556_13 + var_556_8 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_13 + var_556_8
					end
				end

				arg_553_1.text_.text = var_556_11
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311135", "story_v_out_115311.awb") ~= 0 then
					local var_556_14 = manager.audio:GetVoiceLength("story_v_out_115311", "115311135", "story_v_out_115311.awb") / 1000

					if var_556_14 + var_556_8 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_14 + var_556_8
					end

					if var_556_10.prefab_name ~= "" and arg_553_1.actors_[var_556_10.prefab_name] ~= nil then
						local var_556_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_10.prefab_name].transform, "story_v_out_115311", "115311135", "story_v_out_115311.awb")

						arg_553_1:RecordAudio("115311135", var_556_15)
						arg_553_1:RecordAudio("115311135", var_556_15)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_115311", "115311135", "story_v_out_115311.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_115311", "115311135", "story_v_out_115311.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_16 = math.max(var_556_9, arg_553_1.talkMaxDuration)

			if var_556_8 <= arg_553_1.time_ and arg_553_1.time_ < var_556_8 + var_556_16 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_8) / var_556_16

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_8 + var_556_16 and arg_553_1.time_ < var_556_8 + var_556_16 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
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

		arg_553_1:InitPlayNodeList()
	end,
	Play115311136 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 115311136
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play115311137(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(arg_557_1.actors_["10030"]) and arg_557_1.var_.actorSpriteComps10030 == nil then
				arg_557_1.var_.actorSpriteComps10030 = arg_557_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_560_0 = 0.2

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 and not isNil(arg_557_1.actors_["10030"]) then
				if arg_557_1.var_.actorSpriteComps10030 then
					for iter_560_0, iter_560_1 in pairs(arg_557_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_560_1 then
							if arg_557_1.isInRecall_ then
								iter_560_1.color = Color.New(Mathf.Lerp(iter_560_1.color.r, arg_557_1.hightColor2.r, (arg_557_1.time_ - 0) / var_560_0), Mathf.Lerp(iter_560_1.color.g, arg_557_1.hightColor2.g, (arg_557_1.time_ - 0) / var_560_0), (Mathf.Lerp(iter_560_1.color.b, arg_557_1.hightColor2.b, (arg_557_1.time_ - 0) / var_560_0)))
							else
								local var_560_1 = Mathf.Lerp(iter_560_1.color.r, 0.5, (arg_557_1.time_ - 0) / var_560_0)

								iter_560_1.color = Color.New(var_560_1, var_560_1, var_560_1)
							end
						end
					end
				end
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["10030"]) and arg_557_1.var_.actorSpriteComps10030 then
				for iter_560_2, iter_560_3 in pairs(arg_557_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_560_3 then
						iter_560_3.color = arg_557_1.isInRecall_ and (arg_557_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_557_1.var_.actorSpriteComps10030 = nil
			end

			local var_560_2 = 0
			local var_560_3 = 0.85

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_2 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, false)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_4 = arg_557_1:FormatText(arg_557_1:GetWordFromCfg(115311136).content)

				arg_557_1.text_.text = var_560_4

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_6 = 34 <= 0 and var_560_3 or var_560_3 * (utf8.len(var_560_4) / 34)

				if (34 <= 0 and var_560_3 or var_560_3 * (utf8.len(var_560_4) / 34)) > 0 and var_560_3 < var_560_6 then
					arg_557_1.talkMaxDuration = var_560_6

					if var_560_6 + var_560_2 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_6 + var_560_2
					end
				end

				arg_557_1.text_.text = var_560_4
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_7 = math.max(var_560_3, arg_557_1.talkMaxDuration)

			if var_560_2 <= arg_557_1.time_ and arg_557_1.time_ < var_560_2 + var_560_7 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_2) / var_560_7

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_2 + var_560_7 and arg_557_1.time_ < var_560_2 + var_560_7 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play115311137 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 115311137
		arg_561_1.duration_ = 9.57

		local var_561_0 = {
			ja = 7,
			ko = 8.066,
			zh = 9.566,
			en = 9.533
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play115311138(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(arg_561_1.actors_["10030"]) and arg_561_1.var_.actorSpriteComps10030 == nil then
				arg_561_1.var_.actorSpriteComps10030 = arg_561_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_564_0 = 0.2

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 and not isNil(arg_561_1.actors_["10030"]) then
				if arg_561_1.var_.actorSpriteComps10030 then
					for iter_564_0, iter_564_1 in pairs(arg_561_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_564_1 then
							if arg_561_1.isInRecall_ then
								iter_564_1.color = Color.New(Mathf.Lerp(iter_564_1.color.r, arg_561_1.hightColor1.r, (arg_561_1.time_ - 0) / var_564_0), Mathf.Lerp(iter_564_1.color.g, arg_561_1.hightColor1.g, (arg_561_1.time_ - 0) / var_564_0), (Mathf.Lerp(iter_564_1.color.b, arg_561_1.hightColor1.b, (arg_561_1.time_ - 0) / var_564_0)))
							else
								local var_564_1 = Mathf.Lerp(iter_564_1.color.r, 1, (arg_561_1.time_ - 0) / var_564_0)

								iter_564_1.color = Color.New(var_564_1, var_564_1, var_564_1)
							end
						end
					end
				end
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 and not isNil(arg_561_1.actors_["10030"]) and arg_561_1.var_.actorSpriteComps10030 then
				for iter_564_2, iter_564_3 in pairs(arg_561_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_564_3 then
						iter_564_3.color = arg_561_1.isInRecall_ and (arg_561_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_561_1.var_.actorSpriteComps10030 = nil
			end

			local var_564_2 = 0
			local var_564_3 = 1.05

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_2 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_4 = arg_561_1:GetWordFromCfg(115311137)
				local var_564_5 = arg_561_1:FormatText(var_564_4.content)

				arg_561_1.text_.text = var_564_5

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_7 = 42 <= 0 and var_564_3 or var_564_3 * (utf8.len(var_564_5) / 42)

				if (42 <= 0 and var_564_3 or var_564_3 * (utf8.len(var_564_5) / 42)) > 0 and var_564_3 < var_564_7 then
					arg_561_1.talkMaxDuration = var_564_7

					if var_564_7 + var_564_2 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_7 + var_564_2
					end
				end

				arg_561_1.text_.text = var_564_5
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311137", "story_v_out_115311.awb") ~= 0 then
					local var_564_8 = manager.audio:GetVoiceLength("story_v_out_115311", "115311137", "story_v_out_115311.awb") / 1000

					if var_564_8 + var_564_2 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_8 + var_564_2
					end

					if var_564_4.prefab_name ~= "" and arg_561_1.actors_[var_564_4.prefab_name] ~= nil then
						local var_564_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_4.prefab_name].transform, "story_v_out_115311", "115311137", "story_v_out_115311.awb")

						arg_561_1:RecordAudio("115311137", var_564_9)
						arg_561_1:RecordAudio("115311137", var_564_9)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_115311", "115311137", "story_v_out_115311.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_115311", "115311137", "story_v_out_115311.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_10 = math.max(var_564_3, arg_561_1.talkMaxDuration)

			if var_564_2 <= arg_561_1.time_ and arg_561_1.time_ < var_564_2 + var_564_10 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_2) / var_564_10

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_2 + var_564_10 and arg_561_1.time_ < var_564_2 + var_564_10 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play115311138 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 115311138
		arg_565_1.duration_ = 7.1

		local var_565_0 = {
			ja = 4.5,
			ko = 3.9,
			zh = 4.2,
			en = 7.1
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play115311139(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 0.525

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_1 = arg_565_1:GetWordFromCfg(115311138)
				local var_568_2 = arg_565_1:FormatText(var_568_1.content)

				arg_565_1.text_.text = var_568_2

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_4 = 21 <= 0 and var_568_0 or var_568_0 * (utf8.len(var_568_2) / 21)

				if (21 <= 0 and var_568_0 or var_568_0 * (utf8.len(var_568_2) / 21)) > 0 and var_568_0 < var_568_4 then
					arg_565_1.talkMaxDuration = var_568_4

					if var_568_4 + 0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_4 + 0
					end
				end

				arg_565_1.text_.text = var_568_2
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311138", "story_v_out_115311.awb") ~= 0 then
					local var_568_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311138", "story_v_out_115311.awb") / 1000

					if var_568_5 + 0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_5 + 0
					end

					if var_568_1.prefab_name ~= "" and arg_565_1.actors_[var_568_1.prefab_name] ~= nil then
						local var_568_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_1.prefab_name].transform, "story_v_out_115311", "115311138", "story_v_out_115311.awb")

						arg_565_1:RecordAudio("115311138", var_568_6)
						arg_565_1:RecordAudio("115311138", var_568_6)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_out_115311", "115311138", "story_v_out_115311.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_out_115311", "115311138", "story_v_out_115311.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_7 = math.max(var_568_0, arg_565_1.talkMaxDuration)

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_7 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - 0) / var_568_7

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= 0 + var_568_7 and arg_565_1.time_ < 0 + var_568_7 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play115311139 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 115311139
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play115311140(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				local var_572_0 = arg_569_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_572_0 then
					arg_569_1.var_.alphaOldValue10030 = var_572_0.alpha
					arg_569_1.var_.characterEffect10030 = var_572_0
				end

				arg_569_1.var_.alphaOldValue10030 = 1
			end

			local var_572_1 = 0.5

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_1 then
				if arg_569_1.var_.characterEffect10030 then
					arg_569_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_569_1.var_.alphaOldValue10030, 0, (arg_569_1.time_ - 0) / var_572_1)
				end
			end

			if arg_569_1.time_ >= 0 + var_572_1 and arg_569_1.time_ < 0 + var_572_1 + arg_572_0 and arg_569_1.var_.characterEffect10030 then
				arg_569_1.var_.characterEffect10030.alpha = 0
			end

			local var_572_2 = 0
			local var_572_3 = 1.45

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_2 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, false)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_4 = arg_569_1:FormatText(arg_569_1:GetWordFromCfg(115311139).content)

				arg_569_1.text_.text = var_572_4

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_6 = 58 <= 0 and var_572_3 or var_572_3 * (utf8.len(var_572_4) / 58)

				if (58 <= 0 and var_572_3 or var_572_3 * (utf8.len(var_572_4) / 58)) > 0 and var_572_3 < var_572_6 then
					arg_569_1.talkMaxDuration = var_572_6

					if var_572_6 + var_572_2 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_6 + var_572_2
					end
				end

				arg_569_1.text_.text = var_572_4
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_7 = math.max(var_572_3, arg_569_1.talkMaxDuration)

			if var_572_2 <= arg_569_1.time_ and arg_569_1.time_ < var_572_2 + var_572_7 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_2) / var_572_7

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_2 + var_572_7 and arg_569_1.time_ < var_572_2 + var_572_7 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play115311140 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 115311140
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play115311141(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = 0.3

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, false)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_1 = arg_573_1:FormatText(arg_573_1:GetWordFromCfg(115311140).content)

				arg_573_1.text_.text = var_576_1

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_3 = 12 <= 0 and var_576_0 or var_576_0 * (utf8.len(var_576_1) / 12)

				if (12 <= 0 and var_576_0 or var_576_0 * (utf8.len(var_576_1) / 12)) > 0 and var_576_0 < var_576_3 then
					arg_573_1.talkMaxDuration = var_576_3

					if var_576_3 + 0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_3 + 0
					end
				end

				arg_573_1.text_.text = var_576_1
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_4 = math.max(var_576_0, arg_573_1.talkMaxDuration)

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_4 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - 0) / var_576_4

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= 0 + var_576_4 and arg_573_1.time_ < 0 + var_576_4 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play115311141 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 115311141
		arg_577_1.duration_ = 5.83

		local var_577_0 = {
			ja = 5.833,
			ko = 5.3,
			zh = 5.666,
			en = 5.233
		}
		local var_577_1 = manager.audio:GetLocalizationFlag()

		if var_577_0[var_577_1] ~= nil then
			arg_577_1.duration_ = var_577_0[var_577_1]
		end

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play115311142(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_580_0 = 0.6

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_0 then
				local var_580_1, var_580_2 = math.modf((arg_577_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_580_2 * 0.13, var_580_2 * 0.13, var_580_2 * 0.13) + arg_577_1.var_.shakeOldPos
			end

			if arg_577_1.time_ >= 0 + var_580_0 and arg_577_1.time_ < 0 + var_580_0 + arg_580_0 then
				manager.ui.mainCamera.transform.localPosition = arg_577_1.var_.shakeOldPos
			end

			if 0.8 < arg_577_1.time_ and arg_577_1.time_ <= 0.8 + arg_580_0 then
				local var_580_3 = arg_577_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_580_3 then
					arg_577_1.var_.alphaOldValue10030 = var_580_3.alpha
					arg_577_1.var_.characterEffect10030 = var_580_3
				end

				arg_577_1.var_.alphaOldValue10030 = 0
			end

			local var_580_4 = 0.5

			if 0.8 <= arg_577_1.time_ and arg_577_1.time_ < 0.8 + var_580_4 then
				if arg_577_1.var_.characterEffect10030 then
					arg_577_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_577_1.var_.alphaOldValue10030, 1, (arg_577_1.time_ - 0.8) / var_580_4)
				end
			end

			if arg_577_1.time_ >= 0.8 + var_580_4 and arg_577_1.time_ < 0.8 + var_580_4 + arg_580_0 and arg_577_1.var_.characterEffect10030 then
				arg_577_1.var_.characterEffect10030.alpha = 1
			end

			local var_580_5 = arg_577_1.actors_["10030"]

			if 0.8 < arg_577_1.time_ and arg_577_1.time_ <= 0.8 + arg_580_0 and not isNil(var_580_5) and arg_577_1.var_.actorSpriteComps10030 == nil then
				arg_577_1.var_.actorSpriteComps10030 = var_580_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_580_6 = 0.2

			if 0.8 <= arg_577_1.time_ and arg_577_1.time_ < 0.8 + var_580_6 and not isNil(var_580_5) then
				if arg_577_1.var_.actorSpriteComps10030 then
					for iter_580_0, iter_580_1 in pairs(arg_577_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_580_1 then
							if arg_577_1.isInRecall_ then
								iter_580_1.color = Color.New(Mathf.Lerp(iter_580_1.color.r, arg_577_1.hightColor1.r, (arg_577_1.time_ - 0.8) / var_580_6), Mathf.Lerp(iter_580_1.color.g, arg_577_1.hightColor1.g, (arg_577_1.time_ - 0.8) / var_580_6), (Mathf.Lerp(iter_580_1.color.b, arg_577_1.hightColor1.b, (arg_577_1.time_ - 0.8) / var_580_6)))
							else
								local var_580_7 = Mathf.Lerp(iter_580_1.color.r, 1, (arg_577_1.time_ - 0.8) / var_580_6)

								iter_580_1.color = Color.New(var_580_7, var_580_7, var_580_7)
							end
						end
					end
				end
			end

			if arg_577_1.time_ >= 0.8 + var_580_6 and arg_577_1.time_ < 0.8 + var_580_6 + arg_580_0 and not isNil(var_580_5) and arg_577_1.var_.actorSpriteComps10030 then
				for iter_580_2, iter_580_3 in pairs(arg_577_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_580_3 then
						iter_580_3.color = arg_577_1.isInRecall_ and (arg_577_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_577_1.var_.actorSpriteComps10030 = nil
			end

			local var_580_8 = arg_577_1.actors_["10030"].transform

			if 0.8 < arg_577_1.time_ and arg_577_1.time_ <= 0.8 + arg_580_0 then
				arg_577_1.var_.moveOldPos10030 = var_580_8.localPosition
				var_580_8.localScale = Vector3.New(1, 1, 1)

				arg_577_1:CheckSpriteTmpPos("10030", 3)

				for iter_580_4 = 0, var_580_8.childCount - 1 do
					local var_580_9 = var_580_8:GetChild(iter_580_4)

					if var_580_9.name == "split_1" or not string.find(var_580_9.name, "split") then
						var_580_9.gameObject:SetActive(true)
					else
						var_580_9.gameObject:SetActive(false)
					end
				end
			end

			local var_580_10 = 0.001

			if 0.8 <= arg_577_1.time_ and arg_577_1.time_ < 0.8 + var_580_10 then
				var_580_8.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_577_1.time_ - 0.8) / var_580_10)
			end

			if arg_577_1.time_ >= 0.8 + var_580_10 and arg_577_1.time_ < 0.8 + var_580_10 + arg_580_0 then
				var_580_8.localPosition = Vector3.New(0, -390, 150)
			end

			local var_580_11 = 0

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_11 + arg_580_0 then
				arg_577_1.allBtn_.enabled = false
			end

			if arg_577_1.time_ >= var_580_11 + 0.8 and arg_577_1.time_ < var_580_11 + 0.8 + arg_580_0 then
				arg_577_1.allBtn_.enabled = true
			end

			if arg_577_1.frameCnt_ <= 1 then
				arg_577_1.dialog_:SetActive(false)
			end

			local var_580_12 = 0.8
			local var_580_13 = 0.325

			if 0.8 < arg_577_1.time_ and arg_577_1.time_ <= var_580_12 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0

				arg_577_1.dialog_:SetActive(true)

				arg_577_1.dialogCg_.alpha = 0

				local var_580_14 = LeanTween.value(arg_577_1.dialog_, 0, 1, 0.3)

				var_580_14:setOnUpdate(LuaHelper.FloatAction(function(arg_581_0)
					arg_577_1.dialogCg_.alpha = arg_581_0
				end))
				var_580_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_577_1.dialog_)
					var_580_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_577_1.duration_ = arg_577_1.duration_ + 0.3

				SetActive(arg_577_1.leftNameGo_, true)

				arg_577_1.leftNameTxt_.text = arg_577_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_15 = arg_577_1:GetWordFromCfg(115311141)
				local var_580_16 = arg_577_1:FormatText(var_580_15.content)

				arg_577_1.text_.text = var_580_16

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_18 = 13 <= 0 and var_580_13 or var_580_13 * (utf8.len(var_580_16) / 13)

				if (13 <= 0 and var_580_13 or var_580_13 * (utf8.len(var_580_16) / 13)) > 0 and var_580_13 < var_580_18 then
					arg_577_1.talkMaxDuration = var_580_18
					var_580_12 = var_580_12 + 0.3

					if var_580_18 + var_580_12 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_18 + var_580_12
					end
				end

				arg_577_1.text_.text = var_580_16
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311141", "story_v_out_115311.awb") ~= 0 then
					local var_580_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311141", "story_v_out_115311.awb") / 1000

					if var_580_19 + var_580_12 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_19 + var_580_12
					end

					if var_580_15.prefab_name ~= "" and arg_577_1.actors_[var_580_15.prefab_name] ~= nil then
						local var_580_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_577_1.actors_[var_580_15.prefab_name].transform, "story_v_out_115311", "115311141", "story_v_out_115311.awb")

						arg_577_1:RecordAudio("115311141", var_580_20)
						arg_577_1:RecordAudio("115311141", var_580_20)
					else
						arg_577_1:AudioAction("play", "voice", "story_v_out_115311", "115311141", "story_v_out_115311.awb")
					end

					arg_577_1:RecordHistoryTalkVoice("story_v_out_115311", "115311141", "story_v_out_115311.awb")
				end

				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_21 = var_580_12 + 0.3
			local var_580_22 = math.max(var_580_13, arg_577_1.talkMaxDuration)

			if var_580_12 + 0.3 <= arg_577_1.time_ and arg_577_1.time_ < var_580_21 + var_580_22 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_21) / var_580_22

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_21 + var_580_22 and arg_577_1.time_ < var_580_21 + var_580_22 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_577_1:InitPlayNodeList()
	end,
	Play115311142 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 115311142
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play115311143(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				local var_586_0 = arg_583_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_586_0 then
					arg_583_1.var_.alphaOldValue10030 = var_586_0.alpha
					arg_583_1.var_.characterEffect10030 = var_586_0
				end

				arg_583_1.var_.alphaOldValue10030 = 1
			end

			local var_586_1 = 0.5

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_1 then
				if arg_583_1.var_.characterEffect10030 then
					arg_583_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_583_1.var_.alphaOldValue10030, 0, (arg_583_1.time_ - 0) / var_586_1)
				end
			end

			if arg_583_1.time_ >= 0 + var_586_1 and arg_583_1.time_ < 0 + var_586_1 + arg_586_0 and arg_583_1.var_.characterEffect10030 then
				arg_583_1.var_.characterEffect10030.alpha = 0
			end

			local var_586_2 = 0
			local var_586_3 = 1.025

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_2 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, false)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_4 = arg_583_1:FormatText(arg_583_1:GetWordFromCfg(115311142).content)

				arg_583_1.text_.text = var_586_4

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_6 = 41 <= 0 and var_586_3 or var_586_3 * (utf8.len(var_586_4) / 41)

				if (41 <= 0 and var_586_3 or var_586_3 * (utf8.len(var_586_4) / 41)) > 0 and var_586_3 < var_586_6 then
					arg_583_1.talkMaxDuration = var_586_6

					if var_586_6 + var_586_2 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_6 + var_586_2
					end
				end

				arg_583_1.text_.text = var_586_4
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_7 = math.max(var_586_3, arg_583_1.talkMaxDuration)

			if var_586_2 <= arg_583_1.time_ and arg_583_1.time_ < var_586_2 + var_586_7 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_2) / var_586_7

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_2 + var_586_7 and arg_583_1.time_ < var_586_2 + var_586_7 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play115311143 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 115311143
		arg_587_1.duration_ = 4.33

		local var_587_0 = {
			ja = 4.333,
			ko = 3.1,
			zh = 2.633,
			en = 3.066
		}
		local var_587_1 = manager.audio:GetLocalizationFlag()

		if var_587_0[var_587_1] ~= nil then
			arg_587_1.duration_ = var_587_0[var_587_1]
		end

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play115311144(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if arg_587_1.actors_["1041_1"] == nil then
				local var_590_0 = Object.Instantiate(arg_587_1.imageGo_, arg_587_1.canvasGo_.transform)

				var_590_0.transform:SetSiblingIndex(1)

				var_590_0.name = "1041_1"

				local var_590_1 = var_590_0:GetComponent(typeof(Image))

				var_590_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1041_1")

				var_590_1:SetNativeSize()

				var_590_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_587_1.actors_["1041_1"] = var_590_0
			end

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				local var_590_2 = arg_587_1.actors_["1041_1"]:GetComponent("Image")

				if var_590_2 then
					arg_587_1.var_.alphaMatValue1041_1 = var_590_2
					arg_587_1.var_.alphaOldValue1041_1 = var_590_2.color.a
				end

				arg_587_1.var_.alphaOldValue1041_1 = 0
			end

			local var_590_3 = 0.5

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_3 then
				if arg_587_1.var_.alphaMatValue1041_1 then
					arg_587_1.var_.alphaMatValue1041_1.color.a = Mathf.Lerp(arg_587_1.var_.alphaOldValue1041_1, 1, (arg_587_1.time_ - 0) / var_590_3)
					arg_587_1.var_.alphaMatValue1041_1.color = arg_587_1.var_.alphaMatValue1041_1.color
				end
			end

			if arg_587_1.time_ >= 0 + var_590_3 and arg_587_1.time_ < 0 + var_590_3 + arg_590_0 and arg_587_1.var_.alphaMatValue1041_1 then
				arg_587_1.var_.alphaMatValue1041_1.color.a = 1
				arg_587_1.var_.alphaMatValue1041_1.color = arg_587_1.var_.alphaMatValue1041_1.color
			end

			local var_590_4 = arg_587_1.actors_["1041_1"]

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 and not isNil(var_590_4) then
				local var_590_5 = var_590_4:GetComponent("Image")

				if var_590_5 then
					arg_587_1.var_.highlightMatValue1041_1 = var_590_5
				end
			end

			local var_590_6 = 0.2

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_6 and not isNil(var_590_4) then
				if arg_587_1.var_.highlightMatValue1041_1 then
					local var_590_7 = Mathf.Lerp(0.5, 1, (arg_587_1.time_ - 0) / var_590_6)

					arg_587_1.var_.highlightMatValue1041_1.color.r = var_590_7
					arg_587_1.var_.highlightMatValue1041_1.color.g = var_590_7
					arg_587_1.var_.highlightMatValue1041_1.color.b = var_590_7
					arg_587_1.var_.highlightMatValue1041_1.color = arg_587_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_587_1.time_ >= 0 + var_590_6 and arg_587_1.time_ < 0 + var_590_6 + arg_590_0 and not isNil(var_590_4) and arg_587_1.var_.highlightMatValue1041_1 then
				var_590_4.transform:SetSiblingIndex(1)

				arg_587_1.var_.highlightMatValue1041_1.color.r = 1
				arg_587_1.var_.highlightMatValue1041_1.color.g = 1
				arg_587_1.var_.highlightMatValue1041_1.color.b = 1
				arg_587_1.var_.highlightMatValue1041_1.color = arg_587_1.var_.highlightMatValue1041_1.color
			end

			local var_590_8 = arg_587_1.actors_["1041_1"].transform

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.var_.moveOldPos1041_1 = var_590_8.localPosition
				var_590_8.localScale = Vector3.New(1, 1, 1)

				arg_587_1:CheckSpriteTmpPos("1041_1", 4)
			end

			local var_590_9 = 0.001

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_9 then
				var_590_8.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos1041_1, Vector3.New(440, -310, -370), (arg_587_1.time_ - 0) / var_590_9)
			end

			if arg_587_1.time_ >= 0 + var_590_9 and arg_587_1.time_ < 0 + var_590_9 + arg_590_0 then
				var_590_8.localPosition = Vector3.New(440, -310, -370)
			end

			local var_590_10 = 0
			local var_590_11 = 0.3

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_10 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				arg_587_1.leftNameTxt_.text = arg_587_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_12 = arg_587_1:GetWordFromCfg(115311143)
				local var_590_13 = arg_587_1:FormatText(var_590_12.content)

				arg_587_1.text_.text = var_590_13

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_15 = 12 <= 0 and var_590_11 or var_590_11 * (utf8.len(var_590_13) / 12)

				if (12 <= 0 and var_590_11 or var_590_11 * (utf8.len(var_590_13) / 12)) > 0 and var_590_11 < var_590_15 then
					arg_587_1.talkMaxDuration = var_590_15

					if var_590_15 + var_590_10 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_15 + var_590_10
					end
				end

				arg_587_1.text_.text = var_590_13
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311143", "story_v_out_115311.awb") ~= 0 then
					local var_590_16 = manager.audio:GetVoiceLength("story_v_out_115311", "115311143", "story_v_out_115311.awb") / 1000

					if var_590_16 + var_590_10 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_16 + var_590_10
					end

					if var_590_12.prefab_name ~= "" and arg_587_1.actors_[var_590_12.prefab_name] ~= nil then
						local var_590_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_587_1.actors_[var_590_12.prefab_name].transform, "story_v_out_115311", "115311143", "story_v_out_115311.awb")

						arg_587_1:RecordAudio("115311143", var_590_17)
						arg_587_1:RecordAudio("115311143", var_590_17)
					else
						arg_587_1:AudioAction("play", "voice", "story_v_out_115311", "115311143", "story_v_out_115311.awb")
					end

					arg_587_1:RecordHistoryTalkVoice("story_v_out_115311", "115311143", "story_v_out_115311.awb")
				end

				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_18 = math.max(var_590_11, arg_587_1.talkMaxDuration)

			if var_590_10 <= arg_587_1.time_ and arg_587_1.time_ < var_590_10 + var_590_18 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_10) / var_590_18

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_10 + var_590_18 and arg_587_1.time_ < var_590_10 + var_590_18 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_587_1:InitPlayNodeList()
	end,
	Play115311144 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 115311144
		arg_591_1.duration_ = 13.97

		local var_591_0 = {
			ja = 13.966,
			ko = 7.733,
			zh = 7.333,
			en = 7.1
		}
		local var_591_1 = manager.audio:GetLocalizationFlag()

		if var_591_0[var_591_1] ~= nil then
			arg_591_1.duration_ = var_591_0[var_591_1]
		end

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play115311145(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				local var_594_0 = arg_591_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_594_0 then
					arg_591_1.var_.alphaOldValue10030 = var_594_0.alpha
					arg_591_1.var_.characterEffect10030 = var_594_0
				end

				arg_591_1.var_.alphaOldValue10030 = 0
			end

			local var_594_1 = 0.5

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_1 then
				if arg_591_1.var_.characterEffect10030 then
					arg_591_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_591_1.var_.alphaOldValue10030, 1, (arg_591_1.time_ - 0) / var_594_1)
				end
			end

			if arg_591_1.time_ >= 0 + var_594_1 and arg_591_1.time_ < 0 + var_594_1 + arg_594_0 and arg_591_1.var_.characterEffect10030 then
				arg_591_1.var_.characterEffect10030.alpha = 1
			end

			local var_594_2 = arg_591_1.actors_["10030"]

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 and not isNil(var_594_2) and arg_591_1.var_.actorSpriteComps10030 == nil then
				arg_591_1.var_.actorSpriteComps10030 = var_594_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_594_3 = 0.2

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_3 and not isNil(var_594_2) then
				if arg_591_1.var_.actorSpriteComps10030 then
					for iter_594_0, iter_594_1 in pairs(arg_591_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_594_1 then
							if arg_591_1.isInRecall_ then
								iter_594_1.color = Color.New(Mathf.Lerp(iter_594_1.color.r, arg_591_1.hightColor1.r, (arg_591_1.time_ - 0) / var_594_3), Mathf.Lerp(iter_594_1.color.g, arg_591_1.hightColor1.g, (arg_591_1.time_ - 0) / var_594_3), (Mathf.Lerp(iter_594_1.color.b, arg_591_1.hightColor1.b, (arg_591_1.time_ - 0) / var_594_3)))
							else
								local var_594_4 = Mathf.Lerp(iter_594_1.color.r, 1, (arg_591_1.time_ - 0) / var_594_3)

								iter_594_1.color = Color.New(var_594_4, var_594_4, var_594_4)
							end
						end
					end
				end
			end

			if arg_591_1.time_ >= 0 + var_594_3 and arg_591_1.time_ < 0 + var_594_3 + arg_594_0 and not isNil(var_594_2) and arg_591_1.var_.actorSpriteComps10030 then
				for iter_594_2, iter_594_3 in pairs(arg_591_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_594_3 then
						iter_594_3.color = arg_591_1.isInRecall_ and (arg_591_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_591_1.var_.actorSpriteComps10030 = nil
			end

			local var_594_5 = arg_591_1.actors_["10030"].transform

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.var_.moveOldPos10030 = var_594_5.localPosition
				var_594_5.localScale = Vector3.New(1, 1, 1)

				arg_591_1:CheckSpriteTmpPos("10030", 2)

				for iter_594_4 = 0, var_594_5.childCount - 1 do
					local var_594_6 = var_594_5:GetChild(iter_594_4)

					if var_594_6.name == "split_2" or not string.find(var_594_6.name, "split") then
						var_594_6.gameObject:SetActive(true)
					else
						var_594_6.gameObject:SetActive(false)
					end
				end
			end

			local var_594_7 = 0.001

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_7 then
				var_594_5.localPosition = Vector3.Lerp(arg_591_1.var_.moveOldPos10030, Vector3.New(-390, -390, 150), (arg_591_1.time_ - 0) / var_594_7)
			end

			if arg_591_1.time_ >= 0 + var_594_7 and arg_591_1.time_ < 0 + var_594_7 + arg_594_0 then
				var_594_5.localPosition = Vector3.New(-390, -390, 150)
			end

			local var_594_8 = arg_591_1.actors_["1041_1"]

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 and not isNil(var_594_8) then
				local var_594_9 = var_594_8:GetComponent("Image")

				if var_594_9 then
					arg_591_1.var_.highlightMatValue1041_1 = var_594_9
				end
			end

			local var_594_10 = 0.2

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_10 and not isNil(var_594_8) then
				if arg_591_1.var_.highlightMatValue1041_1 then
					local var_594_11 = Mathf.Lerp(1, 0.5, (arg_591_1.time_ - 0) / var_594_10)

					arg_591_1.var_.highlightMatValue1041_1.color.r = var_594_11
					arg_591_1.var_.highlightMatValue1041_1.color.g = var_594_11
					arg_591_1.var_.highlightMatValue1041_1.color.b = var_594_11
					arg_591_1.var_.highlightMatValue1041_1.color = arg_591_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_591_1.time_ >= 0 + var_594_10 and arg_591_1.time_ < 0 + var_594_10 + arg_594_0 and not isNil(var_594_8) and arg_591_1.var_.highlightMatValue1041_1 then
				arg_591_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_591_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_591_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_591_1.var_.highlightMatValue1041_1.color = arg_591_1.var_.highlightMatValue1041_1.color
			end

			local var_594_12 = 0
			local var_594_13 = 0.625

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_12 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_14 = arg_591_1:GetWordFromCfg(115311144)
				local var_594_15 = arg_591_1:FormatText(var_594_14.content)

				arg_591_1.text_.text = var_594_15

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_17 = 25 <= 0 and var_594_13 or var_594_13 * (utf8.len(var_594_15) / 25)

				if (25 <= 0 and var_594_13 or var_594_13 * (utf8.len(var_594_15) / 25)) > 0 and var_594_13 < var_594_17 then
					arg_591_1.talkMaxDuration = var_594_17

					if var_594_17 + var_594_12 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_17 + var_594_12
					end
				end

				arg_591_1.text_.text = var_594_15
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311144", "story_v_out_115311.awb") ~= 0 then
					local var_594_18 = manager.audio:GetVoiceLength("story_v_out_115311", "115311144", "story_v_out_115311.awb") / 1000

					if var_594_18 + var_594_12 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_18 + var_594_12
					end

					if var_594_14.prefab_name ~= "" and arg_591_1.actors_[var_594_14.prefab_name] ~= nil then
						local var_594_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_14.prefab_name].transform, "story_v_out_115311", "115311144", "story_v_out_115311.awb")

						arg_591_1:RecordAudio("115311144", var_594_19)
						arg_591_1:RecordAudio("115311144", var_594_19)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_out_115311", "115311144", "story_v_out_115311.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_out_115311", "115311144", "story_v_out_115311.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_20 = math.max(var_594_13, arg_591_1.talkMaxDuration)

			if var_594_12 <= arg_591_1.time_ and arg_591_1.time_ < var_594_12 + var_594_20 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_12) / var_594_20

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_12 + var_594_20 and arg_591_1.time_ < var_594_12 + var_594_20 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {
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

		arg_591_1:InitPlayNodeList()
	end,
	Play115311145 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 115311145
		arg_595_1.duration_ = 4.33

		local var_595_0 = {
			ja = 3.633,
			ko = 4.333,
			zh = 2.833,
			en = 3.266
		}
		local var_595_1 = manager.audio:GetLocalizationFlag()

		if var_595_0[var_595_1] ~= nil then
			arg_595_1.duration_ = var_595_0[var_595_1]
		end

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play115311146(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 and not isNil(arg_595_1.actors_["10030"]) and arg_595_1.var_.actorSpriteComps10030 == nil then
				arg_595_1.var_.actorSpriteComps10030 = arg_595_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_598_0 = 0.2

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_0 and not isNil(arg_595_1.actors_["10030"]) then
				if arg_595_1.var_.actorSpriteComps10030 then
					for iter_598_0, iter_598_1 in pairs(arg_595_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_598_1 then
							if arg_595_1.isInRecall_ then
								iter_598_1.color = Color.New(Mathf.Lerp(iter_598_1.color.r, arg_595_1.hightColor2.r, (arg_595_1.time_ - 0) / var_598_0), Mathf.Lerp(iter_598_1.color.g, arg_595_1.hightColor2.g, (arg_595_1.time_ - 0) / var_598_0), (Mathf.Lerp(iter_598_1.color.b, arg_595_1.hightColor2.b, (arg_595_1.time_ - 0) / var_598_0)))
							else
								local var_598_1 = Mathf.Lerp(iter_598_1.color.r, 0.5, (arg_595_1.time_ - 0) / var_598_0)

								iter_598_1.color = Color.New(var_598_1, var_598_1, var_598_1)
							end
						end
					end
				end
			end

			if arg_595_1.time_ >= 0 + var_598_0 and arg_595_1.time_ < 0 + var_598_0 + arg_598_0 and not isNil(arg_595_1.actors_["10030"]) and arg_595_1.var_.actorSpriteComps10030 then
				for iter_598_2, iter_598_3 in pairs(arg_595_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_598_3 then
						iter_598_3.color = arg_595_1.isInRecall_ and (arg_595_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_595_1.var_.actorSpriteComps10030 = nil
			end

			local var_598_2 = arg_595_1.actors_["1041_1"]

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 and not isNil(var_598_2) then
				local var_598_3 = var_598_2:GetComponent("Image")

				if var_598_3 then
					arg_595_1.var_.highlightMatValue1041_1 = var_598_3
				end
			end

			local var_598_4 = 0.2

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_4 and not isNil(var_598_2) then
				if arg_595_1.var_.highlightMatValue1041_1 then
					local var_598_5 = Mathf.Lerp(0.5, 1, (arg_595_1.time_ - 0) / var_598_4)

					arg_595_1.var_.highlightMatValue1041_1.color.r = var_598_5
					arg_595_1.var_.highlightMatValue1041_1.color.g = var_598_5
					arg_595_1.var_.highlightMatValue1041_1.color.b = var_598_5
					arg_595_1.var_.highlightMatValue1041_1.color = arg_595_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_595_1.time_ >= 0 + var_598_4 and arg_595_1.time_ < 0 + var_598_4 + arg_598_0 and not isNil(var_598_2) and arg_595_1.var_.highlightMatValue1041_1 then
				var_598_2.transform:SetSiblingIndex(1)

				arg_595_1.var_.highlightMatValue1041_1.color.r = 1
				arg_595_1.var_.highlightMatValue1041_1.color.g = 1
				arg_595_1.var_.highlightMatValue1041_1.color.b = 1
				arg_595_1.var_.highlightMatValue1041_1.color = arg_595_1.var_.highlightMatValue1041_1.color
			end

			local var_598_6 = 0
			local var_598_7 = 0.35

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_6 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_8 = arg_595_1:GetWordFromCfg(115311145)
				local var_598_9 = arg_595_1:FormatText(var_598_8.content)

				arg_595_1.text_.text = var_598_9

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_11 = 14 <= 0 and var_598_7 or var_598_7 * (utf8.len(var_598_9) / 14)

				if (14 <= 0 and var_598_7 or var_598_7 * (utf8.len(var_598_9) / 14)) > 0 and var_598_7 < var_598_11 then
					arg_595_1.talkMaxDuration = var_598_11

					if var_598_11 + var_598_6 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_11 + var_598_6
					end
				end

				arg_595_1.text_.text = var_598_9
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311145", "story_v_out_115311.awb") ~= 0 then
					local var_598_12 = manager.audio:GetVoiceLength("story_v_out_115311", "115311145", "story_v_out_115311.awb") / 1000

					if var_598_12 + var_598_6 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_12 + var_598_6
					end

					if var_598_8.prefab_name ~= "" and arg_595_1.actors_[var_598_8.prefab_name] ~= nil then
						local var_598_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_8.prefab_name].transform, "story_v_out_115311", "115311145", "story_v_out_115311.awb")

						arg_595_1:RecordAudio("115311145", var_598_13)
						arg_595_1:RecordAudio("115311145", var_598_13)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_out_115311", "115311145", "story_v_out_115311.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_out_115311", "115311145", "story_v_out_115311.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_14 = math.max(var_598_7, arg_595_1.talkMaxDuration)

			if var_598_6 <= arg_595_1.time_ and arg_595_1.time_ < var_598_6 + var_598_14 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_6) / var_598_14

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_6 + var_598_14 and arg_595_1.time_ < var_598_6 + var_598_14 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play115311146 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 115311146
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play115311147(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.var_.moveOldPos10030 = arg_599_1.actors_["10030"].transform.localPosition
				arg_599_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_599_1:CheckSpriteTmpPos("10030", 2)

				for iter_602_0 = 0, arg_599_1.actors_["10030"].transform.childCount - 1 do
					local var_602_0 = arg_599_1.actors_["10030"].transform:GetChild(iter_602_0)

					if var_602_0.name == "split_3" or not string.find(var_602_0.name, "split") then
						var_602_0.gameObject:SetActive(true)
					else
						var_602_0.gameObject:SetActive(false)
					end
				end
			end

			local var_602_1 = 0.001

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_1 then
				arg_599_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_599_1.var_.moveOldPos10030, Vector3.New(-390, -390, 150), (arg_599_1.time_ - 0) / var_602_1)
			end

			if arg_599_1.time_ >= 0 + var_602_1 and arg_599_1.time_ < 0 + var_602_1 + arg_602_0 then
				arg_599_1.actors_["10030"].transform.localPosition = Vector3.New(-390, -390, 150)
			end

			local var_602_2 = arg_599_1.actors_["1041_1"]

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 and not isNil(var_602_2) then
				local var_602_3 = var_602_2:GetComponent("Image")

				if var_602_3 then
					arg_599_1.var_.highlightMatValue1041_1 = var_602_3
				end
			end

			local var_602_4 = 0.2

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_4 and not isNil(var_602_2) then
				if arg_599_1.var_.highlightMatValue1041_1 then
					local var_602_5 = Mathf.Lerp(1, 0.5, (arg_599_1.time_ - 0) / var_602_4)

					arg_599_1.var_.highlightMatValue1041_1.color.r = var_602_5
					arg_599_1.var_.highlightMatValue1041_1.color.g = var_602_5
					arg_599_1.var_.highlightMatValue1041_1.color.b = var_602_5
					arg_599_1.var_.highlightMatValue1041_1.color = arg_599_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_599_1.time_ >= 0 + var_602_4 and arg_599_1.time_ < 0 + var_602_4 + arg_602_0 and not isNil(var_602_2) and arg_599_1.var_.highlightMatValue1041_1 then
				arg_599_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_599_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_599_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_599_1.var_.highlightMatValue1041_1.color = arg_599_1.var_.highlightMatValue1041_1.color
			end

			local var_602_6 = 0
			local var_602_7 = 0.575

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_6 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, false)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_8 = arg_599_1:FormatText(arg_599_1:GetWordFromCfg(115311146).content)

				arg_599_1.text_.text = var_602_8

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_10 = 23 <= 0 and var_602_7 or var_602_7 * (utf8.len(var_602_8) / 23)

				if (23 <= 0 and var_602_7 or var_602_7 * (utf8.len(var_602_8) / 23)) > 0 and var_602_7 < var_602_10 then
					arg_599_1.talkMaxDuration = var_602_10

					if var_602_10 + var_602_6 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_10 + var_602_6
					end
				end

				arg_599_1.text_.text = var_602_8
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_11 = math.max(var_602_7, arg_599_1.talkMaxDuration)

			if var_602_6 <= arg_599_1.time_ and arg_599_1.time_ < var_602_6 + var_602_11 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_6) / var_602_11

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_6 + var_602_11 and arg_599_1.time_ < var_602_6 + var_602_11 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {
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

		arg_599_1:InitPlayNodeList()
	end,
	Play115311147 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 115311147
		arg_603_1.duration_ = 10.23

		local var_603_0 = {
			ja = 10.233,
			ko = 6.733,
			zh = 5.5,
			en = 6.3
		}
		local var_603_1 = manager.audio:GetLocalizationFlag()

		if var_603_0[var_603_1] ~= nil then
			arg_603_1.duration_ = var_603_0[var_603_1]
		end

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play115311148(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 and not isNil(arg_603_1.actors_["1041_1"]) then
				local var_606_0 = arg_603_1.actors_["1041_1"]:GetComponent("Image")

				if var_606_0 then
					arg_603_1.var_.highlightMatValue1041_1 = var_606_0
				end
			end

			local var_606_1 = 0.2

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_1 and not isNil(arg_603_1.actors_["1041_1"]) then
				if arg_603_1.var_.highlightMatValue1041_1 then
					local var_606_2 = Mathf.Lerp(0.5, 1, (arg_603_1.time_ - 0) / var_606_1)

					arg_603_1.var_.highlightMatValue1041_1.color.r = var_606_2
					arg_603_1.var_.highlightMatValue1041_1.color.g = var_606_2
					arg_603_1.var_.highlightMatValue1041_1.color.b = var_606_2
					arg_603_1.var_.highlightMatValue1041_1.color = arg_603_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_603_1.time_ >= 0 + var_606_1 and arg_603_1.time_ < 0 + var_606_1 + arg_606_0 and not isNil(arg_603_1.actors_["1041_1"]) and arg_603_1.var_.highlightMatValue1041_1 then
				arg_603_1.actors_["1041_1"].transform:SetSiblingIndex(1)

				arg_603_1.var_.highlightMatValue1041_1.color.r = 1
				arg_603_1.var_.highlightMatValue1041_1.color.g = 1
				arg_603_1.var_.highlightMatValue1041_1.color.b = 1
				arg_603_1.var_.highlightMatValue1041_1.color = arg_603_1.var_.highlightMatValue1041_1.color
			end

			local var_606_3 = 0
			local var_606_4 = 0.725

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_3 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				arg_603_1.leftNameTxt_.text = arg_603_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_5 = arg_603_1:GetWordFromCfg(115311147)
				local var_606_6 = arg_603_1:FormatText(var_606_5.content)

				arg_603_1.text_.text = var_606_6

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_8 = 29 <= 0 and var_606_4 or var_606_4 * (utf8.len(var_606_6) / 29)

				if (29 <= 0 and var_606_4 or var_606_4 * (utf8.len(var_606_6) / 29)) > 0 and var_606_4 < var_606_8 then
					arg_603_1.talkMaxDuration = var_606_8

					if var_606_8 + var_606_3 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_8 + var_606_3
					end
				end

				arg_603_1.text_.text = var_606_6
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311147", "story_v_out_115311.awb") ~= 0 then
					local var_606_9 = manager.audio:GetVoiceLength("story_v_out_115311", "115311147", "story_v_out_115311.awb") / 1000

					if var_606_9 + var_606_3 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_9 + var_606_3
					end

					if var_606_5.prefab_name ~= "" and arg_603_1.actors_[var_606_5.prefab_name] ~= nil then
						local var_606_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_5.prefab_name].transform, "story_v_out_115311", "115311147", "story_v_out_115311.awb")

						arg_603_1:RecordAudio("115311147", var_606_10)
						arg_603_1:RecordAudio("115311147", var_606_10)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_out_115311", "115311147", "story_v_out_115311.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_out_115311", "115311147", "story_v_out_115311.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_11 = math.max(var_606_4, arg_603_1.talkMaxDuration)

			if var_606_3 <= arg_603_1.time_ and arg_603_1.time_ < var_606_3 + var_606_11 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_3) / var_606_11

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_3 + var_606_11 and arg_603_1.time_ < var_606_3 + var_606_11 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play115311148 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 115311148
		arg_607_1.duration_ = 12.87

		local var_607_0 = {
			ja = 12.866,
			ko = 9.666,
			zh = 8.5,
			en = 11.3
		}
		local var_607_1 = manager.audio:GetLocalizationFlag()

		if var_607_0[var_607_1] ~= nil then
			arg_607_1.duration_ = var_607_0[var_607_1]
		end

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play115311149(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 1

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_1 = arg_607_1:GetWordFromCfg(115311148)
				local var_610_2 = arg_607_1:FormatText(var_610_1.content)

				arg_607_1.text_.text = var_610_2

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_4 = 41 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_2) / 41)

				if (41 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_2) / 41)) > 0 and var_610_0 < var_610_4 then
					arg_607_1.talkMaxDuration = var_610_4

					if var_610_4 + 0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_4 + 0
					end
				end

				arg_607_1.text_.text = var_610_2
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311148", "story_v_out_115311.awb") ~= 0 then
					local var_610_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311148", "story_v_out_115311.awb") / 1000

					if var_610_5 + 0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_5 + 0
					end

					if var_610_1.prefab_name ~= "" and arg_607_1.actors_[var_610_1.prefab_name] ~= nil then
						local var_610_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_1.prefab_name].transform, "story_v_out_115311", "115311148", "story_v_out_115311.awb")

						arg_607_1:RecordAudio("115311148", var_610_6)
						arg_607_1:RecordAudio("115311148", var_610_6)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_out_115311", "115311148", "story_v_out_115311.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_out_115311", "115311148", "story_v_out_115311.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_7 = math.max(var_610_0, arg_607_1.talkMaxDuration)

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_7 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - 0) / var_610_7

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= 0 + var_610_7 and arg_607_1.time_ < 0 + var_610_7 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play115311149 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 115311149
		arg_611_1.duration_ = 1.6

		local var_611_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 1.6,
			en = 1.166
		}
		local var_611_1 = manager.audio:GetLocalizationFlag()

		if var_611_0[var_611_1] ~= nil then
			arg_611_1.duration_ = var_611_0[var_611_1]
		end

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play115311150(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(arg_611_1.actors_["1041_1"]) then
				local var_614_0 = arg_611_1.actors_["1041_1"]:GetComponent("Image")

				if var_614_0 then
					arg_611_1.var_.highlightMatValue1041_1 = var_614_0
				end
			end

			local var_614_1 = 0.2

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_1 and not isNil(arg_611_1.actors_["1041_1"]) then
				if arg_611_1.var_.highlightMatValue1041_1 then
					local var_614_2 = Mathf.Lerp(1, 0.5, (arg_611_1.time_ - 0) / var_614_1)

					arg_611_1.var_.highlightMatValue1041_1.color.r = var_614_2
					arg_611_1.var_.highlightMatValue1041_1.color.g = var_614_2
					arg_611_1.var_.highlightMatValue1041_1.color.b = var_614_2
					arg_611_1.var_.highlightMatValue1041_1.color = arg_611_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_611_1.time_ >= 0 + var_614_1 and arg_611_1.time_ < 0 + var_614_1 + arg_614_0 and not isNil(arg_611_1.actors_["1041_1"]) and arg_611_1.var_.highlightMatValue1041_1 then
				arg_611_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_611_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_611_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_611_1.var_.highlightMatValue1041_1.color = arg_611_1.var_.highlightMatValue1041_1.color
			end

			local var_614_3 = arg_611_1.actors_["10030"]

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(var_614_3) and arg_611_1.var_.actorSpriteComps10030 == nil then
				arg_611_1.var_.actorSpriteComps10030 = var_614_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_614_4 = 0.2

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_4 and not isNil(var_614_3) then
				if arg_611_1.var_.actorSpriteComps10030 then
					for iter_614_0, iter_614_1 in pairs(arg_611_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_614_1 then
							if arg_611_1.isInRecall_ then
								iter_614_1.color = Color.New(Mathf.Lerp(iter_614_1.color.r, arg_611_1.hightColor1.r, (arg_611_1.time_ - 0) / var_614_4), Mathf.Lerp(iter_614_1.color.g, arg_611_1.hightColor1.g, (arg_611_1.time_ - 0) / var_614_4), (Mathf.Lerp(iter_614_1.color.b, arg_611_1.hightColor1.b, (arg_611_1.time_ - 0) / var_614_4)))
							else
								local var_614_5 = Mathf.Lerp(iter_614_1.color.r, 1, (arg_611_1.time_ - 0) / var_614_4)

								iter_614_1.color = Color.New(var_614_5, var_614_5, var_614_5)
							end
						end
					end
				end
			end

			if arg_611_1.time_ >= 0 + var_614_4 and arg_611_1.time_ < 0 + var_614_4 + arg_614_0 and not isNil(var_614_3) and arg_611_1.var_.actorSpriteComps10030 then
				for iter_614_2, iter_614_3 in pairs(arg_611_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_614_3 then
						iter_614_3.color = arg_611_1.isInRecall_ and (arg_611_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_611_1.var_.actorSpriteComps10030 = nil
			end

			local var_614_6 = 0
			local var_614_7 = 0.1

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_6 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_8 = arg_611_1:GetWordFromCfg(115311149)
				local var_614_9 = arg_611_1:FormatText(var_614_8.content)

				arg_611_1.text_.text = var_614_9

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_11 = 4 <= 0 and var_614_7 or var_614_7 * (utf8.len(var_614_9) / 4)

				if (4 <= 0 and var_614_7 or var_614_7 * (utf8.len(var_614_9) / 4)) > 0 and var_614_7 < var_614_11 then
					arg_611_1.talkMaxDuration = var_614_11

					if var_614_11 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_11 + var_614_6
					end
				end

				arg_611_1.text_.text = var_614_9
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311149", "story_v_out_115311.awb") ~= 0 then
					local var_614_12 = manager.audio:GetVoiceLength("story_v_out_115311", "115311149", "story_v_out_115311.awb") / 1000

					if var_614_12 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_12 + var_614_6
					end

					if var_614_8.prefab_name ~= "" and arg_611_1.actors_[var_614_8.prefab_name] ~= nil then
						local var_614_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_8.prefab_name].transform, "story_v_out_115311", "115311149", "story_v_out_115311.awb")

						arg_611_1:RecordAudio("115311149", var_614_13)
						arg_611_1:RecordAudio("115311149", var_614_13)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_out_115311", "115311149", "story_v_out_115311.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_out_115311", "115311149", "story_v_out_115311.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_14 = math.max(var_614_7, arg_611_1.talkMaxDuration)

			if var_614_6 <= arg_611_1.time_ and arg_611_1.time_ < var_614_6 + var_614_14 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_6) / var_614_14

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_6 + var_614_14 and arg_611_1.time_ < var_614_6 + var_614_14 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play115311150 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 115311150
		arg_615_1.duration_ = 9

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play115311151(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			if arg_615_1.bgs_.F01a == nil then
				local var_618_0 = Object.Instantiate(arg_615_1.paintGo_)

				var_618_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01a")
				var_618_0.name = "F01a"
				var_618_0.transform.parent = arg_615_1.stage_.transform
				var_618_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_615_1.bgs_.F01a = var_618_0
			end

			if 2 < arg_615_1.time_ and arg_615_1.time_ <= 2 + arg_618_0 then
				local var_618_1 = arg_615_1.bgs_.F01a

				arg_615_1.bgs_.F01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_618_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_618_2 = var_618_1:GetComponent("SpriteRenderer")

				if var_618_2 and var_618_2.sprite then
					local var_618_3 = 2 * (var_618_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_618_1.transform.localScale = Vector3.New(var_618_3 / var_618_2.sprite.bounds.size.y < var_618_3 * manager.ui.mainCameraCom_.aspect / var_618_2.sprite.bounds.size.x and var_618_3 * manager.ui.mainCameraCom_.aspect / var_618_2.sprite.bounds.size.x or var_618_3 / var_618_2.sprite.bounds.size.y, var_618_3 / var_618_2.sprite.bounds.size.y < var_618_3 * manager.ui.mainCameraCom_.aspect / var_618_2.sprite.bounds.size.x and var_618_3 * manager.ui.mainCameraCom_.aspect / var_618_2.sprite.bounds.size.x or var_618_3 / var_618_2.sprite.bounds.size.y, 0)
				end

				for iter_618_0, iter_618_1 in pairs(arg_615_1.bgs_) do
					if iter_618_0 ~= "F01a" then
						iter_618_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_618_4 = 0

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_4 + arg_618_0 then
				arg_615_1.mask_.enabled = true
				arg_615_1.mask_.raycastTarget = true

				arg_615_1:SetGaussion(false)
			end

			local var_618_5 = 2

			if var_618_4 <= arg_615_1.time_ and arg_615_1.time_ < var_618_4 + var_618_5 then
				local var_618_6 = Color.New(0, 0, 0)

				var_618_6.a = Mathf.Lerp(0, 1, (arg_615_1.time_ - var_618_4) / var_618_5)
				arg_615_1.mask_.color = var_618_6
			end

			if arg_615_1.time_ >= var_618_4 + var_618_5 and arg_615_1.time_ < var_618_4 + var_618_5 + arg_618_0 then
				local var_618_7 = Color.New(0, 0, 0)

				var_618_7.a = 1
				arg_615_1.mask_.color = var_618_7
			end

			local var_618_8 = 2

			if 2 < arg_615_1.time_ and arg_615_1.time_ <= var_618_8 + arg_618_0 then
				arg_615_1.mask_.enabled = true
				arg_615_1.mask_.raycastTarget = true

				arg_615_1:SetGaussion(false)
			end

			local var_618_9 = 2

			if var_618_8 <= arg_615_1.time_ and arg_615_1.time_ < var_618_8 + var_618_9 then
				local var_618_10 = Color.New(0, 0, 0)

				var_618_10.a = Mathf.Lerp(1, 0, (arg_615_1.time_ - var_618_8) / var_618_9)
				arg_615_1.mask_.color = var_618_10
			end

			if arg_615_1.time_ >= var_618_8 + var_618_9 and arg_615_1.time_ < var_618_8 + var_618_9 + arg_618_0 then
				local var_618_11 = Color.New(0, 0, 0)

				arg_615_1.mask_.enabled = false
				var_618_11.a = 0
				arg_615_1.mask_.color = var_618_11
			end

			local var_618_12 = arg_615_1.actors_["10030"].transform

			if 1.966 < arg_615_1.time_ and arg_615_1.time_ <= 1.966 + arg_618_0 then
				arg_615_1.var_.moveOldPos10030 = var_618_12.localPosition
				var_618_12.localScale = Vector3.New(1, 1, 1)

				arg_615_1:CheckSpriteTmpPos("10030", 7)

				for iter_618_2 = 0, var_618_12.childCount - 1 do
					local var_618_13 = var_618_12:GetChild(iter_618_2)

					if var_618_13.name == "split_3" or not string.find(var_618_13.name, "split") then
						var_618_13.gameObject:SetActive(true)
					else
						var_618_13.gameObject:SetActive(false)
					end
				end
			end

			local var_618_14 = 0.001

			if 1.966 <= arg_615_1.time_ and arg_615_1.time_ < 1.966 + var_618_14 then
				var_618_12.localPosition = Vector3.Lerp(arg_615_1.var_.moveOldPos10030, Vector3.New(0, -2000, 150), (arg_615_1.time_ - 1.966) / var_618_14)
			end

			if arg_615_1.time_ >= 1.966 + var_618_14 and arg_615_1.time_ < 1.966 + var_618_14 + arg_618_0 then
				var_618_12.localPosition = Vector3.New(0, -2000, 150)
			end

			local var_618_15 = arg_615_1.actors_["1041_1"].transform

			if 1.966 < arg_615_1.time_ and arg_615_1.time_ <= 1.966 + arg_618_0 then
				arg_615_1.var_.moveOldPos1041_1 = var_618_15.localPosition
				var_618_15.localScale = Vector3.New(1, 1, 1)

				arg_615_1:CheckSpriteTmpPos("1041_1", 0)
			end

			local var_618_16 = 0.001

			if 1.966 <= arg_615_1.time_ and arg_615_1.time_ < 1.966 + var_618_16 then
				var_618_15.localPosition = Vector3.Lerp(arg_615_1.var_.moveOldPos1041_1, Vector3.New(-1500, -310, -370), (arg_615_1.time_ - 1.966) / var_618_16)
			end

			if arg_615_1.time_ >= 1.966 + var_618_16 and arg_615_1.time_ < 1.966 + var_618_16 + arg_618_0 then
				var_618_15.localPosition = Vector3.New(-1500, -310, -370)
			end

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_618_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_615_1.bgmTxt_.text ~= var_618_19 and arg_615_1.bgmTxt_.text ~= "" then
						if arg_615_1.bgmTxt2_.text ~= "" then
							arg_615_1.bgmTxt_.text = arg_615_1.bgmTxt2_.text
						end

						arg_615_1.bgmTxt2_.text = var_618_19

						arg_615_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_615_1.bgmTxt_.text = var_618_19
						arg_615_1.bgmTxt2_.text = var_618_19
					end

					if arg_615_1.bgmTimer then
						arg_615_1.bgmTimer:Stop()

						arg_615_1.bgmTimer = nil
					end

					if arg_615_1.settingData.show_music_name == 1 then
						arg_615_1.musicController:SetSelectedState("show")
						arg_615_1.musicAnimator_:Play("open", 0, 0)

						if arg_615_1.settingData.music_time ~= 0 then
							arg_615_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_615_1.settingData.music_time), function()
								if arg_615_1 == nil or isNil(arg_615_1.bgmTxt_) then
									return
								end

								arg_615_1.musicController:SetSelectedState("hide")
								arg_615_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_615_1.frameCnt_ <= 1 then
				arg_615_1.dialog_:SetActive(false)
			end

			local var_618_20 = 4
			local var_618_21 = 0.95

			if 4 < arg_615_1.time_ and arg_615_1.time_ <= var_618_20 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0

				arg_615_1.dialog_:SetActive(true)

				arg_615_1.dialogCg_.alpha = 0

				local var_618_22 = LeanTween.value(arg_615_1.dialog_, 0, 1, 0.3)

				var_618_22:setOnUpdate(LuaHelper.FloatAction(function(arg_620_0)
					arg_615_1.dialogCg_.alpha = arg_620_0
				end))
				var_618_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_615_1.dialog_)
					var_618_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_615_1.duration_ = arg_615_1.duration_ + 0.3

				SetActive(arg_615_1.leftNameGo_, false)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_23 = arg_615_1:FormatText(arg_615_1:GetWordFromCfg(115311150).content)

				arg_615_1.text_.text = var_618_23

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_25 = 38 <= 0 and var_618_21 or var_618_21 * (utf8.len(var_618_23) / 38)

				if (38 <= 0 and var_618_21 or var_618_21 * (utf8.len(var_618_23) / 38)) > 0 and var_618_21 < var_618_25 then
					arg_615_1.talkMaxDuration = var_618_25
					var_618_20 = var_618_20 + 0.3

					if var_618_25 + var_618_20 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_25 + var_618_20
					end
				end

				arg_615_1.text_.text = var_618_23
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_26 = var_618_20 + 0.3
			local var_618_27 = math.max(var_618_21, arg_615_1.talkMaxDuration)

			if var_618_20 + 0.3 <= arg_615_1.time_ and arg_615_1.time_ < var_618_26 + var_618_27 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_26) / var_618_27

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_26 + var_618_27 and arg_615_1.time_ < var_618_26 + var_618_27 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1041_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_615_1:InitPlayNodeList()
	end,
	Play115311151 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 115311151
		arg_622_1.duration_ = 10.87

		local var_622_0 = {
			ja = 10.866,
			ko = 7,
			zh = 7.2,
			en = 7.166
		}
		local var_622_1 = manager.audio:GetLocalizationFlag()

		if var_622_0[var_622_1] ~= nil then
			arg_622_1.duration_ = var_622_0[var_622_1]
		end

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play115311152(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				local var_625_0 = arg_622_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_625_0 then
					arg_622_1.var_.alphaOldValue10030 = var_625_0.alpha
					arg_622_1.var_.characterEffect10030 = var_625_0
				end

				arg_622_1.var_.alphaOldValue10030 = 0
			end

			local var_625_1 = 0.5

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_1 then
				if arg_622_1.var_.characterEffect10030 then
					arg_622_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_622_1.var_.alphaOldValue10030, 1, (arg_622_1.time_ - 0) / var_625_1)
				end
			end

			if arg_622_1.time_ >= 0 + var_625_1 and arg_622_1.time_ < 0 + var_625_1 + arg_625_0 and arg_622_1.var_.characterEffect10030 then
				arg_622_1.var_.characterEffect10030.alpha = 1
			end

			local var_625_2 = arg_622_1.actors_["10030"]

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 and not isNil(var_625_2) and arg_622_1.var_.actorSpriteComps10030 == nil then
				arg_622_1.var_.actorSpriteComps10030 = var_625_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_625_3 = 0.2

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_3 and not isNil(var_625_2) then
				if arg_622_1.var_.actorSpriteComps10030 then
					for iter_625_0, iter_625_1 in pairs(arg_622_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_625_1 then
							if arg_622_1.isInRecall_ then
								iter_625_1.color = Color.New(Mathf.Lerp(iter_625_1.color.r, arg_622_1.hightColor1.r, (arg_622_1.time_ - 0) / var_625_3), Mathf.Lerp(iter_625_1.color.g, arg_622_1.hightColor1.g, (arg_622_1.time_ - 0) / var_625_3), (Mathf.Lerp(iter_625_1.color.b, arg_622_1.hightColor1.b, (arg_622_1.time_ - 0) / var_625_3)))
							else
								local var_625_4 = Mathf.Lerp(iter_625_1.color.r, 1, (arg_622_1.time_ - 0) / var_625_3)

								iter_625_1.color = Color.New(var_625_4, var_625_4, var_625_4)
							end
						end
					end
				end
			end

			if arg_622_1.time_ >= 0 + var_625_3 and arg_622_1.time_ < 0 + var_625_3 + arg_625_0 and not isNil(var_625_2) and arg_622_1.var_.actorSpriteComps10030 then
				for iter_625_2, iter_625_3 in pairs(arg_622_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_625_3 then
						iter_625_3.color = arg_622_1.isInRecall_ and (arg_622_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_622_1.var_.actorSpriteComps10030 = nil
			end

			local var_625_5 = arg_622_1.actors_["10030"].transform

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1.var_.moveOldPos10030 = var_625_5.localPosition
				var_625_5.localScale = Vector3.New(1, 1, 1)

				arg_622_1:CheckSpriteTmpPos("10030", 4)

				for iter_625_4 = 0, var_625_5.childCount - 1 do
					local var_625_6 = var_625_5:GetChild(iter_625_4)

					if var_625_6.name == "split_1" or not string.find(var_625_6.name, "split") then
						var_625_6.gameObject:SetActive(true)
					else
						var_625_6.gameObject:SetActive(false)
					end
				end
			end

			local var_625_7 = 0.001

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_7 then
				var_625_5.localPosition = Vector3.Lerp(arg_622_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_622_1.time_ - 0) / var_625_7)
			end

			if arg_622_1.time_ >= 0 + var_625_7 and arg_622_1.time_ < 0 + var_625_7 + arg_625_0 then
				var_625_5.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_625_10 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_622_1.bgmTxt_.text ~= var_625_10 and arg_622_1.bgmTxt_.text ~= "" then
						if arg_622_1.bgmTxt2_.text ~= "" then
							arg_622_1.bgmTxt_.text = arg_622_1.bgmTxt2_.text
						end

						arg_622_1.bgmTxt2_.text = var_625_10

						arg_622_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_622_1.bgmTxt_.text = var_625_10
						arg_622_1.bgmTxt2_.text = var_625_10
					end

					if arg_622_1.bgmTimer then
						arg_622_1.bgmTimer:Stop()

						arg_622_1.bgmTimer = nil
					end

					if arg_622_1.settingData.show_music_name == 1 then
						arg_622_1.musicController:SetSelectedState("show")
						arg_622_1.musicAnimator_:Play("open", 0, 0)

						if arg_622_1.settingData.music_time ~= 0 then
							arg_622_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_622_1.settingData.music_time), function()
								if arg_622_1 == nil or isNil(arg_622_1.bgmTxt_) then
									return
								end

								arg_622_1.musicController:SetSelectedState("hide")
								arg_622_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_625_11 = 0
			local var_625_12 = 0.85

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= var_625_11 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				arg_622_1.leftNameTxt_.text = arg_622_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, false)
				arg_622_1.callingController_:SetSelectedState("normal")

				local var_625_13 = arg_622_1:GetWordFromCfg(115311151)
				local var_625_14 = arg_622_1:FormatText(var_625_13.content)

				arg_622_1.text_.text = var_625_14

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_16 = 34 <= 0 and var_625_12 or var_625_12 * (utf8.len(var_625_14) / 34)

				if (34 <= 0 and var_625_12 or var_625_12 * (utf8.len(var_625_14) / 34)) > 0 and var_625_12 < var_625_16 then
					arg_622_1.talkMaxDuration = var_625_16

					if var_625_16 + var_625_11 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_16 + var_625_11
					end
				end

				arg_622_1.text_.text = var_625_14
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311151", "story_v_out_115311.awb") ~= 0 then
					local var_625_17 = manager.audio:GetVoiceLength("story_v_out_115311", "115311151", "story_v_out_115311.awb") / 1000

					if var_625_17 + var_625_11 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_17 + var_625_11
					end

					if var_625_13.prefab_name ~= "" and arg_622_1.actors_[var_625_13.prefab_name] ~= nil then
						local var_625_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_622_1.actors_[var_625_13.prefab_name].transform, "story_v_out_115311", "115311151", "story_v_out_115311.awb")

						arg_622_1:RecordAudio("115311151", var_625_18)
						arg_622_1:RecordAudio("115311151", var_625_18)
					else
						arg_622_1:AudioAction("play", "voice", "story_v_out_115311", "115311151", "story_v_out_115311.awb")
					end

					arg_622_1:RecordHistoryTalkVoice("story_v_out_115311", "115311151", "story_v_out_115311.awb")
				end

				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_19 = math.max(var_625_12, arg_622_1.talkMaxDuration)

			if var_625_11 <= arg_622_1.time_ and arg_622_1.time_ < var_625_11 + var_625_19 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - var_625_11) / var_625_19

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= var_625_11 + var_625_19 and arg_622_1.time_ < var_625_11 + var_625_19 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {
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

		arg_622_1:InitPlayNodeList()
	end,
	Play115311152 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 115311152
		arg_627_1.duration_ = 12.37

		local var_627_0 = {
			ja = 9.8,
			ko = 10.666,
			zh = 11.4,
			en = 12.366
		}
		local var_627_1 = manager.audio:GetLocalizationFlag()

		if var_627_0[var_627_1] ~= nil then
			arg_627_1.duration_ = var_627_0[var_627_1]
		end

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play115311153(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(arg_627_1.actors_["10030"]) and arg_627_1.var_.actorSpriteComps10030 == nil then
				arg_627_1.var_.actorSpriteComps10030 = arg_627_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_630_0 = 0.2

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_0 and not isNil(arg_627_1.actors_["10030"]) then
				if arg_627_1.var_.actorSpriteComps10030 then
					for iter_630_0, iter_630_1 in pairs(arg_627_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_630_1 then
							if arg_627_1.isInRecall_ then
								iter_630_1.color = Color.New(Mathf.Lerp(iter_630_1.color.r, arg_627_1.hightColor2.r, (arg_627_1.time_ - 0) / var_630_0), Mathf.Lerp(iter_630_1.color.g, arg_627_1.hightColor2.g, (arg_627_1.time_ - 0) / var_630_0), (Mathf.Lerp(iter_630_1.color.b, arg_627_1.hightColor2.b, (arg_627_1.time_ - 0) / var_630_0)))
							else
								local var_630_1 = Mathf.Lerp(iter_630_1.color.r, 0.5, (arg_627_1.time_ - 0) / var_630_0)

								iter_630_1.color = Color.New(var_630_1, var_630_1, var_630_1)
							end
						end
					end
				end
			end

			if arg_627_1.time_ >= 0 + var_630_0 and arg_627_1.time_ < 0 + var_630_0 + arg_630_0 and not isNil(arg_627_1.actors_["10030"]) and arg_627_1.var_.actorSpriteComps10030 then
				for iter_630_2, iter_630_3 in pairs(arg_627_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_630_3 then
						iter_630_3.color = arg_627_1.isInRecall_ and (arg_627_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_627_1.var_.actorSpriteComps10030 = nil
			end

			local var_630_2 = "1038"

			if arg_627_1.actors_["1038"] == nil then
				local var_630_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1038")

				if not isNil(var_630_3) then
					local var_630_4 = Object.Instantiate(var_630_3, arg_627_1.canvasGo_.transform)

					var_630_4.transform:SetSiblingIndex(1)

					var_630_4.name = var_630_2
					var_630_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_627_1.actors_[var_630_2] = var_630_4

					if arg_627_1.isInRecall_ then
						for iter_630_4, iter_630_5 in ipairs((var_630_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_630_5.color = arg_627_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_630_5 = arg_627_1.actors_["1038"].transform

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1.var_.moveOldPos1038 = var_630_5.localPosition
				var_630_5.localScale = Vector3.New(1, 1, 1)

				arg_627_1:CheckSpriteTmpPos("1038", 2)

				for iter_630_6 = 0, var_630_5.childCount - 1 do
					local var_630_6 = var_630_5:GetChild(iter_630_6)

					if var_630_6.name == "split_1" or not string.find(var_630_6.name, "split") then
						var_630_6.gameObject:SetActive(true)
					else
						var_630_6.gameObject:SetActive(false)
					end
				end
			end

			local var_630_7 = 0.001

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_7 then
				var_630_5.localPosition = Vector3.Lerp(arg_627_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_627_1.time_ - 0) / var_630_7)
			end

			if arg_627_1.time_ >= 0 + var_630_7 and arg_627_1.time_ < 0 + var_630_7 + arg_630_0 then
				var_630_5.localPosition = Vector3.New(-390, -400, 0)
			end

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				local var_630_8 = arg_627_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_630_8 then
					arg_627_1.var_.alphaOldValue1038 = var_630_8.alpha
					arg_627_1.var_.characterEffect1038 = var_630_8
				end

				arg_627_1.var_.alphaOldValue1038 = 0
			end

			local var_630_9 = 0.5

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_9 then
				if arg_627_1.var_.characterEffect1038 then
					arg_627_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_627_1.var_.alphaOldValue1038, 1, (arg_627_1.time_ - 0) / var_630_9)
				end
			end

			if arg_627_1.time_ >= 0 + var_630_9 and arg_627_1.time_ < 0 + var_630_9 + arg_630_0 and arg_627_1.var_.characterEffect1038 then
				arg_627_1.var_.characterEffect1038.alpha = 1
			end

			local var_630_10 = arg_627_1.actors_["1038"]

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(var_630_10) and arg_627_1.var_.actorSpriteComps1038 == nil then
				arg_627_1.var_.actorSpriteComps1038 = var_630_10:GetComponentsInChildren(typeof(Image), true)
			end

			local var_630_11 = 0.2

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_11 and not isNil(var_630_10) then
				if arg_627_1.var_.actorSpriteComps1038 then
					for iter_630_7, iter_630_8 in pairs(arg_627_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_630_8 then
							if arg_627_1.isInRecall_ then
								iter_630_8.color = Color.New(Mathf.Lerp(iter_630_8.color.r, arg_627_1.hightColor1.r, (arg_627_1.time_ - 0) / var_630_11), Mathf.Lerp(iter_630_8.color.g, arg_627_1.hightColor1.g, (arg_627_1.time_ - 0) / var_630_11), (Mathf.Lerp(iter_630_8.color.b, arg_627_1.hightColor1.b, (arg_627_1.time_ - 0) / var_630_11)))
							else
								local var_630_12 = Mathf.Lerp(iter_630_8.color.r, 1, (arg_627_1.time_ - 0) / var_630_11)

								iter_630_8.color = Color.New(var_630_12, var_630_12, var_630_12)
							end
						end
					end
				end
			end

			if arg_627_1.time_ >= 0 + var_630_11 and arg_627_1.time_ < 0 + var_630_11 + arg_630_0 and not isNil(var_630_10) and arg_627_1.var_.actorSpriteComps1038 then
				for iter_630_9, iter_630_10 in pairs(arg_627_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_630_10 then
						iter_630_10.color = arg_627_1.isInRecall_ and (arg_627_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_627_1.var_.actorSpriteComps1038 = nil
			end

			local var_630_13 = 0
			local var_630_14 = 1.05

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_13 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_15 = arg_627_1:GetWordFromCfg(115311152)
				local var_630_16 = arg_627_1:FormatText(var_630_15.content)

				arg_627_1.text_.text = var_630_16

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_18 = 42 <= 0 and var_630_14 or var_630_14 * (utf8.len(var_630_16) / 42)

				if (42 <= 0 and var_630_14 or var_630_14 * (utf8.len(var_630_16) / 42)) > 0 and var_630_14 < var_630_18 then
					arg_627_1.talkMaxDuration = var_630_18

					if var_630_18 + var_630_13 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_18 + var_630_13
					end
				end

				arg_627_1.text_.text = var_630_16
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311152", "story_v_out_115311.awb") ~= 0 then
					local var_630_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311152", "story_v_out_115311.awb") / 1000

					if var_630_19 + var_630_13 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_19 + var_630_13
					end

					if var_630_15.prefab_name ~= "" and arg_627_1.actors_[var_630_15.prefab_name] ~= nil then
						local var_630_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_15.prefab_name].transform, "story_v_out_115311", "115311152", "story_v_out_115311.awb")

						arg_627_1:RecordAudio("115311152", var_630_20)
						arg_627_1:RecordAudio("115311152", var_630_20)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_out_115311", "115311152", "story_v_out_115311.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_out_115311", "115311152", "story_v_out_115311.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_21 = math.max(var_630_14, arg_627_1.talkMaxDuration)

			if var_630_13 <= arg_627_1.time_ and arg_627_1.time_ < var_630_13 + var_630_21 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_13) / var_630_21

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_13 + var_630_21 and arg_627_1.time_ < var_630_13 + var_630_21 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {
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

		arg_627_1:InitPlayNodeList()
	end,
	Play115311153 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 115311153
		arg_631_1.duration_ = 13.17

		local var_631_0 = {
			ja = 12.666,
			ko = 9.633,
			zh = 13.166,
			en = 10.566
		}
		local var_631_1 = manager.audio:GetLocalizationFlag()

		if var_631_0[var_631_1] ~= nil then
			arg_631_1.duration_ = var_631_0[var_631_1]
		end

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play115311154(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = 1.25

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_1 = arg_631_1:GetWordFromCfg(115311153)
				local var_634_2 = arg_631_1:FormatText(var_634_1.content)

				arg_631_1.text_.text = var_634_2

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_4 = 50 <= 0 and var_634_0 or var_634_0 * (utf8.len(var_634_2) / 50)

				if (50 <= 0 and var_634_0 or var_634_0 * (utf8.len(var_634_2) / 50)) > 0 and var_634_0 < var_634_4 then
					arg_631_1.talkMaxDuration = var_634_4

					if var_634_4 + 0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_4 + 0
					end
				end

				arg_631_1.text_.text = var_634_2
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311153", "story_v_out_115311.awb") ~= 0 then
					local var_634_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311153", "story_v_out_115311.awb") / 1000

					if var_634_5 + 0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_5 + 0
					end

					if var_634_1.prefab_name ~= "" and arg_631_1.actors_[var_634_1.prefab_name] ~= nil then
						local var_634_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_1.prefab_name].transform, "story_v_out_115311", "115311153", "story_v_out_115311.awb")

						arg_631_1:RecordAudio("115311153", var_634_6)
						arg_631_1:RecordAudio("115311153", var_634_6)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_out_115311", "115311153", "story_v_out_115311.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_out_115311", "115311153", "story_v_out_115311.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_7 = math.max(var_634_0, arg_631_1.talkMaxDuration)

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_7 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - 0) / var_634_7

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= 0 + var_634_7 and arg_631_1.time_ < 0 + var_634_7 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play115311154 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 115311154
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play115311155(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				local var_638_0 = arg_635_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_638_0 then
					arg_635_1.var_.alphaOldValue10030 = var_638_0.alpha
					arg_635_1.var_.characterEffect10030 = var_638_0
				end

				arg_635_1.var_.alphaOldValue10030 = 1
			end

			local var_638_1 = 0.5

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_1 then
				if arg_635_1.var_.characterEffect10030 then
					arg_635_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_635_1.var_.alphaOldValue10030, 0, (arg_635_1.time_ - 0) / var_638_1)
				end
			end

			if arg_635_1.time_ >= 0 + var_638_1 and arg_635_1.time_ < 0 + var_638_1 + arg_638_0 and arg_635_1.var_.characterEffect10030 then
				arg_635_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				local var_638_2 = arg_635_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_638_2 then
					arg_635_1.var_.alphaOldValue1038 = var_638_2.alpha
					arg_635_1.var_.characterEffect1038 = var_638_2
				end

				arg_635_1.var_.alphaOldValue1038 = 1
			end

			local var_638_3 = 0.5

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_3 then
				if arg_635_1.var_.characterEffect1038 then
					arg_635_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_635_1.var_.alphaOldValue1038, 0, (arg_635_1.time_ - 0) / var_638_3)
				end
			end

			if arg_635_1.time_ >= 0 + var_638_3 and arg_635_1.time_ < 0 + var_638_3 + arg_638_0 and arg_635_1.var_.characterEffect1038 then
				arg_635_1.var_.characterEffect1038.alpha = 0
			end

			local var_638_4 = 0
			local var_638_5 = 1.425

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_4 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, false)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_6 = arg_635_1:FormatText(arg_635_1:GetWordFromCfg(115311154).content)

				arg_635_1.text_.text = var_638_6

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_8 = 57 <= 0 and var_638_5 or var_638_5 * (utf8.len(var_638_6) / 57)

				if (57 <= 0 and var_638_5 or var_638_5 * (utf8.len(var_638_6) / 57)) > 0 and var_638_5 < var_638_8 then
					arg_635_1.talkMaxDuration = var_638_8

					if var_638_8 + var_638_4 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_8 + var_638_4
					end
				end

				arg_635_1.text_.text = var_638_6
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_9 = math.max(var_638_5, arg_635_1.talkMaxDuration)

			if var_638_4 <= arg_635_1.time_ and arg_635_1.time_ < var_638_4 + var_638_9 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_4) / var_638_9

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_4 + var_638_9 and arg_635_1.time_ < var_638_4 + var_638_9 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play115311155 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 115311155
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play115311156(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = 0.9

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, false)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_1 = arg_639_1:FormatText(arg_639_1:GetWordFromCfg(115311155).content)

				arg_639_1.text_.text = var_642_1

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_3 = 36 <= 0 and var_642_0 or var_642_0 * (utf8.len(var_642_1) / 36)

				if (36 <= 0 and var_642_0 or var_642_0 * (utf8.len(var_642_1) / 36)) > 0 and var_642_0 < var_642_3 then
					arg_639_1.talkMaxDuration = var_642_3

					if var_642_3 + 0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_3 + 0
					end
				end

				arg_639_1.text_.text = var_642_1
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_4 = math.max(var_642_0, arg_639_1.talkMaxDuration)

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_4 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - 0) / var_642_4

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= 0 + var_642_4 and arg_639_1.time_ < 0 + var_642_4 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play115311156 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 115311156
		arg_643_1.duration_ = 7.93

		local var_643_0 = {
			ja = 7.933,
			ko = 4,
			zh = 3.3,
			en = 4.066
		}
		local var_643_1 = manager.audio:GetLocalizationFlag()

		if var_643_0[var_643_1] ~= nil then
			arg_643_1.duration_ = var_643_0[var_643_1]
		end

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play115311157(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				local var_646_0 = arg_643_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_646_0 then
					arg_643_1.var_.alphaOldValue10030 = var_646_0.alpha
					arg_643_1.var_.characterEffect10030 = var_646_0
				end

				arg_643_1.var_.alphaOldValue10030 = 0
			end

			local var_646_1 = 0.5

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_1 then
				if arg_643_1.var_.characterEffect10030 then
					arg_643_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_643_1.var_.alphaOldValue10030, 1, (arg_643_1.time_ - 0) / var_646_1)
				end
			end

			if arg_643_1.time_ >= 0 + var_646_1 and arg_643_1.time_ < 0 + var_646_1 + arg_646_0 and arg_643_1.var_.characterEffect10030 then
				arg_643_1.var_.characterEffect10030.alpha = 1
			end

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				local var_646_2 = arg_643_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_646_2 then
					arg_643_1.var_.alphaOldValue1038 = var_646_2.alpha
					arg_643_1.var_.characterEffect1038 = var_646_2
				end

				arg_643_1.var_.alphaOldValue1038 = 0
			end

			local var_646_3 = 0.5

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_3 then
				if arg_643_1.var_.characterEffect1038 then
					arg_643_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_643_1.var_.alphaOldValue1038, 1, (arg_643_1.time_ - 0) / var_646_3)
				end
			end

			if arg_643_1.time_ >= 0 + var_646_3 and arg_643_1.time_ < 0 + var_646_3 + arg_646_0 and arg_643_1.var_.characterEffect1038 then
				arg_643_1.var_.characterEffect1038.alpha = 1
			end

			local var_646_4 = arg_643_1.actors_["10030"].transform

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1.var_.moveOldPos10030 = var_646_4.localPosition
				var_646_4.localScale = Vector3.New(1, 1, 1)

				arg_643_1:CheckSpriteTmpPos("10030", 4)

				for iter_646_0 = 0, var_646_4.childCount - 1 do
					local var_646_5 = var_646_4:GetChild(iter_646_0)

					if var_646_5.name == "split_2" or not string.find(var_646_5.name, "split") then
						var_646_5.gameObject:SetActive(true)
					else
						var_646_5.gameObject:SetActive(false)
					end
				end
			end

			local var_646_6 = 0.001

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_6 then
				var_646_4.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_643_1.time_ - 0) / var_646_6)
			end

			if arg_643_1.time_ >= 0 + var_646_6 and arg_643_1.time_ < 0 + var_646_6 + arg_646_0 then
				var_646_4.localPosition = Vector3.New(390, -390, 150)
			end

			local var_646_7 = arg_643_1.actors_["10030"]

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 and not isNil(var_646_7) and arg_643_1.var_.actorSpriteComps10030 == nil then
				arg_643_1.var_.actorSpriteComps10030 = var_646_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_646_8 = 0.2

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_8 and not isNil(var_646_7) then
				if arg_643_1.var_.actorSpriteComps10030 then
					for iter_646_1, iter_646_2 in pairs(arg_643_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_646_2 then
							if arg_643_1.isInRecall_ then
								iter_646_2.color = Color.New(Mathf.Lerp(iter_646_2.color.r, arg_643_1.hightColor1.r, (arg_643_1.time_ - 0) / var_646_8), Mathf.Lerp(iter_646_2.color.g, arg_643_1.hightColor1.g, (arg_643_1.time_ - 0) / var_646_8), (Mathf.Lerp(iter_646_2.color.b, arg_643_1.hightColor1.b, (arg_643_1.time_ - 0) / var_646_8)))
							else
								local var_646_9 = Mathf.Lerp(iter_646_2.color.r, 1, (arg_643_1.time_ - 0) / var_646_8)

								iter_646_2.color = Color.New(var_646_9, var_646_9, var_646_9)
							end
						end
					end
				end
			end

			if arg_643_1.time_ >= 0 + var_646_8 and arg_643_1.time_ < 0 + var_646_8 + arg_646_0 and not isNil(var_646_7) and arg_643_1.var_.actorSpriteComps10030 then
				for iter_646_3, iter_646_4 in pairs(arg_643_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_646_4 then
						iter_646_4.color = arg_643_1.isInRecall_ and (arg_643_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_643_1.var_.actorSpriteComps10030 = nil
			end

			local var_646_10 = arg_643_1.actors_["1038"]

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 and not isNil(var_646_10) and arg_643_1.var_.actorSpriteComps1038 == nil then
				arg_643_1.var_.actorSpriteComps1038 = var_646_10:GetComponentsInChildren(typeof(Image), true)
			end

			local var_646_11 = 0.2

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_11 and not isNil(var_646_10) then
				if arg_643_1.var_.actorSpriteComps1038 then
					for iter_646_5, iter_646_6 in pairs(arg_643_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_646_6 then
							if arg_643_1.isInRecall_ then
								iter_646_6.color = Color.New(Mathf.Lerp(iter_646_6.color.r, arg_643_1.hightColor2.r, (arg_643_1.time_ - 0) / var_646_11), Mathf.Lerp(iter_646_6.color.g, arg_643_1.hightColor2.g, (arg_643_1.time_ - 0) / var_646_11), (Mathf.Lerp(iter_646_6.color.b, arg_643_1.hightColor2.b, (arg_643_1.time_ - 0) / var_646_11)))
							else
								local var_646_12 = Mathf.Lerp(iter_646_6.color.r, 0.5, (arg_643_1.time_ - 0) / var_646_11)

								iter_646_6.color = Color.New(var_646_12, var_646_12, var_646_12)
							end
						end
					end
				end
			end

			if arg_643_1.time_ >= 0 + var_646_11 and arg_643_1.time_ < 0 + var_646_11 + arg_646_0 and not isNil(var_646_10) and arg_643_1.var_.actorSpriteComps1038 then
				for iter_646_7, iter_646_8 in pairs(arg_643_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_646_8 then
						iter_646_8.color = arg_643_1.isInRecall_ and (arg_643_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_643_1.var_.actorSpriteComps1038 = nil
			end

			local var_646_13 = 0
			local var_646_14 = 0.35

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_13 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_15 = arg_643_1:GetWordFromCfg(115311156)
				local var_646_16 = arg_643_1:FormatText(var_646_15.content)

				arg_643_1.text_.text = var_646_16

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_18 = 14 <= 0 and var_646_14 or var_646_14 * (utf8.len(var_646_16) / 14)

				if (14 <= 0 and var_646_14 or var_646_14 * (utf8.len(var_646_16) / 14)) > 0 and var_646_14 < var_646_18 then
					arg_643_1.talkMaxDuration = var_646_18

					if var_646_18 + var_646_13 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_18 + var_646_13
					end
				end

				arg_643_1.text_.text = var_646_16
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311156", "story_v_out_115311.awb") ~= 0 then
					local var_646_19 = manager.audio:GetVoiceLength("story_v_out_115311", "115311156", "story_v_out_115311.awb") / 1000

					if var_646_19 + var_646_13 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_19 + var_646_13
					end

					if var_646_15.prefab_name ~= "" and arg_643_1.actors_[var_646_15.prefab_name] ~= nil then
						local var_646_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_15.prefab_name].transform, "story_v_out_115311", "115311156", "story_v_out_115311.awb")

						arg_643_1:RecordAudio("115311156", var_646_20)
						arg_643_1:RecordAudio("115311156", var_646_20)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_out_115311", "115311156", "story_v_out_115311.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_out_115311", "115311156", "story_v_out_115311.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_21 = math.max(var_646_14, arg_643_1.talkMaxDuration)

			if var_646_13 <= arg_643_1.time_ and arg_643_1.time_ < var_646_13 + var_646_21 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_13) / var_646_21

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_13 + var_646_21 and arg_643_1.time_ < var_646_13 + var_646_21 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {
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

		arg_643_1:InitPlayNodeList()
	end,
	Play115311157 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 115311157
		arg_647_1.duration_ = 6.4

		local var_647_0 = {
			ja = 6.4,
			ko = 4.2,
			zh = 5.733,
			en = 5.8
		}
		local var_647_1 = manager.audio:GetLocalizationFlag()

		if var_647_0[var_647_1] ~= nil then
			arg_647_1.duration_ = var_647_0[var_647_1]
		end

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play115311158(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 and not isNil(arg_647_1.actors_["10030"]) and arg_647_1.var_.actorSpriteComps10030 == nil then
				arg_647_1.var_.actorSpriteComps10030 = arg_647_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_650_0 = 0.2

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_0 and not isNil(arg_647_1.actors_["10030"]) then
				if arg_647_1.var_.actorSpriteComps10030 then
					for iter_650_0, iter_650_1 in pairs(arg_647_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_650_1 then
							if arg_647_1.isInRecall_ then
								iter_650_1.color = Color.New(Mathf.Lerp(iter_650_1.color.r, arg_647_1.hightColor2.r, (arg_647_1.time_ - 0) / var_650_0), Mathf.Lerp(iter_650_1.color.g, arg_647_1.hightColor2.g, (arg_647_1.time_ - 0) / var_650_0), (Mathf.Lerp(iter_650_1.color.b, arg_647_1.hightColor2.b, (arg_647_1.time_ - 0) / var_650_0)))
							else
								local var_650_1 = Mathf.Lerp(iter_650_1.color.r, 0.5, (arg_647_1.time_ - 0) / var_650_0)

								iter_650_1.color = Color.New(var_650_1, var_650_1, var_650_1)
							end
						end
					end
				end
			end

			if arg_647_1.time_ >= 0 + var_650_0 and arg_647_1.time_ < 0 + var_650_0 + arg_650_0 and not isNil(arg_647_1.actors_["10030"]) and arg_647_1.var_.actorSpriteComps10030 then
				for iter_650_2, iter_650_3 in pairs(arg_647_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_650_3 then
						iter_650_3.color = arg_647_1.isInRecall_ and (arg_647_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_647_1.var_.actorSpriteComps10030 = nil
			end

			local var_650_2 = arg_647_1.actors_["1038"]

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 and not isNil(var_650_2) and arg_647_1.var_.actorSpriteComps1038 == nil then
				arg_647_1.var_.actorSpriteComps1038 = var_650_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_650_3 = 0.2

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_3 and not isNil(var_650_2) then
				if arg_647_1.var_.actorSpriteComps1038 then
					for iter_650_4, iter_650_5 in pairs(arg_647_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_650_5 then
							if arg_647_1.isInRecall_ then
								iter_650_5.color = Color.New(Mathf.Lerp(iter_650_5.color.r, arg_647_1.hightColor1.r, (arg_647_1.time_ - 0) / var_650_3), Mathf.Lerp(iter_650_5.color.g, arg_647_1.hightColor1.g, (arg_647_1.time_ - 0) / var_650_3), (Mathf.Lerp(iter_650_5.color.b, arg_647_1.hightColor1.b, (arg_647_1.time_ - 0) / var_650_3)))
							else
								local var_650_4 = Mathf.Lerp(iter_650_5.color.r, 1, (arg_647_1.time_ - 0) / var_650_3)

								iter_650_5.color = Color.New(var_650_4, var_650_4, var_650_4)
							end
						end
					end
				end
			end

			if arg_647_1.time_ >= 0 + var_650_3 and arg_647_1.time_ < 0 + var_650_3 + arg_650_0 and not isNil(var_650_2) and arg_647_1.var_.actorSpriteComps1038 then
				for iter_650_6, iter_650_7 in pairs(arg_647_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_650_7 then
						iter_650_7.color = arg_647_1.isInRecall_ and (arg_647_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_647_1.var_.actorSpriteComps1038 = nil
			end

			local var_650_5 = arg_647_1.actors_["1038"].transform

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1.var_.moveOldPos1038 = var_650_5.localPosition
				var_650_5.localScale = Vector3.New(1, 1, 1)

				arg_647_1:CheckSpriteTmpPos("1038", 2)

				for iter_650_8 = 0, var_650_5.childCount - 1 do
					local var_650_6 = var_650_5:GetChild(iter_650_8)

					if var_650_6.name == "split_9" or not string.find(var_650_6.name, "split") then
						var_650_6.gameObject:SetActive(true)
					else
						var_650_6.gameObject:SetActive(false)
					end
				end
			end

			local var_650_7 = 0.001

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_7 then
				var_650_5.localPosition = Vector3.Lerp(arg_647_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_647_1.time_ - 0) / var_650_7)
			end

			if arg_647_1.time_ >= 0 + var_650_7 and arg_647_1.time_ < 0 + var_650_7 + arg_650_0 then
				var_650_5.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_650_8 = 0
			local var_650_9 = 0.5

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_8 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				arg_647_1.leftNameTxt_.text = arg_647_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_10 = arg_647_1:GetWordFromCfg(115311157)
				local var_650_11 = arg_647_1:FormatText(var_650_10.content)

				arg_647_1.text_.text = var_650_11

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_13 = 20 <= 0 and var_650_9 or var_650_9 * (utf8.len(var_650_11) / 20)

				if (20 <= 0 and var_650_9 or var_650_9 * (utf8.len(var_650_11) / 20)) > 0 and var_650_9 < var_650_13 then
					arg_647_1.talkMaxDuration = var_650_13

					if var_650_13 + var_650_8 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_13 + var_650_8
					end
				end

				arg_647_1.text_.text = var_650_11
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311157", "story_v_out_115311.awb") ~= 0 then
					local var_650_14 = manager.audio:GetVoiceLength("story_v_out_115311", "115311157", "story_v_out_115311.awb") / 1000

					if var_650_14 + var_650_8 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_14 + var_650_8
					end

					if var_650_10.prefab_name ~= "" and arg_647_1.actors_[var_650_10.prefab_name] ~= nil then
						local var_650_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_10.prefab_name].transform, "story_v_out_115311", "115311157", "story_v_out_115311.awb")

						arg_647_1:RecordAudio("115311157", var_650_15)
						arg_647_1:RecordAudio("115311157", var_650_15)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_out_115311", "115311157", "story_v_out_115311.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_out_115311", "115311157", "story_v_out_115311.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_16 = math.max(var_650_9, arg_647_1.talkMaxDuration)

			if var_650_8 <= arg_647_1.time_ and arg_647_1.time_ < var_650_8 + var_650_16 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_8) / var_650_16

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_8 + var_650_16 and arg_647_1.time_ < var_650_8 + var_650_16 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {
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

		arg_647_1:InitPlayNodeList()
	end,
	Play115311158 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 115311158
		arg_651_1.duration_ = 17.6

		local var_651_0 = {
			ja = 17.466,
			ko = 15.8,
			zh = 13.766,
			en = 17.6
		}
		local var_651_1 = manager.audio:GetLocalizationFlag()

		if var_651_0[var_651_1] ~= nil then
			arg_651_1.duration_ = var_651_0[var_651_1]
		end

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play115311159(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = 1.375

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				arg_651_1.leftNameTxt_.text = arg_651_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_1 = arg_651_1:GetWordFromCfg(115311158)
				local var_654_2 = arg_651_1:FormatText(var_654_1.content)

				arg_651_1.text_.text = var_654_2

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_4 = 55 <= 0 and var_654_0 or var_654_0 * (utf8.len(var_654_2) / 55)

				if (55 <= 0 and var_654_0 or var_654_0 * (utf8.len(var_654_2) / 55)) > 0 and var_654_0 < var_654_4 then
					arg_651_1.talkMaxDuration = var_654_4

					if var_654_4 + 0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_4 + 0
					end
				end

				arg_651_1.text_.text = var_654_2
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311158", "story_v_out_115311.awb") ~= 0 then
					local var_654_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311158", "story_v_out_115311.awb") / 1000

					if var_654_5 + 0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_5 + 0
					end

					if var_654_1.prefab_name ~= "" and arg_651_1.actors_[var_654_1.prefab_name] ~= nil then
						local var_654_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_651_1.actors_[var_654_1.prefab_name].transform, "story_v_out_115311", "115311158", "story_v_out_115311.awb")

						arg_651_1:RecordAudio("115311158", var_654_6)
						arg_651_1:RecordAudio("115311158", var_654_6)
					else
						arg_651_1:AudioAction("play", "voice", "story_v_out_115311", "115311158", "story_v_out_115311.awb")
					end

					arg_651_1:RecordHistoryTalkVoice("story_v_out_115311", "115311158", "story_v_out_115311.awb")
				end

				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_7 = math.max(var_654_0, arg_651_1.talkMaxDuration)

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_7 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - 0) / var_654_7

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= 0 + var_654_7 and arg_651_1.time_ < 0 + var_654_7 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play115311159 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 115311159
		arg_655_1.duration_ = 10.17

		local var_655_0 = {
			ja = 10.166,
			ko = 7.666,
			zh = 8.333,
			en = 8.633
		}
		local var_655_1 = manager.audio:GetLocalizationFlag()

		if var_655_0[var_655_1] ~= nil then
			arg_655_1.duration_ = var_655_0[var_655_1]
		end

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play115311160(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 then
				arg_655_1.var_.moveOldPos10030 = arg_655_1.actors_["10030"].transform.localPosition
				arg_655_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_655_1:CheckSpriteTmpPos("10030", 4)

				for iter_658_0 = 0, arg_655_1.actors_["10030"].transform.childCount - 1 do
					local var_658_0 = arg_655_1.actors_["10030"].transform:GetChild(iter_658_0)

					if var_658_0.name == "split_3" or not string.find(var_658_0.name, "split") then
						var_658_0.gameObject:SetActive(true)
					else
						var_658_0.gameObject:SetActive(false)
					end
				end
			end

			local var_658_1 = 0.001

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_1 then
				arg_655_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_655_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_655_1.time_ - 0) / var_658_1)
			end

			if arg_655_1.time_ >= 0 + var_658_1 and arg_655_1.time_ < 0 + var_658_1 + arg_658_0 then
				arg_655_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_658_2 = arg_655_1.actors_["10030"]

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 and not isNil(var_658_2) and arg_655_1.var_.actorSpriteComps10030 == nil then
				arg_655_1.var_.actorSpriteComps10030 = var_658_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_658_3 = 0.2

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_3 and not isNil(var_658_2) then
				if arg_655_1.var_.actorSpriteComps10030 then
					for iter_658_1, iter_658_2 in pairs(arg_655_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_658_2 then
							if arg_655_1.isInRecall_ then
								iter_658_2.color = Color.New(Mathf.Lerp(iter_658_2.color.r, arg_655_1.hightColor1.r, (arg_655_1.time_ - 0) / var_658_3), Mathf.Lerp(iter_658_2.color.g, arg_655_1.hightColor1.g, (arg_655_1.time_ - 0) / var_658_3), (Mathf.Lerp(iter_658_2.color.b, arg_655_1.hightColor1.b, (arg_655_1.time_ - 0) / var_658_3)))
							else
								local var_658_4 = Mathf.Lerp(iter_658_2.color.r, 1, (arg_655_1.time_ - 0) / var_658_3)

								iter_658_2.color = Color.New(var_658_4, var_658_4, var_658_4)
							end
						end
					end
				end
			end

			if arg_655_1.time_ >= 0 + var_658_3 and arg_655_1.time_ < 0 + var_658_3 + arg_658_0 and not isNil(var_658_2) and arg_655_1.var_.actorSpriteComps10030 then
				for iter_658_3, iter_658_4 in pairs(arg_655_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_658_4 then
						iter_658_4.color = arg_655_1.isInRecall_ and (arg_655_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_655_1.var_.actorSpriteComps10030 = nil
			end

			local var_658_5 = arg_655_1.actors_["1038"]

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 and not isNil(var_658_5) and arg_655_1.var_.actorSpriteComps1038 == nil then
				arg_655_1.var_.actorSpriteComps1038 = var_658_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_658_6 = 0.2

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_6 and not isNil(var_658_5) then
				if arg_655_1.var_.actorSpriteComps1038 then
					for iter_658_5, iter_658_6 in pairs(arg_655_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_658_6 then
							if arg_655_1.isInRecall_ then
								iter_658_6.color = Color.New(Mathf.Lerp(iter_658_6.color.r, arg_655_1.hightColor2.r, (arg_655_1.time_ - 0) / var_658_6), Mathf.Lerp(iter_658_6.color.g, arg_655_1.hightColor2.g, (arg_655_1.time_ - 0) / var_658_6), (Mathf.Lerp(iter_658_6.color.b, arg_655_1.hightColor2.b, (arg_655_1.time_ - 0) / var_658_6)))
							else
								local var_658_7 = Mathf.Lerp(iter_658_6.color.r, 0.5, (arg_655_1.time_ - 0) / var_658_6)

								iter_658_6.color = Color.New(var_658_7, var_658_7, var_658_7)
							end
						end
					end
				end
			end

			if arg_655_1.time_ >= 0 + var_658_6 and arg_655_1.time_ < 0 + var_658_6 + arg_658_0 and not isNil(var_658_5) and arg_655_1.var_.actorSpriteComps1038 then
				for iter_658_7, iter_658_8 in pairs(arg_655_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_658_8 then
						iter_658_8.color = arg_655_1.isInRecall_ and (arg_655_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_655_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 then
				local var_658_8 = arg_655_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_658_8 then
					arg_655_1.var_.alphaOldValue10030 = var_658_8.alpha
					arg_655_1.var_.characterEffect10030 = var_658_8
				end

				arg_655_1.var_.alphaOldValue10030 = 0
			end

			local var_658_9 = 0.0166666666666667

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_9 then
				if arg_655_1.var_.characterEffect10030 then
					arg_655_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_655_1.var_.alphaOldValue10030, 1, (arg_655_1.time_ - 0) / var_658_9)
				end
			end

			if arg_655_1.time_ >= 0 + var_658_9 and arg_655_1.time_ < 0 + var_658_9 + arg_658_0 and arg_655_1.var_.characterEffect10030 then
				arg_655_1.var_.characterEffect10030.alpha = 1
			end

			local var_658_10 = 0
			local var_658_11 = 0.875

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_10 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				arg_655_1.leftNameTxt_.text = arg_655_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, false)
				arg_655_1.callingController_:SetSelectedState("normal")

				local var_658_12 = arg_655_1:GetWordFromCfg(115311159)
				local var_658_13 = arg_655_1:FormatText(var_658_12.content)

				arg_655_1.text_.text = var_658_13

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_15 = 35 <= 0 and var_658_11 or var_658_11 * (utf8.len(var_658_13) / 35)

				if (35 <= 0 and var_658_11 or var_658_11 * (utf8.len(var_658_13) / 35)) > 0 and var_658_11 < var_658_15 then
					arg_655_1.talkMaxDuration = var_658_15

					if var_658_15 + var_658_10 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_15 + var_658_10
					end
				end

				arg_655_1.text_.text = var_658_13
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311159", "story_v_out_115311.awb") ~= 0 then
					local var_658_16 = manager.audio:GetVoiceLength("story_v_out_115311", "115311159", "story_v_out_115311.awb") / 1000

					if var_658_16 + var_658_10 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_16 + var_658_10
					end

					if var_658_12.prefab_name ~= "" and arg_655_1.actors_[var_658_12.prefab_name] ~= nil then
						local var_658_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_655_1.actors_[var_658_12.prefab_name].transform, "story_v_out_115311", "115311159", "story_v_out_115311.awb")

						arg_655_1:RecordAudio("115311159", var_658_17)
						arg_655_1:RecordAudio("115311159", var_658_17)
					else
						arg_655_1:AudioAction("play", "voice", "story_v_out_115311", "115311159", "story_v_out_115311.awb")
					end

					arg_655_1:RecordHistoryTalkVoice("story_v_out_115311", "115311159", "story_v_out_115311.awb")
				end

				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_18 = math.max(var_658_11, arg_655_1.talkMaxDuration)

			if var_658_10 <= arg_655_1.time_ and arg_655_1.time_ < var_658_10 + var_658_18 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_10) / var_658_18

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_10 + var_658_18 and arg_655_1.time_ < var_658_10 + var_658_18 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {
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

		arg_655_1:InitPlayNodeList()
	end,
	Play115311160 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 115311160
		arg_659_1.duration_ = 7.2

		local var_659_0 = {
			ja = 7.2,
			ko = 4.9,
			zh = 4.533,
			en = 6.3
		}
		local var_659_1 = manager.audio:GetLocalizationFlag()

		if var_659_0[var_659_1] ~= nil then
			arg_659_1.duration_ = var_659_0[var_659_1]
		end

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play115311161(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 and not isNil(arg_659_1.actors_["10030"]) and arg_659_1.var_.actorSpriteComps10030 == nil then
				arg_659_1.var_.actorSpriteComps10030 = arg_659_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_662_0 = 0.2

			if 0 <= arg_659_1.time_ and arg_659_1.time_ < 0 + var_662_0 and not isNil(arg_659_1.actors_["10030"]) then
				if arg_659_1.var_.actorSpriteComps10030 then
					for iter_662_0, iter_662_1 in pairs(arg_659_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_662_1 then
							if arg_659_1.isInRecall_ then
								iter_662_1.color = Color.New(Mathf.Lerp(iter_662_1.color.r, arg_659_1.hightColor2.r, (arg_659_1.time_ - 0) / var_662_0), Mathf.Lerp(iter_662_1.color.g, arg_659_1.hightColor2.g, (arg_659_1.time_ - 0) / var_662_0), (Mathf.Lerp(iter_662_1.color.b, arg_659_1.hightColor2.b, (arg_659_1.time_ - 0) / var_662_0)))
							else
								local var_662_1 = Mathf.Lerp(iter_662_1.color.r, 0.5, (arg_659_1.time_ - 0) / var_662_0)

								iter_662_1.color = Color.New(var_662_1, var_662_1, var_662_1)
							end
						end
					end
				end
			end

			if arg_659_1.time_ >= 0 + var_662_0 and arg_659_1.time_ < 0 + var_662_0 + arg_662_0 and not isNil(arg_659_1.actors_["10030"]) and arg_659_1.var_.actorSpriteComps10030 then
				for iter_662_2, iter_662_3 in pairs(arg_659_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_662_3 then
						iter_662_3.color = arg_659_1.isInRecall_ and (arg_659_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_659_1.var_.actorSpriteComps10030 = nil
			end

			local var_662_2 = arg_659_1.actors_["1038"]

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 and not isNil(var_662_2) and arg_659_1.var_.actorSpriteComps1038 == nil then
				arg_659_1.var_.actorSpriteComps1038 = var_662_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_662_3 = 0.2

			if 0 <= arg_659_1.time_ and arg_659_1.time_ < 0 + var_662_3 and not isNil(var_662_2) then
				if arg_659_1.var_.actorSpriteComps1038 then
					for iter_662_4, iter_662_5 in pairs(arg_659_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_662_5 then
							if arg_659_1.isInRecall_ then
								iter_662_5.color = Color.New(Mathf.Lerp(iter_662_5.color.r, arg_659_1.hightColor1.r, (arg_659_1.time_ - 0) / var_662_3), Mathf.Lerp(iter_662_5.color.g, arg_659_1.hightColor1.g, (arg_659_1.time_ - 0) / var_662_3), (Mathf.Lerp(iter_662_5.color.b, arg_659_1.hightColor1.b, (arg_659_1.time_ - 0) / var_662_3)))
							else
								local var_662_4 = Mathf.Lerp(iter_662_5.color.r, 1, (arg_659_1.time_ - 0) / var_662_3)

								iter_662_5.color = Color.New(var_662_4, var_662_4, var_662_4)
							end
						end
					end
				end
			end

			if arg_659_1.time_ >= 0 + var_662_3 and arg_659_1.time_ < 0 + var_662_3 + arg_662_0 and not isNil(var_662_2) and arg_659_1.var_.actorSpriteComps1038 then
				for iter_662_6, iter_662_7 in pairs(arg_659_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_662_7 then
						iter_662_7.color = arg_659_1.isInRecall_ and (arg_659_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_659_1.var_.actorSpriteComps1038 = nil
			end

			local var_662_5 = 0
			local var_662_6 = 0.4

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= var_662_5 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				arg_659_1.leftNameTxt_.text = arg_659_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_7 = arg_659_1:GetWordFromCfg(115311160)
				local var_662_8 = arg_659_1:FormatText(var_662_7.content)

				arg_659_1.text_.text = var_662_8

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_10 = 16 <= 0 and var_662_6 or var_662_6 * (utf8.len(var_662_8) / 16)

				if (16 <= 0 and var_662_6 or var_662_6 * (utf8.len(var_662_8) / 16)) > 0 and var_662_6 < var_662_10 then
					arg_659_1.talkMaxDuration = var_662_10

					if var_662_10 + var_662_5 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_10 + var_662_5
					end
				end

				arg_659_1.text_.text = var_662_8
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311160", "story_v_out_115311.awb") ~= 0 then
					local var_662_11 = manager.audio:GetVoiceLength("story_v_out_115311", "115311160", "story_v_out_115311.awb") / 1000

					if var_662_11 + var_662_5 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_11 + var_662_5
					end

					if var_662_7.prefab_name ~= "" and arg_659_1.actors_[var_662_7.prefab_name] ~= nil then
						local var_662_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_659_1.actors_[var_662_7.prefab_name].transform, "story_v_out_115311", "115311160", "story_v_out_115311.awb")

						arg_659_1:RecordAudio("115311160", var_662_12)
						arg_659_1:RecordAudio("115311160", var_662_12)
					else
						arg_659_1:AudioAction("play", "voice", "story_v_out_115311", "115311160", "story_v_out_115311.awb")
					end

					arg_659_1:RecordHistoryTalkVoice("story_v_out_115311", "115311160", "story_v_out_115311.awb")
				end

				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_13 = math.max(var_662_6, arg_659_1.talkMaxDuration)

			if var_662_5 <= arg_659_1.time_ and arg_659_1.time_ < var_662_5 + var_662_13 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_5) / var_662_13

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_5 + var_662_13 and arg_659_1.time_ < var_662_5 + var_662_13 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play115311161 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 115311161
		arg_663_1.duration_ = 7.77

		local var_663_0 = {
			ja = 7.766,
			ko = 3.9,
			zh = 4.733,
			en = 4.6
		}
		local var_663_1 = manager.audio:GetLocalizationFlag()

		if var_663_0[var_663_1] ~= nil then
			arg_663_1.duration_ = var_663_0[var_663_1]
		end

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play115311162(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 and not isNil(arg_663_1.actors_["1038"]) and arg_663_1.var_.actorSpriteComps1038 == nil then
				arg_663_1.var_.actorSpriteComps1038 = arg_663_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_666_0 = 0.2

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_0 and not isNil(arg_663_1.actors_["1038"]) then
				if arg_663_1.var_.actorSpriteComps1038 then
					for iter_666_0, iter_666_1 in pairs(arg_663_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_666_1 then
							if arg_663_1.isInRecall_ then
								iter_666_1.color = Color.New(Mathf.Lerp(iter_666_1.color.r, arg_663_1.hightColor2.r, (arg_663_1.time_ - 0) / var_666_0), Mathf.Lerp(iter_666_1.color.g, arg_663_1.hightColor2.g, (arg_663_1.time_ - 0) / var_666_0), (Mathf.Lerp(iter_666_1.color.b, arg_663_1.hightColor2.b, (arg_663_1.time_ - 0) / var_666_0)))
							else
								local var_666_1 = Mathf.Lerp(iter_666_1.color.r, 0.5, (arg_663_1.time_ - 0) / var_666_0)

								iter_666_1.color = Color.New(var_666_1, var_666_1, var_666_1)
							end
						end
					end
				end
			end

			if arg_663_1.time_ >= 0 + var_666_0 and arg_663_1.time_ < 0 + var_666_0 + arg_666_0 and not isNil(arg_663_1.actors_["1038"]) and arg_663_1.var_.actorSpriteComps1038 then
				for iter_666_2, iter_666_3 in pairs(arg_663_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_666_3 then
						iter_666_3.color = arg_663_1.isInRecall_ and (arg_663_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_663_1.var_.actorSpriteComps1038 = nil
			end

			local var_666_2 = arg_663_1.actors_["10030"]

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 and not isNil(var_666_2) and arg_663_1.var_.actorSpriteComps10030 == nil then
				arg_663_1.var_.actorSpriteComps10030 = var_666_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_666_3 = 0.2

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_3 and not isNil(var_666_2) then
				if arg_663_1.var_.actorSpriteComps10030 then
					for iter_666_4, iter_666_5 in pairs(arg_663_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_666_5 then
							if arg_663_1.isInRecall_ then
								iter_666_5.color = Color.New(Mathf.Lerp(iter_666_5.color.r, arg_663_1.hightColor1.r, (arg_663_1.time_ - 0) / var_666_3), Mathf.Lerp(iter_666_5.color.g, arg_663_1.hightColor1.g, (arg_663_1.time_ - 0) / var_666_3), (Mathf.Lerp(iter_666_5.color.b, arg_663_1.hightColor1.b, (arg_663_1.time_ - 0) / var_666_3)))
							else
								local var_666_4 = Mathf.Lerp(iter_666_5.color.r, 1, (arg_663_1.time_ - 0) / var_666_3)

								iter_666_5.color = Color.New(var_666_4, var_666_4, var_666_4)
							end
						end
					end
				end
			end

			if arg_663_1.time_ >= 0 + var_666_3 and arg_663_1.time_ < 0 + var_666_3 + arg_666_0 and not isNil(var_666_2) and arg_663_1.var_.actorSpriteComps10030 then
				for iter_666_6, iter_666_7 in pairs(arg_663_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_666_7 then
						iter_666_7.color = arg_663_1.isInRecall_ and (arg_663_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_663_1.var_.actorSpriteComps10030 = nil
			end

			local var_666_5 = 0
			local var_666_6 = 0.425

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_5 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				arg_663_1.leftNameTxt_.text = arg_663_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_7 = arg_663_1:GetWordFromCfg(115311161)
				local var_666_8 = arg_663_1:FormatText(var_666_7.content)

				arg_663_1.text_.text = var_666_8

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_10 = 17 <= 0 and var_666_6 or var_666_6 * (utf8.len(var_666_8) / 17)

				if (17 <= 0 and var_666_6 or var_666_6 * (utf8.len(var_666_8) / 17)) > 0 and var_666_6 < var_666_10 then
					arg_663_1.talkMaxDuration = var_666_10

					if var_666_10 + var_666_5 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_10 + var_666_5
					end
				end

				arg_663_1.text_.text = var_666_8
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311161", "story_v_out_115311.awb") ~= 0 then
					local var_666_11 = manager.audio:GetVoiceLength("story_v_out_115311", "115311161", "story_v_out_115311.awb") / 1000

					if var_666_11 + var_666_5 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_11 + var_666_5
					end

					if var_666_7.prefab_name ~= "" and arg_663_1.actors_[var_666_7.prefab_name] ~= nil then
						local var_666_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_663_1.actors_[var_666_7.prefab_name].transform, "story_v_out_115311", "115311161", "story_v_out_115311.awb")

						arg_663_1:RecordAudio("115311161", var_666_12)
						arg_663_1:RecordAudio("115311161", var_666_12)
					else
						arg_663_1:AudioAction("play", "voice", "story_v_out_115311", "115311161", "story_v_out_115311.awb")
					end

					arg_663_1:RecordHistoryTalkVoice("story_v_out_115311", "115311161", "story_v_out_115311.awb")
				end

				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_13 = math.max(var_666_6, arg_663_1.talkMaxDuration)

			if var_666_5 <= arg_663_1.time_ and arg_663_1.time_ < var_666_5 + var_666_13 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_5) / var_666_13

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_5 + var_666_13 and arg_663_1.time_ < var_666_5 + var_666_13 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play115311162 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 115311162
		arg_667_1.duration_ = 9.83

		local var_667_0 = {
			ja = 9.833,
			ko = 5.9,
			zh = 5.1,
			en = 6.666
		}
		local var_667_1 = manager.audio:GetLocalizationFlag()

		if var_667_0[var_667_1] ~= nil then
			arg_667_1.duration_ = var_667_0[var_667_1]
		end

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play115311163(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = 0.65

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				arg_667_1.leftNameTxt_.text = arg_667_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_1 = arg_667_1:GetWordFromCfg(115311162)
				local var_670_2 = arg_667_1:FormatText(var_670_1.content)

				arg_667_1.text_.text = var_670_2

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_4 = 26 <= 0 and var_670_0 or var_670_0 * (utf8.len(var_670_2) / 26)

				if (26 <= 0 and var_670_0 or var_670_0 * (utf8.len(var_670_2) / 26)) > 0 and var_670_0 < var_670_4 then
					arg_667_1.talkMaxDuration = var_670_4

					if var_670_4 + 0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_4 + 0
					end
				end

				arg_667_1.text_.text = var_670_2
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311162", "story_v_out_115311.awb") ~= 0 then
					local var_670_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311162", "story_v_out_115311.awb") / 1000

					if var_670_5 + 0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_5 + 0
					end

					if var_670_1.prefab_name ~= "" and arg_667_1.actors_[var_670_1.prefab_name] ~= nil then
						local var_670_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_667_1.actors_[var_670_1.prefab_name].transform, "story_v_out_115311", "115311162", "story_v_out_115311.awb")

						arg_667_1:RecordAudio("115311162", var_670_6)
						arg_667_1:RecordAudio("115311162", var_670_6)
					else
						arg_667_1:AudioAction("play", "voice", "story_v_out_115311", "115311162", "story_v_out_115311.awb")
					end

					arg_667_1:RecordHistoryTalkVoice("story_v_out_115311", "115311162", "story_v_out_115311.awb")
				end

				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_7 = math.max(var_670_0, arg_667_1.talkMaxDuration)

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_7 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - 0) / var_670_7

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= 0 + var_670_7 and arg_667_1.time_ < 0 + var_670_7 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play115311163 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 115311163
		arg_671_1.duration_ = 11.4

		local var_671_0 = {
			ja = 11.4,
			ko = 7.266,
			zh = 7.4,
			en = 7.1
		}
		local var_671_1 = manager.audio:GetLocalizationFlag()

		if var_671_0[var_671_1] ~= nil then
			arg_671_1.duration_ = var_671_0[var_671_1]
		end

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play115311164(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 and not isNil(arg_671_1.actors_["1038"]) and arg_671_1.var_.actorSpriteComps1038 == nil then
				arg_671_1.var_.actorSpriteComps1038 = arg_671_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_674_0 = 0.2

			if 0 <= arg_671_1.time_ and arg_671_1.time_ < 0 + var_674_0 and not isNil(arg_671_1.actors_["1038"]) then
				if arg_671_1.var_.actorSpriteComps1038 then
					for iter_674_0, iter_674_1 in pairs(arg_671_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_674_1 then
							if arg_671_1.isInRecall_ then
								iter_674_1.color = Color.New(Mathf.Lerp(iter_674_1.color.r, arg_671_1.hightColor1.r, (arg_671_1.time_ - 0) / var_674_0), Mathf.Lerp(iter_674_1.color.g, arg_671_1.hightColor1.g, (arg_671_1.time_ - 0) / var_674_0), (Mathf.Lerp(iter_674_1.color.b, arg_671_1.hightColor1.b, (arg_671_1.time_ - 0) / var_674_0)))
							else
								local var_674_1 = Mathf.Lerp(iter_674_1.color.r, 1, (arg_671_1.time_ - 0) / var_674_0)

								iter_674_1.color = Color.New(var_674_1, var_674_1, var_674_1)
							end
						end
					end
				end
			end

			if arg_671_1.time_ >= 0 + var_674_0 and arg_671_1.time_ < 0 + var_674_0 + arg_674_0 and not isNil(arg_671_1.actors_["1038"]) and arg_671_1.var_.actorSpriteComps1038 then
				for iter_674_2, iter_674_3 in pairs(arg_671_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_674_3 then
						iter_674_3.color = arg_671_1.isInRecall_ and (arg_671_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_671_1.var_.actorSpriteComps1038 = nil
			end

			local var_674_2 = arg_671_1.actors_["10030"]

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 and not isNil(var_674_2) and arg_671_1.var_.actorSpriteComps10030 == nil then
				arg_671_1.var_.actorSpriteComps10030 = var_674_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_674_3 = 0.2

			if 0 <= arg_671_1.time_ and arg_671_1.time_ < 0 + var_674_3 and not isNil(var_674_2) then
				if arg_671_1.var_.actorSpriteComps10030 then
					for iter_674_4, iter_674_5 in pairs(arg_671_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_674_5 then
							if arg_671_1.isInRecall_ then
								iter_674_5.color = Color.New(Mathf.Lerp(iter_674_5.color.r, arg_671_1.hightColor2.r, (arg_671_1.time_ - 0) / var_674_3), Mathf.Lerp(iter_674_5.color.g, arg_671_1.hightColor2.g, (arg_671_1.time_ - 0) / var_674_3), (Mathf.Lerp(iter_674_5.color.b, arg_671_1.hightColor2.b, (arg_671_1.time_ - 0) / var_674_3)))
							else
								local var_674_4 = Mathf.Lerp(iter_674_5.color.r, 0.5, (arg_671_1.time_ - 0) / var_674_3)

								iter_674_5.color = Color.New(var_674_4, var_674_4, var_674_4)
							end
						end
					end
				end
			end

			if arg_671_1.time_ >= 0 + var_674_3 and arg_671_1.time_ < 0 + var_674_3 + arg_674_0 and not isNil(var_674_2) and arg_671_1.var_.actorSpriteComps10030 then
				for iter_674_6, iter_674_7 in pairs(arg_671_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_674_7 then
						iter_674_7.color = arg_671_1.isInRecall_ and (arg_671_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_671_1.var_.actorSpriteComps10030 = nil
			end

			local var_674_5 = 0
			local var_674_6 = 0.775

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= var_674_5 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				arg_671_1.leftNameTxt_.text = arg_671_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_7 = arg_671_1:GetWordFromCfg(115311163)
				local var_674_8 = arg_671_1:FormatText(var_674_7.content)

				arg_671_1.text_.text = var_674_8

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_10 = 31 <= 0 and var_674_6 or var_674_6 * (utf8.len(var_674_8) / 31)

				if (31 <= 0 and var_674_6 or var_674_6 * (utf8.len(var_674_8) / 31)) > 0 and var_674_6 < var_674_10 then
					arg_671_1.talkMaxDuration = var_674_10

					if var_674_10 + var_674_5 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_10 + var_674_5
					end
				end

				arg_671_1.text_.text = var_674_8
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311163", "story_v_out_115311.awb") ~= 0 then
					local var_674_11 = manager.audio:GetVoiceLength("story_v_out_115311", "115311163", "story_v_out_115311.awb") / 1000

					if var_674_11 + var_674_5 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_11 + var_674_5
					end

					if var_674_7.prefab_name ~= "" and arg_671_1.actors_[var_674_7.prefab_name] ~= nil then
						local var_674_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_671_1.actors_[var_674_7.prefab_name].transform, "story_v_out_115311", "115311163", "story_v_out_115311.awb")

						arg_671_1:RecordAudio("115311163", var_674_12)
						arg_671_1:RecordAudio("115311163", var_674_12)
					else
						arg_671_1:AudioAction("play", "voice", "story_v_out_115311", "115311163", "story_v_out_115311.awb")
					end

					arg_671_1:RecordHistoryTalkVoice("story_v_out_115311", "115311163", "story_v_out_115311.awb")
				end

				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_13 = math.max(var_674_6, arg_671_1.talkMaxDuration)

			if var_674_5 <= arg_671_1.time_ and arg_671_1.time_ < var_674_5 + var_674_13 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_5) / var_674_13

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_5 + var_674_13 and arg_671_1.time_ < var_674_5 + var_674_13 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play115311164 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 115311164
		arg_675_1.duration_ = 17.7

		local var_675_0 = {
			ja = 10.666,
			ko = 16.4,
			zh = 17.3,
			en = 17.7
		}
		local var_675_1 = manager.audio:GetLocalizationFlag()

		if var_675_0[var_675_1] ~= nil then
			arg_675_1.duration_ = var_675_0[var_675_1]
		end

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play115311165(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = 1.475

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				arg_675_1.leftNameTxt_.text = arg_675_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_1 = arg_675_1:GetWordFromCfg(115311164)
				local var_678_2 = arg_675_1:FormatText(var_678_1.content)

				arg_675_1.text_.text = var_678_2

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_4 = 59 <= 0 and var_678_0 or var_678_0 * (utf8.len(var_678_2) / 59)

				if (59 <= 0 and var_678_0 or var_678_0 * (utf8.len(var_678_2) / 59)) > 0 and var_678_0 < var_678_4 then
					arg_675_1.talkMaxDuration = var_678_4

					if var_678_4 + 0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_4 + 0
					end
				end

				arg_675_1.text_.text = var_678_2
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311164", "story_v_out_115311.awb") ~= 0 then
					local var_678_5 = manager.audio:GetVoiceLength("story_v_out_115311", "115311164", "story_v_out_115311.awb") / 1000

					if var_678_5 + 0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_5 + 0
					end

					if var_678_1.prefab_name ~= "" and arg_675_1.actors_[var_678_1.prefab_name] ~= nil then
						local var_678_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_675_1.actors_[var_678_1.prefab_name].transform, "story_v_out_115311", "115311164", "story_v_out_115311.awb")

						arg_675_1:RecordAudio("115311164", var_678_6)
						arg_675_1:RecordAudio("115311164", var_678_6)
					else
						arg_675_1:AudioAction("play", "voice", "story_v_out_115311", "115311164", "story_v_out_115311.awb")
					end

					arg_675_1:RecordHistoryTalkVoice("story_v_out_115311", "115311164", "story_v_out_115311.awb")
				end

				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_7 = math.max(var_678_0, arg_675_1.talkMaxDuration)

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_7 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - 0) / var_678_7

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= 0 + var_678_7 and arg_675_1.time_ < 0 + var_678_7 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play115311165 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 115311165
		arg_679_1.duration_ = 7.53

		local var_679_0 = {
			ja = 6.6,
			ko = 7.533,
			zh = 5.933,
			en = 7
		}
		local var_679_1 = manager.audio:GetLocalizationFlag()

		if var_679_0[var_679_1] ~= nil then
			arg_679_1.duration_ = var_679_0[var_679_1]
		end

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play115311166(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 and not isNil(arg_679_1.actors_["1038"]) and arg_679_1.var_.actorSpriteComps1038 == nil then
				arg_679_1.var_.actorSpriteComps1038 = arg_679_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_682_0 = 0.2

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_0 and not isNil(arg_679_1.actors_["1038"]) then
				if arg_679_1.var_.actorSpriteComps1038 then
					for iter_682_0, iter_682_1 in pairs(arg_679_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_682_1 then
							if arg_679_1.isInRecall_ then
								iter_682_1.color = Color.New(Mathf.Lerp(iter_682_1.color.r, arg_679_1.hightColor2.r, (arg_679_1.time_ - 0) / var_682_0), Mathf.Lerp(iter_682_1.color.g, arg_679_1.hightColor2.g, (arg_679_1.time_ - 0) / var_682_0), (Mathf.Lerp(iter_682_1.color.b, arg_679_1.hightColor2.b, (arg_679_1.time_ - 0) / var_682_0)))
							else
								local var_682_1 = Mathf.Lerp(iter_682_1.color.r, 0.5, (arg_679_1.time_ - 0) / var_682_0)

								iter_682_1.color = Color.New(var_682_1, var_682_1, var_682_1)
							end
						end
					end
				end
			end

			if arg_679_1.time_ >= 0 + var_682_0 and arg_679_1.time_ < 0 + var_682_0 + arg_682_0 and not isNil(arg_679_1.actors_["1038"]) and arg_679_1.var_.actorSpriteComps1038 then
				for iter_682_2, iter_682_3 in pairs(arg_679_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_682_3 then
						iter_682_3.color = arg_679_1.isInRecall_ and (arg_679_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_679_1.var_.actorSpriteComps1038 = nil
			end

			local var_682_2 = arg_679_1.actors_["10030"]

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 and not isNil(var_682_2) and arg_679_1.var_.actorSpriteComps10030 == nil then
				arg_679_1.var_.actorSpriteComps10030 = var_682_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_682_3 = 0.2

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_3 and not isNil(var_682_2) then
				if arg_679_1.var_.actorSpriteComps10030 then
					for iter_682_4, iter_682_5 in pairs(arg_679_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_682_5 then
							if arg_679_1.isInRecall_ then
								iter_682_5.color = Color.New(Mathf.Lerp(iter_682_5.color.r, arg_679_1.hightColor1.r, (arg_679_1.time_ - 0) / var_682_3), Mathf.Lerp(iter_682_5.color.g, arg_679_1.hightColor1.g, (arg_679_1.time_ - 0) / var_682_3), (Mathf.Lerp(iter_682_5.color.b, arg_679_1.hightColor1.b, (arg_679_1.time_ - 0) / var_682_3)))
							else
								local var_682_4 = Mathf.Lerp(iter_682_5.color.r, 1, (arg_679_1.time_ - 0) / var_682_3)

								iter_682_5.color = Color.New(var_682_4, var_682_4, var_682_4)
							end
						end
					end
				end
			end

			if arg_679_1.time_ >= 0 + var_682_3 and arg_679_1.time_ < 0 + var_682_3 + arg_682_0 and not isNil(var_682_2) and arg_679_1.var_.actorSpriteComps10030 then
				for iter_682_6, iter_682_7 in pairs(arg_679_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_682_7 then
						iter_682_7.color = arg_679_1.isInRecall_ and (arg_679_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_679_1.var_.actorSpriteComps10030 = nil
			end

			local var_682_5 = 0
			local var_682_6 = 0.55

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_5 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				arg_679_1.leftNameTxt_.text = arg_679_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_7 = arg_679_1:GetWordFromCfg(115311165)
				local var_682_8 = arg_679_1:FormatText(var_682_7.content)

				arg_679_1.text_.text = var_682_8

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_10 = 22 <= 0 and var_682_6 or var_682_6 * (utf8.len(var_682_8) / 22)

				if (22 <= 0 and var_682_6 or var_682_6 * (utf8.len(var_682_8) / 22)) > 0 and var_682_6 < var_682_10 then
					arg_679_1.talkMaxDuration = var_682_10

					if var_682_10 + var_682_5 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_10 + var_682_5
					end
				end

				arg_679_1.text_.text = var_682_8
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311165", "story_v_out_115311.awb") ~= 0 then
					local var_682_11 = manager.audio:GetVoiceLength("story_v_out_115311", "115311165", "story_v_out_115311.awb") / 1000

					if var_682_11 + var_682_5 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_11 + var_682_5
					end

					if var_682_7.prefab_name ~= "" and arg_679_1.actors_[var_682_7.prefab_name] ~= nil then
						local var_682_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_679_1.actors_[var_682_7.prefab_name].transform, "story_v_out_115311", "115311165", "story_v_out_115311.awb")

						arg_679_1:RecordAudio("115311165", var_682_12)
						arg_679_1:RecordAudio("115311165", var_682_12)
					else
						arg_679_1:AudioAction("play", "voice", "story_v_out_115311", "115311165", "story_v_out_115311.awb")
					end

					arg_679_1:RecordHistoryTalkVoice("story_v_out_115311", "115311165", "story_v_out_115311.awb")
				end

				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_13 = math.max(var_682_6, arg_679_1.talkMaxDuration)

			if var_682_5 <= arg_679_1.time_ and arg_679_1.time_ < var_682_5 + var_682_13 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_5) / var_682_13

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_5 + var_682_13 and arg_679_1.time_ < var_682_5 + var_682_13 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play115311166 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 115311166
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play115311167(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 and not isNil(arg_683_1.actors_["10030"]) and arg_683_1.var_.actorSpriteComps10030 == nil then
				arg_683_1.var_.actorSpriteComps10030 = arg_683_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_686_0 = 0.2

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_0 and not isNil(arg_683_1.actors_["10030"]) then
				if arg_683_1.var_.actorSpriteComps10030 then
					for iter_686_0, iter_686_1 in pairs(arg_683_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_686_1 then
							if arg_683_1.isInRecall_ then
								iter_686_1.color = Color.New(Mathf.Lerp(iter_686_1.color.r, arg_683_1.hightColor2.r, (arg_683_1.time_ - 0) / var_686_0), Mathf.Lerp(iter_686_1.color.g, arg_683_1.hightColor2.g, (arg_683_1.time_ - 0) / var_686_0), (Mathf.Lerp(iter_686_1.color.b, arg_683_1.hightColor2.b, (arg_683_1.time_ - 0) / var_686_0)))
							else
								local var_686_1 = Mathf.Lerp(iter_686_1.color.r, 0.5, (arg_683_1.time_ - 0) / var_686_0)

								iter_686_1.color = Color.New(var_686_1, var_686_1, var_686_1)
							end
						end
					end
				end
			end

			if arg_683_1.time_ >= 0 + var_686_0 and arg_683_1.time_ < 0 + var_686_0 + arg_686_0 and not isNil(arg_683_1.actors_["10030"]) and arg_683_1.var_.actorSpriteComps10030 then
				for iter_686_2, iter_686_3 in pairs(arg_683_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_686_3 then
						iter_686_3.color = arg_683_1.isInRecall_ and (arg_683_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_683_1.var_.actorSpriteComps10030 = nil
			end

			local var_686_2 = 0
			local var_686_3 = 1

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_2 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, false)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_4 = arg_683_1:FormatText(arg_683_1:GetWordFromCfg(115311166).content)

				arg_683_1.text_.text = var_686_4

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_6 = 40 <= 0 and var_686_3 or var_686_3 * (utf8.len(var_686_4) / 40)

				if (40 <= 0 and var_686_3 or var_686_3 * (utf8.len(var_686_4) / 40)) > 0 and var_686_3 < var_686_6 then
					arg_683_1.talkMaxDuration = var_686_6

					if var_686_6 + var_686_2 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_6 + var_686_2
					end
				end

				arg_683_1.text_.text = var_686_4
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_7 = math.max(var_686_3, arg_683_1.talkMaxDuration)

			if var_686_2 <= arg_683_1.time_ and arg_683_1.time_ < var_686_2 + var_686_7 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_2) / var_686_7

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_2 + var_686_7 and arg_683_1.time_ < var_686_2 + var_686_7 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play115311167 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 115311167
		arg_687_1.duration_ = 4.07

		local var_687_0 = {
			ja = 3.866,
			ko = 3.4,
			zh = 2.666,
			en = 4.066
		}
		local var_687_1 = manager.audio:GetLocalizationFlag()

		if var_687_0[var_687_1] ~= nil then
			arg_687_1.duration_ = var_687_0[var_687_1]
		end

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play115311168(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 and not isNil(arg_687_1.actors_["10030"]) and arg_687_1.var_.actorSpriteComps10030 == nil then
				arg_687_1.var_.actorSpriteComps10030 = arg_687_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_690_0 = 0.2

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_0 and not isNil(arg_687_1.actors_["10030"]) then
				if arg_687_1.var_.actorSpriteComps10030 then
					for iter_690_0, iter_690_1 in pairs(arg_687_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_690_1 then
							if arg_687_1.isInRecall_ then
								iter_690_1.color = Color.New(Mathf.Lerp(iter_690_1.color.r, arg_687_1.hightColor1.r, (arg_687_1.time_ - 0) / var_690_0), Mathf.Lerp(iter_690_1.color.g, arg_687_1.hightColor1.g, (arg_687_1.time_ - 0) / var_690_0), (Mathf.Lerp(iter_690_1.color.b, arg_687_1.hightColor1.b, (arg_687_1.time_ - 0) / var_690_0)))
							else
								local var_690_1 = Mathf.Lerp(iter_690_1.color.r, 1, (arg_687_1.time_ - 0) / var_690_0)

								iter_690_1.color = Color.New(var_690_1, var_690_1, var_690_1)
							end
						end
					end
				end
			end

			if arg_687_1.time_ >= 0 + var_690_0 and arg_687_1.time_ < 0 + var_690_0 + arg_690_0 and not isNil(arg_687_1.actors_["10030"]) and arg_687_1.var_.actorSpriteComps10030 then
				for iter_690_2, iter_690_3 in pairs(arg_687_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_690_3 then
						iter_690_3.color = arg_687_1.isInRecall_ and (arg_687_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_687_1.var_.actorSpriteComps10030 = nil
			end

			local var_690_2 = arg_687_1.actors_["10030"].transform

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 then
				arg_687_1.var_.moveOldPos10030 = var_690_2.localPosition
				var_690_2.localScale = Vector3.New(1, 1, 1)

				arg_687_1:CheckSpriteTmpPos("10030", 4)

				for iter_690_4 = 0, var_690_2.childCount - 1 do
					local var_690_3 = var_690_2:GetChild(iter_690_4)

					if var_690_3.name == "split_1" or not string.find(var_690_3.name, "split") then
						var_690_3.gameObject:SetActive(true)
					else
						var_690_3.gameObject:SetActive(false)
					end
				end
			end

			local var_690_4 = 0.001

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_4 then
				var_690_2.localPosition = Vector3.Lerp(arg_687_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_687_1.time_ - 0) / var_690_4)
			end

			if arg_687_1.time_ >= 0 + var_690_4 and arg_687_1.time_ < 0 + var_690_4 + arg_690_0 then
				var_690_2.localPosition = Vector3.New(390, -390, 150)
			end

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 then
				local var_690_5 = arg_687_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_690_5 then
					arg_687_1.var_.alphaOldValue10030 = var_690_5.alpha
					arg_687_1.var_.characterEffect10030 = var_690_5
				end

				arg_687_1.var_.alphaOldValue10030 = 0
			end

			local var_690_6 = 0.0166666666666667

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_6 then
				if arg_687_1.var_.characterEffect10030 then
					arg_687_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_687_1.var_.alphaOldValue10030, 1, (arg_687_1.time_ - 0) / var_690_6)
				end
			end

			if arg_687_1.time_ >= 0 + var_690_6 and arg_687_1.time_ < 0 + var_690_6 + arg_690_0 and arg_687_1.var_.characterEffect10030 then
				arg_687_1.var_.characterEffect10030.alpha = 1
			end

			local var_690_7 = 0
			local var_690_8 = 0.35

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= var_690_7 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				arg_687_1.leftNameTxt_.text = arg_687_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_9 = arg_687_1:GetWordFromCfg(115311167)
				local var_690_10 = arg_687_1:FormatText(var_690_9.content)

				arg_687_1.text_.text = var_690_10

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_12 = 14 <= 0 and var_690_8 or var_690_8 * (utf8.len(var_690_10) / 14)

				if (14 <= 0 and var_690_8 or var_690_8 * (utf8.len(var_690_10) / 14)) > 0 and var_690_8 < var_690_12 then
					arg_687_1.talkMaxDuration = var_690_12

					if var_690_12 + var_690_7 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_12 + var_690_7
					end
				end

				arg_687_1.text_.text = var_690_10
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311167", "story_v_out_115311.awb") ~= 0 then
					local var_690_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311167", "story_v_out_115311.awb") / 1000

					if var_690_13 + var_690_7 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_13 + var_690_7
					end

					if var_690_9.prefab_name ~= "" and arg_687_1.actors_[var_690_9.prefab_name] ~= nil then
						local var_690_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_687_1.actors_[var_690_9.prefab_name].transform, "story_v_out_115311", "115311167", "story_v_out_115311.awb")

						arg_687_1:RecordAudio("115311167", var_690_14)
						arg_687_1:RecordAudio("115311167", var_690_14)
					else
						arg_687_1:AudioAction("play", "voice", "story_v_out_115311", "115311167", "story_v_out_115311.awb")
					end

					arg_687_1:RecordHistoryTalkVoice("story_v_out_115311", "115311167", "story_v_out_115311.awb")
				end

				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_15 = math.max(var_690_8, arg_687_1.talkMaxDuration)

			if var_690_7 <= arg_687_1.time_ and arg_687_1.time_ < var_690_7 + var_690_15 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_7) / var_690_15

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_7 + var_690_15 and arg_687_1.time_ < var_690_7 + var_690_15 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {
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

		arg_687_1:InitPlayNodeList()
	end,
	Play115311168 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 115311168
		arg_691_1.duration_ = 5

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play115311169(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 and not isNil(arg_691_1.actors_["10030"]) and arg_691_1.var_.actorSpriteComps10030 == nil then
				arg_691_1.var_.actorSpriteComps10030 = arg_691_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_694_0 = 0.2

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_0 and not isNil(arg_691_1.actors_["10030"]) then
				if arg_691_1.var_.actorSpriteComps10030 then
					for iter_694_0, iter_694_1 in pairs(arg_691_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_694_1 then
							if arg_691_1.isInRecall_ then
								iter_694_1.color = Color.New(Mathf.Lerp(iter_694_1.color.r, arg_691_1.hightColor2.r, (arg_691_1.time_ - 0) / var_694_0), Mathf.Lerp(iter_694_1.color.g, arg_691_1.hightColor2.g, (arg_691_1.time_ - 0) / var_694_0), (Mathf.Lerp(iter_694_1.color.b, arg_691_1.hightColor2.b, (arg_691_1.time_ - 0) / var_694_0)))
							else
								local var_694_1 = Mathf.Lerp(iter_694_1.color.r, 0.5, (arg_691_1.time_ - 0) / var_694_0)

								iter_694_1.color = Color.New(var_694_1, var_694_1, var_694_1)
							end
						end
					end
				end
			end

			if arg_691_1.time_ >= 0 + var_694_0 and arg_691_1.time_ < 0 + var_694_0 + arg_694_0 and not isNil(arg_691_1.actors_["10030"]) and arg_691_1.var_.actorSpriteComps10030 then
				for iter_694_2, iter_694_3 in pairs(arg_691_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_694_3 then
						iter_694_3.color = arg_691_1.isInRecall_ and (arg_691_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_691_1.var_.actorSpriteComps10030 = nil
			end

			local var_694_2 = 0
			local var_694_3 = 0.7

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_2 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, false)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_4 = arg_691_1:FormatText(arg_691_1:GetWordFromCfg(115311168).content)

				arg_691_1.text_.text = var_694_4

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_6 = 28 <= 0 and var_694_3 or var_694_3 * (utf8.len(var_694_4) / 28)

				if (28 <= 0 and var_694_3 or var_694_3 * (utf8.len(var_694_4) / 28)) > 0 and var_694_3 < var_694_6 then
					arg_691_1.talkMaxDuration = var_694_6

					if var_694_6 + var_694_2 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_6 + var_694_2
					end
				end

				arg_691_1.text_.text = var_694_4
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)
				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_7 = math.max(var_694_3, arg_691_1.talkMaxDuration)

			if var_694_2 <= arg_691_1.time_ and arg_691_1.time_ < var_694_2 + var_694_7 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_2) / var_694_7

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_2 + var_694_7 and arg_691_1.time_ < var_694_2 + var_694_7 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play115311169 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 115311169
		arg_695_1.duration_ = 3

		local var_695_0 = {
			ja = 3,
			ko = 1.666,
			zh = 2.866,
			en = 1.8
		}
		local var_695_1 = manager.audio:GetLocalizationFlag()

		if var_695_0[var_695_1] ~= nil then
			arg_695_1.duration_ = var_695_0[var_695_1]
		end

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play115311170(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 and not isNil(arg_695_1.actors_["1038"]) and arg_695_1.var_.actorSpriteComps1038 == nil then
				arg_695_1.var_.actorSpriteComps1038 = arg_695_1.actors_["1038"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_698_0 = 0.2

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_0 and not isNil(arg_695_1.actors_["1038"]) then
				if arg_695_1.var_.actorSpriteComps1038 then
					for iter_698_0, iter_698_1 in pairs(arg_695_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_698_1 then
							if arg_695_1.isInRecall_ then
								iter_698_1.color = Color.New(Mathf.Lerp(iter_698_1.color.r, arg_695_1.hightColor1.r, (arg_695_1.time_ - 0) / var_698_0), Mathf.Lerp(iter_698_1.color.g, arg_695_1.hightColor1.g, (arg_695_1.time_ - 0) / var_698_0), (Mathf.Lerp(iter_698_1.color.b, arg_695_1.hightColor1.b, (arg_695_1.time_ - 0) / var_698_0)))
							else
								local var_698_1 = Mathf.Lerp(iter_698_1.color.r, 1, (arg_695_1.time_ - 0) / var_698_0)

								iter_698_1.color = Color.New(var_698_1, var_698_1, var_698_1)
							end
						end
					end
				end
			end

			if arg_695_1.time_ >= 0 + var_698_0 and arg_695_1.time_ < 0 + var_698_0 + arg_698_0 and not isNil(arg_695_1.actors_["1038"]) and arg_695_1.var_.actorSpriteComps1038 then
				for iter_698_2, iter_698_3 in pairs(arg_695_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_698_3 then
						iter_698_3.color = arg_695_1.isInRecall_ and (arg_695_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_695_1.var_.actorSpriteComps1038 = nil
			end

			local var_698_2 = arg_695_1.actors_["1038"].transform

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 then
				arg_695_1.var_.moveOldPos1038 = var_698_2.localPosition
				var_698_2.localScale = Vector3.New(1, 1, 1)

				arg_695_1:CheckSpriteTmpPos("1038", 2)

				for iter_698_4 = 0, var_698_2.childCount - 1 do
					local var_698_3 = var_698_2:GetChild(iter_698_4)

					if var_698_3.name == "split_7" or not string.find(var_698_3.name, "split") then
						var_698_3.gameObject:SetActive(true)
					else
						var_698_3.gameObject:SetActive(false)
					end
				end
			end

			local var_698_4 = 0.001

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_4 then
				var_698_2.localPosition = Vector3.Lerp(arg_695_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_695_1.time_ - 0) / var_698_4)
			end

			if arg_695_1.time_ >= 0 + var_698_4 and arg_695_1.time_ < 0 + var_698_4 + arg_698_0 then
				var_698_2.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_698_5 = 0
			local var_698_6 = 0.2

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= var_698_5 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				arg_695_1.leftNameTxt_.text = arg_695_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_7 = arg_695_1:GetWordFromCfg(115311169)
				local var_698_8 = arg_695_1:FormatText(var_698_7.content)

				arg_695_1.text_.text = var_698_8

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_10 = 8 <= 0 and var_698_6 or var_698_6 * (utf8.len(var_698_8) / 8)

				if (8 <= 0 and var_698_6 or var_698_6 * (utf8.len(var_698_8) / 8)) > 0 and var_698_6 < var_698_10 then
					arg_695_1.talkMaxDuration = var_698_10

					if var_698_10 + var_698_5 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_10 + var_698_5
					end
				end

				arg_695_1.text_.text = var_698_8
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311169", "story_v_out_115311.awb") ~= 0 then
					local var_698_11 = manager.audio:GetVoiceLength("story_v_out_115311", "115311169", "story_v_out_115311.awb") / 1000

					if var_698_11 + var_698_5 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_11 + var_698_5
					end

					if var_698_7.prefab_name ~= "" and arg_695_1.actors_[var_698_7.prefab_name] ~= nil then
						local var_698_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_7.prefab_name].transform, "story_v_out_115311", "115311169", "story_v_out_115311.awb")

						arg_695_1:RecordAudio("115311169", var_698_12)
						arg_695_1:RecordAudio("115311169", var_698_12)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_out_115311", "115311169", "story_v_out_115311.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_out_115311", "115311169", "story_v_out_115311.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_13 = math.max(var_698_6, arg_695_1.talkMaxDuration)

			if var_698_5 <= arg_695_1.time_ and arg_695_1.time_ < var_698_5 + var_698_13 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_5) / var_698_13

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_5 + var_698_13 and arg_695_1.time_ < var_698_5 + var_698_13 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {
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

		arg_695_1:InitPlayNodeList()
	end,
	Play115311170 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 115311170
		arg_699_1.duration_ = 7.17

		local var_699_0 = {
			ja = 7.1,
			ko = 5.233,
			zh = 6.8,
			en = 7.166
		}
		local var_699_1 = manager.audio:GetLocalizationFlag()

		if var_699_0[var_699_1] ~= nil then
			arg_699_1.duration_ = var_699_0[var_699_1]
		end

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play115311171(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1.var_.moveOldPos10030 = arg_699_1.actors_["10030"].transform.localPosition
				arg_699_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_699_1:CheckSpriteTmpPos("10030", 4)

				for iter_702_0 = 0, arg_699_1.actors_["10030"].transform.childCount - 1 do
					local var_702_0 = arg_699_1.actors_["10030"].transform:GetChild(iter_702_0)

					if var_702_0.name == "split_3" or not string.find(var_702_0.name, "split") then
						var_702_0.gameObject:SetActive(true)
					else
						var_702_0.gameObject:SetActive(false)
					end
				end
			end

			local var_702_1 = 0.001

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_1 then
				arg_699_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_699_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_699_1.time_ - 0) / var_702_1)
			end

			if arg_699_1.time_ >= 0 + var_702_1 and arg_699_1.time_ < 0 + var_702_1 + arg_702_0 then
				arg_699_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_702_2 = arg_699_1.actors_["10030"]

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 and not isNil(var_702_2) and arg_699_1.var_.actorSpriteComps10030 == nil then
				arg_699_1.var_.actorSpriteComps10030 = var_702_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_702_3 = 0.2

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_3 and not isNil(var_702_2) then
				if arg_699_1.var_.actorSpriteComps10030 then
					for iter_702_1, iter_702_2 in pairs(arg_699_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_702_2 then
							if arg_699_1.isInRecall_ then
								iter_702_2.color = Color.New(Mathf.Lerp(iter_702_2.color.r, arg_699_1.hightColor1.r, (arg_699_1.time_ - 0) / var_702_3), Mathf.Lerp(iter_702_2.color.g, arg_699_1.hightColor1.g, (arg_699_1.time_ - 0) / var_702_3), (Mathf.Lerp(iter_702_2.color.b, arg_699_1.hightColor1.b, (arg_699_1.time_ - 0) / var_702_3)))
							else
								local var_702_4 = Mathf.Lerp(iter_702_2.color.r, 1, (arg_699_1.time_ - 0) / var_702_3)

								iter_702_2.color = Color.New(var_702_4, var_702_4, var_702_4)
							end
						end
					end
				end
			end

			if arg_699_1.time_ >= 0 + var_702_3 and arg_699_1.time_ < 0 + var_702_3 + arg_702_0 and not isNil(var_702_2) and arg_699_1.var_.actorSpriteComps10030 then
				for iter_702_3, iter_702_4 in pairs(arg_699_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_702_4 then
						iter_702_4.color = arg_699_1.isInRecall_ and (arg_699_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_699_1.var_.actorSpriteComps10030 = nil
			end

			local var_702_5 = arg_699_1.actors_["1038"]

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 and not isNil(var_702_5) and arg_699_1.var_.actorSpriteComps1038 == nil then
				arg_699_1.var_.actorSpriteComps1038 = var_702_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_702_6 = 0.2

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_6 and not isNil(var_702_5) then
				if arg_699_1.var_.actorSpriteComps1038 then
					for iter_702_5, iter_702_6 in pairs(arg_699_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_702_6 then
							if arg_699_1.isInRecall_ then
								iter_702_6.color = Color.New(Mathf.Lerp(iter_702_6.color.r, arg_699_1.hightColor2.r, (arg_699_1.time_ - 0) / var_702_6), Mathf.Lerp(iter_702_6.color.g, arg_699_1.hightColor2.g, (arg_699_1.time_ - 0) / var_702_6), (Mathf.Lerp(iter_702_6.color.b, arg_699_1.hightColor2.b, (arg_699_1.time_ - 0) / var_702_6)))
							else
								local var_702_7 = Mathf.Lerp(iter_702_6.color.r, 0.5, (arg_699_1.time_ - 0) / var_702_6)

								iter_702_6.color = Color.New(var_702_7, var_702_7, var_702_7)
							end
						end
					end
				end
			end

			if arg_699_1.time_ >= 0 + var_702_6 and arg_699_1.time_ < 0 + var_702_6 + arg_702_0 and not isNil(var_702_5) and arg_699_1.var_.actorSpriteComps1038 then
				for iter_702_7, iter_702_8 in pairs(arg_699_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_702_8 then
						iter_702_8.color = arg_699_1.isInRecall_ and (arg_699_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_699_1.var_.actorSpriteComps1038 = nil
			end

			local var_702_8 = 0
			local var_702_9 = 0.725

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_8 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				arg_699_1.leftNameTxt_.text = arg_699_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_10 = arg_699_1:GetWordFromCfg(115311170)
				local var_702_11 = arg_699_1:FormatText(var_702_10.content)

				arg_699_1.text_.text = var_702_11

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_13 = 29 <= 0 and var_702_9 or var_702_9 * (utf8.len(var_702_11) / 29)

				if (29 <= 0 and var_702_9 or var_702_9 * (utf8.len(var_702_11) / 29)) > 0 and var_702_9 < var_702_13 then
					arg_699_1.talkMaxDuration = var_702_13

					if var_702_13 + var_702_8 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_13 + var_702_8
					end
				end

				arg_699_1.text_.text = var_702_11
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311170", "story_v_out_115311.awb") ~= 0 then
					local var_702_14 = manager.audio:GetVoiceLength("story_v_out_115311", "115311170", "story_v_out_115311.awb") / 1000

					if var_702_14 + var_702_8 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_14 + var_702_8
					end

					if var_702_10.prefab_name ~= "" and arg_699_1.actors_[var_702_10.prefab_name] ~= nil then
						local var_702_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_10.prefab_name].transform, "story_v_out_115311", "115311170", "story_v_out_115311.awb")

						arg_699_1:RecordAudio("115311170", var_702_15)
						arg_699_1:RecordAudio("115311170", var_702_15)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_out_115311", "115311170", "story_v_out_115311.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_out_115311", "115311170", "story_v_out_115311.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_16 = math.max(var_702_9, arg_699_1.talkMaxDuration)

			if var_702_8 <= arg_699_1.time_ and arg_699_1.time_ < var_702_8 + var_702_16 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_8) / var_702_16

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_8 + var_702_16 and arg_699_1.time_ < var_702_8 + var_702_16 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {
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

		arg_699_1:InitPlayNodeList()
	end,
	Play115311171 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 115311171
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play115311172(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				local var_706_0 = arg_703_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_706_0 then
					arg_703_1.var_.alphaOldValue10030 = var_706_0.alpha
					arg_703_1.var_.characterEffect10030 = var_706_0
				end

				arg_703_1.var_.alphaOldValue10030 = 1
			end

			local var_706_1 = 0.5

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_1 then
				if arg_703_1.var_.characterEffect10030 then
					arg_703_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_703_1.var_.alphaOldValue10030, 0, (arg_703_1.time_ - 0) / var_706_1)
				end
			end

			if arg_703_1.time_ >= 0 + var_706_1 and arg_703_1.time_ < 0 + var_706_1 + arg_706_0 and arg_703_1.var_.characterEffect10030 then
				arg_703_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				local var_706_2 = arg_703_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_706_2 then
					arg_703_1.var_.alphaOldValue1038 = var_706_2.alpha
					arg_703_1.var_.characterEffect1038 = var_706_2
				end

				arg_703_1.var_.alphaOldValue1038 = 1
			end

			local var_706_3 = 0.5

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_3 then
				if arg_703_1.var_.characterEffect1038 then
					arg_703_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_703_1.var_.alphaOldValue1038, 0, (arg_703_1.time_ - 0) / var_706_3)
				end
			end

			if arg_703_1.time_ >= 0 + var_706_3 and arg_703_1.time_ < 0 + var_706_3 + arg_706_0 and arg_703_1.var_.characterEffect1038 then
				arg_703_1.var_.characterEffect1038.alpha = 0
			end

			local var_706_4 = 0
			local var_706_5 = 0.525

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_4 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, false)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_6 = arg_703_1:FormatText(arg_703_1:GetWordFromCfg(115311171).content)

				arg_703_1.text_.text = var_706_6

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_8 = 21 <= 0 and var_706_5 or var_706_5 * (utf8.len(var_706_6) / 21)

				if (21 <= 0 and var_706_5 or var_706_5 * (utf8.len(var_706_6) / 21)) > 0 and var_706_5 < var_706_8 then
					arg_703_1.talkMaxDuration = var_706_8

					if var_706_8 + var_706_4 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_8 + var_706_4
					end
				end

				arg_703_1.text_.text = var_706_6
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_9 = math.max(var_706_5, arg_703_1.talkMaxDuration)

			if var_706_4 <= arg_703_1.time_ and arg_703_1.time_ < var_706_4 + var_706_9 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_4) / var_706_9

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_4 + var_706_9 and arg_703_1.time_ < var_706_4 + var_706_9 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play115311172 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 115311172
		arg_707_1.duration_ = 4.17

		local var_707_0 = {
			ja = 4.166,
			ko = 3.033,
			zh = 3.7,
			en = 2.533
		}
		local var_707_1 = manager.audio:GetLocalizationFlag()

		if var_707_0[var_707_1] ~= nil then
			arg_707_1.duration_ = var_707_0[var_707_1]
		end

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play115311173(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1.var_.moveOldPos10030 = arg_707_1.actors_["10030"].transform.localPosition
				arg_707_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_707_1:CheckSpriteTmpPos("10030", 3)

				for iter_710_0 = 0, arg_707_1.actors_["10030"].transform.childCount - 1 do
					local var_710_0 = arg_707_1.actors_["10030"].transform:GetChild(iter_710_0)

					if var_710_0.name == "split_2" or not string.find(var_710_0.name, "split") then
						var_710_0.gameObject:SetActive(true)
					else
						var_710_0.gameObject:SetActive(false)
					end
				end
			end

			local var_710_1 = 0.001

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_1 then
				arg_707_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_707_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_707_1.time_ - 0) / var_710_1)
			end

			if arg_707_1.time_ >= 0 + var_710_1 and arg_707_1.time_ < 0 + var_710_1 + arg_710_0 then
				arg_707_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_710_2 = arg_707_1.actors_["10030"]

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 and not isNil(var_710_2) and arg_707_1.var_.actorSpriteComps10030 == nil then
				arg_707_1.var_.actorSpriteComps10030 = var_710_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_710_3 = 0.2

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_3 and not isNil(var_710_2) then
				if arg_707_1.var_.actorSpriteComps10030 then
					for iter_710_1, iter_710_2 in pairs(arg_707_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_710_2 then
							if arg_707_1.isInRecall_ then
								iter_710_2.color = Color.New(Mathf.Lerp(iter_710_2.color.r, arg_707_1.hightColor1.r, (arg_707_1.time_ - 0) / var_710_3), Mathf.Lerp(iter_710_2.color.g, arg_707_1.hightColor1.g, (arg_707_1.time_ - 0) / var_710_3), (Mathf.Lerp(iter_710_2.color.b, arg_707_1.hightColor1.b, (arg_707_1.time_ - 0) / var_710_3)))
							else
								local var_710_4 = Mathf.Lerp(iter_710_2.color.r, 1, (arg_707_1.time_ - 0) / var_710_3)

								iter_710_2.color = Color.New(var_710_4, var_710_4, var_710_4)
							end
						end
					end
				end
			end

			if arg_707_1.time_ >= 0 + var_710_3 and arg_707_1.time_ < 0 + var_710_3 + arg_710_0 and not isNil(var_710_2) and arg_707_1.var_.actorSpriteComps10030 then
				for iter_710_3, iter_710_4 in pairs(arg_707_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_710_4 then
						iter_710_4.color = arg_707_1.isInRecall_ and (arg_707_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_707_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				local var_710_5 = arg_707_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_710_5 then
					arg_707_1.var_.alphaOldValue10030 = var_710_5.alpha
					arg_707_1.var_.characterEffect10030 = var_710_5
				end

				arg_707_1.var_.alphaOldValue10030 = 0
			end

			local var_710_6 = 0.5

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_6 then
				if arg_707_1.var_.characterEffect10030 then
					arg_707_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_707_1.var_.alphaOldValue10030, 1, (arg_707_1.time_ - 0) / var_710_6)
				end
			end

			if arg_707_1.time_ >= 0 + var_710_6 and arg_707_1.time_ < 0 + var_710_6 + arg_710_0 and arg_707_1.var_.characterEffect10030 then
				arg_707_1.var_.characterEffect10030.alpha = 1
			end

			local var_710_7 = 0
			local var_710_8 = 0.25

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= var_710_7 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				arg_707_1.leftNameTxt_.text = arg_707_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_9 = arg_707_1:GetWordFromCfg(115311172)
				local var_710_10 = arg_707_1:FormatText(var_710_9.content)

				arg_707_1.text_.text = var_710_10

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_12 = 10 <= 0 and var_710_8 or var_710_8 * (utf8.len(var_710_10) / 10)

				if (10 <= 0 and var_710_8 or var_710_8 * (utf8.len(var_710_10) / 10)) > 0 and var_710_8 < var_710_12 then
					arg_707_1.talkMaxDuration = var_710_12

					if var_710_12 + var_710_7 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_12 + var_710_7
					end
				end

				arg_707_1.text_.text = var_710_10
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115311", "115311172", "story_v_out_115311.awb") ~= 0 then
					local var_710_13 = manager.audio:GetVoiceLength("story_v_out_115311", "115311172", "story_v_out_115311.awb") / 1000

					if var_710_13 + var_710_7 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_13 + var_710_7
					end

					if var_710_9.prefab_name ~= "" and arg_707_1.actors_[var_710_9.prefab_name] ~= nil then
						local var_710_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_707_1.actors_[var_710_9.prefab_name].transform, "story_v_out_115311", "115311172", "story_v_out_115311.awb")

						arg_707_1:RecordAudio("115311172", var_710_14)
						arg_707_1:RecordAudio("115311172", var_710_14)
					else
						arg_707_1:AudioAction("play", "voice", "story_v_out_115311", "115311172", "story_v_out_115311.awb")
					end

					arg_707_1:RecordHistoryTalkVoice("story_v_out_115311", "115311172", "story_v_out_115311.awb")
				end

				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_15 = math.max(var_710_8, arg_707_1.talkMaxDuration)

			if var_710_7 <= arg_707_1.time_ and arg_707_1.time_ < var_710_7 + var_710_15 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_7) / var_710_15

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_7 + var_710_15 and arg_707_1.time_ < var_710_7 + var_710_15 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {
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

		arg_707_1:InitPlayNodeList()
	end,
	Play115311173 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 115311173
		arg_711_1.duration_ = 4.5

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play115311174(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			if 1.966 < arg_711_1.time_ and arg_711_1.time_ <= 1.966 + arg_714_0 then
				arg_711_1.var_.moveOldPos10030 = arg_711_1.actors_["10030"].transform.localPosition
				arg_711_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_711_1:CheckSpriteTmpPos("10030", 7)

				for iter_714_0 = 0, arg_711_1.actors_["10030"].transform.childCount - 1 do
					local var_714_0 = arg_711_1.actors_["10030"].transform:GetChild(iter_714_0)

					if var_714_0.name == "split_2" or not string.find(var_714_0.name, "split") then
						var_714_0.gameObject:SetActive(true)
					else
						var_714_0.gameObject:SetActive(false)
					end
				end
			end

			local var_714_1 = 0.001

			if 1.966 <= arg_711_1.time_ and arg_711_1.time_ < 1.966 + var_714_1 then
				arg_711_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_711_1.var_.moveOldPos10030, Vector3.New(0, -2000, 150), (arg_711_1.time_ - 1.966) / var_714_1)
			end

			if arg_711_1.time_ >= 1.966 + var_714_1 and arg_711_1.time_ < 1.966 + var_714_1 + arg_714_0 then
				arg_711_1.actors_["10030"].transform.localPosition = Vector3.New(0, -2000, 150)
			end

			local var_714_2 = 0

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_2 + arg_714_0 then
				arg_711_1.mask_.enabled = true
				arg_711_1.mask_.raycastTarget = true

				arg_711_1:SetGaussion(false)
			end

			local var_714_3 = 2

			if var_714_2 <= arg_711_1.time_ and arg_711_1.time_ < var_714_2 + var_714_3 then
				local var_714_4 = Color.New(0, 0, 0)

				var_714_4.a = Mathf.Lerp(0, 1, (arg_711_1.time_ - var_714_2) / var_714_3)
				arg_711_1.mask_.color = var_714_4
			end

			if arg_711_1.time_ >= var_714_2 + var_714_3 and arg_711_1.time_ < var_714_2 + var_714_3 + arg_714_0 then
				local var_714_5 = Color.New(0, 0, 0)

				var_714_5.a = 1
				arg_711_1.mask_.color = var_714_5
			end

			local var_714_6 = 2

			if 2 < arg_711_1.time_ and arg_711_1.time_ <= var_714_6 + arg_714_0 then
				arg_711_1.mask_.enabled = true
				arg_711_1.mask_.raycastTarget = true

				arg_711_1:SetGaussion(false)
			end

			local var_714_7 = 2

			if var_714_6 <= arg_711_1.time_ and arg_711_1.time_ < var_714_6 + var_714_7 then
				local var_714_8 = Color.New(0, 0, 0)

				var_714_8.a = Mathf.Lerp(1, 0, (arg_711_1.time_ - var_714_6) / var_714_7)
				arg_711_1.mask_.color = var_714_8
			end

			if arg_711_1.time_ >= var_714_6 + var_714_7 and arg_711_1.time_ < var_714_6 + var_714_7 + arg_714_0 then
				local var_714_9 = Color.New(0, 0, 0)

				arg_711_1.mask_.enabled = false
				var_714_9.a = 0
				arg_711_1.mask_.color = var_714_9
			end

			if 2 < arg_711_1.time_ and arg_711_1.time_ <= 2 + arg_714_0 then
				arg_711_1.fswbg_:SetActive(true)
				arg_711_1.dialog_:SetActive(false)

				arg_711_1.fswtw_.percent = 0
				arg_711_1.fswt_.text = arg_711_1:FormatText(arg_711_1:GetWordFromCfg(115311173).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.fswt_)

				arg_711_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_711_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_711_1.fswtw_:SetDirty()

				arg_711_1.typewritterCharCountI18N = 0

				SetActive(arg_711_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_711_1:ShowNextGo(false)
			end

			local var_714_10 = 2.01666666666667

			if 2.01666666666667 < arg_711_1.time_ and arg_711_1.time_ <= var_714_10 + arg_714_0 then
				arg_711_1.var_.oldValueTypewriter = arg_711_1.fswtw_.percent

				SetActive(arg_711_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_711_1:ShowNextGo(false)
			end

			local var_714_11 = 22
			local var_714_12 = 1.46666666666667
			local var_714_13, var_714_14 = arg_711_1:GetPercentByPara(arg_711_1:FormatText(arg_711_1:GetWordFromCfg(115311173).content), 1)

			if var_714_10 < arg_711_1.time_ and arg_711_1.time_ <= var_714_10 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0

				local var_714_15 = var_714_11 <= 0 and var_714_12 or var_714_12 * ((var_714_14 - arg_711_1.typewritterCharCountI18N) / var_714_11)

				if (var_714_11 <= 0 and var_714_12 or var_714_12 * ((var_714_14 - arg_711_1.typewritterCharCountI18N) / var_714_11)) > 0 and var_714_12 < var_714_15 then
					arg_711_1.talkMaxDuration = var_714_15

					if var_714_15 + var_714_10 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_15 + var_714_10
					end
				end
			end

			local var_714_16 = math.max(1.46666666666667, arg_711_1.talkMaxDuration)

			if var_714_10 <= arg_711_1.time_ and arg_711_1.time_ < var_714_10 + var_714_16 then
				arg_711_1.fswtw_.percent = Mathf.Lerp(arg_711_1.var_.oldValueTypewriter, var_714_13, (arg_711_1.time_ - var_714_10) / var_714_16)
				arg_711_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_711_1.fswtw_:SetDirty()
			end

			if arg_711_1.time_ >= var_714_10 + var_714_16 and arg_711_1.time_ < var_714_10 + var_714_16 + arg_714_0 then
				arg_711_1.fswtw_.percent = var_714_13

				arg_711_1.fswtw_:SetDirty()
				arg_711_1:ShowNextGo(true)

				arg_711_1.typewritterCharCountI18N = var_714_14
			end

			if 2 < arg_711_1.time_ and arg_711_1.time_ <= 2 + arg_714_0 then
				local var_714_17 = arg_711_1.fswbg_.transform:Find("textbox/adapt/content") or arg_711_1.fswbg_.transform:Find("textbox/content")
				local var_714_18 = arg_711_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_714_19 = var_714_17:GetComponent("RectTransform")

				var_714_17:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_714_19.offsetMin = Vector2.New(0, 0)
				var_714_19.offsetMax = Vector2.New(0, 0)
			end

			if 2.01666666666667 < arg_711_1.time_ and arg_711_1.time_ <= 2.01666666666667 + arg_714_0 then
				local var_714_20 = arg_711_1.bgs_.ST22a

				arg_711_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_714_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_714_21 = var_714_20:GetComponent("SpriteRenderer")

				if var_714_21 and var_714_21.sprite then
					local var_714_22 = 2 * (var_714_20.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_714_20.transform.localScale = Vector3.New(var_714_22 / var_714_21.sprite.bounds.size.y < var_714_22 * manager.ui.mainCameraCom_.aspect / var_714_21.sprite.bounds.size.x and var_714_22 * manager.ui.mainCameraCom_.aspect / var_714_21.sprite.bounds.size.x or var_714_22 / var_714_21.sprite.bounds.size.y, var_714_22 / var_714_21.sprite.bounds.size.y < var_714_22 * manager.ui.mainCameraCom_.aspect / var_714_21.sprite.bounds.size.x and var_714_22 * manager.ui.mainCameraCom_.aspect / var_714_21.sprite.bounds.size.x or var_714_22 / var_714_21.sprite.bounds.size.y, 0)
				end

				for iter_714_1, iter_714_2 in pairs(arg_711_1.bgs_) do
					if iter_714_1 ~= "ST22a" then
						iter_714_2.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_711_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_711_1:InitPlayNodeList()
	end,
	Play115311174 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 115311174
		arg_715_1.duration_ = 1

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play115311175(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 then
				arg_715_1.var_.oldValueTypewriter = arg_715_1.fswtw_.percent

				SetActive(arg_715_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_715_1:ShowNextGo(false)
			end

			local var_718_0 = 10
			local var_718_1 = 0.666666666666667
			local var_718_2, var_718_3 = arg_715_1:GetPercentByPara(arg_715_1:FormatText(arg_715_1:GetWordFromCfg(115311173).content), 2)

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0

				local var_718_4 = var_718_0 <= 0 and var_718_1 or var_718_1 * ((var_718_3 - arg_715_1.typewritterCharCountI18N) / var_718_0)

				if (var_718_0 <= 0 and var_718_1 or var_718_1 * ((var_718_3 - arg_715_1.typewritterCharCountI18N) / var_718_0)) > 0 and var_718_1 < var_718_4 then
					arg_715_1.talkMaxDuration = var_718_4

					if var_718_4 + 0 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_4 + 0
					end
				end
			end

			local var_718_5 = math.max(0.666666666666667, arg_715_1.talkMaxDuration)

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_5 then
				arg_715_1.fswtw_.percent = Mathf.Lerp(arg_715_1.var_.oldValueTypewriter, var_718_2, (arg_715_1.time_ - 0) / var_718_5)
				arg_715_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_715_1.fswtw_:SetDirty()
			end

			if arg_715_1.time_ >= 0 + var_718_5 and arg_715_1.time_ < 0 + var_718_5 + arg_718_0 then
				arg_715_1.fswtw_.percent = var_718_2

				arg_715_1.fswtw_:SetDirty()
				arg_715_1:ShowNextGo(true)

				arg_715_1.typewritterCharCountI18N = var_718_3
			end
		end

		arg_715_1.nodeConfigList_ = {}

		arg_715_1:InitPlayNodeList()
	end,
	Play115311175 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 115311175
		arg_719_1.duration_ = 2.95

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play115311176(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			if 2 < arg_719_1.time_ and arg_719_1.time_ <= 2 + arg_722_0 then
				arg_719_1.fswbg_:SetActive(true)
				arg_719_1.dialog_:SetActive(false)

				arg_719_1.fswtw_.percent = 0
				arg_719_1.fswt_.text = arg_719_1:FormatText(arg_719_1:GetWordFromCfg(115311175).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.fswt_)

				arg_719_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_719_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_719_1.fswtw_:SetDirty()

				arg_719_1.typewritterCharCountI18N = 0

				SetActive(arg_719_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_719_1:ShowNextGo(false)
			end

			local var_722_0 = 2.01666666666667

			if 2.01666666666667 < arg_719_1.time_ and arg_719_1.time_ <= var_722_0 + arg_722_0 then
				arg_719_1.var_.oldValueTypewriter = arg_719_1.fswtw_.percent

				SetActive(arg_719_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_719_1:ShowNextGo(false)
			end

			local var_722_1 = 14
			local var_722_2 = 0.933333333333333
			local var_722_3, var_722_4 = arg_719_1:GetPercentByPara(arg_719_1:FormatText(arg_719_1:GetWordFromCfg(115311175).content), 1)

			if var_722_0 < arg_719_1.time_ and arg_719_1.time_ <= var_722_0 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0

				local var_722_5 = var_722_1 <= 0 and var_722_2 or var_722_2 * ((var_722_4 - arg_719_1.typewritterCharCountI18N) / var_722_1)

				if (var_722_1 <= 0 and var_722_2 or var_722_2 * ((var_722_4 - arg_719_1.typewritterCharCountI18N) / var_722_1)) > 0 and var_722_2 < var_722_5 then
					arg_719_1.talkMaxDuration = var_722_5

					if var_722_5 + var_722_0 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_5 + var_722_0
					end
				end
			end

			local var_722_6 = math.max(0.933333333333333, arg_719_1.talkMaxDuration)

			if var_722_0 <= arg_719_1.time_ and arg_719_1.time_ < var_722_0 + var_722_6 then
				arg_719_1.fswtw_.percent = Mathf.Lerp(arg_719_1.var_.oldValueTypewriter, var_722_3, (arg_719_1.time_ - var_722_0) / var_722_6)
				arg_719_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_719_1.fswtw_:SetDirty()
			end

			if arg_719_1.time_ >= var_722_0 + var_722_6 and arg_719_1.time_ < var_722_0 + var_722_6 + arg_722_0 then
				arg_719_1.fswtw_.percent = var_722_3

				arg_719_1.fswtw_:SetDirty()
				arg_719_1:ShowNextGo(true)

				arg_719_1.typewritterCharCountI18N = var_722_4
			end

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 then
				local var_722_7 = arg_719_1.bgs_.ST22a:GetComponent("SpriteRenderer")

				if var_722_7 then
					arg_719_1.var_.alphaOldValueST22a = var_722_7.color.a
					arg_719_1.var_.alphaMatValueST22a = var_722_7
				end

				arg_719_1.var_.alphaOldValueST22a = 1
			end

			local var_722_8 = 2

			if 0 <= arg_719_1.time_ and arg_719_1.time_ < 0 + var_722_8 then
				if arg_719_1.var_.alphaMatValueST22a then
					arg_719_1.var_.alphaMatValueST22a.color.a = Mathf.Lerp(arg_719_1.var_.alphaOldValueST22a, 0, (arg_719_1.time_ - 0) / var_722_8)
					arg_719_1.var_.alphaMatValueST22a.color = arg_719_1.var_.alphaMatValueST22a.color
				end
			end

			if arg_719_1.time_ >= 0 + var_722_8 and arg_719_1.time_ < 0 + var_722_8 + arg_722_0 and arg_719_1.var_.alphaMatValueST22a then
				arg_719_1.var_.alphaMatValueST22a.color.a = 0
				arg_719_1.var_.alphaMatValueST22a.color = arg_719_1.var_.alphaMatValueST22a.color
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	Play115311176 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 115311176
		arg_723_1.duration_ = 1

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play115311177(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			if 0 < arg_723_1.time_ and arg_723_1.time_ <= 0 + arg_726_0 then
				arg_723_1.var_.oldValueTypewriter = arg_723_1.fswtw_.percent

				SetActive(arg_723_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_723_1:ShowNextGo(false)
			end

			local var_726_0 = 14
			local var_726_1 = 0.933333333333333
			local var_726_2, var_726_3 = arg_723_1:GetPercentByPara(arg_723_1:FormatText(arg_723_1:GetWordFromCfg(115311175).content), 2)

			if 0 < arg_723_1.time_ and arg_723_1.time_ <= 0 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0

				local var_726_4 = var_726_0 <= 0 and var_726_1 or var_726_1 * ((var_726_3 - arg_723_1.typewritterCharCountI18N) / var_726_0)

				if (var_726_0 <= 0 and var_726_1 or var_726_1 * ((var_726_3 - arg_723_1.typewritterCharCountI18N) / var_726_0)) > 0 and var_726_1 < var_726_4 then
					arg_723_1.talkMaxDuration = var_726_4

					if var_726_4 + 0 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_4 + 0
					end
				end
			end

			local var_726_5 = math.max(0.933333333333333, arg_723_1.talkMaxDuration)

			if 0 <= arg_723_1.time_ and arg_723_1.time_ < 0 + var_726_5 then
				arg_723_1.fswtw_.percent = Mathf.Lerp(arg_723_1.var_.oldValueTypewriter, var_726_2, (arg_723_1.time_ - 0) / var_726_5)
				arg_723_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_723_1.fswtw_:SetDirty()
			end

			if arg_723_1.time_ >= 0 + var_726_5 and arg_723_1.time_ < 0 + var_726_5 + arg_726_0 then
				arg_723_1.fswtw_.percent = var_726_2

				arg_723_1.fswtw_:SetDirty()
				arg_723_1:ShowNextGo(true)

				arg_723_1.typewritterCharCountI18N = var_726_3
			end
		end

		arg_723_1.nodeConfigList_ = {}

		arg_723_1:InitPlayNodeList()
	end,
	Play115311177 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 115311177
		arg_727_1.duration_ = 1

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play115311178(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 then
				arg_727_1.var_.oldValueTypewriter = arg_727_1.fswtw_.percent

				SetActive(arg_727_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_727_1:ShowNextGo(false)
			end

			local var_730_0 = 14
			local var_730_1 = 0.933333333333333
			local var_730_2, var_730_3 = arg_727_1:GetPercentByPara(arg_727_1:FormatText(arg_727_1:GetWordFromCfg(115311175).content), 3)

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0

				local var_730_4 = var_730_0 <= 0 and var_730_1 or var_730_1 * ((var_730_3 - arg_727_1.typewritterCharCountI18N) / var_730_0)

				if (var_730_0 <= 0 and var_730_1 or var_730_1 * ((var_730_3 - arg_727_1.typewritterCharCountI18N) / var_730_0)) > 0 and var_730_1 < var_730_4 then
					arg_727_1.talkMaxDuration = var_730_4

					if var_730_4 + 0 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_4 + 0
					end
				end
			end

			local var_730_5 = math.max(0.933333333333333, arg_727_1.talkMaxDuration)

			if 0 <= arg_727_1.time_ and arg_727_1.time_ < 0 + var_730_5 then
				arg_727_1.fswtw_.percent = Mathf.Lerp(arg_727_1.var_.oldValueTypewriter, var_730_2, (arg_727_1.time_ - 0) / var_730_5)
				arg_727_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_727_1.fswtw_:SetDirty()
			end

			if arg_727_1.time_ >= 0 + var_730_5 and arg_727_1.time_ < 0 + var_730_5 + arg_730_0 then
				arg_727_1.fswtw_.percent = var_730_2

				arg_727_1.fswtw_:SetDirty()
				arg_727_1:ShowNextGo(true)

				arg_727_1.typewritterCharCountI18N = var_730_3
			end
		end

		arg_727_1.nodeConfigList_ = {}

		arg_727_1:InitPlayNodeList()
	end,
	Play115311178 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 115311178
		arg_731_1.duration_ = 1

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play115311179(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1.var_.oldValueTypewriter = arg_731_1.fswtw_.percent

				SetActive(arg_731_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_731_1:ShowNextGo(false)
			end

			local var_734_0 = 14
			local var_734_1 = 0.933333333333333
			local var_734_2, var_734_3 = arg_731_1:GetPercentByPara(arg_731_1:FormatText(arg_731_1:GetWordFromCfg(115311175).content), 4)

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0

				local var_734_4 = var_734_0 <= 0 and var_734_1 or var_734_1 * ((var_734_3 - arg_731_1.typewritterCharCountI18N) / var_734_0)

				if (var_734_0 <= 0 and var_734_1 or var_734_1 * ((var_734_3 - arg_731_1.typewritterCharCountI18N) / var_734_0)) > 0 and var_734_1 < var_734_4 then
					arg_731_1.talkMaxDuration = var_734_4

					if var_734_4 + 0 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_4 + 0
					end
				end
			end

			local var_734_5 = math.max(0.933333333333333, arg_731_1.talkMaxDuration)

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_5 then
				arg_731_1.fswtw_.percent = Mathf.Lerp(arg_731_1.var_.oldValueTypewriter, var_734_2, (arg_731_1.time_ - 0) / var_734_5)
				arg_731_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_731_1.fswtw_:SetDirty()
			end

			if arg_731_1.time_ >= 0 + var_734_5 and arg_731_1.time_ < 0 + var_734_5 + arg_734_0 then
				arg_731_1.fswtw_.percent = var_734_2

				arg_731_1.fswtw_:SetDirty()
				arg_731_1:ShowNextGo(true)

				arg_731_1.typewritterCharCountI18N = var_734_3
			end
		end

		arg_731_1.nodeConfigList_ = {}

		arg_731_1:InitPlayNodeList()
	end,
	Play115311179 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 115311179
		arg_735_1.duration_ = 1

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
			arg_735_1.auto_ = false
		end

		function arg_735_1.playNext_(arg_737_0)
			arg_735_1.onStoryFinished_()
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			if 0 < arg_735_1.time_ and arg_735_1.time_ <= 0 + arg_738_0 then
				arg_735_1.var_.oldValueTypewriter = arg_735_1.fswtw_.percent

				SetActive(arg_735_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_735_1:ShowNextGo(false)
			end

			local var_738_0 = 14
			local var_738_1 = 0.933333333333333
			local var_738_2, var_738_3 = arg_735_1:GetPercentByPara(arg_735_1:FormatText(arg_735_1:GetWordFromCfg(115311175).content), 5)

			if 0 < arg_735_1.time_ and arg_735_1.time_ <= 0 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0

				local var_738_4 = var_738_0 <= 0 and var_738_1 or var_738_1 * ((var_738_3 - arg_735_1.typewritterCharCountI18N) / var_738_0)

				if (var_738_0 <= 0 and var_738_1 or var_738_1 * ((var_738_3 - arg_735_1.typewritterCharCountI18N) / var_738_0)) > 0 and var_738_1 < var_738_4 then
					arg_735_1.talkMaxDuration = var_738_4

					if var_738_4 + 0 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_4 + 0
					end
				end
			end

			local var_738_5 = math.max(0.933333333333333, arg_735_1.talkMaxDuration)

			if 0 <= arg_735_1.time_ and arg_735_1.time_ < 0 + var_738_5 then
				arg_735_1.fswtw_.percent = Mathf.Lerp(arg_735_1.var_.oldValueTypewriter, var_738_2, (arg_735_1.time_ - 0) / var_738_5)
				arg_735_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_735_1.fswtw_:SetDirty()
			end

			if arg_735_1.time_ >= 0 + var_738_5 and arg_735_1.time_ < 0 + var_738_5 + arg_738_0 then
				arg_735_1.fswtw_.percent = var_738_2

				arg_735_1.fswtw_:SetDirty()
				arg_735_1:ShowNextGo(true)

				arg_735_1.typewritterCharCountI18N = var_738_3
			end
		end

		arg_735_1.nodeConfigList_ = {}

		arg_735_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST22a",
		"TextureConfig/Background/ST28a",
		"TextureConfig/Background/F01a"
	},
	voices = {
		"story_v_out_115311.awb"
	}
}
