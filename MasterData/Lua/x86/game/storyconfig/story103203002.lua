return {
	Play320302001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320302001
		arg_1_1.duration_ = 3.23

		local var_1_0 = {
			zh = 2.59966666666667,
			ja = 3.23266666666667
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
				arg_1_0:Play320302002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 1.36666666666667

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_12 = 1.36666666666667
			local var_4_13 = 0.125

			if 1.36666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_14 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_14:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_15 = arg_1_1:GetWordFromCfg(320302001)
				local var_4_16 = arg_1_1:FormatText(var_4_15.content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 5 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_16) / 5)

				if (5 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_16) / 5)) > 0 and var_4_13 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_12 = var_4_12 + 0.3

					if var_4_18 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_12
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302001", "story_v_out_320302.awb") ~= 0 then
					local var_4_19 = manager.audio:GetVoiceLength("story_v_out_320302", "320302001", "story_v_out_320302.awb") / 1000

					if var_4_19 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_12
					end

					if var_4_15.prefab_name ~= "" and arg_1_1.actors_[var_4_15.prefab_name] ~= nil then
						local var_4_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_15.prefab_name].transform, "story_v_out_320302", "320302001", "story_v_out_320302.awb")

						arg_1_1:RecordAudio("320302001", var_4_20)
						arg_1_1:RecordAudio("320302001", var_4_20)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_320302", "320302001", "story_v_out_320302.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_320302", "320302001", "story_v_out_320302.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_12 + 0.3
			local var_4_22 = math.max(var_4_13, arg_1_1.talkMaxDuration)

			if var_4_12 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
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
	Play320302002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 320302002
		arg_8_1.duration_ = 3.87

		local var_8_0 = {
			zh = 3.366,
			ja = 3.866
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
				arg_8_0:Play320302003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.5

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:GetWordFromCfg(320302002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 20 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 20)

				if (20 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 20)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302002", "story_v_out_320302.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302002", "story_v_out_320302.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_320302", "320302002", "story_v_out_320302.awb")

						arg_8_1:RecordAudio("320302002", var_11_6)
						arg_8_1:RecordAudio("320302002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_320302", "320302002", "story_v_out_320302.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_320302", "320302002", "story_v_out_320302.awb")
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
	Play320302003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 320302003
		arg_12_1.duration_ = 8.83

		local var_12_0 = {
			zh = 8.833,
			ja = 7.833
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
				arg_12_0:Play320302004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.05

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

				local var_15_1 = arg_12_1:GetWordFromCfg(320302003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 42 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 42)

				if (42 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 42)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302003", "story_v_out_320302.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302003", "story_v_out_320302.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_320302", "320302003", "story_v_out_320302.awb")

						arg_12_1:RecordAudio("320302003", var_15_6)
						arg_12_1:RecordAudio("320302003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_320302", "320302003", "story_v_out_320302.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_320302", "320302003", "story_v_out_320302.awb")
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
	Play320302004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 320302004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play320302005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.05

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

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(320302004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 2 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 2)

				if (2 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 2)) > 0 and var_19_0 < var_19_3 then
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
	Play320302005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 320302005
		arg_20_1.duration_ = 7.2

		local var_20_0 = {
			zh = 4.533,
			ja = 7.2
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
				arg_20_0:Play320302006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.575

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

				local var_23_1 = arg_20_1:GetWordFromCfg(320302005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 23 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 23)

				if (23 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 23)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302005", "story_v_out_320302.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302005", "story_v_out_320302.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_320302", "320302005", "story_v_out_320302.awb")

						arg_20_1:RecordAudio("320302005", var_23_6)
						arg_20_1:RecordAudio("320302005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_320302", "320302005", "story_v_out_320302.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_320302", "320302005", "story_v_out_320302.awb")
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
	Play320302006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 320302006
		arg_24_1.duration_ = 14.73

		local var_24_0 = {
			zh = 14.733,
			ja = 13.1
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
				arg_24_0:Play320302007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 1.35

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_1 = arg_24_1:GetWordFromCfg(320302006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 54 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 54)

				if (54 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 54)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302006", "story_v_out_320302.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302006", "story_v_out_320302.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_320302", "320302006", "story_v_out_320302.awb")

						arg_24_1:RecordAudio("320302006", var_27_6)
						arg_24_1:RecordAudio("320302006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_320302", "320302006", "story_v_out_320302.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_320302", "320302006", "story_v_out_320302.awb")
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
	Play320302007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 320302007
		arg_28_1.duration_ = 5.4

		local var_28_0 = {
			zh = 5.3,
			ja = 5.4
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
				arg_28_0:Play320302008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.375

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:GetWordFromCfg(320302007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 15 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 15)

				if (15 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 15)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302007", "story_v_out_320302.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302007", "story_v_out_320302.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_320302", "320302007", "story_v_out_320302.awb")

						arg_28_1:RecordAudio("320302007", var_31_6)
						arg_28_1:RecordAudio("320302007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_320302", "320302007", "story_v_out_320302.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_320302", "320302007", "story_v_out_320302.awb")
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
	Play320302008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 320302008
		arg_32_1.duration_ = 6.33

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play320302009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0.266666666666667 < arg_32_1.time_ and arg_32_1.time_ <= 0.266666666666667 + arg_35_0 then
				local var_35_0 = arg_32_1.bgs_.STblack

				arg_32_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_35_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_1 = var_35_0:GetComponent("SpriteRenderer")

				if var_35_1 and var_35_1.sprite then
					local var_35_2 = 2 * (var_35_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_35_0.transform.localScale = Vector3.New(var_35_2 / var_35_1.sprite.bounds.size.y < var_35_2 * manager.ui.mainCameraCom_.aspect / var_35_1.sprite.bounds.size.x and var_35_2 * manager.ui.mainCameraCom_.aspect / var_35_1.sprite.bounds.size.x or var_35_2 / var_35_1.sprite.bounds.size.y, var_35_2 / var_35_1.sprite.bounds.size.y < var_35_2 * manager.ui.mainCameraCom_.aspect / var_35_1.sprite.bounds.size.x and var_35_2 * manager.ui.mainCameraCom_.aspect / var_35_1.sprite.bounds.size.x or var_35_2 / var_35_1.sprite.bounds.size.y, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "STblack" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_3 = 0

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_3 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_4 = 0.733333333333333

			if var_35_3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_3 + var_35_4 then
				local var_35_5 = Color.New(0, 0, 0)

				var_35_5.a = Mathf.Lerp(0, 1, (arg_32_1.time_ - var_35_3) / var_35_4)
				arg_32_1.mask_.color = var_35_5
			end

			if arg_32_1.time_ >= var_35_3 + var_35_4 and arg_32_1.time_ < var_35_3 + var_35_4 + arg_35_0 then
				local var_35_6 = Color.New(0, 0, 0)

				var_35_6.a = 1
				arg_32_1.mask_.color = var_35_6
			end

			local var_35_7 = 0.733333333333333

			if 0.733333333333333 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_8 = 0.733333333333333

			if var_35_7 <= arg_32_1.time_ and arg_32_1.time_ < var_35_7 + var_35_8 then
				local var_35_9 = Color.New(0, 0, 0)

				var_35_9.a = Mathf.Lerp(1, 0, (arg_32_1.time_ - var_35_7) / var_35_8)
				arg_32_1.mask_.color = var_35_9
			end

			if arg_32_1.time_ >= var_35_7 + var_35_8 and arg_32_1.time_ < var_35_7 + var_35_8 + arg_35_0 then
				local var_35_10 = Color.New(0, 0, 0)

				arg_32_1.mask_.enabled = false
				var_35_10.a = 0
				arg_32_1.mask_.color = var_35_10
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_11 = 1.33333333333333
			local var_35_12 = 0.45

			if 1.33333333333333 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_13 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_13:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_14 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(320302008).content)

				arg_32_1.text_.text = var_35_14

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_16 = 18 <= 0 and var_35_12 or var_35_12 * (utf8.len(var_35_14) / 18)

				if (18 <= 0 and var_35_12 or var_35_12 * (utf8.len(var_35_14) / 18)) > 0 and var_35_12 < var_35_16 then
					arg_32_1.talkMaxDuration = var_35_16
					var_35_11 = var_35_11 + 0.3

					if var_35_16 + var_35_11 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_16 + var_35_11
					end
				end

				arg_32_1.text_.text = var_35_14
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_17 = var_35_11 + 0.3
			local var_35_18 = math.max(var_35_12, arg_32_1.talkMaxDuration)

			if var_35_11 + 0.3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_17 + var_35_18 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_17) / var_35_18

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_17 + var_35_18 and arg_32_1.time_ < var_35_17 + var_35_18 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play320302009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 320302009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play320302010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.45

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_1 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(320302009).content)

				arg_38_1.text_.text = var_41_1

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_3 = 18 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 18)

				if (18 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 18)) > 0 and var_41_0 < var_41_3 then
					arg_38_1.talkMaxDuration = var_41_3

					if var_41_3 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_3 + 0
					end
				end

				arg_38_1.text_.text = var_41_1
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_4 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_4

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play320302010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 320302010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play320302011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 1.6

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_1 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(320302010).content)

				arg_42_1.text_.text = var_45_1

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_3 = 64 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 64)

				if (64 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 64)) > 0 and var_45_0 < var_45_3 then
					arg_42_1.talkMaxDuration = var_45_3

					if var_45_3 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_3 + 0
					end
				end

				arg_42_1.text_.text = var_45_1
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_4 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_4

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play320302011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 320302011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play320302012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.3

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_1 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(320302011).content)

				arg_46_1.text_.text = var_49_1

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_3 = 12 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 12)

				if (12 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 12)) > 0 and var_49_0 < var_49_3 then
					arg_46_1.talkMaxDuration = var_49_3

					if var_49_3 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_3 + 0
					end
				end

				arg_46_1.text_.text = var_49_1
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_4 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_4

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play320302012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 320302012
		arg_50_1.duration_ = 7.1

		local var_50_0 = {
			zh = 4.766,
			ja = 7.1
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play320302013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.4

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_1 = arg_50_1:GetWordFromCfg(320302012)
				local var_53_2 = arg_50_1:FormatText(var_53_1.content)

				arg_50_1.text_.text = var_53_2

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 16 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 16)

				if (16 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 16)) > 0 and var_53_0 < var_53_4 then
					arg_50_1.talkMaxDuration = var_53_4

					if var_53_4 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_4 + 0
					end
				end

				arg_50_1.text_.text = var_53_2
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302012", "story_v_out_320302.awb") ~= 0 then
					local var_53_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302012", "story_v_out_320302.awb") / 1000

					if var_53_5 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + 0
					end

					if var_53_1.prefab_name ~= "" and arg_50_1.actors_[var_53_1.prefab_name] ~= nil then
						local var_53_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_1.prefab_name].transform, "story_v_out_320302", "320302012", "story_v_out_320302.awb")

						arg_50_1:RecordAudio("320302012", var_53_6)
						arg_50_1:RecordAudio("320302012", var_53_6)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_320302", "320302012", "story_v_out_320302.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_320302", "320302012", "story_v_out_320302.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_7 and arg_50_1.time_ < 0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play320302013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 320302013
		arg_54_1.duration_ = 2.93

		local var_54_0 = {
			zh = 1.1,
			ja = 2.933
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play320302014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.15

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_1 = arg_54_1:GetWordFromCfg(320302013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 6 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 6)

				if (6 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 6)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302013", "story_v_out_320302.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302013", "story_v_out_320302.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_320302", "320302013", "story_v_out_320302.awb")

						arg_54_1:RecordAudio("320302013", var_57_6)
						arg_54_1:RecordAudio("320302013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_320302", "320302013", "story_v_out_320302.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_320302", "320302013", "story_v_out_320302.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play320302014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 320302014
		arg_58_1.duration_ = 7

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play320302015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if arg_58_1.bgs_.L05g == nil then
				local var_61_0 = Object.Instantiate(arg_58_1.paintGo_)

				var_61_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L05g")
				var_61_0.name = "L05g"
				var_61_0.transform.parent = arg_58_1.stage_.transform
				var_61_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.bgs_.L05g = var_61_0
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				local var_61_1 = arg_58_1.bgs_.L05g

				arg_58_1.bgs_.L05g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_61_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_61_2 = var_61_1:GetComponent("SpriteRenderer")

				if var_61_2 and var_61_2.sprite then
					local var_61_3 = 2 * (var_61_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_61_1.transform.localScale = Vector3.New(var_61_3 / var_61_2.sprite.bounds.size.y < var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x and var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x or var_61_3 / var_61_2.sprite.bounds.size.y, var_61_3 / var_61_2.sprite.bounds.size.y < var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x and var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x or var_61_3 / var_61_2.sprite.bounds.size.y, 0)
				end

				for iter_61_0, iter_61_1 in pairs(arg_58_1.bgs_) do
					if iter_61_0 ~= "L05g" then
						iter_61_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_61_4 = 0

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1.allBtn_.enabled = false
			end

			if arg_58_1.time_ >= var_61_4 + 0.3 and arg_58_1.time_ < var_61_4 + 0.3 + arg_61_0 then
				arg_58_1.allBtn_.enabled = true
			end

			local var_61_5 = 0

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_6 = 2

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_6 then
				local var_61_7 = Color.New(0, 0, 0)

				var_61_7.a = Mathf.Lerp(1, 0, (arg_58_1.time_ - var_61_5) / var_61_6)
				arg_58_1.mask_.color = var_61_7
			end

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 then
				local var_61_8 = Color.New(0, 0, 0)

				arg_58_1.mask_.enabled = false
				var_61_8.a = 0
				arg_58_1.mask_.color = var_61_8
			end

			if 0.333333333333333 < arg_58_1.time_ and arg_58_1.time_ <= 0.333333333333333 + arg_61_0 then
				arg_58_1:AudioAction("play", "music", "bgm_activity_3_6_story_biotech", "bgm_activity_3_6_story_biotech", "bgm_activity_3_6_story_biotech.awb")

				local var_61_11 = manager.audio:GetAudioName("bgm_activity_3_6_story_biotech", "bgm_activity_3_6_story_biotech")

				if "" ~= "" then
					if arg_58_1.bgmTxt_.text ~= var_61_11 and arg_58_1.bgmTxt_.text ~= "" then
						if arg_58_1.bgmTxt2_.text ~= "" then
							arg_58_1.bgmTxt_.text = arg_58_1.bgmTxt2_.text
						end

						arg_58_1.bgmTxt2_.text = var_61_11

						arg_58_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_58_1.bgmTxt_.text = var_61_11
						arg_58_1.bgmTxt2_.text = var_61_11
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

			if 0.766666666666667 < arg_58_1.time_ and arg_58_1.time_ <= 0.766666666666667 + arg_61_0 then
				arg_58_1:AudioAction("play", "effect", "se_story_side_1096", "se_story_1096_whoosh", "")
			end

			if arg_58_1.frameCnt_ <= 1 then
				arg_58_1.dialog_:SetActive(false)
			end

			local var_61_13 = 2
			local var_61_14 = 1.075

			if 2 < arg_58_1.time_ and arg_58_1.time_ <= var_61_13 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_15 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_15:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_58_1.dialogCg_.alpha = arg_63_0
				end))
				var_61_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_16 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(320302014).content)

				arg_58_1.text_.text = var_61_16

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_18 = 43 <= 0 and var_61_14 or var_61_14 * (utf8.len(var_61_16) / 43)

				if (43 <= 0 and var_61_14 or var_61_14 * (utf8.len(var_61_16) / 43)) > 0 and var_61_14 < var_61_18 then
					arg_58_1.talkMaxDuration = var_61_18
					var_61_13 = var_61_13 + 0.3

					if var_61_18 + var_61_13 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_18 + var_61_13
					end
				end

				arg_58_1.text_.text = var_61_16
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_19 = var_61_13 + 0.3
			local var_61_20 = math.max(var_61_14, arg_58_1.talkMaxDuration)

			if var_61_13 + 0.3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_19 + var_61_20 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_19) / var_61_20

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_19 + var_61_20 and arg_58_1.time_ < var_61_19 + var_61_20 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play320302015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 320302015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play320302016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 1.775

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

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(320302015).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 71 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 71)

				if (71 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 71)) > 0 and var_68_0 < var_68_3 then
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
	Play320302016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 320302016
		arg_69_1.duration_ = 4.23

		local var_69_0 = {
			zh = 2.5,
			ja = 4.233
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
				arg_69_0:Play320302017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_72_0 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_69_1.stage_.transform)

				var_72_0.name = "1156ui_story"
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1156ui_story"] = var_72_0

				local var_72_1 = var_72_0:GetComponentInChildren(typeof(CharacterEffect))

				var_72_1.enabled = true

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_0, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end

				arg_69_1:ShowWeapon(var_72_1.transform, false)

				arg_69_1.var_["1156ui_story" .. "Animator"] = var_72_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_69_1.var_["1156ui_story" .. "Animator"].applyRootMotion = true
				arg_69_1.var_["1156ui_story" .. "LipSync"] = var_72_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_72_3 = arg_69_1.actors_["1156ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1156ui_story = var_72_3.localPosition
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_3.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_69_1.time_ - 0) / var_72_4)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_3.localPosition = Vector3.New(0, -1.1, -6.18)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			local var_72_5 = arg_69_1.actors_["1156ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1156ui_story == nil then
				arg_69_1.var_.characterEffect1156ui_story = var_72_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.characterEffect1156ui_story and not isNil(var_72_5) then
					arg_69_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1156ui_story then
				arg_69_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_72_8 = 0
			local var_72_9 = 0.325

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(320302016)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 13 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 13)

				if (13 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 13)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302016", "story_v_out_320302.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_320302", "320302016", "story_v_out_320302.awb") / 1000

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_out_320302", "320302016", "story_v_out_320302.awb")

						arg_69_1:RecordAudio("320302016", var_72_15)
						arg_69_1:RecordAudio("320302016", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_320302", "320302016", "story_v_out_320302.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_320302", "320302016", "story_v_out_320302.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_16 and arg_69_1.time_ < var_72_8 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play320302017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 320302017
		arg_73_1.duration_ = 9

		local var_73_0 = {
			zh = 8.466,
			ja = 9
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play320302018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1156ui_story"]) and arg_73_1.var_.characterEffect1156ui_story == nil then
				arg_73_1.var_.characterEffect1156ui_story = arg_73_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1156ui_story"]) then
				if arg_73_1.var_.characterEffect1156ui_story and not isNil(arg_73_1.actors_["1156ui_story"]) then
					arg_73_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1156ui_story"]) and arg_73_1.var_.characterEffect1156ui_story then
				arg_73_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.875

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(320302017)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 35 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 35)

				if (35 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 35)) > 0 and var_76_2 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302017", "story_v_out_320302.awb") ~= 0 then
					local var_76_7 = manager.audio:GetVoiceLength("story_v_out_320302", "320302017", "story_v_out_320302.awb") / 1000

					if var_76_7 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_1
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_320302", "320302017", "story_v_out_320302.awb")

						arg_73_1:RecordAudio("320302017", var_76_8)
						arg_73_1:RecordAudio("320302017", var_76_8)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_320302", "320302017", "story_v_out_320302.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_320302", "320302017", "story_v_out_320302.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_9 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_9 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_9

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_9 and arg_73_1.time_ < var_76_1 + var_76_9 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play320302018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 320302018
		arg_77_1.duration_ = 4.93

		local var_77_0 = {
			zh = 2,
			ja = 4.933
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
				arg_77_0:Play320302019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1156ui_story"]) and arg_77_1.var_.characterEffect1156ui_story == nil then
				arg_77_1.var_.characterEffect1156ui_story = arg_77_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1156ui_story"]) then
				if arg_77_1.var_.characterEffect1156ui_story and not isNil(arg_77_1.actors_["1156ui_story"]) then
					arg_77_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1156ui_story"]) and arg_77_1.var_.characterEffect1156ui_story then
				arg_77_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_80_2 = 0
			local var_80_3 = 0.3

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(320302018)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 12 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 12)

				if (12 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 12)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302018", "story_v_out_320302.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_320302", "320302018", "story_v_out_320302.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_320302", "320302018", "story_v_out_320302.awb")

						arg_77_1:RecordAudio("320302018", var_80_9)
						arg_77_1:RecordAudio("320302018", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_320302", "320302018", "story_v_out_320302.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_320302", "320302018", "story_v_out_320302.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play320302019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 320302019
		arg_81_1.duration_ = 4.6

		local var_81_0 = {
			zh = 3.633,
			ja = 4.6
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
				arg_81_0:Play320302020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1156ui_story"]) and arg_81_1.var_.characterEffect1156ui_story == nil then
				arg_81_1.var_.characterEffect1156ui_story = arg_81_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1156ui_story"]) then
				if arg_81_1.var_.characterEffect1156ui_story and not isNil(arg_81_1.actors_["1156ui_story"]) then
					arg_81_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1156ui_story"]) and arg_81_1.var_.characterEffect1156ui_story then
				arg_81_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 0.375

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(320302019)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_6 = 15 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_4) / 15)

				if (15 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_4) / 15)) > 0 and var_84_2 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302019", "story_v_out_320302.awb") ~= 0 then
					local var_84_7 = manager.audio:GetVoiceLength("story_v_out_320302", "320302019", "story_v_out_320302.awb") / 1000

					if var_84_7 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_1
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_320302", "320302019", "story_v_out_320302.awb")

						arg_81_1:RecordAudio("320302019", var_84_8)
						arg_81_1:RecordAudio("320302019", var_84_8)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_320302", "320302019", "story_v_out_320302.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_320302", "320302019", "story_v_out_320302.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_9 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_9 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_9

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_9 and arg_81_1.time_ < var_84_1 + var_84_9 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play320302020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 320302020
		arg_85_1.duration_ = 4.67

		local var_85_0 = {
			zh = 3.133,
			ja = 4.666
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
				arg_85_0:Play320302021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1156ui_story"]) and arg_85_1.var_.characterEffect1156ui_story == nil then
				arg_85_1.var_.characterEffect1156ui_story = arg_85_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1156ui_story"]) then
				if arg_85_1.var_.characterEffect1156ui_story and not isNil(arg_85_1.actors_["1156ui_story"]) then
					arg_85_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1156ui_story"]) and arg_85_1.var_.characterEffect1156ui_story then
				arg_85_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_88_2 = 0
			local var_88_3 = 0.325

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_4 = arg_85_1:GetWordFromCfg(320302020)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 13 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 13)

				if (13 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 13)) > 0 and var_88_3 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302020", "story_v_out_320302.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_320302", "320302020", "story_v_out_320302.awb") / 1000

					if var_88_8 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_2
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_out_320302", "320302020", "story_v_out_320302.awb")

						arg_85_1:RecordAudio("320302020", var_88_9)
						arg_85_1:RecordAudio("320302020", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_320302", "320302020", "story_v_out_320302.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_320302", "320302020", "story_v_out_320302.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_3, arg_85_1.talkMaxDuration)

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_2) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_2 + var_88_10 and arg_85_1.time_ < var_88_2 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play320302021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 320302021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play320302022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1156ui_story = arg_89_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1156ui_story"].transform.position).z)
				arg_89_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1156ui_story"].transform.localEulerAngles = arg_89_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1156ui_story"].transform.position).z)
				arg_89_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1156ui_story"].transform.localEulerAngles = arg_89_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_92_1 = 0
			local var_92_2 = 1.3

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(320302021).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 52 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 52)

				if (52 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 52)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play320302022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 320302022
		arg_93_1.duration_ = 8.8

		local var_93_0 = {
			zh = 8.8,
			ja = 7.5
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
				arg_93_0:Play320302023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.35

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1067].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4043")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(320302022)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 14 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 14)

				if (14 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 14)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302022", "story_v_out_320302.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302022", "story_v_out_320302.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_320302", "320302022", "story_v_out_320302.awb")

						arg_93_1:RecordAudio("320302022", var_96_6)
						arg_93_1:RecordAudio("320302022", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_320302", "320302022", "story_v_out_320302.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_320302", "320302022", "story_v_out_320302.awb")
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
	Play320302023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 320302023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play320302024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 1.575

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

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(320302023).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 63 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 63)

				if (63 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 63)) > 0 and var_100_0 < var_100_3 then
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
	Play320302024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320302024
		arg_101_1.duration_ = 6.33

		local var_101_0 = {
			zh = 3.9,
			ja = 6.333
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
				arg_101_0:Play320302025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1156ui_story"]) and arg_101_1.var_.characterEffect1156ui_story == nil then
				arg_101_1.var_.characterEffect1156ui_story = arg_101_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1156ui_story"]) then
				if arg_101_1.var_.characterEffect1156ui_story and not isNil(arg_101_1.actors_["1156ui_story"]) then
					arg_101_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1156ui_story"]) and arg_101_1.var_.characterEffect1156ui_story then
				arg_101_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action11_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_104_2 = arg_101_1.actors_["1156ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1156ui_story = var_104_2.localPosition
			end

			local var_104_3 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 then
				var_104_2.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_101_1.time_ - 0) / var_104_3)
				var_104_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_2.position).x, (manager.ui.mainCamera.transform.position - var_104_2.position).y, (manager.ui.mainCamera.transform.position - var_104_2.position).z)
				var_104_2.localEulerAngles.z = 0
				var_104_2.localEulerAngles.x = 0
				var_104_2.localEulerAngles = var_104_2.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 then
				var_104_2.localPosition = Vector3.New(0, -1.1, -6.18)
				var_104_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_2.position).x, (manager.ui.mainCamera.transform.position - var_104_2.position).y, (manager.ui.mainCamera.transform.position - var_104_2.position).z)
				var_104_2.localEulerAngles.z = 0
				var_104_2.localEulerAngles.x = 0
				var_104_2.localEulerAngles = var_104_2.localEulerAngles
			end

			local var_104_4 = 0
			local var_104_5 = 0.375

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(320302024)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 15 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 15)

				if (15 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 15)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302024", "story_v_out_320302.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_320302", "320302024", "story_v_out_320302.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_320302", "320302024", "story_v_out_320302.awb")

						arg_101_1:RecordAudio("320302024", var_104_11)
						arg_101_1:RecordAudio("320302024", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_320302", "320302024", "story_v_out_320302.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_320302", "320302024", "story_v_out_320302.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play320302025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320302025
		arg_105_1.duration_ = 2.9

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play320302026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1156ui_story"]) and arg_105_1.var_.characterEffect1156ui_story == nil then
				arg_105_1.var_.characterEffect1156ui_story = arg_105_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1156ui_story"]) then
				if arg_105_1.var_.characterEffect1156ui_story and not isNil(arg_105_1.actors_["1156ui_story"]) then
					arg_105_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1156ui_story"]) and arg_105_1.var_.characterEffect1156ui_story then
				arg_105_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0.333333333333333 < arg_105_1.time_ and arg_105_1.time_ <= 0.333333333333333 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story", "se_story_communication", "")
			end

			local var_108_2 = 0
			local var_108_3 = 0.35

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_4 = arg_105_1:GetWordFromCfg(320302025)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 14 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 14)

				if (14 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 14)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302025", "story_v_out_320302.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_320302", "320302025", "story_v_out_320302.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_out_320302", "320302025", "story_v_out_320302.awb")

						arg_105_1:RecordAudio("320302025", var_108_9)
						arg_105_1:RecordAudio("320302025", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_320302", "320302025", "story_v_out_320302.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_320302", "320302025", "story_v_out_320302.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_10 and arg_105_1.time_ < var_108_2 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play320302026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 320302026
		arg_109_1.duration_ = 5.67

		local var_109_0 = {
			zh = 2.333,
			ja = 5.666
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
				arg_109_0:Play320302027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1156ui_story"]) and arg_109_1.var_.characterEffect1156ui_story == nil then
				arg_109_1.var_.characterEffect1156ui_story = arg_109_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1156ui_story"]) then
				if arg_109_1.var_.characterEffect1156ui_story and not isNil(arg_109_1.actors_["1156ui_story"]) then
					arg_109_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1156ui_story"]) and arg_109_1.var_.characterEffect1156ui_story then
				arg_109_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action11_2")
			end

			local var_112_2 = 0
			local var_112_3 = 0.3

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(320302026)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 12 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 12)

				if (12 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 12)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302026", "story_v_out_320302.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_320302", "320302026", "story_v_out_320302.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_320302", "320302026", "story_v_out_320302.awb")

						arg_109_1:RecordAudio("320302026", var_112_9)
						arg_109_1:RecordAudio("320302026", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_320302", "320302026", "story_v_out_320302.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_320302", "320302026", "story_v_out_320302.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play320302027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 320302027
		arg_113_1.duration_ = 4.13

		local var_113_0 = {
			zh = 3.366,
			ja = 4.133
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
				arg_113_0:Play320302028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if arg_113_1.bgs_.STwhite == nil then
				local var_116_0 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_116_0.name = "STwhite"
				var_116_0.transform.parent = arg_113_1.stage_.transform
				var_116_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_.STwhite = var_116_0
			end

			if 1.16666666666667 < arg_113_1.time_ and arg_113_1.time_ <= 1.16666666666667 + arg_116_0 then
				local var_116_1 = arg_113_1.bgs_.STwhite

				arg_113_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_116_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_2 = var_116_1:GetComponent("SpriteRenderer")

				if var_116_2 and var_116_2.sprite then
					local var_116_3 = 2 * (var_116_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_116_1.transform.localScale = Vector3.New(var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "STwhite" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_4 = 1.16666666666667

			if 1.16666666666667 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			if arg_113_1.time_ >= var_116_4 + 0.3 and arg_113_1.time_ < var_116_4 + 0.3 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end

			local var_116_5 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_6 = 1.16666666666667

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_6 then
				local var_116_7 = Color.New(0, 0, 0)

				var_116_7.a = Mathf.Lerp(0, 1, (arg_113_1.time_ - var_116_5) / var_116_6)
				arg_113_1.mask_.color = var_116_7
			end

			if arg_113_1.time_ >= var_116_5 + var_116_6 and arg_113_1.time_ < var_116_5 + var_116_6 + arg_116_0 then
				local var_116_8 = Color.New(0, 0, 0)

				var_116_8.a = 1
				arg_113_1.mask_.color = var_116_8
			end

			local var_116_9 = 1.16666666666667

			if 1.16666666666667 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_10 = 2

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_10 then
				local var_116_11 = Color.New(0, 0, 0)

				var_116_11.a = Mathf.Lerp(1, 0, (arg_113_1.time_ - var_116_9) / var_116_10)
				arg_113_1.mask_.color = var_116_11
			end

			if arg_113_1.time_ >= var_116_9 + var_116_10 and arg_113_1.time_ < var_116_9 + var_116_10 + arg_116_0 then
				local var_116_12 = Color.New(0, 0, 0)

				arg_113_1.mask_.enabled = false
				var_116_12.a = 0
				arg_113_1.mask_.color = var_116_12
			end

			local var_116_13 = arg_113_1.actors_["1156ui_story"].transform

			if 1.16666666666667 < arg_113_1.time_ and arg_113_1.time_ <= 1.16666666666667 + arg_116_0 then
				arg_113_1.var_.moveOldPos1156ui_story = var_116_13.localPosition
			end

			local var_116_14 = 0.001

			if 1.16666666666667 <= arg_113_1.time_ and arg_113_1.time_ < 1.16666666666667 + var_116_14 then
				var_116_13.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 1.16666666666667) / var_116_14)
				var_116_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_13.position).x, (manager.ui.mainCamera.transform.position - var_116_13.position).y, (manager.ui.mainCamera.transform.position - var_116_13.position).z)
				var_116_13.localEulerAngles.z = 0
				var_116_13.localEulerAngles.x = 0
				var_116_13.localEulerAngles = var_116_13.localEulerAngles
			end

			if arg_113_1.time_ >= 1.16666666666667 + var_116_14 and arg_113_1.time_ < 1.16666666666667 + var_116_14 + arg_116_0 then
				var_116_13.localPosition = Vector3.New(0, 100, 0)
				var_116_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_13.position).x, (manager.ui.mainCamera.transform.position - var_116_13.position).y, (manager.ui.mainCamera.transform.position - var_116_13.position).z)
				var_116_13.localEulerAngles.z = 0
				var_116_13.localEulerAngles.x = 0
				var_116_13.localEulerAngles = var_116_13.localEulerAngles
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_15 = 2.4
			local var_116_16 = 0.075

			if 2.4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_17 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_17:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_18 = arg_113_1:GetWordFromCfg(320302027)
				local var_116_19 = arg_113_1:FormatText(var_116_18.content)

				arg_113_1.text_.text = var_116_19

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_21 = 3 <= 0 and var_116_16 or var_116_16 * (utf8.len(var_116_19) / 3)

				if (3 <= 0 and var_116_16 or var_116_16 * (utf8.len(var_116_19) / 3)) > 0 and var_116_16 < var_116_21 then
					arg_113_1.talkMaxDuration = var_116_21
					var_116_15 = var_116_15 + 0.3

					if var_116_21 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_21 + var_116_15
					end
				end

				arg_113_1.text_.text = var_116_19
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302027", "story_v_out_320302.awb") ~= 0 then
					local var_116_22 = manager.audio:GetVoiceLength("story_v_out_320302", "320302027", "story_v_out_320302.awb") / 1000

					if var_116_22 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_22 + var_116_15
					end

					if var_116_18.prefab_name ~= "" and arg_113_1.actors_[var_116_18.prefab_name] ~= nil then
						local var_116_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_18.prefab_name].transform, "story_v_out_320302", "320302027", "story_v_out_320302.awb")

						arg_113_1:RecordAudio("320302027", var_116_23)
						arg_113_1:RecordAudio("320302027", var_116_23)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_320302", "320302027", "story_v_out_320302.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_320302", "320302027", "story_v_out_320302.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_24 = var_116_15 + 0.3
			local var_116_25 = math.max(var_116_16, arg_113_1.talkMaxDuration)

			if var_116_15 + 0.3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_24 + var_116_25 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_24) / var_116_25

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_24 + var_116_25 and arg_113_1.time_ < var_116_24 + var_116_25 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play320302028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 320302028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play320302029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 1.6

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(320302028).content)

				arg_119_1.text_.text = var_122_1

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_3 = 64 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 64)

				if (64 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 64)) > 0 and var_122_0 < var_122_3 then
					arg_119_1.talkMaxDuration = var_122_3

					if var_122_3 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_3 + 0
					end
				end

				arg_119_1.text_.text = var_122_1
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_4 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_4

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play320302029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 320302029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play320302030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.75

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

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(320302029).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 30 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 30)

				if (30 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 30)) > 0 and var_126_0 < var_126_3 then
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
	Play320302030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 320302030
		arg_127_1.duration_ = 7.45

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play320302031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.bgs_.ST67 == nil then
				local var_130_0 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST67")
				var_130_0.name = "ST67"
				var_130_0.transform.parent = arg_127_1.stage_.transform
				var_130_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_.ST67 = var_130_0
			end

			if 0.9 < arg_127_1.time_ and arg_127_1.time_ <= 0.9 + arg_130_0 then
				local var_130_1 = arg_127_1.bgs_.ST67

				arg_127_1.bgs_.ST67.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_130_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_2 = var_130_1:GetComponent("SpriteRenderer")

				if var_130_2 and var_130_2.sprite then
					local var_130_3 = 2 * (var_130_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_130_1.transform.localScale = Vector3.New(var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "ST67" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_4 = 0

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			if arg_127_1.time_ >= var_130_4 + 0.3 and arg_127_1.time_ < var_130_4 + 0.3 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end

			local var_130_5 = 0

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_6 = 0.9

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_6 then
				local var_130_7 = Color.New(0, 0, 0)

				var_130_7.a = Mathf.Lerp(0, 1, (arg_127_1.time_ - var_130_5) / var_130_6)
				arg_127_1.mask_.color = var_130_7
			end

			if arg_127_1.time_ >= var_130_5 + var_130_6 and arg_127_1.time_ < var_130_5 + var_130_6 + arg_130_0 then
				local var_130_8 = Color.New(0, 0, 0)

				var_130_8.a = 1
				arg_127_1.mask_.color = var_130_8
			end

			local var_130_9 = 0.9

			if 0.9 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_10 = 1.83333333333333

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_10 then
				local var_130_11 = Color.New(0, 0, 0)

				var_130_11.a = Mathf.Lerp(1, 0, (arg_127_1.time_ - var_130_9) / var_130_10)
				arg_127_1.mask_.color = var_130_11
			end

			if arg_127_1.time_ >= var_130_9 + var_130_10 and arg_127_1.time_ < var_130_9 + var_130_10 + arg_130_0 then
				local var_130_12 = Color.New(0, 0, 0)

				arg_127_1.mask_.enabled = false
				var_130_12.a = 0
				arg_127_1.mask_.color = var_130_12
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_13 = 2.4545363007579
			local var_130_14 = 0.5

			if 2.4545363007579 < arg_127_1.time_ and arg_127_1.time_ <= var_130_13 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_15 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_15:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_16 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(320302030).content)

				arg_127_1.text_.text = var_130_16

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_18 = 20 <= 0 and var_130_14 or var_130_14 * (utf8.len(var_130_16) / 20)

				if (20 <= 0 and var_130_14 or var_130_14 * (utf8.len(var_130_16) / 20)) > 0 and var_130_14 < var_130_18 then
					arg_127_1.talkMaxDuration = var_130_18
					var_130_13 = var_130_13 + 0.3

					if var_130_18 + var_130_13 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_18 + var_130_13
					end
				end

				arg_127_1.text_.text = var_130_16
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_19 = var_130_13 + 0.3
			local var_130_20 = math.max(var_130_14, arg_127_1.talkMaxDuration)

			if var_130_13 + 0.3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_19 + var_130_20 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_19) / var_130_20

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_19 + var_130_20 and arg_127_1.time_ < var_130_19 + var_130_20 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play320302031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 320302031
		arg_133_1.duration_ = 6.67

		local var_133_0 = {
			zh = 4.266,
			ja = 6.666
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
				arg_133_0:Play320302032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.55

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:GetWordFromCfg(320302031)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 22 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 22)

				if (22 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 22)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302031", "story_v_out_320302.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302031", "story_v_out_320302.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_320302", "320302031", "story_v_out_320302.awb")

						arg_133_1:RecordAudio("320302031", var_136_6)
						arg_133_1:RecordAudio("320302031", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_320302", "320302031", "story_v_out_320302.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_320302", "320302031", "story_v_out_320302.awb")
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
	Play320302032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 320302032
		arg_137_1.duration_ = 3.33

		local var_137_0 = {
			zh = 1.666,
			ja = 3.333
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
				arg_137_0:Play320302033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.225

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_1 = arg_137_1:GetWordFromCfg(320302032)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 9 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 9)

				if (9 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 9)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302032", "story_v_out_320302.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302032", "story_v_out_320302.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_320302", "320302032", "story_v_out_320302.awb")

						arg_137_1:RecordAudio("320302032", var_140_6)
						arg_137_1:RecordAudio("320302032", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_320302", "320302032", "story_v_out_320302.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_320302", "320302032", "story_v_out_320302.awb")
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
	Play320302033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 320302033
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play320302034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 1.175

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(320302033).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 47 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 47)

				if (47 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 47)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play320302034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 320302034
		arg_145_1.duration_ = 12.77

		local var_145_0 = {
			zh = 6.633,
			ja = 12.766
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
				arg_145_0:Play320302035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.8

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:GetWordFromCfg(320302034)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 32 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 32)

				if (32 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 32)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302034", "story_v_out_320302.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302034", "story_v_out_320302.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_320302", "320302034", "story_v_out_320302.awb")

						arg_145_1:RecordAudio("320302034", var_148_6)
						arg_145_1:RecordAudio("320302034", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_320302", "320302034", "story_v_out_320302.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_320302", "320302034", "story_v_out_320302.awb")
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
	Play320302035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 320302035
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play320302036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.875

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(320302035).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 35 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 35)

				if (35 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 35)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play320302036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 320302036
		arg_153_1.duration_ = 3.13

		local var_153_0 = {
			zh = 3.133,
			ja = 2.266
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
				arg_153_0:Play320302037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.4

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:GetWordFromCfg(320302036)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 16 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 16)

				if (16 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 16)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302036", "story_v_out_320302.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302036", "story_v_out_320302.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_320302", "320302036", "story_v_out_320302.awb")

						arg_153_1:RecordAudio("320302036", var_156_6)
						arg_153_1:RecordAudio("320302036", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_320302", "320302036", "story_v_out_320302.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_320302", "320302036", "story_v_out_320302.awb")
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
	Play320302037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 320302037
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play320302038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.375

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(320302037).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 15 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 15)

				if (15 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 15)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play320302038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 320302038
		arg_161_1.duration_ = 2.63

		local var_161_0 = {
			zh = 0.999999999999,
			ja = 2.633
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
				arg_161_0:Play320302039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.05

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_1 = arg_161_1:GetWordFromCfg(320302038)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 2 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 2)

				if (2 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 2)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302038", "story_v_out_320302.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302038", "story_v_out_320302.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_320302", "320302038", "story_v_out_320302.awb")

						arg_161_1:RecordAudio("320302038", var_164_6)
						arg_161_1:RecordAudio("320302038", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_320302", "320302038", "story_v_out_320302.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_320302", "320302038", "story_v_out_320302.awb")
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
	Play320302039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 320302039
		arg_165_1.duration_ = 10.3

		local var_165_0 = {
			zh = 6.966,
			ja = 10.3
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
				arg_165_0:Play320302040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.775

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:GetWordFromCfg(320302039)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 31 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 31)

				if (31 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 31)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302039", "story_v_out_320302.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302039", "story_v_out_320302.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_320302", "320302039", "story_v_out_320302.awb")

						arg_165_1:RecordAudio("320302039", var_168_6)
						arg_165_1:RecordAudio("320302039", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_320302", "320302039", "story_v_out_320302.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_320302", "320302039", "story_v_out_320302.awb")
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
	Play320302040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 320302040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play320302041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.975

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(320302040).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 39 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 39)

				if (39 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 39)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play320302041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 320302041
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play320302042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.15

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(320302041).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 6 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 6)

				if (6 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 6)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play320302042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 320302042
		arg_177_1.duration_ = 5.87

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play320302043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_9000

			if 0.2 < arg_177_1.time_ and arg_177_1.time_ <= 0.2 + arg_180_0 then
				arg_177_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_180_0 = 0.666666666666667

			if 0.2 <= arg_177_1.time_ and arg_177_1.time_ < 0.2 + var_180_0 then
				local var_180_1, var_180_2 = math.modf((arg_177_1.time_ - 0.2) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_180_2 * 0.13, var_180_2 * 0.13, var_180_2 * 0.13) + arg_177_1.var_.shakeOldPos
			end

			if arg_177_1.time_ >= 0.2 + var_180_0 and arg_177_1.time_ < 0.2 + var_180_0 + arg_180_0 then
				manager.ui.mainCamera.transform.localPosition = arg_177_1.var_.shakeOldPos
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				local var_180_3 = arg_177_1.var_.effect8999

				if not arg_177_1.var_.effect8999 then
					var_180_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_180_3.name = "8999"
					arg_177_1.var_.effect8999 = var_180_3
				else
					var_180_3.transform:SetParent(var_180_9000)
				end

				var_180_3.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_180_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.666666666666667 < arg_177_1.time_ and arg_177_1.time_ <= 0.666666666666667 + arg_180_0 then
				if arg_177_1.var_.effect8999 then
					Object.Destroy(arg_177_1.var_.effect8999)

					arg_177_1.var_.effect8999 = nil
				end
			end

			if 0.866666666666667 < arg_177_1.time_ and arg_177_1.time_ <= 0.866666666666667 + arg_180_0 then
				arg_177_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_sword01", "")
			end

			local var_180_7 = 0

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_7 + arg_180_0 then
				arg_177_1.allBtn_.enabled = false
			end

			if arg_177_1.time_ >= var_180_7 + 0.866666666666667 and arg_177_1.time_ < var_180_7 + 0.866666666666667 + arg_180_0 then
				arg_177_1.allBtn_.enabled = true
			end

			if arg_177_1.frameCnt_ <= 1 then
				arg_177_1.dialog_:SetActive(false)
			end

			local var_180_8 = 0.866666666666667
			local var_180_9 = 1.05

			if 0.866666666666667 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				arg_177_1.dialog_:SetActive(true)

				arg_177_1.dialogCg_.alpha = 0

				local var_180_10 = LeanTween.value(arg_177_1.dialog_, 0, 1, 0.3)

				var_180_10:setOnUpdate(LuaHelper.FloatAction(function(arg_181_0)
					arg_177_1.dialogCg_.alpha = arg_181_0
				end))
				var_180_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_177_1.dialog_)
					var_180_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_177_1.duration_ = arg_177_1.duration_ + 0.3

				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_11 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(320302042).content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 42 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 42)

				if (42 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 42)) > 0 and var_180_9 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13
					var_180_8 = var_180_8 + 0.3

					if var_180_13 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_14 = var_180_8 + 0.3
			local var_180_15 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 + 0.3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_14 + var_180_15 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_14) / var_180_15

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_14 + var_180_15 and arg_177_1.time_ < var_180_14 + var_180_15 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play320302043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 320302043
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play320302044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.225

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
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

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(320302043).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 9 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 9)

				if (9 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 9)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play320302044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 320302044
		arg_187_1.duration_ = 7.57

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play320302045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if arg_187_1.bgs_.XS0203a == nil then
				local var_190_0 = Object.Instantiate(arg_187_1.paintGo_)

				var_190_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XS0203a")
				var_190_0.name = "XS0203a"
				var_190_0.transform.parent = arg_187_1.stage_.transform
				var_190_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_187_1.bgs_.XS0203a = var_190_0
			end

			if 1 < arg_187_1.time_ and arg_187_1.time_ <= 1 + arg_190_0 then
				local var_190_1 = arg_187_1.bgs_.XS0203a

				arg_187_1.bgs_.XS0203a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_190_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_2 = var_190_1:GetComponent("SpriteRenderer")

				if var_190_2 and var_190_2.sprite then
					local var_190_3 = 2 * (var_190_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_190_1.transform.localScale = Vector3.New(var_190_3 / var_190_2.sprite.bounds.size.y < var_190_3 * manager.ui.mainCameraCom_.aspect / var_190_2.sprite.bounds.size.x and var_190_3 * manager.ui.mainCameraCom_.aspect / var_190_2.sprite.bounds.size.x or var_190_3 / var_190_2.sprite.bounds.size.y, var_190_3 / var_190_2.sprite.bounds.size.y < var_190_3 * manager.ui.mainCameraCom_.aspect / var_190_2.sprite.bounds.size.x and var_190_3 * manager.ui.mainCameraCom_.aspect / var_190_2.sprite.bounds.size.x or var_190_3 / var_190_2.sprite.bounds.size.y, 0)
				end

				for iter_190_0, iter_190_1 in pairs(arg_187_1.bgs_) do
					if iter_190_0 ~= "XS0203a" then
						iter_190_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_190_4 = 0

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			if arg_187_1.time_ >= var_190_4 + 0.3 and arg_187_1.time_ < var_190_4 + 0.3 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			local var_190_5 = 0

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_6 = 1

			if var_190_5 <= arg_187_1.time_ and arg_187_1.time_ < var_190_5 + var_190_6 then
				local var_190_7 = Color.New(0, 0, 0)

				var_190_7.a = Mathf.Lerp(0, 1, (arg_187_1.time_ - var_190_5) / var_190_6)
				arg_187_1.mask_.color = var_190_7
			end

			if arg_187_1.time_ >= var_190_5 + var_190_6 and arg_187_1.time_ < var_190_5 + var_190_6 + arg_190_0 then
				local var_190_8 = Color.New(0, 0, 0)

				var_190_8.a = 1
				arg_187_1.mask_.color = var_190_8
			end

			local var_190_9 = 1

			if 1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_9 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_10 = 2.13333333333333

			if var_190_9 <= arg_187_1.time_ and arg_187_1.time_ < var_190_9 + var_190_10 then
				local var_190_11 = Color.New(0, 0, 0)

				var_190_11.a = Mathf.Lerp(1, 0, (arg_187_1.time_ - var_190_9) / var_190_10)
				arg_187_1.mask_.color = var_190_11
			end

			if arg_187_1.time_ >= var_190_9 + var_190_10 and arg_187_1.time_ < var_190_9 + var_190_10 + arg_190_0 then
				local var_190_12 = Color.New(0, 0, 0)

				arg_187_1.mask_.enabled = false
				var_190_12.a = 0
				arg_187_1.mask_.color = var_190_12
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_13 = 2.56666666666667
			local var_190_14 = 1.6

			if 2.56666666666667 < arg_187_1.time_ and arg_187_1.time_ <= var_190_13 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_15 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_15:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_16 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(320302044).content)

				arg_187_1.text_.text = var_190_16

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_18 = 64 <= 0 and var_190_14 or var_190_14 * (utf8.len(var_190_16) / 64)

				if (64 <= 0 and var_190_14 or var_190_14 * (utf8.len(var_190_16) / 64)) > 0 and var_190_14 < var_190_18 then
					arg_187_1.talkMaxDuration = var_190_18
					var_190_13 = var_190_13 + 0.3

					if var_190_18 + var_190_13 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_18 + var_190_13
					end
				end

				arg_187_1.text_.text = var_190_16
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_19 = var_190_13 + 0.3
			local var_190_20 = math.max(var_190_14, arg_187_1.talkMaxDuration)

			if var_190_13 + 0.3 <= arg_187_1.time_ and arg_187_1.time_ < var_190_19 + var_190_20 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_19) / var_190_20

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_19 + var_190_20 and arg_187_1.time_ < var_190_19 + var_190_20 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play320302045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 320302045
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play320302046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 1.275

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(320302045).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 51 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 51)

				if (51 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 51)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play320302046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 320302046
		arg_197_1.duration_ = 4

		local var_197_0 = {
			zh = 2.266,
			ja = 4
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
				arg_197_0:Play320302047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.325

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(320302046)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 13 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 13)

				if (13 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 13)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302046", "story_v_out_320302.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302046", "story_v_out_320302.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_320302", "320302046", "story_v_out_320302.awb")

						arg_197_1:RecordAudio("320302046", var_200_6)
						arg_197_1:RecordAudio("320302046", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_320302", "320302046", "story_v_out_320302.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_320302", "320302046", "story_v_out_320302.awb")
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
	Play320302047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 320302047
		arg_201_1.duration_ = 6.87

		local var_201_0 = {
			zh = 3.866,
			ja = 6.866
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
				arg_201_0:Play320302048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.425

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(320302047)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 17 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 17)

				if (17 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 17)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302047", "story_v_out_320302.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302047", "story_v_out_320302.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_320302", "320302047", "story_v_out_320302.awb")

						arg_201_1:RecordAudio("320302047", var_204_6)
						arg_201_1:RecordAudio("320302047", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_320302", "320302047", "story_v_out_320302.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_320302", "320302047", "story_v_out_320302.awb")
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
	Play320302048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 320302048
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play320302049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1.2

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(320302048).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 48 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 48)

				if (48 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 48)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play320302049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 320302049
		arg_209_1.duration_ = 7.47

		local var_209_0 = {
			zh = 4.166,
			ja = 7.466
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
				arg_209_0:Play320302050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.4

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:GetWordFromCfg(320302049)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 16 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 16)

				if (16 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 16)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302049", "story_v_out_320302.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302049", "story_v_out_320302.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_out_320302", "320302049", "story_v_out_320302.awb")

						arg_209_1:RecordAudio("320302049", var_212_6)
						arg_209_1:RecordAudio("320302049", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_320302", "320302049", "story_v_out_320302.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_320302", "320302049", "story_v_out_320302.awb")
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
	Play320302050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 320302050
		arg_213_1.duration_ = 3.83

		local var_213_0 = {
			zh = 1.966,
			ja = 3.833
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
				arg_213_0:Play320302051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.25

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(320302050)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 10 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 10)

				if (10 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 10)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302050", "story_v_out_320302.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302050", "story_v_out_320302.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_320302", "320302050", "story_v_out_320302.awb")

						arg_213_1:RecordAudio("320302050", var_216_6)
						arg_213_1:RecordAudio("320302050", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_320302", "320302050", "story_v_out_320302.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_320302", "320302050", "story_v_out_320302.awb")
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
	Play320302051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 320302051
		arg_217_1.duration_ = 3.47

		local var_217_0 = {
			zh = 2.066,
			ja = 3.466
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
				arg_217_0:Play320302052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.225

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(320302051)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 9 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 9)

				if (9 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 9)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302051", "story_v_out_320302.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302051", "story_v_out_320302.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_320302", "320302051", "story_v_out_320302.awb")

						arg_217_1:RecordAudio("320302051", var_220_6)
						arg_217_1:RecordAudio("320302051", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_320302", "320302051", "story_v_out_320302.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_320302", "320302051", "story_v_out_320302.awb")
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
	Play320302052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 320302052
		arg_221_1.duration_ = 2.77

		local var_221_0 = {
			zh = 1.53266666666667,
			ja = 2.76666666666667
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
				arg_221_0:Play320302053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_0 = 0.366666666666667
			local var_224_1 = 0.125

			if 0.366666666666667 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_2 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_2:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:GetWordFromCfg(320302052)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_6 = 5 <= 0 and var_224_1 or var_224_1 * (utf8.len(var_224_4) / 5)

				if (5 <= 0 and var_224_1 or var_224_1 * (utf8.len(var_224_4) / 5)) > 0 and var_224_1 < var_224_6 then
					arg_221_1.talkMaxDuration = var_224_6
					var_224_0 = var_224_0 + 0.3

					if var_224_6 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302052", "story_v_out_320302.awb") ~= 0 then
					local var_224_7 = manager.audio:GetVoiceLength("story_v_out_320302", "320302052", "story_v_out_320302.awb") / 1000

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_320302", "320302052", "story_v_out_320302.awb")

						arg_221_1:RecordAudio("320302052", var_224_8)
						arg_221_1:RecordAudio("320302052", var_224_8)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_320302", "320302052", "story_v_out_320302.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_320302", "320302052", "story_v_out_320302.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_9 = var_224_0 + 0.3
			local var_224_10 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 + 0.3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_9 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_9) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_9 + var_224_10 and arg_221_1.time_ < var_224_9 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play320302053 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 320302053
		arg_227_1.duration_ = 7.43

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play320302054(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 1.06666666666667 < arg_227_1.time_ and arg_227_1.time_ <= 1.06666666666667 + arg_230_0 then
				local var_230_0 = arg_227_1.bgs_.L05g

				arg_227_1.bgs_.L05g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_230_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_230_1 = var_230_0:GetComponent("SpriteRenderer")

				if var_230_1 and var_230_1.sprite then
					local var_230_2 = 2 * (var_230_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_230_0.transform.localScale = Vector3.New(var_230_2 / var_230_1.sprite.bounds.size.y < var_230_2 * manager.ui.mainCameraCom_.aspect / var_230_1.sprite.bounds.size.x and var_230_2 * manager.ui.mainCameraCom_.aspect / var_230_1.sprite.bounds.size.x or var_230_2 / var_230_1.sprite.bounds.size.y, var_230_2 / var_230_1.sprite.bounds.size.y < var_230_2 * manager.ui.mainCameraCom_.aspect / var_230_1.sprite.bounds.size.x and var_230_2 * manager.ui.mainCameraCom_.aspect / var_230_1.sprite.bounds.size.x or var_230_2 / var_230_1.sprite.bounds.size.y, 0)
				end

				for iter_230_0, iter_230_1 in pairs(arg_227_1.bgs_) do
					if iter_230_0 ~= "L05g" then
						iter_230_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_230_3 = 0

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_3 + arg_230_0 then
				arg_227_1.allBtn_.enabled = false
			end

			if arg_227_1.time_ >= var_230_3 + 0.3 and arg_227_1.time_ < var_230_3 + 0.3 + arg_230_0 then
				arg_227_1.allBtn_.enabled = true
			end

			local var_230_4 = 0

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_5 = 1.06666666666667

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_5 then
				local var_230_6 = Color.New(0, 0, 0)

				var_230_6.a = Mathf.Lerp(0, 1, (arg_227_1.time_ - var_230_4) / var_230_5)
				arg_227_1.mask_.color = var_230_6
			end

			if arg_227_1.time_ >= var_230_4 + var_230_5 and arg_227_1.time_ < var_230_4 + var_230_5 + arg_230_0 then
				local var_230_7 = Color.New(0, 0, 0)

				var_230_7.a = 1
				arg_227_1.mask_.color = var_230_7
			end

			local var_230_8 = 1.06666666666667

			if 1.06666666666667 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_9 = 2

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_9 then
				local var_230_10 = Color.New(0, 0, 0)

				var_230_10.a = Mathf.Lerp(1, 0, (arg_227_1.time_ - var_230_8) / var_230_9)
				arg_227_1.mask_.color = var_230_10
			end

			if arg_227_1.time_ >= var_230_8 + var_230_9 and arg_227_1.time_ < var_230_8 + var_230_9 + arg_230_0 then
				local var_230_11 = Color.New(0, 0, 0)

				arg_227_1.mask_.enabled = false
				var_230_11.a = 0
				arg_227_1.mask_.color = var_230_11
			end

			if arg_227_1.frameCnt_ <= 1 then
				arg_227_1.dialog_:SetActive(false)
			end

			local var_230_12 = 2.43333333333333
			local var_230_13 = 1.675

			if 2.43333333333333 < arg_227_1.time_ and arg_227_1.time_ <= var_230_12 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				arg_227_1.dialog_:SetActive(true)

				arg_227_1.dialogCg_.alpha = 0

				local var_230_14 = LeanTween.value(arg_227_1.dialog_, 0, 1, 0.3)

				var_230_14:setOnUpdate(LuaHelper.FloatAction(function(arg_231_0)
					arg_227_1.dialogCg_.alpha = arg_231_0
				end))
				var_230_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_227_1.dialog_)
					var_230_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_227_1.duration_ = arg_227_1.duration_ + 0.3

				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_15 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(320302053).content)

				arg_227_1.text_.text = var_230_15

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_17 = 67 <= 0 and var_230_13 or var_230_13 * (utf8.len(var_230_15) / 67)

				if (67 <= 0 and var_230_13 or var_230_13 * (utf8.len(var_230_15) / 67)) > 0 and var_230_13 < var_230_17 then
					arg_227_1.talkMaxDuration = var_230_17
					var_230_12 = var_230_12 + 0.3

					if var_230_17 + var_230_12 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_17 + var_230_12
					end
				end

				arg_227_1.text_.text = var_230_15
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_18 = var_230_12 + 0.3
			local var_230_19 = math.max(var_230_13, arg_227_1.talkMaxDuration)

			if var_230_12 + 0.3 <= arg_227_1.time_ and arg_227_1.time_ < var_230_18 + var_230_19 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_18) / var_230_19

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_18 + var_230_19 and arg_227_1.time_ < var_230_18 + var_230_19 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play320302054 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 320302054
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play320302055(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 1.25

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

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(320302054).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 50 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 50)

				if (50 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 50)) > 0 and var_236_0 < var_236_3 then
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
	Play320302055 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 320302055
		arg_237_1.duration_ = 5.97

		local var_237_0 = {
			zh = 3.9,
			ja = 5.966
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play320302056(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.2

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1067].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4043")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_1 = arg_237_1:GetWordFromCfg(320302055)
				local var_240_2 = arg_237_1:FormatText(var_240_1.content)

				arg_237_1.text_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 8 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 8)

				if (8 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 8)) > 0 and var_240_0 < var_240_4 then
					arg_237_1.talkMaxDuration = var_240_4

					if var_240_4 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_4 + 0
					end
				end

				arg_237_1.text_.text = var_240_2
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302055", "story_v_out_320302.awb") ~= 0 then
					local var_240_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302055", "story_v_out_320302.awb") / 1000

					if var_240_5 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + 0
					end

					if var_240_1.prefab_name ~= "" and arg_237_1.actors_[var_240_1.prefab_name] ~= nil then
						local var_240_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_1.prefab_name].transform, "story_v_out_320302", "320302055", "story_v_out_320302.awb")

						arg_237_1:RecordAudio("320302055", var_240_6)
						arg_237_1:RecordAudio("320302055", var_240_6)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_320302", "320302055", "story_v_out_320302.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_320302", "320302055", "story_v_out_320302.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play320302056 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 320302056
		arg_241_1.duration_ = 2.1

		local var_241_0 = {
			zh = 1.566,
			ja = 2.1
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play320302057(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.175

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_1 = arg_241_1:GetWordFromCfg(320302056)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 7 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 7)

				if (7 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 7)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302056", "story_v_out_320302.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302056", "story_v_out_320302.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_320302", "320302056", "story_v_out_320302.awb")

						arg_241_1:RecordAudio("320302056", var_244_6)
						arg_241_1:RecordAudio("320302056", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_320302", "320302056", "story_v_out_320302.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_320302", "320302056", "story_v_out_320302.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play320302057 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 320302057
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play320302058(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.8

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(320302057).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 32 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 32)

				if (32 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 32)) > 0 and var_248_0 < var_248_3 then
					arg_245_1.talkMaxDuration = var_248_3

					if var_248_3 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_3 + 0
					end
				end

				arg_245_1.text_.text = var_248_1
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_4 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_4

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play320302058 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 320302058
		arg_249_1.duration_ = 5.83

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play320302059(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_9000

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				local var_252_0 = arg_249_1.var_.effect222888

				if not arg_249_1.var_.effect222888 then
					var_252_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in_ui"), manager.ui.mainCamera.transform)
					var_252_0.name = "888"
					arg_249_1.var_.effect222888 = var_252_0
				else
					var_252_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_252_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_252_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_252_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_252_3 = var_252_0.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_252_0, iter_252_1 in ipairs((var_252_3:ToTable())) do
					iter_252_1.transform.localScale = Vector3.New(iter_252_1.transform.localScale.x / var_252_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_252_3 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_252_1.transform.localScale.y / var_252_2, iter_252_1.transform.localScale.z)
				end
			end

			local var_252_5 = 0

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1.mask_.enabled = true
				arg_249_1.mask_.raycastTarget = true

				arg_249_1:SetGaussion(false)
			end

			local var_252_6 = 0.533333333333333

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_6 then
				local var_252_7 = Color.New(0.3962264, 0, 0)

				var_252_7.a = Mathf.Lerp(1, 0, (arg_249_1.time_ - var_252_5) / var_252_6)
				arg_249_1.mask_.color = var_252_7
			end

			if arg_249_1.time_ >= var_252_5 + var_252_6 and arg_249_1.time_ < var_252_5 + var_252_6 + arg_252_0 then
				local var_252_8 = Color.New(0.3962264, 0, 0)

				arg_249_1.mask_.enabled = false
				var_252_8.a = 0
				arg_249_1.mask_.color = var_252_8
			end

			if 0.133333333333333 < arg_249_1.time_ and arg_249_1.time_ <= 0.133333333333333 + arg_252_0 then
				arg_249_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun02", "")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				local var_252_10 = arg_249_1.var_.effect222999

				if not arg_249_1.var_.effect222999 then
					var_252_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), manager.ui.mainCamera.transform)
					var_252_10.name = "999"
					arg_249_1.var_.effect222999 = var_252_10
				else
					var_252_10.transform:SetParent(var_252_9000)
				end

				var_252_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_252_10.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_252_12 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_252_13 = var_252_10.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_252_2, iter_252_3 in ipairs((var_252_13:ToTable())) do
					iter_252_3.transform.localScale = Vector3.New(iter_252_3.transform.localScale.x / var_252_12 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_252_13 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_252_3.transform.localScale.y / var_252_12, iter_252_3.transform.localScale.z)
				end
			end

			if arg_249_1.frameCnt_ <= 1 then
				arg_249_1.dialog_:SetActive(false)
			end

			local var_252_15 = 0.833333333333333
			local var_252_16 = 1.7

			if 0.833333333333333 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0

				arg_249_1.dialog_:SetActive(true)

				arg_249_1.dialogCg_.alpha = 0

				local var_252_17 = LeanTween.value(arg_249_1.dialog_, 0, 1, 0.3)

				var_252_17:setOnUpdate(LuaHelper.FloatAction(function(arg_253_0)
					arg_249_1.dialogCg_.alpha = arg_253_0
				end))
				var_252_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_249_1.dialog_)
					var_252_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_249_1.duration_ = arg_249_1.duration_ + 0.3

				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_18 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(320302058).content)

				arg_249_1.text_.text = var_252_18

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_20 = 68 <= 0 and var_252_16 or var_252_16 * (utf8.len(var_252_18) / 68)

				if (68 <= 0 and var_252_16 or var_252_16 * (utf8.len(var_252_18) / 68)) > 0 and var_252_16 < var_252_20 then
					arg_249_1.talkMaxDuration = var_252_20
					var_252_15 = var_252_15 + 0.3

					if var_252_20 + var_252_15 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_20 + var_252_15
					end
				end

				arg_249_1.text_.text = var_252_18
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_21 = var_252_15 + 0.3
			local var_252_22 = math.max(var_252_16, arg_249_1.talkMaxDuration)

			if var_252_15 + 0.3 <= arg_249_1.time_ and arg_249_1.time_ < var_252_21 + var_252_22 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_21) / var_252_22

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_21 + var_252_22 and arg_249_1.time_ < var_252_21 + var_252_22 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play320302059 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 320302059
		arg_255_1.duration_ = 6.87

		local var_255_0 = {
			zh = 6.866,
			ja = 4.233
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
				arg_255_0:Play320302060(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.35

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:GetWordFromCfg(320302059)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 14 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 14)

				if (14 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 14)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302059", "story_v_out_320302.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302059", "story_v_out_320302.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_320302", "320302059", "story_v_out_320302.awb")

						arg_255_1:RecordAudio("320302059", var_258_6)
						arg_255_1:RecordAudio("320302059", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_320302", "320302059", "story_v_out_320302.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_320302", "320302059", "story_v_out_320302.awb")
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
	Play320302060 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 320302060
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play320302061(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_9000

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				local var_262_0 = arg_259_1.var_.effect2221001

				if not arg_259_1.var_.effect2221001 then
					var_262_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in_1"), manager.ui.mainCamera.transform)
					var_262_0.name = "1001"
					arg_259_1.var_.effect2221001 = var_262_0
				else
					var_262_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_262_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_262_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_262_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_262_3 = var_262_0.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_262_0, iter_262_1 in ipairs((var_262_3:ToTable())) do
					iter_262_1.transform.localScale = Vector3.New(iter_262_1.transform.localScale.x / var_262_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_262_3 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_262_1.transform.localScale.y / var_262_2, iter_262_1.transform.localScale.z)
				end
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				local var_262_5 = arg_259_1.var_.effect2221002

				if not arg_259_1.var_.effect2221002 then
					var_262_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in_ui_1"), manager.ui.mainCamera.transform)
					var_262_5.name = "1002"
					arg_259_1.var_.effect2221002 = var_262_5
				else
					var_262_5.transform:SetParent(var_262_9000)
				end

				var_262_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_262_5.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_262_7 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_262_8 = var_262_5.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_262_2, iter_262_3 in ipairs((var_262_8:ToTable())) do
					iter_262_3.transform.localScale = Vector3.New(iter_262_3.transform.localScale.x / var_262_7 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_262_8 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_262_3.transform.localScale.y / var_262_7, iter_262_3.transform.localScale.z)
				end
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				if arg_259_1.var_.effect222888 then
					Object.Destroy(arg_259_1.var_.effect222888)

					arg_259_1.var_.effect222888 = nil
				end
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				if arg_259_1.var_.effect222999 then
					Object.Destroy(arg_259_1.var_.effect222999)

					arg_259_1.var_.effect222999 = nil
				end
			end

			local var_262_12 = 0
			local var_262_13 = 0.675

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_12 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_14 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(320302060).content)

				arg_259_1.text_.text = var_262_14

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_16 = 27 <= 0 and var_262_13 or var_262_13 * (utf8.len(var_262_14) / 27)

				if (27 <= 0 and var_262_13 or var_262_13 * (utf8.len(var_262_14) / 27)) > 0 and var_262_13 < var_262_16 then
					arg_259_1.talkMaxDuration = var_262_16

					if var_262_16 + var_262_12 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_16 + var_262_12
					end
				end

				arg_259_1.text_.text = var_262_14
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_17 = math.max(var_262_13, arg_259_1.talkMaxDuration)

			if var_262_12 <= arg_259_1.time_ and arg_259_1.time_ < var_262_12 + var_262_17 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_12) / var_262_17

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_12 + var_262_17 and arg_259_1.time_ < var_262_12 + var_262_17 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play320302061 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 320302061
		arg_263_1.duration_ = 3.87

		local var_263_0 = {
			zh = 1.999999999999,
			ja = 3.866
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
				arg_263_0:Play320302062(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1156ui_story = arg_263_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1156ui_story"].transform.position).z)
				arg_263_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1156ui_story"].transform.localEulerAngles = arg_263_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.18)
				arg_263_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1156ui_story"].transform.position).z)
				arg_263_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1156ui_story"].transform.localEulerAngles = arg_263_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1156ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1156ui_story == nil then
				arg_263_1.var_.characterEffect1156ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1156ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1156ui_story then
				arg_263_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_266_4 = 0
			local var_266_5 = 0.2

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_6 = arg_263_1:GetWordFromCfg(320302061)
				local var_266_7 = arg_263_1:FormatText(var_266_6.content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 8 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 8)

				if (8 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 8)) > 0 and var_266_5 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302061", "story_v_out_320302.awb") ~= 0 then
					local var_266_10 = manager.audio:GetVoiceLength("story_v_out_320302", "320302061", "story_v_out_320302.awb") / 1000

					if var_266_10 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_4
					end

					if var_266_6.prefab_name ~= "" and arg_263_1.actors_[var_266_6.prefab_name] ~= nil then
						local var_266_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_6.prefab_name].transform, "story_v_out_320302", "320302061", "story_v_out_320302.awb")

						arg_263_1:RecordAudio("320302061", var_266_11)
						arg_263_1:RecordAudio("320302061", var_266_11)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_320302", "320302061", "story_v_out_320302.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_320302", "320302061", "story_v_out_320302.awb")
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
				actorName = "1156ui_story",
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
	Play320302062 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 320302062
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play320302063(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1156ui_story = arg_267_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1156ui_story"].transform.position).z)
				arg_267_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1156ui_story"].transform.localEulerAngles = arg_267_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1156ui_story"].transform.position).z)
				arg_267_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1156ui_story"].transform.localEulerAngles = arg_267_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_270_1 = arg_267_1.actors_["1156ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1156ui_story == nil then
				arg_267_1.var_.characterEffect1156ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect1156ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_2)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1156ui_story then
				arg_267_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_270_3 = 0
			local var_270_4 = 0.6

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_3 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_5 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(320302062).content)

				arg_267_1.text_.text = var_270_5

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_7 = 24 <= 0 and var_270_4 or var_270_4 * (utf8.len(var_270_5) / 24)

				if (24 <= 0 and var_270_4 or var_270_4 * (utf8.len(var_270_5) / 24)) > 0 and var_270_4 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_3 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_3
					end
				end

				arg_267_1.text_.text = var_270_5
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_8 = math.max(var_270_4, arg_267_1.talkMaxDuration)

			if var_270_3 <= arg_267_1.time_ and arg_267_1.time_ < var_270_3 + var_270_8 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_3) / var_270_8

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_3 + var_270_8 and arg_267_1.time_ < var_270_3 + var_270_8 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play320302063 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 320302063
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play320302064(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 1.275

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(320302063).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 51 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 51)

				if (51 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 51)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play320302064 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 320302064
		arg_275_1.duration_ = 8.27

		local var_275_0 = {
			zh = 7.166,
			ja = 8.266
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
				arg_275_0:Play320302065(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.3

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[1067].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4043")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_1 = arg_275_1:GetWordFromCfg(320302064)
				local var_278_2 = arg_275_1:FormatText(var_278_1.content)

				arg_275_1.text_.text = var_278_2

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 12 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 12)

				if (12 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 12)) > 0 and var_278_0 < var_278_4 then
					arg_275_1.talkMaxDuration = var_278_4

					if var_278_4 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_4 + 0
					end
				end

				arg_275_1.text_.text = var_278_2
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302064", "story_v_out_320302.awb") ~= 0 then
					local var_278_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302064", "story_v_out_320302.awb") / 1000

					if var_278_5 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + 0
					end

					if var_278_1.prefab_name ~= "" and arg_275_1.actors_[var_278_1.prefab_name] ~= nil then
						local var_278_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_1.prefab_name].transform, "story_v_out_320302", "320302064", "story_v_out_320302.awb")

						arg_275_1:RecordAudio("320302064", var_278_6)
						arg_275_1:RecordAudio("320302064", var_278_6)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_320302", "320302064", "story_v_out_320302.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_320302", "320302064", "story_v_out_320302.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play320302065 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 320302065
		arg_279_1.duration_ = 6.17

		local var_279_0 = {
			zh = 2.233,
			ja = 6.166
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
				arg_279_0:Play320302066(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.275

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_1 = arg_279_1:GetWordFromCfg(320302065)
				local var_282_2 = arg_279_1:FormatText(var_282_1.content)

				arg_279_1.text_.text = var_282_2

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 11 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 11)

				if (11 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 11)) > 0 and var_282_0 < var_282_4 then
					arg_279_1.talkMaxDuration = var_282_4

					if var_282_4 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_4 + 0
					end
				end

				arg_279_1.text_.text = var_282_2
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302065", "story_v_out_320302.awb") ~= 0 then
					local var_282_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302065", "story_v_out_320302.awb") / 1000

					if var_282_5 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + 0
					end

					if var_282_1.prefab_name ~= "" and arg_279_1.actors_[var_282_1.prefab_name] ~= nil then
						local var_282_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_1.prefab_name].transform, "story_v_out_320302", "320302065", "story_v_out_320302.awb")

						arg_279_1:RecordAudio("320302065", var_282_6)
						arg_279_1:RecordAudio("320302065", var_282_6)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_320302", "320302065", "story_v_out_320302.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_320302", "320302065", "story_v_out_320302.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_7 and arg_279_1.time_ < 0 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play320302066 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 320302066
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play320302067(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 1.525

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(320302066).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 61 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 61)

				if (61 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 61)) > 0 and var_286_0 < var_286_3 then
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
	Play320302067 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 320302067
		arg_287_1.duration_ = 6

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play320302068(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0.166666666666667 < arg_287_1.time_ and arg_287_1.time_ <= 0.166666666666667 + arg_290_0 then
				arg_287_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_290_0 = 0.966666666666667

			if 0.166666666666667 <= arg_287_1.time_ and arg_287_1.time_ < 0.166666666666667 + var_290_0 then
				local var_290_1, var_290_2 = math.modf((arg_287_1.time_ - 0.166666666666667) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_290_2 * 0.13, var_290_2 * 0.13, var_290_2 * 0.13) + arg_287_1.var_.shakeOldPos
			end

			if arg_287_1.time_ >= 0.166666666666667 + var_290_0 and arg_287_1.time_ < 0.166666666666667 + var_290_0 + arg_290_0 then
				manager.ui.mainCamera.transform.localPosition = arg_287_1.var_.shakeOldPos
			end

			local var_290_3 = 0

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_3 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_4 = 0.633333333333333

			if var_290_3 <= arg_287_1.time_ and arg_287_1.time_ < var_290_3 + var_290_4 then
				local var_290_5 = Color.New(1, 1, 1)

				var_290_5.a = Mathf.Lerp(1, 0, (arg_287_1.time_ - var_290_3) / var_290_4)
				arg_287_1.mask_.color = var_290_5
			end

			if arg_287_1.time_ >= var_290_3 + var_290_4 and arg_287_1.time_ < var_290_3 + var_290_4 + arg_290_0 then
				local var_290_6 = Color.New(1, 1, 1)

				arg_287_1.mask_.enabled = false
				var_290_6.a = 0
				arg_287_1.mask_.color = var_290_6
			end

			if 0.333333333333333 < arg_287_1.time_ and arg_287_1.time_ <= 0.333333333333333 + arg_290_0 then
				arg_287_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_290_8 = 0

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_8 + arg_290_0 then
				arg_287_1.allBtn_.enabled = false
			end

			if arg_287_1.time_ >= var_290_8 + 1 and arg_287_1.time_ < var_290_8 + 1 + arg_290_0 then
				arg_287_1.allBtn_.enabled = true
			end

			if arg_287_1.frameCnt_ <= 1 then
				arg_287_1.dialog_:SetActive(false)
			end

			local var_290_9 = 1
			local var_290_10 = 0.925

			if 1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0

				arg_287_1.dialog_:SetActive(true)

				arg_287_1.dialogCg_.alpha = 0

				local var_290_11 = LeanTween.value(arg_287_1.dialog_, 0, 1, 0.3)

				var_290_11:setOnUpdate(LuaHelper.FloatAction(function(arg_291_0)
					arg_287_1.dialogCg_.alpha = arg_291_0
				end))
				var_290_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_287_1.dialog_)
					var_290_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_287_1.duration_ = arg_287_1.duration_ + 0.3

				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_12 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(320302067).content)

				arg_287_1.text_.text = var_290_12

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_14 = 37 <= 0 and var_290_10 or var_290_10 * (utf8.len(var_290_12) / 37)

				if (37 <= 0 and var_290_10 or var_290_10 * (utf8.len(var_290_12) / 37)) > 0 and var_290_10 < var_290_14 then
					arg_287_1.talkMaxDuration = var_290_14
					var_290_9 = var_290_9 + 0.3

					if var_290_14 + var_290_9 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_14 + var_290_9
					end
				end

				arg_287_1.text_.text = var_290_12
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_15 = var_290_9 + 0.3
			local var_290_16 = math.max(var_290_10, arg_287_1.talkMaxDuration)

			if var_290_9 + 0.3 <= arg_287_1.time_ and arg_287_1.time_ < var_290_15 + var_290_16 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_15) / var_290_16

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_15 + var_290_16 and arg_287_1.time_ < var_290_15 + var_290_16 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play320302068 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 320302068
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play320302069(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 1

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(320302068).content)

				arg_293_1.text_.text = var_296_1

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_3 = 40 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 40)

				if (40 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 40)) > 0 and var_296_0 < var_296_3 then
					arg_293_1.talkMaxDuration = var_296_3

					if var_296_3 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_3 + 0
					end
				end

				arg_293_1.text_.text = var_296_1
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_4 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_4

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play320302069 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 320302069
		arg_297_1.duration_ = 8.23

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play320302070(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if arg_297_1.bgs_.L05f == nil then
				local var_300_0 = Object.Instantiate(arg_297_1.paintGo_)

				var_300_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L05f")
				var_300_0.name = "L05f"
				var_300_0.transform.parent = arg_297_1.stage_.transform
				var_300_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.bgs_.L05f = var_300_0
			end

			if 1.6 < arg_297_1.time_ and arg_297_1.time_ <= 1.6 + arg_300_0 then
				local var_300_1 = arg_297_1.bgs_.L05f

				arg_297_1.bgs_.L05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_300_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_300_2 = var_300_1:GetComponent("SpriteRenderer")

				if var_300_2 and var_300_2.sprite then
					local var_300_3 = 2 * (var_300_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_300_1.transform.localScale = Vector3.New(var_300_3 / var_300_2.sprite.bounds.size.y < var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x and var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x or var_300_3 / var_300_2.sprite.bounds.size.y, var_300_3 / var_300_2.sprite.bounds.size.y < var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x and var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x or var_300_3 / var_300_2.sprite.bounds.size.y, 0)
				end

				for iter_300_0, iter_300_1 in pairs(arg_297_1.bgs_) do
					if iter_300_0 ~= "L05f" then
						iter_300_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_300_4 = 0

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.allBtn_.enabled = false
			end

			if arg_297_1.time_ >= var_300_4 + 0.3 and arg_297_1.time_ < var_300_4 + 0.3 + arg_300_0 then
				arg_297_1.allBtn_.enabled = true
			end

			local var_300_5 = 0

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_6 = 1.6

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_6 then
				local var_300_7 = Color.New(0, 0, 0)

				var_300_7.a = Mathf.Lerp(0, 1, (arg_297_1.time_ - var_300_5) / var_300_6)
				arg_297_1.mask_.color = var_300_7
			end

			if arg_297_1.time_ >= var_300_5 + var_300_6 and arg_297_1.time_ < var_300_5 + var_300_6 + arg_300_0 then
				local var_300_8 = Color.New(0, 0, 0)

				var_300_8.a = 1
				arg_297_1.mask_.color = var_300_8
			end

			local var_300_9 = 1.6

			if 1.6 < arg_297_1.time_ and arg_297_1.time_ <= var_300_9 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_10 = 1.9

			if var_300_9 <= arg_297_1.time_ and arg_297_1.time_ < var_300_9 + var_300_10 then
				local var_300_11 = Color.New(0, 0, 0)

				var_300_11.a = Mathf.Lerp(1, 0, (arg_297_1.time_ - var_300_9) / var_300_10)
				arg_297_1.mask_.color = var_300_11
			end

			if arg_297_1.time_ >= var_300_9 + var_300_10 and arg_297_1.time_ < var_300_9 + var_300_10 + arg_300_0 then
				local var_300_12 = Color.New(0, 0, 0)

				arg_297_1.mask_.enabled = false
				var_300_12.a = 0
				arg_297_1.mask_.color = var_300_12
			end

			if arg_297_1.frameCnt_ <= 1 then
				arg_297_1.dialog_:SetActive(false)
			end

			local var_300_13 = 3.23333333333333
			local var_300_14 = 1

			if 3.23333333333333 < arg_297_1.time_ and arg_297_1.time_ <= var_300_13 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				arg_297_1.dialog_:SetActive(true)

				arg_297_1.dialogCg_.alpha = 0

				local var_300_15 = LeanTween.value(arg_297_1.dialog_, 0, 1, 0.3)

				var_300_15:setOnUpdate(LuaHelper.FloatAction(function(arg_301_0)
					arg_297_1.dialogCg_.alpha = arg_301_0
				end))
				var_300_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_297_1.dialog_)
					var_300_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_297_1.duration_ = arg_297_1.duration_ + 0.3

				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_16 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(320302069).content)

				arg_297_1.text_.text = var_300_16

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_18 = 40 <= 0 and var_300_14 or var_300_14 * (utf8.len(var_300_16) / 40)

				if (40 <= 0 and var_300_14 or var_300_14 * (utf8.len(var_300_16) / 40)) > 0 and var_300_14 < var_300_18 then
					arg_297_1.talkMaxDuration = var_300_18
					var_300_13 = var_300_13 + 0.3

					if var_300_18 + var_300_13 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_18 + var_300_13
					end
				end

				arg_297_1.text_.text = var_300_16
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_19 = var_300_13 + 0.3
			local var_300_20 = math.max(var_300_14, arg_297_1.talkMaxDuration)

			if var_300_13 + 0.3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_19 + var_300_20 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_19) / var_300_20

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_19 + var_300_20 and arg_297_1.time_ < var_300_19 + var_300_20 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play320302070 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 320302070
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play320302071(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.275

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
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

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(320302070).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 11 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 11)

				if (11 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 11)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play320302071 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 320302071
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play320302072(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 1.375

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(320302071).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 55 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 55)

				if (55 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 55)) > 0 and var_310_0 < var_310_3 then
					arg_307_1.talkMaxDuration = var_310_3

					if var_310_3 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_3 + 0
					end
				end

				arg_307_1.text_.text = var_310_1
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_4 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_4

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play320302072 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 320302072
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play320302073(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.925

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(320302072).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 37 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 37)

				if (37 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 37)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play320302073 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 320302073
		arg_315_1.duration_ = 10.6

		local var_315_0 = {
			zh = 6.233,
			ja = 10.6
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
				arg_315_0:Play320302074(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.775

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_1 = arg_315_1:GetWordFromCfg(320302073)
				local var_318_2 = arg_315_1:FormatText(var_318_1.content)

				arg_315_1.text_.text = var_318_2

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 31 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 31)

				if (31 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 31)) > 0 and var_318_0 < var_318_4 then
					arg_315_1.talkMaxDuration = var_318_4

					if var_318_4 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_4 + 0
					end
				end

				arg_315_1.text_.text = var_318_2
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302073", "story_v_out_320302.awb") ~= 0 then
					local var_318_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302073", "story_v_out_320302.awb") / 1000

					if var_318_5 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + 0
					end

					if var_318_1.prefab_name ~= "" and arg_315_1.actors_[var_318_1.prefab_name] ~= nil then
						local var_318_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_1.prefab_name].transform, "story_v_out_320302", "320302073", "story_v_out_320302.awb")

						arg_315_1:RecordAudio("320302073", var_318_6)
						arg_315_1:RecordAudio("320302073", var_318_6)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_320302", "320302073", "story_v_out_320302.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_320302", "320302073", "story_v_out_320302.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play320302074 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 320302074
		arg_319_1.duration_ = 12.83

		local var_319_0 = {
			zh = 8.733,
			ja = 12.833
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
				arg_319_0:Play320302075(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 1.075

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_1 = arg_319_1:GetWordFromCfg(320302074)
				local var_322_2 = arg_319_1:FormatText(var_322_1.content)

				arg_319_1.text_.text = var_322_2

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 43 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 43)

				if (43 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 43)) > 0 and var_322_0 < var_322_4 then
					arg_319_1.talkMaxDuration = var_322_4

					if var_322_4 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_4 + 0
					end
				end

				arg_319_1.text_.text = var_322_2
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302074", "story_v_out_320302.awb") ~= 0 then
					local var_322_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302074", "story_v_out_320302.awb") / 1000

					if var_322_5 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + 0
					end

					if var_322_1.prefab_name ~= "" and arg_319_1.actors_[var_322_1.prefab_name] ~= nil then
						local var_322_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_1.prefab_name].transform, "story_v_out_320302", "320302074", "story_v_out_320302.awb")

						arg_319_1:RecordAudio("320302074", var_322_6)
						arg_319_1:RecordAudio("320302074", var_322_6)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_320302", "320302074", "story_v_out_320302.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_320302", "320302074", "story_v_out_320302.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_7 and arg_319_1.time_ < 0 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play320302075 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 320302075
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play320302076(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 1.375

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
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

				local var_326_1 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(320302075).content)

				arg_323_1.text_.text = var_326_1

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_3 = 55 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 55)

				if (55 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 55)) > 0 and var_326_0 < var_326_3 then
					arg_323_1.talkMaxDuration = var_326_3

					if var_326_3 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_3 + 0
					end
				end

				arg_323_1.text_.text = var_326_1
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_4 = math.max(var_326_0, arg_323_1.talkMaxDuration)

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - 0) / var_326_4

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play320302076 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 320302076
		arg_327_1.duration_ = 7

		local var_327_0 = {
			zh = 4.7,
			ja = 7
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
				arg_327_0:Play320302077(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.55

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_1 = arg_327_1:GetWordFromCfg(320302076)
				local var_330_2 = arg_327_1:FormatText(var_330_1.content)

				arg_327_1.text_.text = var_330_2

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 22 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 22)

				if (22 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 22)) > 0 and var_330_0 < var_330_4 then
					arg_327_1.talkMaxDuration = var_330_4

					if var_330_4 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_4 + 0
					end
				end

				arg_327_1.text_.text = var_330_2
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302076", "story_v_out_320302.awb") ~= 0 then
					local var_330_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302076", "story_v_out_320302.awb") / 1000

					if var_330_5 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + 0
					end

					if var_330_1.prefab_name ~= "" and arg_327_1.actors_[var_330_1.prefab_name] ~= nil then
						local var_330_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_1.prefab_name].transform, "story_v_out_320302", "320302076", "story_v_out_320302.awb")

						arg_327_1:RecordAudio("320302076", var_330_6)
						arg_327_1:RecordAudio("320302076", var_330_6)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_320302", "320302076", "story_v_out_320302.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_320302", "320302076", "story_v_out_320302.awb")
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
	Play320302077 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 320302077
		arg_331_1.duration_ = 1.87

		local var_331_0 = {
			zh = 1.533,
			ja = 1.866
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
				arg_331_0:Play320302078(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.15

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_331_1.callingController_:SetSelectedState("calling")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_1 = arg_331_1:GetWordFromCfg(320302077)
				local var_334_2 = arg_331_1:FormatText(var_334_1.content)

				arg_331_1.text_.text = var_334_2

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 6 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 6)

				if (6 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 6)) > 0 and var_334_0 < var_334_4 then
					arg_331_1.talkMaxDuration = var_334_4

					if var_334_4 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_4 + 0
					end
				end

				arg_331_1.text_.text = var_334_2
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302077", "story_v_out_320302.awb") ~= 0 then
					local var_334_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302077", "story_v_out_320302.awb") / 1000

					if var_334_5 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + 0
					end

					if var_334_1.prefab_name ~= "" and arg_331_1.actors_[var_334_1.prefab_name] ~= nil then
						local var_334_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_1.prefab_name].transform, "story_v_out_320302", "320302077", "story_v_out_320302.awb")

						arg_331_1:RecordAudio("320302077", var_334_6)
						arg_331_1:RecordAudio("320302077", var_334_6)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_320302", "320302077", "story_v_out_320302.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_320302", "320302077", "story_v_out_320302.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play320302078 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 320302078
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play320302079(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.525

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_1 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(320302078).content)

				arg_335_1.text_.text = var_338_1

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_3 = 21 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 21)

				if (21 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 21)) > 0 and var_338_0 < var_338_3 then
					arg_335_1.talkMaxDuration = var_338_3

					if var_338_3 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_3 + 0
					end
				end

				arg_335_1.text_.text = var_338_1
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_4 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_4

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play320302079 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 320302079
		arg_339_1.duration_ = 3.43

		local var_339_0 = {
			zh = 2.666,
			ja = 3.433
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
			arg_339_1.auto_ = false
		end

		function arg_339_1.playNext_(arg_341_0)
			arg_339_1.onStoryFinished_()
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.45

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_339_1.callingController_:SetSelectedState("calling")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_1 = arg_339_1:GetWordFromCfg(320302079)
				local var_342_2 = arg_339_1:FormatText(var_342_1.content)

				arg_339_1.text_.text = var_342_2

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 18 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 18)

				if (18 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 18)) > 0 and var_342_0 < var_342_4 then
					arg_339_1.talkMaxDuration = var_342_4

					if var_342_4 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_4 + 0
					end
				end

				arg_339_1.text_.text = var_342_2
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320302", "320302079", "story_v_out_320302.awb") ~= 0 then
					local var_342_5 = manager.audio:GetVoiceLength("story_v_out_320302", "320302079", "story_v_out_320302.awb") / 1000

					if var_342_5 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + 0
					end

					if var_342_1.prefab_name ~= "" and arg_339_1.actors_[var_342_1.prefab_name] ~= nil then
						local var_342_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_1.prefab_name].transform, "story_v_out_320302", "320302079", "story_v_out_320302.awb")

						arg_339_1:RecordAudio("320302079", var_342_6)
						arg_339_1:RecordAudio("320302079", var_342_6)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_320302", "320302079", "story_v_out_320302.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_320302", "320302079", "story_v_out_320302.awb")
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
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L05g",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/ST67",
		"TextureConfig/Background/XS0203a",
		"TextureConfig/Background/L05f"
	},
	voices = {
		"story_v_out_320302.awb"
	}
}
