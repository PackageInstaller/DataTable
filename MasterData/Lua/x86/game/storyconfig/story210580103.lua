return {
	Play1105803001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1105803001
		arg_1_1.duration_ = 11.8

		local var_1_0 = {
			zh = 8.76666666666667,
			ja = 11.7996666666667
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
				arg_1_0:Play1105803002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST59a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST59a")
				var_4_0.name = "ST59a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST59a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST59a

				arg_1_1.bgs_.ST59a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST59a" then
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_crowd_loop", "")
			end

			local var_4_15 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_15 + 0.3 and arg_1_1.time_ < var_4_15 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 1.96666666666667
			local var_4_17 = 0.7

			if 1.96666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[396].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:GetWordFromCfg(1105803001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 28 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 28)

				if (28 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 28)) > 0 and var_4_17 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_16 = var_4_16 + 0.3

					if var_4_22 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803001", "story_v_side_new_1105803.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803001", "story_v_side_new_1105803.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_side_new_1105803", "1105803001", "story_v_side_new_1105803.awb")

						arg_1_1:RecordAudio("1105803001", var_4_24)
						arg_1_1:RecordAudio("1105803001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803001", "story_v_side_new_1105803.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803001", "story_v_side_new_1105803.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_16 + 0.3
			local var_4_26 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1105803002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1105803002
		arg_9_1.duration_ = 8.33

		local var_9_0 = {
			zh = 6.466,
			ja = 8.333
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
				arg_9_0:Play1105803003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.675

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[396].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(1105803002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 27 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 27)

				if (27 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 27)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803002", "story_v_side_new_1105803.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803002", "story_v_side_new_1105803.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_side_new_1105803", "1105803002", "story_v_side_new_1105803.awb")

						arg_9_1:RecordAudio("1105803002", var_12_6)
						arg_9_1:RecordAudio("1105803002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803002", "story_v_side_new_1105803.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803002", "story_v_side_new_1105803.awb")
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
	Play1105803003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1105803003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1105803004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.1

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1105803003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 44 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 44)

				if (44 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 44)) > 0 and var_16_0 < var_16_3 then
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
	Play1105803004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1105803004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1105803005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.025

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1105803004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 41 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 41)

				if (41 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 41)) > 0 and var_20_0 < var_20_3 then
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
	Play1105803005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1105803005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1105803006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.5

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1105803005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 20 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 20)

				if (20 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 20)) > 0 and var_24_0 < var_24_3 then
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
	Play1105803006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1105803006
		arg_25_1.duration_ = 6.03

		local var_25_0 = {
			zh = 2,
			ja = 6.033
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
				arg_25_0:Play1105803007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "1058ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1058ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["1058ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["1058ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["1058ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["1058ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1058ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0, -0.95, -5.88)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["1058ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1058ui_story == nil then
				arg_25_1.var_.characterEffect1058ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect1058ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1058ui_story then
				arg_25_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_8 = 0
			local var_28_9 = 0.25

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(1105803006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 10 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 10)

				if (10 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 10)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803006", "story_v_side_new_1105803.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803006", "story_v_side_new_1105803.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_side_new_1105803", "1105803006", "story_v_side_new_1105803.awb")

						arg_25_1:RecordAudio("1105803006", var_28_15)
						arg_25_1:RecordAudio("1105803006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803006", "story_v_side_new_1105803.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803006", "story_v_side_new_1105803.awb")
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
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play1105803007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1105803007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1105803008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1058ui_story"]) and arg_29_1.var_.characterEffect1058ui_story == nil then
				arg_29_1.var_.characterEffect1058ui_story = arg_29_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1058ui_story"]) then
				if arg_29_1.var_.characterEffect1058ui_story and not isNil(arg_29_1.actors_["1058ui_story"]) then
					arg_29_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1058ui_story"]) and arg_29_1.var_.characterEffect1058ui_story then
				arg_29_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.475

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1105803007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 19 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 19)

				if (19 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 19)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1105803008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1105803008
		arg_33_1.duration_ = 2.13

		local var_33_0 = {
			zh = 1.999999999999,
			ja = 2.133
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
				arg_33_0:Play1105803009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1058ui_story = arg_33_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1058ui_story"].transform.position).z)
				arg_33_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1058ui_story"].transform.localEulerAngles = arg_33_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_33_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1058ui_story"].transform.position).z)
				arg_33_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1058ui_story"].transform.localEulerAngles = arg_33_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1058ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1058ui_story == nil then
				arg_33_1.var_.characterEffect1058ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1058ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1058ui_story then
				arg_33_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_36_4 = 0
			local var_36_5 = 0.125

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(1105803008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 5 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 5)

				if (5 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 5)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803008", "story_v_side_new_1105803.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803008", "story_v_side_new_1105803.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_side_new_1105803", "1105803008", "story_v_side_new_1105803.awb")

						arg_33_1:RecordAudio("1105803008", var_36_11)
						arg_33_1:RecordAudio("1105803008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803008", "story_v_side_new_1105803.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803008", "story_v_side_new_1105803.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play1105803009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1105803009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1105803010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1058ui_story"]) and arg_37_1.var_.characterEffect1058ui_story == nil then
				arg_37_1.var_.characterEffect1058ui_story = arg_37_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1058ui_story"]) then
				if arg_37_1.var_.characterEffect1058ui_story and not isNil(arg_37_1.actors_["1058ui_story"]) then
					arg_37_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1058ui_story"]) and arg_37_1.var_.characterEffect1058ui_story then
				arg_37_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.3

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1105803009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 12 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 12)

				if (12 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 12)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1105803010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1105803010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1105803011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.575

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
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

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(1105803010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 23 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 23)

				if (23 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 23)) > 0 and var_44_0 < var_44_3 then
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
	Play1105803011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1105803011
		arg_45_1.duration_ = 2

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1105803012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1058ui_story = arg_45_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).z)
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles = arg_45_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_45_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1058ui_story"].transform.position).z)
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1058ui_story"].transform.localEulerAngles = arg_45_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1058ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1058ui_story == nil then
				arg_45_1.var_.characterEffect1058ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1058ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1058ui_story then
				arg_45_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_48_4 = 0
			local var_48_5 = 0.15

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(1105803011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 6 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 6)

				if (6 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 6)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803011", "story_v_side_new_1105803.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803011", "story_v_side_new_1105803.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_side_new_1105803", "1105803011", "story_v_side_new_1105803.awb")

						arg_45_1:RecordAudio("1105803011", var_48_11)
						arg_45_1:RecordAudio("1105803011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803011", "story_v_side_new_1105803.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803011", "story_v_side_new_1105803.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play1105803012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1105803012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1105803013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1058ui_story"]) and arg_49_1.var_.characterEffect1058ui_story == nil then
				arg_49_1.var_.characterEffect1058ui_story = arg_49_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1058ui_story"]) then
				if arg_49_1.var_.characterEffect1058ui_story and not isNil(arg_49_1.actors_["1058ui_story"]) then
					arg_49_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1058ui_story"]) and arg_49_1.var_.characterEffect1058ui_story then
				arg_49_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.9

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
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

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1105803012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 36 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 36)

				if (36 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 36)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1105803013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1105803013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1105803014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.65

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1105803013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 26 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 26)

				if (26 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 26)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1105803014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1105803014
		arg_57_1.duration_ = 6.4

		local var_57_0 = {
			zh = 6.4,
			ja = 5.233
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
				arg_57_0:Play1105803015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1058ui_story = arg_57_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1058ui_story"].transform.position).z)
				arg_57_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1058ui_story"].transform.localEulerAngles = arg_57_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_57_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1058ui_story"].transform.position).z)
				arg_57_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1058ui_story"].transform.localEulerAngles = arg_57_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1058ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1058ui_story == nil then
				arg_57_1.var_.characterEffect1058ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1058ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1058ui_story then
				arg_57_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action6_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.7

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(1105803014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 28 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 28)

				if (28 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 28)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803014", "story_v_side_new_1105803.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803014", "story_v_side_new_1105803.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_side_new_1105803", "1105803014", "story_v_side_new_1105803.awb")

						arg_57_1:RecordAudio("1105803014", var_60_11)
						arg_57_1:RecordAudio("1105803014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803014", "story_v_side_new_1105803.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803014", "story_v_side_new_1105803.awb")
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

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play1105803015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1105803015
		arg_61_1.duration_ = 3.8

		local var_61_0 = {
			zh = 3.766,
			ja = 3.8
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
				arg_61_0:Play1105803016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1058ui_story = arg_61_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1058ui_story"].transform.position).z)
				arg_61_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1058ui_story"].transform.localEulerAngles = arg_61_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_61_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1058ui_story"].transform.position).z)
				arg_61_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1058ui_story"].transform.localEulerAngles = arg_61_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1058ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1058ui_story == nil then
				arg_61_1.var_.characterEffect1058ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1058ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1058ui_story then
				arg_61_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_64_4 = 0
			local var_64_5 = 0.475

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(1105803015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 19 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 19)

				if (19 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 19)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803015", "story_v_side_new_1105803.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803015", "story_v_side_new_1105803.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_side_new_1105803", "1105803015", "story_v_side_new_1105803.awb")

						arg_61_1:RecordAudio("1105803015", var_64_11)
						arg_61_1:RecordAudio("1105803015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803015", "story_v_side_new_1105803.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803015", "story_v_side_new_1105803.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play1105803016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1105803016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1105803017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1058ui_story"]) and arg_65_1.var_.characterEffect1058ui_story == nil then
				arg_65_1.var_.characterEffect1058ui_story = arg_65_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1058ui_story"]) then
				if arg_65_1.var_.characterEffect1058ui_story and not isNil(arg_65_1.actors_["1058ui_story"]) then
					arg_65_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1058ui_story"]) and arg_65_1.var_.characterEffect1058ui_story then
				arg_65_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 0.275

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1105803016).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 11 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 11)

				if (11 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 11)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1105803017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1105803017
		arg_69_1.duration_ = 7.43

		local var_69_0 = {
			zh = 3.6,
			ja = 7.433
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
				arg_69_0:Play1105803018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1058ui_story = arg_69_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1058ui_story"].transform.position).z)
				arg_69_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1058ui_story"].transform.localEulerAngles = arg_69_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_69_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1058ui_story"].transform.position).z)
				arg_69_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1058ui_story"].transform.localEulerAngles = arg_69_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1058ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1058ui_story == nil then
				arg_69_1.var_.characterEffect1058ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1058ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1058ui_story then
				arg_69_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action6_2")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_4 = 0
			local var_72_5 = 0.325

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(1105803017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 13 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 13)

				if (13 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 13)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803017", "story_v_side_new_1105803.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803017", "story_v_side_new_1105803.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_side_new_1105803", "1105803017", "story_v_side_new_1105803.awb")

						arg_69_1:RecordAudio("1105803017", var_72_11)
						arg_69_1:RecordAudio("1105803017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803017", "story_v_side_new_1105803.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803017", "story_v_side_new_1105803.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play1105803018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1105803018
		arg_73_1.duration_ = 9

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1105803019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if arg_73_1.bgs_.K01i == nil then
				local var_76_0 = Object.Instantiate(arg_73_1.paintGo_)

				var_76_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K01i")
				var_76_0.name = "K01i"
				var_76_0.transform.parent = arg_73_1.stage_.transform
				var_76_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.bgs_.K01i = var_76_0
			end

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= 2 + arg_76_0 then
				local var_76_1 = arg_73_1.bgs_.K01i

				arg_73_1.bgs_.K01i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_76_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_76_2 = var_76_1:GetComponent("SpriteRenderer")

				if var_76_2 and var_76_2.sprite then
					local var_76_3 = 2 * (var_76_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_76_1.transform.localScale = Vector3.New(var_76_3 / var_76_2.sprite.bounds.size.y < var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x and var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x or var_76_3 / var_76_2.sprite.bounds.size.y, var_76_3 / var_76_2.sprite.bounds.size.y < var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x and var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x or var_76_3 / var_76_2.sprite.bounds.size.y, 0)
				end

				for iter_76_0, iter_76_1 in pairs(arg_73_1.bgs_) do
					if iter_76_0 ~= "K01i" then
						iter_76_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_76_4 = 0

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_5 = 2

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_5 then
				local var_76_6 = Color.New(0, 0, 0)

				var_76_6.a = Mathf.Lerp(0, 1, (arg_73_1.time_ - var_76_4) / var_76_5)
				arg_73_1.mask_.color = var_76_6
			end

			if arg_73_1.time_ >= var_76_4 + var_76_5 and arg_73_1.time_ < var_76_4 + var_76_5 + arg_76_0 then
				local var_76_7 = Color.New(0, 0, 0)

				var_76_7.a = 1
				arg_73_1.mask_.color = var_76_7
			end

			local var_76_8 = 2

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_9 = 2

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 then
				local var_76_10 = Color.New(0, 0, 0)

				var_76_10.a = Mathf.Lerp(1, 0, (arg_73_1.time_ - var_76_8) / var_76_9)
				arg_73_1.mask_.color = var_76_10
			end

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 then
				local var_76_11 = Color.New(0, 0, 0)

				arg_73_1.mask_.enabled = false
				var_76_11.a = 0
				arg_73_1.mask_.color = var_76_11
			end

			local var_76_12 = arg_73_1.actors_["1058ui_story"].transform

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= 2 + arg_76_0 then
				arg_73_1.var_.moveOldPos1058ui_story = var_76_12.localPosition
			end

			local var_76_13 = 0.001

			if 2 <= arg_73_1.time_ and arg_73_1.time_ < 2 + var_76_13 then
				var_76_12.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 2) / var_76_13)
				var_76_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_12.position).x, (manager.ui.mainCamera.transform.position - var_76_12.position).y, (manager.ui.mainCamera.transform.position - var_76_12.position).z)
				var_76_12.localEulerAngles.z = 0
				var_76_12.localEulerAngles.x = 0
				var_76_12.localEulerAngles = var_76_12.localEulerAngles
			end

			if arg_73_1.time_ >= 2 + var_76_13 and arg_73_1.time_ < 2 + var_76_13 + arg_76_0 then
				var_76_12.localPosition = Vector3.New(0, 100, 0)
				var_76_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_12.position).x, (manager.ui.mainCamera.transform.position - var_76_12.position).y, (manager.ui.mainCamera.transform.position - var_76_12.position).z)
				var_76_12.localEulerAngles.z = 0
				var_76_12.localEulerAngles.x = 0
				var_76_12.localEulerAngles = var_76_12.localEulerAngles
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_crowd_loop", "")
			end

			local var_76_15 = 0

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.allBtn_.enabled = false
			end

			if arg_73_1.time_ >= var_76_15 + 0.3 and arg_73_1.time_ < var_76_15 + 0.3 + arg_76_0 then
				arg_73_1.allBtn_.enabled = true
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_16 = 4
			local var_76_17 = 0.725

			if 4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_18 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_18:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_19 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(1105803018).content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_21 = 29 <= 0 and var_76_17 or var_76_17 * (utf8.len(var_76_19) / 29)

				if (29 <= 0 and var_76_17 or var_76_17 * (utf8.len(var_76_19) / 29)) > 0 and var_76_17 < var_76_21 then
					arg_73_1.talkMaxDuration = var_76_21
					var_76_16 = var_76_16 + 0.3

					if var_76_21 + var_76_16 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_21 + var_76_16
					end
				end

				arg_73_1.text_.text = var_76_19
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_22 = var_76_16 + 0.3
			local var_76_23 = math.max(var_76_17, arg_73_1.talkMaxDuration)

			if var_76_16 + 0.3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_22 + var_76_23 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_22) / var_76_23

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_22 + var_76_23 and arg_73_1.time_ < var_76_22 + var_76_23 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play1105803019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1105803019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1105803020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.925

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(1105803019).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 37 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 37)

				if (37 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 37)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1105803020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1105803020
		arg_83_1.duration_ = 3.97

		local var_83_0 = {
			zh = 3.9,
			ja = 3.966
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
				arg_83_0:Play1105803021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1058ui_story = arg_83_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1058ui_story"].transform.position).z)
				arg_83_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1058ui_story"].transform.localEulerAngles = arg_83_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_83_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1058ui_story"].transform.position).z)
				arg_83_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1058ui_story"].transform.localEulerAngles = arg_83_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["1058ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1058ui_story == nil then
				arg_83_1.var_.characterEffect1058ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect1058ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1058ui_story then
				arg_83_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_86_4 = 0
			local var_86_5 = 0.475

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_6 = arg_83_1:GetWordFromCfg(1105803020)
				local var_86_7 = arg_83_1:FormatText(var_86_6.content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_9 = 19 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 19)

				if (19 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 19)) > 0 and var_86_5 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9

					if var_86_9 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803020", "story_v_side_new_1105803.awb") ~= 0 then
					local var_86_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803020", "story_v_side_new_1105803.awb") / 1000

					if var_86_10 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_4
					end

					if var_86_6.prefab_name ~= "" and arg_83_1.actors_[var_86_6.prefab_name] ~= nil then
						local var_86_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_6.prefab_name].transform, "story_v_side_new_1105803", "1105803020", "story_v_side_new_1105803.awb")

						arg_83_1:RecordAudio("1105803020", var_86_11)
						arg_83_1:RecordAudio("1105803020", var_86_11)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803020", "story_v_side_new_1105803.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803020", "story_v_side_new_1105803.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_12 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_12 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_12

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_12 and arg_83_1.time_ < var_86_4 + var_86_12 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play1105803021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1105803021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1105803022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1058ui_story"]) and arg_87_1.var_.characterEffect1058ui_story == nil then
				arg_87_1.var_.characterEffect1058ui_story = arg_87_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1058ui_story"]) then
				if arg_87_1.var_.characterEffect1058ui_story and not isNil(arg_87_1.actors_["1058ui_story"]) then
					arg_87_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1058ui_story"]) and arg_87_1.var_.characterEffect1058ui_story then
				arg_87_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_90_1 = 0
			local var_90_2 = 0.575

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(1105803021).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 23 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 23)

				if (23 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 23)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play1105803022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1105803022
		arg_91_1.duration_ = 5.77

		local var_91_0 = {
			zh = 2.933,
			ja = 5.766
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
				arg_91_0:Play1105803023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1058ui_story = arg_91_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1058ui_story"].transform.position).z)
				arg_91_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1058ui_story"].transform.localEulerAngles = arg_91_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_91_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1058ui_story"].transform.position).z)
				arg_91_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1058ui_story"].transform.localEulerAngles = arg_91_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["1058ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1058ui_story == nil then
				arg_91_1.var_.characterEffect1058ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect1058ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1058ui_story then
				arg_91_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_94_4 = 0
			local var_94_5 = 0.425

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(1105803022)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 17 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 17)

				if (17 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 17)) > 0 and var_94_5 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803022", "story_v_side_new_1105803.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803022", "story_v_side_new_1105803.awb") / 1000

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_side_new_1105803", "1105803022", "story_v_side_new_1105803.awb")

						arg_91_1:RecordAudio("1105803022", var_94_11)
						arg_91_1:RecordAudio("1105803022", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803022", "story_v_side_new_1105803.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803022", "story_v_side_new_1105803.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_12 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_12

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_12 and arg_91_1.time_ < var_94_4 + var_94_12 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play1105803023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1105803023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1105803024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1058ui_story"]) and arg_95_1.var_.characterEffect1058ui_story == nil then
				arg_95_1.var_.characterEffect1058ui_story = arg_95_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1058ui_story"]) then
				if arg_95_1.var_.characterEffect1058ui_story and not isNil(arg_95_1.actors_["1058ui_story"]) then
					arg_95_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1058ui_story"]) and arg_95_1.var_.characterEffect1058ui_story then
				arg_95_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_98_1 = 0
			local var_98_2 = 0.325

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(1105803023).content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 13 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 13)

				if (13 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 13)) > 0 and var_98_2 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_6 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_6 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_6

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_6 and arg_95_1.time_ < var_98_1 + var_98_6 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1105803024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1105803024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1105803025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_2")
			end

			local var_102_0 = 0
			local var_102_1 = 0.85

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_2 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1105803024).content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 34 <= 0 and var_102_1 or var_102_1 * (utf8.len(var_102_2) / 34)

				if (34 <= 0 and var_102_1 or var_102_1 * (utf8.len(var_102_2) / 34)) > 0 and var_102_1 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_5 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_5 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_5

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_5 and arg_99_1.time_ < var_102_0 + var_102_5 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1105803025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1105803025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1105803026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.75

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

				local var_106_1 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(1105803025).content)

				arg_103_1.text_.text = var_106_1

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_3 = 30 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 30)

				if (30 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 30)) > 0 and var_106_0 < var_106_3 then
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
	Play1105803026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1105803026
		arg_107_1.duration_ = 9.83

		local var_107_0 = {
			zh = 4.333,
			ja = 9.833
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
				arg_107_0:Play1105803027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1058ui_story = arg_107_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1058ui_story"].transform.position).z)
				arg_107_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1058ui_story"].transform.localEulerAngles = arg_107_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_107_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1058ui_story"].transform.position).z)
				arg_107_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1058ui_story"].transform.localEulerAngles = arg_107_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["1058ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1058ui_story == nil then
				arg_107_1.var_.characterEffect1058ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect1058ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1058ui_story then
				arg_107_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_110_4 = 0
			local var_110_5 = 0.575

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(1105803026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 23 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 23)

				if (23 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 23)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803026", "story_v_side_new_1105803.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803026", "story_v_side_new_1105803.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_side_new_1105803", "1105803026", "story_v_side_new_1105803.awb")

						arg_107_1:RecordAudio("1105803026", var_110_11)
						arg_107_1:RecordAudio("1105803026", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803026", "story_v_side_new_1105803.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803026", "story_v_side_new_1105803.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_12 and arg_107_1.time_ < var_110_4 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play1105803027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1105803027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1105803028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1058ui_story"]) and arg_111_1.var_.characterEffect1058ui_story == nil then
				arg_111_1.var_.characterEffect1058ui_story = arg_111_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1058ui_story"]) then
				if arg_111_1.var_.characterEffect1058ui_story and not isNil(arg_111_1.actors_["1058ui_story"]) then
					arg_111_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1058ui_story"]) and arg_111_1.var_.characterEffect1058ui_story then
				arg_111_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_114_1 = 0
			local var_114_2 = 0.75

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(1105803027).content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 30 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 30)

				if (30 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 30)) > 0 and var_114_2 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_6 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_6 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_6

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_6 and arg_111_1.time_ < var_114_1 + var_114_6 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1105803028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1105803028
		arg_115_1.duration_ = 3.1

		local var_115_0 = {
			zh = 2.433,
			ja = 3.1
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
				arg_115_0:Play1105803029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1058ui_story = arg_115_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1058ui_story"].transform.position).z)
				arg_115_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1058ui_story"].transform.localEulerAngles = arg_115_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_115_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1058ui_story"].transform.position).z)
				arg_115_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1058ui_story"].transform.localEulerAngles = arg_115_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["1058ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1058ui_story == nil then
				arg_115_1.var_.characterEffect1058ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect1058ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1058ui_story then
				arg_115_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_4 = 0
			local var_118_5 = 0.3

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(1105803028)
				local var_118_7 = arg_115_1:FormatText(var_118_6.content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 12 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 12)

				if (12 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 12)) > 0 and var_118_5 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803028", "story_v_side_new_1105803.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803028", "story_v_side_new_1105803.awb") / 1000

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end

					if var_118_6.prefab_name ~= "" and arg_115_1.actors_[var_118_6.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_6.prefab_name].transform, "story_v_side_new_1105803", "1105803028", "story_v_side_new_1105803.awb")

						arg_115_1:RecordAudio("1105803028", var_118_11)
						arg_115_1:RecordAudio("1105803028", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803028", "story_v_side_new_1105803.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803028", "story_v_side_new_1105803.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_12 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_12 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_12

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_12 and arg_115_1.time_ < var_118_4 + var_118_12 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play1105803029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1105803029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1105803030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1058ui_story"]) and arg_119_1.var_.characterEffect1058ui_story == nil then
				arg_119_1.var_.characterEffect1058ui_story = arg_119_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1058ui_story"]) then
				if arg_119_1.var_.characterEffect1058ui_story and not isNil(arg_119_1.actors_["1058ui_story"]) then
					arg_119_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1058ui_story"]) and arg_119_1.var_.characterEffect1058ui_story then
				arg_119_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_122_1 = 0
			local var_122_2 = 0.35

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(1105803029).content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 14 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 14)

				if (14 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 14)) > 0 and var_122_2 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_6 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_6 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_6

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_6 and arg_119_1.time_ < var_122_1 + var_122_6 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1105803030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1105803030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1105803031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.6

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(1105803030).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 24 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 24)

				if (24 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 24)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1105803031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1105803031
		arg_127_1.duration_ = 3.6

		local var_127_0 = {
			zh = 2.5,
			ja = 3.6
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
				arg_127_0:Play1105803032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1058ui_story = arg_127_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1058ui_story"].transform.position).z)
				arg_127_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1058ui_story"].transform.localEulerAngles = arg_127_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_127_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1058ui_story"].transform.position).z)
				arg_127_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1058ui_story"].transform.localEulerAngles = arg_127_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1058ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1058ui_story == nil then
				arg_127_1.var_.characterEffect1058ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1058ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1058ui_story then
				arg_127_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_130_4 = 0
			local var_130_5 = 0.3

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(1105803031)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 12 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 12)

				if (12 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 12)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803031", "story_v_side_new_1105803.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803031", "story_v_side_new_1105803.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_side_new_1105803", "1105803031", "story_v_side_new_1105803.awb")

						arg_127_1:RecordAudio("1105803031", var_130_11)
						arg_127_1:RecordAudio("1105803031", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803031", "story_v_side_new_1105803.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803031", "story_v_side_new_1105803.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_12 and arg_127_1.time_ < var_130_4 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play1105803032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1105803032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1105803033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_9000

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1058ui_story"]) and arg_131_1.var_.characterEffect1058ui_story == nil then
				arg_131_1.var_.characterEffect1058ui_story = arg_131_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1058ui_story"]) then
				if arg_131_1.var_.characterEffect1058ui_story and not isNil(arg_131_1.actors_["1058ui_story"]) then
					arg_131_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1058ui_story"]) and arg_131_1.var_.characterEffect1058ui_story then
				arg_131_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_rain_loop", "")
			end

			local var_134_2 = arg_131_1.actors_["1058ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1058ui_story = var_134_2.localPosition
			end

			local var_134_3 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 then
				var_134_2.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_3)
				var_134_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_2.position).x, (manager.ui.mainCamera.transform.position - var_134_2.position).y, (manager.ui.mainCamera.transform.position - var_134_2.position).z)
				var_134_2.localEulerAngles.z = 0
				var_134_2.localEulerAngles.x = 0
				var_134_2.localEulerAngles = var_134_2.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 then
				var_134_2.localPosition = Vector3.New(0, 100, 0)
				var_134_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_2.position).x, (manager.ui.mainCamera.transform.position - var_134_2.position).y, (manager.ui.mainCamera.transform.position - var_134_2.position).z)
				var_134_2.localEulerAngles.z = 0
				var_134_2.localEulerAngles.x = 0
				var_134_2.localEulerAngles = var_134_2.localEulerAngles
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				local var_134_4 = arg_131_1.var_.effectxiayuli

				if not arg_131_1.var_.effectxiayuli then
					var_134_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_raindrop"), manager.ui.mainCamera.transform)
					var_134_4.name = "xiayuli"
					arg_131_1.var_.effectxiayuli = var_134_4
				else
					var_134_4.transform:SetParent(var_134_9000)
				end

				var_134_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_134_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_134_6 = 0
			local var_134_7 = 0.925

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(1105803032).content)

				arg_131_1.text_.text = var_134_8

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_10 = 37 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_8) / 37)

				if (37 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_8) / 37)) > 0 and var_134_7 < var_134_10 then
					arg_131_1.talkMaxDuration = var_134_10

					if var_134_10 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_8
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_11 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_11 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_11

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_11 and arg_131_1.time_ < var_134_6 + var_134_11 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play1105803033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1105803033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1105803034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_raincave_loop", "")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:AudioAction("stop", "effect", "se_story_side_1058", "se_story_side_1058_rain_loop", "")
			end

			local var_138_2 = 0
			local var_138_3 = 1.05

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_4 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(1105803033).content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_6 = 42 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_4) / 42)

				if (42 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_4) / 42)) > 0 and var_138_3 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_2
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_3, arg_135_1.talkMaxDuration)

			if var_138_2 <= arg_135_1.time_ and arg_135_1.time_ < var_138_2 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_2) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_2 + var_138_7 and arg_135_1.time_ < var_138_2 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1105803034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1105803034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1105803035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.375

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(1105803034).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 15 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 15)

				if (15 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 15)) > 0 and var_142_0 < var_142_3 then
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
	Play1105803035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1105803035
		arg_143_1.duration_ = 3.47

		local var_143_0 = {
			zh = 3.1,
			ja = 3.466
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
				arg_143_0:Play1105803036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1058ui_story = arg_143_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1058ui_story"].transform.position).z)
				arg_143_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1058ui_story"].transform.localEulerAngles = arg_143_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_143_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1058ui_story"].transform.position).z)
				arg_143_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1058ui_story"].transform.localEulerAngles = arg_143_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1058ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1058ui_story == nil then
				arg_143_1.var_.characterEffect1058ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1058ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1058ui_story then
				arg_143_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_4 = 0
			local var_146_5 = 0.4

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(1105803035)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 16 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 16)

				if (16 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 16)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803035", "story_v_side_new_1105803.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803035", "story_v_side_new_1105803.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_side_new_1105803", "1105803035", "story_v_side_new_1105803.awb")

						arg_143_1:RecordAudio("1105803035", var_146_11)
						arg_143_1:RecordAudio("1105803035", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803035", "story_v_side_new_1105803.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803035", "story_v_side_new_1105803.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play1105803036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1105803036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1105803037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1058ui_story"]) and arg_147_1.var_.characterEffect1058ui_story == nil then
				arg_147_1.var_.characterEffect1058ui_story = arg_147_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1058ui_story"]) then
				if arg_147_1.var_.characterEffect1058ui_story and not isNil(arg_147_1.actors_["1058ui_story"]) then
					arg_147_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1058ui_story"]) and arg_147_1.var_.characterEffect1058ui_story then
				arg_147_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 0.35

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1105803036).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 14 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 14)

				if (14 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 14)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1105803037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1105803037
		arg_151_1.duration_ = 6.83

		local var_151_0 = {
			zh = 4.8,
			ja = 6.833
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
				arg_151_0:Play1105803038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1058ui_story = arg_151_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1058ui_story"].transform.position).z)
				arg_151_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1058ui_story"].transform.localEulerAngles = arg_151_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_151_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1058ui_story"].transform.position).z)
				arg_151_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1058ui_story"].transform.localEulerAngles = arg_151_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1058ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1058ui_story == nil then
				arg_151_1.var_.characterEffect1058ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1058ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1058ui_story then
				arg_151_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_4 = 0
			local var_154_5 = 0.55

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(1105803037)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 22 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 22)

				if (22 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 22)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803037", "story_v_side_new_1105803.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803037", "story_v_side_new_1105803.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_side_new_1105803", "1105803037", "story_v_side_new_1105803.awb")

						arg_151_1:RecordAudio("1105803037", var_154_11)
						arg_151_1:RecordAudio("1105803037", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803037", "story_v_side_new_1105803.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803037", "story_v_side_new_1105803.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_12 and arg_151_1.time_ < var_154_4 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play1105803038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1105803038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1105803039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1058ui_story"]) and arg_155_1.var_.characterEffect1058ui_story == nil then
				arg_155_1.var_.characterEffect1058ui_story = arg_155_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1058ui_story"]) then
				if arg_155_1.var_.characterEffect1058ui_story and not isNil(arg_155_1.actors_["1058ui_story"]) then
					arg_155_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1058ui_story"]) and arg_155_1.var_.characterEffect1058ui_story then
				arg_155_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_158_1 = 0
			local var_158_2 = 0.7

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(1105803038).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 28 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 28)

				if (28 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 28)) > 0 and var_158_2 < var_158_5 then
					arg_155_1.talkMaxDuration = var_158_5

					if var_158_5 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + var_158_1
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_6 = math.max(var_158_2, arg_155_1.talkMaxDuration)

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_6 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_1) / var_158_6

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_1 + var_158_6 and arg_155_1.time_ < var_158_1 + var_158_6 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1105803039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1105803039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1105803040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.45

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
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

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(1105803039).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 18 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 18)

				if (18 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 18)) > 0 and var_162_0 < var_162_3 then
					arg_159_1.talkMaxDuration = var_162_3

					if var_162_3 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_3 + 0
					end
				end

				arg_159_1.text_.text = var_162_1
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_4 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_4

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1105803040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1105803040
		arg_163_1.duration_ = 8.9

		local var_163_0 = {
			zh = 8.9,
			ja = 7.2
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
				arg_163_0:Play1105803041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1058ui_story = arg_163_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).z)
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles = arg_163_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_163_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).z)
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles = arg_163_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["1058ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1058ui_story == nil then
				arg_163_1.var_.characterEffect1058ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect1058ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1058ui_story then
				arg_163_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_2")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_166_4 = 0
			local var_166_5 = 1.175

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(1105803040)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 47 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 47)

				if (47 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 47)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803040", "story_v_side_new_1105803.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803040", "story_v_side_new_1105803.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_side_new_1105803", "1105803040", "story_v_side_new_1105803.awb")

						arg_163_1:RecordAudio("1105803040", var_166_11)
						arg_163_1:RecordAudio("1105803040", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803040", "story_v_side_new_1105803.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803040", "story_v_side_new_1105803.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_12 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_12

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_12 and arg_163_1.time_ < var_166_4 + var_166_12 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play1105803041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1105803041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1105803042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1058ui_story"]) and arg_167_1.var_.characterEffect1058ui_story == nil then
				arg_167_1.var_.characterEffect1058ui_story = arg_167_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1058ui_story"]) then
				if arg_167_1.var_.characterEffect1058ui_story and not isNil(arg_167_1.actors_["1058ui_story"]) then
					arg_167_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1058ui_story"]) and arg_167_1.var_.characterEffect1058ui_story then
				arg_167_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_170_1 = 0
			local var_170_2 = 0.175

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
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

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1105803041).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 7 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 7)

				if (7 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 7)) > 0 and var_170_2 < var_170_5 then
					arg_167_1.talkMaxDuration = var_170_5

					if var_170_5 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_6 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_6 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_6

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_6 and arg_167_1.time_ < var_170_1 + var_170_6 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1105803042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1105803042
		arg_171_1.duration_ = 2.03

		local var_171_0 = {
			zh = 1.999999999999,
			ja = 2.033
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
				arg_171_0:Play1105803043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1058ui_story = arg_171_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1058ui_story"].transform.position).z)
				arg_171_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1058ui_story"].transform.localEulerAngles = arg_171_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_171_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1058ui_story"].transform.position).z)
				arg_171_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1058ui_story"].transform.localEulerAngles = arg_171_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["1058ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1058ui_story == nil then
				arg_171_1.var_.characterEffect1058ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect1058ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1058ui_story then
				arg_171_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_174_4 = 0
			local var_174_5 = 0.125

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(1105803042)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 5 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 5)

				if (5 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 5)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803042", "story_v_side_new_1105803.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803042", "story_v_side_new_1105803.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_side_new_1105803", "1105803042", "story_v_side_new_1105803.awb")

						arg_171_1:RecordAudio("1105803042", var_174_11)
						arg_171_1:RecordAudio("1105803042", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803042", "story_v_side_new_1105803.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803042", "story_v_side_new_1105803.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_12 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_12 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_12

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_12 and arg_171_1.time_ < var_174_4 + var_174_12 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play1105803043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1105803043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1105803044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1058ui_story"]) and arg_175_1.var_.characterEffect1058ui_story == nil then
				arg_175_1.var_.characterEffect1058ui_story = arg_175_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1058ui_story"]) then
				if arg_175_1.var_.characterEffect1058ui_story and not isNil(arg_175_1.actors_["1058ui_story"]) then
					arg_175_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1058ui_story"]) and arg_175_1.var_.characterEffect1058ui_story then
				arg_175_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_178_1 = 0
			local var_178_2 = 0.3

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1105803043).content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 12 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 12)

				if (12 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 12)) > 0 and var_178_2 < var_178_5 then
					arg_175_1.talkMaxDuration = var_178_5

					if var_178_5 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + var_178_1
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_6 = math.max(var_178_2, arg_175_1.talkMaxDuration)

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_6 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_1) / var_178_6

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_1 + var_178_6 and arg_175_1.time_ < var_178_1 + var_178_6 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1105803044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1105803044
		arg_179_1.duration_ = 5.7

		local var_179_0 = {
			zh = 5.7,
			ja = 5.666
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
				arg_179_0:Play1105803045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1058ui_story = arg_179_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1058ui_story"].transform.position).z)
				arg_179_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1058ui_story"].transform.localEulerAngles = arg_179_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_179_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1058ui_story"].transform.position).z)
				arg_179_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1058ui_story"].transform.localEulerAngles = arg_179_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1058ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1058ui_story == nil then
				arg_179_1.var_.characterEffect1058ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1058ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1058ui_story then
				arg_179_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_182_4 = 0
			local var_182_5 = 0.7

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(1105803044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 28 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 28)

				if (28 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 28)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803044", "story_v_side_new_1105803.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803044", "story_v_side_new_1105803.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_side_new_1105803", "1105803044", "story_v_side_new_1105803.awb")

						arg_179_1:RecordAudio("1105803044", var_182_11)
						arg_179_1:RecordAudio("1105803044", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803044", "story_v_side_new_1105803.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803044", "story_v_side_new_1105803.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_12 and arg_179_1.time_ < var_182_4 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play1105803045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1105803045
		arg_183_1.duration_ = 9

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1105803046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if arg_183_1.bgs_.STblack == nil then
				local var_186_0 = Object.Instantiate(arg_183_1.paintGo_)

				var_186_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_186_0.name = "STblack"
				var_186_0.transform.parent = arg_183_1.stage_.transform
				var_186_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.bgs_.STblack = var_186_0
			end

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 then
				local var_186_1 = arg_183_1.bgs_.STblack

				arg_183_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_186_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_2 = var_186_1:GetComponent("SpriteRenderer")

				if var_186_2 and var_186_2.sprite then
					local var_186_3 = 2 * (var_186_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_186_1.transform.localScale = Vector3.New(var_186_3 / var_186_2.sprite.bounds.size.y < var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x and var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x or var_186_3 / var_186_2.sprite.bounds.size.y, var_186_3 / var_186_2.sprite.bounds.size.y < var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x and var_186_3 * manager.ui.mainCameraCom_.aspect / var_186_2.sprite.bounds.size.x or var_186_3 / var_186_2.sprite.bounds.size.y, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "STblack" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_4 = arg_183_1.actors_["1058ui_story"].transform

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 then
				arg_183_1.var_.moveOldPos1058ui_story = var_186_4.localPosition
			end

			local var_186_5 = 0.001

			if 2 <= arg_183_1.time_ and arg_183_1.time_ < 2 + var_186_5 then
				var_186_4.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 2) / var_186_5)
				var_186_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_4.position).x, (manager.ui.mainCamera.transform.position - var_186_4.position).y, (manager.ui.mainCamera.transform.position - var_186_4.position).z)
				var_186_4.localEulerAngles.z = 0
				var_186_4.localEulerAngles.x = 0
				var_186_4.localEulerAngles = var_186_4.localEulerAngles
			end

			if arg_183_1.time_ >= 2 + var_186_5 and arg_183_1.time_ < 2 + var_186_5 + arg_186_0 then
				var_186_4.localPosition = Vector3.New(0, 100, 0)
				var_186_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_4.position).x, (manager.ui.mainCamera.transform.position - var_186_4.position).y, (manager.ui.mainCamera.transform.position - var_186_4.position).z)
				var_186_4.localEulerAngles.z = 0
				var_186_4.localEulerAngles.x = 0
				var_186_4.localEulerAngles = var_186_4.localEulerAngles
			end

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 then
				if arg_183_1.var_.effectxiayuli then
					Object.Destroy(arg_183_1.var_.effectxiayuli)

					arg_183_1.var_.effectxiayuli = nil
				end
			end

			local var_186_7 = 0

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_7 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_8 = 2

			if var_186_7 <= arg_183_1.time_ and arg_183_1.time_ < var_186_7 + var_186_8 then
				local var_186_9 = Color.New(0, 0, 0)

				var_186_9.a = Mathf.Lerp(0, 1, (arg_183_1.time_ - var_186_7) / var_186_8)
				arg_183_1.mask_.color = var_186_9
			end

			if arg_183_1.time_ >= var_186_7 + var_186_8 and arg_183_1.time_ < var_186_7 + var_186_8 + arg_186_0 then
				local var_186_10 = Color.New(0, 0, 0)

				var_186_10.a = 1
				arg_183_1.mask_.color = var_186_10
			end

			local var_186_11 = 2

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= var_186_11 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_12 = 2

			if var_186_11 <= arg_183_1.time_ and arg_183_1.time_ < var_186_11 + var_186_12 then
				local var_186_13 = Color.New(0, 0, 0)

				var_186_13.a = Mathf.Lerp(1, 0, (arg_183_1.time_ - var_186_11) / var_186_12)
				arg_183_1.mask_.color = var_186_13
			end

			if arg_183_1.time_ >= var_186_11 + var_186_12 and arg_183_1.time_ < var_186_11 + var_186_12 + arg_186_0 then
				local var_186_14 = Color.New(0, 0, 0)

				arg_183_1.mask_.enabled = false
				var_186_14.a = 0
				arg_183_1.mask_.color = var_186_14
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_15 = 4
			local var_186_16 = 1.175

			if 4 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_17 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_17:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(1105803045).content)

				arg_183_1.text_.text = var_186_18

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 47 <= 0 and var_186_16 or var_186_16 * (utf8.len(var_186_18) / 47)

				if (47 <= 0 and var_186_16 or var_186_16 * (utf8.len(var_186_18) / 47)) > 0 and var_186_16 < var_186_20 then
					arg_183_1.talkMaxDuration = var_186_20
					var_186_15 = var_186_15 + 0.3

					if var_186_20 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_20 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_18
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_21 = var_186_15 + 0.3
			local var_186_22 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 + 0.3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_21 + var_186_22 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_21) / var_186_22

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_21 + var_186_22 and arg_183_1.time_ < var_186_21 + var_186_22 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play1105803046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1105803046
		arg_189_1.duration_ = 7

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1105803047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				local var_192_0 = arg_189_1.bgs_.K01i

				arg_189_1.bgs_.K01i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_192_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_1 = var_192_0:GetComponent("SpriteRenderer")

				if var_192_1 and var_192_1.sprite then
					local var_192_2 = 2 * (var_192_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_192_0.transform.localScale = Vector3.New(var_192_2 / var_192_1.sprite.bounds.size.y < var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x and var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x or var_192_2 / var_192_1.sprite.bounds.size.y, var_192_2 / var_192_1.sprite.bounds.size.y < var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x and var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x or var_192_2 / var_192_1.sprite.bounds.size.y, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "K01i" then
						iter_192_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_fireloop", "")
			end

			local var_192_4 = 0

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_5 = 2

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_5 then
				local var_192_6 = Color.New(0, 0, 0)

				var_192_6.a = Mathf.Lerp(1, 0, (arg_189_1.time_ - var_192_4) / var_192_5)
				arg_189_1.mask_.color = var_192_6
			end

			if arg_189_1.time_ >= var_192_4 + var_192_5 and arg_189_1.time_ < var_192_4 + var_192_5 + arg_192_0 then
				local var_192_7 = Color.New(0, 0, 0)

				arg_189_1.mask_.enabled = false
				var_192_7.a = 0
				arg_189_1.mask_.color = var_192_7
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_8 = 2
			local var_192_9 = 1.325

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_10 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_10:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_11 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(1105803046).content)

				arg_189_1.text_.text = var_192_11

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_13 = 53 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 53)

				if (53 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 53)) > 0 and var_192_9 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13
					var_192_8 = var_192_8 + 0.3

					if var_192_13 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_8
					end
				end

				arg_189_1.text_.text = var_192_11
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_14 = var_192_8 + 0.3
			local var_192_15 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 + 0.3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_14 + var_192_15 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_14) / var_192_15

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_14 + var_192_15 and arg_189_1.time_ < var_192_14 + var_192_15 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1105803047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1105803047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1105803048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.4

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(1105803047).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 16 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 16)

				if (16 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 16)) > 0 and var_198_0 < var_198_3 then
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
	Play1105803048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1105803048
		arg_199_1.duration_ = 3.37

		local var_199_0 = {
			zh = 3.366,
			ja = 2.3
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
				arg_199_0:Play1105803049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1058ui_story = arg_199_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1058ui_story"].transform.position).z)
				arg_199_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1058ui_story"].transform.localEulerAngles = arg_199_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_199_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1058ui_story"].transform.position).z)
				arg_199_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1058ui_story"].transform.localEulerAngles = arg_199_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["1058ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1058ui_story == nil then
				arg_199_1.var_.characterEffect1058ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect1058ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1058ui_story then
				arg_199_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_202_4 = 0
			local var_202_5 = 0.3

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(1105803048)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 12 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 12)

				if (12 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 12)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803048", "story_v_side_new_1105803.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803048", "story_v_side_new_1105803.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_side_new_1105803", "1105803048", "story_v_side_new_1105803.awb")

						arg_199_1:RecordAudio("1105803048", var_202_11)
						arg_199_1:RecordAudio("1105803048", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803048", "story_v_side_new_1105803.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803048", "story_v_side_new_1105803.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play1105803049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1105803049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1105803050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1058ui_story"]) and arg_203_1.var_.characterEffect1058ui_story == nil then
				arg_203_1.var_.characterEffect1058ui_story = arg_203_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1058ui_story"]) then
				if arg_203_1.var_.characterEffect1058ui_story and not isNil(arg_203_1.actors_["1058ui_story"]) then
					arg_203_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_0)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1058ui_story"]) and arg_203_1.var_.characterEffect1058ui_story then
				arg_203_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_206_1 = 0
			local var_206_2 = 0.475

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(1105803049).content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 19 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 19)

				if (19 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 19)) > 0 and var_206_2 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_6 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_6 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_6

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_6 and arg_203_1.time_ < var_206_1 + var_206_6 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1105803050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1105803050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1105803051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1058ui_story = arg_207_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1058ui_story"].transform.position).z)
				arg_207_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1058ui_story"].transform.localEulerAngles = arg_207_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1058ui_story"].transform.position).z)
				arg_207_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1058ui_story"].transform.localEulerAngles = arg_207_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_210_1 = 0
			local var_210_2 = 0.65

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1105803050).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 26 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 26)

				if (26 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 26)) > 0 and var_210_2 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_6 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_6 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_6

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_6 and arg_207_1.time_ < var_210_1 + var_210_6 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play1105803051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1105803051
		arg_211_1.duration_ = 3.2

		local var_211_0 = {
			zh = 3.2,
			ja = 2.5
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
				arg_211_0:Play1105803052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1058ui_story = arg_211_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).z)
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles = arg_211_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_211_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).z)
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles = arg_211_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1058ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1058ui_story == nil then
				arg_211_1.var_.characterEffect1058ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1058ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1058ui_story then
				arg_211_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_2")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_214_4 = 0
			local var_214_5 = 0.35

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(1105803051)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 14 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 14)

				if (14 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 14)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803051", "story_v_side_new_1105803.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803051", "story_v_side_new_1105803.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_side_new_1105803", "1105803051", "story_v_side_new_1105803.awb")

						arg_211_1:RecordAudio("1105803051", var_214_11)
						arg_211_1:RecordAudio("1105803051", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803051", "story_v_side_new_1105803.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803051", "story_v_side_new_1105803.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_12 and arg_211_1.time_ < var_214_4 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play1105803052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1105803052
		arg_215_1.duration_ = 4.9

		local var_215_0 = {
			zh = 4.633,
			ja = 4.9
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
				arg_215_0:Play1105803053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1058ui_story = arg_215_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).z)
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles = arg_215_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_215_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).z)
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles = arg_215_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_218_1 = 0
			local var_218_2 = 0.6

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_3 = arg_215_1:GetWordFromCfg(1105803052)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_6 = 24 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_4) / 24)

				if (24 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_4) / 24)) > 0 and var_218_2 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803052", "story_v_side_new_1105803.awb") ~= 0 then
					local var_218_7 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803052", "story_v_side_new_1105803.awb") / 1000

					if var_218_7 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_1
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_side_new_1105803", "1105803052", "story_v_side_new_1105803.awb")

						arg_215_1:RecordAudio("1105803052", var_218_8)
						arg_215_1:RecordAudio("1105803052", var_218_8)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803052", "story_v_side_new_1105803.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803052", "story_v_side_new_1105803.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_9 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_9 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_9

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_9 and arg_215_1.time_ < var_218_1 + var_218_9 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
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
	Play1105803053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1105803053
		arg_219_1.duration_ = 6.67

		local var_219_0 = {
			zh = 6.666,
			ja = 2.766
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
				arg_219_0:Play1105803054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_222_0 = 0
			local var_222_1 = 0.8

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(1105803053)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 32 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 32)

				if (32 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 32)) > 0 and var_222_1 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803053", "story_v_side_new_1105803.awb") ~= 0 then
					local var_222_6 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803053", "story_v_side_new_1105803.awb") / 1000

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end

					if var_222_2.prefab_name ~= "" and arg_219_1.actors_[var_222_2.prefab_name] ~= nil then
						local var_222_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_2.prefab_name].transform, "story_v_side_new_1105803", "1105803053", "story_v_side_new_1105803.awb")

						arg_219_1:RecordAudio("1105803053", var_222_7)
						arg_219_1:RecordAudio("1105803053", var_222_7)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803053", "story_v_side_new_1105803.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803053", "story_v_side_new_1105803.awb")
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
	Play1105803054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1105803054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1105803055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1058ui_story"]) and arg_223_1.var_.characterEffect1058ui_story == nil then
				arg_223_1.var_.characterEffect1058ui_story = arg_223_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1058ui_story"]) then
				if arg_223_1.var_.characterEffect1058ui_story and not isNil(arg_223_1.actors_["1058ui_story"]) then
					arg_223_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1058ui_story"]) and arg_223_1.var_.characterEffect1058ui_story then
				arg_223_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0
			local var_226_2 = 0.95

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(1105803054).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 38 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 38)

				if (38 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 38)) > 0 and var_226_2 < var_226_5 then
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
	Play1105803055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1105803055
		arg_227_1.duration_ = 3.73

		local var_227_0 = {
			zh = 3.5,
			ja = 3.733
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
				arg_227_0:Play1105803056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1058ui_story = arg_227_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1058ui_story"].transform.position).z)
				arg_227_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1058ui_story"].transform.localEulerAngles = arg_227_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_227_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1058ui_story"].transform.position).z)
				arg_227_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1058ui_story"].transform.localEulerAngles = arg_227_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1058ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1058ui_story == nil then
				arg_227_1.var_.characterEffect1058ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1058ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1058ui_story then
				arg_227_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_2")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_4 = 0
			local var_230_5 = 0.375

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_6 = arg_227_1:GetWordFromCfg(1105803055)
				local var_230_7 = arg_227_1:FormatText(var_230_6.content)

				arg_227_1.text_.text = var_230_7

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_9 = 15 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 15)

				if (15 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 15)) > 0 and var_230_5 < var_230_9 then
					arg_227_1.talkMaxDuration = var_230_9

					if var_230_9 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_4
					end
				end

				arg_227_1.text_.text = var_230_7
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803055", "story_v_side_new_1105803.awb") ~= 0 then
					local var_230_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803055", "story_v_side_new_1105803.awb") / 1000

					if var_230_10 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_4
					end

					if var_230_6.prefab_name ~= "" and arg_227_1.actors_[var_230_6.prefab_name] ~= nil then
						local var_230_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_6.prefab_name].transform, "story_v_side_new_1105803", "1105803055", "story_v_side_new_1105803.awb")

						arg_227_1:RecordAudio("1105803055", var_230_11)
						arg_227_1:RecordAudio("1105803055", var_230_11)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803055", "story_v_side_new_1105803.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803055", "story_v_side_new_1105803.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_12 = math.max(var_230_5, arg_227_1.talkMaxDuration)

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_12 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_4) / var_230_12

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_4 + var_230_12 and arg_227_1.time_ < var_230_4 + var_230_12 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play1105803056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1105803056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1105803057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1058ui_story"]) and arg_231_1.var_.characterEffect1058ui_story == nil then
				arg_231_1.var_.characterEffect1058ui_story = arg_231_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1058ui_story"]) then
				if arg_231_1.var_.characterEffect1058ui_story and not isNil(arg_231_1.actors_["1058ui_story"]) then
					arg_231_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_0)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1058ui_story"]) and arg_231_1.var_.characterEffect1058ui_story then
				arg_231_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_234_1 = 0
			local var_234_2 = 0.45

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

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(1105803056).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 18 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 18)

				if (18 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 18)) > 0 and var_234_2 < var_234_5 then
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
	Play1105803057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1105803057
		arg_235_1.duration_ = 6.37

		local var_235_0 = {
			zh = 6.133,
			ja = 6.366
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
				arg_235_0:Play1105803058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1058ui_story = arg_235_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1058ui_story"].transform.position).z)
				arg_235_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1058ui_story"].transform.localEulerAngles = arg_235_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_235_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1058ui_story"].transform.position).z)
				arg_235_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1058ui_story"].transform.localEulerAngles = arg_235_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["1058ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1058ui_story == nil then
				arg_235_1.var_.characterEffect1058ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 and not isNil(var_238_1) then
				if arg_235_1.var_.characterEffect1058ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect1058ui_story then
				arg_235_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action3_1")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_238_4 = 0
			local var_238_5 = 0.875

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_6 = arg_235_1:GetWordFromCfg(1105803057)
				local var_238_7 = arg_235_1:FormatText(var_238_6.content)

				arg_235_1.text_.text = var_238_7

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_9 = 35 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 35)

				if (35 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 35)) > 0 and var_238_5 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_4
					end
				end

				arg_235_1.text_.text = var_238_7
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803057", "story_v_side_new_1105803.awb") ~= 0 then
					local var_238_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803057", "story_v_side_new_1105803.awb") / 1000

					if var_238_10 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_4
					end

					if var_238_6.prefab_name ~= "" and arg_235_1.actors_[var_238_6.prefab_name] ~= nil then
						local var_238_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_6.prefab_name].transform, "story_v_side_new_1105803", "1105803057", "story_v_side_new_1105803.awb")

						arg_235_1:RecordAudio("1105803057", var_238_11)
						arg_235_1:RecordAudio("1105803057", var_238_11)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803057", "story_v_side_new_1105803.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803057", "story_v_side_new_1105803.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_12 = math.max(var_238_5, arg_235_1.talkMaxDuration)

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_12 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_4) / var_238_12

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_4 + var_238_12 and arg_235_1.time_ < var_238_4 + var_238_12 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play1105803058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1105803058
		arg_239_1.duration_ = 10.47

		local var_239_0 = {
			zh = 9.533,
			ja = 10.466
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
				arg_239_0:Play1105803059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1058ui_story = arg_239_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1058ui_story"].transform.position).z)
				arg_239_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1058ui_story"].transform.localEulerAngles = arg_239_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_239_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1058ui_story"].transform.position).z)
				arg_239_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1058ui_story"].transform.localEulerAngles = arg_239_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1058ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1058ui_story == nil then
				arg_239_1.var_.characterEffect1058ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1058ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1058ui_story then
				arg_239_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_242_4 = 0
			local var_242_5 = 1.15

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(1105803058)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 46 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 46)

				if (46 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 46)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803058", "story_v_side_new_1105803.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803058", "story_v_side_new_1105803.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_side_new_1105803", "1105803058", "story_v_side_new_1105803.awb")

						arg_239_1:RecordAudio("1105803058", var_242_11)
						arg_239_1:RecordAudio("1105803058", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803058", "story_v_side_new_1105803.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803058", "story_v_side_new_1105803.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play1105803059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1105803059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1105803060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1058ui_story"]) and arg_243_1.var_.characterEffect1058ui_story == nil then
				arg_243_1.var_.characterEffect1058ui_story = arg_243_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1058ui_story"]) then
				if arg_243_1.var_.characterEffect1058ui_story and not isNil(arg_243_1.actors_["1058ui_story"]) then
					arg_243_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1058ui_story"]) and arg_243_1.var_.characterEffect1058ui_story then
				arg_243_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 0.175

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(1105803059).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 7 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 7)

				if (7 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 7)) > 0 and var_246_2 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_6 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_6 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_6

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_6 and arg_243_1.time_ < var_246_1 + var_246_6 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1105803060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1105803060
		arg_247_1.duration_ = 3.83

		local var_247_0 = {
			zh = 3.833,
			ja = 3.533
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
				arg_247_0:Play1105803061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1058ui_story = arg_247_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1058ui_story"].transform.position).z)
				arg_247_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1058ui_story"].transform.localEulerAngles = arg_247_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_247_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1058ui_story"].transform.position).z)
				arg_247_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1058ui_story"].transform.localEulerAngles = arg_247_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["1058ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1058ui_story == nil then
				arg_247_1.var_.characterEffect1058ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect1058ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1058ui_story then
				arg_247_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action3_2")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_250_4 = 0
			local var_250_5 = 0.525

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_6 = arg_247_1:GetWordFromCfg(1105803060)
				local var_250_7 = arg_247_1:FormatText(var_250_6.content)

				arg_247_1.text_.text = var_250_7

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_9 = 21 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 21)

				if (21 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 21)) > 0 and var_250_5 < var_250_9 then
					arg_247_1.talkMaxDuration = var_250_9

					if var_250_9 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_7
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803060", "story_v_side_new_1105803.awb") ~= 0 then
					local var_250_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803060", "story_v_side_new_1105803.awb") / 1000

					if var_250_10 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_4
					end

					if var_250_6.prefab_name ~= "" and arg_247_1.actors_[var_250_6.prefab_name] ~= nil then
						local var_250_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_6.prefab_name].transform, "story_v_side_new_1105803", "1105803060", "story_v_side_new_1105803.awb")

						arg_247_1:RecordAudio("1105803060", var_250_11)
						arg_247_1:RecordAudio("1105803060", var_250_11)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803060", "story_v_side_new_1105803.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803060", "story_v_side_new_1105803.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_12 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_12 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_12

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_12 and arg_247_1.time_ < var_250_4 + var_250_12 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play1105803061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1105803061
		arg_251_1.duration_ = 6.33

		local var_251_0 = {
			zh = 6.333,
			ja = 5.133
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
				arg_251_0:Play1105803062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1058ui_story = arg_251_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1058ui_story"].transform.position).z)
				arg_251_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1058ui_story"].transform.localEulerAngles = arg_251_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_251_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1058ui_story"].transform.position).z)
				arg_251_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1058ui_story"].transform.localEulerAngles = arg_251_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["1058ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1058ui_story == nil then
				arg_251_1.var_.characterEffect1058ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect1058ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1058ui_story then
				arg_251_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action7_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_254_4 = 0
			local var_254_5 = 0.7

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_4 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_6 = arg_251_1:GetWordFromCfg(1105803061)
				local var_254_7 = arg_251_1:FormatText(var_254_6.content)

				arg_251_1.text_.text = var_254_7

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_9 = 28 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 28)

				if (28 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 28)) > 0 and var_254_5 < var_254_9 then
					arg_251_1.talkMaxDuration = var_254_9

					if var_254_9 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_9 + var_254_4
					end
				end

				arg_251_1.text_.text = var_254_7
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803061", "story_v_side_new_1105803.awb") ~= 0 then
					local var_254_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803061", "story_v_side_new_1105803.awb") / 1000

					if var_254_10 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_4
					end

					if var_254_6.prefab_name ~= "" and arg_251_1.actors_[var_254_6.prefab_name] ~= nil then
						local var_254_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_6.prefab_name].transform, "story_v_side_new_1105803", "1105803061", "story_v_side_new_1105803.awb")

						arg_251_1:RecordAudio("1105803061", var_254_11)
						arg_251_1:RecordAudio("1105803061", var_254_11)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803061", "story_v_side_new_1105803.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803061", "story_v_side_new_1105803.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_12 = math.max(var_254_5, arg_251_1.talkMaxDuration)

			if var_254_4 <= arg_251_1.time_ and arg_251_1.time_ < var_254_4 + var_254_12 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_4) / var_254_12

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_4 + var_254_12 and arg_251_1.time_ < var_254_4 + var_254_12 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play1105803062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1105803062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1105803063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1058ui_story"]) and arg_255_1.var_.characterEffect1058ui_story == nil then
				arg_255_1.var_.characterEffect1058ui_story = arg_255_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1058ui_story"]) then
				if arg_255_1.var_.characterEffect1058ui_story and not isNil(arg_255_1.actors_["1058ui_story"]) then
					arg_255_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1058ui_story"]) and arg_255_1.var_.characterEffect1058ui_story then
				arg_255_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_258_1 = 0
			local var_258_2 = 0.325

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(1105803062).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 13 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 13)

				if (13 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 13)) > 0 and var_258_2 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_6 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_6 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_1) / var_258_6

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_1 + var_258_6 and arg_255_1.time_ < var_258_1 + var_258_6 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1105803063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1105803063
		arg_259_1.duration_ = 6.8

		local var_259_0 = {
			zh = 6.8,
			ja = 3.6
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
				arg_259_0:Play1105803064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1058ui_story = arg_259_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1058ui_story"].transform.position).z)
				arg_259_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1058ui_story"].transform.localEulerAngles = arg_259_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_259_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1058ui_story"].transform.position).z)
				arg_259_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1058ui_story"].transform.localEulerAngles = arg_259_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["1058ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1058ui_story == nil then
				arg_259_1.var_.characterEffect1058ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect1058ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1058ui_story then
				arg_259_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_262_4 = 0
			local var_262_5 = 0.75

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_6 = arg_259_1:GetWordFromCfg(1105803063)
				local var_262_7 = arg_259_1:FormatText(var_262_6.content)

				arg_259_1.text_.text = var_262_7

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_9 = 30 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 30)

				if (30 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 30)) > 0 and var_262_5 < var_262_9 then
					arg_259_1.talkMaxDuration = var_262_9

					if var_262_9 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_4
					end
				end

				arg_259_1.text_.text = var_262_7
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803063", "story_v_side_new_1105803.awb") ~= 0 then
					local var_262_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803063", "story_v_side_new_1105803.awb") / 1000

					if var_262_10 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_4
					end

					if var_262_6.prefab_name ~= "" and arg_259_1.actors_[var_262_6.prefab_name] ~= nil then
						local var_262_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_6.prefab_name].transform, "story_v_side_new_1105803", "1105803063", "story_v_side_new_1105803.awb")

						arg_259_1:RecordAudio("1105803063", var_262_11)
						arg_259_1:RecordAudio("1105803063", var_262_11)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803063", "story_v_side_new_1105803.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803063", "story_v_side_new_1105803.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_12 = math.max(var_262_5, arg_259_1.talkMaxDuration)

			if var_262_4 <= arg_259_1.time_ and arg_259_1.time_ < var_262_4 + var_262_12 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_4) / var_262_12

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_4 + var_262_12 and arg_259_1.time_ < var_262_4 + var_262_12 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
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
	Play1105803064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1105803064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1105803065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1058ui_story"]) and arg_263_1.var_.characterEffect1058ui_story == nil then
				arg_263_1.var_.characterEffect1058ui_story = arg_263_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1058ui_story"]) then
				if arg_263_1.var_.characterEffect1058ui_story and not isNil(arg_263_1.actors_["1058ui_story"]) then
					arg_263_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1058ui_story"]) and arg_263_1.var_.characterEffect1058ui_story then
				arg_263_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_266_1 = 0
			local var_266_2 = 0.725

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_3 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(1105803064).content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 29 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 29)

				if (29 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 29)) > 0 and var_266_2 < var_266_5 then
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
	Play1105803065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1105803065
		arg_267_1.duration_ = 10.13

		local var_267_0 = {
			zh = 10.133,
			ja = 8.333
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
				arg_267_0:Play1105803066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1058ui_story = arg_267_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1058ui_story"].transform.position).z)
				arg_267_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1058ui_story"].transform.localEulerAngles = arg_267_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_267_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1058ui_story"].transform.position).z)
				arg_267_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1058ui_story"].transform.localEulerAngles = arg_267_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_270_1 = arg_267_1.actors_["1058ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1058ui_story == nil then
				arg_267_1.var_.characterEffect1058ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect1058ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1058ui_story then
				arg_267_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_270_4 = 0
			local var_270_5 = 1.175

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_6 = arg_267_1:GetWordFromCfg(1105803065)
				local var_270_7 = arg_267_1:FormatText(var_270_6.content)

				arg_267_1.text_.text = var_270_7

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_9 = 47 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 47)

				if (47 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 47)) > 0 and var_270_5 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9

					if var_270_9 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_4
					end
				end

				arg_267_1.text_.text = var_270_7
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803065", "story_v_side_new_1105803.awb") ~= 0 then
					local var_270_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803065", "story_v_side_new_1105803.awb") / 1000

					if var_270_10 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_4
					end

					if var_270_6.prefab_name ~= "" and arg_267_1.actors_[var_270_6.prefab_name] ~= nil then
						local var_270_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_6.prefab_name].transform, "story_v_side_new_1105803", "1105803065", "story_v_side_new_1105803.awb")

						arg_267_1:RecordAudio("1105803065", var_270_11)
						arg_267_1:RecordAudio("1105803065", var_270_11)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803065", "story_v_side_new_1105803.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803065", "story_v_side_new_1105803.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_12 = math.max(var_270_5, arg_267_1.talkMaxDuration)

			if var_270_4 <= arg_267_1.time_ and arg_267_1.time_ < var_270_4 + var_270_12 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_4) / var_270_12

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_4 + var_270_12 and arg_267_1.time_ < var_270_4 + var_270_12 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
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
	Play1105803066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1105803066
		arg_271_1.duration_ = 1

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"

			SetActive(arg_271_1.choicesGo_, true)

			for iter_272_0, iter_272_1 in ipairs(arg_271_1.choices_) do
				SetActive(iter_272_1.go, iter_272_0 <= 2)
			end

			arg_271_1.choices_[1].txt.text = arg_271_1:FormatText(StoryChoiceCfg[533].name)
			arg_271_1.choices_[2].txt.text = arg_271_1:FormatText(StoryChoiceCfg[534].name)
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1105803067(arg_271_1)
			end

			if arg_273_0 == 2 then
				arg_271_0:Play1105803067(arg_271_1)
			end

			arg_271_1:RecordChoiceLog(1105803066, 533, 534)
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.allBtn_.enabled = false
			end

			if arg_271_1.time_ >= 0 + 0.75 and arg_271_1.time_ < 0 + 0.75 + arg_274_0 then
				arg_271_1.allBtn_.enabled = true
			end

			local var_274_0 = arg_271_1.actors_["1058ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1058ui_story == nil then
				arg_271_1.var_.characterEffect1058ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_1 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_1 and not isNil(var_274_0) then
				if arg_271_1.var_.characterEffect1058ui_story and not isNil(var_274_0) then
					arg_271_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_1)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_1 and arg_271_1.time_ < 0 + var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1058ui_story then
				arg_271_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1105803067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1105803067
		arg_275_1.duration_ = 6.83

		local var_275_0 = {
			zh = 6.2,
			ja = 6.833
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
				arg_275_0:Play1105803068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if arg_275_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_278_0 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_275_1.stage_.transform)

				var_278_0.name = "1058ui_story"
				var_278_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_275_1.actors_["1058ui_story"] = var_278_0

				local var_278_1 = var_278_0:GetComponentInChildren(typeof(CharacterEffect))

				var_278_1.enabled = true

				local var_278_2 = GameObjectTools.GetOrAddComponent(var_278_0, typeof(DynamicBoneHelper))

				if var_278_2 then
					var_278_2:EnableDynamicBone(false)
				end

				arg_275_1:ShowWeapon(var_278_1.transform, false)

				arg_275_1.var_["1058ui_story" .. "Animator"] = var_278_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_275_1.var_["1058ui_story" .. "Animator"].applyRootMotion = true
				arg_275_1.var_["1058ui_story" .. "LipSync"] = var_278_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_278_3 = arg_275_1.actors_["1058ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_3) and arg_275_1.var_.characterEffect1058ui_story == nil then
				arg_275_1.var_.characterEffect1058ui_story = var_278_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_4 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 and not isNil(var_278_3) then
				if arg_275_1.var_.characterEffect1058ui_story and not isNil(var_278_3) then
					arg_275_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 and not isNil(var_278_3) and arg_275_1.var_.characterEffect1058ui_story then
				arg_275_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_278_6 = 0
			local var_278_7 = 0.65

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_8 = arg_275_1:GetWordFromCfg(1105803067)
				local var_278_9 = arg_275_1:FormatText(var_278_8.content)

				arg_275_1.text_.text = var_278_9

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_11 = 26 <= 0 and var_278_7 or var_278_7 * (utf8.len(var_278_9) / 26)

				if (26 <= 0 and var_278_7 or var_278_7 * (utf8.len(var_278_9) / 26)) > 0 and var_278_7 < var_278_11 then
					arg_275_1.talkMaxDuration = var_278_11

					if var_278_11 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_11 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_9
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803067", "story_v_side_new_1105803.awb") ~= 0 then
					local var_278_12 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803067", "story_v_side_new_1105803.awb") / 1000

					if var_278_12 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_12 + var_278_6
					end

					if var_278_8.prefab_name ~= "" and arg_275_1.actors_[var_278_8.prefab_name] ~= nil then
						local var_278_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_8.prefab_name].transform, "story_v_side_new_1105803", "1105803067", "story_v_side_new_1105803.awb")

						arg_275_1:RecordAudio("1105803067", var_278_13)
						arg_275_1:RecordAudio("1105803067", var_278_13)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803067", "story_v_side_new_1105803.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803067", "story_v_side_new_1105803.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_14 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_14 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_14

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_14 and arg_275_1.time_ < var_278_6 + var_278_14 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1105803068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1105803068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1105803069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1058ui_story"]) and arg_279_1.var_.characterEffect1058ui_story == nil then
				arg_279_1.var_.characterEffect1058ui_story = arg_279_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1058ui_story"]) then
				if arg_279_1.var_.characterEffect1058ui_story and not isNil(arg_279_1.actors_["1058ui_story"]) then
					arg_279_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1058ui_story"]) and arg_279_1.var_.characterEffect1058ui_story then
				arg_279_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 0.075

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

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(1105803068).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 3 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 3)

				if (3 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 3)) > 0 and var_282_2 < var_282_5 then
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
	Play1105803069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1105803069
		arg_283_1.duration_ = 8.4

		local var_283_0 = {
			zh = 8.4,
			ja = 3.9
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
				arg_283_0:Play1105803070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1058ui_story = arg_283_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1058ui_story"].transform.position).z)
				arg_283_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1058ui_story"].transform.localEulerAngles = arg_283_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_283_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1058ui_story"].transform.position).z)
				arg_283_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1058ui_story"].transform.localEulerAngles = arg_283_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["1058ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1058ui_story == nil then
				arg_283_1.var_.characterEffect1058ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect1058ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1058ui_story then
				arg_283_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action7_2")
			end

			local var_286_4 = 0
			local var_286_5 = 0.85

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_6 = arg_283_1:GetWordFromCfg(1105803069)
				local var_286_7 = arg_283_1:FormatText(var_286_6.content)

				arg_283_1.text_.text = var_286_7

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_9 = 34 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 34)

				if (34 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 34)) > 0 and var_286_5 < var_286_9 then
					arg_283_1.talkMaxDuration = var_286_9

					if var_286_9 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_4
					end
				end

				arg_283_1.text_.text = var_286_7
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803069", "story_v_side_new_1105803.awb") ~= 0 then
					local var_286_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803069", "story_v_side_new_1105803.awb") / 1000

					if var_286_10 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_4
					end

					if var_286_6.prefab_name ~= "" and arg_283_1.actors_[var_286_6.prefab_name] ~= nil then
						local var_286_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_6.prefab_name].transform, "story_v_side_new_1105803", "1105803069", "story_v_side_new_1105803.awb")

						arg_283_1:RecordAudio("1105803069", var_286_11)
						arg_283_1:RecordAudio("1105803069", var_286_11)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803069", "story_v_side_new_1105803.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803069", "story_v_side_new_1105803.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_12 = math.max(var_286_5, arg_283_1.talkMaxDuration)

			if var_286_4 <= arg_283_1.time_ and arg_283_1.time_ < var_286_4 + var_286_12 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_4) / var_286_12

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_4 + var_286_12 and arg_283_1.time_ < var_286_4 + var_286_12 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play1105803070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1105803070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1105803071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1058ui_story"]) and arg_287_1.var_.characterEffect1058ui_story == nil then
				arg_287_1.var_.characterEffect1058ui_story = arg_287_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1058ui_story"]) then
				if arg_287_1.var_.characterEffect1058ui_story and not isNil(arg_287_1.actors_["1058ui_story"]) then
					arg_287_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_0)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1058ui_story"]) and arg_287_1.var_.characterEffect1058ui_story then
				arg_287_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_290_1 = 0
			local var_290_2 = 0.175

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_3 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(1105803070).content)

				arg_287_1.text_.text = var_290_3

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 7 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 7)

				if (7 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 7)) > 0 and var_290_2 < var_290_5 then
					arg_287_1.talkMaxDuration = var_290_5

					if var_290_5 + var_290_1 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + var_290_1
					end
				end

				arg_287_1.text_.text = var_290_3
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_6 = math.max(var_290_2, arg_287_1.talkMaxDuration)

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_6 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_1) / var_290_6

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_1 + var_290_6 and arg_287_1.time_ < var_290_1 + var_290_6 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1105803071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1105803071
		arg_291_1.duration_ = 2

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1105803072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1058ui_story = arg_291_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1058ui_story"].transform.position).z)
				arg_291_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1058ui_story"].transform.localEulerAngles = arg_291_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_291_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1058ui_story"].transform.position).z)
				arg_291_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1058ui_story"].transform.localEulerAngles = arg_291_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_294_1 = arg_291_1.actors_["1058ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect1058ui_story == nil then
				arg_291_1.var_.characterEffect1058ui_story = var_294_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_2 and not isNil(var_294_1) then
				if arg_291_1.var_.characterEffect1058ui_story and not isNil(var_294_1) then
					arg_291_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_2 and arg_291_1.time_ < 0 + var_294_2 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect1058ui_story then
				arg_291_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_294_4 = 0
			local var_294_5 = 0.075

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_6 = arg_291_1:GetWordFromCfg(1105803071)
				local var_294_7 = arg_291_1:FormatText(var_294_6.content)

				arg_291_1.text_.text = var_294_7

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_9 = 3 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_7) / 3)

				if (3 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_7) / 3)) > 0 and var_294_5 < var_294_9 then
					arg_291_1.talkMaxDuration = var_294_9

					if var_294_9 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_9 + var_294_4
					end
				end

				arg_291_1.text_.text = var_294_7
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803071", "story_v_side_new_1105803.awb") ~= 0 then
					local var_294_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803071", "story_v_side_new_1105803.awb") / 1000

					if var_294_10 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_10 + var_294_4
					end

					if var_294_6.prefab_name ~= "" and arg_291_1.actors_[var_294_6.prefab_name] ~= nil then
						local var_294_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_6.prefab_name].transform, "story_v_side_new_1105803", "1105803071", "story_v_side_new_1105803.awb")

						arg_291_1:RecordAudio("1105803071", var_294_11)
						arg_291_1:RecordAudio("1105803071", var_294_11)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803071", "story_v_side_new_1105803.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803071", "story_v_side_new_1105803.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_12 = math.max(var_294_5, arg_291_1.talkMaxDuration)

			if var_294_4 <= arg_291_1.time_ and arg_291_1.time_ < var_294_4 + var_294_12 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_4) / var_294_12

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_4 + var_294_12 and arg_291_1.time_ < var_294_4 + var_294_12 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play1105803072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1105803072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1105803073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["1058ui_story"]) and arg_295_1.var_.characterEffect1058ui_story == nil then
				arg_295_1.var_.characterEffect1058ui_story = arg_295_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["1058ui_story"]) then
				if arg_295_1.var_.characterEffect1058ui_story and not isNil(arg_295_1.actors_["1058ui_story"]) then
					arg_295_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_0)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["1058ui_story"]) and arg_295_1.var_.characterEffect1058ui_story then
				arg_295_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_298_1 = 0
			local var_298_2 = 0.425

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(1105803072).content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 17 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 17)

				if (17 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 17)) > 0 and var_298_2 < var_298_5 then
					arg_295_1.talkMaxDuration = var_298_5

					if var_298_5 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + var_298_1
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_6 = math.max(var_298_2, arg_295_1.talkMaxDuration)

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_6 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_1) / var_298_6

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_1 + var_298_6 and arg_295_1.time_ < var_298_1 + var_298_6 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1105803073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1105803073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1105803074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.7

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(1105803073).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 28 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 28)

				if (28 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 28)) > 0 and var_302_0 < var_302_3 then
					arg_299_1.talkMaxDuration = var_302_3

					if var_302_3 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_3 + 0
					end
				end

				arg_299_1.text_.text = var_302_1
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_4 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_4

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1105803074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1105803074
		arg_303_1.duration_ = 7.8

		local var_303_0 = {
			zh = 7.8,
			ja = 4.566
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
				arg_303_0:Play1105803075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1058ui_story = arg_303_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1058ui_story"].transform.position).z)
				arg_303_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1058ui_story"].transform.localEulerAngles = arg_303_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_303_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1058ui_story"].transform.position).z)
				arg_303_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1058ui_story"].transform.localEulerAngles = arg_303_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_306_1 = arg_303_1.actors_["1058ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1058ui_story == nil then
				arg_303_1.var_.characterEffect1058ui_story = var_306_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_2 and not isNil(var_306_1) then
				if arg_303_1.var_.characterEffect1058ui_story and not isNil(var_306_1) then
					arg_303_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_2 and arg_303_1.time_ < 0 + var_306_2 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1058ui_story then
				arg_303_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_1")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_306_4 = 0
			local var_306_5 = 1

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_4 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_6 = arg_303_1:GetWordFromCfg(1105803074)
				local var_306_7 = arg_303_1:FormatText(var_306_6.content)

				arg_303_1.text_.text = var_306_7

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_9 = 40 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_7) / 40)

				if (40 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_7) / 40)) > 0 and var_306_5 < var_306_9 then
					arg_303_1.talkMaxDuration = var_306_9

					if var_306_9 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_9 + var_306_4
					end
				end

				arg_303_1.text_.text = var_306_7
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803074", "story_v_side_new_1105803.awb") ~= 0 then
					local var_306_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803074", "story_v_side_new_1105803.awb") / 1000

					if var_306_10 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_10 + var_306_4
					end

					if var_306_6.prefab_name ~= "" and arg_303_1.actors_[var_306_6.prefab_name] ~= nil then
						local var_306_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_6.prefab_name].transform, "story_v_side_new_1105803", "1105803074", "story_v_side_new_1105803.awb")

						arg_303_1:RecordAudio("1105803074", var_306_11)
						arg_303_1:RecordAudio("1105803074", var_306_11)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803074", "story_v_side_new_1105803.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803074", "story_v_side_new_1105803.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_12 = math.max(var_306_5, arg_303_1.talkMaxDuration)

			if var_306_4 <= arg_303_1.time_ and arg_303_1.time_ < var_306_4 + var_306_12 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_4) / var_306_12

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_4 + var_306_12 and arg_303_1.time_ < var_306_4 + var_306_12 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play1105803075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1105803075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1105803076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1058ui_story"]) and arg_307_1.var_.characterEffect1058ui_story == nil then
				arg_307_1.var_.characterEffect1058ui_story = arg_307_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1058ui_story"]) then
				if arg_307_1.var_.characterEffect1058ui_story and not isNil(arg_307_1.actors_["1058ui_story"]) then
					arg_307_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_0)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1058ui_story"]) and arg_307_1.var_.characterEffect1058ui_story then
				arg_307_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_310_1 = 0
			local var_310_2 = 0.3

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_3 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(1105803075).content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 12 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 12)

				if (12 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 12)) > 0 and var_310_2 < var_310_5 then
					arg_307_1.talkMaxDuration = var_310_5

					if var_310_5 + var_310_1 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + var_310_1
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_6 = math.max(var_310_2, arg_307_1.talkMaxDuration)

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_6 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_1) / var_310_6

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_1 + var_310_6 and arg_307_1.time_ < var_310_1 + var_310_6 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1105803076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1105803076
		arg_311_1.duration_ = 7.4

		local var_311_0 = {
			zh = 7.4,
			ja = 6.933
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
				arg_311_0:Play1105803077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos1058ui_story = arg_311_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1058ui_story"].transform.position).z)
				arg_311_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1058ui_story"].transform.localEulerAngles = arg_311_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_311_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1058ui_story"].transform.position).z)
				arg_311_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1058ui_story"].transform.localEulerAngles = arg_311_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["1058ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1058ui_story == nil then
				arg_311_1.var_.characterEffect1058ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect1058ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1058ui_story then
				arg_311_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_314_4 = 0
			local var_314_5 = 0.9

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_6 = arg_311_1:GetWordFromCfg(1105803076)
				local var_314_7 = arg_311_1:FormatText(var_314_6.content)

				arg_311_1.text_.text = var_314_7

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_9 = 36 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 36)

				if (36 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 36)) > 0 and var_314_5 < var_314_9 then
					arg_311_1.talkMaxDuration = var_314_9

					if var_314_9 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_9 + var_314_4
					end
				end

				arg_311_1.text_.text = var_314_7
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803076", "story_v_side_new_1105803.awb") ~= 0 then
					local var_314_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803076", "story_v_side_new_1105803.awb") / 1000

					if var_314_10 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_4
					end

					if var_314_6.prefab_name ~= "" and arg_311_1.actors_[var_314_6.prefab_name] ~= nil then
						local var_314_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_6.prefab_name].transform, "story_v_side_new_1105803", "1105803076", "story_v_side_new_1105803.awb")

						arg_311_1:RecordAudio("1105803076", var_314_11)
						arg_311_1:RecordAudio("1105803076", var_314_11)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803076", "story_v_side_new_1105803.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803076", "story_v_side_new_1105803.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_12 = math.max(var_314_5, arg_311_1.talkMaxDuration)

			if var_314_4 <= arg_311_1.time_ and arg_311_1.time_ < var_314_4 + var_314_12 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_4) / var_314_12

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_4 + var_314_12 and arg_311_1.time_ < var_314_4 + var_314_12 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play1105803077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1105803077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1105803078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1058ui_story"]) and arg_315_1.var_.characterEffect1058ui_story == nil then
				arg_315_1.var_.characterEffect1058ui_story = arg_315_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1058ui_story"]) then
				if arg_315_1.var_.characterEffect1058ui_story and not isNil(arg_315_1.actors_["1058ui_story"]) then
					arg_315_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1058ui_story"]) and arg_315_1.var_.characterEffect1058ui_story then
				arg_315_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_318_1 = 0
			local var_318_2 = 0.8

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_3 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(1105803077).content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 32 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 32)

				if (32 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 32)) > 0 and var_318_2 < var_318_5 then
					arg_315_1.talkMaxDuration = var_318_5

					if var_318_5 + var_318_1 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + var_318_1
					end
				end

				arg_315_1.text_.text = var_318_3
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_6 = math.max(var_318_2, arg_315_1.talkMaxDuration)

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_6 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_1) / var_318_6

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_1 + var_318_6 and arg_315_1.time_ < var_318_1 + var_318_6 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1105803078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1105803078
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1105803079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 1.15

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_1 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(1105803078).content)

				arg_319_1.text_.text = var_322_1

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_3 = 46 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 46)

				if (46 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 46)) > 0 and var_322_0 < var_322_3 then
					arg_319_1.talkMaxDuration = var_322_3

					if var_322_3 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_3 + 0
					end
				end

				arg_319_1.text_.text = var_322_1
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_4 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_4

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1105803079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1105803079
		arg_323_1.duration_ = 7.43

		local var_323_0 = {
			zh = 5.866,
			ja = 7.433
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
				arg_323_0:Play1105803080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1058ui_story = arg_323_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_326_0 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				arg_323_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_323_1.time_ - 0) / var_326_0)
				arg_323_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1058ui_story"].transform.position).z)
				arg_323_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1058ui_story"].transform.localEulerAngles = arg_323_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				arg_323_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_323_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1058ui_story"].transform.position).z)
				arg_323_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1058ui_story"].transform.localEulerAngles = arg_323_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_326_1 = arg_323_1.actors_["1058ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1058ui_story == nil then
				arg_323_1.var_.characterEffect1058ui_story = var_326_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_2 and not isNil(var_326_1) then
				if arg_323_1.var_.characterEffect1058ui_story and not isNil(var_326_1) then
					arg_323_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_2 and arg_323_1.time_ < 0 + var_326_2 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1058ui_story then
				arg_323_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_2")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_326_4 = 0
			local var_326_5 = 0.8

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_6 = arg_323_1:GetWordFromCfg(1105803079)
				local var_326_7 = arg_323_1:FormatText(var_326_6.content)

				arg_323_1.text_.text = var_326_7

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_9 = 32 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 32)

				if (32 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 32)) > 0 and var_326_5 < var_326_9 then
					arg_323_1.talkMaxDuration = var_326_9

					if var_326_9 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_9 + var_326_4
					end
				end

				arg_323_1.text_.text = var_326_7
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803079", "story_v_side_new_1105803.awb") ~= 0 then
					local var_326_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803079", "story_v_side_new_1105803.awb") / 1000

					if var_326_10 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_4
					end

					if var_326_6.prefab_name ~= "" and arg_323_1.actors_[var_326_6.prefab_name] ~= nil then
						local var_326_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_6.prefab_name].transform, "story_v_side_new_1105803", "1105803079", "story_v_side_new_1105803.awb")

						arg_323_1:RecordAudio("1105803079", var_326_11)
						arg_323_1:RecordAudio("1105803079", var_326_11)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803079", "story_v_side_new_1105803.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803079", "story_v_side_new_1105803.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_12 = math.max(var_326_5, arg_323_1.talkMaxDuration)

			if var_326_4 <= arg_323_1.time_ and arg_323_1.time_ < var_326_4 + var_326_12 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_4) / var_326_12

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_4 + var_326_12 and arg_323_1.time_ < var_326_4 + var_326_12 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
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
	Play1105803080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1105803080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1105803081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1058ui_story"]) and arg_327_1.var_.characterEffect1058ui_story == nil then
				arg_327_1.var_.characterEffect1058ui_story = arg_327_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1058ui_story"]) then
				if arg_327_1.var_.characterEffect1058ui_story and not isNil(arg_327_1.actors_["1058ui_story"]) then
					arg_327_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_0)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1058ui_story"]) and arg_327_1.var_.characterEffect1058ui_story then
				arg_327_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_330_1 = 0
			local var_330_2 = 0.225

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

				local var_330_3 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(1105803080).content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 9 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 9)

				if (9 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 9)) > 0 and var_330_2 < var_330_5 then
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
	Play1105803081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1105803081
		arg_331_1.duration_ = 13

		local var_331_0 = {
			zh = 3.4,
			ja = 13
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
				arg_331_0:Play1105803082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1058ui_story = arg_331_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_334_0 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 then
				arg_331_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_331_1.time_ - 0) / var_334_0)
				arg_331_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1058ui_story"].transform.position).z)
				arg_331_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1058ui_story"].transform.localEulerAngles = arg_331_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_331_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1058ui_story"].transform.position).z)
				arg_331_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1058ui_story"].transform.localEulerAngles = arg_331_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_334_1 = arg_331_1.actors_["1058ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1058ui_story == nil then
				arg_331_1.var_.characterEffect1058ui_story = var_334_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_2 and not isNil(var_334_1) then
				if arg_331_1.var_.characterEffect1058ui_story and not isNil(var_334_1) then
					arg_331_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_2 and arg_331_1.time_ < 0 + var_334_2 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect1058ui_story then
				arg_331_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_334_4 = 0
			local var_334_5 = 0.325

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_6 = arg_331_1:GetWordFromCfg(1105803081)
				local var_334_7 = arg_331_1:FormatText(var_334_6.content)

				arg_331_1.text_.text = var_334_7

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_9 = 13 <= 0 and var_334_5 or var_334_5 * (utf8.len(var_334_7) / 13)

				if (13 <= 0 and var_334_5 or var_334_5 * (utf8.len(var_334_7) / 13)) > 0 and var_334_5 < var_334_9 then
					arg_331_1.talkMaxDuration = var_334_9

					if var_334_9 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_9 + var_334_4
					end
				end

				arg_331_1.text_.text = var_334_7
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803081", "story_v_side_new_1105803.awb") ~= 0 then
					local var_334_10 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803081", "story_v_side_new_1105803.awb") / 1000

					if var_334_10 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_10 + var_334_4
					end

					if var_334_6.prefab_name ~= "" and arg_331_1.actors_[var_334_6.prefab_name] ~= nil then
						local var_334_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_6.prefab_name].transform, "story_v_side_new_1105803", "1105803081", "story_v_side_new_1105803.awb")

						arg_331_1:RecordAudio("1105803081", var_334_11)
						arg_331_1:RecordAudio("1105803081", var_334_11)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803081", "story_v_side_new_1105803.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_new_1105803", "1105803081", "story_v_side_new_1105803.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_12 = math.max(var_334_5, arg_331_1.talkMaxDuration)

			if var_334_4 <= arg_331_1.time_ and arg_331_1.time_ < var_334_4 + var_334_12 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_4) / var_334_12

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_4 + var_334_12 and arg_331_1.time_ < var_334_4 + var_334_12 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
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
	Play1105803082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1105803082
		arg_335_1.duration_ = 9.23

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1105803083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.fswbg_:SetActive(true)
				arg_335_1.dialog_:SetActive(false)

				arg_335_1.fswtw_.percent = 0
				arg_335_1.fswt_.text = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(1105803082).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.fswt_)

				arg_335_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_335_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_335_1.fswtw_:SetDirty()

				arg_335_1.typewritterCharCountI18N = 0

				SetActive(arg_335_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_335_1:ShowNextGo(false)
			end

			local var_338_0 = 0.033

			if 0.033 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.var_.oldValueTypewriter = arg_335_1.fswtw_.percent

				SetActive(arg_335_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_335_1:ShowNextGo(false)
			end

			local var_338_1 = 48
			local var_338_2 = 3.2
			local var_338_3, var_338_4 = arg_335_1:GetPercentByPara(arg_335_1:FormatText(arg_335_1:GetWordFromCfg(1105803082).content), 1)

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0

				local var_338_5 = var_338_1 <= 0 and var_338_2 or var_338_2 * ((var_338_4 - arg_335_1.typewritterCharCountI18N) / var_338_1)

				if (var_338_1 <= 0 and var_338_2 or var_338_2 * ((var_338_4 - arg_335_1.typewritterCharCountI18N) / var_338_1)) > 0 and var_338_2 < var_338_5 then
					arg_335_1.talkMaxDuration = var_338_5

					if var_338_5 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + var_338_0
					end
				end
			end

			local var_338_6 = math.max(3.2, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_6 then
				arg_335_1.fswtw_.percent = Mathf.Lerp(arg_335_1.var_.oldValueTypewriter, var_338_3, (arg_335_1.time_ - var_338_0) / var_338_6)
				arg_335_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_335_1.fswtw_:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_6 and arg_335_1.time_ < var_338_0 + var_338_6 + arg_338_0 then
				arg_335_1.fswtw_.percent = var_338_3

				arg_335_1.fswtw_:SetDirty()
				arg_335_1:ShowNextGo(true)

				arg_335_1.typewritterCharCountI18N = var_338_4
			end

			local var_338_7 = 0
			local var_338_8 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803082", "story_v_side_new_1105803.awb") / 1000

			if var_338_8 > 0 and 9.233 < var_338_8 and var_338_8 + var_338_7 > arg_335_1.duration_ then
				arg_335_1.duration_ = var_338_8 + var_338_7
			end

			if var_338_7 < arg_335_1.time_ and arg_335_1.time_ <= var_338_7 + arg_338_0 then
				arg_335_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803082", "story_v_side_new_1105803.awb")
			end

			local var_338_10 = arg_335_1.actors_["1058ui_story"].transform

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1058ui_story = var_338_10.localPosition
			end

			local var_338_11 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_11 then
				var_338_10.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_335_1.time_ - 0) / var_338_11)
				var_338_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_10.position).x, (manager.ui.mainCamera.transform.position - var_338_10.position).y, (manager.ui.mainCamera.transform.position - var_338_10.position).z)
				var_338_10.localEulerAngles.z = 0
				var_338_10.localEulerAngles.x = 0
				var_338_10.localEulerAngles = var_338_10.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_11 and arg_335_1.time_ < 0 + var_338_11 + arg_338_0 then
				var_338_10.localPosition = Vector3.New(0, 100, 0)
				var_338_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_10.position).x, (manager.ui.mainCamera.transform.position - var_338_10.position).y, (manager.ui.mainCamera.transform.position - var_338_10.position).z)
				var_338_10.localEulerAngles.z = 0
				var_338_10.localEulerAngles.x = 0
				var_338_10.localEulerAngles = var_338_10.localEulerAngles
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play1105803083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1105803083
		arg_339_1.duration_ = 10.43

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1105803084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.oldValueTypewriter = arg_339_1.fswtw_.percent

				SetActive(arg_339_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_339_1:ShowNextGo(false)
			end

			local var_342_0 = 49
			local var_342_1 = 3.26666666666667
			local var_342_2, var_342_3 = arg_339_1:GetPercentByPara(arg_339_1:FormatText(arg_339_1:GetWordFromCfg(1105803082).content), 2)

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0

				local var_342_4 = var_342_0 <= 0 and var_342_1 or var_342_1 * ((var_342_3 - arg_339_1.typewritterCharCountI18N) / var_342_0)

				if (var_342_0 <= 0 and var_342_1 or var_342_1 * ((var_342_3 - arg_339_1.typewritterCharCountI18N) / var_342_0)) > 0 and var_342_1 < var_342_4 then
					arg_339_1.talkMaxDuration = var_342_4

					if var_342_4 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_4 + 0
					end
				end
			end

			local var_342_5 = math.max(3.26666666666667, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_5 then
				arg_339_1.fswtw_.percent = Mathf.Lerp(arg_339_1.var_.oldValueTypewriter, var_342_2, (arg_339_1.time_ - 0) / var_342_5)
				arg_339_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_339_1.fswtw_:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_5 and arg_339_1.time_ < 0 + var_342_5 + arg_342_0 then
				arg_339_1.fswtw_.percent = var_342_2

				arg_339_1.fswtw_:SetDirty()
				arg_339_1:ShowNextGo(true)

				arg_339_1.typewritterCharCountI18N = var_342_3
			end

			local var_342_6 = 0
			local var_342_7 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803083", "story_v_side_new_1105803.awb") / 1000

			if var_342_7 > 0 and 10.433 < var_342_7 and var_342_7 + var_342_6 > arg_339_1.duration_ then
				arg_339_1.duration_ = var_342_7 + var_342_6
			end

			if var_342_6 < arg_339_1.time_ and arg_339_1.time_ <= var_342_6 + arg_342_0 then
				arg_339_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803083", "story_v_side_new_1105803.awb")
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1105803084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1105803084
		arg_343_1.duration_ = 13.87

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1105803085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.oldValueTypewriter = arg_343_1.fswtw_.percent

				SetActive(arg_343_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_343_1:ShowNextGo(false)
			end

			local var_346_0 = 65
			local var_346_1 = 4.33333333333333
			local var_346_2, var_346_3 = arg_343_1:GetPercentByPara(arg_343_1:FormatText(arg_343_1:GetWordFromCfg(1105803082).content), 3)

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				local var_346_4 = var_346_0 <= 0 and var_346_1 or var_346_1 * ((var_346_3 - arg_343_1.typewritterCharCountI18N) / var_346_0)

				if (var_346_0 <= 0 and var_346_1 or var_346_1 * ((var_346_3 - arg_343_1.typewritterCharCountI18N) / var_346_0)) > 0 and var_346_1 < var_346_4 then
					arg_343_1.talkMaxDuration = var_346_4

					if var_346_4 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_4 + 0
					end
				end
			end

			local var_346_5 = math.max(4.33333333333333, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_5 then
				arg_343_1.fswtw_.percent = Mathf.Lerp(arg_343_1.var_.oldValueTypewriter, var_346_2, (arg_343_1.time_ - 0) / var_346_5)
				arg_343_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_343_1.fswtw_:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_5 and arg_343_1.time_ < 0 + var_346_5 + arg_346_0 then
				arg_343_1.fswtw_.percent = var_346_2

				arg_343_1.fswtw_:SetDirty()
				arg_343_1:ShowNextGo(true)

				arg_343_1.typewritterCharCountI18N = var_346_3
			end

			local var_346_6 = 0
			local var_346_7 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803084", "story_v_side_new_1105803.awb") / 1000

			if var_346_7 > 0 and 13.866 < var_346_7 and var_346_7 + var_346_6 > arg_343_1.duration_ then
				arg_343_1.duration_ = var_346_7 + var_346_6
			end

			if var_346_6 < arg_343_1.time_ and arg_343_1.time_ <= var_346_6 + arg_346_0 then
				arg_343_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803084", "story_v_side_new_1105803.awb")
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1105803085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1105803085
		arg_347_1.duration_ = 8.37

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1105803086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.oldValueTypewriter = arg_347_1.fswtw_.percent

				SetActive(arg_347_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_347_1:ShowNextGo(false)
			end

			local var_350_0 = 45
			local var_350_1 = 3
			local var_350_2, var_350_3 = arg_347_1:GetPercentByPara(arg_347_1:FormatText(arg_347_1:GetWordFromCfg(1105803082).content), 4)

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0

				local var_350_4 = var_350_0 <= 0 and var_350_1 or var_350_1 * ((var_350_3 - arg_347_1.typewritterCharCountI18N) / var_350_0)

				if (var_350_0 <= 0 and var_350_1 or var_350_1 * ((var_350_3 - arg_347_1.typewritterCharCountI18N) / var_350_0)) > 0 and var_350_1 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end
			end

			local var_350_5 = math.max(3, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_5 then
				arg_347_1.fswtw_.percent = Mathf.Lerp(arg_347_1.var_.oldValueTypewriter, var_350_2, (arg_347_1.time_ - 0) / var_350_5)
				arg_347_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_347_1.fswtw_:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_5 and arg_347_1.time_ < 0 + var_350_5 + arg_350_0 then
				arg_347_1.fswtw_.percent = var_350_2

				arg_347_1.fswtw_:SetDirty()
				arg_347_1:ShowNextGo(true)

				arg_347_1.typewritterCharCountI18N = var_350_3
			end

			local var_350_6 = 0
			local var_350_7 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803085", "story_v_side_new_1105803.awb") / 1000

			if var_350_7 > 0 and 8.366 < var_350_7 and var_350_7 + var_350_6 > arg_347_1.duration_ then
				arg_347_1.duration_ = var_350_7 + var_350_6
			end

			if var_350_6 < arg_347_1.time_ and arg_347_1.time_ <= var_350_6 + arg_350_0 then
				arg_347_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803085", "story_v_side_new_1105803.awb")
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1105803086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1105803086
		arg_351_1.duration_ = 12.97

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1105803087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.oldValueTypewriter = arg_351_1.fswtw_.percent

				SetActive(arg_351_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_351_1:ShowNextGo(false)
			end

			local var_354_0 = 63
			local var_354_1 = 4.2
			local var_354_2, var_354_3 = arg_351_1:GetPercentByPara(arg_351_1:FormatText(arg_351_1:GetWordFromCfg(1105803082).content), 5)

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0

				local var_354_4 = var_354_0 <= 0 and var_354_1 or var_354_1 * ((var_354_3 - arg_351_1.typewritterCharCountI18N) / var_354_0)

				if (var_354_0 <= 0 and var_354_1 or var_354_1 * ((var_354_3 - arg_351_1.typewritterCharCountI18N) / var_354_0)) > 0 and var_354_1 < var_354_4 then
					arg_351_1.talkMaxDuration = var_354_4

					if var_354_4 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_4 + 0
					end
				end
			end

			local var_354_5 = math.max(4.2, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_5 then
				arg_351_1.fswtw_.percent = Mathf.Lerp(arg_351_1.var_.oldValueTypewriter, var_354_2, (arg_351_1.time_ - 0) / var_354_5)
				arg_351_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_351_1.fswtw_:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_5 and arg_351_1.time_ < 0 + var_354_5 + arg_354_0 then
				arg_351_1.fswtw_.percent = var_354_2

				arg_351_1.fswtw_:SetDirty()
				arg_351_1:ShowNextGo(true)

				arg_351_1.typewritterCharCountI18N = var_354_3
			end

			local var_354_6 = 0
			local var_354_7 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803086", "story_v_side_new_1105803.awb") / 1000

			if var_354_7 > 0 and 12.966 < var_354_7 and var_354_7 + var_354_6 > arg_351_1.duration_ then
				arg_351_1.duration_ = var_354_7 + var_354_6
			end

			if var_354_6 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
				arg_351_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803086", "story_v_side_new_1105803.awb")
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1105803087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1105803087
		arg_355_1.duration_ = 7

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1105803088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.oldValueTypewriter = arg_355_1.fswtw_.percent

				SetActive(arg_355_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_355_1:ShowNextGo(false)
			end

			local var_358_0 = 36
			local var_358_1 = 2.4
			local var_358_2, var_358_3 = arg_355_1:GetPercentByPara(arg_355_1:FormatText(arg_355_1:GetWordFromCfg(1105803082).content), 6)

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0

				local var_358_4 = var_358_0 <= 0 and var_358_1 or var_358_1 * ((var_358_3 - arg_355_1.typewritterCharCountI18N) / var_358_0)

				if (var_358_0 <= 0 and var_358_1 or var_358_1 * ((var_358_3 - arg_355_1.typewritterCharCountI18N) / var_358_0)) > 0 and var_358_1 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end
			end

			local var_358_5 = math.max(2.4, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_5 then
				arg_355_1.fswtw_.percent = Mathf.Lerp(arg_355_1.var_.oldValueTypewriter, var_358_2, (arg_355_1.time_ - 0) / var_358_5)
				arg_355_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_355_1.fswtw_:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_5 and arg_355_1.time_ < 0 + var_358_5 + arg_358_0 then
				arg_355_1.fswtw_.percent = var_358_2

				arg_355_1.fswtw_:SetDirty()
				arg_355_1:ShowNextGo(true)

				arg_355_1.typewritterCharCountI18N = var_358_3
			end

			local var_358_6 = 0
			local var_358_7 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803087", "story_v_side_new_1105803.awb") / 1000

			if var_358_7 > 0 and 7 < var_358_7 and var_358_7 + var_358_6 > arg_355_1.duration_ then
				arg_355_1.duration_ = var_358_7 + var_358_6
			end

			if var_358_6 < arg_355_1.time_ and arg_355_1.time_ <= var_358_6 + arg_358_0 then
				arg_355_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803087", "story_v_side_new_1105803.awb")
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1105803088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1105803088
		arg_359_1.duration_ = 1

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1105803089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.fswbg_:SetActive(true)
				arg_359_1.dialog_:SetActive(false)

				arg_359_1.fswtw_.percent = 0
				arg_359_1.fswt_.text = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(1105803088).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.fswt_)

				arg_359_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_359_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_359_1.fswtw_:SetDirty()

				arg_359_1.typewritterCharCountI18N = 0

				SetActive(arg_359_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_359_1:ShowNextGo(false)
			end

			local var_362_0 = 0.033

			if 0.033 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.var_.oldValueTypewriter = arg_359_1.fswtw_.percent

				SetActive(arg_359_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_359_1:ShowNextGo(false)
			end

			local var_362_1 = 14
			local var_362_2 = 0.933333333333333
			local var_362_3, var_362_4 = arg_359_1:GetPercentByPara(arg_359_1:FormatText(arg_359_1:GetWordFromCfg(1105803088).content), 1)

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0

				local var_362_5 = var_362_1 <= 0 and var_362_2 or var_362_2 * ((var_362_4 - arg_359_1.typewritterCharCountI18N) / var_362_1)

				if (var_362_1 <= 0 and var_362_2 or var_362_2 * ((var_362_4 - arg_359_1.typewritterCharCountI18N) / var_362_1)) > 0 and var_362_2 < var_362_5 then
					arg_359_1.talkMaxDuration = var_362_5

					if var_362_5 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + var_362_0
					end
				end
			end

			local var_362_6 = math.max(0.933333333333333, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_6 then
				arg_359_1.fswtw_.percent = Mathf.Lerp(arg_359_1.var_.oldValueTypewriter, var_362_3, (arg_359_1.time_ - var_362_0) / var_362_6)
				arg_359_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_359_1.fswtw_:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_6 and arg_359_1.time_ < var_362_0 + var_362_6 + arg_362_0 then
				arg_359_1.fswtw_.percent = var_362_3

				arg_359_1.fswtw_:SetDirty()
				arg_359_1:ShowNextGo(true)

				arg_359_1.typewritterCharCountI18N = var_362_4
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1105803089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1105803089
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1105803090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.oldValueTypewriter = arg_363_1.fswtw_.percent

				SetActive(arg_363_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_363_1:ShowNextGo(false)
			end

			local var_366_0 = 25
			local var_366_1 = 1.66666666666667
			local var_366_2, var_366_3 = arg_363_1:GetPercentByPara(arg_363_1:FormatText(arg_363_1:GetWordFromCfg(1105803088).content), 2)

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0

				local var_366_4 = var_366_0 <= 0 and var_366_1 or var_366_1 * ((var_366_3 - arg_363_1.typewritterCharCountI18N) / var_366_0)

				if (var_366_0 <= 0 and var_366_1 or var_366_1 * ((var_366_3 - arg_363_1.typewritterCharCountI18N) / var_366_0)) > 0 and var_366_1 < var_366_4 then
					arg_363_1.talkMaxDuration = var_366_4

					if var_366_4 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_4 + 0
					end
				end
			end

			local var_366_5 = math.max(1.66666666666667, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_5 then
				arg_363_1.fswtw_.percent = Mathf.Lerp(arg_363_1.var_.oldValueTypewriter, var_366_2, (arg_363_1.time_ - 0) / var_366_5)
				arg_363_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_363_1.fswtw_:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_5 and arg_363_1.time_ < 0 + var_366_5 + arg_366_0 then
				arg_363_1.fswtw_.percent = var_366_2

				arg_363_1.fswtw_:SetDirty()
				arg_363_1:ShowNextGo(true)

				arg_363_1.typewritterCharCountI18N = var_366_3
			end

			local var_366_6 = 0
			local var_366_7 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803089", "story_v_side_new_1105803.awb") / 1000

			if var_366_7 > 0 and 5 < var_366_7 and var_366_7 + var_366_6 > arg_363_1.duration_ then
				arg_363_1.duration_ = var_366_7 + var_366_6
			end

			if var_366_6 < arg_363_1.time_ and arg_363_1.time_ <= var_366_6 + arg_366_0 then
				arg_363_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803089", "story_v_side_new_1105803.awb")
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1105803090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1105803090
		arg_367_1.duration_ = 7.9

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1105803091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.oldValueTypewriter = arg_367_1.fswtw_.percent

				SetActive(arg_367_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_367_1:ShowNextGo(false)
			end

			local var_370_0 = 36
			local var_370_1 = 2.4
			local var_370_2, var_370_3 = arg_367_1:GetPercentByPara(arg_367_1:FormatText(arg_367_1:GetWordFromCfg(1105803088).content), 3)

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0

				local var_370_4 = var_370_0 <= 0 and var_370_1 or var_370_1 * ((var_370_3 - arg_367_1.typewritterCharCountI18N) / var_370_0)

				if (var_370_0 <= 0 and var_370_1 or var_370_1 * ((var_370_3 - arg_367_1.typewritterCharCountI18N) / var_370_0)) > 0 and var_370_1 < var_370_4 then
					arg_367_1.talkMaxDuration = var_370_4

					if var_370_4 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_4 + 0
					end
				end
			end

			local var_370_5 = math.max(2.4, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_5 then
				arg_367_1.fswtw_.percent = Mathf.Lerp(arg_367_1.var_.oldValueTypewriter, var_370_2, (arg_367_1.time_ - 0) / var_370_5)
				arg_367_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_367_1.fswtw_:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_5 and arg_367_1.time_ < 0 + var_370_5 + arg_370_0 then
				arg_367_1.fswtw_.percent = var_370_2

				arg_367_1.fswtw_:SetDirty()
				arg_367_1:ShowNextGo(true)

				arg_367_1.typewritterCharCountI18N = var_370_3
			end

			local var_370_6 = 0
			local var_370_7 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803090", "story_v_side_new_1105803.awb") / 1000

			if var_370_7 > 0 and 7.9 < var_370_7 and var_370_7 + var_370_6 > arg_367_1.duration_ then
				arg_367_1.duration_ = var_370_7 + var_370_6
			end

			if var_370_6 < arg_367_1.time_ and arg_367_1.time_ <= var_370_6 + arg_370_0 then
				arg_367_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803090", "story_v_side_new_1105803.awb")
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1105803091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1105803091
		arg_371_1.duration_ = 1.67

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1105803092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.oldValueTypewriter = arg_371_1.fswtw_.percent

				SetActive(arg_371_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_371_1:ShowNextGo(false)
			end

			local var_374_0 = 25
			local var_374_1 = 1.66666666666667
			local var_374_2, var_374_3 = arg_371_1:GetPercentByPara(arg_371_1:FormatText(arg_371_1:GetWordFromCfg(1105803088).content), 4)

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0

				local var_374_4 = var_374_0 <= 0 and var_374_1 or var_374_1 * ((var_374_3 - arg_371_1.typewritterCharCountI18N) / var_374_0)

				if (var_374_0 <= 0 and var_374_1 or var_374_1 * ((var_374_3 - arg_371_1.typewritterCharCountI18N) / var_374_0)) > 0 and var_374_1 < var_374_4 then
					arg_371_1.talkMaxDuration = var_374_4

					if var_374_4 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_4 + 0
					end
				end
			end

			local var_374_5 = math.max(1.66666666666667, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_5 then
				arg_371_1.fswtw_.percent = Mathf.Lerp(arg_371_1.var_.oldValueTypewriter, var_374_2, (arg_371_1.time_ - 0) / var_374_5)
				arg_371_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_371_1.fswtw_:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_5 and arg_371_1.time_ < 0 + var_374_5 + arg_374_0 then
				arg_371_1.fswtw_.percent = var_374_2

				arg_371_1.fswtw_:SetDirty()
				arg_371_1:ShowNextGo(true)

				arg_371_1.typewritterCharCountI18N = var_374_3
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1105803092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1105803092
		arg_375_1.duration_ = 7.3

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1105803093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.oldValueTypewriter = arg_375_1.fswtw_.percent

				SetActive(arg_375_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_375_1:ShowNextGo(false)
			end

			local var_378_0 = 37
			local var_378_1 = 2.46666666666667
			local var_378_2, var_378_3 = arg_375_1:GetPercentByPara(arg_375_1:FormatText(arg_375_1:GetWordFromCfg(1105803088).content), 5)

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0

				local var_378_4 = var_378_0 <= 0 and var_378_1 or var_378_1 * ((var_378_3 - arg_375_1.typewritterCharCountI18N) / var_378_0)

				if (var_378_0 <= 0 and var_378_1 or var_378_1 * ((var_378_3 - arg_375_1.typewritterCharCountI18N) / var_378_0)) > 0 and var_378_1 < var_378_4 then
					arg_375_1.talkMaxDuration = var_378_4

					if var_378_4 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_4 + 0
					end
				end
			end

			local var_378_5 = math.max(2.46666666666667, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_5 then
				arg_375_1.fswtw_.percent = Mathf.Lerp(arg_375_1.var_.oldValueTypewriter, var_378_2, (arg_375_1.time_ - 0) / var_378_5)
				arg_375_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_375_1.fswtw_:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_5 and arg_375_1.time_ < 0 + var_378_5 + arg_378_0 then
				arg_375_1.fswtw_.percent = var_378_2

				arg_375_1.fswtw_:SetDirty()
				arg_375_1:ShowNextGo(true)

				arg_375_1.typewritterCharCountI18N = var_378_3
			end

			local var_378_6 = 0
			local var_378_7 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803092", "story_v_side_new_1105803.awb") / 1000

			if var_378_7 > 0 and 7.3 < var_378_7 and var_378_7 + var_378_6 > arg_375_1.duration_ then
				arg_375_1.duration_ = var_378_7 + var_378_6
			end

			if var_378_6 < arg_375_1.time_ and arg_375_1.time_ <= var_378_6 + arg_378_0 then
				arg_375_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803092", "story_v_side_new_1105803.awb")
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1105803093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1105803093
		arg_379_1.duration_ = 9.37

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1105803094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.oldValueTypewriter = arg_379_1.fswtw_.percent

				SetActive(arg_379_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_379_1:ShowNextGo(false)
			end

			local var_382_0 = 41
			local var_382_1 = 2.73333333333333
			local var_382_2, var_382_3 = arg_379_1:GetPercentByPara(arg_379_1:FormatText(arg_379_1:GetWordFromCfg(1105803088).content), 6)

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0

				local var_382_4 = var_382_0 <= 0 and var_382_1 or var_382_1 * ((var_382_3 - arg_379_1.typewritterCharCountI18N) / var_382_0)

				if (var_382_0 <= 0 and var_382_1 or var_382_1 * ((var_382_3 - arg_379_1.typewritterCharCountI18N) / var_382_0)) > 0 and var_382_1 < var_382_4 then
					arg_379_1.talkMaxDuration = var_382_4

					if var_382_4 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_4 + 0
					end
				end
			end

			local var_382_5 = math.max(2.73333333333333, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_5 then
				arg_379_1.fswtw_.percent = Mathf.Lerp(arg_379_1.var_.oldValueTypewriter, var_382_2, (arg_379_1.time_ - 0) / var_382_5)
				arg_379_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_379_1.fswtw_:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_5 and arg_379_1.time_ < 0 + var_382_5 + arg_382_0 then
				arg_379_1.fswtw_.percent = var_382_2

				arg_379_1.fswtw_:SetDirty()
				arg_379_1:ShowNextGo(true)

				arg_379_1.typewritterCharCountI18N = var_382_3
			end

			local var_382_6 = 0
			local var_382_7 = manager.audio:GetVoiceLength("story_v_side_new_1105803", "1105803093", "story_v_side_new_1105803.awb") / 1000

			if var_382_7 > 0 and 9.366 < var_382_7 and var_382_7 + var_382_6 > arg_379_1.duration_ then
				arg_379_1.duration_ = var_382_7 + var_382_6
			end

			if var_382_6 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1:AudioAction("play", "voice", "story_v_side_new_1105803", "1105803093", "story_v_side_new_1105803.awb")
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1105803094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1105803094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1105803095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.fswbg_:SetActive(false)
				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_383_1:ShowNextGo(false)
			end

			local var_386_0 = 0
			local var_386_1 = 0.65

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_2 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(1105803094).content)

				arg_383_1.text_.text = var_386_2

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_4 = 26 <= 0 and var_386_1 or var_386_1 * (utf8.len(var_386_2) / 26)

				if (26 <= 0 and var_386_1 or var_386_1 * (utf8.len(var_386_2) / 26)) > 0 and var_386_1 < var_386_4 then
					arg_383_1.talkMaxDuration = var_386_4

					if var_386_4 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_4 + var_386_0
					end
				end

				arg_383_1.text_.text = var_386_2
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_5 = math.max(var_386_1, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_5 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_0) / var_386_5

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_5 and arg_383_1.time_ < var_386_0 + var_386_5 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1105803095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1105803095
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1105803096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.575

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

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(1105803095).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 23 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 23)

				if (23 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 23)) > 0 and var_390_0 < var_390_3 then
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
	Play1105803096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1105803096
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
			arg_391_1.auto_ = false
		end

		function arg_391_1.playNext_(arg_393_0)
			arg_391_1.onStoryFinished_()
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:AudioAction("stop", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_fireloop", "")
			end

			local var_394_1 = 0
			local var_394_2 = 0.375

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_3 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(1105803096).content)

				arg_391_1.text_.text = var_394_3

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 15 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 15)

				if (15 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 15)) > 0 and var_394_2 < var_394_5 then
					arg_391_1.talkMaxDuration = var_394_5

					if var_394_5 + var_394_1 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + var_394_1
					end
				end

				arg_391_1.text_.text = var_394_3
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_6 = math.max(var_394_2, arg_391_1.talkMaxDuration)

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_6 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_1) / var_394_6

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_1 + var_394_6 and arg_391_1.time_ < var_394_1 + var_394_6 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST59a",
		"TextureConfig/Background/K01i",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_side_new_1105803.awb"
	}
}
