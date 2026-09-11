return {
	Play122111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122111001
		arg_1_1.duration_ = 9.37

		local var_1_0 = {
			ja = 9.366,
			ko = 7.566,
			zh = 7.566
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
				arg_1_0:Play122111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST07b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07b")
				var_4_0.name = "ST07b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST07b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST07b

				arg_1_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST07b" then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_11 = 2
			local var_4_12 = 0.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_13 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_13:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_14 = arg_1_1:GetWordFromCfg(122111001)
				local var_4_15 = arg_1_1:FormatText(var_4_14.content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 32 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_15) / 32)

				if (32 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_15) / 32)) > 0 and var_4_12 < var_4_17 then
					arg_1_1.talkMaxDuration = var_4_17
					var_4_11 = var_4_11 + 0.3

					if var_4_17 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_15
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111001", "story_v_out_122111.awb") ~= 0 then
					local var_4_18 = manager.audio:GetVoiceLength("story_v_out_122111", "122111001", "story_v_out_122111.awb") / 1000

					if var_4_18 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_11
					end

					if var_4_14.prefab_name ~= "" and arg_1_1.actors_[var_4_14.prefab_name] ~= nil then
						local var_4_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_14.prefab_name].transform, "story_v_out_122111", "122111001", "story_v_out_122111.awb")

						arg_1_1:RecordAudio("122111001", var_4_19)
						arg_1_1:RecordAudio("122111001", var_4_19)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_122111", "122111001", "story_v_out_122111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_122111", "122111001", "story_v_out_122111.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_11 + 0.3
			local var_4_21 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play122111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 122111002
		arg_8_1.duration_ = 12.23

		local var_8_0 = {
			ja = 10.666,
			ko = 12.233,
			zh = 12.233
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
				arg_8_0:Play122111003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.55

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:GetWordFromCfg(122111002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 62 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 62)

				if (62 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 62)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111002", "story_v_out_122111.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_122111", "122111002", "story_v_out_122111.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_122111", "122111002", "story_v_out_122111.awb")

						arg_8_1:RecordAudio("122111002", var_11_6)
						arg_8_1:RecordAudio("122111002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_122111", "122111002", "story_v_out_122111.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_122111", "122111002", "story_v_out_122111.awb")
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
	Play122111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 122111003
		arg_12_1.duration_ = 15.63

		local var_12_0 = {
			ja = 15.633,
			ko = 11.433,
			zh = 11.433
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
				arg_12_0:Play122111004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.5

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:GetWordFromCfg(122111003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 60 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 60)

				if (60 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 60)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111003", "story_v_out_122111.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_122111", "122111003", "story_v_out_122111.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_122111", "122111003", "story_v_out_122111.awb")

						arg_12_1:RecordAudio("122111003", var_15_6)
						arg_12_1:RecordAudio("122111003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_122111", "122111003", "story_v_out_122111.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_122111", "122111003", "story_v_out_122111.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play122111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 122111004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play122111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.425

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(122111004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 57 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 57)

				if (57 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 57)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play122111005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 122111005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play122111006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.15

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(122111005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 6 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 6)

				if (6 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 6)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play122111006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 122111006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play122111007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.3

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(122111006).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 12 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 12)

				if (12 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 12)) > 0 and var_27_0 < var_27_3 then
					arg_24_1.talkMaxDuration = var_27_3

					if var_27_3 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_3 + 0
					end
				end

				arg_24_1.text_.text = var_27_1
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_4 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_4

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play122111007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 122111007
		arg_28_1.duration_ = 14.07

		local var_28_0 = {
			ja = 14.066,
			ko = 12.4,
			zh = 12.4
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
				arg_28_0:Play122111008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.bgs_.ST12 == nil then
				local var_31_0 = Object.Instantiate(arg_28_1.paintGo_)

				var_31_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_31_0.name = "ST12"
				var_31_0.transform.parent = arg_28_1.stage_.transform
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.bgs_.ST12 = var_31_0
			end

			if 2 < arg_28_1.time_ and arg_28_1.time_ <= 2 + arg_31_0 then
				local var_31_1 = arg_28_1.bgs_.ST12

				arg_28_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_31_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_2 = var_31_1:GetComponent("SpriteRenderer")

				if var_31_2 and var_31_2.sprite then
					local var_31_3 = 2 * (var_31_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_31_1.transform.localScale = Vector3.New(var_31_3 / var_31_2.sprite.bounds.size.y < var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x and var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x or var_31_3 / var_31_2.sprite.bounds.size.y, var_31_3 / var_31_2.sprite.bounds.size.y < var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x and var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x or var_31_3 / var_31_2.sprite.bounds.size.y, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "ST12" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_4 = "1032ui_story"

			if arg_28_1.actors_["1032ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1032ui_story"))) then
				local var_31_5 = Object.Instantiate(Asset.Load("Char/" .. "1032ui_story"), arg_28_1.stage_.transform)

				var_31_5.name = var_31_4
				var_31_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_[var_31_4] = var_31_5

				local var_31_6 = var_31_5:GetComponentInChildren(typeof(CharacterEffect))

				var_31_6.enabled = true

				local var_31_7 = GameObjectTools.GetOrAddComponent(var_31_5, typeof(DynamicBoneHelper))

				if var_31_7 then
					var_31_7:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_6.transform, false)

				arg_28_1.var_[var_31_4 .. "Animator"] = var_31_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_[var_31_4 .. "Animator"].applyRootMotion = true
				arg_28_1.var_[var_31_4 .. "LipSync"] = var_31_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_8 = arg_28_1.actors_["1032ui_story"].transform

			if 4 < arg_28_1.time_ and arg_28_1.time_ <= 4 + arg_31_0 then
				arg_28_1.var_.moveOldPos1032ui_story = var_31_8.localPosition
			end

			local var_31_9 = 0.001

			if 4 <= arg_28_1.time_ and arg_28_1.time_ < 4 + var_31_9 then
				var_31_8.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1032ui_story, Vector3.New(0, -1.05, -6.2), (arg_28_1.time_ - 4) / var_31_9)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			if arg_28_1.time_ >= 4 + var_31_9 and arg_28_1.time_ < 4 + var_31_9 + arg_31_0 then
				var_31_8.localPosition = Vector3.New(0, -1.05, -6.2)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			local var_31_10 = arg_28_1.actors_["1032ui_story"]

			if 4 < arg_28_1.time_ and arg_28_1.time_ <= 4 + arg_31_0 and not isNil(var_31_10) and arg_28_1.var_.characterEffect1032ui_story == nil then
				arg_28_1.var_.characterEffect1032ui_story = var_31_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_11 = 0.200000002980232

			if 4 <= arg_28_1.time_ and arg_28_1.time_ < 4 + var_31_11 and not isNil(var_31_10) then
				if arg_28_1.var_.characterEffect1032ui_story and not isNil(var_31_10) then
					arg_28_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 4 + var_31_11 and arg_28_1.time_ < 4 + var_31_11 + arg_31_0 and not isNil(var_31_10) and arg_28_1.var_.characterEffect1032ui_story then
				arg_28_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			if 4 < arg_28_1.time_ and arg_28_1.time_ <= 4 + arg_31_0 then
				arg_28_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action3_1")
			end

			if 4 < arg_28_1.time_ and arg_28_1.time_ <= 4 + arg_31_0 then
				arg_28_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_31_13 = 2

			arg_28_1.isInRecall_ = false

			if var_31_13 < arg_28_1.time_ and arg_28_1.time_ <= var_31_13 + arg_31_0 then
				arg_28_1.screenFilterGo_:SetActive(true)

				arg_28_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_31_2, iter_31_3 in pairs(arg_28_1.actors_) do
					for iter_31_4, iter_31_5 in ipairs((iter_31_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_31_5.color = iter_31_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_31_14 = 0.0166666666666667

			if var_31_13 <= arg_28_1.time_ and arg_28_1.time_ < var_31_13 + var_31_14 then
				arg_28_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_28_1.time_ - var_31_13) / var_31_14)
			end

			if arg_28_1.time_ >= var_31_13 + var_31_14 and arg_28_1.time_ < var_31_13 + var_31_14 + arg_31_0 then
				arg_28_1.screenFilterEffect_.weight = 1
			end

			local var_31_15 = 0

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_16 = 2

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_16 then
				local var_31_17 = Color.New(0, 0, 0)

				var_31_17.a = Mathf.Lerp(0, 1, (arg_28_1.time_ - var_31_15) / var_31_16)
				arg_28_1.mask_.color = var_31_17
			end

			if arg_28_1.time_ >= var_31_15 + var_31_16 and arg_28_1.time_ < var_31_15 + var_31_16 + arg_31_0 then
				local var_31_18 = Color.New(0, 0, 0)

				var_31_18.a = 1
				arg_28_1.mask_.color = var_31_18
			end

			local var_31_19 = 2

			if 2 < arg_28_1.time_ and arg_28_1.time_ <= var_31_19 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_20 = 2

			if var_31_19 <= arg_28_1.time_ and arg_28_1.time_ < var_31_19 + var_31_20 then
				local var_31_21 = Color.New(0, 0, 0)

				var_31_21.a = Mathf.Lerp(1, 0, (arg_28_1.time_ - var_31_19) / var_31_20)
				arg_28_1.mask_.color = var_31_21
			end

			if arg_28_1.time_ >= var_31_19 + var_31_20 and arg_28_1.time_ < var_31_19 + var_31_20 + arg_31_0 then
				local var_31_22 = Color.New(0, 0, 0)

				arg_28_1.mask_.enabled = false
				var_31_22.a = 0
				arg_28_1.mask_.color = var_31_22
			end

			if 4 < arg_28_1.time_ and arg_28_1.time_ <= 4 + arg_31_0 then
				arg_28_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_31_25 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_28_1.bgmTxt_.text ~= var_31_25 and arg_28_1.bgmTxt_.text ~= "" then
						if arg_28_1.bgmTxt2_.text ~= "" then
							arg_28_1.bgmTxt_.text = arg_28_1.bgmTxt2_.text
						end

						arg_28_1.bgmTxt2_.text = var_31_25

						arg_28_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_28_1.bgmTxt_.text = var_31_25
						arg_28_1.bgmTxt2_.text = var_31_25
					end

					if arg_28_1.bgmTimer then
						arg_28_1.bgmTimer:Stop()

						arg_28_1.bgmTimer = nil
					end

					if arg_28_1.settingData.show_music_name == 1 then
						arg_28_1.musicController:SetSelectedState("show")
						arg_28_1.musicAnimator_:Play("open", 0, 0)

						if arg_28_1.settingData.music_time ~= 0 then
							arg_28_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_28_1.settingData.music_time), function()
								if arg_28_1 == nil or isNil(arg_28_1.bgmTxt_) then
									return
								end

								arg_28_1.musicController:SetSelectedState("hide")
								arg_28_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_26 = 4
			local var_31_27 = 0.9

			if 4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_26 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_28 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_28:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_28_1.dialogCg_.alpha = arg_33_0
				end))
				var_31_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_29 = arg_28_1:GetWordFromCfg(122111007)
				local var_31_30 = arg_28_1:FormatText(var_31_29.content)

				arg_28_1.text_.text = var_31_30

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_32 = 36 <= 0 and var_31_27 or var_31_27 * (utf8.len(var_31_30) / 36)

				if (36 <= 0 and var_31_27 or var_31_27 * (utf8.len(var_31_30) / 36)) > 0 and var_31_27 < var_31_32 then
					arg_28_1.talkMaxDuration = var_31_32
					var_31_26 = var_31_26 + 0.3

					if var_31_32 + var_31_26 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_32 + var_31_26
					end
				end

				arg_28_1.text_.text = var_31_30
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111007", "story_v_out_122111.awb") ~= 0 then
					local var_31_33 = manager.audio:GetVoiceLength("story_v_out_122111", "122111007", "story_v_out_122111.awb") / 1000

					if var_31_33 + var_31_26 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_33 + var_31_26
					end

					if var_31_29.prefab_name ~= "" and arg_28_1.actors_[var_31_29.prefab_name] ~= nil then
						local var_31_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_29.prefab_name].transform, "story_v_out_122111", "122111007", "story_v_out_122111.awb")

						arg_28_1:RecordAudio("122111007", var_31_34)
						arg_28_1:RecordAudio("122111007", var_31_34)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_122111", "122111007", "story_v_out_122111.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_122111", "122111007", "story_v_out_122111.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_35 = var_31_26 + 0.3
			local var_31_36 = math.max(var_31_27, arg_28_1.talkMaxDuration)

			if var_31_26 + 0.3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_35 + var_31_36 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_35) / var_31_36

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_35 + var_31_36 and arg_28_1.time_ < var_31_35 + var_31_36 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play122111008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 122111008
		arg_35_1.duration_ = 4.7

		local var_35_0 = {
			ja = 4.7,
			ko = 2.9,
			zh = 2.9
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play122111009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032actionlink/1032action434")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_38_0 = 0
			local var_38_1 = 0.8

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_2 = arg_35_1:GetWordFromCfg(122111008)
				local var_38_3 = arg_35_1:FormatText(var_38_2.content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 32 <= 0 and var_38_1 or var_38_1 * (utf8.len(var_38_3) / 32)

				if (32 <= 0 and var_38_1 or var_38_1 * (utf8.len(var_38_3) / 32)) > 0 and var_38_1 < var_38_5 then
					arg_35_1.talkMaxDuration = var_38_5

					if var_38_5 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_3
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111008", "story_v_out_122111.awb") ~= 0 then
					local var_38_6 = manager.audio:GetVoiceLength("story_v_out_122111", "122111008", "story_v_out_122111.awb") / 1000

					if var_38_6 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_0
					end

					if var_38_2.prefab_name ~= "" and arg_35_1.actors_[var_38_2.prefab_name] ~= nil then
						local var_38_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_2.prefab_name].transform, "story_v_out_122111", "122111008", "story_v_out_122111.awb")

						arg_35_1:RecordAudio("122111008", var_38_7)
						arg_35_1:RecordAudio("122111008", var_38_7)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_122111", "122111008", "story_v_out_122111.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_122111", "122111008", "story_v_out_122111.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_8 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_8 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_8

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_8 and arg_35_1.time_ < var_38_0 + var_38_8 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play122111009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 122111009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play122111010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1032ui_story"]) and arg_39_1.var_.characterEffect1032ui_story == nil then
				arg_39_1.var_.characterEffect1032ui_story = arg_39_1.actors_["1032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1032ui_story"]) then
				if arg_39_1.var_.characterEffect1032ui_story and not isNil(arg_39_1.actors_["1032ui_story"]) then
					arg_39_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1032ui_story"]) and arg_39_1.var_.characterEffect1032ui_story then
				arg_39_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1032ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 0.2

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(122111009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 8 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 8)

				if (8 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 8)) > 0 and var_42_2 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_6 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_6

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_6 and arg_39_1.time_ < var_42_1 + var_42_6 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play122111010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 122111010
		arg_43_1.duration_ = 3.87

		local var_43_0 = {
			ja = 3.866,
			ko = 2.433,
			zh = 2.433
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
				arg_43_0:Play122111011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1032ui_story = arg_43_1.actors_["1032ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1032ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1032ui_story, Vector3.New(0, -1.05, -6.2), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1032ui_story"].transform.position).z)
				arg_43_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1032ui_story"].transform.localEulerAngles = arg_43_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1032ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_43_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1032ui_story"].transform.position).z)
				arg_43_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1032ui_story"].transform.localEulerAngles = arg_43_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1032ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1032ui_story == nil then
				arg_43_1.var_.characterEffect1032ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1032ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1032ui_story then
				arg_43_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action4_2")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_4 = 0
			local var_46_5 = 0.175

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(122111010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 7 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 7)

				if (7 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 7)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111010", "story_v_out_122111.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111010", "story_v_out_122111.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_122111", "122111010", "story_v_out_122111.awb")

						arg_43_1:RecordAudio("122111010", var_46_11)
						arg_43_1:RecordAudio("122111010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_122111", "122111010", "story_v_out_122111.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_122111", "122111010", "story_v_out_122111.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play122111011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 122111011
		arg_47_1.duration_ = 11.83

		local var_47_0 = {
			ja = 11.833,
			ko = 11,
			zh = 11
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
				arg_47_0:Play122111012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1032ui_story = arg_47_1.actors_["1032ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1032ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1032ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1032ui_story"].transform.position).z)
				arg_47_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1032ui_story"].transform.localEulerAngles = arg_47_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1032ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_47_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1032ui_story"].transform.position).z)
				arg_47_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1032ui_story"].transform.localEulerAngles = arg_47_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["1032ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1032ui_story == nil then
				arg_47_1.var_.characterEffect1032ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect1032ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_2)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1032ui_story then
				arg_47_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1032ui_story.fillRatio = 0.5
			end

			local var_50_3 = "1019ui_story"

			if arg_47_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_50_4 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_47_1.stage_.transform)

				var_50_4.name = var_50_3
				var_50_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_[var_50_3] = var_50_4

				local var_50_5 = var_50_4:GetComponentInChildren(typeof(CharacterEffect))

				var_50_5.enabled = true

				local var_50_6 = GameObjectTools.GetOrAddComponent(var_50_4, typeof(DynamicBoneHelper))

				if var_50_6 then
					var_50_6:EnableDynamicBone(false)
				end

				arg_47_1:ShowWeapon(var_50_5.transform, false)

				arg_47_1.var_[var_50_3 .. "Animator"] = var_50_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_47_1.var_[var_50_3 .. "Animator"].applyRootMotion = true
				arg_47_1.var_[var_50_3 .. "LipSync"] = var_50_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_50_7 = arg_47_1.actors_["1019ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1019ui_story = var_50_7.localPosition
			end

			local var_50_8 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_8 then
				var_50_7.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_47_1.time_ - 0) / var_50_8)
				var_50_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_7.position).x, (manager.ui.mainCamera.transform.position - var_50_7.position).y, (manager.ui.mainCamera.transform.position - var_50_7.position).z)
				var_50_7.localEulerAngles.z = 0
				var_50_7.localEulerAngles.x = 0
				var_50_7.localEulerAngles = var_50_7.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_8 and arg_47_1.time_ < 0 + var_50_8 + arg_50_0 then
				var_50_7.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_50_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_7.position).x, (manager.ui.mainCamera.transform.position - var_50_7.position).y, (manager.ui.mainCamera.transform.position - var_50_7.position).z)
				var_50_7.localEulerAngles.z = 0
				var_50_7.localEulerAngles.x = 0
				var_50_7.localEulerAngles = var_50_7.localEulerAngles
			end

			local var_50_9 = arg_47_1.actors_["1019ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_9) and arg_47_1.var_.characterEffect1019ui_story == nil then
				arg_47_1.var_.characterEffect1019ui_story = var_50_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_10 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_10 and not isNil(var_50_9) then
				if arg_47_1.var_.characterEffect1019ui_story and not isNil(var_50_9) then
					arg_47_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_10 and arg_47_1.time_ < 0 + var_50_10 + arg_50_0 and not isNil(var_50_9) and arg_47_1.var_.characterEffect1019ui_story then
				arg_47_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_12 = 0
			local var_50_13 = 1.2

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_12 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_14 = arg_47_1:GetWordFromCfg(122111011)
				local var_50_15 = arg_47_1:FormatText(var_50_14.content)

				arg_47_1.text_.text = var_50_15

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_17 = 48 <= 0 and var_50_13 or var_50_13 * (utf8.len(var_50_15) / 48)

				if (48 <= 0 and var_50_13 or var_50_13 * (utf8.len(var_50_15) / 48)) > 0 and var_50_13 < var_50_17 then
					arg_47_1.talkMaxDuration = var_50_17

					if var_50_17 + var_50_12 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_17 + var_50_12
					end
				end

				arg_47_1.text_.text = var_50_15
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111011", "story_v_out_122111.awb") ~= 0 then
					local var_50_18 = manager.audio:GetVoiceLength("story_v_out_122111", "122111011", "story_v_out_122111.awb") / 1000

					if var_50_18 + var_50_12 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_18 + var_50_12
					end

					if var_50_14.prefab_name ~= "" and arg_47_1.actors_[var_50_14.prefab_name] ~= nil then
						local var_50_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_14.prefab_name].transform, "story_v_out_122111", "122111011", "story_v_out_122111.awb")

						arg_47_1:RecordAudio("122111011", var_50_19)
						arg_47_1:RecordAudio("122111011", var_50_19)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_122111", "122111011", "story_v_out_122111.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_122111", "122111011", "story_v_out_122111.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_20 = math.max(var_50_13, arg_47_1.talkMaxDuration)

			if var_50_12 <= arg_47_1.time_ and arg_47_1.time_ < var_50_12 + var_50_20 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_12) / var_50_20

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_12 + var_50_20 and arg_47_1.time_ < var_50_12 + var_50_20 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play122111012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 122111012
		arg_51_1.duration_ = 5.17

		local var_51_0 = {
			ja = 5.166,
			ko = 1.766,
			zh = 1.766
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
				arg_51_0:Play122111013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.225

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:GetWordFromCfg(122111012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 9 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 9)

				if (9 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 9)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111012", "story_v_out_122111.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_122111", "122111012", "story_v_out_122111.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_122111", "122111012", "story_v_out_122111.awb")

						arg_51_1:RecordAudio("122111012", var_54_6)
						arg_51_1:RecordAudio("122111012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_122111", "122111012", "story_v_out_122111.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_122111", "122111012", "story_v_out_122111.awb")
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
	Play122111013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 122111013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play122111014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1019ui_story"]) and arg_55_1.var_.characterEffect1019ui_story == nil then
				arg_55_1.var_.characterEffect1019ui_story = arg_55_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1019ui_story"]) then
				if arg_55_1.var_.characterEffect1019ui_story and not isNil(arg_55_1.actors_["1019ui_story"]) then
					arg_55_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_0)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1019ui_story"]) and arg_55_1.var_.characterEffect1019ui_story then
				arg_55_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_58_1 = 0
			local var_58_2 = 0.125

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(122111013).content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 5 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 5)

				if (5 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 5)) > 0 and var_58_2 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_1
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_6 = math.max(var_58_2, arg_55_1.talkMaxDuration)

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_6 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_1) / var_58_6

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_1 + var_58_6 and arg_55_1.time_ < var_58_1 + var_58_6 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play122111014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 122111014
		arg_59_1.duration_ = 10.3

		local var_59_0 = {
			ja = 10.3,
			ko = 9.866,
			zh = 9.866
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
				arg_59_0:Play122111015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1019ui_story"]) and arg_59_1.var_.characterEffect1019ui_story == nil then
				arg_59_1.var_.characterEffect1019ui_story = arg_59_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1019ui_story"]) then
				if arg_59_1.var_.characterEffect1019ui_story and not isNil(arg_59_1.actors_["1019ui_story"]) then
					arg_59_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1019ui_story"]) and arg_59_1.var_.characterEffect1019ui_story then
				arg_59_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_62_2 = 0
			local var_62_3 = 1.15

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_4 = arg_59_1:GetWordFromCfg(122111014)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_7 = 46 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 46)

				if (46 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 46)) > 0 and var_62_3 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111014", "story_v_out_122111.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111014", "story_v_out_122111.awb") / 1000

					if var_62_8 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_2
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_out_122111", "122111014", "story_v_out_122111.awb")

						arg_59_1:RecordAudio("122111014", var_62_9)
						arg_59_1:RecordAudio("122111014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_122111", "122111014", "story_v_out_122111.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_122111", "122111014", "story_v_out_122111.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_3, arg_59_1.talkMaxDuration)

			if var_62_2 <= arg_59_1.time_ and arg_59_1.time_ < var_62_2 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_2) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_2 + var_62_10 and arg_59_1.time_ < var_62_2 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play122111015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 122111015
		arg_63_1.duration_ = 8.33

		local var_63_0 = {
			ja = 8.333,
			ko = 7.466,
			zh = 7.466
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
				arg_63_0:Play122111016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1019ui_story"]) and arg_63_1.var_.characterEffect1019ui_story == nil then
				arg_63_1.var_.characterEffect1019ui_story = arg_63_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1019ui_story"]) then
				if arg_63_1.var_.characterEffect1019ui_story and not isNil(arg_63_1.actors_["1019ui_story"]) then
					arg_63_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1019ui_story"]) and arg_63_1.var_.characterEffect1019ui_story then
				arg_63_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_66_1 = arg_63_1.actors_["1032ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1032ui_story == nil then
				arg_63_1.var_.characterEffect1032ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect1032ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1032ui_story then
				arg_63_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action8_1")
			end

			local var_66_4 = 0
			local var_66_5 = 0.975

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(122111015)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 39 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 39)

				if (39 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 39)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111015", "story_v_out_122111.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111015", "story_v_out_122111.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_out_122111", "122111015", "story_v_out_122111.awb")

						arg_63_1:RecordAudio("122111015", var_66_11)
						arg_63_1:RecordAudio("122111015", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_122111", "122111015", "story_v_out_122111.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_122111", "122111015", "story_v_out_122111.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play122111016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 122111016
		arg_67_1.duration_ = 6.8

		local var_67_0 = {
			ja = 6.8,
			ko = 5.933,
			zh = 5.933
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
				arg_67_0:Play122111017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.8

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(122111016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 32 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 32)

				if (32 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 32)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111016", "story_v_out_122111.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_122111", "122111016", "story_v_out_122111.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_122111", "122111016", "story_v_out_122111.awb")

						arg_67_1:RecordAudio("122111016", var_70_6)
						arg_67_1:RecordAudio("122111016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_122111", "122111016", "story_v_out_122111.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_122111", "122111016", "story_v_out_122111.awb")
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
	Play122111017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 122111017
		arg_71_1.duration_ = 9

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play122111018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 2 < arg_71_1.time_ and arg_71_1.time_ <= 2 + arg_74_0 then
				local var_74_0 = arg_71_1.bgs_.ST07b

				arg_71_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_74_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_1 = var_74_0:GetComponent("SpriteRenderer")

				if var_74_1 and var_74_1.sprite then
					local var_74_2 = 2 * (var_74_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_74_0.transform.localScale = Vector3.New(var_74_2 / var_74_1.sprite.bounds.size.y < var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x and var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x or var_74_2 / var_74_1.sprite.bounds.size.y, var_74_2 / var_74_1.sprite.bounds.size.y < var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x and var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x or var_74_2 / var_74_1.sprite.bounds.size.y, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "ST07b" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_3 = arg_71_1.actors_["1032ui_story"].transform

			if 1.96599999815226 < arg_71_1.time_ and arg_71_1.time_ <= 1.96599999815226 + arg_74_0 then
				arg_71_1.var_.moveOldPos1032ui_story = var_74_3.localPosition
			end

			local var_74_4 = 0.001

			if 1.96599999815226 <= arg_71_1.time_ and arg_71_1.time_ < 1.96599999815226 + var_74_4 then
				var_74_3.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1032ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 1.96599999815226) / var_74_4)
				var_74_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_3.position).x, (manager.ui.mainCamera.transform.position - var_74_3.position).y, (manager.ui.mainCamera.transform.position - var_74_3.position).z)
				var_74_3.localEulerAngles.z = 0
				var_74_3.localEulerAngles.x = 0
				var_74_3.localEulerAngles = var_74_3.localEulerAngles
			end

			if arg_71_1.time_ >= 1.96599999815226 + var_74_4 and arg_71_1.time_ < 1.96599999815226 + var_74_4 + arg_74_0 then
				var_74_3.localPosition = Vector3.New(0, 100, 0)
				var_74_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_3.position).x, (manager.ui.mainCamera.transform.position - var_74_3.position).y, (manager.ui.mainCamera.transform.position - var_74_3.position).z)
				var_74_3.localEulerAngles.z = 0
				var_74_3.localEulerAngles.x = 0
				var_74_3.localEulerAngles = var_74_3.localEulerAngles
			end

			local var_74_5 = arg_71_1.actors_["1032ui_story"]

			if 1.96599999815226 < arg_71_1.time_ and arg_71_1.time_ <= 1.96599999815226 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.characterEffect1032ui_story == nil then
				arg_71_1.var_.characterEffect1032ui_story = var_74_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_6 = 0.034000001847744

			if 1.96599999815226 <= arg_71_1.time_ and arg_71_1.time_ < 1.96599999815226 + var_74_6 and not isNil(var_74_5) then
				if arg_71_1.var_.characterEffect1032ui_story and not isNil(var_74_5) then
					arg_71_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 1.96599999815226) / var_74_6)
				end
			end

			if arg_71_1.time_ >= 1.96599999815226 + var_74_6 and arg_71_1.time_ < 1.96599999815226 + var_74_6 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.characterEffect1032ui_story then
				arg_71_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1032ui_story.fillRatio = 0.5
			end

			local var_74_7 = arg_71_1.actors_["1019ui_story"].transform

			if 1.96599999815226 < arg_71_1.time_ and arg_71_1.time_ <= 1.96599999815226 + arg_74_0 then
				arg_71_1.var_.moveOldPos1019ui_story = var_74_7.localPosition
			end

			local var_74_8 = 0.001

			if 1.96599999815226 <= arg_71_1.time_ and arg_71_1.time_ < 1.96599999815226 + var_74_8 then
				var_74_7.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 1.96599999815226) / var_74_8)
				var_74_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_7.position).x, (manager.ui.mainCamera.transform.position - var_74_7.position).y, (manager.ui.mainCamera.transform.position - var_74_7.position).z)
				var_74_7.localEulerAngles.z = 0
				var_74_7.localEulerAngles.x = 0
				var_74_7.localEulerAngles = var_74_7.localEulerAngles
			end

			if arg_71_1.time_ >= 1.96599999815226 + var_74_8 and arg_71_1.time_ < 1.96599999815226 + var_74_8 + arg_74_0 then
				var_74_7.localPosition = Vector3.New(0, 100, 0)
				var_74_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_7.position).x, (manager.ui.mainCamera.transform.position - var_74_7.position).y, (manager.ui.mainCamera.transform.position - var_74_7.position).z)
				var_74_7.localEulerAngles.z = 0
				var_74_7.localEulerAngles.x = 0
				var_74_7.localEulerAngles = var_74_7.localEulerAngles
			end

			local var_74_9 = arg_71_1.actors_["1019ui_story"]

			if 1.96599999815226 < arg_71_1.time_ and arg_71_1.time_ <= 1.96599999815226 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1019ui_story == nil then
				arg_71_1.var_.characterEffect1019ui_story = var_74_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_10 = 0.034000001847744

			if 1.96599999815226 <= arg_71_1.time_ and arg_71_1.time_ < 1.96599999815226 + var_74_10 and not isNil(var_74_9) then
				if arg_71_1.var_.characterEffect1019ui_story and not isNil(var_74_9) then
					arg_71_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 1.96599999815226) / var_74_10)
				end
			end

			if arg_71_1.time_ >= 1.96599999815226 + var_74_10 and arg_71_1.time_ < 1.96599999815226 + var_74_10 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1019ui_story then
				arg_71_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_74_11 = 2

			arg_71_1.isInRecall_ = false

			if var_74_11 < arg_71_1.time_ and arg_71_1.time_ <= var_74_11 + arg_74_0 then
				arg_71_1.screenFilterGo_:SetActive(false)

				for iter_74_2, iter_74_3 in pairs(arg_71_1.actors_) do
					for iter_74_4, iter_74_5 in ipairs((iter_74_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_74_5.color = iter_74_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_74_12 = 0.0166666666666667

			if var_74_11 <= arg_71_1.time_ and arg_71_1.time_ < var_74_11 + var_74_12 then
				arg_71_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_71_1.time_ - var_74_11) / var_74_12)
			end

			if arg_71_1.time_ >= var_74_11 + var_74_12 and arg_71_1.time_ < var_74_11 + var_74_12 + arg_74_0 then
				arg_71_1.screenFilterEffect_.weight = 0
			end

			local var_74_13 = 0

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_13 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_14 = 2

			if var_74_13 <= arg_71_1.time_ and arg_71_1.time_ < var_74_13 + var_74_14 then
				local var_74_15 = Color.New(0, 0, 0)

				var_74_15.a = Mathf.Lerp(0, 1, (arg_71_1.time_ - var_74_13) / var_74_14)
				arg_71_1.mask_.color = var_74_15
			end

			if arg_71_1.time_ >= var_74_13 + var_74_14 and arg_71_1.time_ < var_74_13 + var_74_14 + arg_74_0 then
				local var_74_16 = Color.New(0, 0, 0)

				var_74_16.a = 1
				arg_71_1.mask_.color = var_74_16
			end

			local var_74_17 = 2

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_17 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_18 = 2

			if var_74_17 <= arg_71_1.time_ and arg_71_1.time_ < var_74_17 + var_74_18 then
				local var_74_19 = Color.New(0, 0, 0)

				var_74_19.a = Mathf.Lerp(1, 0, (arg_71_1.time_ - var_74_17) / var_74_18)
				arg_71_1.mask_.color = var_74_19
			end

			if arg_71_1.time_ >= var_74_17 + var_74_18 and arg_71_1.time_ < var_74_17 + var_74_18 + arg_74_0 then
				local var_74_20 = Color.New(0, 0, 0)

				arg_71_1.mask_.enabled = false
				var_74_20.a = 0
				arg_71_1.mask_.color = var_74_20
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_74_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_23 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_23

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_23
						arg_71_1.bgmTxt2_.text = var_74_23
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_24 = 4
			local var_74_25 = 0.3

			if 4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_24 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_26 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_26:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_71_1.dialogCg_.alpha = arg_76_0
				end))
				var_74_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_27 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(122111017).content)

				arg_71_1.text_.text = var_74_27

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_29 = 12 <= 0 and var_74_25 or var_74_25 * (utf8.len(var_74_27) / 12)

				if (12 <= 0 and var_74_25 or var_74_25 * (utf8.len(var_74_27) / 12)) > 0 and var_74_25 < var_74_29 then
					arg_71_1.talkMaxDuration = var_74_29
					var_74_24 = var_74_24 + 0.3

					if var_74_29 + var_74_24 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_29 + var_74_24
					end
				end

				arg_71_1.text_.text = var_74_27
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_30 = var_74_24 + 0.3
			local var_74_31 = math.max(var_74_25, arg_71_1.talkMaxDuration)

			if var_74_24 + 0.3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_30 + var_74_31 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_30) / var_74_31

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_30 + var_74_31 and arg_71_1.time_ < var_74_30 + var_74_31 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play122111018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 122111018
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play122111019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 1.1

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_1 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(122111018).content)

				arg_78_1.text_.text = var_81_1

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_3 = 44 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 44)

				if (44 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 44)) > 0 and var_81_0 < var_81_3 then
					arg_78_1.talkMaxDuration = var_81_3

					if var_81_3 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_3 + 0
					end
				end

				arg_78_1.text_.text = var_81_1
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_4 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_4

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play122111019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 122111019
		arg_82_1.duration_ = 9

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play122111020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if arg_82_1.bgs_.S0012 == nil then
				local var_85_0 = Object.Instantiate(arg_82_1.paintGo_)

				var_85_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0012")
				var_85_0.name = "S0012"
				var_85_0.transform.parent = arg_82_1.stage_.transform
				var_85_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_82_1.bgs_.S0012 = var_85_0
			end

			if 2 < arg_82_1.time_ and arg_82_1.time_ <= 2 + arg_85_0 then
				local var_85_1 = arg_82_1.bgs_.S0012

				arg_82_1.bgs_.S0012.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_85_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_85_2 = var_85_1:GetComponent("SpriteRenderer")

				if var_85_2 and var_85_2.sprite then
					local var_85_3 = 2 * (var_85_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_85_1.transform.localScale = Vector3.New(var_85_3 / var_85_2.sprite.bounds.size.y < var_85_3 * manager.ui.mainCameraCom_.aspect / var_85_2.sprite.bounds.size.x and var_85_3 * manager.ui.mainCameraCom_.aspect / var_85_2.sprite.bounds.size.x or var_85_3 / var_85_2.sprite.bounds.size.y, var_85_3 / var_85_2.sprite.bounds.size.y < var_85_3 * manager.ui.mainCameraCom_.aspect / var_85_2.sprite.bounds.size.x and var_85_3 * manager.ui.mainCameraCom_.aspect / var_85_2.sprite.bounds.size.x or var_85_3 / var_85_2.sprite.bounds.size.y, 0)
				end

				for iter_85_0, iter_85_1 in pairs(arg_82_1.bgs_) do
					if iter_85_0 ~= "S0012" then
						iter_85_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_85_4 = 0

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.mask_.enabled = true
				arg_82_1.mask_.raycastTarget = true

				arg_82_1:SetGaussion(false)
			end

			local var_85_5 = 2

			if var_85_4 <= arg_82_1.time_ and arg_82_1.time_ < var_85_4 + var_85_5 then
				local var_85_6 = Color.New(0, 0, 0)

				var_85_6.a = Mathf.Lerp(0, 1, (arg_82_1.time_ - var_85_4) / var_85_5)
				arg_82_1.mask_.color = var_85_6
			end

			if arg_82_1.time_ >= var_85_4 + var_85_5 and arg_82_1.time_ < var_85_4 + var_85_5 + arg_85_0 then
				local var_85_7 = Color.New(0, 0, 0)

				var_85_7.a = 1
				arg_82_1.mask_.color = var_85_7
			end

			local var_85_8 = 2

			if 2 < arg_82_1.time_ and arg_82_1.time_ <= var_85_8 + arg_85_0 then
				arg_82_1.mask_.enabled = true
				arg_82_1.mask_.raycastTarget = true

				arg_82_1:SetGaussion(false)
			end

			local var_85_9 = 2

			if var_85_8 <= arg_82_1.time_ and arg_82_1.time_ < var_85_8 + var_85_9 then
				local var_85_10 = Color.New(0, 0, 0)

				var_85_10.a = Mathf.Lerp(1, 0, (arg_82_1.time_ - var_85_8) / var_85_9)
				arg_82_1.mask_.color = var_85_10
			end

			if arg_82_1.time_ >= var_85_8 + var_85_9 and arg_82_1.time_ < var_85_8 + var_85_9 + arg_85_0 then
				local var_85_11 = Color.New(0, 0, 0)

				arg_82_1.mask_.enabled = false
				var_85_11.a = 0
				arg_82_1.mask_.color = var_85_11
			end

			if arg_82_1.frameCnt_ <= 1 then
				arg_82_1.dialog_:SetActive(false)
			end

			local var_85_12 = 4
			local var_85_13 = 1.2

			if 4 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				arg_82_1.dialog_:SetActive(true)

				arg_82_1.dialogCg_.alpha = 0

				local var_85_14 = LeanTween.value(arg_82_1.dialog_, 0, 1, 0.3)

				var_85_14:setOnUpdate(LuaHelper.FloatAction(function(arg_86_0)
					arg_82_1.dialogCg_.alpha = arg_86_0
				end))
				var_85_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_82_1.dialog_)
					var_85_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_82_1.duration_ = arg_82_1.duration_ + 0.3

				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_15 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(122111019).content)

				arg_82_1.text_.text = var_85_15

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_17 = 48 <= 0 and var_85_13 or var_85_13 * (utf8.len(var_85_15) / 48)

				if (48 <= 0 and var_85_13 or var_85_13 * (utf8.len(var_85_15) / 48)) > 0 and var_85_13 < var_85_17 then
					arg_82_1.talkMaxDuration = var_85_17
					var_85_12 = var_85_12 + 0.3

					if var_85_17 + var_85_12 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_17 + var_85_12
					end
				end

				arg_82_1.text_.text = var_85_15
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_18 = var_85_12 + 0.3
			local var_85_19 = math.max(var_85_13, arg_82_1.talkMaxDuration)

			if var_85_12 + 0.3 <= arg_82_1.time_ and arg_82_1.time_ < var_85_18 + var_85_19 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_18) / var_85_19

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_18 + var_85_19 and arg_82_1.time_ < var_85_18 + var_85_19 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play122111020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 122111020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play122111021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1.5

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(122111020).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 60 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 60)

				if (60 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 60)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play122111021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 122111021
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play122111022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 1.525

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_1 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(122111021).content)

				arg_92_1.text_.text = var_95_1

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_3 = 61 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 61)

				if (61 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 61)) > 0 and var_95_0 < var_95_3 then
					arg_92_1.talkMaxDuration = var_95_3

					if var_95_3 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_3 + 0
					end
				end

				arg_92_1.text_.text = var_95_1
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_4 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_4

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play122111022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 122111022
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play122111023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.15

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_1 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(122111022).content)

				arg_96_1.text_.text = var_99_1

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_3 = 6 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 6)

				if (6 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 6)) > 0 and var_99_0 < var_99_3 then
					arg_96_1.talkMaxDuration = var_99_3

					if var_99_3 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_3 + 0
					end
				end

				arg_96_1.text_.text = var_99_1
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_4 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_4

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play122111023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 122111023
		arg_100_1.duration_ = 1.73

		local var_100_0 = {
			ja = 1.733,
			ko = 1.6,
			zh = 1.6
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
				arg_100_0:Play122111024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:AudioAction("play", "music", "bgm_activity_2_2_story_ver_1_short", "bgm_activity_2_2_story_ver_1_short", "bgm_activity_2_2_story_ver_1_short.awb")

				local var_103_2 = manager.audio:GetAudioName("bgm_activity_2_2_story_ver_1_short", "bgm_activity_2_2_story_ver_1_short")

				if "" ~= "" then
					if arg_100_1.bgmTxt_.text ~= var_103_2 and arg_100_1.bgmTxt_.text ~= "" then
						if arg_100_1.bgmTxt2_.text ~= "" then
							arg_100_1.bgmTxt_.text = arg_100_1.bgmTxt2_.text
						end

						arg_100_1.bgmTxt2_.text = var_103_2

						arg_100_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_100_1.bgmTxt_.text = var_103_2
						arg_100_1.bgmTxt2_.text = var_103_2
					end

					if arg_100_1.bgmTimer then
						arg_100_1.bgmTimer:Stop()

						arg_100_1.bgmTimer = nil
					end

					if arg_100_1.settingData.show_music_name == 1 then
						arg_100_1.musicController:SetSelectedState("show")
						arg_100_1.musicAnimator_:Play("open", 0, 0)

						if arg_100_1.settingData.music_time ~= 0 then
							arg_100_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_100_1.settingData.music_time), function()
								if arg_100_1 == nil or isNil(arg_100_1.bgmTxt_) then
									return
								end

								arg_100_1.musicController:SetSelectedState("hide")
								arg_100_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_103_3 = 0
			local var_103_4 = 0.125

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_3 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_5 = arg_100_1:GetWordFromCfg(122111023)
				local var_103_6 = arg_100_1:FormatText(var_103_5.content)

				arg_100_1.text_.text = var_103_6

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_8 = 5 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_6) / 5)

				if (5 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_6) / 5)) > 0 and var_103_4 < var_103_8 then
					arg_100_1.talkMaxDuration = var_103_8

					if var_103_8 + var_103_3 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_3
					end
				end

				arg_100_1.text_.text = var_103_6
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111023", "story_v_out_122111.awb") ~= 0 then
					local var_103_9 = manager.audio:GetVoiceLength("story_v_out_122111", "122111023", "story_v_out_122111.awb") / 1000

					if var_103_9 + var_103_3 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_3
					end

					if var_103_5.prefab_name ~= "" and arg_100_1.actors_[var_103_5.prefab_name] ~= nil then
						local var_103_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_5.prefab_name].transform, "story_v_out_122111", "122111023", "story_v_out_122111.awb")

						arg_100_1:RecordAudio("122111023", var_103_10)
						arg_100_1:RecordAudio("122111023", var_103_10)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_122111", "122111023", "story_v_out_122111.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_122111", "122111023", "story_v_out_122111.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_11 = math.max(var_103_4, arg_100_1.talkMaxDuration)

			if var_103_3 <= arg_100_1.time_ and arg_100_1.time_ < var_103_3 + var_103_11 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_3) / var_103_11

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_3 + var_103_11 and arg_100_1.time_ < var_103_3 + var_103_11 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play122111024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 122111024
		arg_105_1.duration_ = 7

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play122111025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				local var_108_0 = arg_105_1.bgs_.ST07b

				arg_105_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_108_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_1 = var_108_0:GetComponent("SpriteRenderer")

				if var_108_1 and var_108_1.sprite then
					local var_108_2 = 2 * (var_108_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_108_0.transform.localScale = Vector3.New(var_108_2 / var_108_1.sprite.bounds.size.y < var_108_2 * manager.ui.mainCameraCom_.aspect / var_108_1.sprite.bounds.size.x and var_108_2 * manager.ui.mainCameraCom_.aspect / var_108_1.sprite.bounds.size.x or var_108_2 / var_108_1.sprite.bounds.size.y, var_108_2 / var_108_1.sprite.bounds.size.y < var_108_2 * manager.ui.mainCameraCom_.aspect / var_108_1.sprite.bounds.size.x and var_108_2 * manager.ui.mainCameraCom_.aspect / var_108_1.sprite.bounds.size.x or var_108_2 / var_108_1.sprite.bounds.size.y, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "ST07b" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_3 = 0

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_3 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = false

				arg_105_1:SetGaussion(false)
			end

			local var_108_4 = 2

			if var_108_3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_3 + var_108_4 then
				local var_108_5 = Color.New(1, 1, 1)

				var_108_5.a = Mathf.Lerp(1, 0, (arg_105_1.time_ - var_108_3) / var_108_4)
				arg_105_1.mask_.color = var_108_5
			end

			if arg_105_1.time_ >= var_108_3 + var_108_4 and arg_105_1.time_ < var_108_3 + var_108_4 + arg_108_0 then
				local var_108_6 = Color.New(1, 1, 1)

				arg_105_1.mask_.enabled = false
				var_108_6.a = 0
				arg_105_1.mask_.color = var_108_6
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_7 = 1.999999999999
			local var_108_8 = 1

			if 1.999999999999 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_9 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_9:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(122111024).content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_12 = 40 <= 0 and var_108_8 or var_108_8 * (utf8.len(var_108_10) / 40)

				if (40 <= 0 and var_108_8 or var_108_8 * (utf8.len(var_108_10) / 40)) > 0 and var_108_8 < var_108_12 then
					arg_105_1.talkMaxDuration = var_108_12
					var_108_7 = var_108_7 + 0.3

					if var_108_12 + var_108_7 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_7
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_13 = var_108_7 + 0.3
			local var_108_14 = math.max(var_108_8, arg_105_1.talkMaxDuration)

			if var_108_7 + 0.3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_13 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_13) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_13 + var_108_14 and arg_105_1.time_ < var_108_13 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play122111025 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 122111025
		arg_111_1.duration_ = 1

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"

			SetActive(arg_111_1.choicesGo_, true)

			for iter_112_0, iter_112_1 in ipairs(arg_111_1.choices_) do
				SetActive(iter_112_1.go, iter_112_0 <= 1)
			end

			arg_111_1.choices_[1].txt.text = arg_111_1:FormatText(StoryChoiceCfg[434].name)
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play122111026(arg_111_1)
			end

			arg_111_1:RecordChoiceLog(122111025, 434)
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			if arg_111_1.time_ >= 0 + 1 and arg_111_1.time_ < 0 + 1 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play122111026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 122111026
		arg_115_1.duration_ = 4.63

		local var_115_0 = {
			ja = 4.133,
			ko = 4.633,
			zh = 4.633
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
				arg_115_0:Play122111027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if arg_115_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_118_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_115_1.stage_.transform)

				var_118_0.name = "1084ui_story"
				var_118_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_["1084ui_story"] = var_118_0

				local var_118_1 = var_118_0:GetComponentInChildren(typeof(CharacterEffect))

				var_118_1.enabled = true

				local var_118_2 = GameObjectTools.GetOrAddComponent(var_118_0, typeof(DynamicBoneHelper))

				if var_118_2 then
					var_118_2:EnableDynamicBone(false)
				end

				arg_115_1:ShowWeapon(var_118_1.transform, false)

				arg_115_1.var_["1084ui_story" .. "Animator"] = var_118_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_115_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_115_1.var_["1084ui_story" .. "LipSync"] = var_118_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_118_3 = arg_115_1.actors_["1084ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1084ui_story = var_118_3.localPosition
			end

			local var_118_4 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				var_118_3.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_115_1.time_ - 0) / var_118_4)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_3.localPosition = Vector3.New(0, -0.97, -6)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			local var_118_5 = arg_115_1.actors_["1084ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_6 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_6 and not isNil(var_118_5) then
				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_5) then
					arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_6 and arg_115_1.time_ < 0 + var_118_6 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.characterEffect1084ui_story then
				arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_118_8 = 0
			local var_118_9 = 0.375

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_10 = arg_115_1:GetWordFromCfg(122111026)
				local var_118_11 = arg_115_1:FormatText(var_118_10.content)

				arg_115_1.text_.text = var_118_11

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 15 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 15)

				if (15 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 15)) > 0 and var_118_9 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_11
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111026", "story_v_out_122111.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_122111", "122111026", "story_v_out_122111.awb") / 1000

					if var_118_14 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_8
					end

					if var_118_10.prefab_name ~= "" and arg_115_1.actors_[var_118_10.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_10.prefab_name].transform, "story_v_out_122111", "122111026", "story_v_out_122111.awb")

						arg_115_1:RecordAudio("122111026", var_118_15)
						arg_115_1:RecordAudio("122111026", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_122111", "122111026", "story_v_out_122111.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_122111", "122111026", "story_v_out_122111.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_16 = math.max(var_118_9, arg_115_1.talkMaxDuration)

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_16 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_8) / var_118_16

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_8 + var_118_16 and arg_115_1.time_ < var_118_8 + var_118_16 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play122111027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 122111027
		arg_119_1.duration_ = 4.43

		local var_119_0 = {
			ja = 4.433,
			ko = 2.733,
			zh = 2.733
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
				arg_119_0:Play122111028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1084ui_story = arg_119_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).z)
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles = arg_119_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_119_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).z)
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles = arg_119_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1084ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1084ui_story == nil then
				arg_119_1.var_.characterEffect1084ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1084ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1084ui_story then
				arg_119_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action427")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_122_4 = 0
			local var_122_5 = 0.35

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(122111027)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 14 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 14)

				if (14 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 14)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111027", "story_v_out_122111.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111027", "story_v_out_122111.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_122111", "122111027", "story_v_out_122111.awb")

						arg_119_1:RecordAudio("122111027", var_122_11)
						arg_119_1:RecordAudio("122111027", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_122111", "122111027", "story_v_out_122111.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_122111", "122111027", "story_v_out_122111.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play122111028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 122111028
		arg_123_1.duration_ = 0.5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"

			SetActive(arg_123_1.choicesGo_, true)

			for iter_124_0, iter_124_1 in ipairs(arg_123_1.choices_) do
				SetActive(iter_124_1.go, iter_124_0 <= 1)
			end

			arg_123_1.choices_[1].txt.text = arg_123_1:FormatText(StoryChoiceCfg[435].name)
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play122111029(arg_123_1)
			end

			arg_123_1:RecordChoiceLog(122111028, 435)
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1084ui_story"]) and arg_123_1.var_.characterEffect1084ui_story == nil then
				arg_123_1.var_.characterEffect1084ui_story = arg_123_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1084ui_story"]) then
				if arg_123_1.var_.characterEffect1084ui_story and not isNil(arg_123_1.actors_["1084ui_story"]) then
					arg_123_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_0)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1084ui_story"]) and arg_123_1.var_.characterEffect1084ui_story then
				arg_123_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_126_1 = 0

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.allBtn_.enabled = false
			end

			if arg_123_1.time_ >= var_126_1 + 0.5 and arg_123_1.time_ < var_126_1 + 0.5 + arg_126_0 then
				arg_123_1.allBtn_.enabled = true
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play122111029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 122111029
		arg_127_1.duration_ = 8.4

		local var_127_0 = {
			ja = 8.4,
			ko = 4.733,
			zh = 4.733
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
				arg_127_0:Play122111030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1084ui_story = arg_127_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1084ui_story"].transform.position).z)
				arg_127_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1084ui_story"].transform.localEulerAngles = arg_127_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_127_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1084ui_story"].transform.position).z)
				arg_127_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1084ui_story"].transform.localEulerAngles = arg_127_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1084ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1084ui_story == nil then
				arg_127_1.var_.characterEffect1084ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1084ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1084ui_story then
				arg_127_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_4 = 0
			local var_130_5 = 0.525

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(122111029)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 21 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 21)

				if (21 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 21)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111029", "story_v_out_122111.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111029", "story_v_out_122111.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_122111", "122111029", "story_v_out_122111.awb")

						arg_127_1:RecordAudio("122111029", var_130_11)
						arg_127_1:RecordAudio("122111029", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_122111", "122111029", "story_v_out_122111.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_122111", "122111029", "story_v_out_122111.awb")
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
				actorName = "1084ui_story",
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
	Play122111030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 122111030
		arg_131_1.duration_ = 1

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"

			SetActive(arg_131_1.choicesGo_, true)

			for iter_132_0, iter_132_1 in ipairs(arg_131_1.choices_) do
				SetActive(iter_132_1.go, iter_132_0 <= 2)
			end

			arg_131_1.choices_[1].txt.text = arg_131_1:FormatText(StoryChoiceCfg[436].name)
			arg_131_1.choices_[2].txt.text = arg_131_1:FormatText(StoryChoiceCfg[437].name)
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play122111031(arg_131_1)
			end

			if arg_133_0 == 2 then
				arg_131_0:Play122111031(arg_131_1)
			end

			arg_131_1:RecordChoiceLog(122111030, 436, 437)
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1084ui_story"]) and arg_131_1.var_.characterEffect1084ui_story == nil then
				arg_131_1.var_.characterEffect1084ui_story = arg_131_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1084ui_story"]) then
				if arg_131_1.var_.characterEffect1084ui_story and not isNil(arg_131_1.actors_["1084ui_story"]) then
					arg_131_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1084ui_story"]) and arg_131_1.var_.characterEffect1084ui_story then
				arg_131_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play122111031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 122111031
		arg_135_1.duration_ = 1

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"

			SetActive(arg_135_1.choicesGo_, true)

			for iter_136_0, iter_136_1 in ipairs(arg_135_1.choices_) do
				SetActive(iter_136_1.go, iter_136_0 <= 1)
			end

			arg_135_1.choices_[1].txt.text = arg_135_1:FormatText(StoryChoiceCfg[438].name)
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play122111032(arg_135_1)
			end

			arg_135_1:RecordChoiceLog(122111031, 438)
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			if arg_135_1.time_ >= 0 + 0.5 and arg_135_1.time_ < 0 + 0.5 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play122111032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 122111032
		arg_139_1.duration_ = 7.27

		local var_139_0 = {
			ja = 7.266,
			ko = 4.666,
			zh = 4.666
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
				arg_139_0:Play122111033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1084ui_story"]) and arg_139_1.var_.characterEffect1084ui_story == nil then
				arg_139_1.var_.characterEffect1084ui_story = arg_139_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1084ui_story"]) then
				if arg_139_1.var_.characterEffect1084ui_story and not isNil(arg_139_1.actors_["1084ui_story"]) then
					arg_139_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1084ui_story"]) and arg_139_1.var_.characterEffect1084ui_story then
				arg_139_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_2 = 0
			local var_142_3 = 0.625

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_4 = arg_139_1:GetWordFromCfg(122111032)
				local var_142_5 = arg_139_1:FormatText(var_142_4.content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 25 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 25)

				if (25 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 25)) > 0 and var_142_3 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111032", "story_v_out_122111.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111032", "story_v_out_122111.awb") / 1000

					if var_142_8 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_2
					end

					if var_142_4.prefab_name ~= "" and arg_139_1.actors_[var_142_4.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_4.prefab_name].transform, "story_v_out_122111", "122111032", "story_v_out_122111.awb")

						arg_139_1:RecordAudio("122111032", var_142_9)
						arg_139_1:RecordAudio("122111032", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_122111", "122111032", "story_v_out_122111.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_122111", "122111032", "story_v_out_122111.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_10 and arg_139_1.time_ < var_142_2 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play122111033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 122111033
		arg_143_1.duration_ = 7.1

		local var_143_0 = {
			ja = 7.1,
			ko = 3,
			zh = 3
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
				arg_143_0:Play122111034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_146_0 = 0
			local var_146_1 = 0.4

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_2 = arg_143_1:GetWordFromCfg(122111033)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 16 <= 0 and var_146_1 or var_146_1 * (utf8.len(var_146_3) / 16)

				if (16 <= 0 and var_146_1 or var_146_1 * (utf8.len(var_146_3) / 16)) > 0 and var_146_1 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111033", "story_v_out_122111.awb") ~= 0 then
					local var_146_6 = manager.audio:GetVoiceLength("story_v_out_122111", "122111033", "story_v_out_122111.awb") / 1000

					if var_146_6 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_0
					end

					if var_146_2.prefab_name ~= "" and arg_143_1.actors_[var_146_2.prefab_name] ~= nil then
						local var_146_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_2.prefab_name].transform, "story_v_out_122111", "122111033", "story_v_out_122111.awb")

						arg_143_1:RecordAudio("122111033", var_146_7)
						arg_143_1:RecordAudio("122111033", var_146_7)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_122111", "122111033", "story_v_out_122111.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_122111", "122111033", "story_v_out_122111.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_8 and arg_143_1.time_ < var_146_0 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play122111034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 122111034
		arg_147_1.duration_ = 12.7

		local var_147_0 = {
			ja = 12.7,
			ko = 7.9,
			zh = 7.9
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
				arg_147_0:Play122111035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action483")
			end

			local var_150_0 = 0
			local var_150_1 = 0.925

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:GetWordFromCfg(122111034)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 37 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_3) / 37)

				if (37 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_3) / 37)) > 0 and var_150_1 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111034", "story_v_out_122111.awb") ~= 0 then
					local var_150_6 = manager.audio:GetVoiceLength("story_v_out_122111", "122111034", "story_v_out_122111.awb") / 1000

					if var_150_6 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_0
					end

					if var_150_2.prefab_name ~= "" and arg_147_1.actors_[var_150_2.prefab_name] ~= nil then
						local var_150_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_2.prefab_name].transform, "story_v_out_122111", "122111034", "story_v_out_122111.awb")

						arg_147_1:RecordAudio("122111034", var_150_7)
						arg_147_1:RecordAudio("122111034", var_150_7)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_122111", "122111034", "story_v_out_122111.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_122111", "122111034", "story_v_out_122111.awb")
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
	Play122111035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 122111035
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play122111036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1084ui_story"]) and arg_151_1.var_.characterEffect1084ui_story == nil then
				arg_151_1.var_.characterEffect1084ui_story = arg_151_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1084ui_story"]) then
				if arg_151_1.var_.characterEffect1084ui_story and not isNil(arg_151_1.actors_["1084ui_story"]) then
					arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1084ui_story"]) and arg_151_1.var_.characterEffect1084ui_story then
				arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 0.325

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
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

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(122111035).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 13 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 13)

				if (13 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 13)) > 0 and var_154_2 < var_154_5 then
					arg_151_1.talkMaxDuration = var_154_5

					if var_154_5 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_6 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_6 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_6

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_6 and arg_151_1.time_ < var_154_1 + var_154_6 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play122111036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 122111036
		arg_155_1.duration_ = 10.23

		local var_155_0 = {
			ja = 10.233,
			ko = 8,
			zh = 8
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
				arg_155_0:Play122111037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1084ui_story"]) and arg_155_1.var_.characterEffect1084ui_story == nil then
				arg_155_1.var_.characterEffect1084ui_story = arg_155_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1084ui_story"]) then
				if arg_155_1.var_.characterEffect1084ui_story and not isNil(arg_155_1.actors_["1084ui_story"]) then
					arg_155_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1084ui_story"]) and arg_155_1.var_.characterEffect1084ui_story then
				arg_155_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_158_2 = 0
			local var_158_3 = 0.775

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(122111036)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 31 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 31)

				if (31 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 31)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111036", "story_v_out_122111.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111036", "story_v_out_122111.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_out_122111", "122111036", "story_v_out_122111.awb")

						arg_155_1:RecordAudio("122111036", var_158_9)
						arg_155_1:RecordAudio("122111036", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_122111", "122111036", "story_v_out_122111.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_122111", "122111036", "story_v_out_122111.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_10 and arg_155_1.time_ < var_158_2 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play122111037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 122111037
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play122111038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1084ui_story"]) and arg_159_1.var_.characterEffect1084ui_story == nil then
				arg_159_1.var_.characterEffect1084ui_story = arg_159_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1084ui_story"]) then
				if arg_159_1.var_.characterEffect1084ui_story and not isNil(arg_159_1.actors_["1084ui_story"]) then
					arg_159_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1084ui_story"]) and arg_159_1.var_.characterEffect1084ui_story then
				arg_159_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_162_1 = 0
			local var_162_2 = 1.375

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(122111037).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 55 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 55)

				if (55 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 55)) > 0 and var_162_2 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_6 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_6 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_6

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_6 and arg_159_1.time_ < var_162_1 + var_162_6 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play122111038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 122111038
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play122111039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.95

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

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(122111038).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 38 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 38)

				if (38 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 38)) > 0 and var_166_0 < var_166_3 then
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
	Play122111039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 122111039
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play122111040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.45

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
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

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(122111039).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 18 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 18)

				if (18 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 18)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play122111040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 122111040
		arg_171_1.duration_ = 9.77

		local var_171_0 = {
			ja = 9.766,
			ko = 8.2,
			zh = 8.2
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
				arg_171_0:Play122111041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1084ui_story"]) and arg_171_1.var_.characterEffect1084ui_story == nil then
				arg_171_1.var_.characterEffect1084ui_story = arg_171_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1084ui_story"]) then
				if arg_171_1.var_.characterEffect1084ui_story and not isNil(arg_171_1.actors_["1084ui_story"]) then
					arg_171_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1084ui_story"]) and arg_171_1.var_.characterEffect1084ui_story then
				arg_171_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_174_2 = 0
			local var_174_3 = 1.1

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_4 = arg_171_1:GetWordFromCfg(122111040)
				local var_174_5 = arg_171_1:FormatText(var_174_4.content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_7 = 44 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 44)

				if (44 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 44)) > 0 and var_174_3 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_2
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111040", "story_v_out_122111.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111040", "story_v_out_122111.awb") / 1000

					if var_174_8 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_2
					end

					if var_174_4.prefab_name ~= "" and arg_171_1.actors_[var_174_4.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_4.prefab_name].transform, "story_v_out_122111", "122111040", "story_v_out_122111.awb")

						arg_171_1:RecordAudio("122111040", var_174_9)
						arg_171_1:RecordAudio("122111040", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_122111", "122111040", "story_v_out_122111.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_122111", "122111040", "story_v_out_122111.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_3, arg_171_1.talkMaxDuration)

			if var_174_2 <= arg_171_1.time_ and arg_171_1.time_ < var_174_2 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_2) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_2 + var_174_10 and arg_171_1.time_ < var_174_2 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play122111041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 122111041
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play122111042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1084ui_story"]) and arg_175_1.var_.characterEffect1084ui_story == nil then
				arg_175_1.var_.characterEffect1084ui_story = arg_175_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1084ui_story"]) then
				if arg_175_1.var_.characterEffect1084ui_story and not isNil(arg_175_1.actors_["1084ui_story"]) then
					arg_175_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1084ui_story"]) and arg_175_1.var_.characterEffect1084ui_story then
				arg_175_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_178_1 = 0
			local var_178_2 = 0.1

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

				local var_178_3 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(122111041).content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 4 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 4)

				if (4 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 4)) > 0 and var_178_2 < var_178_5 then
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
	Play122111042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 122111042
		arg_179_1.duration_ = 6.8

		local var_179_0 = {
			ja = 5.133,
			ko = 6.8,
			zh = 6.8
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
				arg_179_0:Play122111043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1084ui_story"]) and arg_179_1.var_.characterEffect1084ui_story == nil then
				arg_179_1.var_.characterEffect1084ui_story = arg_179_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1084ui_story"]) then
				if arg_179_1.var_.characterEffect1084ui_story and not isNil(arg_179_1.actors_["1084ui_story"]) then
					arg_179_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1084ui_story"]) and arg_179_1.var_.characterEffect1084ui_story then
				arg_179_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_182_2 = 0
			local var_182_3 = 0.825

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_4 = arg_179_1:GetWordFromCfg(122111042)
				local var_182_5 = arg_179_1:FormatText(var_182_4.content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 33 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 33)

				if (33 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 33)) > 0 and var_182_3 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111042", "story_v_out_122111.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111042", "story_v_out_122111.awb") / 1000

					if var_182_8 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_2
					end

					if var_182_4.prefab_name ~= "" and arg_179_1.actors_[var_182_4.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_4.prefab_name].transform, "story_v_out_122111", "122111042", "story_v_out_122111.awb")

						arg_179_1:RecordAudio("122111042", var_182_9)
						arg_179_1:RecordAudio("122111042", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_122111", "122111042", "story_v_out_122111.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_122111", "122111042", "story_v_out_122111.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_10 and arg_179_1.time_ < var_182_2 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play122111043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 122111043
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play122111044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1084ui_story"]) and arg_183_1.var_.characterEffect1084ui_story == nil then
				arg_183_1.var_.characterEffect1084ui_story = arg_183_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1084ui_story"]) then
				if arg_183_1.var_.characterEffect1084ui_story and not isNil(arg_183_1.actors_["1084ui_story"]) then
					arg_183_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1084ui_story"]) and arg_183_1.var_.characterEffect1084ui_story then
				arg_183_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_186_1 = 0
			local var_186_2 = 0.55

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(122111043).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 22 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 22)

				if (22 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 22)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play122111044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 122111044
		arg_187_1.duration_ = 7.13

		local var_187_0 = {
			ja = 7.133,
			ko = 5.333,
			zh = 5.333
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
				arg_187_0:Play122111045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1084ui_story"]) and arg_187_1.var_.characterEffect1084ui_story == nil then
				arg_187_1.var_.characterEffect1084ui_story = arg_187_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1084ui_story"]) then
				if arg_187_1.var_.characterEffect1084ui_story and not isNil(arg_187_1.actors_["1084ui_story"]) then
					arg_187_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1084ui_story"]) and arg_187_1.var_.characterEffect1084ui_story then
				arg_187_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action483")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_190_2 = 0
			local var_190_3 = 0.55

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_4 = arg_187_1:GetWordFromCfg(122111044)
				local var_190_5 = arg_187_1:FormatText(var_190_4.content)

				arg_187_1.text_.text = var_190_5

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_7 = 22 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 22)

				if (22 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 22)) > 0 and var_190_3 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_2
					end
				end

				arg_187_1.text_.text = var_190_5
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111044", "story_v_out_122111.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111044", "story_v_out_122111.awb") / 1000

					if var_190_8 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_2
					end

					if var_190_4.prefab_name ~= "" and arg_187_1.actors_[var_190_4.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_4.prefab_name].transform, "story_v_out_122111", "122111044", "story_v_out_122111.awb")

						arg_187_1:RecordAudio("122111044", var_190_9)
						arg_187_1:RecordAudio("122111044", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_122111", "122111044", "story_v_out_122111.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_122111", "122111044", "story_v_out_122111.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_3, arg_187_1.talkMaxDuration)

			if var_190_2 <= arg_187_1.time_ and arg_187_1.time_ < var_190_2 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_2) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_2 + var_190_10 and arg_187_1.time_ < var_190_2 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play122111045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 122111045
		arg_191_1.duration_ = 10.4

		local var_191_0 = {
			ja = 10.4,
			ko = 6.066,
			zh = 6.066
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
				arg_191_0:Play122111046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1084ui_story"]) and arg_191_1.var_.characterEffect1084ui_story == nil then
				arg_191_1.var_.characterEffect1084ui_story = arg_191_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1084ui_story"]) then
				if arg_191_1.var_.characterEffect1084ui_story and not isNil(arg_191_1.actors_["1084ui_story"]) then
					arg_191_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1084ui_story"]) and arg_191_1.var_.characterEffect1084ui_story then
				arg_191_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action438")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_194_2 = 0
			local var_194_3 = 0.85

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(122111045)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 34 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 34)

				if (34 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 34)) > 0 and var_194_3 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_2
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111045", "story_v_out_122111.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111045", "story_v_out_122111.awb") / 1000

					if var_194_8 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_2
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_out_122111", "122111045", "story_v_out_122111.awb")

						arg_191_1:RecordAudio("122111045", var_194_9)
						arg_191_1:RecordAudio("122111045", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_122111", "122111045", "story_v_out_122111.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_122111", "122111045", "story_v_out_122111.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_3, arg_191_1.talkMaxDuration)

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_2) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_2 + var_194_10 and arg_191_1.time_ < var_194_2 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play122111046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 122111046
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play122111047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1084ui_story"]) and arg_195_1.var_.characterEffect1084ui_story == nil then
				arg_195_1.var_.characterEffect1084ui_story = arg_195_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1084ui_story"]) then
				if arg_195_1.var_.characterEffect1084ui_story and not isNil(arg_195_1.actors_["1084ui_story"]) then
					arg_195_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1084ui_story"]) and arg_195_1.var_.characterEffect1084ui_story then
				arg_195_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 1.625

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(122111046).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 65 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 65)

				if (65 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 65)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play122111047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 122111047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play122111048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 1.25

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(122111047).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 50 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 50)

				if (50 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 50)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play122111048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 122111048
		arg_203_1.duration_ = 6.07

		local var_203_0 = {
			ja = 4.266,
			ko = 6.066,
			zh = 6.066
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
				arg_203_0:Play122111049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1084ui_story = arg_203_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1084ui_story"].transform.position).z)
				arg_203_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1084ui_story"].transform.localEulerAngles = arg_203_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_203_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1084ui_story"].transform.position).z)
				arg_203_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1084ui_story"].transform.localEulerAngles = arg_203_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1084ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1084ui_story == nil then
				arg_203_1.var_.characterEffect1084ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1084ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1084ui_story then
				arg_203_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action483")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_206_4 = 0
			local var_206_5 = 0.65

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(122111048)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 26 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 26)

				if (26 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 26)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111048", "story_v_out_122111.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111048", "story_v_out_122111.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_122111", "122111048", "story_v_out_122111.awb")

						arg_203_1:RecordAudio("122111048", var_206_11)
						arg_203_1:RecordAudio("122111048", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_122111", "122111048", "story_v_out_122111.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_122111", "122111048", "story_v_out_122111.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play122111049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 122111049
		arg_207_1.duration_ = 0.5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"

			SetActive(arg_207_1.choicesGo_, true)

			for iter_208_0, iter_208_1 in ipairs(arg_207_1.choices_) do
				SetActive(iter_208_1.go, iter_208_0 <= 1)
			end

			arg_207_1.choices_[1].txt.text = arg_207_1:FormatText(StoryChoiceCfg[439].name)
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play122111050(arg_207_1)
			end

			arg_207_1:RecordChoiceLog(122111049, 439)
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1084ui_story"]) and arg_207_1.var_.characterEffect1084ui_story == nil then
				arg_207_1.var_.characterEffect1084ui_story = arg_207_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1084ui_story"]) then
				if arg_207_1.var_.characterEffect1084ui_story and not isNil(arg_207_1.actors_["1084ui_story"]) then
					arg_207_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1084ui_story"]) and arg_207_1.var_.characterEffect1084ui_story then
				arg_207_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.allBtn_.enabled = false
			end

			if arg_207_1.time_ >= var_210_1 + 0.5 and arg_207_1.time_ < var_210_1 + 0.5 + arg_210_0 then
				arg_207_1.allBtn_.enabled = true
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play122111050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 122111050
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play122111051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action437")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_214_0 = arg_211_1.actors_["1084ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1084ui_story == nil then
				arg_211_1.var_.characterEffect1084ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_1 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_1 and not isNil(var_214_0) then
				if arg_211_1.var_.characterEffect1084ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_1 and arg_211_1.time_ < 0 + var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1084ui_story then
				arg_211_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_214_3 = 0
			local var_214_4 = 0.425

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_3 + arg_214_0 then
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

				local var_214_5 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(122111050).content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 17 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 17)

				if (17 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 17)) > 0 and var_214_4 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_3 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_3
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_4, arg_211_1.talkMaxDuration)

			if var_214_3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_3 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_3) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_3 + var_214_8 and arg_211_1.time_ < var_214_3 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play122111051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 122111051
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play122111052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_218_0 = arg_215_1.actors_["1084ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1084ui_story == nil then
				arg_215_1.var_.characterEffect1084ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_1 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_1 and not isNil(var_218_0) then
				if arg_215_1.var_.characterEffect1084ui_story and not isNil(var_218_0) then
					arg_215_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_1)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_1 and arg_215_1.time_ < 0 + var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1084ui_story then
				arg_215_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_218_2 = 0
			local var_218_3 = 0.775

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_2 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_4 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(122111051).content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_6 = 31 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_4) / 31)

				if (31 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_4) / 31)) > 0 and var_218_3 < var_218_6 then
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
	Play122111052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 122111052
		arg_219_1.duration_ = 5.23

		local var_219_0 = {
			ja = 5.233,
			ko = 4.333,
			zh = 4.333
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
				arg_219_0:Play122111053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1084ui_story"]) and arg_219_1.var_.characterEffect1084ui_story == nil then
				arg_219_1.var_.characterEffect1084ui_story = arg_219_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1084ui_story"]) then
				if arg_219_1.var_.characterEffect1084ui_story and not isNil(arg_219_1.actors_["1084ui_story"]) then
					arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1084ui_story"]) and arg_219_1.var_.characterEffect1084ui_story then
				arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action472")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_222_2 = 0
			local var_222_3 = 0.35

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_4 = arg_219_1:GetWordFromCfg(122111052)
				local var_222_5 = arg_219_1:FormatText(var_222_4.content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 14 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 14)

				if (14 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 14)) > 0 and var_222_3 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111052", "story_v_out_122111.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111052", "story_v_out_122111.awb") / 1000

					if var_222_8 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_2
					end

					if var_222_4.prefab_name ~= "" and arg_219_1.actors_[var_222_4.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_4.prefab_name].transform, "story_v_out_122111", "122111052", "story_v_out_122111.awb")

						arg_219_1:RecordAudio("122111052", var_222_9)
						arg_219_1:RecordAudio("122111052", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_122111", "122111052", "story_v_out_122111.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_122111", "122111052", "story_v_out_122111.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_10 and arg_219_1.time_ < var_222_2 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play122111053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 122111053
		arg_223_1.duration_ = 0.5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"

			SetActive(arg_223_1.choicesGo_, true)

			for iter_224_0, iter_224_1 in ipairs(arg_223_1.choices_) do
				SetActive(iter_224_1.go, iter_224_0 <= 1)
			end

			arg_223_1.choices_[1].txt.text = arg_223_1:FormatText(StoryChoiceCfg[440].name)
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play122111054(arg_223_1)
			end

			arg_223_1:RecordChoiceLog(122111053, 440)
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1084ui_story"]) and arg_223_1.var_.characterEffect1084ui_story == nil then
				arg_223_1.var_.characterEffect1084ui_story = arg_223_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1084ui_story"]) then
				if arg_223_1.var_.characterEffect1084ui_story and not isNil(arg_223_1.actors_["1084ui_story"]) then
					arg_223_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1084ui_story"]) and arg_223_1.var_.characterEffect1084ui_story then
				arg_223_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			if arg_223_1.time_ >= var_226_1 + 0.5 and arg_223_1.time_ < var_226_1 + 0.5 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play122111054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 122111054
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play122111055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 1.4

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

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(122111054).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 56 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 56)

				if (56 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 56)) > 0 and var_230_0 < var_230_3 then
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
	Play122111055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 122111055
		arg_231_1.duration_ = 6.2

		local var_231_0 = {
			ja = 6.2,
			ko = 4.233,
			zh = 4.233
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
				arg_231_0:Play122111056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1084ui_story"]) and arg_231_1.var_.characterEffect1084ui_story == nil then
				arg_231_1.var_.characterEffect1084ui_story = arg_231_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1084ui_story"]) then
				if arg_231_1.var_.characterEffect1084ui_story and not isNil(arg_231_1.actors_["1084ui_story"]) then
					arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1084ui_story"]) and arg_231_1.var_.characterEffect1084ui_story then
				arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_2")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_2 = 0
			local var_234_3 = 0.6

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_4 = arg_231_1:GetWordFromCfg(122111055)
				local var_234_5 = arg_231_1:FormatText(var_234_4.content)

				arg_231_1.text_.text = var_234_5

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_7 = 24 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 24)

				if (24 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 24)) > 0 and var_234_3 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_2
					end
				end

				arg_231_1.text_.text = var_234_5
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111055", "story_v_out_122111.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111055", "story_v_out_122111.awb") / 1000

					if var_234_8 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_2
					end

					if var_234_4.prefab_name ~= "" and arg_231_1.actors_[var_234_4.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_4.prefab_name].transform, "story_v_out_122111", "122111055", "story_v_out_122111.awb")

						arg_231_1:RecordAudio("122111055", var_234_9)
						arg_231_1:RecordAudio("122111055", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_122111", "122111055", "story_v_out_122111.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_122111", "122111055", "story_v_out_122111.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_3, arg_231_1.talkMaxDuration)

			if var_234_2 <= arg_231_1.time_ and arg_231_1.time_ < var_234_2 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_2) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_2 + var_234_10 and arg_231_1.time_ < var_234_2 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play122111056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 122111056
		arg_235_1.duration_ = 16

		local var_235_0 = {
			ja = 16,
			ko = 10.333,
			zh = 10.333
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
				arg_235_0:Play122111057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_238_0 = 0
			local var_238_1 = 1.35

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_2 = arg_235_1:GetWordFromCfg(122111056)
				local var_238_3 = arg_235_1:FormatText(var_238_2.content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 54 <= 0 and var_238_1 or var_238_1 * (utf8.len(var_238_3) / 54)

				if (54 <= 0 and var_238_1 or var_238_1 * (utf8.len(var_238_3) / 54)) > 0 and var_238_1 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111056", "story_v_out_122111.awb") ~= 0 then
					local var_238_6 = manager.audio:GetVoiceLength("story_v_out_122111", "122111056", "story_v_out_122111.awb") / 1000

					if var_238_6 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_0
					end

					if var_238_2.prefab_name ~= "" and arg_235_1.actors_[var_238_2.prefab_name] ~= nil then
						local var_238_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_2.prefab_name].transform, "story_v_out_122111", "122111056", "story_v_out_122111.awb")

						arg_235_1:RecordAudio("122111056", var_238_7)
						arg_235_1:RecordAudio("122111056", var_238_7)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_122111", "122111056", "story_v_out_122111.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_122111", "122111056", "story_v_out_122111.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_8 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_8 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_8

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_8 and arg_235_1.time_ < var_238_0 + var_238_8 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play122111057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 122111057
		arg_239_1.duration_ = 8.53

		local var_239_0 = {
			ja = 8.533,
			ko = 2.3,
			zh = 2.3
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
				arg_239_0:Play122111058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1084ui_story"]) and arg_239_1.var_.characterEffect1084ui_story == nil then
				arg_239_1.var_.characterEffect1084ui_story = arg_239_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1084ui_story"]) then
				if arg_239_1.var_.characterEffect1084ui_story and not isNil(arg_239_1.actors_["1084ui_story"]) then
					arg_239_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1084ui_story"]) and arg_239_1.var_.characterEffect1084ui_story then
				arg_239_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action468")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_242_2 = 0
			local var_242_3 = 0.25

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_4 = arg_239_1:GetWordFromCfg(122111057)
				local var_242_5 = arg_239_1:FormatText(var_242_4.content)

				arg_239_1.text_.text = var_242_5

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_7 = 10 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_5) / 10)

				if (10 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_5) / 10)) > 0 and var_242_3 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_2
					end
				end

				arg_239_1.text_.text = var_242_5
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111057", "story_v_out_122111.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111057", "story_v_out_122111.awb") / 1000

					if var_242_8 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_2
					end

					if var_242_4.prefab_name ~= "" and arg_239_1.actors_[var_242_4.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_4.prefab_name].transform, "story_v_out_122111", "122111057", "story_v_out_122111.awb")

						arg_239_1:RecordAudio("122111057", var_242_9)
						arg_239_1:RecordAudio("122111057", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_122111", "122111057", "story_v_out_122111.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_122111", "122111057", "story_v_out_122111.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_3, arg_239_1.talkMaxDuration)

			if var_242_2 <= arg_239_1.time_ and arg_239_1.time_ < var_242_2 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_2) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_2 + var_242_10 and arg_239_1.time_ < var_242_2 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play122111058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 122111058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play122111059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) and arg_243_1.var_.characterEffect1084ui_story == nil then
				arg_243_1.var_.characterEffect1084ui_story = arg_243_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) then
				if arg_243_1.var_.characterEffect1084ui_story and not isNil(arg_243_1.actors_["1084ui_story"]) then
					arg_243_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) and arg_243_1.var_.characterEffect1084ui_story then
				arg_243_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 0.2

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

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(122111058).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 8 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 8)

				if (8 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 8)) > 0 and var_246_2 < var_246_5 then
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
	Play122111059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 122111059
		arg_247_1.duration_ = 10.2

		local var_247_0 = {
			ja = 10.2,
			ko = 8.8,
			zh = 8.8
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
				arg_247_0:Play122111060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) and arg_247_1.var_.characterEffect1084ui_story == nil then
				arg_247_1.var_.characterEffect1084ui_story = arg_247_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) then
				if arg_247_1.var_.characterEffect1084ui_story and not isNil(arg_247_1.actors_["1084ui_story"]) then
					arg_247_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) and arg_247_1.var_.characterEffect1084ui_story then
				arg_247_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_250_2 = 0
			local var_250_3 = 1.15

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(122111059)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 46 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 46)

				if (46 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 46)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111059", "story_v_out_122111.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111059", "story_v_out_122111.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_out_122111", "122111059", "story_v_out_122111.awb")

						arg_247_1:RecordAudio("122111059", var_250_9)
						arg_247_1:RecordAudio("122111059", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_122111", "122111059", "story_v_out_122111.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_122111", "122111059", "story_v_out_122111.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play122111060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 122111060
		arg_251_1.duration_ = 11.7

		local var_251_0 = {
			ja = 11.7,
			ko = 9.933,
			zh = 9.933
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
				arg_251_0:Play122111061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if arg_251_1.bgs_.ST02 == nil then
				local var_254_0 = Object.Instantiate(arg_251_1.paintGo_)

				var_254_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_254_0.name = "ST02"
				var_254_0.transform.parent = arg_251_1.stage_.transform
				var_254_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_251_1.bgs_.ST02 = var_254_0
			end

			if 2 < arg_251_1.time_ and arg_251_1.time_ <= 2 + arg_254_0 then
				local var_254_1 = arg_251_1.bgs_.ST02

				arg_251_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_254_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_254_2 = var_254_1:GetComponent("SpriteRenderer")

				if var_254_2 and var_254_2.sprite then
					local var_254_3 = 2 * (var_254_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_254_1.transform.localScale = Vector3.New(var_254_3 / var_254_2.sprite.bounds.size.y < var_254_3 * manager.ui.mainCameraCom_.aspect / var_254_2.sprite.bounds.size.x and var_254_3 * manager.ui.mainCameraCom_.aspect / var_254_2.sprite.bounds.size.x or var_254_3 / var_254_2.sprite.bounds.size.y, var_254_3 / var_254_2.sprite.bounds.size.y < var_254_3 * manager.ui.mainCameraCom_.aspect / var_254_2.sprite.bounds.size.x and var_254_3 * manager.ui.mainCameraCom_.aspect / var_254_2.sprite.bounds.size.x or var_254_3 / var_254_2.sprite.bounds.size.y, 0)
				end

				for iter_254_0, iter_254_1 in pairs(arg_251_1.bgs_) do
					if iter_254_0 ~= "ST02" then
						iter_254_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_254_4 = 0

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_4 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_5 = 2

			if var_254_4 <= arg_251_1.time_ and arg_251_1.time_ < var_254_4 + var_254_5 then
				local var_254_6 = Color.New(0, 0, 0)

				var_254_6.a = Mathf.Lerp(0, 1, (arg_251_1.time_ - var_254_4) / var_254_5)
				arg_251_1.mask_.color = var_254_6
			end

			if arg_251_1.time_ >= var_254_4 + var_254_5 and arg_251_1.time_ < var_254_4 + var_254_5 + arg_254_0 then
				local var_254_7 = Color.New(0, 0, 0)

				var_254_7.a = 1
				arg_251_1.mask_.color = var_254_7
			end

			local var_254_8 = 2

			if 2 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_9 = 2

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_9 then
				local var_254_10 = Color.New(0, 0, 0)

				var_254_10.a = Mathf.Lerp(1, 0, (arg_251_1.time_ - var_254_8) / var_254_9)
				arg_251_1.mask_.color = var_254_10
			end

			if arg_251_1.time_ >= var_254_8 + var_254_9 and arg_251_1.time_ < var_254_8 + var_254_9 + arg_254_0 then
				local var_254_11 = Color.New(0, 0, 0)

				arg_251_1.mask_.enabled = false
				var_254_11.a = 0
				arg_251_1.mask_.color = var_254_11
			end

			local var_254_12 = arg_251_1.actors_["1084ui_story"].transform

			if 4 < arg_251_1.time_ and arg_251_1.time_ <= 4 + arg_254_0 then
				arg_251_1.var_.moveOldPos1084ui_story = var_254_12.localPosition
			end

			local var_254_13 = 0.001

			if 4 <= arg_251_1.time_ and arg_251_1.time_ < 4 + var_254_13 then
				var_254_12.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_251_1.time_ - 4) / var_254_13)
				var_254_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_12.position).x, (manager.ui.mainCamera.transform.position - var_254_12.position).y, (manager.ui.mainCamera.transform.position - var_254_12.position).z)
				var_254_12.localEulerAngles.z = 0
				var_254_12.localEulerAngles.x = 0
				var_254_12.localEulerAngles = var_254_12.localEulerAngles
			end

			if arg_251_1.time_ >= 4 + var_254_13 and arg_251_1.time_ < 4 + var_254_13 + arg_254_0 then
				var_254_12.localPosition = Vector3.New(0, -0.97, -6)
				var_254_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_12.position).x, (manager.ui.mainCamera.transform.position - var_254_12.position).y, (manager.ui.mainCamera.transform.position - var_254_12.position).z)
				var_254_12.localEulerAngles.z = 0
				var_254_12.localEulerAngles.x = 0
				var_254_12.localEulerAngles = var_254_12.localEulerAngles
			end

			local var_254_14 = arg_251_1.actors_["1084ui_story"]

			if 4 < arg_251_1.time_ and arg_251_1.time_ <= 4 + arg_254_0 and not isNil(var_254_14) and arg_251_1.var_.characterEffect1084ui_story == nil then
				arg_251_1.var_.characterEffect1084ui_story = var_254_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_15 = 0.200000002980232

			if 4 <= arg_251_1.time_ and arg_251_1.time_ < 4 + var_254_15 and not isNil(var_254_14) then
				if arg_251_1.var_.characterEffect1084ui_story and not isNil(var_254_14) then
					arg_251_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 4 + var_254_15 and arg_251_1.time_ < 4 + var_254_15 + arg_254_0 and not isNil(var_254_14) and arg_251_1.var_.characterEffect1084ui_story then
				arg_251_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 4 < arg_251_1.time_ and arg_251_1.time_ <= 4 + arg_254_0 then
				arg_251_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 4 < arg_251_1.time_ and arg_251_1.time_ <= 4 + arg_254_0 then
				arg_251_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_254_17 = arg_251_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_251_1.time_ and arg_251_1.time_ <= 1.96599999815226 + arg_254_0 then
				arg_251_1.var_.moveOldPos1084ui_story = var_254_17.localPosition
			end

			local var_254_18 = 0.001

			if 1.96599999815226 <= arg_251_1.time_ and arg_251_1.time_ < 1.96599999815226 + var_254_18 then
				var_254_17.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_251_1.time_ - 1.96599999815226) / var_254_18)
				var_254_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_17.position).x, (manager.ui.mainCamera.transform.position - var_254_17.position).y, (manager.ui.mainCamera.transform.position - var_254_17.position).z)
				var_254_17.localEulerAngles.z = 0
				var_254_17.localEulerAngles.x = 0
				var_254_17.localEulerAngles = var_254_17.localEulerAngles
			end

			if arg_251_1.time_ >= 1.96599999815226 + var_254_18 and arg_251_1.time_ < 1.96599999815226 + var_254_18 + arg_254_0 then
				var_254_17.localPosition = Vector3.New(0, 100, 0)
				var_254_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_17.position).x, (manager.ui.mainCamera.transform.position - var_254_17.position).y, (manager.ui.mainCamera.transform.position - var_254_17.position).z)
				var_254_17.localEulerAngles.z = 0
				var_254_17.localEulerAngles.x = 0
				var_254_17.localEulerAngles = var_254_17.localEulerAngles
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_19 = 4
			local var_254_20 = 0.7

			if 4 < arg_251_1.time_ and arg_251_1.time_ <= var_254_19 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_21 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_21:setOnUpdate(LuaHelper.FloatAction(function(arg_255_0)
					arg_251_1.dialogCg_.alpha = arg_255_0
				end))
				var_254_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_22 = arg_251_1:GetWordFromCfg(122111060)
				local var_254_23 = arg_251_1:FormatText(var_254_22.content)

				arg_251_1.text_.text = var_254_23

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_25 = 28 <= 0 and var_254_20 or var_254_20 * (utf8.len(var_254_23) / 28)

				if (28 <= 0 and var_254_20 or var_254_20 * (utf8.len(var_254_23) / 28)) > 0 and var_254_20 < var_254_25 then
					arg_251_1.talkMaxDuration = var_254_25
					var_254_19 = var_254_19 + 0.3

					if var_254_25 + var_254_19 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_25 + var_254_19
					end
				end

				arg_251_1.text_.text = var_254_23
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111060", "story_v_out_122111.awb") ~= 0 then
					local var_254_26 = manager.audio:GetVoiceLength("story_v_out_122111", "122111060", "story_v_out_122111.awb") / 1000

					if var_254_26 + var_254_19 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_26 + var_254_19
					end

					if var_254_22.prefab_name ~= "" and arg_251_1.actors_[var_254_22.prefab_name] ~= nil then
						local var_254_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_22.prefab_name].transform, "story_v_out_122111", "122111060", "story_v_out_122111.awb")

						arg_251_1:RecordAudio("122111060", var_254_27)
						arg_251_1:RecordAudio("122111060", var_254_27)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_122111", "122111060", "story_v_out_122111.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_122111", "122111060", "story_v_out_122111.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_28 = var_254_19 + 0.3
			local var_254_29 = math.max(var_254_20, arg_251_1.talkMaxDuration)

			if var_254_19 + 0.3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_28 + var_254_29 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_28) / var_254_29

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_28 + var_254_29 and arg_251_1.time_ < var_254_28 + var_254_29 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play122111061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 122111061
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play122111062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1084ui_story = arg_257_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1084ui_story"].transform.position).z)
				arg_257_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1084ui_story"].transform.localEulerAngles = arg_257_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1084ui_story"].transform.position).z)
				arg_257_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1084ui_story"].transform.localEulerAngles = arg_257_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_260_1 = 0
			local var_260_2 = 0.825

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(122111061).content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 33 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 33)

				if (33 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 33)) > 0 and var_260_2 < var_260_5 then
					arg_257_1.talkMaxDuration = var_260_5

					if var_260_5 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_6 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_6 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_6

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_6 and arg_257_1.time_ < var_260_1 + var_260_6 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play122111062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 122111062
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play122111063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 1.35

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(122111062).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 54 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 54)

				if (54 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 54)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play122111063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 122111063
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play122111064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 1.7

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(122111063).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 68 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 68)

				if (68 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 68)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play122111064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 122111064
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play122111065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 1.45

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(122111064).content)

				arg_269_1.text_.text = var_272_1

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_3 = 58 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 58)

				if (58 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 58)) > 0 and var_272_0 < var_272_3 then
					arg_269_1.talkMaxDuration = var_272_3

					if var_272_3 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_3 + 0
					end
				end

				arg_269_1.text_.text = var_272_1
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_4 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_4

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play122111065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 122111065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play122111066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.35

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_1 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(122111065).content)

				arg_273_1.text_.text = var_276_1

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_3 = 14 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 14)

				if (14 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 14)) > 0 and var_276_0 < var_276_3 then
					arg_273_1.talkMaxDuration = var_276_3

					if var_276_3 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_3 + 0
					end
				end

				arg_273_1.text_.text = var_276_1
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_4 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_4

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play122111066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 122111066
		arg_277_1.duration_ = 5.13

		local var_277_0 = {
			ja = 3.733,
			ko = 5.133,
			zh = 5.133
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play122111067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1084ui_story = arg_277_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1084ui_story"].transform.position).z)
				arg_277_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1084ui_story"].transform.localEulerAngles = arg_277_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_277_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1084ui_story"].transform.position).z)
				arg_277_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1084ui_story"].transform.localEulerAngles = arg_277_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["1084ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1084ui_story == nil then
				arg_277_1.var_.characterEffect1084ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1084ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1084ui_story then
				arg_277_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_280_4 = 0
			local var_280_5 = 0.675

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(122111066)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 27 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 27)

				if (27 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 27)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111066", "story_v_out_122111.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111066", "story_v_out_122111.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_out_122111", "122111066", "story_v_out_122111.awb")

						arg_277_1:RecordAudio("122111066", var_280_11)
						arg_277_1:RecordAudio("122111066", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_122111", "122111066", "story_v_out_122111.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_122111", "122111066", "story_v_out_122111.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play122111067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 122111067
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play122111068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1084ui_story"]) and arg_281_1.var_.characterEffect1084ui_story == nil then
				arg_281_1.var_.characterEffect1084ui_story = arg_281_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1084ui_story"]) then
				if arg_281_1.var_.characterEffect1084ui_story and not isNil(arg_281_1.actors_["1084ui_story"]) then
					arg_281_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_0)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1084ui_story"]) and arg_281_1.var_.characterEffect1084ui_story then
				arg_281_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_284_1 = 0
			local var_284_2 = 0.75

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(122111067).content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 30 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 30)

				if (30 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 30)) > 0 and var_284_2 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_1 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_1
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_6 = math.max(var_284_2, arg_281_1.talkMaxDuration)

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_6 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_1) / var_284_6

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_1 + var_284_6 and arg_281_1.time_ < var_284_1 + var_284_6 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play122111068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 122111068
		arg_285_1.duration_ = 11.13

		local var_285_0 = {
			ja = 11.133,
			ko = 5.7,
			zh = 5.7
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play122111069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1084ui_story"]) and arg_285_1.var_.characterEffect1084ui_story == nil then
				arg_285_1.var_.characterEffect1084ui_story = arg_285_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1084ui_story"]) then
				if arg_285_1.var_.characterEffect1084ui_story and not isNil(arg_285_1.actors_["1084ui_story"]) then
					arg_285_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1084ui_story"]) and arg_285_1.var_.characterEffect1084ui_story then
				arg_285_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4124")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_288_2 = 0
			local var_288_3 = 0.675

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_4 = arg_285_1:GetWordFromCfg(122111068)
				local var_288_5 = arg_285_1:FormatText(var_288_4.content)

				arg_285_1.text_.text = var_288_5

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_7 = 27 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 27)

				if (27 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 27)) > 0 and var_288_3 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_2
					end
				end

				arg_285_1.text_.text = var_288_5
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111068", "story_v_out_122111.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111068", "story_v_out_122111.awb") / 1000

					if var_288_8 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_2
					end

					if var_288_4.prefab_name ~= "" and arg_285_1.actors_[var_288_4.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_4.prefab_name].transform, "story_v_out_122111", "122111068", "story_v_out_122111.awb")

						arg_285_1:RecordAudio("122111068", var_288_9)
						arg_285_1:RecordAudio("122111068", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_122111", "122111068", "story_v_out_122111.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_122111", "122111068", "story_v_out_122111.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_3, arg_285_1.talkMaxDuration)

			if var_288_2 <= arg_285_1.time_ and arg_285_1.time_ < var_288_2 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_2) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_2 + var_288_10 and arg_285_1.time_ < var_288_2 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play122111069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 122111069
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play122111070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1084ui_story"]) and arg_289_1.var_.characterEffect1084ui_story == nil then
				arg_289_1.var_.characterEffect1084ui_story = arg_289_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1084ui_story"]) then
				if arg_289_1.var_.characterEffect1084ui_story and not isNil(arg_289_1.actors_["1084ui_story"]) then
					arg_289_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_0)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1084ui_story"]) and arg_289_1.var_.characterEffect1084ui_story then
				arg_289_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_292_1 = 0
			local var_292_2 = 2

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_3 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(122111069).content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 80 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_3) / 80)

				if (80 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_3) / 80)) > 0 and var_292_2 < var_292_5 then
					arg_289_1.talkMaxDuration = var_292_5

					if var_292_5 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + var_292_1
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_6 = math.max(var_292_2, arg_289_1.talkMaxDuration)

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_6 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_1) / var_292_6

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_1 + var_292_6 and arg_289_1.time_ < var_292_1 + var_292_6 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play122111070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 122111070
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play122111071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_296_0 = 0
			local var_296_1 = 1.225

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_2 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(122111070).content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 49 <= 0 and var_296_1 or var_296_1 * (utf8.len(var_296_2) / 49)

				if (49 <= 0 and var_296_1 or var_296_1 * (utf8.len(var_296_2) / 49)) > 0 and var_296_1 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_5 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_5 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_5

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_5 and arg_293_1.time_ < var_296_0 + var_296_5 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play122111071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 122111071
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play122111072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.375

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(122111071).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 15 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 15)

				if (15 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 15)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play122111072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 122111072
		arg_301_1.duration_ = 12.03

		local var_301_0 = {
			ja = 12.033,
			ko = 11.666,
			zh = 11.666
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play122111073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1084ui_story"]) and arg_301_1.var_.characterEffect1084ui_story == nil then
				arg_301_1.var_.characterEffect1084ui_story = arg_301_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1084ui_story"]) then
				if arg_301_1.var_.characterEffect1084ui_story and not isNil(arg_301_1.actors_["1084ui_story"]) then
					arg_301_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1084ui_story"]) and arg_301_1.var_.characterEffect1084ui_story then
				arg_301_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_304_2 = 0
			local var_304_3 = 1.425

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_4 = arg_301_1:GetWordFromCfg(122111072)
				local var_304_5 = arg_301_1:FormatText(var_304_4.content)

				arg_301_1.text_.text = var_304_5

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_7 = 57 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_5) / 57)

				if (57 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_5) / 57)) > 0 and var_304_3 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_2
					end
				end

				arg_301_1.text_.text = var_304_5
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111072", "story_v_out_122111.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111072", "story_v_out_122111.awb") / 1000

					if var_304_8 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_2
					end

					if var_304_4.prefab_name ~= "" and arg_301_1.actors_[var_304_4.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_4.prefab_name].transform, "story_v_out_122111", "122111072", "story_v_out_122111.awb")

						arg_301_1:RecordAudio("122111072", var_304_9)
						arg_301_1:RecordAudio("122111072", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_122111", "122111072", "story_v_out_122111.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_122111", "122111072", "story_v_out_122111.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_3, arg_301_1.talkMaxDuration)

			if var_304_2 <= arg_301_1.time_ and arg_301_1.time_ < var_304_2 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_2) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_2 + var_304_10 and arg_301_1.time_ < var_304_2 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play122111073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 122111073
		arg_305_1.duration_ = 13.5

		local var_305_0 = {
			ja = 13.5,
			ko = 8.6,
			zh = 8.6
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play122111074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_308_0 = 0
			local var_308_1 = 1.2

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_2 = arg_305_1:GetWordFromCfg(122111073)
				local var_308_3 = arg_305_1:FormatText(var_308_2.content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 48 <= 0 and var_308_1 or var_308_1 * (utf8.len(var_308_3) / 48)

				if (48 <= 0 and var_308_1 or var_308_1 * (utf8.len(var_308_3) / 48)) > 0 and var_308_1 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111073", "story_v_out_122111.awb") ~= 0 then
					local var_308_6 = manager.audio:GetVoiceLength("story_v_out_122111", "122111073", "story_v_out_122111.awb") / 1000

					if var_308_6 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_6 + var_308_0
					end

					if var_308_2.prefab_name ~= "" and arg_305_1.actors_[var_308_2.prefab_name] ~= nil then
						local var_308_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_2.prefab_name].transform, "story_v_out_122111", "122111073", "story_v_out_122111.awb")

						arg_305_1:RecordAudio("122111073", var_308_7)
						arg_305_1:RecordAudio("122111073", var_308_7)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_122111", "122111073", "story_v_out_122111.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_122111", "122111073", "story_v_out_122111.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_8 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_8 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_8

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_8 and arg_305_1.time_ < var_308_0 + var_308_8 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play122111074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 122111074
		arg_309_1.duration_ = 8.4

		local var_309_0 = {
			ja = 8.4,
			ko = 5.433,
			zh = 5.433
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play122111075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_312_0 = 0
			local var_312_1 = 0.625

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_2 = arg_309_1:GetWordFromCfg(122111074)
				local var_312_3 = arg_309_1:FormatText(var_312_2.content)

				arg_309_1.text_.text = var_312_3

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 25 <= 0 and var_312_1 or var_312_1 * (utf8.len(var_312_3) / 25)

				if (25 <= 0 and var_312_1 or var_312_1 * (utf8.len(var_312_3) / 25)) > 0 and var_312_1 < var_312_5 then
					arg_309_1.talkMaxDuration = var_312_5

					if var_312_5 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_3
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111074", "story_v_out_122111.awb") ~= 0 then
					local var_312_6 = manager.audio:GetVoiceLength("story_v_out_122111", "122111074", "story_v_out_122111.awb") / 1000

					if var_312_6 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_6 + var_312_0
					end

					if var_312_2.prefab_name ~= "" and arg_309_1.actors_[var_312_2.prefab_name] ~= nil then
						local var_312_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_2.prefab_name].transform, "story_v_out_122111", "122111074", "story_v_out_122111.awb")

						arg_309_1:RecordAudio("122111074", var_312_7)
						arg_309_1:RecordAudio("122111074", var_312_7)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_122111", "122111074", "story_v_out_122111.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_122111", "122111074", "story_v_out_122111.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_8 and arg_309_1.time_ < var_312_0 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play122111075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 122111075
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play122111076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1084ui_story"]) and arg_313_1.var_.characterEffect1084ui_story == nil then
				arg_313_1.var_.characterEffect1084ui_story = arg_313_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1084ui_story"]) then
				if arg_313_1.var_.characterEffect1084ui_story and not isNil(arg_313_1.actors_["1084ui_story"]) then
					arg_313_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1084ui_story"]) and arg_313_1.var_.characterEffect1084ui_story then
				arg_313_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 0.225

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(122111075).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 9 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 9)

				if (9 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 9)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_6 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_6 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_6

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_6 and arg_313_1.time_ < var_316_1 + var_316_6 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play122111076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 122111076
		arg_317_1.duration_ = 12.73

		local var_317_0 = {
			ja = 12.733,
			ko = 7,
			zh = 7
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play122111077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1084ui_story"]) and arg_317_1.var_.characterEffect1084ui_story == nil then
				arg_317_1.var_.characterEffect1084ui_story = arg_317_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1084ui_story"]) then
				if arg_317_1.var_.characterEffect1084ui_story and not isNil(arg_317_1.actors_["1084ui_story"]) then
					arg_317_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1084ui_story"]) and arg_317_1.var_.characterEffect1084ui_story then
				arg_317_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_320_2 = 0
			local var_320_3 = 0.95

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_4 = arg_317_1:GetWordFromCfg(122111076)
				local var_320_5 = arg_317_1:FormatText(var_320_4.content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 38 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 38)

				if (38 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 38)) > 0 and var_320_3 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_2
					end
				end

				arg_317_1.text_.text = var_320_5
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111076", "story_v_out_122111.awb") ~= 0 then
					local var_320_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111076", "story_v_out_122111.awb") / 1000

					if var_320_8 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_8 + var_320_2
					end

					if var_320_4.prefab_name ~= "" and arg_317_1.actors_[var_320_4.prefab_name] ~= nil then
						local var_320_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_4.prefab_name].transform, "story_v_out_122111", "122111076", "story_v_out_122111.awb")

						arg_317_1:RecordAudio("122111076", var_320_9)
						arg_317_1:RecordAudio("122111076", var_320_9)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_122111", "122111076", "story_v_out_122111.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_122111", "122111076", "story_v_out_122111.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_10 = math.max(var_320_3, arg_317_1.talkMaxDuration)

			if var_320_2 <= arg_317_1.time_ and arg_317_1.time_ < var_320_2 + var_320_10 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_2) / var_320_10

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_2 + var_320_10 and arg_317_1.time_ < var_320_2 + var_320_10 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play122111077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 122111077
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play122111078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1084ui_story"]) and arg_321_1.var_.characterEffect1084ui_story == nil then
				arg_321_1.var_.characterEffect1084ui_story = arg_321_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1084ui_story"]) then
				if arg_321_1.var_.characterEffect1084ui_story and not isNil(arg_321_1.actors_["1084ui_story"]) then
					arg_321_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_0)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1084ui_story"]) and arg_321_1.var_.characterEffect1084ui_story then
				arg_321_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_324_1 = 0
			local var_324_2 = 1.075

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_3 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(122111077).content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 43 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 43)

				if (43 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 43)) > 0 and var_324_2 < var_324_5 then
					arg_321_1.talkMaxDuration = var_324_5

					if var_324_5 + var_324_1 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + var_324_1
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_6 = math.max(var_324_2, arg_321_1.talkMaxDuration)

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_6 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_1) / var_324_6

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_1 + var_324_6 and arg_321_1.time_ < var_324_1 + var_324_6 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play122111078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 122111078
		arg_325_1.duration_ = 5.83

		local var_325_0 = {
			ja = 4.5,
			ko = 5.833,
			zh = 5.833
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play122111079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1084ui_story"]) and arg_325_1.var_.characterEffect1084ui_story == nil then
				arg_325_1.var_.characterEffect1084ui_story = arg_325_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1084ui_story"]) then
				if arg_325_1.var_.characterEffect1084ui_story and not isNil(arg_325_1.actors_["1084ui_story"]) then
					arg_325_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1084ui_story"]) and arg_325_1.var_.characterEffect1084ui_story then
				arg_325_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_328_2 = 0
			local var_328_3 = 0.8

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_4 = arg_325_1:GetWordFromCfg(122111078)
				local var_328_5 = arg_325_1:FormatText(var_328_4.content)

				arg_325_1.text_.text = var_328_5

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_7 = 32 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 32)

				if (32 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 32)) > 0 and var_328_3 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_5
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111078", "story_v_out_122111.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111078", "story_v_out_122111.awb") / 1000

					if var_328_8 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_2
					end

					if var_328_4.prefab_name ~= "" and arg_325_1.actors_[var_328_4.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_4.prefab_name].transform, "story_v_out_122111", "122111078", "story_v_out_122111.awb")

						arg_325_1:RecordAudio("122111078", var_328_9)
						arg_325_1:RecordAudio("122111078", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_122111", "122111078", "story_v_out_122111.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_122111", "122111078", "story_v_out_122111.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_10 and arg_325_1.time_ < var_328_2 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play122111079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 122111079
		arg_329_1.duration_ = 9.4

		local var_329_0 = {
			ja = 9.4,
			ko = 5.5,
			zh = 5.5
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play122111080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1084ui_story"]) and arg_329_1.var_.characterEffect1084ui_story == nil then
				arg_329_1.var_.characterEffect1084ui_story = arg_329_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1084ui_story"]) then
				if arg_329_1.var_.characterEffect1084ui_story and not isNil(arg_329_1.actors_["1084ui_story"]) then
					arg_329_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1084ui_story"]) and arg_329_1.var_.characterEffect1084ui_story then
				arg_329_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action423")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_332_2 = 0
			local var_332_3 = 0.75

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_2 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_4 = arg_329_1:GetWordFromCfg(122111079)
				local var_332_5 = arg_329_1:FormatText(var_332_4.content)

				arg_329_1.text_.text = var_332_5

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_7 = 30 <= 0 and var_332_3 or var_332_3 * (utf8.len(var_332_5) / 30)

				if (30 <= 0 and var_332_3 or var_332_3 * (utf8.len(var_332_5) / 30)) > 0 and var_332_3 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_2
					end
				end

				arg_329_1.text_.text = var_332_5
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111079", "story_v_out_122111.awb") ~= 0 then
					local var_332_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111079", "story_v_out_122111.awb") / 1000

					if var_332_8 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_2
					end

					if var_332_4.prefab_name ~= "" and arg_329_1.actors_[var_332_4.prefab_name] ~= nil then
						local var_332_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_4.prefab_name].transform, "story_v_out_122111", "122111079", "story_v_out_122111.awb")

						arg_329_1:RecordAudio("122111079", var_332_9)
						arg_329_1:RecordAudio("122111079", var_332_9)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_122111", "122111079", "story_v_out_122111.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_122111", "122111079", "story_v_out_122111.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_10 = math.max(var_332_3, arg_329_1.talkMaxDuration)

			if var_332_2 <= arg_329_1.time_ and arg_329_1.time_ < var_332_2 + var_332_10 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_2) / var_332_10

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_2 + var_332_10 and arg_329_1.time_ < var_332_2 + var_332_10 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play122111080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 122111080
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play122111081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1084ui_story"]) and arg_333_1.var_.characterEffect1084ui_story == nil then
				arg_333_1.var_.characterEffect1084ui_story = arg_333_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1084ui_story"]) then
				if arg_333_1.var_.characterEffect1084ui_story and not isNil(arg_333_1.actors_["1084ui_story"]) then
					arg_333_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_0)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1084ui_story"]) and arg_333_1.var_.characterEffect1084ui_story then
				arg_333_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_336_1 = 0
			local var_336_2 = 0.375

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(122111080).content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 15 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 15)

				if (15 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 15)) > 0 and var_336_2 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_6 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_6 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_6

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_6 and arg_333_1.time_ < var_336_1 + var_336_6 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play122111081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 122111081
		arg_337_1.duration_ = 3.37

		local var_337_0 = {
			ja = 3.366,
			ko = 3,
			zh = 3
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play122111082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1084ui_story"]) and arg_337_1.var_.characterEffect1084ui_story == nil then
				arg_337_1.var_.characterEffect1084ui_story = arg_337_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1084ui_story"]) then
				if arg_337_1.var_.characterEffect1084ui_story and not isNil(arg_337_1.actors_["1084ui_story"]) then
					arg_337_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1084ui_story"]) and arg_337_1.var_.characterEffect1084ui_story then
				arg_337_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_340_2 = 0
			local var_340_3 = 0.325

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_2 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_4 = arg_337_1:GetWordFromCfg(122111081)
				local var_340_5 = arg_337_1:FormatText(var_340_4.content)

				arg_337_1.text_.text = var_340_5

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_7 = 13 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 13)

				if (13 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 13)) > 0 and var_340_3 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_2
					end
				end

				arg_337_1.text_.text = var_340_5
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111081", "story_v_out_122111.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111081", "story_v_out_122111.awb") / 1000

					if var_340_8 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_2
					end

					if var_340_4.prefab_name ~= "" and arg_337_1.actors_[var_340_4.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_4.prefab_name].transform, "story_v_out_122111", "122111081", "story_v_out_122111.awb")

						arg_337_1:RecordAudio("122111081", var_340_9)
						arg_337_1:RecordAudio("122111081", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_122111", "122111081", "story_v_out_122111.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_122111", "122111081", "story_v_out_122111.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_3, arg_337_1.talkMaxDuration)

			if var_340_2 <= arg_337_1.time_ and arg_337_1.time_ < var_340_2 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_2) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_2 + var_340_10 and arg_337_1.time_ < var_340_2 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play122111082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 122111082
		arg_341_1.duration_ = 5.63

		local var_341_0 = {
			ja = 5.633,
			ko = 4.133,
			zh = 4.133
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play122111083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1084ui_story"]) and arg_341_1.var_.characterEffect1084ui_story == nil then
				arg_341_1.var_.characterEffect1084ui_story = arg_341_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1084ui_story"]) then
				if arg_341_1.var_.characterEffect1084ui_story and not isNil(arg_341_1.actors_["1084ui_story"]) then
					arg_341_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1084ui_story"]) and arg_341_1.var_.characterEffect1084ui_story then
				arg_341_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action438")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_344_2 = 0
			local var_344_3 = 0.5

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_2 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_4 = arg_341_1:GetWordFromCfg(122111082)
				local var_344_5 = arg_341_1:FormatText(var_344_4.content)

				arg_341_1.text_.text = var_344_5

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_7 = 20 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 20)

				if (20 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 20)) > 0 and var_344_3 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_2
					end
				end

				arg_341_1.text_.text = var_344_5
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111082", "story_v_out_122111.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111082", "story_v_out_122111.awb") / 1000

					if var_344_8 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_2
					end

					if var_344_4.prefab_name ~= "" and arg_341_1.actors_[var_344_4.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_4.prefab_name].transform, "story_v_out_122111", "122111082", "story_v_out_122111.awb")

						arg_341_1:RecordAudio("122111082", var_344_9)
						arg_341_1:RecordAudio("122111082", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_122111", "122111082", "story_v_out_122111.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_122111", "122111082", "story_v_out_122111.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_3, arg_341_1.talkMaxDuration)

			if var_344_2 <= arg_341_1.time_ and arg_341_1.time_ < var_344_2 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_2) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_2 + var_344_10 and arg_341_1.time_ < var_344_2 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play122111083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 122111083
		arg_345_1.duration_ = 9

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play122111084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if arg_345_1.bgs_.ST03 == nil then
				local var_348_0 = Object.Instantiate(arg_345_1.paintGo_)

				var_348_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03")
				var_348_0.name = "ST03"
				var_348_0.transform.parent = arg_345_1.stage_.transform
				var_348_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_345_1.bgs_.ST03 = var_348_0
			end

			if 2 < arg_345_1.time_ and arg_345_1.time_ <= 2 + arg_348_0 then
				local var_348_1 = arg_345_1.bgs_.ST03

				arg_345_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_348_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_348_2 = var_348_1:GetComponent("SpriteRenderer")

				if var_348_2 and var_348_2.sprite then
					local var_348_3 = 2 * (var_348_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_348_1.transform.localScale = Vector3.New(var_348_3 / var_348_2.sprite.bounds.size.y < var_348_3 * manager.ui.mainCameraCom_.aspect / var_348_2.sprite.bounds.size.x and var_348_3 * manager.ui.mainCameraCom_.aspect / var_348_2.sprite.bounds.size.x or var_348_3 / var_348_2.sprite.bounds.size.y, var_348_3 / var_348_2.sprite.bounds.size.y < var_348_3 * manager.ui.mainCameraCom_.aspect / var_348_2.sprite.bounds.size.x and var_348_3 * manager.ui.mainCameraCom_.aspect / var_348_2.sprite.bounds.size.x or var_348_3 / var_348_2.sprite.bounds.size.y, 0)
				end

				for iter_348_0, iter_348_1 in pairs(arg_345_1.bgs_) do
					if iter_348_0 ~= "ST03" then
						iter_348_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_348_4 = 0

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_5 = 2

			if var_348_4 <= arg_345_1.time_ and arg_345_1.time_ < var_348_4 + var_348_5 then
				local var_348_6 = Color.New(0, 0, 0)

				var_348_6.a = Mathf.Lerp(0, 1, (arg_345_1.time_ - var_348_4) / var_348_5)
				arg_345_1.mask_.color = var_348_6
			end

			if arg_345_1.time_ >= var_348_4 + var_348_5 and arg_345_1.time_ < var_348_4 + var_348_5 + arg_348_0 then
				local var_348_7 = Color.New(0, 0, 0)

				var_348_7.a = 1
				arg_345_1.mask_.color = var_348_7
			end

			local var_348_8 = 2

			if 2 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_9 = 2

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_9 then
				local var_348_10 = Color.New(0, 0, 0)

				var_348_10.a = Mathf.Lerp(1, 0, (arg_345_1.time_ - var_348_8) / var_348_9)
				arg_345_1.mask_.color = var_348_10
			end

			if arg_345_1.time_ >= var_348_8 + var_348_9 and arg_345_1.time_ < var_348_8 + var_348_9 + arg_348_0 then
				local var_348_11 = Color.New(0, 0, 0)

				arg_345_1.mask_.enabled = false
				var_348_11.a = 0
				arg_345_1.mask_.color = var_348_11
			end

			local var_348_12 = arg_345_1.actors_["1084ui_story"].transform

			if 1.966 < arg_345_1.time_ and arg_345_1.time_ <= 1.966 + arg_348_0 then
				arg_345_1.var_.moveOldPos1084ui_story = var_348_12.localPosition
			end

			local var_348_13 = 0.001

			if 1.966 <= arg_345_1.time_ and arg_345_1.time_ < 1.966 + var_348_13 then
				var_348_12.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 1.966) / var_348_13)
				var_348_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_12.position).x, (manager.ui.mainCamera.transform.position - var_348_12.position).y, (manager.ui.mainCamera.transform.position - var_348_12.position).z)
				var_348_12.localEulerAngles.z = 0
				var_348_12.localEulerAngles.x = 0
				var_348_12.localEulerAngles = var_348_12.localEulerAngles
			end

			if arg_345_1.time_ >= 1.966 + var_348_13 and arg_345_1.time_ < 1.966 + var_348_13 + arg_348_0 then
				var_348_12.localPosition = Vector3.New(0, 100, 0)
				var_348_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_12.position).x, (manager.ui.mainCamera.transform.position - var_348_12.position).y, (manager.ui.mainCamera.transform.position - var_348_12.position).z)
				var_348_12.localEulerAngles.z = 0
				var_348_12.localEulerAngles.x = 0
				var_348_12.localEulerAngles = var_348_12.localEulerAngles
			end

			if arg_345_1.frameCnt_ <= 1 then
				arg_345_1.dialog_:SetActive(false)
			end

			local var_348_14 = 4
			local var_348_15 = 1.05

			if 4 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				arg_345_1.dialog_:SetActive(true)

				arg_345_1.dialogCg_.alpha = 0

				local var_348_16 = LeanTween.value(arg_345_1.dialog_, 0, 1, 0.3)

				var_348_16:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_345_1.dialogCg_.alpha = arg_349_0
				end))
				var_348_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_345_1.dialog_)
					var_348_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_345_1.duration_ = arg_345_1.duration_ + 0.3

				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_17 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(122111083).content)

				arg_345_1.text_.text = var_348_17

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_19 = 42 <= 0 and var_348_15 or var_348_15 * (utf8.len(var_348_17) / 42)

				if (42 <= 0 and var_348_15 or var_348_15 * (utf8.len(var_348_17) / 42)) > 0 and var_348_15 < var_348_19 then
					arg_345_1.talkMaxDuration = var_348_19
					var_348_14 = var_348_14 + 0.3

					if var_348_19 + var_348_14 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_19 + var_348_14
					end
				end

				arg_345_1.text_.text = var_348_17
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_20 = var_348_14 + 0.3
			local var_348_21 = math.max(var_348_15, arg_345_1.talkMaxDuration)

			if var_348_14 + 0.3 <= arg_345_1.time_ and arg_345_1.time_ < var_348_20 + var_348_21 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_20) / var_348_21

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_20 + var_348_21 and arg_345_1.time_ < var_348_20 + var_348_21 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play122111084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 122111084
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play122111085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 1.6

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(122111084).content)

				arg_351_1.text_.text = var_354_1

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_3 = 64 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 64)

				if (64 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 64)) > 0 and var_354_0 < var_354_3 then
					arg_351_1.talkMaxDuration = var_354_3

					if var_354_3 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_3 + 0
					end
				end

				arg_351_1.text_.text = var_354_1
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_4 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_4

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play122111085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 122111085
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play122111086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1.375

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(122111085).content)

				arg_355_1.text_.text = var_358_1

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_3 = 55 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 55)

				if (55 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 55)) > 0 and var_358_0 < var_358_3 then
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
	Play122111086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 122111086
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play122111087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 1.45

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(122111086).content)

				arg_359_1.text_.text = var_362_1

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_3 = 58 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 58)

				if (58 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 58)) > 0 and var_362_0 < var_362_3 then
					arg_359_1.talkMaxDuration = var_362_3

					if var_362_3 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_3 + 0
					end
				end

				arg_359_1.text_.text = var_362_1
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_4 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_4

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play122111087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 122111087
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play122111088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 1.25

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_1 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(122111087).content)

				arg_363_1.text_.text = var_366_1

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_3 = 50 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 50)

				if (50 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 50)) > 0 and var_366_0 < var_366_3 then
					arg_363_1.talkMaxDuration = var_366_3

					if var_366_3 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_3 + 0
					end
				end

				arg_363_1.text_.text = var_366_1
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_4 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_4 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_4

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_4 and arg_363_1.time_ < 0 + var_366_4 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play122111088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 122111088
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play122111089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 1.3

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(122111088).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 52 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 52)

				if (52 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 52)) > 0 and var_370_0 < var_370_3 then
					arg_367_1.talkMaxDuration = var_370_3

					if var_370_3 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_3 + 0
					end
				end

				arg_367_1.text_.text = var_370_1
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_4 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_4

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play122111089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 122111089
		arg_371_1.duration_ = 9

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play122111090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if arg_371_1.bgs_.ST15 == nil then
				local var_374_0 = Object.Instantiate(arg_371_1.paintGo_)

				var_374_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15")
				var_374_0.name = "ST15"
				var_374_0.transform.parent = arg_371_1.stage_.transform
				var_374_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_371_1.bgs_.ST15 = var_374_0
			end

			if 2 < arg_371_1.time_ and arg_371_1.time_ <= 2 + arg_374_0 then
				local var_374_1 = arg_371_1.bgs_.ST15

				arg_371_1.bgs_.ST15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_374_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_374_2 = var_374_1:GetComponent("SpriteRenderer")

				if var_374_2 and var_374_2.sprite then
					local var_374_3 = 2 * (var_374_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_374_1.transform.localScale = Vector3.New(var_374_3 / var_374_2.sprite.bounds.size.y < var_374_3 * manager.ui.mainCameraCom_.aspect / var_374_2.sprite.bounds.size.x and var_374_3 * manager.ui.mainCameraCom_.aspect / var_374_2.sprite.bounds.size.x or var_374_3 / var_374_2.sprite.bounds.size.y, var_374_3 / var_374_2.sprite.bounds.size.y < var_374_3 * manager.ui.mainCameraCom_.aspect / var_374_2.sprite.bounds.size.x and var_374_3 * manager.ui.mainCameraCom_.aspect / var_374_2.sprite.bounds.size.x or var_374_3 / var_374_2.sprite.bounds.size.y, 0)
				end

				for iter_374_0, iter_374_1 in pairs(arg_371_1.bgs_) do
					if iter_374_0 ~= "ST15" then
						iter_374_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_374_4 = 0

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1.mask_.enabled = true
				arg_371_1.mask_.raycastTarget = true

				arg_371_1:SetGaussion(false)
			end

			local var_374_5 = 2

			if var_374_4 <= arg_371_1.time_ and arg_371_1.time_ < var_374_4 + var_374_5 then
				local var_374_6 = Color.New(0, 0, 0)

				var_374_6.a = Mathf.Lerp(0, 1, (arg_371_1.time_ - var_374_4) / var_374_5)
				arg_371_1.mask_.color = var_374_6
			end

			if arg_371_1.time_ >= var_374_4 + var_374_5 and arg_371_1.time_ < var_374_4 + var_374_5 + arg_374_0 then
				local var_374_7 = Color.New(0, 0, 0)

				var_374_7.a = 1
				arg_371_1.mask_.color = var_374_7
			end

			local var_374_8 = 2

			if 2 < arg_371_1.time_ and arg_371_1.time_ <= var_374_8 + arg_374_0 then
				arg_371_1.mask_.enabled = true
				arg_371_1.mask_.raycastTarget = true

				arg_371_1:SetGaussion(false)
			end

			local var_374_9 = 2

			if var_374_8 <= arg_371_1.time_ and arg_371_1.time_ < var_374_8 + var_374_9 then
				local var_374_10 = Color.New(0, 0, 0)

				var_374_10.a = Mathf.Lerp(1, 0, (arg_371_1.time_ - var_374_8) / var_374_9)
				arg_371_1.mask_.color = var_374_10
			end

			if arg_371_1.time_ >= var_374_8 + var_374_9 and arg_371_1.time_ < var_374_8 + var_374_9 + arg_374_0 then
				local var_374_11 = Color.New(0, 0, 0)

				arg_371_1.mask_.enabled = false
				var_374_11.a = 0
				arg_371_1.mask_.color = var_374_11
			end

			if 1.86666666666667 < arg_371_1.time_ and arg_371_1.time_ <= 1.86666666666667 + arg_374_0 then
				arg_371_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_1028_smallwaveloop", "")
			end

			if arg_371_1.frameCnt_ <= 1 then
				arg_371_1.dialog_:SetActive(false)
			end

			local var_374_13 = 4
			local var_374_14 = 1.725

			if 4 < arg_371_1.time_ and arg_371_1.time_ <= var_374_13 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0

				arg_371_1.dialog_:SetActive(true)

				arg_371_1.dialogCg_.alpha = 0

				local var_374_15 = LeanTween.value(arg_371_1.dialog_, 0, 1, 0.3)

				var_374_15:setOnUpdate(LuaHelper.FloatAction(function(arg_375_0)
					arg_371_1.dialogCg_.alpha = arg_375_0
				end))
				var_374_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_371_1.dialog_)
					var_374_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_371_1.duration_ = arg_371_1.duration_ + 0.3

				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_16 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(122111089).content)

				arg_371_1.text_.text = var_374_16

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_18 = 69 <= 0 and var_374_14 or var_374_14 * (utf8.len(var_374_16) / 69)

				if (69 <= 0 and var_374_14 or var_374_14 * (utf8.len(var_374_16) / 69)) > 0 and var_374_14 < var_374_18 then
					arg_371_1.talkMaxDuration = var_374_18
					var_374_13 = var_374_13 + 0.3

					if var_374_18 + var_374_13 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_18 + var_374_13
					end
				end

				arg_371_1.text_.text = var_374_16
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_19 = var_374_13 + 0.3
			local var_374_20 = math.max(var_374_14, arg_371_1.talkMaxDuration)

			if var_374_13 + 0.3 <= arg_371_1.time_ and arg_371_1.time_ < var_374_19 + var_374_20 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_19) / var_374_20

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_19 + var_374_20 and arg_371_1.time_ < var_374_19 + var_374_20 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play122111090 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 122111090
		arg_377_1.duration_ = 10.17

		local var_377_0 = {
			ja = 6.033,
			ko = 10.166,
			zh = 10.166
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
				arg_377_0:Play122111091(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1084ui_story = arg_377_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_380_0 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 then
				arg_377_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_377_1.time_ - 0) / var_380_0)
				arg_377_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1084ui_story"].transform.position).z)
				arg_377_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1084ui_story"].transform.localEulerAngles = arg_377_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 then
				arg_377_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_377_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1084ui_story"].transform.position).z)
				arg_377_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1084ui_story"].transform.localEulerAngles = arg_377_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_380_1 = arg_377_1.actors_["1084ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1084ui_story == nil then
				arg_377_1.var_.characterEffect1084ui_story = var_380_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_2 and not isNil(var_380_1) then
				if arg_377_1.var_.characterEffect1084ui_story and not isNil(var_380_1) then
					arg_377_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_2 and arg_377_1.time_ < 0 + var_380_2 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1084ui_story then
				arg_377_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_380_4 = 0
			local var_380_5 = 0.75

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_4 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_6 = arg_377_1:GetWordFromCfg(122111090)
				local var_380_7 = arg_377_1:FormatText(var_380_6.content)

				arg_377_1.text_.text = var_380_7

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_9 = 30 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 30)

				if (30 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 30)) > 0 and var_380_5 < var_380_9 then
					arg_377_1.talkMaxDuration = var_380_9

					if var_380_9 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_9 + var_380_4
					end
				end

				arg_377_1.text_.text = var_380_7
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111090", "story_v_out_122111.awb") ~= 0 then
					local var_380_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111090", "story_v_out_122111.awb") / 1000

					if var_380_10 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_4
					end

					if var_380_6.prefab_name ~= "" and arg_377_1.actors_[var_380_6.prefab_name] ~= nil then
						local var_380_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_6.prefab_name].transform, "story_v_out_122111", "122111090", "story_v_out_122111.awb")

						arg_377_1:RecordAudio("122111090", var_380_11)
						arg_377_1:RecordAudio("122111090", var_380_11)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_122111", "122111090", "story_v_out_122111.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_122111", "122111090", "story_v_out_122111.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_12 = math.max(var_380_5, arg_377_1.talkMaxDuration)

			if var_380_4 <= arg_377_1.time_ and arg_377_1.time_ < var_380_4 + var_380_12 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_4) / var_380_12

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_4 + var_380_12 and arg_377_1.time_ < var_380_4 + var_380_12 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play122111091 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 122111091
		arg_381_1.duration_ = 7.4

		local var_381_0 = {
			ja = 6.233,
			ko = 7.4,
			zh = 7.4
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play122111092(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_384_0 = 0
			local var_384_1 = 0.775

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_2 = arg_381_1:GetWordFromCfg(122111091)
				local var_384_3 = arg_381_1:FormatText(var_384_2.content)

				arg_381_1.text_.text = var_384_3

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_5 = 31 <= 0 and var_384_1 or var_384_1 * (utf8.len(var_384_3) / 31)

				if (31 <= 0 and var_384_1 or var_384_1 * (utf8.len(var_384_3) / 31)) > 0 and var_384_1 < var_384_5 then
					arg_381_1.talkMaxDuration = var_384_5

					if var_384_5 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_3
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111091", "story_v_out_122111.awb") ~= 0 then
					local var_384_6 = manager.audio:GetVoiceLength("story_v_out_122111", "122111091", "story_v_out_122111.awb") / 1000

					if var_384_6 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_6 + var_384_0
					end

					if var_384_2.prefab_name ~= "" and arg_381_1.actors_[var_384_2.prefab_name] ~= nil then
						local var_384_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_2.prefab_name].transform, "story_v_out_122111", "122111091", "story_v_out_122111.awb")

						arg_381_1:RecordAudio("122111091", var_384_7)
						arg_381_1:RecordAudio("122111091", var_384_7)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_122111", "122111091", "story_v_out_122111.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_122111", "122111091", "story_v_out_122111.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_8 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_8 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_8

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_8 and arg_381_1.time_ < var_384_0 + var_384_8 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play122111092 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 122111092
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play122111093(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1084ui_story"]) and arg_385_1.var_.characterEffect1084ui_story == nil then
				arg_385_1.var_.characterEffect1084ui_story = arg_385_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1084ui_story"]) then
				if arg_385_1.var_.characterEffect1084ui_story and not isNil(arg_385_1.actors_["1084ui_story"]) then
					arg_385_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_0)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1084ui_story"]) and arg_385_1.var_.characterEffect1084ui_story then
				arg_385_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_388_1 = 0
			local var_388_2 = 0.55

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_3 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(122111092).content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 22 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 22)

				if (22 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 22)) > 0 and var_388_2 < var_388_5 then
					arg_385_1.talkMaxDuration = var_388_5

					if var_388_5 + var_388_1 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + var_388_1
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_6 = math.max(var_388_2, arg_385_1.talkMaxDuration)

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_6 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_1) / var_388_6

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_1 + var_388_6 and arg_385_1.time_ < var_388_1 + var_388_6 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play122111093 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 122111093
		arg_389_1.duration_ = 10.63

		local var_389_0 = {
			ja = 10.633,
			ko = 5.266,
			zh = 5.266
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
				arg_389_0:Play122111094(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1084ui_story"]) and arg_389_1.var_.characterEffect1084ui_story == nil then
				arg_389_1.var_.characterEffect1084ui_story = arg_389_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1084ui_story"]) then
				if arg_389_1.var_.characterEffect1084ui_story and not isNil(arg_389_1.actors_["1084ui_story"]) then
					arg_389_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1084ui_story"]) and arg_389_1.var_.characterEffect1084ui_story then
				arg_389_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action468")
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_392_2 = 0
			local var_392_3 = 0.7

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_2 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_4 = arg_389_1:GetWordFromCfg(122111093)
				local var_392_5 = arg_389_1:FormatText(var_392_4.content)

				arg_389_1.text_.text = var_392_5

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_7 = 28 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 28)

				if (28 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 28)) > 0 and var_392_3 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_2
					end
				end

				arg_389_1.text_.text = var_392_5
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111093", "story_v_out_122111.awb") ~= 0 then
					local var_392_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111093", "story_v_out_122111.awb") / 1000

					if var_392_8 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_8 + var_392_2
					end

					if var_392_4.prefab_name ~= "" and arg_389_1.actors_[var_392_4.prefab_name] ~= nil then
						local var_392_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_4.prefab_name].transform, "story_v_out_122111", "122111093", "story_v_out_122111.awb")

						arg_389_1:RecordAudio("122111093", var_392_9)
						arg_389_1:RecordAudio("122111093", var_392_9)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_122111", "122111093", "story_v_out_122111.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_122111", "122111093", "story_v_out_122111.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_10 = math.max(var_392_3, arg_389_1.talkMaxDuration)

			if var_392_2 <= arg_389_1.time_ and arg_389_1.time_ < var_392_2 + var_392_10 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_2) / var_392_10

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_2 + var_392_10 and arg_389_1.time_ < var_392_2 + var_392_10 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play122111094 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 122111094
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play122111095(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1084ui_story"]) and arg_393_1.var_.characterEffect1084ui_story == nil then
				arg_393_1.var_.characterEffect1084ui_story = arg_393_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1084ui_story"]) then
				if arg_393_1.var_.characterEffect1084ui_story and not isNil(arg_393_1.actors_["1084ui_story"]) then
					arg_393_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_0)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1084ui_story"]) and arg_393_1.var_.characterEffect1084ui_story then
				arg_393_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_396_1 = 0
			local var_396_2 = 0.3

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_3 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(122111094).content)

				arg_393_1.text_.text = var_396_3

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 12 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 12)

				if (12 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 12)) > 0 and var_396_2 < var_396_5 then
					arg_393_1.talkMaxDuration = var_396_5

					if var_396_5 + var_396_1 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + var_396_1
					end
				end

				arg_393_1.text_.text = var_396_3
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_6 = math.max(var_396_2, arg_393_1.talkMaxDuration)

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_6 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_1) / var_396_6

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_1 + var_396_6 and arg_393_1.time_ < var_396_1 + var_396_6 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play122111095 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 122111095
		arg_397_1.duration_ = 2.1

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play122111096(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1084ui_story"]) and arg_397_1.var_.characterEffect1084ui_story == nil then
				arg_397_1.var_.characterEffect1084ui_story = arg_397_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1084ui_story"]) then
				if arg_397_1.var_.characterEffect1084ui_story and not isNil(arg_397_1.actors_["1084ui_story"]) then
					arg_397_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1084ui_story"]) and arg_397_1.var_.characterEffect1084ui_story then
				arg_397_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_400_2 = 0
			local var_400_3 = 0.225

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_2 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_4 = arg_397_1:GetWordFromCfg(122111095)
				local var_400_5 = arg_397_1:FormatText(var_400_4.content)

				arg_397_1.text_.text = var_400_5

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_7 = 9 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_5) / 9)

				if (9 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_5) / 9)) > 0 and var_400_3 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_2
					end
				end

				arg_397_1.text_.text = var_400_5
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111095", "story_v_out_122111.awb") ~= 0 then
					local var_400_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111095", "story_v_out_122111.awb") / 1000

					if var_400_8 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_2
					end

					if var_400_4.prefab_name ~= "" and arg_397_1.actors_[var_400_4.prefab_name] ~= nil then
						local var_400_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_4.prefab_name].transform, "story_v_out_122111", "122111095", "story_v_out_122111.awb")

						arg_397_1:RecordAudio("122111095", var_400_9)
						arg_397_1:RecordAudio("122111095", var_400_9)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_122111", "122111095", "story_v_out_122111.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_122111", "122111095", "story_v_out_122111.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = math.max(var_400_3, arg_397_1.talkMaxDuration)

			if var_400_2 <= arg_397_1.time_ and arg_397_1.time_ < var_400_2 + var_400_10 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_2) / var_400_10

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_2 + var_400_10 and arg_397_1.time_ < var_400_2 + var_400_10 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play122111096 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 122111096
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play122111097(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["1084ui_story"]) and arg_401_1.var_.characterEffect1084ui_story == nil then
				arg_401_1.var_.characterEffect1084ui_story = arg_401_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["1084ui_story"]) then
				if arg_401_1.var_.characterEffect1084ui_story and not isNil(arg_401_1.actors_["1084ui_story"]) then
					arg_401_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_401_1.time_ - 0) / var_404_0)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["1084ui_story"]) and arg_401_1.var_.characterEffect1084ui_story then
				arg_401_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_404_1 = 0
			local var_404_2 = 0.725

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_3 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(122111096).content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_5 = 29 <= 0 and var_404_2 or var_404_2 * (utf8.len(var_404_3) / 29)

				if (29 <= 0 and var_404_2 or var_404_2 * (utf8.len(var_404_3) / 29)) > 0 and var_404_2 < var_404_5 then
					arg_401_1.talkMaxDuration = var_404_5

					if var_404_5 + var_404_1 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + var_404_1
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_6 = math.max(var_404_2, arg_401_1.talkMaxDuration)

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_6 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_1) / var_404_6

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_1 + var_404_6 and arg_401_1.time_ < var_404_1 + var_404_6 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play122111097 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 122111097
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play122111098(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1084ui_story = arg_405_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1084ui_story"].transform.position).z)
				arg_405_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1084ui_story"].transform.localEulerAngles = arg_405_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_405_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1084ui_story"].transform.position).z)
				arg_405_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1084ui_story"].transform.localEulerAngles = arg_405_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_408_1 = 0
			local var_408_2 = 1.025

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_3 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(122111097).content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 41 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 41)

				if (41 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 41)) > 0 and var_408_2 < var_408_5 then
					arg_405_1.talkMaxDuration = var_408_5

					if var_408_5 + var_408_1 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + var_408_1
					end
				end

				arg_405_1.text_.text = var_408_3
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_6 = math.max(var_408_2, arg_405_1.talkMaxDuration)

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_6 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_1) / var_408_6

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_1 + var_408_6 and arg_405_1.time_ < var_408_1 + var_408_6 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play122111098 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 122111098
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play122111099(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0.55

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_1 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(122111098).content)

				arg_409_1.text_.text = var_412_1

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_3 = 22 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_1) / 22)

				if (22 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_1) / 22)) > 0 and var_412_0 < var_412_3 then
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
	Play122111099 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 122111099
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play122111100(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0.825

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_1 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(122111099).content)

				arg_413_1.text_.text = var_416_1

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_3 = 33 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 33)

				if (33 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 33)) > 0 and var_416_0 < var_416_3 then
					arg_413_1.talkMaxDuration = var_416_3

					if var_416_3 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_3 + 0
					end
				end

				arg_413_1.text_.text = var_416_1
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_4 = math.max(var_416_0, arg_413_1.talkMaxDuration)

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_4 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - 0) / var_416_4

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= 0 + var_416_4 and arg_413_1.time_ < 0 + var_416_4 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play122111100 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 122111100
		arg_417_1.duration_ = 2.23

		local var_417_0 = {
			ja = 2.066,
			ko = 2.233,
			zh = 2.233
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play122111101(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1084ui_story"]) and arg_417_1.var_.characterEffect1084ui_story == nil then
				arg_417_1.var_.characterEffect1084ui_story = arg_417_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1084ui_story"]) then
				if arg_417_1.var_.characterEffect1084ui_story and not isNil(arg_417_1.actors_["1084ui_story"]) then
					arg_417_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1084ui_story"]) and arg_417_1.var_.characterEffect1084ui_story then
				arg_417_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_420_2 = arg_417_1.actors_["1084ui_story"].transform

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1084ui_story = var_420_2.localPosition
			end

			local var_420_3 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_3 then
				var_420_2.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_417_1.time_ - 0) / var_420_3)
				var_420_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_420_2.position).x, (manager.ui.mainCamera.transform.position - var_420_2.position).y, (manager.ui.mainCamera.transform.position - var_420_2.position).z)
				var_420_2.localEulerAngles.z = 0
				var_420_2.localEulerAngles.x = 0
				var_420_2.localEulerAngles = var_420_2.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_3 and arg_417_1.time_ < 0 + var_420_3 + arg_420_0 then
				var_420_2.localPosition = Vector3.New(0, -0.97, -6)
				var_420_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_420_2.position).x, (manager.ui.mainCamera.transform.position - var_420_2.position).y, (manager.ui.mainCamera.transform.position - var_420_2.position).z)
				var_420_2.localEulerAngles.z = 0
				var_420_2.localEulerAngles.x = 0
				var_420_2.localEulerAngles = var_420_2.localEulerAngles
			end

			local var_420_4 = 0
			local var_420_5 = 0.225

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_4 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_6 = arg_417_1:GetWordFromCfg(122111100)
				local var_420_7 = arg_417_1:FormatText(var_420_6.content)

				arg_417_1.text_.text = var_420_7

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_9 = 9 <= 0 and var_420_5 or var_420_5 * (utf8.len(var_420_7) / 9)

				if (9 <= 0 and var_420_5 or var_420_5 * (utf8.len(var_420_7) / 9)) > 0 and var_420_5 < var_420_9 then
					arg_417_1.talkMaxDuration = var_420_9

					if var_420_9 + var_420_4 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_9 + var_420_4
					end
				end

				arg_417_1.text_.text = var_420_7
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111100", "story_v_out_122111.awb") ~= 0 then
					local var_420_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111100", "story_v_out_122111.awb") / 1000

					if var_420_10 + var_420_4 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_10 + var_420_4
					end

					if var_420_6.prefab_name ~= "" and arg_417_1.actors_[var_420_6.prefab_name] ~= nil then
						local var_420_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_6.prefab_name].transform, "story_v_out_122111", "122111100", "story_v_out_122111.awb")

						arg_417_1:RecordAudio("122111100", var_420_11)
						arg_417_1:RecordAudio("122111100", var_420_11)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_122111", "122111100", "story_v_out_122111.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_122111", "122111100", "story_v_out_122111.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_12 = math.max(var_420_5, arg_417_1.talkMaxDuration)

			if var_420_4 <= arg_417_1.time_ and arg_417_1.time_ < var_420_4 + var_420_12 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_4) / var_420_12

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_4 + var_420_12 and arg_417_1.time_ < var_420_4 + var_420_12 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play122111101 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 122111101
		arg_421_1.duration_ = 9

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play122111102(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 2 < arg_421_1.time_ and arg_421_1.time_ <= 2 + arg_424_0 then
				local var_424_0 = arg_421_1.bgs_.ST03

				arg_421_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_424_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_424_1 = var_424_0:GetComponent("SpriteRenderer")

				if var_424_1 and var_424_1.sprite then
					local var_424_2 = 2 * (var_424_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_424_0.transform.localScale = Vector3.New(var_424_2 / var_424_1.sprite.bounds.size.y < var_424_2 * manager.ui.mainCameraCom_.aspect / var_424_1.sprite.bounds.size.x and var_424_2 * manager.ui.mainCameraCom_.aspect / var_424_1.sprite.bounds.size.x or var_424_2 / var_424_1.sprite.bounds.size.y, var_424_2 / var_424_1.sprite.bounds.size.y < var_424_2 * manager.ui.mainCameraCom_.aspect / var_424_1.sprite.bounds.size.x and var_424_2 * manager.ui.mainCameraCom_.aspect / var_424_1.sprite.bounds.size.x or var_424_2 / var_424_1.sprite.bounds.size.y, 0)
				end

				for iter_424_0, iter_424_1 in pairs(arg_421_1.bgs_) do
					if iter_424_0 ~= "ST03" then
						iter_424_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_424_3 = 0

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_3 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_4 = 2

			if var_424_3 <= arg_421_1.time_ and arg_421_1.time_ < var_424_3 + var_424_4 then
				local var_424_5 = Color.New(0, 0, 0)

				var_424_5.a = Mathf.Lerp(0, 1, (arg_421_1.time_ - var_424_3) / var_424_4)
				arg_421_1.mask_.color = var_424_5
			end

			if arg_421_1.time_ >= var_424_3 + var_424_4 and arg_421_1.time_ < var_424_3 + var_424_4 + arg_424_0 then
				local var_424_6 = Color.New(0, 0, 0)

				var_424_6.a = 1
				arg_421_1.mask_.color = var_424_6
			end

			local var_424_7 = 2

			if 2 < arg_421_1.time_ and arg_421_1.time_ <= var_424_7 + arg_424_0 then
				arg_421_1.mask_.enabled = true
				arg_421_1.mask_.raycastTarget = true

				arg_421_1:SetGaussion(false)
			end

			local var_424_8 = 2

			if var_424_7 <= arg_421_1.time_ and arg_421_1.time_ < var_424_7 + var_424_8 then
				local var_424_9 = Color.New(0, 0, 0)

				var_424_9.a = Mathf.Lerp(1, 0, (arg_421_1.time_ - var_424_7) / var_424_8)
				arg_421_1.mask_.color = var_424_9
			end

			if arg_421_1.time_ >= var_424_7 + var_424_8 and arg_421_1.time_ < var_424_7 + var_424_8 + arg_424_0 then
				local var_424_10 = Color.New(0, 0, 0)

				arg_421_1.mask_.enabled = false
				var_424_10.a = 0
				arg_421_1.mask_.color = var_424_10
			end

			local var_424_11 = arg_421_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_421_1.time_ and arg_421_1.time_ <= 1.96599999815226 + arg_424_0 then
				arg_421_1.var_.moveOldPos1084ui_story = var_424_11.localPosition
			end

			local var_424_12 = 0.001

			if 1.96599999815226 <= arg_421_1.time_ and arg_421_1.time_ < 1.96599999815226 + var_424_12 then
				var_424_11.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_421_1.time_ - 1.96599999815226) / var_424_12)
				var_424_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_11.position).x, (manager.ui.mainCamera.transform.position - var_424_11.position).y, (manager.ui.mainCamera.transform.position - var_424_11.position).z)
				var_424_11.localEulerAngles.z = 0
				var_424_11.localEulerAngles.x = 0
				var_424_11.localEulerAngles = var_424_11.localEulerAngles
			end

			if arg_421_1.time_ >= 1.96599999815226 + var_424_12 and arg_421_1.time_ < 1.96599999815226 + var_424_12 + arg_424_0 then
				var_424_11.localPosition = Vector3.New(0, 100, 0)
				var_424_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_11.position).x, (manager.ui.mainCamera.transform.position - var_424_11.position).y, (manager.ui.mainCamera.transform.position - var_424_11.position).z)
				var_424_11.localEulerAngles.z = 0
				var_424_11.localEulerAngles.x = 0
				var_424_11.localEulerAngles = var_424_11.localEulerAngles
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:AudioAction("stop", "effect", "se_story_side_1028", "se_story_1028_smallwaveloop", "")
			end

			if arg_421_1.frameCnt_ <= 1 then
				arg_421_1.dialog_:SetActive(false)
			end

			local var_424_14 = 4
			local var_424_15 = 1.1

			if 4 < arg_421_1.time_ and arg_421_1.time_ <= var_424_14 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0

				arg_421_1.dialog_:SetActive(true)

				arg_421_1.dialogCg_.alpha = 0

				local var_424_16 = LeanTween.value(arg_421_1.dialog_, 0, 1, 0.3)

				var_424_16:setOnUpdate(LuaHelper.FloatAction(function(arg_425_0)
					arg_421_1.dialogCg_.alpha = arg_425_0
				end))
				var_424_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_421_1.dialog_)
					var_424_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_421_1.duration_ = arg_421_1.duration_ + 0.3

				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_17 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(122111101).content)

				arg_421_1.text_.text = var_424_17

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_19 = 44 <= 0 and var_424_15 or var_424_15 * (utf8.len(var_424_17) / 44)

				if (44 <= 0 and var_424_15 or var_424_15 * (utf8.len(var_424_17) / 44)) > 0 and var_424_15 < var_424_19 then
					arg_421_1.talkMaxDuration = var_424_19
					var_424_14 = var_424_14 + 0.3

					if var_424_19 + var_424_14 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_19 + var_424_14
					end
				end

				arg_421_1.text_.text = var_424_17
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_20 = var_424_14 + 0.3
			local var_424_21 = math.max(var_424_15, arg_421_1.talkMaxDuration)

			if var_424_14 + 0.3 <= arg_421_1.time_ and arg_421_1.time_ < var_424_20 + var_424_21 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_20) / var_424_21

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_20 + var_424_21 and arg_421_1.time_ < var_424_20 + var_424_21 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play122111102 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 122111102
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play122111103(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0.55

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_1 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(122111102).content)

				arg_427_1.text_.text = var_430_1

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_3 = 22 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 22)

				if (22 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 22)) > 0 and var_430_0 < var_430_3 then
					arg_427_1.talkMaxDuration = var_430_3

					if var_430_3 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_3 + 0
					end
				end

				arg_427_1.text_.text = var_430_1
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_4 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_4

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play122111103 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 122111103
		arg_431_1.duration_ = 12.4

		local var_431_0 = {
			ja = 12.4,
			ko = 7.066,
			zh = 7.066
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
				arg_431_0:Play122111104(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.var_.moveOldPos1084ui_story = arg_431_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_434_0 = 0.001

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 then
				arg_431_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_431_1.time_ - 0) / var_434_0)
				arg_431_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1084ui_story"].transform.position).z)
				arg_431_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["1084ui_story"].transform.localEulerAngles = arg_431_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 then
				arg_431_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_431_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1084ui_story"].transform.position).z)
				arg_431_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["1084ui_story"].transform.localEulerAngles = arg_431_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_434_1 = arg_431_1.actors_["1084ui_story"]

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(var_434_1) and arg_431_1.var_.characterEffect1084ui_story == nil then
				arg_431_1.var_.characterEffect1084ui_story = var_434_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_2 and not isNil(var_434_1) then
				if arg_431_1.var_.characterEffect1084ui_story and not isNil(var_434_1) then
					arg_431_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= 0 + var_434_2 and arg_431_1.time_ < 0 + var_434_2 + arg_434_0 and not isNil(var_434_1) and arg_431_1.var_.characterEffect1084ui_story then
				arg_431_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_434_4 = 0
			local var_434_5 = 0.85

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_4 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_6 = arg_431_1:GetWordFromCfg(122111103)
				local var_434_7 = arg_431_1:FormatText(var_434_6.content)

				arg_431_1.text_.text = var_434_7

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_9 = 34 <= 0 and var_434_5 or var_434_5 * (utf8.len(var_434_7) / 34)

				if (34 <= 0 and var_434_5 or var_434_5 * (utf8.len(var_434_7) / 34)) > 0 and var_434_5 < var_434_9 then
					arg_431_1.talkMaxDuration = var_434_9

					if var_434_9 + var_434_4 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_9 + var_434_4
					end
				end

				arg_431_1.text_.text = var_434_7
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111103", "story_v_out_122111.awb") ~= 0 then
					local var_434_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111103", "story_v_out_122111.awb") / 1000

					if var_434_10 + var_434_4 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_10 + var_434_4
					end

					if var_434_6.prefab_name ~= "" and arg_431_1.actors_[var_434_6.prefab_name] ~= nil then
						local var_434_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_6.prefab_name].transform, "story_v_out_122111", "122111103", "story_v_out_122111.awb")

						arg_431_1:RecordAudio("122111103", var_434_11)
						arg_431_1:RecordAudio("122111103", var_434_11)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_122111", "122111103", "story_v_out_122111.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_122111", "122111103", "story_v_out_122111.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_12 = math.max(var_434_5, arg_431_1.talkMaxDuration)

			if var_434_4 <= arg_431_1.time_ and arg_431_1.time_ < var_434_4 + var_434_12 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_4) / var_434_12

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_4 + var_434_12 and arg_431_1.time_ < var_434_4 + var_434_12 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play122111104 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 122111104
		arg_435_1.duration_ = 7.53

		local var_435_0 = {
			ja = 7.533,
			ko = 4.733,
			zh = 4.733
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
				arg_435_0:Play122111105(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos1084ui_story = arg_435_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_438_0 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 then
				arg_435_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_435_1.time_ - 0) / var_438_0)
				arg_435_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1084ui_story"].transform.position).z)
				arg_435_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1084ui_story"].transform.localEulerAngles = arg_435_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 then
				arg_435_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_435_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1084ui_story"].transform.position).z)
				arg_435_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1084ui_story"].transform.localEulerAngles = arg_435_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_438_1 = arg_435_1.actors_["1084ui_story"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_1) and arg_435_1.var_.characterEffect1084ui_story == nil then
				arg_435_1.var_.characterEffect1084ui_story = var_438_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_2 and not isNil(var_438_1) then
				if arg_435_1.var_.characterEffect1084ui_story and not isNil(var_438_1) then
					arg_435_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_2 and arg_435_1.time_ < 0 + var_438_2 + arg_438_0 and not isNil(var_438_1) and arg_435_1.var_.characterEffect1084ui_story then
				arg_435_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action436")
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_438_4 = 0
			local var_438_5 = 0.55

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_4 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_6 = arg_435_1:GetWordFromCfg(122111104)
				local var_438_7 = arg_435_1:FormatText(var_438_6.content)

				arg_435_1.text_.text = var_438_7

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_9 = 22 <= 0 and var_438_5 or var_438_5 * (utf8.len(var_438_7) / 22)

				if (22 <= 0 and var_438_5 or var_438_5 * (utf8.len(var_438_7) / 22)) > 0 and var_438_5 < var_438_9 then
					arg_435_1.talkMaxDuration = var_438_9

					if var_438_9 + var_438_4 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_9 + var_438_4
					end
				end

				arg_435_1.text_.text = var_438_7
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111104", "story_v_out_122111.awb") ~= 0 then
					local var_438_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111104", "story_v_out_122111.awb") / 1000

					if var_438_10 + var_438_4 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_10 + var_438_4
					end

					if var_438_6.prefab_name ~= "" and arg_435_1.actors_[var_438_6.prefab_name] ~= nil then
						local var_438_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_6.prefab_name].transform, "story_v_out_122111", "122111104", "story_v_out_122111.awb")

						arg_435_1:RecordAudio("122111104", var_438_11)
						arg_435_1:RecordAudio("122111104", var_438_11)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_122111", "122111104", "story_v_out_122111.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_122111", "122111104", "story_v_out_122111.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_12 = math.max(var_438_5, arg_435_1.talkMaxDuration)

			if var_438_4 <= arg_435_1.time_ and arg_435_1.time_ < var_438_4 + var_438_12 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_4) / var_438_12

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_4 + var_438_12 and arg_435_1.time_ < var_438_4 + var_438_12 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play122111105 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 122111105
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play122111106(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["1084ui_story"]) and arg_439_1.var_.characterEffect1084ui_story == nil then
				arg_439_1.var_.characterEffect1084ui_story = arg_439_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_0 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["1084ui_story"]) then
				if arg_439_1.var_.characterEffect1084ui_story and not isNil(arg_439_1.actors_["1084ui_story"]) then
					arg_439_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_439_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_439_1.time_ - 0) / var_442_0)
				end
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["1084ui_story"]) and arg_439_1.var_.characterEffect1084ui_story then
				arg_439_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_439_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_442_1 = 0
			local var_442_2 = 0.75

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_3 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(122111105).content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 30 <= 0 and var_442_2 or var_442_2 * (utf8.len(var_442_3) / 30)

				if (30 <= 0 and var_442_2 or var_442_2 * (utf8.len(var_442_3) / 30)) > 0 and var_442_2 < var_442_5 then
					arg_439_1.talkMaxDuration = var_442_5

					if var_442_5 + var_442_1 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + var_442_1
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_6 = math.max(var_442_2, arg_439_1.talkMaxDuration)

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_6 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_1) / var_442_6

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_1 + var_442_6 and arg_439_1.time_ < var_442_1 + var_442_6 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play122111106 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 122111106
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play122111107(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0.85

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_1 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(122111106).content)

				arg_443_1.text_.text = var_446_1

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_3 = 34 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 34)

				if (34 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 34)) > 0 and var_446_0 < var_446_3 then
					arg_443_1.talkMaxDuration = var_446_3

					if var_446_3 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_3 + 0
					end
				end

				arg_443_1.text_.text = var_446_1
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_4 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_4 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_4

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_4 and arg_443_1.time_ < 0 + var_446_4 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play122111107 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 122111107
		arg_447_1.duration_ = 8.53

		local var_447_0 = {
			ja = 8.533,
			ko = 3.966,
			zh = 3.966
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
				arg_447_0:Play122111108(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos1084ui_story = arg_447_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_450_0 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 then
				arg_447_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_447_1.time_ - 0) / var_450_0)
				arg_447_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_447_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1084ui_story"].transform.position).z)
				arg_447_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_447_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_447_1.actors_["1084ui_story"].transform.localEulerAngles = arg_447_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 then
				arg_447_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_447_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_447_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1084ui_story"].transform.position).z)
				arg_447_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_447_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_447_1.actors_["1084ui_story"].transform.localEulerAngles = arg_447_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_450_1 = arg_447_1.actors_["1084ui_story"]

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(var_450_1) and arg_447_1.var_.characterEffect1084ui_story == nil then
				arg_447_1.var_.characterEffect1084ui_story = var_450_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_2 = 0.200000002980232

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_2 and not isNil(var_450_1) then
				if arg_447_1.var_.characterEffect1084ui_story and not isNil(var_450_1) then
					arg_447_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= 0 + var_450_2 and arg_447_1.time_ < 0 + var_450_2 + arg_450_0 and not isNil(var_450_1) and arg_447_1.var_.characterEffect1084ui_story then
				arg_447_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action468")
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_450_4 = 0
			local var_450_5 = 0.55

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_4 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_6 = arg_447_1:GetWordFromCfg(122111107)
				local var_450_7 = arg_447_1:FormatText(var_450_6.content)

				arg_447_1.text_.text = var_450_7

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_9 = 22 <= 0 and var_450_5 or var_450_5 * (utf8.len(var_450_7) / 22)

				if (22 <= 0 and var_450_5 or var_450_5 * (utf8.len(var_450_7) / 22)) > 0 and var_450_5 < var_450_9 then
					arg_447_1.talkMaxDuration = var_450_9

					if var_450_9 + var_450_4 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_9 + var_450_4
					end
				end

				arg_447_1.text_.text = var_450_7
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111107", "story_v_out_122111.awb") ~= 0 then
					local var_450_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111107", "story_v_out_122111.awb") / 1000

					if var_450_10 + var_450_4 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_10 + var_450_4
					end

					if var_450_6.prefab_name ~= "" and arg_447_1.actors_[var_450_6.prefab_name] ~= nil then
						local var_450_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_6.prefab_name].transform, "story_v_out_122111", "122111107", "story_v_out_122111.awb")

						arg_447_1:RecordAudio("122111107", var_450_11)
						arg_447_1:RecordAudio("122111107", var_450_11)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_122111", "122111107", "story_v_out_122111.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_122111", "122111107", "story_v_out_122111.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play122111108 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 122111108
		arg_451_1.duration_ = 6.03

		local var_451_0 = {
			ja = 4.966,
			ko = 6.033,
			zh = 6.033
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
				arg_451_0:Play122111109(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_454_0 = 0
			local var_454_1 = 0.775

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_2 = arg_451_1:GetWordFromCfg(122111108)
				local var_454_3 = arg_451_1:FormatText(var_454_2.content)

				arg_451_1.text_.text = var_454_3

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_5 = 30 <= 0 and var_454_1 or var_454_1 * (utf8.len(var_454_3) / 30)

				if (30 <= 0 and var_454_1 or var_454_1 * (utf8.len(var_454_3) / 30)) > 0 and var_454_1 < var_454_5 then
					arg_451_1.talkMaxDuration = var_454_5

					if var_454_5 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_5 + var_454_0
					end
				end

				arg_451_1.text_.text = var_454_3
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111108", "story_v_out_122111.awb") ~= 0 then
					local var_454_6 = manager.audio:GetVoiceLength("story_v_out_122111", "122111108", "story_v_out_122111.awb") / 1000

					if var_454_6 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_6 + var_454_0
					end

					if var_454_2.prefab_name ~= "" and arg_451_1.actors_[var_454_2.prefab_name] ~= nil then
						local var_454_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_2.prefab_name].transform, "story_v_out_122111", "122111108", "story_v_out_122111.awb")

						arg_451_1:RecordAudio("122111108", var_454_7)
						arg_451_1:RecordAudio("122111108", var_454_7)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_122111", "122111108", "story_v_out_122111.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_122111", "122111108", "story_v_out_122111.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_8 = math.max(var_454_1, arg_451_1.talkMaxDuration)

			if var_454_0 <= arg_451_1.time_ and arg_451_1.time_ < var_454_0 + var_454_8 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_0) / var_454_8

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_0 + var_454_8 and arg_451_1.time_ < var_454_0 + var_454_8 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play122111109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 122111109
		arg_455_1.duration_ = 9

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play122111110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if arg_455_1.bgs_.ST17 == nil then
				local var_458_0 = Object.Instantiate(arg_455_1.paintGo_)

				var_458_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST17")
				var_458_0.name = "ST17"
				var_458_0.transform.parent = arg_455_1.stage_.transform
				var_458_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_455_1.bgs_.ST17 = var_458_0
			end

			if 2 < arg_455_1.time_ and arg_455_1.time_ <= 2 + arg_458_0 then
				local var_458_1 = arg_455_1.bgs_.ST17

				arg_455_1.bgs_.ST17.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_458_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_458_2 = var_458_1:GetComponent("SpriteRenderer")

				if var_458_2 and var_458_2.sprite then
					local var_458_3 = 2 * (var_458_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_458_1.transform.localScale = Vector3.New(var_458_3 / var_458_2.sprite.bounds.size.y < var_458_3 * manager.ui.mainCameraCom_.aspect / var_458_2.sprite.bounds.size.x and var_458_3 * manager.ui.mainCameraCom_.aspect / var_458_2.sprite.bounds.size.x or var_458_3 / var_458_2.sprite.bounds.size.y, var_458_3 / var_458_2.sprite.bounds.size.y < var_458_3 * manager.ui.mainCameraCom_.aspect / var_458_2.sprite.bounds.size.x and var_458_3 * manager.ui.mainCameraCom_.aspect / var_458_2.sprite.bounds.size.x or var_458_3 / var_458_2.sprite.bounds.size.y, 0)
				end

				for iter_458_0, iter_458_1 in pairs(arg_455_1.bgs_) do
					if iter_458_0 ~= "ST17" then
						iter_458_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_458_4 = 0

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_4 + arg_458_0 then
				arg_455_1.mask_.enabled = true
				arg_455_1.mask_.raycastTarget = true

				arg_455_1:SetGaussion(false)
			end

			local var_458_5 = 2

			if var_458_4 <= arg_455_1.time_ and arg_455_1.time_ < var_458_4 + var_458_5 then
				local var_458_6 = Color.New(0, 0, 0)

				var_458_6.a = Mathf.Lerp(0, 1, (arg_455_1.time_ - var_458_4) / var_458_5)
				arg_455_1.mask_.color = var_458_6
			end

			if arg_455_1.time_ >= var_458_4 + var_458_5 and arg_455_1.time_ < var_458_4 + var_458_5 + arg_458_0 then
				local var_458_7 = Color.New(0, 0, 0)

				var_458_7.a = 1
				arg_455_1.mask_.color = var_458_7
			end

			local var_458_8 = 2

			if 2 < arg_455_1.time_ and arg_455_1.time_ <= var_458_8 + arg_458_0 then
				arg_455_1.mask_.enabled = true
				arg_455_1.mask_.raycastTarget = true

				arg_455_1:SetGaussion(false)
			end

			local var_458_9 = 2

			if var_458_8 <= arg_455_1.time_ and arg_455_1.time_ < var_458_8 + var_458_9 then
				local var_458_10 = Color.New(0, 0, 0)

				var_458_10.a = Mathf.Lerp(1, 0, (arg_455_1.time_ - var_458_8) / var_458_9)
				arg_455_1.mask_.color = var_458_10
			end

			if arg_455_1.time_ >= var_458_8 + var_458_9 and arg_455_1.time_ < var_458_8 + var_458_9 + arg_458_0 then
				local var_458_11 = Color.New(0, 0, 0)

				arg_455_1.mask_.enabled = false
				var_458_11.a = 0
				arg_455_1.mask_.color = var_458_11
			end

			local var_458_12 = arg_455_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_455_1.time_ and arg_455_1.time_ <= 1.96599999815226 + arg_458_0 then
				arg_455_1.var_.moveOldPos1084ui_story = var_458_12.localPosition
			end

			local var_458_13 = 0.001

			if 1.96599999815226 <= arg_455_1.time_ and arg_455_1.time_ < 1.96599999815226 + var_458_13 then
				var_458_12.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_455_1.time_ - 1.96599999815226) / var_458_13)
				var_458_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_458_12.position).x, (manager.ui.mainCamera.transform.position - var_458_12.position).y, (manager.ui.mainCamera.transform.position - var_458_12.position).z)
				var_458_12.localEulerAngles.z = 0
				var_458_12.localEulerAngles.x = 0
				var_458_12.localEulerAngles = var_458_12.localEulerAngles
			end

			if arg_455_1.time_ >= 1.96599999815226 + var_458_13 and arg_455_1.time_ < 1.96599999815226 + var_458_13 + arg_458_0 then
				var_458_12.localPosition = Vector3.New(0, 100, 0)
				var_458_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_458_12.position).x, (manager.ui.mainCamera.transform.position - var_458_12.position).y, (manager.ui.mainCamera.transform.position - var_458_12.position).z)
				var_458_12.localEulerAngles.z = 0
				var_458_12.localEulerAngles.x = 0
				var_458_12.localEulerAngles = var_458_12.localEulerAngles
			end

			local var_458_14 = arg_455_1.actors_["1084ui_story"]

			if 1.96599999815226 < arg_455_1.time_ and arg_455_1.time_ <= 1.96599999815226 + arg_458_0 and not isNil(var_458_14) and arg_455_1.var_.characterEffect1084ui_story == nil then
				arg_455_1.var_.characterEffect1084ui_story = var_458_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_15 = 0.034000001847744

			if 1.96599999815226 <= arg_455_1.time_ and arg_455_1.time_ < 1.96599999815226 + var_458_15 and not isNil(var_458_14) then
				if arg_455_1.var_.characterEffect1084ui_story and not isNil(var_458_14) then
					arg_455_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_455_1.time_ - 1.96599999815226) / var_458_15)
				end
			end

			if arg_455_1.time_ >= 1.96599999815226 + var_458_15 and arg_455_1.time_ < 1.96599999815226 + var_458_15 + arg_458_0 and not isNil(var_458_14) and arg_455_1.var_.characterEffect1084ui_story then
				arg_455_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if arg_455_1.frameCnt_ <= 1 then
				arg_455_1.dialog_:SetActive(false)
			end

			local var_458_16 = 4
			local var_458_17 = 0.9

			if 4 < arg_455_1.time_ and arg_455_1.time_ <= var_458_16 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0

				arg_455_1.dialog_:SetActive(true)

				arg_455_1.dialogCg_.alpha = 0

				local var_458_18 = LeanTween.value(arg_455_1.dialog_, 0, 1, 0.3)

				var_458_18:setOnUpdate(LuaHelper.FloatAction(function(arg_459_0)
					arg_455_1.dialogCg_.alpha = arg_459_0
				end))
				var_458_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_455_1.dialog_)
					var_458_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_455_1.duration_ = arg_455_1.duration_ + 0.3

				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_19 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(122111109).content)

				arg_455_1.text_.text = var_458_19

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_21 = 36 <= 0 and var_458_17 or var_458_17 * (utf8.len(var_458_19) / 36)

				if (36 <= 0 and var_458_17 or var_458_17 * (utf8.len(var_458_19) / 36)) > 0 and var_458_17 < var_458_21 then
					arg_455_1.talkMaxDuration = var_458_21
					var_458_16 = var_458_16 + 0.3

					if var_458_21 + var_458_16 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_21 + var_458_16
					end
				end

				arg_455_1.text_.text = var_458_19
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_22 = var_458_16 + 0.3
			local var_458_23 = math.max(var_458_17, arg_455_1.talkMaxDuration)

			if var_458_16 + 0.3 <= arg_455_1.time_ and arg_455_1.time_ < var_458_22 + var_458_23 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_22) / var_458_23

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_22 + var_458_23 and arg_455_1.time_ < var_458_22 + var_458_23 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play122111110 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 122111110
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play122111111(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 1.05

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_1 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(122111110).content)

				arg_461_1.text_.text = var_464_1

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_3 = 42 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 42)

				if (42 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 42)) > 0 and var_464_0 < var_464_3 then
					arg_461_1.talkMaxDuration = var_464_3

					if var_464_3 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_3 + 0
					end
				end

				arg_461_1.text_.text = var_464_1
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_4 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_4

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play122111111 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 122111111
		arg_465_1.duration_ = 3.9

		local var_465_0 = {
			ja = 2.566,
			ko = 3.9,
			zh = 3.9
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play122111112(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos1084ui_story = arg_465_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_468_0 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 then
				arg_465_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_465_1.time_ - 0) / var_468_0)
				arg_465_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1084ui_story"].transform.position).z)
				arg_465_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1084ui_story"].transform.localEulerAngles = arg_465_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 then
				arg_465_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_465_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1084ui_story"].transform.position).z)
				arg_465_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1084ui_story"].transform.localEulerAngles = arg_465_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_468_1 = arg_465_1.actors_["1084ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1084ui_story == nil then
				arg_465_1.var_.characterEffect1084ui_story = var_468_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_2 and not isNil(var_468_1) then
				if arg_465_1.var_.characterEffect1084ui_story and not isNil(var_468_1) then
					arg_465_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_2 and arg_465_1.time_ < 0 + var_468_2 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1084ui_story then
				arg_465_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_468_4 = 0
			local var_468_5 = 0.325

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_4 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_6 = arg_465_1:GetWordFromCfg(122111111)
				local var_468_7 = arg_465_1:FormatText(var_468_6.content)

				arg_465_1.text_.text = var_468_7

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_9 = 13 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_7) / 13)

				if (13 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_7) / 13)) > 0 and var_468_5 < var_468_9 then
					arg_465_1.talkMaxDuration = var_468_9

					if var_468_9 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_9 + var_468_4
					end
				end

				arg_465_1.text_.text = var_468_7
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111111", "story_v_out_122111.awb") ~= 0 then
					local var_468_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111111", "story_v_out_122111.awb") / 1000

					if var_468_10 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_10 + var_468_4
					end

					if var_468_6.prefab_name ~= "" and arg_465_1.actors_[var_468_6.prefab_name] ~= nil then
						local var_468_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_6.prefab_name].transform, "story_v_out_122111", "122111111", "story_v_out_122111.awb")

						arg_465_1:RecordAudio("122111111", var_468_11)
						arg_465_1:RecordAudio("122111111", var_468_11)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_122111", "122111111", "story_v_out_122111.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_122111", "122111111", "story_v_out_122111.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_12 = math.max(var_468_5, arg_465_1.talkMaxDuration)

			if var_468_4 <= arg_465_1.time_ and arg_465_1.time_ < var_468_4 + var_468_12 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_4) / var_468_12

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_4 + var_468_12 and arg_465_1.time_ < var_468_4 + var_468_12 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play122111112 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 122111112
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play122111113(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["1084ui_story"]) and arg_469_1.var_.characterEffect1084ui_story == nil then
				arg_469_1.var_.characterEffect1084ui_story = arg_469_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["1084ui_story"]) then
				if arg_469_1.var_.characterEffect1084ui_story and not isNil(arg_469_1.actors_["1084ui_story"]) then
					arg_469_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_0)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["1084ui_story"]) and arg_469_1.var_.characterEffect1084ui_story then
				arg_469_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_472_1 = 0
			local var_472_2 = 0.475

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(122111112).content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 19 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 19)

				if (19 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 19)) > 0 and var_472_2 < var_472_5 then
					arg_469_1.talkMaxDuration = var_472_5

					if var_472_5 + var_472_1 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + var_472_1
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_6 = math.max(var_472_2, arg_469_1.talkMaxDuration)

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_6 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_1) / var_472_6

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_1 + var_472_6 and arg_469_1.time_ < var_472_1 + var_472_6 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play122111113 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 122111113
		arg_473_1.duration_ = 3.93

		local var_473_0 = {
			ja = 3.9,
			ko = 3.933,
			zh = 3.933
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play122111114(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos1084ui_story = arg_473_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_476_0 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 then
				arg_473_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_473_1.time_ - 0) / var_476_0)
				arg_473_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1084ui_story"].transform.position).z)
				arg_473_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1084ui_story"].transform.localEulerAngles = arg_473_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 then
				arg_473_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_473_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1084ui_story"].transform.position).z)
				arg_473_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1084ui_story"].transform.localEulerAngles = arg_473_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_476_1 = arg_473_1.actors_["1084ui_story"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1084ui_story == nil then
				arg_473_1.var_.characterEffect1084ui_story = var_476_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_2 and not isNil(var_476_1) then
				if arg_473_1.var_.characterEffect1084ui_story and not isNil(var_476_1) then
					arg_473_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_2 and arg_473_1.time_ < 0 + var_476_2 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1084ui_story then
				arg_473_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_476_4 = 0
			local var_476_5 = 0.525

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_4 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_6 = arg_473_1:GetWordFromCfg(122111113)
				local var_476_7 = arg_473_1:FormatText(var_476_6.content)

				arg_473_1.text_.text = var_476_7

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_9 = 21 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 21)

				if (21 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 21)) > 0 and var_476_5 < var_476_9 then
					arg_473_1.talkMaxDuration = var_476_9

					if var_476_9 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_9 + var_476_4
					end
				end

				arg_473_1.text_.text = var_476_7
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111113", "story_v_out_122111.awb") ~= 0 then
					local var_476_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111113", "story_v_out_122111.awb") / 1000

					if var_476_10 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_10 + var_476_4
					end

					if var_476_6.prefab_name ~= "" and arg_473_1.actors_[var_476_6.prefab_name] ~= nil then
						local var_476_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_6.prefab_name].transform, "story_v_out_122111", "122111113", "story_v_out_122111.awb")

						arg_473_1:RecordAudio("122111113", var_476_11)
						arg_473_1:RecordAudio("122111113", var_476_11)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_122111", "122111113", "story_v_out_122111.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_122111", "122111113", "story_v_out_122111.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_12 = math.max(var_476_5, arg_473_1.talkMaxDuration)

			if var_476_4 <= arg_473_1.time_ and arg_473_1.time_ < var_476_4 + var_476_12 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_4) / var_476_12

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_4 + var_476_12 and arg_473_1.time_ < var_476_4 + var_476_12 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play122111114 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 122111114
		arg_477_1.duration_ = 8.9

		local var_477_0 = {
			ja = 8.066,
			ko = 8.9,
			zh = 8.9
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
				arg_477_0:Play122111115(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["1084ui_story"]) and arg_477_1.var_.characterEffect1084ui_story == nil then
				arg_477_1.var_.characterEffect1084ui_story = arg_477_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["1084ui_story"]) then
				if arg_477_1.var_.characterEffect1084ui_story and not isNil(arg_477_1.actors_["1084ui_story"]) then
					arg_477_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["1084ui_story"]) and arg_477_1.var_.characterEffect1084ui_story then
				arg_477_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_480_2 = 0
			local var_480_3 = 1.2

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_2 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_4 = arg_477_1:GetWordFromCfg(122111114)
				local var_480_5 = arg_477_1:FormatText(var_480_4.content)

				arg_477_1.text_.text = var_480_5

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_7 = 48 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_5) / 48)

				if (48 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_5) / 48)) > 0 and var_480_3 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_2
					end
				end

				arg_477_1.text_.text = var_480_5
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111114", "story_v_out_122111.awb") ~= 0 then
					local var_480_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111114", "story_v_out_122111.awb") / 1000

					if var_480_8 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_8 + var_480_2
					end

					if var_480_4.prefab_name ~= "" and arg_477_1.actors_[var_480_4.prefab_name] ~= nil then
						local var_480_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_4.prefab_name].transform, "story_v_out_122111", "122111114", "story_v_out_122111.awb")

						arg_477_1:RecordAudio("122111114", var_480_9)
						arg_477_1:RecordAudio("122111114", var_480_9)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_122111", "122111114", "story_v_out_122111.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_122111", "122111114", "story_v_out_122111.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_10 = math.max(var_480_3, arg_477_1.talkMaxDuration)

			if var_480_2 <= arg_477_1.time_ and arg_477_1.time_ < var_480_2 + var_480_10 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_2) / var_480_10

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_2 + var_480_10 and arg_477_1.time_ < var_480_2 + var_480_10 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play122111115 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 122111115
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play122111116(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos1084ui_story = arg_481_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_484_0 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 then
				arg_481_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_481_1.time_ - 0) / var_484_0)
				arg_481_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1084ui_story"].transform.position).z)
				arg_481_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1084ui_story"].transform.localEulerAngles = arg_481_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 then
				arg_481_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_481_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1084ui_story"].transform.position).z)
				arg_481_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1084ui_story"].transform.localEulerAngles = arg_481_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_484_1 = arg_481_1.actors_["1084ui_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1084ui_story == nil then
				arg_481_1.var_.characterEffect1084ui_story = var_484_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_2 and not isNil(var_484_1) then
				if arg_481_1.var_.characterEffect1084ui_story and not isNil(var_484_1) then
					arg_481_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_481_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_481_1.time_ - 0) / var_484_2)
				end
			end

			if arg_481_1.time_ >= 0 + var_484_2 and arg_481_1.time_ < 0 + var_484_2 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1084ui_story then
				arg_481_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_481_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_484_3 = 0
			local var_484_4 = 1.475

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_3 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_5 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(122111115).content)

				arg_481_1.text_.text = var_484_5

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_7 = 59 <= 0 and var_484_4 or var_484_4 * (utf8.len(var_484_5) / 59)

				if (59 <= 0 and var_484_4 or var_484_4 * (utf8.len(var_484_5) / 59)) > 0 and var_484_4 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_3 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_3
					end
				end

				arg_481_1.text_.text = var_484_5
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_8 = math.max(var_484_4, arg_481_1.talkMaxDuration)

			if var_484_3 <= arg_481_1.time_ and arg_481_1.time_ < var_484_3 + var_484_8 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_3) / var_484_8

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_3 + var_484_8 and arg_481_1.time_ < var_484_3 + var_484_8 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play122111116 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 122111116
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play122111117(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0.225

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_1 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(122111116).content)

				arg_485_1.text_.text = var_488_1

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_3 = 9 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 9)

				if (9 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 9)) > 0 and var_488_0 < var_488_3 then
					arg_485_1.talkMaxDuration = var_488_3

					if var_488_3 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_3 + 0
					end
				end

				arg_485_1.text_.text = var_488_1
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_4 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_4 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_4

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_4 and arg_485_1.time_ < 0 + var_488_4 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play122111117 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 122111117
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play122111118(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.9

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

				local var_492_1 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(122111117).content)

				arg_489_1.text_.text = var_492_1

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_3 = 36 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 36)

				if (36 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 36)) > 0 and var_492_0 < var_492_3 then
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
	Play122111118 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 122111118
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play122111119(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.2

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_1 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(122111118).content)

				arg_493_1.text_.text = var_496_1

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_3 = 8 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 8)

				if (8 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 8)) > 0 and var_496_0 < var_496_3 then
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
	Play122111119 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 122111119
		arg_497_1.duration_ = 5.4

		local var_497_0 = {
			ja = 5.4,
			ko = 4.8,
			zh = 4.8
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play122111120(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0.45

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_1 = arg_497_1:GetWordFromCfg(122111119)
				local var_500_2 = arg_497_1:FormatText(var_500_1.content)

				arg_497_1.text_.text = var_500_2

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_4 = 18 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_2) / 18)

				if (18 <= 0 and var_500_0 or var_500_0 * (utf8.len(var_500_2) / 18)) > 0 and var_500_0 < var_500_4 then
					arg_497_1.talkMaxDuration = var_500_4

					if var_500_4 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_4 + 0
					end
				end

				arg_497_1.text_.text = var_500_2
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111119", "story_v_out_122111.awb") ~= 0 then
					local var_500_5 = manager.audio:GetVoiceLength("story_v_out_122111", "122111119", "story_v_out_122111.awb") / 1000

					if var_500_5 + 0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + 0
					end

					if var_500_1.prefab_name ~= "" and arg_497_1.actors_[var_500_1.prefab_name] ~= nil then
						local var_500_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_1.prefab_name].transform, "story_v_out_122111", "122111119", "story_v_out_122111.awb")

						arg_497_1:RecordAudio("122111119", var_500_6)
						arg_497_1:RecordAudio("122111119", var_500_6)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_122111", "122111119", "story_v_out_122111.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_122111", "122111119", "story_v_out_122111.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_7 = math.max(var_500_0, arg_497_1.talkMaxDuration)

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_7 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - 0) / var_500_7

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= 0 + var_500_7 and arg_497_1.time_ < 0 + var_500_7 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play122111120 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 122111120
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play122111121(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos1084ui_story = arg_501_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_504_0 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 then
				arg_501_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_501_1.time_ - 0) / var_504_0)
				arg_501_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1084ui_story"].transform.position).z)
				arg_501_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["1084ui_story"].transform.localEulerAngles = arg_501_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 then
				arg_501_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_501_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1084ui_story"].transform.position).z)
				arg_501_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["1084ui_story"].transform.localEulerAngles = arg_501_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_504_1 = arg_501_1.actors_["1084ui_story"]

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(var_504_1) and arg_501_1.var_.characterEffect1084ui_story == nil then
				arg_501_1.var_.characterEffect1084ui_story = var_504_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_2 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_2 and not isNil(var_504_1) then
				if arg_501_1.var_.characterEffect1084ui_story and not isNil(var_504_1) then
					arg_501_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= 0 + var_504_2 and arg_501_1.time_ < 0 + var_504_2 + arg_504_0 and not isNil(var_504_1) and arg_501_1.var_.characterEffect1084ui_story then
				arg_501_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_504_4 = 0
			local var_504_5 = 0.875

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_4 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_6 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(122111120).content)

				arg_501_1.text_.text = var_504_6

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_8 = 35 <= 0 and var_504_5 or var_504_5 * (utf8.len(var_504_6) / 35)

				if (35 <= 0 and var_504_5 or var_504_5 * (utf8.len(var_504_6) / 35)) > 0 and var_504_5 < var_504_8 then
					arg_501_1.talkMaxDuration = var_504_8

					if var_504_8 + var_504_4 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_8 + var_504_4
					end
				end

				arg_501_1.text_.text = var_504_6
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_9 = math.max(var_504_5, arg_501_1.talkMaxDuration)

			if var_504_4 <= arg_501_1.time_ and arg_501_1.time_ < var_504_4 + var_504_9 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_4) / var_504_9

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_4 + var_504_9 and arg_501_1.time_ < var_504_4 + var_504_9 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play122111121 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 122111121
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play122111122(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0.125

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_1 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(122111121).content)

				arg_505_1.text_.text = var_508_1

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_3 = 5 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 5)

				if (5 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 5)) > 0 and var_508_0 < var_508_3 then
					arg_505_1.talkMaxDuration = var_508_3

					if var_508_3 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_3 + 0
					end
				end

				arg_505_1.text_.text = var_508_1
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_4 = math.max(var_508_0, arg_505_1.talkMaxDuration)

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_4 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - 0) / var_508_4

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= 0 + var_508_4 and arg_505_1.time_ < 0 + var_508_4 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play122111122 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 122111122
		arg_509_1.duration_ = 6.83

		local var_509_0 = {
			ja = 6.833,
			ko = 3.433,
			zh = 3.433
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play122111123(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_512_0 = 0
			local var_512_1 = 0.7

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_2 = arg_509_1:GetWordFromCfg(122111122)
				local var_512_3 = arg_509_1:FormatText(var_512_2.content)

				arg_509_1.text_.text = var_512_3

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 28 <= 0 and var_512_1 or var_512_1 * (utf8.len(var_512_3) / 28)

				if (28 <= 0 and var_512_1 or var_512_1 * (utf8.len(var_512_3) / 28)) > 0 and var_512_1 < var_512_5 then
					arg_509_1.talkMaxDuration = var_512_5

					if var_512_5 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + var_512_0
					end
				end

				arg_509_1.text_.text = var_512_3
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111122", "story_v_out_122111.awb") ~= 0 then
					local var_512_6 = manager.audio:GetVoiceLength("story_v_out_122111", "122111122", "story_v_out_122111.awb") / 1000

					if var_512_6 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_6 + var_512_0
					end

					if var_512_2.prefab_name ~= "" and arg_509_1.actors_[var_512_2.prefab_name] ~= nil then
						local var_512_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_2.prefab_name].transform, "story_v_out_122111", "122111122", "story_v_out_122111.awb")

						arg_509_1:RecordAudio("122111122", var_512_7)
						arg_509_1:RecordAudio("122111122", var_512_7)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_122111", "122111122", "story_v_out_122111.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_122111", "122111122", "story_v_out_122111.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_8 = math.max(var_512_1, arg_509_1.talkMaxDuration)

			if var_512_0 <= arg_509_1.time_ and arg_509_1.time_ < var_512_0 + var_512_8 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_0) / var_512_8

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_0 + var_512_8 and arg_509_1.time_ < var_512_0 + var_512_8 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play122111123 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 122111123
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play122111124(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(arg_513_1.actors_["1084ui_story"]) and arg_513_1.var_.characterEffect1084ui_story == nil then
				arg_513_1.var_.characterEffect1084ui_story = arg_513_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_0 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 and not isNil(arg_513_1.actors_["1084ui_story"]) then
				if arg_513_1.var_.characterEffect1084ui_story and not isNil(arg_513_1.actors_["1084ui_story"]) then
					arg_513_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_513_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_513_1.time_ - 0) / var_516_0)
				end
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 and not isNil(arg_513_1.actors_["1084ui_story"]) and arg_513_1.var_.characterEffect1084ui_story then
				arg_513_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_513_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_516_1 = 0
			local var_516_2 = 0.55

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_3 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(122111123).content)

				arg_513_1.text_.text = var_516_3

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 22 <= 0 and var_516_2 or var_516_2 * (utf8.len(var_516_3) / 22)

				if (22 <= 0 and var_516_2 or var_516_2 * (utf8.len(var_516_3) / 22)) > 0 and var_516_2 < var_516_5 then
					arg_513_1.talkMaxDuration = var_516_5

					if var_516_5 + var_516_1 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_5 + var_516_1
					end
				end

				arg_513_1.text_.text = var_516_3
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_6 = math.max(var_516_2, arg_513_1.talkMaxDuration)

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_6 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_1) / var_516_6

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_1 + var_516_6 and arg_513_1.time_ < var_516_1 + var_516_6 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play122111124 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 122111124
		arg_517_1.duration_ = 10.13

		local var_517_0 = {
			ja = 10.133,
			ko = 9.7,
			zh = 9.7
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play122111125(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(arg_517_1.actors_["1084ui_story"]) and arg_517_1.var_.characterEffect1084ui_story == nil then
				arg_517_1.var_.characterEffect1084ui_story = arg_517_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_0 = 0.200000002980232

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 and not isNil(arg_517_1.actors_["1084ui_story"]) then
				if arg_517_1.var_.characterEffect1084ui_story and not isNil(arg_517_1.actors_["1084ui_story"]) then
					arg_517_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 and not isNil(arg_517_1.actors_["1084ui_story"]) and arg_517_1.var_.characterEffect1084ui_story then
				arg_517_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_520_2 = 0
			local var_520_3 = 1.125

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_2 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_4 = arg_517_1:GetWordFromCfg(122111124)
				local var_520_5 = arg_517_1:FormatText(var_520_4.content)

				arg_517_1.text_.text = var_520_5

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_7 = 45 <= 0 and var_520_3 or var_520_3 * (utf8.len(var_520_5) / 45)

				if (45 <= 0 and var_520_3 or var_520_3 * (utf8.len(var_520_5) / 45)) > 0 and var_520_3 < var_520_7 then
					arg_517_1.talkMaxDuration = var_520_7

					if var_520_7 + var_520_2 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_2
					end
				end

				arg_517_1.text_.text = var_520_5
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111124", "story_v_out_122111.awb") ~= 0 then
					local var_520_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111124", "story_v_out_122111.awb") / 1000

					if var_520_8 + var_520_2 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_8 + var_520_2
					end

					if var_520_4.prefab_name ~= "" and arg_517_1.actors_[var_520_4.prefab_name] ~= nil then
						local var_520_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_4.prefab_name].transform, "story_v_out_122111", "122111124", "story_v_out_122111.awb")

						arg_517_1:RecordAudio("122111124", var_520_9)
						arg_517_1:RecordAudio("122111124", var_520_9)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_122111", "122111124", "story_v_out_122111.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_122111", "122111124", "story_v_out_122111.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_10 = math.max(var_520_3, arg_517_1.talkMaxDuration)

			if var_520_2 <= arg_517_1.time_ and arg_517_1.time_ < var_520_2 + var_520_10 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_2) / var_520_10

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_2 + var_520_10 and arg_517_1.time_ < var_520_2 + var_520_10 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play122111125 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 122111125
		arg_521_1.duration_ = 15.03

		local var_521_0 = {
			ja = 15.033,
			ko = 7.866,
			zh = 7.866
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play122111126(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 1.05

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_1 = arg_521_1:GetWordFromCfg(122111125)
				local var_524_2 = arg_521_1:FormatText(var_524_1.content)

				arg_521_1.text_.text = var_524_2

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_4 = 42 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 42)

				if (42 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 42)) > 0 and var_524_0 < var_524_4 then
					arg_521_1.talkMaxDuration = var_524_4

					if var_524_4 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_4 + 0
					end
				end

				arg_521_1.text_.text = var_524_2
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111125", "story_v_out_122111.awb") ~= 0 then
					local var_524_5 = manager.audio:GetVoiceLength("story_v_out_122111", "122111125", "story_v_out_122111.awb") / 1000

					if var_524_5 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + 0
					end

					if var_524_1.prefab_name ~= "" and arg_521_1.actors_[var_524_1.prefab_name] ~= nil then
						local var_524_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_1.prefab_name].transform, "story_v_out_122111", "122111125", "story_v_out_122111.awb")

						arg_521_1:RecordAudio("122111125", var_524_6)
						arg_521_1:RecordAudio("122111125", var_524_6)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_122111", "122111125", "story_v_out_122111.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_122111", "122111125", "story_v_out_122111.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_7 = math.max(var_524_0, arg_521_1.talkMaxDuration)

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_7 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - 0) / var_524_7

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= 0 + var_524_7 and arg_521_1.time_ < 0 + var_524_7 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play122111126 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 122111126
		arg_525_1.duration_ = 10.27

		local var_525_0 = {
			ja = 10.266,
			ko = 7.166,
			zh = 7.166
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play122111127(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 1.1

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_1 = arg_525_1:GetWordFromCfg(122111126)
				local var_528_2 = arg_525_1:FormatText(var_528_1.content)

				arg_525_1.text_.text = var_528_2

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_4 = 44 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 44)

				if (44 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 44)) > 0 and var_528_0 < var_528_4 then
					arg_525_1.talkMaxDuration = var_528_4

					if var_528_4 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_4 + 0
					end
				end

				arg_525_1.text_.text = var_528_2
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111126", "story_v_out_122111.awb") ~= 0 then
					local var_528_5 = manager.audio:GetVoiceLength("story_v_out_122111", "122111126", "story_v_out_122111.awb") / 1000

					if var_528_5 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_5 + 0
					end

					if var_528_1.prefab_name ~= "" and arg_525_1.actors_[var_528_1.prefab_name] ~= nil then
						local var_528_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_1.prefab_name].transform, "story_v_out_122111", "122111126", "story_v_out_122111.awb")

						arg_525_1:RecordAudio("122111126", var_528_6)
						arg_525_1:RecordAudio("122111126", var_528_6)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_122111", "122111126", "story_v_out_122111.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_122111", "122111126", "story_v_out_122111.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_7 = math.max(var_528_0, arg_525_1.talkMaxDuration)

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_7 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - 0) / var_528_7

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= 0 + var_528_7 and arg_525_1.time_ < 0 + var_528_7 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play122111127 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 122111127
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play122111128(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(arg_529_1.actors_["1084ui_story"]) and arg_529_1.var_.characterEffect1084ui_story == nil then
				arg_529_1.var_.characterEffect1084ui_story = arg_529_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_0 = 0.200000002980232

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 and not isNil(arg_529_1.actors_["1084ui_story"]) then
				if arg_529_1.var_.characterEffect1084ui_story and not isNil(arg_529_1.actors_["1084ui_story"]) then
					arg_529_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_529_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_529_1.time_ - 0) / var_532_0)
				end
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 and not isNil(arg_529_1.actors_["1084ui_story"]) and arg_529_1.var_.characterEffect1084ui_story then
				arg_529_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_529_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_532_1 = 0
			local var_532_2 = 0.25

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, true)
				arg_529_1.iconController_:SetSelectedState("hero")

				arg_529_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_529_1.callingController_:SetSelectedState("normal")

				arg_529_1.keyicon_.color = Color.New(1, 1, 1)
				arg_529_1.icon_.color = Color.New(1, 1, 1)

				local var_532_3 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(122111127).content)

				arg_529_1.text_.text = var_532_3

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_5 = 10 <= 0 and var_532_2 or var_532_2 * (utf8.len(var_532_3) / 10)

				if (10 <= 0 and var_532_2 or var_532_2 * (utf8.len(var_532_3) / 10)) > 0 and var_532_2 < var_532_5 then
					arg_529_1.talkMaxDuration = var_532_5

					if var_532_5 + var_532_1 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_5 + var_532_1
					end
				end

				arg_529_1.text_.text = var_532_3
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_6 = math.max(var_532_2, arg_529_1.talkMaxDuration)

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_6 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_1) / var_532_6

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_1 + var_532_6 and arg_529_1.time_ < var_532_1 + var_532_6 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play122111128 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 122111128
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play122111129(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 1

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, false)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_1 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(122111128).content)

				arg_533_1.text_.text = var_536_1

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_3 = 40 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_1) / 40)

				if (40 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_1) / 40)) > 0 and var_536_0 < var_536_3 then
					arg_533_1.talkMaxDuration = var_536_3

					if var_536_3 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_3 + 0
					end
				end

				arg_533_1.text_.text = var_536_1
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_4 = math.max(var_536_0, arg_533_1.talkMaxDuration)

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_4 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - 0) / var_536_4

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= 0 + var_536_4 and arg_533_1.time_ < 0 + var_536_4 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play122111129 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 122111129
		arg_537_1.duration_ = 5.7

		local var_537_0 = {
			ja = 5.7,
			ko = 4.8,
			zh = 4.8
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play122111130(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.var_.moveOldPos1084ui_story = arg_537_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_540_0 = 0.001

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_0 then
				arg_537_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_537_1.time_ - 0) / var_540_0)
				arg_537_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_537_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1084ui_story"].transform.position).z)
				arg_537_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_537_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_537_1.actors_["1084ui_story"].transform.localEulerAngles = arg_537_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_537_1.time_ >= 0 + var_540_0 and arg_537_1.time_ < 0 + var_540_0 + arg_540_0 then
				arg_537_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_537_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_537_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1084ui_story"].transform.position).z)
				arg_537_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_537_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_537_1.actors_["1084ui_story"].transform.localEulerAngles = arg_537_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_540_1 = arg_537_1.actors_["1084ui_story"]

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(var_540_1) and arg_537_1.var_.characterEffect1084ui_story == nil then
				arg_537_1.var_.characterEffect1084ui_story = var_540_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_2 = 0.200000002980232

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_2 and not isNil(var_540_1) then
				if arg_537_1.var_.characterEffect1084ui_story and not isNil(var_540_1) then
					arg_537_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_537_1.time_ >= 0 + var_540_2 and arg_537_1.time_ < 0 + var_540_2 + arg_540_0 and not isNil(var_540_1) and arg_537_1.var_.characterEffect1084ui_story then
				arg_537_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action428")
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_540_4 = 0
			local var_540_5 = 0.575

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_4 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_6 = arg_537_1:GetWordFromCfg(122111129)
				local var_540_7 = arg_537_1:FormatText(var_540_6.content)

				arg_537_1.text_.text = var_540_7

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_9 = 23 <= 0 and var_540_5 or var_540_5 * (utf8.len(var_540_7) / 23)

				if (23 <= 0 and var_540_5 or var_540_5 * (utf8.len(var_540_7) / 23)) > 0 and var_540_5 < var_540_9 then
					arg_537_1.talkMaxDuration = var_540_9

					if var_540_9 + var_540_4 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_9 + var_540_4
					end
				end

				arg_537_1.text_.text = var_540_7
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111129", "story_v_out_122111.awb") ~= 0 then
					local var_540_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111129", "story_v_out_122111.awb") / 1000

					if var_540_10 + var_540_4 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_10 + var_540_4
					end

					if var_540_6.prefab_name ~= "" and arg_537_1.actors_[var_540_6.prefab_name] ~= nil then
						local var_540_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_6.prefab_name].transform, "story_v_out_122111", "122111129", "story_v_out_122111.awb")

						arg_537_1:RecordAudio("122111129", var_540_11)
						arg_537_1:RecordAudio("122111129", var_540_11)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_122111", "122111129", "story_v_out_122111.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_122111", "122111129", "story_v_out_122111.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_12 = math.max(var_540_5, arg_537_1.talkMaxDuration)

			if var_540_4 <= arg_537_1.time_ and arg_537_1.time_ < var_540_4 + var_540_12 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_4) / var_540_12

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_4 + var_540_12 and arg_537_1.time_ < var_540_4 + var_540_12 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_537_1:InitPlayNodeList()
	end,
	Play122111130 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 122111130
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play122111131(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos1084ui_story = arg_541_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_544_0 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 then
				arg_541_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_541_1.time_ - 0) / var_544_0)
				arg_541_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1084ui_story"].transform.position).z)
				arg_541_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["1084ui_story"].transform.localEulerAngles = arg_541_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 then
				arg_541_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_541_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1084ui_story"].transform.position).z)
				arg_541_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["1084ui_story"].transform.localEulerAngles = arg_541_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_544_1 = arg_541_1.actors_["1084ui_story"]

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(var_544_1) and arg_541_1.var_.characterEffect1084ui_story == nil then
				arg_541_1.var_.characterEffect1084ui_story = var_544_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_2 = 0.200000002980232

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_2 and not isNil(var_544_1) then
				if arg_541_1.var_.characterEffect1084ui_story and not isNil(var_544_1) then
					arg_541_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_541_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_541_1.time_ - 0) / var_544_2)
				end
			end

			if arg_541_1.time_ >= 0 + var_544_2 and arg_541_1.time_ < 0 + var_544_2 + arg_544_0 and not isNil(var_544_1) and arg_541_1.var_.characterEffect1084ui_story then
				arg_541_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_541_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_544_3 = 0
			local var_544_4 = 0.95

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_3 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, false)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_5 = arg_541_1:FormatText(arg_541_1:GetWordFromCfg(122111130).content)

				arg_541_1.text_.text = var_544_5

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_7 = 38 <= 0 and var_544_4 or var_544_4 * (utf8.len(var_544_5) / 38)

				if (38 <= 0 and var_544_4 or var_544_4 * (utf8.len(var_544_5) / 38)) > 0 and var_544_4 < var_544_7 then
					arg_541_1.talkMaxDuration = var_544_7

					if var_544_7 + var_544_3 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_3
					end
				end

				arg_541_1.text_.text = var_544_5
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_8 = math.max(var_544_4, arg_541_1.talkMaxDuration)

			if var_544_3 <= arg_541_1.time_ and arg_541_1.time_ < var_544_3 + var_544_8 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_3) / var_544_8

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_3 + var_544_8 and arg_541_1.time_ < var_544_3 + var_544_8 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play122111131 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 122111131
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play122111132(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 1.325

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, false)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_1 = arg_545_1:FormatText(arg_545_1:GetWordFromCfg(122111131).content)

				arg_545_1.text_.text = var_548_1

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_3 = 53 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_1) / 53)

				if (53 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_1) / 53)) > 0 and var_548_0 < var_548_3 then
					arg_545_1.talkMaxDuration = var_548_3

					if var_548_3 + 0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_3 + 0
					end
				end

				arg_545_1.text_.text = var_548_1
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_4 = math.max(var_548_0, arg_545_1.talkMaxDuration)

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_4 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - 0) / var_548_4

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= 0 + var_548_4 and arg_545_1.time_ < 0 + var_548_4 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play122111132 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 122111132
		arg_549_1.duration_ = 8.17

		local var_549_0 = {
			ja = 8.166,
			ko = 7.133,
			zh = 7.133
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play122111133(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if arg_549_1.bgs_.XH0505 == nil then
				local var_552_0 = Object.Instantiate(arg_549_1.paintGo_)

				var_552_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0505")
				var_552_0.name = "XH0505"
				var_552_0.transform.parent = arg_549_1.stage_.transform
				var_552_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_549_1.bgs_.XH0505 = var_552_0
			end

			if 2 < arg_549_1.time_ and arg_549_1.time_ <= 2 + arg_552_0 then
				local var_552_1 = arg_549_1.bgs_.XH0505

				arg_549_1.bgs_.XH0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_552_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_552_2 = var_552_1:GetComponent("SpriteRenderer")

				if var_552_2 and var_552_2.sprite then
					local var_552_3 = 2 * (var_552_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_552_1.transform.localScale = Vector3.New(var_552_3 / var_552_2.sprite.bounds.size.y < var_552_3 * manager.ui.mainCameraCom_.aspect / var_552_2.sprite.bounds.size.x and var_552_3 * manager.ui.mainCameraCom_.aspect / var_552_2.sprite.bounds.size.x or var_552_3 / var_552_2.sprite.bounds.size.y, var_552_3 / var_552_2.sprite.bounds.size.y < var_552_3 * manager.ui.mainCameraCom_.aspect / var_552_2.sprite.bounds.size.x and var_552_3 * manager.ui.mainCameraCom_.aspect / var_552_2.sprite.bounds.size.x or var_552_3 / var_552_2.sprite.bounds.size.y, 0)
				end

				for iter_552_0, iter_552_1 in pairs(arg_549_1.bgs_) do
					if iter_552_0 ~= "XH0505" then
						iter_552_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_552_4 = 0

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_4 + arg_552_0 then
				arg_549_1.mask_.enabled = true
				arg_549_1.mask_.raycastTarget = true

				arg_549_1:SetGaussion(false)
			end

			local var_552_5 = 2

			if var_552_4 <= arg_549_1.time_ and arg_549_1.time_ < var_552_4 + var_552_5 then
				local var_552_6 = Color.New(0, 0, 0)

				var_552_6.a = Mathf.Lerp(0, 1, (arg_549_1.time_ - var_552_4) / var_552_5)
				arg_549_1.mask_.color = var_552_6
			end

			if arg_549_1.time_ >= var_552_4 + var_552_5 and arg_549_1.time_ < var_552_4 + var_552_5 + arg_552_0 then
				local var_552_7 = Color.New(0, 0, 0)

				var_552_7.a = 1
				arg_549_1.mask_.color = var_552_7
			end

			local var_552_8 = 2

			if 2 < arg_549_1.time_ and arg_549_1.time_ <= var_552_8 + arg_552_0 then
				arg_549_1.mask_.enabled = true
				arg_549_1.mask_.raycastTarget = true

				arg_549_1:SetGaussion(false)
			end

			local var_552_9 = 2

			if var_552_8 <= arg_549_1.time_ and arg_549_1.time_ < var_552_8 + var_552_9 then
				local var_552_10 = Color.New(0, 0, 0)

				var_552_10.a = Mathf.Lerp(1, 0, (arg_549_1.time_ - var_552_8) / var_552_9)
				arg_549_1.mask_.color = var_552_10
			end

			if arg_549_1.time_ >= var_552_8 + var_552_9 and arg_549_1.time_ < var_552_8 + var_552_9 + arg_552_0 then
				local var_552_11 = Color.New(0, 0, 0)

				arg_549_1.mask_.enabled = false
				var_552_11.a = 0
				arg_549_1.mask_.color = var_552_11
			end

			if 3.8 < arg_549_1.time_ and arg_549_1.time_ <= 3.8 + arg_552_0 then
				arg_549_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_552_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_549_1.bgmTxt_.text ~= var_552_14 and arg_549_1.bgmTxt_.text ~= "" then
						if arg_549_1.bgmTxt2_.text ~= "" then
							arg_549_1.bgmTxt_.text = arg_549_1.bgmTxt2_.text
						end

						arg_549_1.bgmTxt2_.text = var_552_14

						arg_549_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_549_1.bgmTxt_.text = var_552_14
						arg_549_1.bgmTxt2_.text = var_552_14
					end

					if arg_549_1.bgmTimer then
						arg_549_1.bgmTimer:Stop()

						arg_549_1.bgmTimer = nil
					end

					if arg_549_1.settingData.show_music_name == 1 then
						arg_549_1.musicController:SetSelectedState("show")
						arg_549_1.musicAnimator_:Play("open", 0, 0)

						if arg_549_1.settingData.music_time ~= 0 then
							arg_549_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_549_1.settingData.music_time), function()
								if arg_549_1 == nil or isNil(arg_549_1.bgmTxt_) then
									return
								end

								arg_549_1.musicController:SetSelectedState("hide")
								arg_549_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_549_1.frameCnt_ <= 1 then
				arg_549_1.dialog_:SetActive(false)
			end

			local var_552_15 = 4
			local var_552_16 = 0.35

			if 4 < arg_549_1.time_ and arg_549_1.time_ <= var_552_15 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0

				arg_549_1.dialog_:SetActive(true)

				arg_549_1.dialogCg_.alpha = 0

				local var_552_17 = LeanTween.value(arg_549_1.dialog_, 0, 1, 0.3)

				var_552_17:setOnUpdate(LuaHelper.FloatAction(function(arg_554_0)
					arg_549_1.dialogCg_.alpha = arg_554_0
				end))
				var_552_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_549_1.dialog_)
					var_552_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_549_1.duration_ = arg_549_1.duration_ + 0.3

				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_18 = arg_549_1:GetWordFromCfg(122111132)
				local var_552_19 = arg_549_1:FormatText(var_552_18.content)

				arg_549_1.text_.text = var_552_19

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_21 = 14 <= 0 and var_552_16 or var_552_16 * (utf8.len(var_552_19) / 14)

				if (14 <= 0 and var_552_16 or var_552_16 * (utf8.len(var_552_19) / 14)) > 0 and var_552_16 < var_552_21 then
					arg_549_1.talkMaxDuration = var_552_21
					var_552_15 = var_552_15 + 0.3

					if var_552_21 + var_552_15 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_21 + var_552_15
					end
				end

				arg_549_1.text_.text = var_552_19
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111132", "story_v_out_122111.awb") ~= 0 then
					local var_552_22 = manager.audio:GetVoiceLength("story_v_out_122111", "122111132", "story_v_out_122111.awb") / 1000

					if var_552_22 + var_552_15 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_22 + var_552_15
					end

					if var_552_18.prefab_name ~= "" and arg_549_1.actors_[var_552_18.prefab_name] ~= nil then
						local var_552_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_18.prefab_name].transform, "story_v_out_122111", "122111132", "story_v_out_122111.awb")

						arg_549_1:RecordAudio("122111132", var_552_23)
						arg_549_1:RecordAudio("122111132", var_552_23)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_122111", "122111132", "story_v_out_122111.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_122111", "122111132", "story_v_out_122111.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_24 = var_552_15 + 0.3
			local var_552_25 = math.max(var_552_16, arg_549_1.talkMaxDuration)

			if var_552_15 + 0.3 <= arg_549_1.time_ and arg_549_1.time_ < var_552_24 + var_552_25 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_24) / var_552_25

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_24 + var_552_25 and arg_549_1.time_ < var_552_24 + var_552_25 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play122111133 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 122111133
		arg_556_1.duration_ = 5

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play122111134(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0.325

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				arg_556_1.leftNameTxt_.text = arg_556_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, true)
				arg_556_1.iconController_:SetSelectedState("hero")

				arg_556_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_556_1.callingController_:SetSelectedState("normal")

				arg_556_1.keyicon_.color = Color.New(1, 1, 1)
				arg_556_1.icon_.color = Color.New(1, 1, 1)

				local var_559_1 = arg_556_1:FormatText(arg_556_1:GetWordFromCfg(122111133).content)

				arg_556_1.text_.text = var_559_1

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_3 = 13 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_1) / 13)

				if (13 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_1) / 13)) > 0 and var_559_0 < var_559_3 then
					arg_556_1.talkMaxDuration = var_559_3

					if var_559_3 + 0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_3 + 0
					end
				end

				arg_556_1.text_.text = var_559_1
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_4 = math.max(var_559_0, arg_556_1.talkMaxDuration)

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_4 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - 0) / var_559_4

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= 0 + var_559_4 and arg_556_1.time_ < 0 + var_559_4 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play122111134 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 122111134
		arg_560_1.duration_ = 6.1

		local var_560_0 = {
			ja = 5.4,
			ko = 6.1,
			zh = 6.1
		}
		local var_560_1 = manager.audio:GetLocalizationFlag()

		if var_560_0[var_560_1] ~= nil then
			arg_560_1.duration_ = var_560_0[var_560_1]
		end

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play122111135(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 0.625

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				arg_560_1.leftNameTxt_.text = arg_560_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_1 = arg_560_1:GetWordFromCfg(122111134)
				local var_563_2 = arg_560_1:FormatText(var_563_1.content)

				arg_560_1.text_.text = var_563_2

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_4 = 25 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_2) / 25)

				if (25 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_2) / 25)) > 0 and var_563_0 < var_563_4 then
					arg_560_1.talkMaxDuration = var_563_4

					if var_563_4 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_4 + 0
					end
				end

				arg_560_1.text_.text = var_563_2
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111134", "story_v_out_122111.awb") ~= 0 then
					local var_563_5 = manager.audio:GetVoiceLength("story_v_out_122111", "122111134", "story_v_out_122111.awb") / 1000

					if var_563_5 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_5 + 0
					end

					if var_563_1.prefab_name ~= "" and arg_560_1.actors_[var_563_1.prefab_name] ~= nil then
						local var_563_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_1.prefab_name].transform, "story_v_out_122111", "122111134", "story_v_out_122111.awb")

						arg_560_1:RecordAudio("122111134", var_563_6)
						arg_560_1:RecordAudio("122111134", var_563_6)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_out_122111", "122111134", "story_v_out_122111.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_out_122111", "122111134", "story_v_out_122111.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_7 = math.max(var_563_0, arg_560_1.talkMaxDuration)

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_7 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - 0) / var_563_7

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= 0 + var_563_7 and arg_560_1.time_ < 0 + var_563_7 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play122111135 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 122111135
		arg_564_1.duration_ = 12.93

		local var_564_0 = {
			ja = 12.933,
			ko = 9.233,
			zh = 9.233
		}
		local var_564_1 = manager.audio:GetLocalizationFlag()

		if var_564_0[var_564_1] ~= nil then
			arg_564_1.duration_ = var_564_0[var_564_1]
		end

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play122111136(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = 1.075

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				arg_564_1.leftNameTxt_.text = arg_564_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_1 = arg_564_1:GetWordFromCfg(122111135)
				local var_567_2 = arg_564_1:FormatText(var_567_1.content)

				arg_564_1.text_.text = var_567_2

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_4 = 43 <= 0 and var_567_0 or var_567_0 * (utf8.len(var_567_2) / 43)

				if (43 <= 0 and var_567_0 or var_567_0 * (utf8.len(var_567_2) / 43)) > 0 and var_567_0 < var_567_4 then
					arg_564_1.talkMaxDuration = var_567_4

					if var_567_4 + 0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_4 + 0
					end
				end

				arg_564_1.text_.text = var_567_2
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111135", "story_v_out_122111.awb") ~= 0 then
					local var_567_5 = manager.audio:GetVoiceLength("story_v_out_122111", "122111135", "story_v_out_122111.awb") / 1000

					if var_567_5 + 0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_5 + 0
					end

					if var_567_1.prefab_name ~= "" and arg_564_1.actors_[var_567_1.prefab_name] ~= nil then
						local var_567_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_564_1.actors_[var_567_1.prefab_name].transform, "story_v_out_122111", "122111135", "story_v_out_122111.awb")

						arg_564_1:RecordAudio("122111135", var_567_6)
						arg_564_1:RecordAudio("122111135", var_567_6)
					else
						arg_564_1:AudioAction("play", "voice", "story_v_out_122111", "122111135", "story_v_out_122111.awb")
					end

					arg_564_1:RecordHistoryTalkVoice("story_v_out_122111", "122111135", "story_v_out_122111.awb")
				end

				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_7 = math.max(var_567_0, arg_564_1.talkMaxDuration)

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_7 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - 0) / var_567_7

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= 0 + var_567_7 and arg_564_1.time_ < 0 + var_567_7 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play122111136 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 122111136
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play122111137(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = 0.4

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				arg_568_1.leftNameTxt_.text = arg_568_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, true)
				arg_568_1.iconController_:SetSelectedState("hero")

				arg_568_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_568_1.callingController_:SetSelectedState("normal")

				arg_568_1.keyicon_.color = Color.New(1, 1, 1)
				arg_568_1.icon_.color = Color.New(1, 1, 1)

				local var_571_1 = arg_568_1:FormatText(arg_568_1:GetWordFromCfg(122111136).content)

				arg_568_1.text_.text = var_571_1

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_3 = 16 <= 0 and var_571_0 or var_571_0 * (utf8.len(var_571_1) / 16)

				if (16 <= 0 and var_571_0 or var_571_0 * (utf8.len(var_571_1) / 16)) > 0 and var_571_0 < var_571_3 then
					arg_568_1.talkMaxDuration = var_571_3

					if var_571_3 + 0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_3 + 0
					end
				end

				arg_568_1.text_.text = var_571_1
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_4 = math.max(var_571_0, arg_568_1.talkMaxDuration)

			if 0 <= arg_568_1.time_ and arg_568_1.time_ < 0 + var_571_4 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - 0) / var_571_4

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= 0 + var_571_4 and arg_568_1.time_ < 0 + var_571_4 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play122111137 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 122111137
		arg_572_1.duration_ = 5

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play122111138(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = 1.3

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, false)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_1 = arg_572_1:FormatText(arg_572_1:GetWordFromCfg(122111137).content)

				arg_572_1.text_.text = var_575_1

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_3 = 52 <= 0 and var_575_0 or var_575_0 * (utf8.len(var_575_1) / 52)

				if (52 <= 0 and var_575_0 or var_575_0 * (utf8.len(var_575_1) / 52)) > 0 and var_575_0 < var_575_3 then
					arg_572_1.talkMaxDuration = var_575_3

					if var_575_3 + 0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_3 + 0
					end
				end

				arg_572_1.text_.text = var_575_1
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_4 = math.max(var_575_0, arg_572_1.talkMaxDuration)

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_4 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - 0) / var_575_4

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= 0 + var_575_4 and arg_572_1.time_ < 0 + var_575_4 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play122111138 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 122111138
		arg_576_1.duration_ = 5

		local var_576_0 = {
			ja = 3.866,
			ko = 5,
			zh = 5
		}
		local var_576_1 = manager.audio:GetLocalizationFlag()

		if var_576_0[var_576_1] ~= nil then
			arg_576_1.duration_ = var_576_0[var_576_1]
		end

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play122111139(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = 0.2

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				arg_576_1.leftNameTxt_.text = arg_576_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_1 = arg_576_1:GetWordFromCfg(122111138)
				local var_579_2 = arg_576_1:FormatText(var_579_1.content)

				arg_576_1.text_.text = var_579_2

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_4 = 8 <= 0 and var_579_0 or var_579_0 * (utf8.len(var_579_2) / 8)

				if (8 <= 0 and var_579_0 or var_579_0 * (utf8.len(var_579_2) / 8)) > 0 and var_579_0 < var_579_4 then
					arg_576_1.talkMaxDuration = var_579_4

					if var_579_4 + 0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_4 + 0
					end
				end

				arg_576_1.text_.text = var_579_2
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111138", "story_v_out_122111.awb") ~= 0 then
					local var_579_5 = manager.audio:GetVoiceLength("story_v_out_122111", "122111138", "story_v_out_122111.awb") / 1000

					if var_579_5 + 0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_5 + 0
					end

					if var_579_1.prefab_name ~= "" and arg_576_1.actors_[var_579_1.prefab_name] ~= nil then
						local var_579_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_576_1.actors_[var_579_1.prefab_name].transform, "story_v_out_122111", "122111138", "story_v_out_122111.awb")

						arg_576_1:RecordAudio("122111138", var_579_6)
						arg_576_1:RecordAudio("122111138", var_579_6)
					else
						arg_576_1:AudioAction("play", "voice", "story_v_out_122111", "122111138", "story_v_out_122111.awb")
					end

					arg_576_1:RecordHistoryTalkVoice("story_v_out_122111", "122111138", "story_v_out_122111.awb")
				end

				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_7 = math.max(var_579_0, arg_576_1.talkMaxDuration)

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_7 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - 0) / var_579_7

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= 0 + var_579_7 and arg_576_1.time_ < 0 + var_579_7 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play122111139 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 122111139
		arg_580_1.duration_ = 5

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play122111140(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 then
				arg_580_1:AudioAction("play", "music", "bgm_activity_2_2_story_promise_orgel", "bgm_activity_2_2_story_promise_orgel", "bgm_activity_2_2_story_promise_orgel.awb")

				local var_583_2 = manager.audio:GetAudioName("bgm_activity_2_2_story_promise_orgel", "bgm_activity_2_2_story_promise_orgel")

				if "" ~= "" then
					if arg_580_1.bgmTxt_.text ~= var_583_2 and arg_580_1.bgmTxt_.text ~= "" then
						if arg_580_1.bgmTxt2_.text ~= "" then
							arg_580_1.bgmTxt_.text = arg_580_1.bgmTxt2_.text
						end

						arg_580_1.bgmTxt2_.text = var_583_2

						arg_580_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_580_1.bgmTxt_.text = var_583_2
						arg_580_1.bgmTxt2_.text = var_583_2
					end

					if arg_580_1.bgmTimer then
						arg_580_1.bgmTimer:Stop()

						arg_580_1.bgmTimer = nil
					end

					if arg_580_1.settingData.show_music_name == 1 then
						arg_580_1.musicController:SetSelectedState("show")
						arg_580_1.musicAnimator_:Play("open", 0, 0)

						if arg_580_1.settingData.music_time ~= 0 then
							arg_580_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_580_1.settingData.music_time), function()
								if arg_580_1 == nil or isNil(arg_580_1.bgmTxt_) then
									return
								end

								arg_580_1.musicController:SetSelectedState("hide")
								arg_580_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_583_3 = 0
			local var_583_4 = 0.375

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_3 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, false)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_5 = arg_580_1:FormatText(arg_580_1:GetWordFromCfg(122111139).content)

				arg_580_1.text_.text = var_583_5

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_7 = 15 <= 0 and var_583_4 or var_583_4 * (utf8.len(var_583_5) / 15)

				if (15 <= 0 and var_583_4 or var_583_4 * (utf8.len(var_583_5) / 15)) > 0 and var_583_4 < var_583_7 then
					arg_580_1.talkMaxDuration = var_583_7

					if var_583_7 + var_583_3 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_7 + var_583_3
					end
				end

				arg_580_1.text_.text = var_583_5
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)
				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_8 = math.max(var_583_4, arg_580_1.talkMaxDuration)

			if var_583_3 <= arg_580_1.time_ and arg_580_1.time_ < var_583_3 + var_583_8 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_3) / var_583_8

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_3 + var_583_8 and arg_580_1.time_ < var_583_3 + var_583_8 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play122111140 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 122111140
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play122111141(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 1.15

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, false)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_1 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(122111140).content)

				arg_585_1.text_.text = var_588_1

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_3 = 46 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 46)

				if (46 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 46)) > 0 and var_588_0 < var_588_3 then
					arg_585_1.talkMaxDuration = var_588_3

					if var_588_3 + 0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_3 + 0
					end
				end

				arg_585_1.text_.text = var_588_1
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_4 = math.max(var_588_0, arg_585_1.talkMaxDuration)

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_4 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - 0) / var_588_4

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= 0 + var_588_4 and arg_585_1.time_ < 0 + var_588_4 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play122111141 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 122111141
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play122111142(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0.875

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, false)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_1 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(122111141).content)

				arg_589_1.text_.text = var_592_1

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_3 = 35 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 35)

				if (35 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 35)) > 0 and var_592_0 < var_592_3 then
					arg_589_1.talkMaxDuration = var_592_3

					if var_592_3 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_3 + 0
					end
				end

				arg_589_1.text_.text = var_592_1
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_4 = math.max(var_592_0, arg_589_1.talkMaxDuration)

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_4 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - 0) / var_592_4

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= 0 + var_592_4 and arg_589_1.time_ < 0 + var_592_4 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play122111142 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 122111142
		arg_593_1.duration_ = 5.2

		local var_593_0 = {
			ja = 5.033,
			ko = 5.2,
			zh = 5.2
		}
		local var_593_1 = manager.audio:GetLocalizationFlag()

		if var_593_0[var_593_1] ~= nil then
			arg_593_1.duration_ = var_593_0[var_593_1]
		end

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play122111143(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0.525

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_1 = arg_593_1:GetWordFromCfg(122111142)
				local var_596_2 = arg_593_1:FormatText(var_596_1.content)

				arg_593_1.text_.text = var_596_2

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_4 = 21 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_2) / 21)

				if (21 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_2) / 21)) > 0 and var_596_0 < var_596_4 then
					arg_593_1.talkMaxDuration = var_596_4

					if var_596_4 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_4 + 0
					end
				end

				arg_593_1.text_.text = var_596_2
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111142", "story_v_out_122111.awb") ~= 0 then
					local var_596_5 = manager.audio:GetVoiceLength("story_v_out_122111", "122111142", "story_v_out_122111.awb") / 1000

					if var_596_5 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_5 + 0
					end

					if var_596_1.prefab_name ~= "" and arg_593_1.actors_[var_596_1.prefab_name] ~= nil then
						local var_596_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_1.prefab_name].transform, "story_v_out_122111", "122111142", "story_v_out_122111.awb")

						arg_593_1:RecordAudio("122111142", var_596_6)
						arg_593_1:RecordAudio("122111142", var_596_6)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_out_122111", "122111142", "story_v_out_122111.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_out_122111", "122111142", "story_v_out_122111.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_7 = math.max(var_596_0, arg_593_1.talkMaxDuration)

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_7 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - 0) / var_596_7

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= 0 + var_596_7 and arg_593_1.time_ < 0 + var_596_7 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play122111143 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 122111143
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play122111144(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = 0.675

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, true)
				arg_597_1.iconController_:SetSelectedState("hero")

				arg_597_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_597_1.callingController_:SetSelectedState("normal")

				arg_597_1.keyicon_.color = Color.New(1, 1, 1)
				arg_597_1.icon_.color = Color.New(1, 1, 1)

				local var_600_1 = arg_597_1:FormatText(arg_597_1:GetWordFromCfg(122111143).content)

				arg_597_1.text_.text = var_600_1

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_3 = 27 <= 0 and var_600_0 or var_600_0 * (utf8.len(var_600_1) / 27)

				if (27 <= 0 and var_600_0 or var_600_0 * (utf8.len(var_600_1) / 27)) > 0 and var_600_0 < var_600_3 then
					arg_597_1.talkMaxDuration = var_600_3

					if var_600_3 + 0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_3 + 0
					end
				end

				arg_597_1.text_.text = var_600_1
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_4 = math.max(var_600_0, arg_597_1.talkMaxDuration)

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_4 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - 0) / var_600_4

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= 0 + var_600_4 and arg_597_1.time_ < 0 + var_600_4 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play122111144 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 122111144
		arg_601_1.duration_ = 4.2

		local var_601_0 = {
			ja = 3.633,
			ko = 4.2,
			zh = 4.2
		}
		local var_601_1 = manager.audio:GetLocalizationFlag()

		if var_601_0[var_601_1] ~= nil then
			arg_601_1.duration_ = var_601_0[var_601_1]
		end

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play122111145(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = 0.3

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				arg_601_1.leftNameTxt_.text = arg_601_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_1 = arg_601_1:GetWordFromCfg(122111144)
				local var_604_2 = arg_601_1:FormatText(var_604_1.content)

				arg_601_1.text_.text = var_604_2

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_4 = 12 <= 0 and var_604_0 or var_604_0 * (utf8.len(var_604_2) / 12)

				if (12 <= 0 and var_604_0 or var_604_0 * (utf8.len(var_604_2) / 12)) > 0 and var_604_0 < var_604_4 then
					arg_601_1.talkMaxDuration = var_604_4

					if var_604_4 + 0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_4 + 0
					end
				end

				arg_601_1.text_.text = var_604_2
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111144", "story_v_out_122111.awb") ~= 0 then
					local var_604_5 = manager.audio:GetVoiceLength("story_v_out_122111", "122111144", "story_v_out_122111.awb") / 1000

					if var_604_5 + 0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_5 + 0
					end

					if var_604_1.prefab_name ~= "" and arg_601_1.actors_[var_604_1.prefab_name] ~= nil then
						local var_604_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_601_1.actors_[var_604_1.prefab_name].transform, "story_v_out_122111", "122111144", "story_v_out_122111.awb")

						arg_601_1:RecordAudio("122111144", var_604_6)
						arg_601_1:RecordAudio("122111144", var_604_6)
					else
						arg_601_1:AudioAction("play", "voice", "story_v_out_122111", "122111144", "story_v_out_122111.awb")
					end

					arg_601_1:RecordHistoryTalkVoice("story_v_out_122111", "122111144", "story_v_out_122111.awb")
				end

				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_7 = math.max(var_604_0, arg_601_1.talkMaxDuration)

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_7 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - 0) / var_604_7

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= 0 + var_604_7 and arg_601_1.time_ < 0 + var_604_7 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play122111145 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 122111145
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play122111146(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0.275

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, true)
				arg_605_1.iconController_:SetSelectedState("hero")

				arg_605_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_605_1.callingController_:SetSelectedState("normal")

				arg_605_1.keyicon_.color = Color.New(1, 1, 1)
				arg_605_1.icon_.color = Color.New(1, 1, 1)

				local var_608_1 = arg_605_1:FormatText(arg_605_1:GetWordFromCfg(122111145).content)

				arg_605_1.text_.text = var_608_1

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_3 = 11 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_1) / 11)

				if (11 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_1) / 11)) > 0 and var_608_0 < var_608_3 then
					arg_605_1.talkMaxDuration = var_608_3

					if var_608_3 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_3 + 0
					end
				end

				arg_605_1.text_.text = var_608_1
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_4 = math.max(var_608_0, arg_605_1.talkMaxDuration)

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_4 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - 0) / var_608_4

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= 0 + var_608_4 and arg_605_1.time_ < 0 + var_608_4 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play122111146 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 122111146
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play122111147(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 0.5

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, false)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_1 = arg_609_1:FormatText(arg_609_1:GetWordFromCfg(122111146).content)

				arg_609_1.text_.text = var_612_1

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_3 = 20 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 20)

				if (20 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 20)) > 0 and var_612_0 < var_612_3 then
					arg_609_1.talkMaxDuration = var_612_3

					if var_612_3 + 0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_3 + 0
					end
				end

				arg_609_1.text_.text = var_612_1
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_4 = math.max(var_612_0, arg_609_1.talkMaxDuration)

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_4 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - 0) / var_612_4

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= 0 + var_612_4 and arg_609_1.time_ < 0 + var_612_4 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play122111147 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 122111147
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play122111148(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 1

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, false)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_1 = arg_613_1:FormatText(arg_613_1:GetWordFromCfg(122111147).content)

				arg_613_1.text_.text = var_616_1

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_3 = 40 <= 0 and var_616_0 or var_616_0 * (utf8.len(var_616_1) / 40)

				if (40 <= 0 and var_616_0 or var_616_0 * (utf8.len(var_616_1) / 40)) > 0 and var_616_0 < var_616_3 then
					arg_613_1.talkMaxDuration = var_616_3

					if var_616_3 + 0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_3 + 0
					end
				end

				arg_613_1.text_.text = var_616_1
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_4 = math.max(var_616_0, arg_613_1.talkMaxDuration)

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_4 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - 0) / var_616_4

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= 0 + var_616_4 and arg_613_1.time_ < 0 + var_616_4 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play122111148 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 122111148
		arg_617_1.duration_ = 11

		local var_617_0 = {
			ja = 11,
			ko = 6.033,
			zh = 6.033
		}
		local var_617_1 = manager.audio:GetLocalizationFlag()

		if var_617_0[var_617_1] ~= nil then
			arg_617_1.duration_ = var_617_0[var_617_1]
		end

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play122111149(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1.var_.moveOldPosXH0505 = arg_617_1.bgs_.XH0505.transform.localPosition
			end

			local var_620_0 = 4.5

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_0 then
				arg_617_1.bgs_.XH0505.transform.localPosition = Vector3.Lerp(arg_617_1.var_.moveOldPosXH0505, Vector3.New(0, 1, 9.5), (arg_617_1.time_ - 0) / var_620_0)
			end

			if arg_617_1.time_ >= 0 + var_620_0 and arg_617_1.time_ < 0 + var_620_0 + arg_620_0 then
				arg_617_1.bgs_.XH0505.transform.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_620_1 = 0

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_1 + arg_620_0 then
				arg_617_1.allBtn_.enabled = false
			end

			if arg_617_1.time_ >= var_620_1 + 4.5 and arg_617_1.time_ < var_620_1 + 4.5 + arg_620_0 then
				arg_617_1.allBtn_.enabled = true
			end

			local var_620_2 = 0
			local var_620_3 = 0.75

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_2 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_4 = arg_617_1:GetWordFromCfg(122111148)
				local var_620_5 = arg_617_1:FormatText(var_620_4.content)

				arg_617_1.text_.text = var_620_5

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_7 = 30 <= 0 and var_620_3 or var_620_3 * (utf8.len(var_620_5) / 30)

				if (30 <= 0 and var_620_3 or var_620_3 * (utf8.len(var_620_5) / 30)) > 0 and var_620_3 < var_620_7 then
					arg_617_1.talkMaxDuration = var_620_7

					if var_620_7 + var_620_2 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_7 + var_620_2
					end
				end

				arg_617_1.text_.text = var_620_5
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111148", "story_v_out_122111.awb") ~= 0 then
					local var_620_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111148", "story_v_out_122111.awb") / 1000

					if var_620_8 + var_620_2 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_8 + var_620_2
					end

					if var_620_4.prefab_name ~= "" and arg_617_1.actors_[var_620_4.prefab_name] ~= nil then
						local var_620_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_4.prefab_name].transform, "story_v_out_122111", "122111148", "story_v_out_122111.awb")

						arg_617_1:RecordAudio("122111148", var_620_9)
						arg_617_1:RecordAudio("122111148", var_620_9)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_out_122111", "122111148", "story_v_out_122111.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_out_122111", "122111148", "story_v_out_122111.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_10 = math.max(var_620_3, arg_617_1.talkMaxDuration)

			if var_620_2 <= arg_617_1.time_ and arg_617_1.time_ < var_620_2 + var_620_10 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_2) / var_620_10

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_2 + var_620_10 and arg_617_1.time_ < var_620_2 + var_620_10 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0505",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_617_1:InitPlayNodeList()
	end,
	Play122111149 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 122111149
		arg_621_1.duration_ = 8.63

		local var_621_0 = {
			ja = 8.633,
			ko = 6.233,
			zh = 6.233
		}
		local var_621_1 = manager.audio:GetLocalizationFlag()

		if var_621_0[var_621_1] ~= nil then
			arg_621_1.duration_ = var_621_0[var_621_1]
		end

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play122111150(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 0.75

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				arg_621_1.leftNameTxt_.text = arg_621_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_1 = arg_621_1:GetWordFromCfg(122111149)
				local var_624_2 = arg_621_1:FormatText(var_624_1.content)

				arg_621_1.text_.text = var_624_2

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_4 = 30 <= 0 and var_624_0 or var_624_0 * (utf8.len(var_624_2) / 30)

				if (30 <= 0 and var_624_0 or var_624_0 * (utf8.len(var_624_2) / 30)) > 0 and var_624_0 < var_624_4 then
					arg_621_1.talkMaxDuration = var_624_4

					if var_624_4 + 0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_4 + 0
					end
				end

				arg_621_1.text_.text = var_624_2
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111149", "story_v_out_122111.awb") ~= 0 then
					local var_624_5 = manager.audio:GetVoiceLength("story_v_out_122111", "122111149", "story_v_out_122111.awb") / 1000

					if var_624_5 + 0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_5 + 0
					end

					if var_624_1.prefab_name ~= "" and arg_621_1.actors_[var_624_1.prefab_name] ~= nil then
						local var_624_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_1.prefab_name].transform, "story_v_out_122111", "122111149", "story_v_out_122111.awb")

						arg_621_1:RecordAudio("122111149", var_624_6)
						arg_621_1:RecordAudio("122111149", var_624_6)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_out_122111", "122111149", "story_v_out_122111.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_out_122111", "122111149", "story_v_out_122111.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_7 = math.max(var_624_0, arg_621_1.talkMaxDuration)

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_7 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - 0) / var_624_7

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= 0 + var_624_7 and arg_621_1.time_ < 0 + var_624_7 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play122111150 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 122111150
		arg_625_1.duration_ = 4.87

		local var_625_0 = {
			ja = 4.866,
			ko = 3.833,
			zh = 3.833
		}
		local var_625_1 = manager.audio:GetLocalizationFlag()

		if var_625_0[var_625_1] ~= nil then
			arg_625_1.duration_ = var_625_0[var_625_1]
		end

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play122111151(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0.4

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				arg_625_1.leftNameTxt_.text = arg_625_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_1 = arg_625_1:GetWordFromCfg(122111150)
				local var_628_2 = arg_625_1:FormatText(var_628_1.content)

				arg_625_1.text_.text = var_628_2

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_4 = 16 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_2) / 16)

				if (16 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_2) / 16)) > 0 and var_628_0 < var_628_4 then
					arg_625_1.talkMaxDuration = var_628_4

					if var_628_4 + 0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_4 + 0
					end
				end

				arg_625_1.text_.text = var_628_2
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111150", "story_v_out_122111.awb") ~= 0 then
					local var_628_5 = manager.audio:GetVoiceLength("story_v_out_122111", "122111150", "story_v_out_122111.awb") / 1000

					if var_628_5 + 0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_5 + 0
					end

					if var_628_1.prefab_name ~= "" and arg_625_1.actors_[var_628_1.prefab_name] ~= nil then
						local var_628_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_625_1.actors_[var_628_1.prefab_name].transform, "story_v_out_122111", "122111150", "story_v_out_122111.awb")

						arg_625_1:RecordAudio("122111150", var_628_6)
						arg_625_1:RecordAudio("122111150", var_628_6)
					else
						arg_625_1:AudioAction("play", "voice", "story_v_out_122111", "122111150", "story_v_out_122111.awb")
					end

					arg_625_1:RecordHistoryTalkVoice("story_v_out_122111", "122111150", "story_v_out_122111.awb")
				end

				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_7 = math.max(var_628_0, arg_625_1.talkMaxDuration)

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_7 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - 0) / var_628_7

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= 0 + var_628_7 and arg_625_1.time_ < 0 + var_628_7 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play122111151 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 122111151
		arg_629_1.duration_ = 13.03

		local var_629_0 = {
			ja = 13.033,
			ko = 9.933,
			zh = 9.933
		}
		local var_629_1 = manager.audio:GetLocalizationFlag()

		if var_629_0[var_629_1] ~= nil then
			arg_629_1.duration_ = var_629_0[var_629_1]
		end

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play122111152(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			if arg_629_1.bgs_.ST03a == nil then
				local var_632_0 = Object.Instantiate(arg_629_1.paintGo_)

				var_632_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03a")
				var_632_0.name = "ST03a"
				var_632_0.transform.parent = arg_629_1.stage_.transform
				var_632_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_629_1.bgs_.ST03a = var_632_0
			end

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= 2 + arg_632_0 then
				local var_632_1 = arg_629_1.bgs_.ST03a

				arg_629_1.bgs_.ST03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_632_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_632_2 = var_632_1:GetComponent("SpriteRenderer")

				if var_632_2 and var_632_2.sprite then
					local var_632_3 = 2 * (var_632_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_632_1.transform.localScale = Vector3.New(var_632_3 / var_632_2.sprite.bounds.size.y < var_632_3 * manager.ui.mainCameraCom_.aspect / var_632_2.sprite.bounds.size.x and var_632_3 * manager.ui.mainCameraCom_.aspect / var_632_2.sprite.bounds.size.x or var_632_3 / var_632_2.sprite.bounds.size.y, var_632_3 / var_632_2.sprite.bounds.size.y < var_632_3 * manager.ui.mainCameraCom_.aspect / var_632_2.sprite.bounds.size.x and var_632_3 * manager.ui.mainCameraCom_.aspect / var_632_2.sprite.bounds.size.x or var_632_3 / var_632_2.sprite.bounds.size.y, 0)
				end

				for iter_632_0, iter_632_1 in pairs(arg_629_1.bgs_) do
					if iter_632_0 ~= "ST03a" then
						iter_632_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_632_4 = 0

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_4 + arg_632_0 then
				arg_629_1.mask_.enabled = true
				arg_629_1.mask_.raycastTarget = true

				arg_629_1:SetGaussion(false)
			end

			local var_632_5 = 2

			if var_632_4 <= arg_629_1.time_ and arg_629_1.time_ < var_632_4 + var_632_5 then
				local var_632_6 = Color.New(0, 0, 0)

				var_632_6.a = Mathf.Lerp(0, 1, (arg_629_1.time_ - var_632_4) / var_632_5)
				arg_629_1.mask_.color = var_632_6
			end

			if arg_629_1.time_ >= var_632_4 + var_632_5 and arg_629_1.time_ < var_632_4 + var_632_5 + arg_632_0 then
				local var_632_7 = Color.New(0, 0, 0)

				var_632_7.a = 1
				arg_629_1.mask_.color = var_632_7
			end

			local var_632_8 = 2

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= var_632_8 + arg_632_0 then
				arg_629_1.mask_.enabled = true
				arg_629_1.mask_.raycastTarget = true

				arg_629_1:SetGaussion(false)
			end

			local var_632_9 = 2

			if var_632_8 <= arg_629_1.time_ and arg_629_1.time_ < var_632_8 + var_632_9 then
				local var_632_10 = Color.New(0, 0, 0)

				var_632_10.a = Mathf.Lerp(1, 0, (arg_629_1.time_ - var_632_8) / var_632_9)
				arg_629_1.mask_.color = var_632_10
			end

			if arg_629_1.time_ >= var_632_8 + var_632_9 and arg_629_1.time_ < var_632_8 + var_632_9 + arg_632_0 then
				local var_632_11 = Color.New(0, 0, 0)

				arg_629_1.mask_.enabled = false
				var_632_11.a = 0
				arg_629_1.mask_.color = var_632_11
			end

			local var_632_12 = arg_629_1.actors_["1084ui_story"].transform

			if 4 < arg_629_1.time_ and arg_629_1.time_ <= 4 + arg_632_0 then
				arg_629_1.var_.moveOldPos1084ui_story = var_632_12.localPosition
			end

			local var_632_13 = 0.001

			if 4 <= arg_629_1.time_ and arg_629_1.time_ < 4 + var_632_13 then
				var_632_12.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_629_1.time_ - 4) / var_632_13)
				var_632_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_632_12.position).x, (manager.ui.mainCamera.transform.position - var_632_12.position).y, (manager.ui.mainCamera.transform.position - var_632_12.position).z)
				var_632_12.localEulerAngles.z = 0
				var_632_12.localEulerAngles.x = 0
				var_632_12.localEulerAngles = var_632_12.localEulerAngles
			end

			if arg_629_1.time_ >= 4 + var_632_13 and arg_629_1.time_ < 4 + var_632_13 + arg_632_0 then
				var_632_12.localPosition = Vector3.New(0, -0.97, -6)
				var_632_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_632_12.position).x, (manager.ui.mainCamera.transform.position - var_632_12.position).y, (manager.ui.mainCamera.transform.position - var_632_12.position).z)
				var_632_12.localEulerAngles.z = 0
				var_632_12.localEulerAngles.x = 0
				var_632_12.localEulerAngles = var_632_12.localEulerAngles
			end

			local var_632_14 = arg_629_1.actors_["1084ui_story"]

			if 4 < arg_629_1.time_ and arg_629_1.time_ <= 4 + arg_632_0 and not isNil(var_632_14) and arg_629_1.var_.characterEffect1084ui_story == nil then
				arg_629_1.var_.characterEffect1084ui_story = var_632_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_632_15 = 0.200000002980232

			if 4 <= arg_629_1.time_ and arg_629_1.time_ < 4 + var_632_15 and not isNil(var_632_14) then
				if arg_629_1.var_.characterEffect1084ui_story and not isNil(var_632_14) then
					arg_629_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_629_1.time_ >= 4 + var_632_15 and arg_629_1.time_ < 4 + var_632_15 + arg_632_0 and not isNil(var_632_14) and arg_629_1.var_.characterEffect1084ui_story then
				arg_629_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 4 < arg_629_1.time_ and arg_629_1.time_ <= 4 + arg_632_0 then
				arg_629_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 4 < arg_629_1.time_ and arg_629_1.time_ <= 4 + arg_632_0 then
				arg_629_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			if arg_629_1.frameCnt_ <= 1 then
				arg_629_1.dialog_:SetActive(false)
			end

			local var_632_17 = 4
			local var_632_18 = 0.7

			if 4 < arg_629_1.time_ and arg_629_1.time_ <= var_632_17 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0

				arg_629_1.dialog_:SetActive(true)

				arg_629_1.dialogCg_.alpha = 0

				local var_632_19 = LeanTween.value(arg_629_1.dialog_, 0, 1, 0.3)

				var_632_19:setOnUpdate(LuaHelper.FloatAction(function(arg_633_0)
					arg_629_1.dialogCg_.alpha = arg_633_0
				end))
				var_632_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_629_1.dialog_)
					var_632_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_629_1.duration_ = arg_629_1.duration_ + 0.3

				SetActive(arg_629_1.leftNameGo_, true)

				arg_629_1.leftNameTxt_.text = arg_629_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_20 = arg_629_1:GetWordFromCfg(122111151)
				local var_632_21 = arg_629_1:FormatText(var_632_20.content)

				arg_629_1.text_.text = var_632_21

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_23 = 28 <= 0 and var_632_18 or var_632_18 * (utf8.len(var_632_21) / 28)

				if (28 <= 0 and var_632_18 or var_632_18 * (utf8.len(var_632_21) / 28)) > 0 and var_632_18 < var_632_23 then
					arg_629_1.talkMaxDuration = var_632_23
					var_632_17 = var_632_17 + 0.3

					if var_632_23 + var_632_17 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_23 + var_632_17
					end
				end

				arg_629_1.text_.text = var_632_21
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111151", "story_v_out_122111.awb") ~= 0 then
					local var_632_24 = manager.audio:GetVoiceLength("story_v_out_122111", "122111151", "story_v_out_122111.awb") / 1000

					if var_632_24 + var_632_17 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_24 + var_632_17
					end

					if var_632_20.prefab_name ~= "" and arg_629_1.actors_[var_632_20.prefab_name] ~= nil then
						local var_632_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_629_1.actors_[var_632_20.prefab_name].transform, "story_v_out_122111", "122111151", "story_v_out_122111.awb")

						arg_629_1:RecordAudio("122111151", var_632_25)
						arg_629_1:RecordAudio("122111151", var_632_25)
					else
						arg_629_1:AudioAction("play", "voice", "story_v_out_122111", "122111151", "story_v_out_122111.awb")
					end

					arg_629_1:RecordHistoryTalkVoice("story_v_out_122111", "122111151", "story_v_out_122111.awb")
				end

				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_26 = var_632_17 + 0.3
			local var_632_27 = math.max(var_632_18, arg_629_1.talkMaxDuration)

			if var_632_17 + 0.3 <= arg_629_1.time_ and arg_629_1.time_ < var_632_26 + var_632_27 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_26) / var_632_27

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_26 + var_632_27 and arg_629_1.time_ < var_632_26 + var_632_27 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_629_1:InitPlayNodeList()
	end,
	Play122111152 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 122111152
		arg_635_1.duration_ = 3.53

		local var_635_0 = {
			ja = 3.533,
			ko = 2.166,
			zh = 2.166
		}
		local var_635_1 = manager.audio:GetLocalizationFlag()

		if var_635_0[var_635_1] ~= nil then
			arg_635_1.duration_ = var_635_0[var_635_1]
		end

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play122111153(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_638_0 = 0
			local var_638_1 = 0.25

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_0 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				arg_635_1.leftNameTxt_.text = arg_635_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_2 = arg_635_1:GetWordFromCfg(122111152)
				local var_638_3 = arg_635_1:FormatText(var_638_2.content)

				arg_635_1.text_.text = var_638_3

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_5 = 10 <= 0 and var_638_1 or var_638_1 * (utf8.len(var_638_3) / 10)

				if (10 <= 0 and var_638_1 or var_638_1 * (utf8.len(var_638_3) / 10)) > 0 and var_638_1 < var_638_5 then
					arg_635_1.talkMaxDuration = var_638_5

					if var_638_5 + var_638_0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_5 + var_638_0
					end
				end

				arg_635_1.text_.text = var_638_3
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111152", "story_v_out_122111.awb") ~= 0 then
					local var_638_6 = manager.audio:GetVoiceLength("story_v_out_122111", "122111152", "story_v_out_122111.awb") / 1000

					if var_638_6 + var_638_0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_6 + var_638_0
					end

					if var_638_2.prefab_name ~= "" and arg_635_1.actors_[var_638_2.prefab_name] ~= nil then
						local var_638_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_2.prefab_name].transform, "story_v_out_122111", "122111152", "story_v_out_122111.awb")

						arg_635_1:RecordAudio("122111152", var_638_7)
						arg_635_1:RecordAudio("122111152", var_638_7)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_out_122111", "122111152", "story_v_out_122111.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_out_122111", "122111152", "story_v_out_122111.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_8 = math.max(var_638_1, arg_635_1.talkMaxDuration)

			if var_638_0 <= arg_635_1.time_ and arg_635_1.time_ < var_638_0 + var_638_8 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_0) / var_638_8

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_0 + var_638_8 and arg_635_1.time_ < var_638_0 + var_638_8 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play122111153 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 122111153
		arg_639_1.duration_ = 1

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"

			SetActive(arg_639_1.choicesGo_, true)

			for iter_640_0, iter_640_1 in ipairs(arg_639_1.choices_) do
				SetActive(iter_640_1.go, iter_640_0 <= 1)
			end

			arg_639_1.choices_[1].txt.text = arg_639_1:FormatText(StoryChoiceCfg[441].name)
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play122111154(arg_639_1)
			end

			arg_639_1:RecordChoiceLog(122111153, 441)
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 and not isNil(arg_639_1.actors_["1084ui_story"]) and arg_639_1.var_.characterEffect1084ui_story == nil then
				arg_639_1.var_.characterEffect1084ui_story = arg_639_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_0 = 0.200000002980232

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_0 and not isNil(arg_639_1.actors_["1084ui_story"]) then
				if arg_639_1.var_.characterEffect1084ui_story and not isNil(arg_639_1.actors_["1084ui_story"]) then
					arg_639_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_639_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_639_1.time_ - 0) / var_642_0)
				end
			end

			if arg_639_1.time_ >= 0 + var_642_0 and arg_639_1.time_ < 0 + var_642_0 + arg_642_0 and not isNil(arg_639_1.actors_["1084ui_story"]) and arg_639_1.var_.characterEffect1084ui_story then
				arg_639_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_639_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play122111154 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 122111154
		arg_643_1.duration_ = 5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play122111155(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = 0.525

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, true)
				arg_643_1.iconController_:SetSelectedState("hero")

				arg_643_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_643_1.callingController_:SetSelectedState("normal")

				arg_643_1.keyicon_.color = Color.New(1, 1, 1)
				arg_643_1.icon_.color = Color.New(1, 1, 1)

				local var_646_1 = arg_643_1:FormatText(arg_643_1:GetWordFromCfg(122111154).content)

				arg_643_1.text_.text = var_646_1

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_3 = 21 <= 0 and var_646_0 or var_646_0 * (utf8.len(var_646_1) / 21)

				if (21 <= 0 and var_646_0 or var_646_0 * (utf8.len(var_646_1) / 21)) > 0 and var_646_0 < var_646_3 then
					arg_643_1.talkMaxDuration = var_646_3

					if var_646_3 + 0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_3 + 0
					end
				end

				arg_643_1.text_.text = var_646_1
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_4 = math.max(var_646_0, arg_643_1.talkMaxDuration)

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_4 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - 0) / var_646_4

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= 0 + var_646_4 and arg_643_1.time_ < 0 + var_646_4 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play122111155 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 122111155
		arg_647_1.duration_ = 7.77

		local var_647_0 = {
			ja = 7.766,
			ko = 5.266,
			zh = 5.266
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
				arg_647_0:Play122111156(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1.var_.moveOldPos1084ui_story = arg_647_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_650_0 = 0.001

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_0 then
				arg_647_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_647_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_647_1.time_ - 0) / var_650_0)
				arg_647_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_647_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_647_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_647_1.actors_["1084ui_story"].transform.position).z)
				arg_647_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_647_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_647_1.actors_["1084ui_story"].transform.localEulerAngles = arg_647_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_647_1.time_ >= 0 + var_650_0 and arg_647_1.time_ < 0 + var_650_0 + arg_650_0 then
				arg_647_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_647_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_647_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_647_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_647_1.actors_["1084ui_story"].transform.position).z)
				arg_647_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_647_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_647_1.actors_["1084ui_story"].transform.localEulerAngles = arg_647_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_650_1 = arg_647_1.actors_["1084ui_story"]

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 and not isNil(var_650_1) and arg_647_1.var_.characterEffect1084ui_story == nil then
				arg_647_1.var_.characterEffect1084ui_story = var_650_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_650_2 = 0.200000002980232

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_2 and not isNil(var_650_1) then
				if arg_647_1.var_.characterEffect1084ui_story and not isNil(var_650_1) then
					arg_647_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_647_1.time_ >= 0 + var_650_2 and arg_647_1.time_ < 0 + var_650_2 + arg_650_0 and not isNil(var_650_1) and arg_647_1.var_.characterEffect1084ui_story then
				arg_647_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_650_4 = 0
			local var_650_5 = 0.675

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_4 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				arg_647_1.leftNameTxt_.text = arg_647_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_6 = arg_647_1:GetWordFromCfg(122111155)
				local var_650_7 = arg_647_1:FormatText(var_650_6.content)

				arg_647_1.text_.text = var_650_7

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_9 = 27 <= 0 and var_650_5 or var_650_5 * (utf8.len(var_650_7) / 27)

				if (27 <= 0 and var_650_5 or var_650_5 * (utf8.len(var_650_7) / 27)) > 0 and var_650_5 < var_650_9 then
					arg_647_1.talkMaxDuration = var_650_9

					if var_650_9 + var_650_4 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_9 + var_650_4
					end
				end

				arg_647_1.text_.text = var_650_7
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111155", "story_v_out_122111.awb") ~= 0 then
					local var_650_10 = manager.audio:GetVoiceLength("story_v_out_122111", "122111155", "story_v_out_122111.awb") / 1000

					if var_650_10 + var_650_4 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_10 + var_650_4
					end

					if var_650_6.prefab_name ~= "" and arg_647_1.actors_[var_650_6.prefab_name] ~= nil then
						local var_650_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_6.prefab_name].transform, "story_v_out_122111", "122111155", "story_v_out_122111.awb")

						arg_647_1:RecordAudio("122111155", var_650_11)
						arg_647_1:RecordAudio("122111155", var_650_11)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_out_122111", "122111155", "story_v_out_122111.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_out_122111", "122111155", "story_v_out_122111.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_12 = math.max(var_650_5, arg_647_1.talkMaxDuration)

			if var_650_4 <= arg_647_1.time_ and arg_647_1.time_ < var_650_4 + var_650_12 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_4) / var_650_12

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_4 + var_650_12 and arg_647_1.time_ < var_650_4 + var_650_12 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_647_1:InitPlayNodeList()
	end,
	Play122111156 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 122111156
		arg_651_1.duration_ = 5

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play122111157(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 and not isNil(arg_651_1.actors_["1084ui_story"]) and arg_651_1.var_.characterEffect1084ui_story == nil then
				arg_651_1.var_.characterEffect1084ui_story = arg_651_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_654_0 = 0.200000002980232

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_0 and not isNil(arg_651_1.actors_["1084ui_story"]) then
				if arg_651_1.var_.characterEffect1084ui_story and not isNil(arg_651_1.actors_["1084ui_story"]) then
					arg_651_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_651_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_651_1.time_ - 0) / var_654_0)
				end
			end

			if arg_651_1.time_ >= 0 + var_654_0 and arg_651_1.time_ < 0 + var_654_0 + arg_654_0 and not isNil(arg_651_1.actors_["1084ui_story"]) and arg_651_1.var_.characterEffect1084ui_story then
				arg_651_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_651_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_654_1 = 0
			local var_654_2 = 0.4

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= var_654_1 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				arg_651_1.leftNameTxt_.text = arg_651_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, true)
				arg_651_1.iconController_:SetSelectedState("hero")

				arg_651_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_651_1.callingController_:SetSelectedState("normal")

				arg_651_1.keyicon_.color = Color.New(1, 1, 1)
				arg_651_1.icon_.color = Color.New(1, 1, 1)

				local var_654_3 = arg_651_1:FormatText(arg_651_1:GetWordFromCfg(122111156).content)

				arg_651_1.text_.text = var_654_3

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_5 = 16 <= 0 and var_654_2 or var_654_2 * (utf8.len(var_654_3) / 16)

				if (16 <= 0 and var_654_2 or var_654_2 * (utf8.len(var_654_3) / 16)) > 0 and var_654_2 < var_654_5 then
					arg_651_1.talkMaxDuration = var_654_5

					if var_654_5 + var_654_1 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_5 + var_654_1
					end
				end

				arg_651_1.text_.text = var_654_3
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)
				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_6 = math.max(var_654_2, arg_651_1.talkMaxDuration)

			if var_654_1 <= arg_651_1.time_ and arg_651_1.time_ < var_654_1 + var_654_6 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_1) / var_654_6

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_1 + var_654_6 and arg_651_1.time_ < var_654_1 + var_654_6 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play122111157 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 122111157
		arg_655_1.duration_ = 5.9

		local var_655_0 = {
			ja = 5.9,
			ko = 4.633,
			zh = 4.633
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
				arg_655_0:Play122111158(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 and not isNil(arg_655_1.actors_["1084ui_story"]) and arg_655_1.var_.characterEffect1084ui_story == nil then
				arg_655_1.var_.characterEffect1084ui_story = arg_655_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_658_0 = 0.200000002980232

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_0 and not isNil(arg_655_1.actors_["1084ui_story"]) then
				if arg_655_1.var_.characterEffect1084ui_story and not isNil(arg_655_1.actors_["1084ui_story"]) then
					arg_655_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_655_1.time_ >= 0 + var_658_0 and arg_655_1.time_ < 0 + var_658_0 + arg_658_0 and not isNil(arg_655_1.actors_["1084ui_story"]) and arg_655_1.var_.characterEffect1084ui_story then
				arg_655_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 then
				arg_655_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action437")
			end

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 then
				arg_655_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_658_2 = 0
			local var_658_3 = 0.475

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_2 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				arg_655_1.leftNameTxt_.text = arg_655_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, false)
				arg_655_1.callingController_:SetSelectedState("normal")

				local var_658_4 = arg_655_1:GetWordFromCfg(122111157)
				local var_658_5 = arg_655_1:FormatText(var_658_4.content)

				arg_655_1.text_.text = var_658_5

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_7 = 19 <= 0 and var_658_3 or var_658_3 * (utf8.len(var_658_5) / 19)

				if (19 <= 0 and var_658_3 or var_658_3 * (utf8.len(var_658_5) / 19)) > 0 and var_658_3 < var_658_7 then
					arg_655_1.talkMaxDuration = var_658_7

					if var_658_7 + var_658_2 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_7 + var_658_2
					end
				end

				arg_655_1.text_.text = var_658_5
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111157", "story_v_out_122111.awb") ~= 0 then
					local var_658_8 = manager.audio:GetVoiceLength("story_v_out_122111", "122111157", "story_v_out_122111.awb") / 1000

					if var_658_8 + var_658_2 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_8 + var_658_2
					end

					if var_658_4.prefab_name ~= "" and arg_655_1.actors_[var_658_4.prefab_name] ~= nil then
						local var_658_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_655_1.actors_[var_658_4.prefab_name].transform, "story_v_out_122111", "122111157", "story_v_out_122111.awb")

						arg_655_1:RecordAudio("122111157", var_658_9)
						arg_655_1:RecordAudio("122111157", var_658_9)
					else
						arg_655_1:AudioAction("play", "voice", "story_v_out_122111", "122111157", "story_v_out_122111.awb")
					end

					arg_655_1:RecordHistoryTalkVoice("story_v_out_122111", "122111157", "story_v_out_122111.awb")
				end

				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_10 = math.max(var_658_3, arg_655_1.talkMaxDuration)

			if var_658_2 <= arg_655_1.time_ and arg_655_1.time_ < var_658_2 + var_658_10 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_2) / var_658_10

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_2 + var_658_10 and arg_655_1.time_ < var_658_2 + var_658_10 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play122111158 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 122111158
		arg_659_1.duration_ = 6.9

		local var_659_0 = {
			ja = 6.9,
			ko = 3.8,
			zh = 3.8
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
				arg_659_0:Play122111159(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 then
				arg_659_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action475")
			end

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 then
				arg_659_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_662_0 = 0
			local var_662_1 = 0.575

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= var_662_0 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				arg_659_1.leftNameTxt_.text = arg_659_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_2 = arg_659_1:GetWordFromCfg(122111158)
				local var_662_3 = arg_659_1:FormatText(var_662_2.content)

				arg_659_1.text_.text = var_662_3

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_5 = 23 <= 0 and var_662_1 or var_662_1 * (utf8.len(var_662_3) / 23)

				if (23 <= 0 and var_662_1 or var_662_1 * (utf8.len(var_662_3) / 23)) > 0 and var_662_1 < var_662_5 then
					arg_659_1.talkMaxDuration = var_662_5

					if var_662_5 + var_662_0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_5 + var_662_0
					end
				end

				arg_659_1.text_.text = var_662_3
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122111", "122111158", "story_v_out_122111.awb") ~= 0 then
					local var_662_6 = manager.audio:GetVoiceLength("story_v_out_122111", "122111158", "story_v_out_122111.awb") / 1000

					if var_662_6 + var_662_0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_6 + var_662_0
					end

					if var_662_2.prefab_name ~= "" and arg_659_1.actors_[var_662_2.prefab_name] ~= nil then
						local var_662_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_659_1.actors_[var_662_2.prefab_name].transform, "story_v_out_122111", "122111158", "story_v_out_122111.awb")

						arg_659_1:RecordAudio("122111158", var_662_7)
						arg_659_1:RecordAudio("122111158", var_662_7)
					else
						arg_659_1:AudioAction("play", "voice", "story_v_out_122111", "122111158", "story_v_out_122111.awb")
					end

					arg_659_1:RecordHistoryTalkVoice("story_v_out_122111", "122111158", "story_v_out_122111.awb")
				end

				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_8 = math.max(var_662_1, arg_659_1.talkMaxDuration)

			if var_662_0 <= arg_659_1.time_ and arg_659_1.time_ < var_662_0 + var_662_8 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_0) / var_662_8

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_0 + var_662_8 and arg_659_1.time_ < var_662_0 + var_662_8 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play122111159 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 122111159
		arg_663_1.duration_ = 5

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play122111160(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 and not isNil(arg_663_1.actors_["1084ui_story"]) and arg_663_1.var_.characterEffect1084ui_story == nil then
				arg_663_1.var_.characterEffect1084ui_story = arg_663_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_0 = 0.200000002980232

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_0 and not isNil(arg_663_1.actors_["1084ui_story"]) then
				if arg_663_1.var_.characterEffect1084ui_story and not isNil(arg_663_1.actors_["1084ui_story"]) then
					arg_663_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_663_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_663_1.time_ - 0) / var_666_0)
				end
			end

			if arg_663_1.time_ >= 0 + var_666_0 and arg_663_1.time_ < 0 + var_666_0 + arg_666_0 and not isNil(arg_663_1.actors_["1084ui_story"]) and arg_663_1.var_.characterEffect1084ui_story then
				arg_663_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_663_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_666_1 = 0
			local var_666_2 = 1.2

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_1 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, false)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_3 = arg_663_1:FormatText(arg_663_1:GetWordFromCfg(122111159).content)

				arg_663_1.text_.text = var_666_3

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_5 = 48 <= 0 and var_666_2 or var_666_2 * (utf8.len(var_666_3) / 48)

				if (48 <= 0 and var_666_2 or var_666_2 * (utf8.len(var_666_3) / 48)) > 0 and var_666_2 < var_666_5 then
					arg_663_1.talkMaxDuration = var_666_5

					if var_666_5 + var_666_1 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_5 + var_666_1
					end
				end

				arg_663_1.text_.text = var_666_3
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_6 = math.max(var_666_2, arg_663_1.talkMaxDuration)

			if var_666_1 <= arg_663_1.time_ and arg_663_1.time_ < var_666_1 + var_666_6 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_1) / var_666_6

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_1 + var_666_6 and arg_663_1.time_ < var_666_1 + var_666_6 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play122111160 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 122111160
		arg_667_1.duration_ = 5

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play122111161(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 then
				arg_667_1.var_.moveOldPos1084ui_story = arg_667_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_670_0 = 0.001

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_0 then
				arg_667_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_667_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_667_1.time_ - 0) / var_670_0)
				arg_667_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_667_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_667_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_667_1.actors_["1084ui_story"].transform.position).z)
				arg_667_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_667_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_667_1.actors_["1084ui_story"].transform.localEulerAngles = arg_667_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_667_1.time_ >= 0 + var_670_0 and arg_667_1.time_ < 0 + var_670_0 + arg_670_0 then
				arg_667_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_667_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_667_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_667_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_667_1.actors_["1084ui_story"].transform.position).z)
				arg_667_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_667_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_667_1.actors_["1084ui_story"].transform.localEulerAngles = arg_667_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_670_1 = arg_667_1.actors_["1084ui_story"]

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 and not isNil(var_670_1) and arg_667_1.var_.characterEffect1084ui_story == nil then
				arg_667_1.var_.characterEffect1084ui_story = var_670_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_670_2 = 0.200000002980232

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_2 and not isNil(var_670_1) then
				if arg_667_1.var_.characterEffect1084ui_story and not isNil(var_670_1) then
					arg_667_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_667_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_667_1.time_ - 0) / var_670_2)
				end
			end

			if arg_667_1.time_ >= 0 + var_670_2 and arg_667_1.time_ < 0 + var_670_2 + arg_670_0 and not isNil(var_670_1) and arg_667_1.var_.characterEffect1084ui_story then
				arg_667_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_667_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_670_3 = 0
			local var_670_4 = 0.875

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= var_670_3 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, false)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_5 = arg_667_1:FormatText(arg_667_1:GetWordFromCfg(122111160).content)

				arg_667_1.text_.text = var_670_5

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_7 = 35 <= 0 and var_670_4 or var_670_4 * (utf8.len(var_670_5) / 35)

				if (35 <= 0 and var_670_4 or var_670_4 * (utf8.len(var_670_5) / 35)) > 0 and var_670_4 < var_670_7 then
					arg_667_1.talkMaxDuration = var_670_7

					if var_670_7 + var_670_3 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_7 + var_670_3
					end
				end

				arg_667_1.text_.text = var_670_5
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)
				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_8 = math.max(var_670_4, arg_667_1.talkMaxDuration)

			if var_670_3 <= arg_667_1.time_ and arg_667_1.time_ < var_670_3 + var_670_8 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_3) / var_670_8

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_3 + var_670_8 and arg_667_1.time_ < var_670_3 + var_670_8 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_667_1:InitPlayNodeList()
	end,
	Play122111161 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 122111161
		arg_671_1.duration_ = 1

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"

			SetActive(arg_671_1.choicesGo_, true)

			for iter_672_0, iter_672_1 in ipairs(arg_671_1.choices_) do
				SetActive(iter_672_1.go, iter_672_0 <= 1)
			end

			arg_671_1.choices_[1].txt.text = arg_671_1:FormatText(StoryChoiceCfg[442].name)
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play122111162(arg_671_1)
			end

			arg_671_1:RecordChoiceLog(122111161, 442)
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			return
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play122111162 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 122111162
		arg_675_1.duration_ = 0.5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"

			SetActive(arg_675_1.choicesGo_, true)

			for iter_676_0, iter_676_1 in ipairs(arg_675_1.choices_) do
				SetActive(iter_676_1.go, iter_676_0 <= 2)
			end

			arg_675_1.choices_[1].txt.text = arg_675_1:FormatText(StoryChoiceCfg[443].name)
			arg_675_1.choices_[2].txt.text = arg_675_1:FormatText(StoryChoiceCfg[444].name)
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play122111163(arg_675_1)
			end

			if arg_677_0 == 2 then
				arg_675_0:Play122111163(arg_675_1)
			end

			arg_675_1:RecordChoiceLog(122111162, 443, 444)
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.allBtn_.enabled = false
			end

			if arg_675_1.time_ >= 0 + 0.5 and arg_675_1.time_ < 0 + 0.5 + arg_678_0 then
				arg_675_1.allBtn_.enabled = true
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play122111163 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 122111163
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play122111164(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = 1.625

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, false)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_1 = arg_679_1:FormatText(arg_679_1:GetWordFromCfg(122111163).content)

				arg_679_1.text_.text = var_682_1

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_3 = 65 <= 0 and var_682_0 or var_682_0 * (utf8.len(var_682_1) / 65)

				if (65 <= 0 and var_682_0 or var_682_0 * (utf8.len(var_682_1) / 65)) > 0 and var_682_0 < var_682_3 then
					arg_679_1.talkMaxDuration = var_682_3

					if var_682_3 + 0 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_3 + 0
					end
				end

				arg_679_1.text_.text = var_682_1
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_4 = math.max(var_682_0, arg_679_1.talkMaxDuration)

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_4 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - 0) / var_682_4

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= 0 + var_682_4 and arg_679_1.time_ < 0 + var_682_4 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play122111164 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 122111164
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
			arg_683_1.auto_ = false
		end

		function arg_683_1.playNext_(arg_685_0)
			arg_683_1.onStoryFinished_()
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = 0.375

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				arg_683_1.leftNameTxt_.text = arg_683_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, true)
				arg_683_1.iconController_:SetSelectedState("hero")

				arg_683_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_683_1.callingController_:SetSelectedState("normal")

				arg_683_1.keyicon_.color = Color.New(1, 1, 1)
				arg_683_1.icon_.color = Color.New(1, 1, 1)

				local var_686_1 = arg_683_1:FormatText(arg_683_1:GetWordFromCfg(122111164).content)

				arg_683_1.text_.text = var_686_1

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_3 = 15 <= 0 and var_686_0 or var_686_0 * (utf8.len(var_686_1) / 15)

				if (15 <= 0 and var_686_0 or var_686_0 * (utf8.len(var_686_1) / 15)) > 0 and var_686_0 < var_686_3 then
					arg_683_1.talkMaxDuration = var_686_3

					if var_686_3 + 0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_3 + 0
					end
				end

				arg_683_1.text_.text = var_686_1
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_4 = math.max(var_686_0, arg_683_1.talkMaxDuration)

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_4 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - 0) / var_686_4

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= 0 + var_686_4 and arg_683_1.time_ < 0 + var_686_4 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST07b",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/S0012",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/ST15",
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/XH0505",
		"TextureConfig/Background/ST03a"
	},
	voices = {
		"story_v_out_122111.awb"
	}
}
