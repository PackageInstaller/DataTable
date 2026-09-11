return {
	Play320011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320011001
		arg_1_1.duration_ = 106.72

		local var_1_0 = {
			zh = 106.716,
			ja = 105.35
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
				arg_1_0:Play320011002(arg_1_1)
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

			if 101.75 < arg_1_1.time_ and arg_1_1.time_ <= 101.75 + arg_4_0 then
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

			local var_4_4 = 103.749999999999

			if 103.749999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 101.75

			if 101.75 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

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

			if 101.75 < arg_1_1.time_ and arg_1_1.time_ <= 101.75 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_136", "se_story_136_banquet_loop", "")
			end

			local var_4_13 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				SetActive(arg_1_1.dialog_, false)
				SetActive(arg_1_1.allBtn_.gameObject, false)
				arg_1_1.hideBtnsController_:SetSelectedIndex(1)

				arg_1_1.marker = "XSV01"

				manager.video:Play("SofdecAsset/story/story_1032001.usm", function(arg_6_0)
					arg_1_1.time_ = var_4_13 + 101.740000000224

					if arg_1_1.state_ == "pause" then
						arg_1_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_7_0)
					arg_1_1.state_ = arg_7_0 and "pause" or "playing"
				end, 1032001)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_4_14 = 101.75

			if var_4_13 <= arg_1_1.time_ and arg_1_1.time_ < var_4_13 + var_4_14 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_13 + var_4_14 and arg_1_1.time_ < var_4_13 + var_4_14 + arg_4_0 then
				arg_1_1.marker = ""
			end

			local var_4_15 = 101.75

			if 101.75 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				SetActive(arg_1_1.dialog_, true)
				SetActive(arg_1_1.allBtn_.gameObject, true)
				arg_1_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_1_1.isInLoopVideo = false
			end

			local var_4_16 = 2.81666666666666

			if var_4_15 <= arg_1_1.time_ and arg_1_1.time_ < var_4_15 + var_4_16 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_15 + var_4_16 and arg_1_1.time_ < var_4_15 + var_4_16 + arg_4_0 then
				arg_1_1.marker = ""
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_17 = 103.75
			local var_4_18 = 0.1

			if 103.75 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_19 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_19:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_20 = arg_1_1:GetWordFromCfg(320011001)
				local var_4_21 = arg_1_1:FormatText(var_4_20.content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 4 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_21) / 4)

				if (4 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_21) / 4)) > 0 and var_4_18 < var_4_23 then
					arg_1_1.talkMaxDuration = var_4_23
					var_4_17 = var_4_17 + 0.3

					if var_4_23 + var_4_17 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_17
					end
				end

				arg_1_1.text_.text = var_4_21
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011001", "story_v_out_320011.awb") ~= 0 then
					local var_4_24 = manager.audio:GetVoiceLength("story_v_out_320011", "320011001", "story_v_out_320011.awb") / 1000

					if var_4_24 + var_4_17 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_17
					end

					if var_4_20.prefab_name ~= "" and arg_1_1.actors_[var_4_20.prefab_name] ~= nil then
						local var_4_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_20.prefab_name].transform, "story_v_out_320011", "320011001", "story_v_out_320011.awb")

						arg_1_1:RecordAudio("320011001", var_4_25)
						arg_1_1:RecordAudio("320011001", var_4_25)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_320011", "320011001", "story_v_out_320011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_320011", "320011001", "story_v_out_320011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_26 = var_4_17 + 0.3
			local var_4_27 = math.max(var_4_18, arg_1_1.talkMaxDuration)

			if var_4_17 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_26) / var_4_27

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play320011002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 320011002
		arg_10_1.duration_ = 14.5

		local var_10_0 = {
			zh = 10.8,
			ja = 14.5
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play320011003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 1.45

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_1 = arg_10_1:GetWordFromCfg(320011002)
				local var_13_2 = arg_10_1:FormatText(var_13_1.content)

				arg_10_1.text_.text = var_13_2

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_4 = 58 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_2) / 58)

				if (58 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_2) / 58)) > 0 and var_13_0 < var_13_4 then
					arg_10_1.talkMaxDuration = var_13_4

					if var_13_4 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_4 + 0
					end
				end

				arg_10_1.text_.text = var_13_2
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011002", "story_v_out_320011.awb") ~= 0 then
					local var_13_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011002", "story_v_out_320011.awb") / 1000

					if var_13_5 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_5 + 0
					end

					if var_13_1.prefab_name ~= "" and arg_10_1.actors_[var_13_1.prefab_name] ~= nil then
						local var_13_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_1.prefab_name].transform, "story_v_out_320011", "320011002", "story_v_out_320011.awb")

						arg_10_1:RecordAudio("320011002", var_13_6)
						arg_10_1:RecordAudio("320011002", var_13_6)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_320011", "320011002", "story_v_out_320011.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_320011", "320011002", "story_v_out_320011.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_7 = math.max(var_13_0, arg_10_1.talkMaxDuration)

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_7 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - 0) / var_13_7

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= 0 + var_13_7 and arg_10_1.time_ < 0 + var_13_7 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play320011003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 320011003
		arg_14_1.duration_ = 10.33

		local var_14_0 = {
			zh = 9.3,
			ja = 10.333
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play320011004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 1.025

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_1 = arg_14_1:GetWordFromCfg(320011003)
				local var_17_2 = arg_14_1:FormatText(var_17_1.content)

				arg_14_1.text_.text = var_17_2

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_4 = 40 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 40)

				if (40 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 40)) > 0 and var_17_0 < var_17_4 then
					arg_14_1.talkMaxDuration = var_17_4

					if var_17_4 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_4 + 0
					end
				end

				arg_14_1.text_.text = var_17_2
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011003", "story_v_out_320011.awb") ~= 0 then
					local var_17_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011003", "story_v_out_320011.awb") / 1000

					if var_17_5 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_5 + 0
					end

					if var_17_1.prefab_name ~= "" and arg_14_1.actors_[var_17_1.prefab_name] ~= nil then
						local var_17_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_1.prefab_name].transform, "story_v_out_320011", "320011003", "story_v_out_320011.awb")

						arg_14_1:RecordAudio("320011003", var_17_6)
						arg_14_1:RecordAudio("320011003", var_17_6)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_320011", "320011003", "story_v_out_320011.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_320011", "320011003", "story_v_out_320011.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_7 = math.max(var_17_0, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_7 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - 0) / var_17_7

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_7 and arg_14_1.time_ < 0 + var_17_7 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play320011004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 320011004
		arg_18_1.duration_ = 14.87

		local var_18_0 = {
			zh = 14.866,
			ja = 12.1
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
				arg_18_0:Play320011005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 1.875

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_1 = arg_18_1:GetWordFromCfg(320011004)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 75 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 75)

				if (75 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 75)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011004", "story_v_out_320011.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011004", "story_v_out_320011.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_out_320011", "320011004", "story_v_out_320011.awb")

						arg_18_1:RecordAudio("320011004", var_21_6)
						arg_18_1:RecordAudio("320011004", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_320011", "320011004", "story_v_out_320011.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_320011", "320011004", "story_v_out_320011.awb")
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
	Play320011005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 320011005
		arg_22_1.duration_ = 5.5

		local var_22_0 = {
			zh = 5.5,
			ja = 4.166
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
				arg_22_0:Play320011006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.6

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_1 = arg_22_1:GetWordFromCfg(320011005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 24 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 24)

				if (24 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 24)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011005", "story_v_out_320011.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011005", "story_v_out_320011.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_320011", "320011005", "story_v_out_320011.awb")

						arg_22_1:RecordAudio("320011005", var_25_6)
						arg_22_1:RecordAudio("320011005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_320011", "320011005", "story_v_out_320011.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_320011", "320011005", "story_v_out_320011.awb")
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
	Play320011006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 320011006
		arg_26_1.duration_ = 19.6

		local var_26_0 = {
			zh = 10.966,
			ja = 19.6
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
				arg_26_0:Play320011007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 1.525

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_1 = arg_26_1:GetWordFromCfg(320011006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 61 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 61)

				if (61 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 61)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011006", "story_v_out_320011.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011006", "story_v_out_320011.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_320011", "320011006", "story_v_out_320011.awb")

						arg_26_1:RecordAudio("320011006", var_29_6)
						arg_26_1:RecordAudio("320011006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_320011", "320011006", "story_v_out_320011.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_320011", "320011006", "story_v_out_320011.awb")
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
	Play320011007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 320011007
		arg_30_1.duration_ = 11.57

		local var_30_0 = {
			zh = 11.333,
			ja = 11.566
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
				arg_30_0:Play320011008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 1.35

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_1 = arg_30_1:GetWordFromCfg(320011007)
				local var_33_2 = arg_30_1:FormatText(var_33_1.content)

				arg_30_1.text_.text = var_33_2

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 54 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 54)

				if (54 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 54)) > 0 and var_33_0 < var_33_4 then
					arg_30_1.talkMaxDuration = var_33_4

					if var_33_4 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_4 + 0
					end
				end

				arg_30_1.text_.text = var_33_2
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011007", "story_v_out_320011.awb") ~= 0 then
					local var_33_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011007", "story_v_out_320011.awb") / 1000

					if var_33_5 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + 0
					end

					if var_33_1.prefab_name ~= "" and arg_30_1.actors_[var_33_1.prefab_name] ~= nil then
						local var_33_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_1.prefab_name].transform, "story_v_out_320011", "320011007", "story_v_out_320011.awb")

						arg_30_1:RecordAudio("320011007", var_33_6)
						arg_30_1:RecordAudio("320011007", var_33_6)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_320011", "320011007", "story_v_out_320011.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_320011", "320011007", "story_v_out_320011.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_7 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_7 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_7

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_7 and arg_30_1.time_ < 0 + var_33_7 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play320011008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 320011008
		arg_34_1.duration_ = 6.83

		local var_34_0 = {
			zh = 6.199999999999,
			ja = 6.832999999999
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play320011009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if arg_34_1.bgs_.ST0501 == nil then
				local var_37_0 = Object.Instantiate(arg_34_1.paintGo_)

				var_37_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0501")
				var_37_0.name = "ST0501"
				var_37_0.transform.parent = arg_34_1.stage_.transform
				var_37_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.bgs_.ST0501 = var_37_0
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				local var_37_1 = arg_34_1.bgs_.ST0501

				arg_34_1.bgs_.ST0501.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_37_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_37_2 = var_37_1:GetComponent("SpriteRenderer")

				if var_37_2 and var_37_2.sprite then
					local var_37_3 = 2 * (var_37_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_37_1.transform.localScale = Vector3.New(var_37_3 / var_37_2.sprite.bounds.size.y < var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x and var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x or var_37_3 / var_37_2.sprite.bounds.size.y, var_37_3 / var_37_2.sprite.bounds.size.y < var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x and var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x or var_37_3 / var_37_2.sprite.bounds.size.y, 0)
				end

				for iter_37_0, iter_37_1 in pairs(arg_34_1.bgs_) do
					if iter_37_0 ~= "ST0501" then
						iter_37_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_37_4 = 2

			if 2 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.allBtn_.enabled = false
			end

			if arg_34_1.time_ >= var_37_4 + 0.3 and arg_34_1.time_ < var_37_4 + 0.3 + arg_37_0 then
				arg_34_1.allBtn_.enabled = true
			end

			local var_37_5 = 0

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_6 = 2

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_6 then
				local var_37_7 = Color.New(0, 0, 0)

				var_37_7.a = Mathf.Lerp(1, 0, (arg_34_1.time_ - var_37_5) / var_37_6)
				arg_34_1.mask_.color = var_37_7
			end

			if arg_34_1.time_ >= var_37_5 + var_37_6 and arg_34_1.time_ < var_37_5 + var_37_6 + arg_37_0 then
				local var_37_8 = Color.New(0, 0, 0)

				arg_34_1.mask_.enabled = false
				var_37_8.a = 0
				arg_34_1.mask_.color = var_37_8
			end

			if 0.333333333333333 < arg_34_1.time_ and arg_34_1.time_ <= 0.333333333333333 + arg_37_0 then
				arg_34_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_37_11 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_34_1.bgmTxt_.text ~= var_37_11 and arg_34_1.bgmTxt_.text ~= "" then
						if arg_34_1.bgmTxt2_.text ~= "" then
							arg_34_1.bgmTxt_.text = arg_34_1.bgmTxt2_.text
						end

						arg_34_1.bgmTxt2_.text = var_37_11

						arg_34_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_34_1.bgmTxt_.text = var_37_11
						arg_34_1.bgmTxt2_.text = var_37_11
					end

					if arg_34_1.bgmTimer then
						arg_34_1.bgmTimer:Stop()

						arg_34_1.bgmTimer = nil
					end

					if arg_34_1.settingData.show_music_name == 1 then
						arg_34_1.musicController:SetSelectedState("show")
						arg_34_1.musicAnimator_:Play("open", 0, 0)

						if arg_34_1.settingData.music_time ~= 0 then
							arg_34_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_34_1.settingData.music_time), function()
								if arg_34_1 == nil or isNil(arg_34_1.bgmTxt_) then
									return
								end

								arg_34_1.musicController:SetSelectedState("hide")
								arg_34_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_34_1.frameCnt_ <= 1 then
				arg_34_1.dialog_:SetActive(false)
			end

			local var_37_12 = 1.999999999999
			local var_37_13 = 0.425

			if 1.999999999999 < arg_34_1.time_ and arg_34_1.time_ <= var_37_12 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				arg_34_1.dialog_:SetActive(true)

				arg_34_1.dialogCg_.alpha = 0

				local var_37_14 = LeanTween.value(arg_34_1.dialog_, 0, 1, 0.3)

				var_37_14:setOnUpdate(LuaHelper.FloatAction(function(arg_39_0)
					arg_34_1.dialogCg_.alpha = arg_39_0
				end))
				var_37_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_34_1.dialog_)
					var_37_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_34_1.duration_ = arg_34_1.duration_ + 0.3

				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_15 = arg_34_1:GetWordFromCfg(320011008)
				local var_37_16 = arg_34_1:FormatText(var_37_15.content)

				arg_34_1.text_.text = var_37_16

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_18 = 17 <= 0 and var_37_13 or var_37_13 * (utf8.len(var_37_16) / 17)

				if (17 <= 0 and var_37_13 or var_37_13 * (utf8.len(var_37_16) / 17)) > 0 and var_37_13 < var_37_18 then
					arg_34_1.talkMaxDuration = var_37_18
					var_37_12 = var_37_12 + 0.3

					if var_37_18 + var_37_12 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_18 + var_37_12
					end
				end

				arg_34_1.text_.text = var_37_16
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011008", "story_v_out_320011.awb") ~= 0 then
					local var_37_19 = manager.audio:GetVoiceLength("story_v_out_320011", "320011008", "story_v_out_320011.awb") / 1000

					if var_37_19 + var_37_12 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_19 + var_37_12
					end

					if var_37_15.prefab_name ~= "" and arg_34_1.actors_[var_37_15.prefab_name] ~= nil then
						local var_37_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_15.prefab_name].transform, "story_v_out_320011", "320011008", "story_v_out_320011.awb")

						arg_34_1:RecordAudio("320011008", var_37_20)
						arg_34_1:RecordAudio("320011008", var_37_20)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_320011", "320011008", "story_v_out_320011.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_320011", "320011008", "story_v_out_320011.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_21 = var_37_12 + 0.3
			local var_37_22 = math.max(var_37_13, arg_34_1.talkMaxDuration)

			if var_37_12 + 0.3 <= arg_34_1.time_ and arg_34_1.time_ < var_37_21 + var_37_22 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_21) / var_37_22

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_21 + var_37_22 and arg_34_1.time_ < var_37_21 + var_37_22 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play320011009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320011009
		arg_41_1.duration_ = 6.37

		local var_41_0 = {
			zh = 6.366,
			ja = 4.533
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
				arg_41_0:Play320011010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if arg_41_1.actors_["10100ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10100ui_story"))) then
				local var_44_0 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_41_1.stage_.transform)

				var_44_0.name = "10100ui_story"
				var_44_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["10100ui_story"] = var_44_0

				local var_44_1 = var_44_0:GetComponentInChildren(typeof(CharacterEffect))

				var_44_1.enabled = true

				local var_44_2 = GameObjectTools.GetOrAddComponent(var_44_0, typeof(DynamicBoneHelper))

				if var_44_2 then
					var_44_2:EnableDynamicBone(false)
				end

				arg_41_1:ShowWeapon(var_44_1.transform, false)

				arg_41_1.var_["10100ui_story" .. "Animator"] = var_44_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_41_1.var_["10100ui_story" .. "Animator"].applyRootMotion = true
				arg_41_1.var_["10100ui_story" .. "LipSync"] = var_44_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_44_3 = arg_41_1.actors_["10100ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10100ui_story = var_44_3.localPosition
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_3.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_41_1.time_ - 0) / var_44_4)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_3.localPosition = Vector3.New(0, -1.16, -6.25)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			local var_44_5 = arg_41_1.actors_["10100ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect10100ui_story == nil then
				arg_41_1.var_.characterEffect10100ui_story = var_44_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 and not isNil(var_44_5) then
				if arg_41_1.var_.characterEffect10100ui_story and not isNil(var_44_5) then
					arg_41_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect10100ui_story then
				arg_41_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action18_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_8 = 0
			local var_44_9 = 0.825

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(320011009)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 33 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 33)

				if (33 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 33)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011009", "story_v_out_320011.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_320011", "320011009", "story_v_out_320011.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_320011", "320011009", "story_v_out_320011.awb")

						arg_41_1:RecordAudio("320011009", var_44_15)
						arg_41_1:RecordAudio("320011009", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_320011", "320011009", "story_v_out_320011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_320011", "320011009", "story_v_out_320011.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play320011010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320011010
		arg_45_1.duration_ = 9.43

		local var_45_0 = {
			zh = 6.033,
			ja = 9.433
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
				arg_45_0:Play320011011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10100ui_story"]) and arg_45_1.var_.characterEffect10100ui_story == nil then
				arg_45_1.var_.characterEffect10100ui_story = arg_45_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10100ui_story"]) then
				if arg_45_1.var_.characterEffect10100ui_story and not isNil(arg_45_1.actors_["10100ui_story"]) then
					arg_45_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10100ui_story"]) and arg_45_1.var_.characterEffect10100ui_story then
				arg_45_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.775

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(320011010)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 31 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_4) / 31)

				if (31 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_4) / 31)) > 0 and var_48_2 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011010", "story_v_out_320011.awb") ~= 0 then
					local var_48_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011010", "story_v_out_320011.awb") / 1000

					if var_48_7 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_1
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_320011", "320011010", "story_v_out_320011.awb")

						arg_45_1:RecordAudio("320011010", var_48_8)
						arg_45_1:RecordAudio("320011010", var_48_8)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_320011", "320011010", "story_v_out_320011.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_320011", "320011010", "story_v_out_320011.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_9 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_9 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_9

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_9 and arg_45_1.time_ < var_48_1 + var_48_9 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play320011011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320011011
		arg_49_1.duration_ = 11.23

		local var_49_0 = {
			zh = 7.666,
			ja = 11.233
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
				arg_49_0:Play320011012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10100ui_story"]) and arg_49_1.var_.characterEffect10100ui_story == nil then
				arg_49_1.var_.characterEffect10100ui_story = arg_49_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10100ui_story"]) then
				if arg_49_1.var_.characterEffect10100ui_story and not isNil(arg_49_1.actors_["10100ui_story"]) then
					arg_49_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10100ui_story"]) and arg_49_1.var_.characterEffect10100ui_story then
				arg_49_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action18_2")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_2 = 0
			local var_52_3 = 1

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(320011011)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 40 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 40)

				if (40 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 40)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011011", "story_v_out_320011.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_320011", "320011011", "story_v_out_320011.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_320011", "320011011", "story_v_out_320011.awb")

						arg_49_1:RecordAudio("320011011", var_52_9)
						arg_49_1:RecordAudio("320011011", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_320011", "320011011", "story_v_out_320011.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_320011", "320011011", "story_v_out_320011.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play320011012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320011012
		arg_53_1.duration_ = 14.43

		local var_53_0 = {
			zh = 9.866,
			ja = 14.433
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
				arg_53_0:Play320011013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10100ui_story"]) and arg_53_1.var_.characterEffect10100ui_story == nil then
				arg_53_1.var_.characterEffect10100ui_story = arg_53_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10100ui_story"]) then
				if arg_53_1.var_.characterEffect10100ui_story and not isNil(arg_53_1.actors_["10100ui_story"]) then
					arg_53_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10100ui_story"]) and arg_53_1.var_.characterEffect10100ui_story then
				arg_53_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 1.05

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(320011012)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 42 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 42)

				if (42 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 42)) > 0 and var_56_2 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011012", "story_v_out_320011.awb") ~= 0 then
					local var_56_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011012", "story_v_out_320011.awb") / 1000

					if var_56_7 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_1
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_320011", "320011012", "story_v_out_320011.awb")

						arg_53_1:RecordAudio("320011012", var_56_8)
						arg_53_1:RecordAudio("320011012", var_56_8)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_320011", "320011012", "story_v_out_320011.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_320011", "320011012", "story_v_out_320011.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_9 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_9 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_9

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_9 and arg_53_1.time_ < var_56_1 + var_56_9 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play320011013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320011013
		arg_57_1.duration_ = 15.6

		local var_57_0 = {
			zh = 7.866,
			ja = 15.6
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
				arg_57_0:Play320011014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10100ui_story"]) and arg_57_1.var_.characterEffect10100ui_story == nil then
				arg_57_1.var_.characterEffect10100ui_story = arg_57_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10100ui_story"]) then
				if arg_57_1.var_.characterEffect10100ui_story and not isNil(arg_57_1.actors_["10100ui_story"]) then
					arg_57_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10100ui_story"]) and arg_57_1.var_.characterEffect10100ui_story then
				arg_57_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_2 = 0
			local var_60_3 = 1.05

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(320011013)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 42 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 42)

				if (42 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 42)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011013", "story_v_out_320011.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_320011", "320011013", "story_v_out_320011.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_320011", "320011013", "story_v_out_320011.awb")

						arg_57_1:RecordAudio("320011013", var_60_9)
						arg_57_1:RecordAudio("320011013", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_320011", "320011013", "story_v_out_320011.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_320011", "320011013", "story_v_out_320011.awb")
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
	Play320011014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 320011014
		arg_61_1.duration_ = 7.8

		local var_61_0 = {
			zh = 7.8,
			ja = 7.633
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
				arg_61_0:Play320011015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10100ui_story"]) and arg_61_1.var_.characterEffect10100ui_story == nil then
				arg_61_1.var_.characterEffect10100ui_story = arg_61_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10100ui_story"]) then
				if arg_61_1.var_.characterEffect10100ui_story and not isNil(arg_61_1.actors_["10100ui_story"]) then
					arg_61_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10100ui_story"]) and arg_61_1.var_.characterEffect10100ui_story then
				arg_61_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.75

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(320011014)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 30 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 30)

				if (30 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 30)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011014", "story_v_out_320011.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011014", "story_v_out_320011.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_320011", "320011014", "story_v_out_320011.awb")

						arg_61_1:RecordAudio("320011014", var_64_8)
						arg_61_1:RecordAudio("320011014", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_320011", "320011014", "story_v_out_320011.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_320011", "320011014", "story_v_out_320011.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_9 and arg_61_1.time_ < var_64_1 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play320011015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 320011015
		arg_65_1.duration_ = 6.33

		local var_65_0 = {
			zh = 2.8,
			ja = 6.333
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
				arg_65_0:Play320011016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10100ui_story = arg_65_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10100ui_story"].transform.position).z)
				arg_65_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10100ui_story"].transform.localEulerAngles = arg_65_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_65_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10100ui_story"].transform.position).z)
				arg_65_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10100ui_story"].transform.localEulerAngles = arg_65_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["10100ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10100ui_story == nil then
				arg_65_1.var_.characterEffect10100ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect10100ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10100ui_story then
				arg_65_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_2")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.375

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(320011015)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 15 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 15)

				if (15 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 15)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011015", "story_v_out_320011.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011015", "story_v_out_320011.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_320011", "320011015", "story_v_out_320011.awb")

						arg_65_1:RecordAudio("320011015", var_68_11)
						arg_65_1:RecordAudio("320011015", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_320011", "320011015", "story_v_out_320011.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_320011", "320011015", "story_v_out_320011.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play320011016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 320011016
		arg_69_1.duration_ = 7.33

		local var_69_0 = {
			zh = 5.366,
			ja = 7.333
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
				arg_69_0:Play320011017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10100ui_story"]) and arg_69_1.var_.characterEffect10100ui_story == nil then
				arg_69_1.var_.characterEffect10100ui_story = arg_69_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10100ui_story"]) then
				if arg_69_1.var_.characterEffect10100ui_story and not isNil(arg_69_1.actors_["10100ui_story"]) then
					arg_69_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10100ui_story"]) and arg_69_1.var_.characterEffect10100ui_story then
				arg_69_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.65

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(320011016)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 26 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 26)

				if (26 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 26)) > 0 and var_72_2 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011016", "story_v_out_320011.awb") ~= 0 then
					local var_72_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011016", "story_v_out_320011.awb") / 1000

					if var_72_7 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_1
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_320011", "320011016", "story_v_out_320011.awb")

						arg_69_1:RecordAudio("320011016", var_72_8)
						arg_69_1:RecordAudio("320011016", var_72_8)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_320011", "320011016", "story_v_out_320011.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_320011", "320011016", "story_v_out_320011.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_9 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_9 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_9

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_9 and arg_69_1.time_ < var_72_1 + var_72_9 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play320011017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 320011017
		arg_73_1.duration_ = 11.6

		local var_73_0 = {
			zh = 7.533,
			ja = 11.6
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
				arg_73_0:Play320011018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 1.025

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(320011017)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 41 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 41)

				if (41 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 41)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011017", "story_v_out_320011.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011017", "story_v_out_320011.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_320011", "320011017", "story_v_out_320011.awb")

						arg_73_1:RecordAudio("320011017", var_76_6)
						arg_73_1:RecordAudio("320011017", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_320011", "320011017", "story_v_out_320011.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_320011", "320011017", "story_v_out_320011.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play320011018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 320011018
		arg_77_1.duration_ = 11.87

		local var_77_0 = {
			zh = 10.9,
			ja = 11.866
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
				arg_77_0:Play320011019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 1.1

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(320011018)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 44 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 44)

				if (44 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 44)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011018", "story_v_out_320011.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011018", "story_v_out_320011.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_320011", "320011018", "story_v_out_320011.awb")

						arg_77_1:RecordAudio("320011018", var_80_6)
						arg_77_1:RecordAudio("320011018", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_320011", "320011018", "story_v_out_320011.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_320011", "320011018", "story_v_out_320011.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play320011019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 320011019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play320011020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10100ui_story = arg_81_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10100ui_story"].transform.position).z)
				arg_81_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10100ui_story"].transform.localEulerAngles = arg_81_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10100ui_story"].transform.position).z)
				arg_81_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10100ui_story"].transform.localEulerAngles = arg_81_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["10100ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect10100ui_story == nil then
				arg_81_1.var_.characterEffect10100ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect10100ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_2)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect10100ui_story then
				arg_81_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_84_3 = 0
			local var_84_4 = 1.15

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_5 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(320011019).content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 46 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 46)

				if (46 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 46)) > 0 and var_84_4 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_3 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_3
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_4, arg_81_1.talkMaxDuration)

			if var_84_3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_3 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_3) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_3 + var_84_8 and arg_81_1.time_ < var_84_3 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play320011020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 320011020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play320011021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 1.35

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(320011020).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 54 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 54)

				if (54 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 54)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play320011021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 320011021
		arg_89_1.duration_ = 9.8

		local var_89_0 = {
			zh = 6.1,
			ja = 9.8
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
				arg_89_0:Play320011022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.625

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1022].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:GetWordFromCfg(320011021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 25 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 25)

				if (25 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 25)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011021", "story_v_out_320011.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011021", "story_v_out_320011.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_320011", "320011021", "story_v_out_320011.awb")

						arg_89_1:RecordAudio("320011021", var_92_6)
						arg_89_1:RecordAudio("320011021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_320011", "320011021", "story_v_out_320011.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_320011", "320011021", "story_v_out_320011.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play320011022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 320011022
		arg_93_1.duration_ = 2.7

		local var_93_0 = {
			zh = 1.2,
			ja = 2.7
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
				arg_93_0:Play320011023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10100ui_story = arg_93_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10100ui_story"].transform.position).z)
				arg_93_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10100ui_story"].transform.localEulerAngles = arg_93_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_93_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10100ui_story"].transform.position).z)
				arg_93_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10100ui_story"].transform.localEulerAngles = arg_93_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["10100ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10100ui_story == nil then
				arg_93_1.var_.characterEffect10100ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect10100ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10100ui_story then
				arg_93_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_4 = 0
			local var_96_5 = 0.125

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(320011022)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 5 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 5)

				if (5 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 5)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011022", "story_v_out_320011.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011022", "story_v_out_320011.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_320011", "320011022", "story_v_out_320011.awb")

						arg_93_1:RecordAudio("320011022", var_96_11)
						arg_93_1:RecordAudio("320011022", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_320011", "320011022", "story_v_out_320011.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_320011", "320011022", "story_v_out_320011.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play320011023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 320011023
		arg_97_1.duration_ = 8.97

		local var_97_0 = {
			zh = 8.966,
			ja = 8.733
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
				arg_97_0:Play320011024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10100ui_story"]) and arg_97_1.var_.characterEffect10100ui_story == nil then
				arg_97_1.var_.characterEffect10100ui_story = arg_97_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10100ui_story"]) then
				if arg_97_1.var_.characterEffect10100ui_story and not isNil(arg_97_1.actors_["10100ui_story"]) then
					arg_97_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10100ui_story"]) and arg_97_1.var_.characterEffect10100ui_story then
				arg_97_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.95

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1022].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(320011023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 38 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 38)

				if (38 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 38)) > 0 and var_100_2 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011023", "story_v_out_320011.awb") ~= 0 then
					local var_100_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011023", "story_v_out_320011.awb") / 1000

					if var_100_7 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_1
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_320011", "320011023", "story_v_out_320011.awb")

						arg_97_1:RecordAudio("320011023", var_100_8)
						arg_97_1:RecordAudio("320011023", var_100_8)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_320011", "320011023", "story_v_out_320011.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_320011", "320011023", "story_v_out_320011.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_9 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_9 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_9

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_9 and arg_97_1.time_ < var_100_1 + var_100_9 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play320011024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320011024
		arg_101_1.duration_ = 18.5

		local var_101_0 = {
			zh = 12.1,
			ja = 18.5
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
				arg_101_0:Play320011025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.425

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1022].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(320011024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 57 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 57)

				if (57 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 57)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011024", "story_v_out_320011.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011024", "story_v_out_320011.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_320011", "320011024", "story_v_out_320011.awb")

						arg_101_1:RecordAudio("320011024", var_104_6)
						arg_101_1:RecordAudio("320011024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_320011", "320011024", "story_v_out_320011.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_320011", "320011024", "story_v_out_320011.awb")
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
	Play320011025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320011025
		arg_105_1.duration_ = 15.1

		local var_105_0 = {
			zh = 7.5,
			ja = 15.1
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
				arg_105_0:Play320011026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10100ui_story = arg_105_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10100ui_story"].transform.position).z)
				arg_105_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10100ui_story"].transform.localEulerAngles = arg_105_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_105_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10100ui_story"].transform.position).z)
				arg_105_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10100ui_story"].transform.localEulerAngles = arg_105_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["10100ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10100ui_story == nil then
				arg_105_1.var_.characterEffect10100ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect10100ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10100ui_story then
				arg_105_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action19_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_4 = 0
			local var_108_5 = 0.9

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(320011025)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 36 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 36)

				if (36 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 36)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011025", "story_v_out_320011.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011025", "story_v_out_320011.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_320011", "320011025", "story_v_out_320011.awb")

						arg_105_1:RecordAudio("320011025", var_108_11)
						arg_105_1:RecordAudio("320011025", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_320011", "320011025", "story_v_out_320011.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_320011", "320011025", "story_v_out_320011.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play320011026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 320011026
		arg_109_1.duration_ = 4

		local var_109_0 = {
			zh = 3.233,
			ja = 4
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
				arg_109_0:Play320011027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10100ui_story"]) and arg_109_1.var_.characterEffect10100ui_story == nil then
				arg_109_1.var_.characterEffect10100ui_story = arg_109_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10100ui_story"]) then
				if arg_109_1.var_.characterEffect10100ui_story and not isNil(arg_109_1.actors_["10100ui_story"]) then
					arg_109_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10100ui_story"]) and arg_109_1.var_.characterEffect10100ui_story then
				arg_109_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.375

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1022].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:GetWordFromCfg(320011026)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 15 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 15)

				if (15 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 15)) > 0 and var_112_2 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011026", "story_v_out_320011.awb") ~= 0 then
					local var_112_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011026", "story_v_out_320011.awb") / 1000

					if var_112_7 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_1
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_320011", "320011026", "story_v_out_320011.awb")

						arg_109_1:RecordAudio("320011026", var_112_8)
						arg_109_1:RecordAudio("320011026", var_112_8)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_320011", "320011026", "story_v_out_320011.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_320011", "320011026", "story_v_out_320011.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_9 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_9

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_9 and arg_109_1.time_ < var_112_1 + var_112_9 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play320011027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 320011027
		arg_113_1.duration_ = 8.73

		local var_113_0 = {
			zh = 6,
			ja = 8.733
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
				arg_113_0:Play320011028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10100ui_story = arg_113_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10100ui_story"].transform.position).z)
				arg_113_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10100ui_story"].transform.localEulerAngles = arg_113_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_113_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10100ui_story"].transform.position).z)
				arg_113_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10100ui_story"].transform.localEulerAngles = arg_113_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["10100ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10100ui_story == nil then
				arg_113_1.var_.characterEffect10100ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect10100ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10100ui_story then
				arg_113_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action19_2")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_4 = 0
			local var_116_5 = 0.575

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(320011027)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 23 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 23)

				if (23 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 23)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011027", "story_v_out_320011.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011027", "story_v_out_320011.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_320011", "320011027", "story_v_out_320011.awb")

						arg_113_1:RecordAudio("320011027", var_116_11)
						arg_113_1:RecordAudio("320011027", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_320011", "320011027", "story_v_out_320011.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_320011", "320011027", "story_v_out_320011.awb")
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

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play320011028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 320011028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play320011029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10100ui_story"]) and arg_117_1.var_.characterEffect10100ui_story == nil then
				arg_117_1.var_.characterEffect10100ui_story = arg_117_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10100ui_story"]) then
				if arg_117_1.var_.characterEffect10100ui_story and not isNil(arg_117_1.actors_["10100ui_story"]) then
					arg_117_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10100ui_story"]) and arg_117_1.var_.characterEffect10100ui_story then
				arg_117_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_120_1 = arg_117_1.actors_["10100ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10100ui_story = var_120_1.localPosition
			end

			local var_120_2 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 then
				var_120_1.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_2)
				var_120_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_1.position).x, (manager.ui.mainCamera.transform.position - var_120_1.position).y, (manager.ui.mainCamera.transform.position - var_120_1.position).z)
				var_120_1.localEulerAngles.z = 0
				var_120_1.localEulerAngles.x = 0
				var_120_1.localEulerAngles = var_120_1.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 then
				var_120_1.localPosition = Vector3.New(0, 100, 0)
				var_120_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_1.position).x, (manager.ui.mainCamera.transform.position - var_120_1.position).y, (manager.ui.mainCamera.transform.position - var_120_1.position).z)
				var_120_1.localEulerAngles.z = 0
				var_120_1.localEulerAngles.x = 0
				var_120_1.localEulerAngles = var_120_1.localEulerAngles
			end

			local var_120_3 = 0
			local var_120_4 = 1.375

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_5 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(320011028).content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 55 <= 0 and var_120_4 or var_120_4 * (utf8.len(var_120_5) / 55)

				if (55 <= 0 and var_120_4 or var_120_4 * (utf8.len(var_120_5) / 55)) > 0 and var_120_4 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_3 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_3
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_8 = math.max(var_120_4, arg_117_1.talkMaxDuration)

			if var_120_3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_3 + var_120_8 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_3) / var_120_8

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_3 + var_120_8 and arg_117_1.time_ < var_120_3 + var_120_8 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play320011029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 320011029
		arg_121_1.duration_ = 5.67

		local var_121_0 = {
			zh = 5.1,
			ja = 5.666
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
				arg_121_0:Play320011030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10100ui_story = arg_121_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10100ui_story"].transform.position).z)
				arg_121_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10100ui_story"].transform.localEulerAngles = arg_121_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_121_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10100ui_story"].transform.position).z)
				arg_121_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10100ui_story"].transform.localEulerAngles = arg_121_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["10100ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10100ui_story == nil then
				arg_121_1.var_.characterEffect10100ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect10100ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10100ui_story then
				arg_121_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_4 = 0
			local var_124_5 = 0.625

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(320011029)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 25 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 25)

				if (25 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 25)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011029", "story_v_out_320011.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011029", "story_v_out_320011.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_320011", "320011029", "story_v_out_320011.awb")

						arg_121_1:RecordAudio("320011029", var_124_11)
						arg_121_1:RecordAudio("320011029", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_320011", "320011029", "story_v_out_320011.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_320011", "320011029", "story_v_out_320011.awb")
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

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play320011030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 320011030
		arg_125_1.duration_ = 3.9

		local var_125_0 = {
			zh = 1.999999999999,
			ja = 3.9
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
				arg_125_0:Play320011031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10100ui_story = arg_125_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10100ui_story, Vector3.New(-0.7, -1.16, -6.25), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10100ui_story"].transform.position).z)
				arg_125_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10100ui_story"].transform.localEulerAngles = arg_125_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(-0.7, -1.16, -6.25)
				arg_125_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10100ui_story"].transform.position).z)
				arg_125_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10100ui_story"].transform.localEulerAngles = arg_125_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["10100ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect10100ui_story == nil then
				arg_125_1.var_.characterEffect10100ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect10100ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_2)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect10100ui_story then
				arg_125_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_128_3 = "10101ui_story"

			if arg_125_1.actors_["10101ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10101ui_story"))) then
				local var_128_4 = Object.Instantiate(Asset.Load("Char/" .. "10101ui_story"), arg_125_1.stage_.transform)

				var_128_4.name = var_128_3
				var_128_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_[var_128_3] = var_128_4

				local var_128_5 = var_128_4:GetComponentInChildren(typeof(CharacterEffect))

				var_128_5.enabled = true

				local var_128_6 = GameObjectTools.GetOrAddComponent(var_128_4, typeof(DynamicBoneHelper))

				if var_128_6 then
					var_128_6:EnableDynamicBone(false)
				end

				arg_125_1:ShowWeapon(var_128_5.transform, false)

				arg_125_1.var_[var_128_3 .. "Animator"] = var_128_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_125_1.var_[var_128_3 .. "Animator"].applyRootMotion = true
				arg_125_1.var_[var_128_3 .. "LipSync"] = var_128_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_128_7 = arg_125_1.actors_["10101ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10101ui_story = var_128_7.localPosition
			end

			local var_128_8 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_8 then
				var_128_7.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10101ui_story, Vector3.New(0.7, -1.16, -6.01), (arg_125_1.time_ - 0) / var_128_8)
				var_128_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_7.position).x, (manager.ui.mainCamera.transform.position - var_128_7.position).y, (manager.ui.mainCamera.transform.position - var_128_7.position).z)
				var_128_7.localEulerAngles.z = 0
				var_128_7.localEulerAngles.x = 0
				var_128_7.localEulerAngles = var_128_7.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_8 and arg_125_1.time_ < 0 + var_128_8 + arg_128_0 then
				var_128_7.localPosition = Vector3.New(0.7, -1.16, -6.01)
				var_128_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_7.position).x, (manager.ui.mainCamera.transform.position - var_128_7.position).y, (manager.ui.mainCamera.transform.position - var_128_7.position).z)
				var_128_7.localEulerAngles.z = 0
				var_128_7.localEulerAngles.x = 0
				var_128_7.localEulerAngles = var_128_7.localEulerAngles
			end

			local var_128_9 = arg_125_1.actors_["10101ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect10101ui_story == nil then
				arg_125_1.var_.characterEffect10101ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_10 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_10 and not isNil(var_128_9) then
				if arg_125_1.var_.characterEffect10101ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_10 and arg_125_1.time_ < 0 + var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect10101ui_story then
				arg_125_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_128_12 = 0
			local var_128_13 = 0.15

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_14 = arg_125_1:GetWordFromCfg(320011030)
				local var_128_15 = arg_125_1:FormatText(var_128_14.content)

				arg_125_1.text_.text = var_128_15

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_17 = 6 <= 0 and var_128_13 or var_128_13 * (utf8.len(var_128_15) / 6)

				if (6 <= 0 and var_128_13 or var_128_13 * (utf8.len(var_128_15) / 6)) > 0 and var_128_13 < var_128_17 then
					arg_125_1.talkMaxDuration = var_128_17

					if var_128_17 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_17 + var_128_12
					end
				end

				arg_125_1.text_.text = var_128_15
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011030", "story_v_out_320011.awb") ~= 0 then
					local var_128_18 = manager.audio:GetVoiceLength("story_v_out_320011", "320011030", "story_v_out_320011.awb") / 1000

					if var_128_18 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_18 + var_128_12
					end

					if var_128_14.prefab_name ~= "" and arg_125_1.actors_[var_128_14.prefab_name] ~= nil then
						local var_128_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_14.prefab_name].transform, "story_v_out_320011", "320011030", "story_v_out_320011.awb")

						arg_125_1:RecordAudio("320011030", var_128_19)
						arg_125_1:RecordAudio("320011030", var_128_19)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_320011", "320011030", "story_v_out_320011.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_320011", "320011030", "story_v_out_320011.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_20 = math.max(var_128_13, arg_125_1.talkMaxDuration)

			if var_128_12 <= arg_125_1.time_ and arg_125_1.time_ < var_128_12 + var_128_20 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_12) / var_128_20

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_12 + var_128_20 and arg_125_1.time_ < var_128_12 + var_128_20 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play320011031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 320011031
		arg_129_1.duration_ = 5.17

		local var_129_0 = {
			zh = 5.1,
			ja = 5.166
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
				arg_129_0:Play320011032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10101ui_story"]) and arg_129_1.var_.characterEffect10101ui_story == nil then
				arg_129_1.var_.characterEffect10101ui_story = arg_129_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10101ui_story"]) then
				if arg_129_1.var_.characterEffect10101ui_story and not isNil(arg_129_1.actors_["10101ui_story"]) then
					arg_129_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10101ui_story"]) and arg_129_1.var_.characterEffect10101ui_story then
				arg_129_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_132_1 = arg_129_1.actors_["10100ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect10100ui_story == nil then
				arg_129_1.var_.characterEffect10100ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect10100ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect10100ui_story then
				arg_129_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_132_4 = 0
			local var_132_5 = 0.625

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(320011031)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 25 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 25)

				if (25 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 25)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011031", "story_v_out_320011.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011031", "story_v_out_320011.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_320011", "320011031", "story_v_out_320011.awb")

						arg_129_1:RecordAudio("320011031", var_132_11)
						arg_129_1:RecordAudio("320011031", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_320011", "320011031", "story_v_out_320011.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_320011", "320011031", "story_v_out_320011.awb")
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
	Play320011032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 320011032
		arg_133_1.duration_ = 12.3

		local var_133_0 = {
			zh = 9.9,
			ja = 12.3
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
				arg_133_0:Play320011033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10101ui_story"]) and arg_133_1.var_.characterEffect10101ui_story == nil then
				arg_133_1.var_.characterEffect10101ui_story = arg_133_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10101ui_story"]) then
				if arg_133_1.var_.characterEffect10101ui_story and not isNil(arg_133_1.actors_["10101ui_story"]) then
					arg_133_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10101ui_story"]) and arg_133_1.var_.characterEffect10101ui_story then
				arg_133_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_136_2 = arg_133_1.actors_["10100ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect10100ui_story == nil then
				arg_133_1.var_.characterEffect10100ui_story = var_136_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_3 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.characterEffect10100ui_story and not isNil(var_136_2) then
					arg_133_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_3)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect10100ui_story then
				arg_133_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			local var_136_4 = 0
			local var_136_5 = 1.2

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(320011032)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 48 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 48)

				if (48 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 48)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011032", "story_v_out_320011.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011032", "story_v_out_320011.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_320011", "320011032", "story_v_out_320011.awb")

						arg_133_1:RecordAudio("320011032", var_136_11)
						arg_133_1:RecordAudio("320011032", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_320011", "320011032", "story_v_out_320011.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_320011", "320011032", "story_v_out_320011.awb")
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
	Play320011033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 320011033
		arg_137_1.duration_ = 11.03

		local var_137_0 = {
			zh = 6.466,
			ja = 11.033
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
				arg_137_0:Play320011034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.825

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(320011033)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 33 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 33)

				if (33 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 33)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011033", "story_v_out_320011.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011033", "story_v_out_320011.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_320011", "320011033", "story_v_out_320011.awb")

						arg_137_1:RecordAudio("320011033", var_140_6)
						arg_137_1:RecordAudio("320011033", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_320011", "320011033", "story_v_out_320011.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_320011", "320011033", "story_v_out_320011.awb")
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
	Play320011034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 320011034
		arg_141_1.duration_ = 5.93

		local var_141_0 = {
			zh = 2.2,
			ja = 5.933
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
				arg_141_0:Play320011035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10101ui_story"]) and arg_141_1.var_.characterEffect10101ui_story == nil then
				arg_141_1.var_.characterEffect10101ui_story = arg_141_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10101ui_story"]) then
				if arg_141_1.var_.characterEffect10101ui_story and not isNil(arg_141_1.actors_["10101ui_story"]) then
					arg_141_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10101ui_story"]) and arg_141_1.var_.characterEffect10101ui_story then
				arg_141_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_144_1 = arg_141_1.actors_["10100ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10100ui_story == nil then
				arg_141_1.var_.characterEffect10100ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect10100ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10100ui_story then
				arg_141_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action9_1")
			end

			local var_144_4 = 0
			local var_144_5 = 0.275

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(320011034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 11 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 11)

				if (11 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 11)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011034", "story_v_out_320011.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011034", "story_v_out_320011.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_320011", "320011034", "story_v_out_320011.awb")

						arg_141_1:RecordAudio("320011034", var_144_11)
						arg_141_1:RecordAudio("320011034", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_320011", "320011034", "story_v_out_320011.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_320011", "320011034", "story_v_out_320011.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play320011035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 320011035
		arg_145_1.duration_ = 5.67

		local var_145_0 = {
			zh = 3.233,
			ja = 5.666
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
				arg_145_0:Play320011036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["10100ui_story"]) and arg_145_1.var_.characterEffect10100ui_story == nil then
				arg_145_1.var_.characterEffect10100ui_story = arg_145_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["10100ui_story"]) then
				if arg_145_1.var_.characterEffect10100ui_story and not isNil(arg_145_1.actors_["10100ui_story"]) then
					arg_145_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["10100ui_story"]) and arg_145_1.var_.characterEffect10100ui_story then
				arg_145_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_148_1 = 0
			local var_148_2 = 0.325

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1022].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(320011035)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_6 = 13 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_4) / 13)

				if (13 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_4) / 13)) > 0 and var_148_2 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011035", "story_v_out_320011.awb") ~= 0 then
					local var_148_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011035", "story_v_out_320011.awb") / 1000

					if var_148_7 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_1
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_320011", "320011035", "story_v_out_320011.awb")

						arg_145_1:RecordAudio("320011035", var_148_8)
						arg_145_1:RecordAudio("320011035", var_148_8)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_320011", "320011035", "story_v_out_320011.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_320011", "320011035", "story_v_out_320011.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_9 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_9 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_9

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_9 and arg_145_1.time_ < var_148_1 + var_148_9 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play320011036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 320011036
		arg_149_1.duration_ = 6.3

		local var_149_0 = {
			zh = 4,
			ja = 6.3
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
				arg_149_0:Play320011037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10101ui_story"]) and arg_149_1.var_.characterEffect10101ui_story == nil then
				arg_149_1.var_.characterEffect10101ui_story = arg_149_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10101ui_story"]) then
				if arg_149_1.var_.characterEffect10101ui_story and not isNil(arg_149_1.actors_["10101ui_story"]) then
					arg_149_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10101ui_story"]) and arg_149_1.var_.characterEffect10101ui_story then
				arg_149_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_152_2 = 0
			local var_152_3 = 0.425

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_4 = arg_149_1:GetWordFromCfg(320011036)
				local var_152_5 = arg_149_1:FormatText(var_152_4.content)

				arg_149_1.text_.text = var_152_5

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_7 = 17 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 17)

				if (17 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 17)) > 0 and var_152_3 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_5
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011036", "story_v_out_320011.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_320011", "320011036", "story_v_out_320011.awb") / 1000

					if var_152_8 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_2
					end

					if var_152_4.prefab_name ~= "" and arg_149_1.actors_[var_152_4.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_4.prefab_name].transform, "story_v_out_320011", "320011036", "story_v_out_320011.awb")

						arg_149_1:RecordAudio("320011036", var_152_9)
						arg_149_1:RecordAudio("320011036", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_320011", "320011036", "story_v_out_320011.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_320011", "320011036", "story_v_out_320011.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_10 and arg_149_1.time_ < var_152_2 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play320011037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 320011037
		arg_153_1.duration_ = 6.1

		local var_153_0 = {
			zh = 4.5,
			ja = 6.1
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
				arg_153_0:Play320011038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10101ui_story"]) and arg_153_1.var_.characterEffect10101ui_story == nil then
				arg_153_1.var_.characterEffect10101ui_story = arg_153_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10101ui_story"]) then
				if arg_153_1.var_.characterEffect10101ui_story and not isNil(arg_153_1.actors_["10101ui_story"]) then
					arg_153_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10101ui_story"]) and arg_153_1.var_.characterEffect10101ui_story then
				arg_153_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 0.45

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1022].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(320011037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_6 = 18 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_4) / 18)

				if (18 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_4) / 18)) > 0 and var_156_2 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011037", "story_v_out_320011.awb") ~= 0 then
					local var_156_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011037", "story_v_out_320011.awb") / 1000

					if var_156_7 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_1
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_320011", "320011037", "story_v_out_320011.awb")

						arg_153_1:RecordAudio("320011037", var_156_8)
						arg_153_1:RecordAudio("320011037", var_156_8)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_320011", "320011037", "story_v_out_320011.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_320011", "320011037", "story_v_out_320011.awb")
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
	Play320011038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 320011038
		arg_157_1.duration_ = 7

		local var_157_0 = {
			zh = 5.6,
			ja = 7
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
				arg_157_0:Play320011039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10100ui_story = arg_157_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10100ui_story"].transform.position).z)
				arg_157_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10100ui_story"].transform.localEulerAngles = arg_157_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_157_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10100ui_story"].transform.position).z)
				arg_157_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10100ui_story"].transform.localEulerAngles = arg_157_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["10100ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect10100ui_story == nil then
				arg_157_1.var_.characterEffect10100ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect10100ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect10100ui_story then
				arg_157_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action9_2")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_4 = arg_157_1.actors_["10101ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10101ui_story = var_160_4.localPosition
			end

			local var_160_5 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_5 then
				var_160_4.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_5)
				var_160_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_4.position).x, (manager.ui.mainCamera.transform.position - var_160_4.position).y, (manager.ui.mainCamera.transform.position - var_160_4.position).z)
				var_160_4.localEulerAngles.z = 0
				var_160_4.localEulerAngles.x = 0
				var_160_4.localEulerAngles = var_160_4.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_5 and arg_157_1.time_ < 0 + var_160_5 + arg_160_0 then
				var_160_4.localPosition = Vector3.New(0, 100, 0)
				var_160_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_4.position).x, (manager.ui.mainCamera.transform.position - var_160_4.position).y, (manager.ui.mainCamera.transform.position - var_160_4.position).z)
				var_160_4.localEulerAngles.z = 0
				var_160_4.localEulerAngles.x = 0
				var_160_4.localEulerAngles = var_160_4.localEulerAngles
			end

			local var_160_6 = 0
			local var_160_7 = 0.55

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_8 = arg_157_1:GetWordFromCfg(320011038)
				local var_160_9 = arg_157_1:FormatText(var_160_8.content)

				arg_157_1.text_.text = var_160_9

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_11 = 22 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_9) / 22)

				if (22 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_9) / 22)) > 0 and var_160_7 < var_160_11 then
					arg_157_1.talkMaxDuration = var_160_11

					if var_160_11 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_11 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_9
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011038", "story_v_out_320011.awb") ~= 0 then
					local var_160_12 = manager.audio:GetVoiceLength("story_v_out_320011", "320011038", "story_v_out_320011.awb") / 1000

					if var_160_12 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_12 + var_160_6
					end

					if var_160_8.prefab_name ~= "" and arg_157_1.actors_[var_160_8.prefab_name] ~= nil then
						local var_160_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_8.prefab_name].transform, "story_v_out_320011", "320011038", "story_v_out_320011.awb")

						arg_157_1:RecordAudio("320011038", var_160_13)
						arg_157_1:RecordAudio("320011038", var_160_13)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_320011", "320011038", "story_v_out_320011.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_320011", "320011038", "story_v_out_320011.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_14 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_14 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_14

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_14 and arg_157_1.time_ < var_160_6 + var_160_14 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play320011039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 320011039
		arg_161_1.duration_ = 9.13

		local var_161_0 = {
			zh = 3.833,
			ja = 9.133
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
				arg_161_0:Play320011040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["10100ui_story"]) and arg_161_1.var_.characterEffect10100ui_story == nil then
				arg_161_1.var_.characterEffect10100ui_story = arg_161_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["10100ui_story"]) then
				if arg_161_1.var_.characterEffect10100ui_story and not isNil(arg_161_1.actors_["10100ui_story"]) then
					arg_161_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_0)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["10100ui_story"]) and arg_161_1.var_.characterEffect10100ui_story then
				arg_161_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_164_1 = 0
			local var_164_2 = 0.475

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1022].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:GetWordFromCfg(320011039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_6 = 19 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_4) / 19)

				if (19 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_4) / 19)) > 0 and var_164_2 < var_164_6 then
					arg_161_1.talkMaxDuration = var_164_6

					if var_164_6 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_1
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011039", "story_v_out_320011.awb") ~= 0 then
					local var_164_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011039", "story_v_out_320011.awb") / 1000

					if var_164_7 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_1
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_320011", "320011039", "story_v_out_320011.awb")

						arg_161_1:RecordAudio("320011039", var_164_8)
						arg_161_1:RecordAudio("320011039", var_164_8)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_320011", "320011039", "story_v_out_320011.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_320011", "320011039", "story_v_out_320011.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_9 = math.max(var_164_2, arg_161_1.talkMaxDuration)

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_9 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_1) / var_164_9

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_1 + var_164_9 and arg_161_1.time_ < var_164_1 + var_164_9 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play320011040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 320011040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play320011041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10100ui_story = arg_165_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10100ui_story"].transform.position).z)
				arg_165_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["10100ui_story"].transform.localEulerAngles = arg_165_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10100ui_story"].transform.position).z)
				arg_165_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["10100ui_story"].transform.localEulerAngles = arg_165_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["10100ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect10100ui_story == nil then
				arg_165_1.var_.characterEffect10100ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect10100ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_2)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect10100ui_story then
				arg_165_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_168_3 = arg_165_1.actors_["10101ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10101ui_story = var_168_3.localPosition
			end

			local var_168_4 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				var_168_3.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_4)
				var_168_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_3.position).x, (manager.ui.mainCamera.transform.position - var_168_3.position).y, (manager.ui.mainCamera.transform.position - var_168_3.position).z)
				var_168_3.localEulerAngles.z = 0
				var_168_3.localEulerAngles.x = 0
				var_168_3.localEulerAngles = var_168_3.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				var_168_3.localPosition = Vector3.New(0, 100, 0)
				var_168_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_3.position).x, (manager.ui.mainCamera.transform.position - var_168_3.position).y, (manager.ui.mainCamera.transform.position - var_168_3.position).z)
				var_168_3.localEulerAngles.z = 0
				var_168_3.localEulerAngles.x = 0
				var_168_3.localEulerAngles = var_168_3.localEulerAngles
			end

			local var_168_5 = arg_165_1.actors_["10101ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.characterEffect10101ui_story == nil then
				arg_165_1.var_.characterEffect10101ui_story = var_168_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_6 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_6 and not isNil(var_168_5) then
				if arg_165_1.var_.characterEffect10101ui_story and not isNil(var_168_5) then
					arg_165_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_6)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_6 and arg_165_1.time_ < 0 + var_168_6 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.characterEffect10101ui_story then
				arg_165_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_168_7 = 0
			local var_168_8 = 1.45

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_7 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_9 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(320011040).content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_11 = 58 <= 0 and var_168_8 or var_168_8 * (utf8.len(var_168_9) / 58)

				if (58 <= 0 and var_168_8 or var_168_8 * (utf8.len(var_168_9) / 58)) > 0 and var_168_8 < var_168_11 then
					arg_165_1.talkMaxDuration = var_168_11

					if var_168_11 + var_168_7 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_7
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_8, arg_165_1.talkMaxDuration)

			if var_168_7 <= arg_165_1.time_ and arg_165_1.time_ < var_168_7 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_7) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_7 + var_168_12 and arg_165_1.time_ < var_168_7 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play320011041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 320011041
		arg_169_1.duration_ = 9.87

		local var_169_0 = {
			zh = 6.266,
			ja = 9.866
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
				arg_169_0:Play320011042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10100ui_story = arg_169_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10100ui_story, Vector3.New(-0.7, -1.16, -6.25), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10100ui_story"].transform.position).z)
				arg_169_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10100ui_story"].transform.localEulerAngles = arg_169_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(-0.7, -1.16, -6.25)
				arg_169_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10100ui_story"].transform.position).z)
				arg_169_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10100ui_story"].transform.localEulerAngles = arg_169_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["10100ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect10100ui_story == nil then
				arg_169_1.var_.characterEffect10100ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect10100ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect10100ui_story then
				arg_169_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_4 = arg_169_1.actors_["10101ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10101ui_story = var_172_4.localPosition
			end

			local var_172_5 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_5 then
				var_172_4.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10101ui_story, Vector3.New(0.7, -1.16, -6.01), (arg_169_1.time_ - 0) / var_172_5)
				var_172_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_4.position).x, (manager.ui.mainCamera.transform.position - var_172_4.position).y, (manager.ui.mainCamera.transform.position - var_172_4.position).z)
				var_172_4.localEulerAngles.z = 0
				var_172_4.localEulerAngles.x = 0
				var_172_4.localEulerAngles = var_172_4.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_5 and arg_169_1.time_ < 0 + var_172_5 + arg_172_0 then
				var_172_4.localPosition = Vector3.New(0.7, -1.16, -6.01)
				var_172_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_4.position).x, (manager.ui.mainCamera.transform.position - var_172_4.position).y, (manager.ui.mainCamera.transform.position - var_172_4.position).z)
				var_172_4.localEulerAngles.z = 0
				var_172_4.localEulerAngles.x = 0
				var_172_4.localEulerAngles = var_172_4.localEulerAngles
			end

			local var_172_6 = arg_169_1.actors_["10101ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_6) and arg_169_1.var_.characterEffect10101ui_story == nil then
				arg_169_1.var_.characterEffect10101ui_story = var_172_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_7 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 and not isNil(var_172_6) then
				if arg_169_1.var_.characterEffect10101ui_story and not isNil(var_172_6) then
					arg_169_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_169_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_7)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 and not isNil(var_172_6) and arg_169_1.var_.characterEffect10101ui_story then
				arg_169_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_169_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_172_8 = 0
			local var_172_9 = 0.7

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_10 = arg_169_1:GetWordFromCfg(320011041)
				local var_172_11 = arg_169_1:FormatText(var_172_10.content)

				arg_169_1.text_.text = var_172_11

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_13 = 28 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_11) / 28)

				if (28 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_11) / 28)) > 0 and var_172_9 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13

					if var_172_13 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_11
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011041", "story_v_out_320011.awb") ~= 0 then
					local var_172_14 = manager.audio:GetVoiceLength("story_v_out_320011", "320011041", "story_v_out_320011.awb") / 1000

					if var_172_14 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_14 + var_172_8
					end

					if var_172_10.prefab_name ~= "" and arg_169_1.actors_[var_172_10.prefab_name] ~= nil then
						local var_172_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_10.prefab_name].transform, "story_v_out_320011", "320011041", "story_v_out_320011.awb")

						arg_169_1:RecordAudio("320011041", var_172_15)
						arg_169_1:RecordAudio("320011041", var_172_15)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_320011", "320011041", "story_v_out_320011.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_320011", "320011041", "story_v_out_320011.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_16 = math.max(var_172_9, arg_169_1.talkMaxDuration)

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_16 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_8) / var_172_16

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_8 + var_172_16 and arg_169_1.time_ < var_172_8 + var_172_16 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play320011042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 320011042
		arg_173_1.duration_ = 7.17

		local var_173_0 = {
			zh = 4.433,
			ja = 7.166
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
				arg_173_0:Play320011043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["10100ui_story"]) and arg_173_1.var_.characterEffect10100ui_story == nil then
				arg_173_1.var_.characterEffect10100ui_story = arg_173_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["10100ui_story"]) then
				if arg_173_1.var_.characterEffect10100ui_story and not isNil(arg_173_1.actors_["10100ui_story"]) then
					arg_173_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["10100ui_story"]) and arg_173_1.var_.characterEffect10100ui_story then
				arg_173_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_176_1 = arg_173_1.actors_["10101ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect10101ui_story == nil then
				arg_173_1.var_.characterEffect10101ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect10101ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect10101ui_story then
				arg_173_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_176_4 = 0
			local var_176_5 = 0.475

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(320011042)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 19 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 19)

				if (19 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 19)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011042", "story_v_out_320011.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011042", "story_v_out_320011.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_320011", "320011042", "story_v_out_320011.awb")

						arg_173_1:RecordAudio("320011042", var_176_11)
						arg_173_1:RecordAudio("320011042", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_320011", "320011042", "story_v_out_320011.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_320011", "320011042", "story_v_out_320011.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play320011043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 320011043
		arg_177_1.duration_ = 13.17

		local var_177_0 = {
			zh = 11.433,
			ja = 13.166
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
				arg_177_0:Play320011044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10101ui_story"]) and arg_177_1.var_.characterEffect10101ui_story == nil then
				arg_177_1.var_.characterEffect10101ui_story = arg_177_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["10101ui_story"]) then
				if arg_177_1.var_.characterEffect10101ui_story and not isNil(arg_177_1.actors_["10101ui_story"]) then
					arg_177_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["10101ui_story"]) and arg_177_1.var_.characterEffect10101ui_story then
				arg_177_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_180_1 = arg_177_1.actors_["10100ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect10100ui_story == nil then
				arg_177_1.var_.characterEffect10100ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect10100ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect10100ui_story then
				arg_177_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_180_4 = 0
			local var_180_5 = 1.2

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(320011043)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 48 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 48)

				if (48 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 48)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011043", "story_v_out_320011.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011043", "story_v_out_320011.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_320011", "320011043", "story_v_out_320011.awb")

						arg_177_1:RecordAudio("320011043", var_180_11)
						arg_177_1:RecordAudio("320011043", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_320011", "320011043", "story_v_out_320011.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_320011", "320011043", "story_v_out_320011.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play320011044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 320011044
		arg_181_1.duration_ = 7.87

		local var_181_0 = {
			zh = 7.866,
			ja = 7.166
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
				arg_181_0:Play320011045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["10101ui_story"]) and arg_181_1.var_.characterEffect10101ui_story == nil then
				arg_181_1.var_.characterEffect10101ui_story = arg_181_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["10101ui_story"]) then
				if arg_181_1.var_.characterEffect10101ui_story and not isNil(arg_181_1.actors_["10101ui_story"]) then
					arg_181_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["10101ui_story"]) and arg_181_1.var_.characterEffect10101ui_story then
				arg_181_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_184_2 = arg_181_1.actors_["10100ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect10100ui_story == nil then
				arg_181_1.var_.characterEffect10100ui_story = var_184_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_3 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.characterEffect10100ui_story and not isNil(var_184_2) then
					arg_181_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_3)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect10100ui_story then
				arg_181_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_184_4 = 0
			local var_184_5 = 1.025

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(320011044)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 41 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 41)

				if (41 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 41)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011044", "story_v_out_320011.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011044", "story_v_out_320011.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_out_320011", "320011044", "story_v_out_320011.awb")

						arg_181_1:RecordAudio("320011044", var_184_11)
						arg_181_1:RecordAudio("320011044", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_320011", "320011044", "story_v_out_320011.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_320011", "320011044", "story_v_out_320011.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_12 and arg_181_1.time_ < var_184_4 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play320011045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 320011045
		arg_185_1.duration_ = 21.6

		local var_185_0 = {
			zh = 12.433,
			ja = 21.6
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
				arg_185_0:Play320011046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["10100ui_story"]) and arg_185_1.var_.characterEffect10100ui_story == nil then
				arg_185_1.var_.characterEffect10100ui_story = arg_185_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["10100ui_story"]) then
				if arg_185_1.var_.characterEffect10100ui_story and not isNil(arg_185_1.actors_["10100ui_story"]) then
					arg_185_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["10100ui_story"]) and arg_185_1.var_.characterEffect10100ui_story then
				arg_185_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_188_2 = arg_185_1.actors_["10101ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.characterEffect10101ui_story == nil then
				arg_185_1.var_.characterEffect10101ui_story = var_188_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_3 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.characterEffect10101ui_story and not isNil(var_188_2) then
					arg_185_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_185_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_3)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.characterEffect10101ui_story then
				arg_185_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_185_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_188_4 = 0
			local var_188_5 = 1.2

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(320011045)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 48 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 48)

				if (48 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 48)) > 0 and var_188_5 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011045", "story_v_out_320011.awb") ~= 0 then
					local var_188_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011045", "story_v_out_320011.awb") / 1000

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end

					if var_188_6.prefab_name ~= "" and arg_185_1.actors_[var_188_6.prefab_name] ~= nil then
						local var_188_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_6.prefab_name].transform, "story_v_out_320011", "320011045", "story_v_out_320011.awb")

						arg_185_1:RecordAudio("320011045", var_188_11)
						arg_185_1:RecordAudio("320011045", var_188_11)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_320011", "320011045", "story_v_out_320011.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_320011", "320011045", "story_v_out_320011.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_12 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_12 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_12

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_12 and arg_185_1.time_ < var_188_4 + var_188_12 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play320011046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 320011046
		arg_189_1.duration_ = 3.47

		local var_189_0 = {
			zh = 3.466,
			ja = 2.6
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
				arg_189_0:Play320011047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["10101ui_story"]) and arg_189_1.var_.characterEffect10101ui_story == nil then
				arg_189_1.var_.characterEffect10101ui_story = arg_189_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["10101ui_story"]) then
				if arg_189_1.var_.characterEffect10101ui_story and not isNil(arg_189_1.actors_["10101ui_story"]) then
					arg_189_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["10101ui_story"]) and arg_189_1.var_.characterEffect10101ui_story then
				arg_189_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_192_2 = arg_189_1.actors_["10100ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect10100ui_story == nil then
				arg_189_1.var_.characterEffect10100ui_story = var_192_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_3 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.characterEffect10100ui_story and not isNil(var_192_2) then
					arg_189_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_189_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_3)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect10100ui_story then
				arg_189_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_189_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_192_4 = 0
			local var_192_5 = 0.375

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(320011046)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 15 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 15)

				if (15 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 15)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011046", "story_v_out_320011.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011046", "story_v_out_320011.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_out_320011", "320011046", "story_v_out_320011.awb")

						arg_189_1:RecordAudio("320011046", var_192_11)
						arg_189_1:RecordAudio("320011046", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_320011", "320011046", "story_v_out_320011.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_320011", "320011046", "story_v_out_320011.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_12 and arg_189_1.time_ < var_192_4 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play320011047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 320011047
		arg_193_1.duration_ = 6.43

		local var_193_0 = {
			zh = 6,
			ja = 6.433
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
				arg_193_0:Play320011048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["10100ui_story"]) and arg_193_1.var_.characterEffect10100ui_story == nil then
				arg_193_1.var_.characterEffect10100ui_story = arg_193_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["10100ui_story"]) then
				if arg_193_1.var_.characterEffect10100ui_story and not isNil(arg_193_1.actors_["10100ui_story"]) then
					arg_193_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["10100ui_story"]) and arg_193_1.var_.characterEffect10100ui_story then
				arg_193_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action6_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_2 = arg_193_1.actors_["10101ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect10101ui_story == nil then
				arg_193_1.var_.characterEffect10101ui_story = var_196_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_3 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.characterEffect10101ui_story and not isNil(var_196_2) then
					arg_193_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_193_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_3)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect10101ui_story then
				arg_193_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_193_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_196_4 = 0
			local var_196_5 = 0.6

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(320011047)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 24 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 24)

				if (24 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 24)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011047", "story_v_out_320011.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011047", "story_v_out_320011.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_320011", "320011047", "story_v_out_320011.awb")

						arg_193_1:RecordAudio("320011047", var_196_11)
						arg_193_1:RecordAudio("320011047", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_320011", "320011047", "story_v_out_320011.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_320011", "320011047", "story_v_out_320011.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_12 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_12 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_12

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_12 and arg_193_1.time_ < var_196_4 + var_196_12 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play320011048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 320011048
		arg_197_1.duration_ = 13.1

		local var_197_0 = {
			zh = 10.066,
			ja = 13.1
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
				arg_197_0:Play320011049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["10100ui_story"]) and arg_197_1.var_.characterEffect10100ui_story == nil then
				arg_197_1.var_.characterEffect10100ui_story = arg_197_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["10100ui_story"]) then
				if arg_197_1.var_.characterEffect10100ui_story and not isNil(arg_197_1.actors_["10100ui_story"]) then
					arg_197_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_197_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["10100ui_story"]) and arg_197_1.var_.characterEffect10100ui_story then
				arg_197_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_197_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_200_1 = arg_197_1.actors_["10101ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect10101ui_story == nil then
				arg_197_1.var_.characterEffect10101ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect10101ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect10101ui_story then
				arg_197_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			local var_200_4 = 0
			local var_200_5 = 0.95

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(320011048)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 38 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 38)

				if (38 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 38)) > 0 and var_200_5 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011048", "story_v_out_320011.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011048", "story_v_out_320011.awb") / 1000

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end

					if var_200_6.prefab_name ~= "" and arg_197_1.actors_[var_200_6.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_6.prefab_name].transform, "story_v_out_320011", "320011048", "story_v_out_320011.awb")

						arg_197_1:RecordAudio("320011048", var_200_11)
						arg_197_1:RecordAudio("320011048", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_320011", "320011048", "story_v_out_320011.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_320011", "320011048", "story_v_out_320011.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_12 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_12 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_12

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_12 and arg_197_1.time_ < var_200_4 + var_200_12 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play320011049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 320011049
		arg_201_1.duration_ = 8.17

		local var_201_0 = {
			zh = 7.866,
			ja = 8.166
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
				arg_201_0:Play320011050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["10100ui_story"]) and arg_201_1.var_.characterEffect10100ui_story == nil then
				arg_201_1.var_.characterEffect10100ui_story = arg_201_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["10100ui_story"]) then
				if arg_201_1.var_.characterEffect10100ui_story and not isNil(arg_201_1.actors_["10100ui_story"]) then
					arg_201_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["10100ui_story"]) and arg_201_1.var_.characterEffect10100ui_story then
				arg_201_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action4618")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_204_2 = arg_201_1.actors_["10101ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.characterEffect10101ui_story == nil then
				arg_201_1.var_.characterEffect10101ui_story = var_204_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_3 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.characterEffect10101ui_story and not isNil(var_204_2) then
					arg_201_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_3)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.characterEffect10101ui_story then
				arg_201_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_204_4 = 0
			local var_204_5 = 0.875

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:GetWordFromCfg(320011049)
				local var_204_7 = arg_201_1:FormatText(var_204_6.content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_9 = 35 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 35)

				if (35 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 35)) > 0 and var_204_5 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011049", "story_v_out_320011.awb") ~= 0 then
					local var_204_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011049", "story_v_out_320011.awb") / 1000

					if var_204_10 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_4
					end

					if var_204_6.prefab_name ~= "" and arg_201_1.actors_[var_204_6.prefab_name] ~= nil then
						local var_204_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_6.prefab_name].transform, "story_v_out_320011", "320011049", "story_v_out_320011.awb")

						arg_201_1:RecordAudio("320011049", var_204_11)
						arg_201_1:RecordAudio("320011049", var_204_11)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_320011", "320011049", "story_v_out_320011.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_320011", "320011049", "story_v_out_320011.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_12 = math.max(var_204_5, arg_201_1.talkMaxDuration)

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_12 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_4) / var_204_12

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_4 + var_204_12 and arg_201_1.time_ < var_204_4 + var_204_12 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play320011050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 320011050
		arg_205_1.duration_ = 3.47

		local var_205_0 = {
			zh = 1.999999999999,
			ja = 3.466
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
				arg_205_0:Play320011051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["10101ui_story"]) and arg_205_1.var_.characterEffect10101ui_story == nil then
				arg_205_1.var_.characterEffect10101ui_story = arg_205_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["10101ui_story"]) then
				if arg_205_1.var_.characterEffect10101ui_story and not isNil(arg_205_1.actors_["10101ui_story"]) then
					arg_205_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["10101ui_story"]) and arg_205_1.var_.characterEffect10101ui_story then
				arg_205_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_208_2 = arg_205_1.actors_["10100ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.characterEffect10100ui_story == nil then
				arg_205_1.var_.characterEffect10100ui_story = var_208_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_3 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.characterEffect10100ui_story and not isNil(var_208_2) then
					arg_205_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_205_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_3)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.characterEffect10100ui_story then
				arg_205_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_205_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_208_4 = 0
			local var_208_5 = 0.175

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:GetWordFromCfg(320011050)
				local var_208_7 = arg_205_1:FormatText(var_208_6.content)

				arg_205_1.text_.text = var_208_7

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 7 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 7)

				if (7 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 7)) > 0 and var_208_5 < var_208_9 then
					arg_205_1.talkMaxDuration = var_208_9

					if var_208_9 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_7
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011050", "story_v_out_320011.awb") ~= 0 then
					local var_208_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011050", "story_v_out_320011.awb") / 1000

					if var_208_10 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_4
					end

					if var_208_6.prefab_name ~= "" and arg_205_1.actors_[var_208_6.prefab_name] ~= nil then
						local var_208_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_6.prefab_name].transform, "story_v_out_320011", "320011050", "story_v_out_320011.awb")

						arg_205_1:RecordAudio("320011050", var_208_11)
						arg_205_1:RecordAudio("320011050", var_208_11)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_320011", "320011050", "story_v_out_320011.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_320011", "320011050", "story_v_out_320011.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_12 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_12 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_12

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_12 and arg_205_1.time_ < var_208_4 + var_208_12 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play320011051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 320011051
		arg_209_1.duration_ = 11.4

		local var_209_0 = {
			zh = 9.766,
			ja = 11.4
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
				arg_209_0:Play320011052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["10100ui_story"]) and arg_209_1.var_.characterEffect10100ui_story == nil then
				arg_209_1.var_.characterEffect10100ui_story = arg_209_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["10100ui_story"]) then
				if arg_209_1.var_.characterEffect10100ui_story and not isNil(arg_209_1.actors_["10100ui_story"]) then
					arg_209_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["10100ui_story"]) and arg_209_1.var_.characterEffect10100ui_story then
				arg_209_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action41820")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_212_2 = arg_209_1.actors_["10101ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.characterEffect10101ui_story == nil then
				arg_209_1.var_.characterEffect10101ui_story = var_212_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_3 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 and not isNil(var_212_2) then
				if arg_209_1.var_.characterEffect10101ui_story and not isNil(var_212_2) then
					arg_209_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_209_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_3)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.characterEffect10101ui_story then
				arg_209_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_209_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_212_4 = 0
			local var_212_5 = 1.05

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(320011051)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 42 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 42)

				if (42 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 42)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011051", "story_v_out_320011.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011051", "story_v_out_320011.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_out_320011", "320011051", "story_v_out_320011.awb")

						arg_209_1:RecordAudio("320011051", var_212_11)
						arg_209_1:RecordAudio("320011051", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_320011", "320011051", "story_v_out_320011.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_320011", "320011051", "story_v_out_320011.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_12 and arg_209_1.time_ < var_212_4 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play320011052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 320011052
		arg_213_1.duration_ = 8.03

		local var_213_0 = {
			zh = 5.7,
			ja = 8.033
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
				arg_213_0:Play320011053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["10101ui_story"]) and arg_213_1.var_.characterEffect10101ui_story == nil then
				arg_213_1.var_.characterEffect10101ui_story = arg_213_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["10101ui_story"]) then
				if arg_213_1.var_.characterEffect10101ui_story and not isNil(arg_213_1.actors_["10101ui_story"]) then
					arg_213_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["10101ui_story"]) and arg_213_1.var_.characterEffect10101ui_story then
				arg_213_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_216_2 = arg_213_1.actors_["10100ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.characterEffect10100ui_story == nil then
				arg_213_1.var_.characterEffect10100ui_story = var_216_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_3 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.characterEffect10100ui_story and not isNil(var_216_2) then
					arg_213_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_213_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_3)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.characterEffect10100ui_story then
				arg_213_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_213_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_216_4 = 0
			local var_216_5 = 0.5

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(320011052)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 20 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 20)

				if (20 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 20)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011052", "story_v_out_320011.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011052", "story_v_out_320011.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_out_320011", "320011052", "story_v_out_320011.awb")

						arg_213_1:RecordAudio("320011052", var_216_11)
						arg_213_1:RecordAudio("320011052", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_320011", "320011052", "story_v_out_320011.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_320011", "320011052", "story_v_out_320011.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play320011053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 320011053
		arg_217_1.duration_ = 8.9

		local var_217_0 = {
			zh = 3.033,
			ja = 8.9
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
				arg_217_0:Play320011054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["10101ui_story"]) and arg_217_1.var_.characterEffect10101ui_story == nil then
				arg_217_1.var_.characterEffect10101ui_story = arg_217_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["10101ui_story"]) then
				if arg_217_1.var_.characterEffect10101ui_story and not isNil(arg_217_1.actors_["10101ui_story"]) then
					arg_217_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_217_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["10101ui_story"]) and arg_217_1.var_.characterEffect10101ui_story then
				arg_217_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_217_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_220_1 = arg_217_1.actors_["10100ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect10100ui_story == nil then
				arg_217_1.var_.characterEffect10100ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect10100ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect10100ui_story then
				arg_217_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action20_2")
			end

			local var_220_4 = 0
			local var_220_5 = 0.375

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_6 = arg_217_1:GetWordFromCfg(320011053)
				local var_220_7 = arg_217_1:FormatText(var_220_6.content)

				arg_217_1.text_.text = var_220_7

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_9 = 15 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 15)

				if (15 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 15)) > 0 and var_220_5 < var_220_9 then
					arg_217_1.talkMaxDuration = var_220_9

					if var_220_9 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_4
					end
				end

				arg_217_1.text_.text = var_220_7
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011053", "story_v_out_320011.awb") ~= 0 then
					local var_220_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011053", "story_v_out_320011.awb") / 1000

					if var_220_10 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_4
					end

					if var_220_6.prefab_name ~= "" and arg_217_1.actors_[var_220_6.prefab_name] ~= nil then
						local var_220_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_6.prefab_name].transform, "story_v_out_320011", "320011053", "story_v_out_320011.awb")

						arg_217_1:RecordAudio("320011053", var_220_11)
						arg_217_1:RecordAudio("320011053", var_220_11)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_320011", "320011053", "story_v_out_320011.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_320011", "320011053", "story_v_out_320011.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_12 = math.max(var_220_5, arg_217_1.talkMaxDuration)

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_12 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_4) / var_220_12

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_4 + var_220_12 and arg_217_1.time_ < var_220_4 + var_220_12 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play320011054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 320011054
		arg_221_1.duration_ = 9.13

		local var_221_0 = {
			zh = 9.133,
			ja = 7.366
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
				arg_221_0:Play320011055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["10101ui_story"]) and arg_221_1.var_.characterEffect10101ui_story == nil then
				arg_221_1.var_.characterEffect10101ui_story = arg_221_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["10101ui_story"]) then
				if arg_221_1.var_.characterEffect10101ui_story and not isNil(arg_221_1.actors_["10101ui_story"]) then
					arg_221_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["10101ui_story"]) and arg_221_1.var_.characterEffect10101ui_story then
				arg_221_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_224_2 = arg_221_1.actors_["10100ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.characterEffect10100ui_story == nil then
				arg_221_1.var_.characterEffect10100ui_story = var_224_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_3 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.characterEffect10100ui_story and not isNil(var_224_2) then
					arg_221_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_221_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_3)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.characterEffect10100ui_story then
				arg_221_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_221_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_224_4 = 0
			local var_224_5 = 1.025

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(320011054)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 41 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 41)

				if (41 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 41)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011054", "story_v_out_320011.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011054", "story_v_out_320011.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_out_320011", "320011054", "story_v_out_320011.awb")

						arg_221_1:RecordAudio("320011054", var_224_11)
						arg_221_1:RecordAudio("320011054", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_320011", "320011054", "story_v_out_320011.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_320011", "320011054", "story_v_out_320011.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_12 = math.max(var_224_5, arg_221_1.talkMaxDuration)

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_12 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_4) / var_224_12

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_4 + var_224_12 and arg_221_1.time_ < var_224_4 + var_224_12 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play320011055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 320011055
		arg_225_1.duration_ = 14.37

		local var_225_0 = {
			zh = 7.533,
			ja = 14.366
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
				arg_225_0:Play320011056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["10101ui_story"]) and arg_225_1.var_.characterEffect10101ui_story == nil then
				arg_225_1.var_.characterEffect10101ui_story = arg_225_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["10101ui_story"]) then
				if arg_225_1.var_.characterEffect10101ui_story and not isNil(arg_225_1.actors_["10101ui_story"]) then
					arg_225_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["10101ui_story"]) and arg_225_1.var_.characterEffect10101ui_story then
				arg_225_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_228_1 = arg_225_1.actors_["10100ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect10100ui_story == nil then
				arg_225_1.var_.characterEffect10100ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect10100ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect10100ui_story then
				arg_225_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_228_4 = 0
			local var_228_5 = 0.75

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:GetWordFromCfg(320011055)
				local var_228_7 = arg_225_1:FormatText(var_228_6.content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 30 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 30)

				if (30 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 30)) > 0 and var_228_5 < var_228_9 then
					arg_225_1.talkMaxDuration = var_228_9

					if var_228_9 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011055", "story_v_out_320011.awb") ~= 0 then
					local var_228_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011055", "story_v_out_320011.awb") / 1000

					if var_228_10 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_4
					end

					if var_228_6.prefab_name ~= "" and arg_225_1.actors_[var_228_6.prefab_name] ~= nil then
						local var_228_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_6.prefab_name].transform, "story_v_out_320011", "320011055", "story_v_out_320011.awb")

						arg_225_1:RecordAudio("320011055", var_228_11)
						arg_225_1:RecordAudio("320011055", var_228_11)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_320011", "320011055", "story_v_out_320011.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_320011", "320011055", "story_v_out_320011.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_12 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_12 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_12

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_12 and arg_225_1.time_ < var_228_4 + var_228_12 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play320011056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 320011056
		arg_229_1.duration_ = 4.4

		local var_229_0 = {
			zh = 4.066,
			ja = 4.4
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play320011057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["10101ui_story"]) and arg_229_1.var_.characterEffect10101ui_story == nil then
				arg_229_1.var_.characterEffect10101ui_story = arg_229_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["10101ui_story"]) then
				if arg_229_1.var_.characterEffect10101ui_story and not isNil(arg_229_1.actors_["10101ui_story"]) then
					arg_229_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["10101ui_story"]) and arg_229_1.var_.characterEffect10101ui_story then
				arg_229_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_232_2 = arg_229_1.actors_["10100ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect10100ui_story == nil then
				arg_229_1.var_.characterEffect10100ui_story = var_232_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_3 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_3 and not isNil(var_232_2) then
				if arg_229_1.var_.characterEffect10100ui_story and not isNil(var_232_2) then
					arg_229_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_229_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_3)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_3 and arg_229_1.time_ < 0 + var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect10100ui_story then
				arg_229_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_229_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_232_4 = 0
			local var_232_5 = 0.25

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(320011056)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 10 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 10)

				if (10 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 10)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011056", "story_v_out_320011.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011056", "story_v_out_320011.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_out_320011", "320011056", "story_v_out_320011.awb")

						arg_229_1:RecordAudio("320011056", var_232_11)
						arg_229_1:RecordAudio("320011056", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_320011", "320011056", "story_v_out_320011.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_320011", "320011056", "story_v_out_320011.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play320011057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 320011057
		arg_233_1.duration_ = 2.3

		local var_233_0 = {
			zh = 1.466,
			ja = 2.3
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play320011058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["10101ui_story"]) and arg_233_1.var_.characterEffect10101ui_story == nil then
				arg_233_1.var_.characterEffect10101ui_story = arg_233_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["10101ui_story"]) then
				if arg_233_1.var_.characterEffect10101ui_story and not isNil(arg_233_1.actors_["10101ui_story"]) then
					arg_233_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_233_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["10101ui_story"]) and arg_233_1.var_.characterEffect10101ui_story then
				arg_233_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_233_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_236_1 = arg_233_1.actors_["10100ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect10100ui_story == nil then
				arg_233_1.var_.characterEffect10100ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect10100ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect10100ui_story then
				arg_233_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_236_4 = 0
			local var_236_5 = 0.15

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(320011057)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 6 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 6)

				if (6 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 6)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011057", "story_v_out_320011.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011057", "story_v_out_320011.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_out_320011", "320011057", "story_v_out_320011.awb")

						arg_233_1:RecordAudio("320011057", var_236_11)
						arg_233_1:RecordAudio("320011057", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_320011", "320011057", "story_v_out_320011.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_320011", "320011057", "story_v_out_320011.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play320011058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 320011058
		arg_237_1.duration_ = 11.67

		local var_237_0 = {
			zh = 6.4,
			ja = 11.666
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
				arg_237_0:Play320011059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["10101ui_story"]) and arg_237_1.var_.characterEffect10101ui_story == nil then
				arg_237_1.var_.characterEffect10101ui_story = arg_237_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["10101ui_story"]) then
				if arg_237_1.var_.characterEffect10101ui_story and not isNil(arg_237_1.actors_["10101ui_story"]) then
					arg_237_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["10101ui_story"]) and arg_237_1.var_.characterEffect10101ui_story then
				arg_237_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			local var_240_2 = arg_237_1.actors_["10100ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.characterEffect10100ui_story == nil then
				arg_237_1.var_.characterEffect10100ui_story = var_240_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_3 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_3 and not isNil(var_240_2) then
				if arg_237_1.var_.characterEffect10100ui_story and not isNil(var_240_2) then
					arg_237_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_237_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_3)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_3 and arg_237_1.time_ < 0 + var_240_3 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.characterEffect10100ui_story then
				arg_237_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_237_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_2")
			end

			local var_240_4 = 0
			local var_240_5 = 0.775

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:GetWordFromCfg(320011058)
				local var_240_7 = arg_237_1:FormatText(var_240_6.content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 31 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 31)

				if (31 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 31)) > 0 and var_240_5 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011058", "story_v_out_320011.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011058", "story_v_out_320011.awb") / 1000

					if var_240_10 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_4
					end

					if var_240_6.prefab_name ~= "" and arg_237_1.actors_[var_240_6.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_6.prefab_name].transform, "story_v_out_320011", "320011058", "story_v_out_320011.awb")

						arg_237_1:RecordAudio("320011058", var_240_11)
						arg_237_1:RecordAudio("320011058", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_320011", "320011058", "story_v_out_320011.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_320011", "320011058", "story_v_out_320011.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_12 and arg_237_1.time_ < var_240_4 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play320011059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 320011059
		arg_241_1.duration_ = 14.2

		local var_241_0 = {
			zh = 12.7,
			ja = 14.2
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
				arg_241_0:Play320011060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 1.525

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:GetWordFromCfg(320011059)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 61 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 61)

				if (61 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 61)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011059", "story_v_out_320011.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011059", "story_v_out_320011.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_320011", "320011059", "story_v_out_320011.awb")

						arg_241_1:RecordAudio("320011059", var_244_6)
						arg_241_1:RecordAudio("320011059", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_320011", "320011059", "story_v_out_320011.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_320011", "320011059", "story_v_out_320011.awb")
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
	Play320011060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 320011060
		arg_245_1.duration_ = 4.47

		local var_245_0 = {
			zh = 2.266,
			ja = 4.466
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play320011061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["10100ui_story"]) and arg_245_1.var_.characterEffect10100ui_story == nil then
				arg_245_1.var_.characterEffect10100ui_story = arg_245_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["10100ui_story"]) then
				if arg_245_1.var_.characterEffect10100ui_story and not isNil(arg_245_1.actors_["10100ui_story"]) then
					arg_245_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["10100ui_story"]) and arg_245_1.var_.characterEffect10100ui_story then
				arg_245_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_248_2 = arg_245_1.actors_["10101ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.characterEffect10101ui_story == nil then
				arg_245_1.var_.characterEffect10101ui_story = var_248_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_3 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_3 and not isNil(var_248_2) then
				if arg_245_1.var_.characterEffect10101ui_story and not isNil(var_248_2) then
					arg_245_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_3)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_3 and arg_245_1.time_ < 0 + var_248_3 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.characterEffect10101ui_story then
				arg_245_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_248_4 = 0
			local var_248_5 = 0.275

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_6 = arg_245_1:GetWordFromCfg(320011060)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 11 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 11)

				if (11 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 11)) > 0 and var_248_5 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011060", "story_v_out_320011.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011060", "story_v_out_320011.awb") / 1000

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_out_320011", "320011060", "story_v_out_320011.awb")

						arg_245_1:RecordAudio("320011060", var_248_11)
						arg_245_1:RecordAudio("320011060", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_320011", "320011060", "story_v_out_320011.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_320011", "320011060", "story_v_out_320011.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_12 = math.max(var_248_5, arg_245_1.talkMaxDuration)

			if var_248_4 <= arg_245_1.time_ and arg_245_1.time_ < var_248_4 + var_248_12 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_4) / var_248_12

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_4 + var_248_12 and arg_245_1.time_ < var_248_4 + var_248_12 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play320011061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 320011061
		arg_249_1.duration_ = 4.4

		local var_249_0 = {
			zh = 3.133,
			ja = 4.4
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play320011062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["10100ui_story"]) and arg_249_1.var_.characterEffect10100ui_story == nil then
				arg_249_1.var_.characterEffect10100ui_story = arg_249_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["10100ui_story"]) then
				if arg_249_1.var_.characterEffect10100ui_story and not isNil(arg_249_1.actors_["10100ui_story"]) then
					arg_249_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["10100ui_story"]) and arg_249_1.var_.characterEffect10100ui_story then
				arg_249_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 0.35

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1024].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(320011061)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_6 = 14 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 14)

				if (14 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 14)) > 0 and var_252_2 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011061", "story_v_out_320011.awb") ~= 0 then
					local var_252_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011061", "story_v_out_320011.awb") / 1000

					if var_252_7 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_1
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_320011", "320011061", "story_v_out_320011.awb")

						arg_249_1:RecordAudio("320011061", var_252_8)
						arg_249_1:RecordAudio("320011061", var_252_8)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_320011", "320011061", "story_v_out_320011.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_320011", "320011061", "story_v_out_320011.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_9 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_9 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_9

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_9 and arg_249_1.time_ < var_252_1 + var_252_9 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play320011062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 320011062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play320011063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10100ui_story = arg_253_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10100ui_story"].transform.position).z)
				arg_253_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["10100ui_story"].transform.localEulerAngles = arg_253_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10100ui_story"].transform.position).z)
				arg_253_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["10100ui_story"].transform.localEulerAngles = arg_253_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["10100ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect10100ui_story == nil then
				arg_253_1.var_.characterEffect10100ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect10100ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_2)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect10100ui_story then
				arg_253_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_256_3 = arg_253_1.actors_["10101ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10101ui_story = var_256_3.localPosition
			end

			local var_256_4 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				var_256_3.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_4)
				var_256_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_3.position).x, (manager.ui.mainCamera.transform.position - var_256_3.position).y, (manager.ui.mainCamera.transform.position - var_256_3.position).z)
				var_256_3.localEulerAngles.z = 0
				var_256_3.localEulerAngles.x = 0
				var_256_3.localEulerAngles = var_256_3.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				var_256_3.localPosition = Vector3.New(0, 100, 0)
				var_256_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_3.position).x, (manager.ui.mainCamera.transform.position - var_256_3.position).y, (manager.ui.mainCamera.transform.position - var_256_3.position).z)
				var_256_3.localEulerAngles.z = 0
				var_256_3.localEulerAngles.x = 0
				var_256_3.localEulerAngles = var_256_3.localEulerAngles
			end

			local var_256_5 = arg_253_1.actors_["10101ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.characterEffect10101ui_story == nil then
				arg_253_1.var_.characterEffect10101ui_story = var_256_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_6 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_6 and not isNil(var_256_5) then
				if arg_253_1.var_.characterEffect10101ui_story and not isNil(var_256_5) then
					arg_253_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_6)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_6 and arg_253_1.time_ < 0 + var_256_6 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.characterEffect10101ui_story then
				arg_253_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			if 0.433333333333333 < arg_253_1.time_ and arg_253_1.time_ <= 0.433333333333333 + arg_256_0 then
				arg_253_1:AudioAction("play", "effect", "se_story_136", "se_story_136_tray", "")
			end

			local var_256_8 = 0
			local var_256_9 = 1.05

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_10 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(320011062).content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_12 = 42 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_10) / 42)

				if (42 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_10) / 42)) > 0 and var_256_9 < var_256_12 then
					arg_253_1.talkMaxDuration = var_256_12

					if var_256_12 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_12 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_10
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_13 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_13 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_13

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_13 and arg_253_1.time_ < var_256_8 + var_256_13 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play320011063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 320011063
		arg_257_1.duration_ = 7.43

		local var_257_0 = {
			zh = 3.066,
			ja = 7.433
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play320011064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos10100ui_story = arg_257_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10100ui_story"].transform.position).z)
				arg_257_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["10100ui_story"].transform.localEulerAngles = arg_257_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_257_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10100ui_story"].transform.position).z)
				arg_257_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["10100ui_story"].transform.localEulerAngles = arg_257_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["10100ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect10100ui_story == nil then
				arg_257_1.var_.characterEffect10100ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect10100ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect10100ui_story then
				arg_257_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_260_4 = 0
			local var_260_5 = 0.35

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(320011063)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 14 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 14)

				if (14 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 14)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011063", "story_v_out_320011.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011063", "story_v_out_320011.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_out_320011", "320011063", "story_v_out_320011.awb")

						arg_257_1:RecordAudio("320011063", var_260_11)
						arg_257_1:RecordAudio("320011063", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_320011", "320011063", "story_v_out_320011.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_320011", "320011063", "story_v_out_320011.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_12 and arg_257_1.time_ < var_260_4 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play320011064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 320011064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play320011065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10100ui_story = arg_261_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10100ui_story"].transform.position).z)
				arg_261_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["10100ui_story"].transform.localEulerAngles = arg_261_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10100ui_story"].transform.position).z)
				arg_261_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["10100ui_story"].transform.localEulerAngles = arg_261_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["10100ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect10100ui_story == nil then
				arg_261_1.var_.characterEffect10100ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect10100ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_261_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_2)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect10100ui_story then
				arg_261_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_261_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_264_3 = 0
			local var_264_4 = 1.2

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_3 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_5 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(320011064).content)

				arg_261_1.text_.text = var_264_5

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_7 = 48 <= 0 and var_264_4 or var_264_4 * (utf8.len(var_264_5) / 48)

				if (48 <= 0 and var_264_4 or var_264_4 * (utf8.len(var_264_5) / 48)) > 0 and var_264_4 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_3 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_3
					end
				end

				arg_261_1.text_.text = var_264_5
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_8 = math.max(var_264_4, arg_261_1.talkMaxDuration)

			if var_264_3 <= arg_261_1.time_ and arg_261_1.time_ < var_264_3 + var_264_8 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_3) / var_264_8

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_3 + var_264_8 and arg_261_1.time_ < var_264_3 + var_264_8 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play320011065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 320011065
		arg_265_1.duration_ = 2

		local var_265_0 = {
			zh = 2,
			ja = 1.666
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play320011066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.225

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_1 = arg_265_1:GetWordFromCfg(320011065)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 9 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 9)

				if (9 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 9)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011065", "story_v_out_320011.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011065", "story_v_out_320011.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_out_320011", "320011065", "story_v_out_320011.awb")

						arg_265_1:RecordAudio("320011065", var_268_6)
						arg_265_1:RecordAudio("320011065", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_320011", "320011065", "story_v_out_320011.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_320011", "320011065", "story_v_out_320011.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play320011066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 320011066
		arg_269_1.duration_ = 2.37

		local var_269_0 = {
			zh = 1.7,
			ja = 2.366
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play320011067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos10100ui_story = arg_269_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10100ui_story"].transform.position).z)
				arg_269_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["10100ui_story"].transform.localEulerAngles = arg_269_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_269_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10100ui_story"].transform.position).z)
				arg_269_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["10100ui_story"].transform.localEulerAngles = arg_269_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["10100ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect10100ui_story == nil then
				arg_269_1.var_.characterEffect10100ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect10100ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect10100ui_story then
				arg_269_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_272_4 = 0
			local var_272_5 = 0.2

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(320011066)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 8 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 8)

				if (8 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 8)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011066", "story_v_out_320011.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011066", "story_v_out_320011.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_320011", "320011066", "story_v_out_320011.awb")

						arg_269_1:RecordAudio("320011066", var_272_11)
						arg_269_1:RecordAudio("320011066", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_320011", "320011066", "story_v_out_320011.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_320011", "320011066", "story_v_out_320011.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play320011067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 320011067
		arg_273_1.duration_ = 15.37

		local var_273_0 = {
			zh = 7.933,
			ja = 15.366
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play320011068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["10100ui_story"]) and arg_273_1.var_.characterEffect10100ui_story == nil then
				arg_273_1.var_.characterEffect10100ui_story = arg_273_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["10100ui_story"]) then
				if arg_273_1.var_.characterEffect10100ui_story and not isNil(arg_273_1.actors_["10100ui_story"]) then
					arg_273_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_273_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["10100ui_story"]) and arg_273_1.var_.characterEffect10100ui_story then
				arg_273_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_273_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 0.75

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:GetWordFromCfg(320011067)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_6 = 30 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_4) / 30)

				if (30 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_4) / 30)) > 0 and var_276_2 < var_276_6 then
					arg_273_1.talkMaxDuration = var_276_6

					if var_276_6 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_6 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011067", "story_v_out_320011.awb") ~= 0 then
					local var_276_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011067", "story_v_out_320011.awb") / 1000

					if var_276_7 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_1
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_320011", "320011067", "story_v_out_320011.awb")

						arg_273_1:RecordAudio("320011067", var_276_8)
						arg_273_1:RecordAudio("320011067", var_276_8)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_320011", "320011067", "story_v_out_320011.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_320011", "320011067", "story_v_out_320011.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_9 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_9 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_9

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_9 and arg_273_1.time_ < var_276_1 + var_276_9 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play320011068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 320011068
		arg_277_1.duration_ = 7.13

		local var_277_0 = {
			zh = 2.633,
			ja = 7.133
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
				arg_277_0:Play320011069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10100ui_story = arg_277_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10100ui_story"].transform.position).z)
				arg_277_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["10100ui_story"].transform.localEulerAngles = arg_277_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_277_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10100ui_story"].transform.position).z)
				arg_277_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["10100ui_story"].transform.localEulerAngles = arg_277_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["10100ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect10100ui_story == nil then
				arg_277_1.var_.characterEffect10100ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect10100ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect10100ui_story then
				arg_277_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_280_4 = 0
			local var_280_5 = 0.3

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(320011068)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 12 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 12)

				if (12 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 12)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011068", "story_v_out_320011.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011068", "story_v_out_320011.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_out_320011", "320011068", "story_v_out_320011.awb")

						arg_277_1:RecordAudio("320011068", var_280_11)
						arg_277_1:RecordAudio("320011068", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_320011", "320011068", "story_v_out_320011.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_320011", "320011068", "story_v_out_320011.awb")
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
				actorName = "10100ui_story",
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
	Play320011069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 320011069
		arg_281_1.duration_ = 17.8

		local var_281_0 = {
			zh = 15.866,
			ja = 17.8
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play320011070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 2 < arg_281_1.time_ and arg_281_1.time_ <= 2 + arg_284_0 then
				local var_284_0 = arg_281_1.bgs_.ST0501

				arg_281_1.bgs_.ST0501.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_284_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_284_1 = var_284_0:GetComponent("SpriteRenderer")

				if var_284_1 and var_284_1.sprite then
					local var_284_2 = 2 * (var_284_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_284_0.transform.localScale = Vector3.New(var_284_2 / var_284_1.sprite.bounds.size.y < var_284_2 * manager.ui.mainCameraCom_.aspect / var_284_1.sprite.bounds.size.x and var_284_2 * manager.ui.mainCameraCom_.aspect / var_284_1.sprite.bounds.size.x or var_284_2 / var_284_1.sprite.bounds.size.y, var_284_2 / var_284_1.sprite.bounds.size.y < var_284_2 * manager.ui.mainCameraCom_.aspect / var_284_1.sprite.bounds.size.x and var_284_2 * manager.ui.mainCameraCom_.aspect / var_284_1.sprite.bounds.size.x or var_284_2 / var_284_1.sprite.bounds.size.y, 0)
				end

				for iter_284_0, iter_284_1 in pairs(arg_281_1.bgs_) do
					if iter_284_0 ~= "ST0501" then
						iter_284_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_284_3 = 4

			if 4 < arg_281_1.time_ and arg_281_1.time_ <= var_284_3 + arg_284_0 then
				arg_281_1.allBtn_.enabled = false
			end

			if arg_281_1.time_ >= var_284_3 + 0.3 and arg_281_1.time_ < var_284_3 + 0.3 + arg_284_0 then
				arg_281_1.allBtn_.enabled = true
			end

			local var_284_4 = 0

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_5 = 2

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_5 then
				local var_284_6 = Color.New(0, 0, 0)

				var_284_6.a = Mathf.Lerp(0, 1, (arg_281_1.time_ - var_284_4) / var_284_5)
				arg_281_1.mask_.color = var_284_6
			end

			if arg_281_1.time_ >= var_284_4 + var_284_5 and arg_281_1.time_ < var_284_4 + var_284_5 + arg_284_0 then
				local var_284_7 = Color.New(0, 0, 0)

				var_284_7.a = 1
				arg_281_1.mask_.color = var_284_7
			end

			local var_284_8 = 2

			if 2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_9 = 2

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_9 then
				local var_284_10 = Color.New(0, 0, 0)

				var_284_10.a = Mathf.Lerp(1, 0, (arg_281_1.time_ - var_284_8) / var_284_9)
				arg_281_1.mask_.color = var_284_10
			end

			if arg_281_1.time_ >= var_284_8 + var_284_9 and arg_281_1.time_ < var_284_8 + var_284_9 + arg_284_0 then
				local var_284_11 = Color.New(0, 0, 0)

				arg_281_1.mask_.enabled = false
				var_284_11.a = 0
				arg_281_1.mask_.color = var_284_11
			end

			local var_284_12 = arg_281_1.actors_["10100ui_story"].transform

			if 1.96599999815226 < arg_281_1.time_ and arg_281_1.time_ <= 1.96599999815226 + arg_284_0 then
				arg_281_1.var_.moveOldPos10100ui_story = var_284_12.localPosition
			end

			local var_284_13 = 0.001

			if 1.96599999815226 <= arg_281_1.time_ and arg_281_1.time_ < 1.96599999815226 + var_284_13 then
				var_284_12.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 1.96599999815226) / var_284_13)
				var_284_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_12.position).x, (manager.ui.mainCamera.transform.position - var_284_12.position).y, (manager.ui.mainCamera.transform.position - var_284_12.position).z)
				var_284_12.localEulerAngles.z = 0
				var_284_12.localEulerAngles.x = 0
				var_284_12.localEulerAngles = var_284_12.localEulerAngles
			end

			if arg_281_1.time_ >= 1.96599999815226 + var_284_13 and arg_281_1.time_ < 1.96599999815226 + var_284_13 + arg_284_0 then
				var_284_12.localPosition = Vector3.New(0, 100, 0)
				var_284_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_12.position).x, (manager.ui.mainCamera.transform.position - var_284_12.position).y, (manager.ui.mainCamera.transform.position - var_284_12.position).z)
				var_284_12.localEulerAngles.z = 0
				var_284_12.localEulerAngles.x = 0
				var_284_12.localEulerAngles = var_284_12.localEulerAngles
			end

			local var_284_14 = arg_281_1.actors_["10100ui_story"]

			if 1.96599999815226 < arg_281_1.time_ and arg_281_1.time_ <= 1.96599999815226 + arg_284_0 and not isNil(var_284_14) and arg_281_1.var_.characterEffect10100ui_story == nil then
				arg_281_1.var_.characterEffect10100ui_story = var_284_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_15 = 0.034000001847744

			if 1.96599999815226 <= arg_281_1.time_ and arg_281_1.time_ < 1.96599999815226 + var_284_15 and not isNil(var_284_14) then
				if arg_281_1.var_.characterEffect10100ui_story and not isNil(var_284_14) then
					arg_281_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_281_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 1.96599999815226) / var_284_15)
				end
			end

			if arg_281_1.time_ >= 1.96599999815226 + var_284_15 and arg_281_1.time_ < 1.96599999815226 + var_284_15 + arg_284_0 and not isNil(var_284_14) and arg_281_1.var_.characterEffect10100ui_story then
				arg_281_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_281_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if arg_281_1.frameCnt_ <= 1 then
				arg_281_1.dialog_:SetActive(false)
			end

			local var_284_16 = 4
			local var_284_17 = 1.4

			if 4 < arg_281_1.time_ and arg_281_1.time_ <= var_284_16 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				arg_281_1.dialog_:SetActive(true)

				arg_281_1.dialogCg_.alpha = 0

				local var_284_18 = LeanTween.value(arg_281_1.dialog_, 0, 1, 0.3)

				var_284_18:setOnUpdate(LuaHelper.FloatAction(function(arg_285_0)
					arg_281_1.dialogCg_.alpha = arg_285_0
				end))
				var_284_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_281_1.dialog_)
					var_284_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_281_1.duration_ = arg_281_1.duration_ + 0.3

				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_19 = arg_281_1:GetWordFromCfg(320011069)
				local var_284_20 = arg_281_1:FormatText(var_284_19.content)

				arg_281_1.text_.text = var_284_20

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_22 = 56 <= 0 and var_284_17 or var_284_17 * (utf8.len(var_284_20) / 56)

				if (56 <= 0 and var_284_17 or var_284_17 * (utf8.len(var_284_20) / 56)) > 0 and var_284_17 < var_284_22 then
					arg_281_1.talkMaxDuration = var_284_22
					var_284_16 = var_284_16 + 0.3

					if var_284_22 + var_284_16 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_22 + var_284_16
					end
				end

				arg_281_1.text_.text = var_284_20
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011069", "story_v_out_320011.awb") ~= 0 then
					local var_284_23 = manager.audio:GetVoiceLength("story_v_out_320011", "320011069", "story_v_out_320011.awb") / 1000

					if var_284_23 + var_284_16 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_23 + var_284_16
					end

					if var_284_19.prefab_name ~= "" and arg_281_1.actors_[var_284_19.prefab_name] ~= nil then
						local var_284_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_19.prefab_name].transform, "story_v_out_320011", "320011069", "story_v_out_320011.awb")

						arg_281_1:RecordAudio("320011069", var_284_24)
						arg_281_1:RecordAudio("320011069", var_284_24)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_320011", "320011069", "story_v_out_320011.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_320011", "320011069", "story_v_out_320011.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_25 = var_284_16 + 0.3
			local var_284_26 = math.max(var_284_17, arg_281_1.talkMaxDuration)

			if var_284_16 + 0.3 <= arg_281_1.time_ and arg_281_1.time_ < var_284_25 + var_284_26 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_25) / var_284_26

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_25 + var_284_26 and arg_281_1.time_ < var_284_25 + var_284_26 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play320011070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 320011070
		arg_287_1.duration_ = 6

		local var_287_0 = {
			zh = 5.133,
			ja = 6
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
				arg_287_0:Play320011071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.625

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_1 = arg_287_1:GetWordFromCfg(320011070)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 25 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 25)

				if (25 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 25)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011070", "story_v_out_320011.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011070", "story_v_out_320011.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_320011", "320011070", "story_v_out_320011.awb")

						arg_287_1:RecordAudio("320011070", var_290_6)
						arg_287_1:RecordAudio("320011070", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_320011", "320011070", "story_v_out_320011.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_320011", "320011070", "story_v_out_320011.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play320011071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 320011071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play320011072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 1.25

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(320011071).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 50 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 50)

				if (50 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 50)) > 0 and var_294_0 < var_294_3 then
					arg_291_1.talkMaxDuration = var_294_3

					if var_294_3 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_3 + 0
					end
				end

				arg_291_1.text_.text = var_294_1
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_4 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_4

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play320011072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 320011072
		arg_295_1.duration_ = 4.23

		local var_295_0 = {
			zh = 2.6,
			ja = 4.233
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
				arg_295_0:Play320011073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.2

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:GetWordFromCfg(320011072)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 8 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 8)

				if (8 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 8)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011072", "story_v_out_320011.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011072", "story_v_out_320011.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_out_320011", "320011072", "story_v_out_320011.awb")

						arg_295_1:RecordAudio("320011072", var_298_6)
						arg_295_1:RecordAudio("320011072", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_320011", "320011072", "story_v_out_320011.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_320011", "320011072", "story_v_out_320011.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play320011073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 320011073
		arg_299_1.duration_ = 4.23

		local var_299_0 = {
			zh = 2.1,
			ja = 4.233
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
				arg_299_0:Play320011074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10100ui_story = arg_299_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10100ui_story"].transform.position).z)
				arg_299_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["10100ui_story"].transform.localEulerAngles = arg_299_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_299_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10100ui_story"].transform.position).z)
				arg_299_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["10100ui_story"].transform.localEulerAngles = arg_299_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_302_1 = arg_299_1.actors_["10100ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect10100ui_story == nil then
				arg_299_1.var_.characterEffect10100ui_story = var_302_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 and not isNil(var_302_1) then
				if arg_299_1.var_.characterEffect10100ui_story and not isNil(var_302_1) then
					arg_299_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect10100ui_story then
				arg_299_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_302_4 = 0
			local var_302_5 = 0.275

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_6 = arg_299_1:GetWordFromCfg(320011073)
				local var_302_7 = arg_299_1:FormatText(var_302_6.content)

				arg_299_1.text_.text = var_302_7

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_9 = 11 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 11)

				if (11 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 11)) > 0 and var_302_5 < var_302_9 then
					arg_299_1.talkMaxDuration = var_302_9

					if var_302_9 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_9 + var_302_4
					end
				end

				arg_299_1.text_.text = var_302_7
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011073", "story_v_out_320011.awb") ~= 0 then
					local var_302_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011073", "story_v_out_320011.awb") / 1000

					if var_302_10 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_4
					end

					if var_302_6.prefab_name ~= "" and arg_299_1.actors_[var_302_6.prefab_name] ~= nil then
						local var_302_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_6.prefab_name].transform, "story_v_out_320011", "320011073", "story_v_out_320011.awb")

						arg_299_1:RecordAudio("320011073", var_302_11)
						arg_299_1:RecordAudio("320011073", var_302_11)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_320011", "320011073", "story_v_out_320011.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_320011", "320011073", "story_v_out_320011.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_12 = math.max(var_302_5, arg_299_1.talkMaxDuration)

			if var_302_4 <= arg_299_1.time_ and arg_299_1.time_ < var_302_4 + var_302_12 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_4) / var_302_12

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_4 + var_302_12 and arg_299_1.time_ < var_302_4 + var_302_12 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play320011074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 320011074
		arg_303_1.duration_ = 7.6

		local var_303_0 = {
			zh = 7.6,
			ja = 5.466
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
				arg_303_0:Play320011075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["10100ui_story"]) and arg_303_1.var_.characterEffect10100ui_story == nil then
				arg_303_1.var_.characterEffect10100ui_story = arg_303_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["10100ui_story"]) then
				if arg_303_1.var_.characterEffect10100ui_story and not isNil(arg_303_1.actors_["10100ui_story"]) then
					arg_303_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_303_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["10100ui_story"]) and arg_303_1.var_.characterEffect10100ui_story then
				arg_303_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_303_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.475

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_3 = arg_303_1:GetWordFromCfg(320011074)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_6 = 19 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_4) / 19)

				if (19 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_4) / 19)) > 0 and var_306_2 < var_306_6 then
					arg_303_1.talkMaxDuration = var_306_6

					if var_306_6 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_6 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011074", "story_v_out_320011.awb") ~= 0 then
					local var_306_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011074", "story_v_out_320011.awb") / 1000

					if var_306_7 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_1
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_out_320011", "320011074", "story_v_out_320011.awb")

						arg_303_1:RecordAudio("320011074", var_306_8)
						arg_303_1:RecordAudio("320011074", var_306_8)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_320011", "320011074", "story_v_out_320011.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_320011", "320011074", "story_v_out_320011.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_9 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_9 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_9

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_9 and arg_303_1.time_ < var_306_1 + var_306_9 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play320011075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 320011075
		arg_307_1.duration_ = 15.5

		local var_307_0 = {
			zh = 9.633,
			ja = 15.5
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
				arg_307_0:Play320011076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 1

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_1 = arg_307_1:GetWordFromCfg(320011075)
				local var_310_2 = arg_307_1:FormatText(var_310_1.content)

				arg_307_1.text_.text = var_310_2

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 40 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 40)

				if (40 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 40)) > 0 and var_310_0 < var_310_4 then
					arg_307_1.talkMaxDuration = var_310_4

					if var_310_4 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_4 + 0
					end
				end

				arg_307_1.text_.text = var_310_2
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011075", "story_v_out_320011.awb") ~= 0 then
					local var_310_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011075", "story_v_out_320011.awb") / 1000

					if var_310_5 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + 0
					end

					if var_310_1.prefab_name ~= "" and arg_307_1.actors_[var_310_1.prefab_name] ~= nil then
						local var_310_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_1.prefab_name].transform, "story_v_out_320011", "320011075", "story_v_out_320011.awb")

						arg_307_1:RecordAudio("320011075", var_310_6)
						arg_307_1:RecordAudio("320011075", var_310_6)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_320011", "320011075", "story_v_out_320011.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_320011", "320011075", "story_v_out_320011.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_7 and arg_307_1.time_ < 0 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play320011076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 320011076
		arg_311_1.duration_ = 15.03

		local var_311_0 = {
			zh = 7.866,
			ja = 15.033
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
				arg_311_0:Play320011077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["10100ui_story"]) and arg_311_1.var_.characterEffect10100ui_story == nil then
				arg_311_1.var_.characterEffect10100ui_story = arg_311_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["10100ui_story"]) then
				if arg_311_1.var_.characterEffect10100ui_story and not isNil(arg_311_1.actors_["10100ui_story"]) then
					arg_311_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["10100ui_story"]) and arg_311_1.var_.characterEffect10100ui_story then
				arg_311_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_314_2 = 0
			local var_314_3 = 0.9

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_2 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_4 = arg_311_1:GetWordFromCfg(320011076)
				local var_314_5 = arg_311_1:FormatText(var_314_4.content)

				arg_311_1.text_.text = var_314_5

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_7 = 36 <= 0 and var_314_3 or var_314_3 * (utf8.len(var_314_5) / 36)

				if (36 <= 0 and var_314_3 or var_314_3 * (utf8.len(var_314_5) / 36)) > 0 and var_314_3 < var_314_7 then
					arg_311_1.talkMaxDuration = var_314_7

					if var_314_7 + var_314_2 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_7 + var_314_2
					end
				end

				arg_311_1.text_.text = var_314_5
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011076", "story_v_out_320011.awb") ~= 0 then
					local var_314_8 = manager.audio:GetVoiceLength("story_v_out_320011", "320011076", "story_v_out_320011.awb") / 1000

					if var_314_8 + var_314_2 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_8 + var_314_2
					end

					if var_314_4.prefab_name ~= "" and arg_311_1.actors_[var_314_4.prefab_name] ~= nil then
						local var_314_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_4.prefab_name].transform, "story_v_out_320011", "320011076", "story_v_out_320011.awb")

						arg_311_1:RecordAudio("320011076", var_314_9)
						arg_311_1:RecordAudio("320011076", var_314_9)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_320011", "320011076", "story_v_out_320011.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_320011", "320011076", "story_v_out_320011.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_10 = math.max(var_314_3, arg_311_1.talkMaxDuration)

			if var_314_2 <= arg_311_1.time_ and arg_311_1.time_ < var_314_2 + var_314_10 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_2) / var_314_10

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_2 + var_314_10 and arg_311_1.time_ < var_314_2 + var_314_10 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play320011077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 320011077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play320011078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["10100ui_story"]) and arg_315_1.var_.characterEffect10100ui_story == nil then
				arg_315_1.var_.characterEffect10100ui_story = arg_315_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["10100ui_story"]) then
				if arg_315_1.var_.characterEffect10100ui_story and not isNil(arg_315_1.actors_["10100ui_story"]) then
					arg_315_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_315_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["10100ui_story"]) and arg_315_1.var_.characterEffect10100ui_story then
				arg_315_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_315_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_318_1 = 0
			local var_318_2 = 1.325

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

				local var_318_3 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(320011077).content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 53 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 53)

				if (53 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 53)) > 0 and var_318_2 < var_318_5 then
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
	Play320011078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 320011078
		arg_319_1.duration_ = 10.37

		local var_319_0 = {
			zh = 6.533,
			ja = 10.366
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
				arg_319_0:Play320011079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0.525

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_1 = arg_319_1:GetWordFromCfg(320011078)
				local var_322_2 = arg_319_1:FormatText(var_322_1.content)

				arg_319_1.text_.text = var_322_2

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 21 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 21)

				if (21 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 21)) > 0 and var_322_0 < var_322_4 then
					arg_319_1.talkMaxDuration = var_322_4

					if var_322_4 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_4 + 0
					end
				end

				arg_319_1.text_.text = var_322_2
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011078", "story_v_out_320011.awb") ~= 0 then
					local var_322_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011078", "story_v_out_320011.awb") / 1000

					if var_322_5 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + 0
					end

					if var_322_1.prefab_name ~= "" and arg_319_1.actors_[var_322_1.prefab_name] ~= nil then
						local var_322_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_1.prefab_name].transform, "story_v_out_320011", "320011078", "story_v_out_320011.awb")

						arg_319_1:RecordAudio("320011078", var_322_6)
						arg_319_1:RecordAudio("320011078", var_322_6)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_320011", "320011078", "story_v_out_320011.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_320011", "320011078", "story_v_out_320011.awb")
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
	Play320011079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 320011079
		arg_323_1.duration_ = 16.83

		local var_323_0 = {
			zh = 8.3,
			ja = 16.833
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
				arg_323_0:Play320011080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["10100ui_story"]) and arg_323_1.var_.characterEffect10100ui_story == nil then
				arg_323_1.var_.characterEffect10100ui_story = arg_323_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["10100ui_story"]) then
				if arg_323_1.var_.characterEffect10100ui_story and not isNil(arg_323_1.actors_["10100ui_story"]) then
					arg_323_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["10100ui_story"]) and arg_323_1.var_.characterEffect10100ui_story then
				arg_323_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_326_2 = 0
			local var_326_3 = 1.025

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_2 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_4 = arg_323_1:GetWordFromCfg(320011079)
				local var_326_5 = arg_323_1:FormatText(var_326_4.content)

				arg_323_1.text_.text = var_326_5

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_7 = 41 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 41)

				if (41 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 41)) > 0 and var_326_3 < var_326_7 then
					arg_323_1.talkMaxDuration = var_326_7

					if var_326_7 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_7 + var_326_2
					end
				end

				arg_323_1.text_.text = var_326_5
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011079", "story_v_out_320011.awb") ~= 0 then
					local var_326_8 = manager.audio:GetVoiceLength("story_v_out_320011", "320011079", "story_v_out_320011.awb") / 1000

					if var_326_8 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_8 + var_326_2
					end

					if var_326_4.prefab_name ~= "" and arg_323_1.actors_[var_326_4.prefab_name] ~= nil then
						local var_326_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_4.prefab_name].transform, "story_v_out_320011", "320011079", "story_v_out_320011.awb")

						arg_323_1:RecordAudio("320011079", var_326_9)
						arg_323_1:RecordAudio("320011079", var_326_9)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_320011", "320011079", "story_v_out_320011.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_320011", "320011079", "story_v_out_320011.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_10 = math.max(var_326_3, arg_323_1.talkMaxDuration)

			if var_326_2 <= arg_323_1.time_ and arg_323_1.time_ < var_326_2 + var_326_10 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_2) / var_326_10

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_2 + var_326_10 and arg_323_1.time_ < var_326_2 + var_326_10 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play320011080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 320011080
		arg_327_1.duration_ = 8.43

		local var_327_0 = {
			zh = 8.366,
			ja = 8.433
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
				arg_327_0:Play320011081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["10100ui_story"]) and arg_327_1.var_.characterEffect10100ui_story == nil then
				arg_327_1.var_.characterEffect10100ui_story = arg_327_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["10100ui_story"]) then
				if arg_327_1.var_.characterEffect10100ui_story and not isNil(arg_327_1.actors_["10100ui_story"]) then
					arg_327_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_327_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_0)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["10100ui_story"]) and arg_327_1.var_.characterEffect10100ui_story then
				arg_327_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_327_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_330_1 = 0
			local var_330_2 = 0.775

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_3 = arg_327_1:GetWordFromCfg(320011080)
				local var_330_4 = arg_327_1:FormatText(var_330_3.content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_6 = 31 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_4) / 31)

				if (31 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_4) / 31)) > 0 and var_330_2 < var_330_6 then
					arg_327_1.talkMaxDuration = var_330_6

					if var_330_6 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_6 + var_330_1
					end
				end

				arg_327_1.text_.text = var_330_4
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011080", "story_v_out_320011.awb") ~= 0 then
					local var_330_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011080", "story_v_out_320011.awb") / 1000

					if var_330_7 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_1
					end

					if var_330_3.prefab_name ~= "" and arg_327_1.actors_[var_330_3.prefab_name] ~= nil then
						local var_330_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_3.prefab_name].transform, "story_v_out_320011", "320011080", "story_v_out_320011.awb")

						arg_327_1:RecordAudio("320011080", var_330_8)
						arg_327_1:RecordAudio("320011080", var_330_8)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_320011", "320011080", "story_v_out_320011.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_320011", "320011080", "story_v_out_320011.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_9 = math.max(var_330_2, arg_327_1.talkMaxDuration)

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_9 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_1) / var_330_9

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_1 + var_330_9 and arg_327_1.time_ < var_330_1 + var_330_9 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play320011081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 320011081
		arg_331_1.duration_ = 10.23

		local var_331_0 = {
			zh = 10.233,
			ja = 9.333
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
				arg_331_0:Play320011082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["10100ui_story"]) and arg_331_1.var_.characterEffect10100ui_story == nil then
				arg_331_1.var_.characterEffect10100ui_story = arg_331_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["10100ui_story"]) then
				if arg_331_1.var_.characterEffect10100ui_story and not isNil(arg_331_1.actors_["10100ui_story"]) then
					arg_331_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["10100ui_story"]) and arg_331_1.var_.characterEffect10100ui_story then
				arg_331_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_334_2 = 0
			local var_334_3 = 0.95

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_2 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_4 = arg_331_1:GetWordFromCfg(320011081)
				local var_334_5 = arg_331_1:FormatText(var_334_4.content)

				arg_331_1.text_.text = var_334_5

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_7 = 38 <= 0 and var_334_3 or var_334_3 * (utf8.len(var_334_5) / 38)

				if (38 <= 0 and var_334_3 or var_334_3 * (utf8.len(var_334_5) / 38)) > 0 and var_334_3 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_2 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_2
					end
				end

				arg_331_1.text_.text = var_334_5
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011081", "story_v_out_320011.awb") ~= 0 then
					local var_334_8 = manager.audio:GetVoiceLength("story_v_out_320011", "320011081", "story_v_out_320011.awb") / 1000

					if var_334_8 + var_334_2 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_8 + var_334_2
					end

					if var_334_4.prefab_name ~= "" and arg_331_1.actors_[var_334_4.prefab_name] ~= nil then
						local var_334_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_4.prefab_name].transform, "story_v_out_320011", "320011081", "story_v_out_320011.awb")

						arg_331_1:RecordAudio("320011081", var_334_9)
						arg_331_1:RecordAudio("320011081", var_334_9)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_320011", "320011081", "story_v_out_320011.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_320011", "320011081", "story_v_out_320011.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_10 = math.max(var_334_3, arg_331_1.talkMaxDuration)

			if var_334_2 <= arg_331_1.time_ and arg_331_1.time_ < var_334_2 + var_334_10 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_2) / var_334_10

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_2 + var_334_10 and arg_331_1.time_ < var_334_2 + var_334_10 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play320011082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 320011082
		arg_335_1.duration_ = 10.9

		local var_335_0 = {
			zh = 9.6,
			ja = 10.9
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
				arg_335_0:Play320011083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_338_0 = 0
			local var_338_1 = 1

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_2 = arg_335_1:GetWordFromCfg(320011082)
				local var_338_3 = arg_335_1:FormatText(var_338_2.content)

				arg_335_1.text_.text = var_338_3

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 40 <= 0 and var_338_1 or var_338_1 * (utf8.len(var_338_3) / 40)

				if (40 <= 0 and var_338_1 or var_338_1 * (utf8.len(var_338_3) / 40)) > 0 and var_338_1 < var_338_5 then
					arg_335_1.talkMaxDuration = var_338_5

					if var_338_5 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_3
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011082", "story_v_out_320011.awb") ~= 0 then
					local var_338_6 = manager.audio:GetVoiceLength("story_v_out_320011", "320011082", "story_v_out_320011.awb") / 1000

					if var_338_6 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_6 + var_338_0
					end

					if var_338_2.prefab_name ~= "" and arg_335_1.actors_[var_338_2.prefab_name] ~= nil then
						local var_338_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_2.prefab_name].transform, "story_v_out_320011", "320011082", "story_v_out_320011.awb")

						arg_335_1:RecordAudio("320011082", var_338_7)
						arg_335_1:RecordAudio("320011082", var_338_7)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_320011", "320011082", "story_v_out_320011.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_320011", "320011082", "story_v_out_320011.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_8 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_8 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_8

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_8 and arg_335_1.time_ < var_338_0 + var_338_8 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play320011083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 320011083
		arg_339_1.duration_ = 15.17

		local var_339_0 = {
			zh = 11.9,
			ja = 15.166
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
				arg_339_0:Play320011084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["10100ui_story"]) and arg_339_1.var_.characterEffect10100ui_story == nil then
				arg_339_1.var_.characterEffect10100ui_story = arg_339_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["10100ui_story"]) then
				if arg_339_1.var_.characterEffect10100ui_story and not isNil(arg_339_1.actors_["10100ui_story"]) then
					arg_339_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_339_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_0)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["10100ui_story"]) and arg_339_1.var_.characterEffect10100ui_story then
				arg_339_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_339_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_342_1 = 0
			local var_342_2 = 1.075

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_3 = arg_339_1:GetWordFromCfg(320011083)
				local var_342_4 = arg_339_1:FormatText(var_342_3.content)

				arg_339_1.text_.text = var_342_4

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_6 = 43 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_4) / 43)

				if (43 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_4) / 43)) > 0 and var_342_2 < var_342_6 then
					arg_339_1.talkMaxDuration = var_342_6

					if var_342_6 + var_342_1 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_6 + var_342_1
					end
				end

				arg_339_1.text_.text = var_342_4
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011083", "story_v_out_320011.awb") ~= 0 then
					local var_342_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011083", "story_v_out_320011.awb") / 1000

					if var_342_7 + var_342_1 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_1
					end

					if var_342_3.prefab_name ~= "" and arg_339_1.actors_[var_342_3.prefab_name] ~= nil then
						local var_342_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_3.prefab_name].transform, "story_v_out_320011", "320011083", "story_v_out_320011.awb")

						arg_339_1:RecordAudio("320011083", var_342_8)
						arg_339_1:RecordAudio("320011083", var_342_8)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_320011", "320011083", "story_v_out_320011.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_320011", "320011083", "story_v_out_320011.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_9 = math.max(var_342_2, arg_339_1.talkMaxDuration)

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_9 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_1) / var_342_9

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_1 + var_342_9 and arg_339_1.time_ < var_342_1 + var_342_9 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play320011084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 320011084
		arg_343_1.duration_ = 8.4

		local var_343_0 = {
			zh = 5.366,
			ja = 8.4
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
				arg_343_0:Play320011085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.6

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_1 = arg_343_1:GetWordFromCfg(320011084)
				local var_346_2 = arg_343_1:FormatText(var_346_1.content)

				arg_343_1.text_.text = var_346_2

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 24 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 24)

				if (24 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 24)) > 0 and var_346_0 < var_346_4 then
					arg_343_1.talkMaxDuration = var_346_4

					if var_346_4 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_4 + 0
					end
				end

				arg_343_1.text_.text = var_346_2
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011084", "story_v_out_320011.awb") ~= 0 then
					local var_346_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011084", "story_v_out_320011.awb") / 1000

					if var_346_5 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + 0
					end

					if var_346_1.prefab_name ~= "" and arg_343_1.actors_[var_346_1.prefab_name] ~= nil then
						local var_346_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_1.prefab_name].transform, "story_v_out_320011", "320011084", "story_v_out_320011.awb")

						arg_343_1:RecordAudio("320011084", var_346_6)
						arg_343_1:RecordAudio("320011084", var_346_6)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_320011", "320011084", "story_v_out_320011.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_320011", "320011084", "story_v_out_320011.awb")
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
	Play320011085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 320011085
		arg_347_1.duration_ = 13.5

		local var_347_0 = {
			zh = 7.433,
			ja = 13.5
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
				arg_347_0:Play320011086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["10100ui_story"]) and arg_347_1.var_.characterEffect10100ui_story == nil then
				arg_347_1.var_.characterEffect10100ui_story = arg_347_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["10100ui_story"]) then
				if arg_347_1.var_.characterEffect10100ui_story and not isNil(arg_347_1.actors_["10100ui_story"]) then
					arg_347_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["10100ui_story"]) and arg_347_1.var_.characterEffect10100ui_story then
				arg_347_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action445")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_350_2 = 0
			local var_350_3 = 0.875

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_2 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_4 = arg_347_1:GetWordFromCfg(320011085)
				local var_350_5 = arg_347_1:FormatText(var_350_4.content)

				arg_347_1.text_.text = var_350_5

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_7 = 35 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 35)

				if (35 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 35)) > 0 and var_350_3 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_2
					end
				end

				arg_347_1.text_.text = var_350_5
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011085", "story_v_out_320011.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_320011", "320011085", "story_v_out_320011.awb") / 1000

					if var_350_8 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_2
					end

					if var_350_4.prefab_name ~= "" and arg_347_1.actors_[var_350_4.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_4.prefab_name].transform, "story_v_out_320011", "320011085", "story_v_out_320011.awb")

						arg_347_1:RecordAudio("320011085", var_350_9)
						arg_347_1:RecordAudio("320011085", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_320011", "320011085", "story_v_out_320011.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_320011", "320011085", "story_v_out_320011.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_3, arg_347_1.talkMaxDuration)

			if var_350_2 <= arg_347_1.time_ and arg_347_1.time_ < var_350_2 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_2) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_2 + var_350_10 and arg_347_1.time_ < var_350_2 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play320011086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 320011086
		arg_351_1.duration_ = 5.77

		local var_351_0 = {
			zh = 5.766,
			ja = 5.666
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
				arg_351_0:Play320011087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["10100ui_story"]) and arg_351_1.var_.characterEffect10100ui_story == nil then
				arg_351_1.var_.characterEffect10100ui_story = arg_351_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["10100ui_story"]) then
				if arg_351_1.var_.characterEffect10100ui_story and not isNil(arg_351_1.actors_["10100ui_story"]) then
					arg_351_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_351_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["10100ui_story"]) and arg_351_1.var_.characterEffect10100ui_story then
				arg_351_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_351_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_354_1 = 0
			local var_354_2 = 0.45

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:GetWordFromCfg(320011086)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_6 = 18 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_4) / 18)

				if (18 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_4) / 18)) > 0 and var_354_2 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6

					if var_354_6 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_1
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011086", "story_v_out_320011.awb") ~= 0 then
					local var_354_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011086", "story_v_out_320011.awb") / 1000

					if var_354_7 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_1
					end

					if var_354_3.prefab_name ~= "" and arg_351_1.actors_[var_354_3.prefab_name] ~= nil then
						local var_354_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_3.prefab_name].transform, "story_v_out_320011", "320011086", "story_v_out_320011.awb")

						arg_351_1:RecordAudio("320011086", var_354_8)
						arg_351_1:RecordAudio("320011086", var_354_8)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_320011", "320011086", "story_v_out_320011.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_320011", "320011086", "story_v_out_320011.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_9 = math.max(var_354_2, arg_351_1.talkMaxDuration)

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_9 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_1) / var_354_9

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_1 + var_354_9 and arg_351_1.time_ < var_354_1 + var_354_9 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play320011087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 320011087
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play320011088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos10100ui_story = arg_355_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_358_0 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 then
				arg_355_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_355_1.time_ - 0) / var_358_0)
				arg_355_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["10100ui_story"].transform.position).z)
				arg_355_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["10100ui_story"].transform.localEulerAngles = arg_355_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 then
				arg_355_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_355_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["10100ui_story"].transform.position).z)
				arg_355_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["10100ui_story"].transform.localEulerAngles = arg_355_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_358_1 = 0
			local var_358_2 = 1.525

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(320011087).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 61 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 61)

				if (61 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 61)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play320011088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 320011088
		arg_359_1.duration_ = 9.53

		local var_359_0 = {
			zh = 9.466,
			ja = 9.533
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
				arg_359_0:Play320011089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 1.025

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_1 = arg_359_1:GetWordFromCfg(320011088)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 41 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 41)

				if (41 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 41)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011088", "story_v_out_320011.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011088", "story_v_out_320011.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_out_320011", "320011088", "story_v_out_320011.awb")

						arg_359_1:RecordAudio("320011088", var_362_6)
						arg_359_1:RecordAudio("320011088", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_320011", "320011088", "story_v_out_320011.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_320011", "320011088", "story_v_out_320011.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_7 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_7 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_7

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_7 and arg_359_1.time_ < 0 + var_362_7 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play320011089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 320011089
		arg_363_1.duration_ = 14

		local var_363_0 = {
			zh = 14,
			ja = 9.8
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
				arg_363_0:Play320011090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 1.425

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_1 = arg_363_1:GetWordFromCfg(320011089)
				local var_366_2 = arg_363_1:FormatText(var_366_1.content)

				arg_363_1.text_.text = var_366_2

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 56 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 56)

				if (56 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 56)) > 0 and var_366_0 < var_366_4 then
					arg_363_1.talkMaxDuration = var_366_4

					if var_366_4 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_4 + 0
					end
				end

				arg_363_1.text_.text = var_366_2
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011089", "story_v_out_320011.awb") ~= 0 then
					local var_366_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011089", "story_v_out_320011.awb") / 1000

					if var_366_5 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + 0
					end

					if var_366_1.prefab_name ~= "" and arg_363_1.actors_[var_366_1.prefab_name] ~= nil then
						local var_366_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_1.prefab_name].transform, "story_v_out_320011", "320011089", "story_v_out_320011.awb")

						arg_363_1:RecordAudio("320011089", var_366_6)
						arg_363_1:RecordAudio("320011089", var_366_6)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_320011", "320011089", "story_v_out_320011.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_320011", "320011089", "story_v_out_320011.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play320011090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 320011090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play320011091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos10100ui_story = arg_367_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10100ui_story"].transform.position).z)
				arg_367_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["10100ui_story"].transform.localEulerAngles = arg_367_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_367_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10100ui_story"].transform.position).z)
				arg_367_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["10100ui_story"].transform.localEulerAngles = arg_367_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_370_1 = arg_367_1.actors_["10100ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect10100ui_story == nil then
				arg_367_1.var_.characterEffect10100ui_story = var_370_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_2 and not isNil(var_370_1) then
				if arg_367_1.var_.characterEffect10100ui_story and not isNil(var_370_1) then
					arg_367_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_367_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_2)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_2 and arg_367_1.time_ < 0 + var_370_2 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect10100ui_story then
				arg_367_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_367_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:AudioAction("stop", "effect", "se_story_136", "se_story_136_banquet_loop", "")
			end

			if 0.3 < arg_367_1.time_ and arg_367_1.time_ <= 0.3 + arg_370_0 then
				arg_367_1:AudioAction("play", "effect", "se_story_221_00", "se_story_221_00_firework", "")
			end

			local var_370_5 = 0
			local var_370_6 = 1.15

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_5 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_7 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(320011090).content)

				arg_367_1.text_.text = var_370_7

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 46 <= 0 and var_370_6 or var_370_6 * (utf8.len(var_370_7) / 46)

				if (46 <= 0 and var_370_6 or var_370_6 * (utf8.len(var_370_7) / 46)) > 0 and var_370_6 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_5 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_5
					end
				end

				arg_367_1.text_.text = var_370_7
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_10 = math.max(var_370_6, arg_367_1.talkMaxDuration)

			if var_370_5 <= arg_367_1.time_ and arg_367_1.time_ < var_370_5 + var_370_10 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_5) / var_370_10

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_5 + var_370_10 and arg_367_1.time_ < var_370_5 + var_370_10 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play320011091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 320011091
		arg_371_1.duration_ = 6.87

		local var_371_0 = {
			zh = 6.3,
			ja = 6.866
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
				arg_371_0:Play320011092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if arg_371_1.bgs_.L02g == nil then
				local var_374_0 = Object.Instantiate(arg_371_1.paintGo_)

				var_374_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L02g")
				var_374_0.name = "L02g"
				var_374_0.transform.parent = arg_371_1.stage_.transform
				var_374_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_371_1.bgs_.L02g = var_374_0
			end

			if 2 < arg_371_1.time_ and arg_371_1.time_ <= 2 + arg_374_0 then
				local var_374_1 = arg_371_1.bgs_.L02g

				arg_371_1.bgs_.L02g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_374_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_374_2 = var_374_1:GetComponent("SpriteRenderer")

				if var_374_2 and var_374_2.sprite then
					local var_374_3 = 2 * (var_374_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_374_1.transform.localScale = Vector3.New(var_374_3 / var_374_2.sprite.bounds.size.y < var_374_3 * manager.ui.mainCameraCom_.aspect / var_374_2.sprite.bounds.size.x and var_374_3 * manager.ui.mainCameraCom_.aspect / var_374_2.sprite.bounds.size.x or var_374_3 / var_374_2.sprite.bounds.size.y, var_374_3 / var_374_2.sprite.bounds.size.y < var_374_3 * manager.ui.mainCameraCom_.aspect / var_374_2.sprite.bounds.size.x and var_374_3 * manager.ui.mainCameraCom_.aspect / var_374_2.sprite.bounds.size.x or var_374_3 / var_374_2.sprite.bounds.size.y, 0)
				end

				for iter_374_0, iter_374_1 in pairs(arg_371_1.bgs_) do
					if iter_374_0 ~= "L02g" then
						iter_374_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_374_4 = 3.975

			if 3.975 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1.allBtn_.enabled = false
			end

			if arg_371_1.time_ >= var_374_4 + 0.3 and arg_371_1.time_ < var_374_4 + 0.3 + arg_374_0 then
				arg_371_1.allBtn_.enabled = true
			end

			local var_374_5 = 0

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_5 + arg_374_0 then
				arg_371_1.mask_.enabled = true
				arg_371_1.mask_.raycastTarget = true

				arg_371_1:SetGaussion(false)
			end

			local var_374_6 = 2

			if var_374_5 <= arg_371_1.time_ and arg_371_1.time_ < var_374_5 + var_374_6 then
				local var_374_7 = Color.New(0, 0, 0)

				var_374_7.a = Mathf.Lerp(0, 1, (arg_371_1.time_ - var_374_5) / var_374_6)
				arg_371_1.mask_.color = var_374_7
			end

			if arg_371_1.time_ >= var_374_5 + var_374_6 and arg_371_1.time_ < var_374_5 + var_374_6 + arg_374_0 then
				local var_374_8 = Color.New(0, 0, 0)

				var_374_8.a = 1
				arg_371_1.mask_.color = var_374_8
			end

			local var_374_9 = 2

			if 2 < arg_371_1.time_ and arg_371_1.time_ <= var_374_9 + arg_374_0 then
				arg_371_1.mask_.enabled = true
				arg_371_1.mask_.raycastTarget = true

				arg_371_1:SetGaussion(false)
			end

			local var_374_10 = 2

			if var_374_9 <= arg_371_1.time_ and arg_371_1.time_ < var_374_9 + var_374_10 then
				local var_374_11 = Color.New(0, 0, 0)

				var_374_11.a = Mathf.Lerp(1, 0, (arg_371_1.time_ - var_374_9) / var_374_10)
				arg_371_1.mask_.color = var_374_11
			end

			if arg_371_1.time_ >= var_374_9 + var_374_10 and arg_371_1.time_ < var_374_9 + var_374_10 + arg_374_0 then
				local var_374_12 = Color.New(0, 0, 0)

				arg_371_1.mask_.enabled = false
				var_374_12.a = 0
				arg_371_1.mask_.color = var_374_12
			end

			if arg_371_1.frameCnt_ <= 1 then
				arg_371_1.dialog_:SetActive(false)
			end

			local var_374_13 = 4
			local var_374_14 = 0.458333333333333

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

				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[1026].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_16 = arg_371_1:GetWordFromCfg(320011091)
				local var_374_17 = arg_371_1:FormatText(var_374_16.content)

				arg_371_1.text_.text = var_374_17

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_19 = 11 <= 0 and var_374_14 or var_374_14 * (utf8.len(var_374_17) / 11)

				if (11 <= 0 and var_374_14 or var_374_14 * (utf8.len(var_374_17) / 11)) > 0 and var_374_14 < var_374_19 then
					arg_371_1.talkMaxDuration = var_374_19
					var_374_13 = var_374_13 + 0.3

					if var_374_19 + var_374_13 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_19 + var_374_13
					end
				end

				arg_371_1.text_.text = var_374_17
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011091", "story_v_out_320011.awb") ~= 0 then
					local var_374_20 = manager.audio:GetVoiceLength("story_v_out_320011", "320011091", "story_v_out_320011.awb") / 1000

					if var_374_20 + var_374_13 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_20 + var_374_13
					end

					if var_374_16.prefab_name ~= "" and arg_371_1.actors_[var_374_16.prefab_name] ~= nil then
						local var_374_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_16.prefab_name].transform, "story_v_out_320011", "320011091", "story_v_out_320011.awb")

						arg_371_1:RecordAudio("320011091", var_374_21)
						arg_371_1:RecordAudio("320011091", var_374_21)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_320011", "320011091", "story_v_out_320011.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_320011", "320011091", "story_v_out_320011.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_22 = var_374_13 + 0.3
			local var_374_23 = math.max(var_374_14, arg_371_1.talkMaxDuration)

			if var_374_13 + 0.3 <= arg_371_1.time_ and arg_371_1.time_ < var_374_22 + var_374_23 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_22) / var_374_23

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_22 + var_374_23 and arg_371_1.time_ < var_374_22 + var_374_23 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play320011092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 320011092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play320011093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 1.25

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_1 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(320011092).content)

				arg_377_1.text_.text = var_380_1

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_3 = 50 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 50)

				if (50 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 50)) > 0 and var_380_0 < var_380_3 then
					arg_377_1.talkMaxDuration = var_380_3

					if var_380_3 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_3 + 0
					end
				end

				arg_377_1.text_.text = var_380_1
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_4 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_4

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play320011093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 320011093
		arg_381_1.duration_ = 5.5

		local var_381_0 = {
			zh = 5.1,
			ja = 5.5
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
				arg_381_0:Play320011094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.725

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[1026].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_1 = arg_381_1:GetWordFromCfg(320011093)
				local var_384_2 = arg_381_1:FormatText(var_384_1.content)

				arg_381_1.text_.text = var_384_2

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 29 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 29)

				if (29 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 29)) > 0 and var_384_0 < var_384_4 then
					arg_381_1.talkMaxDuration = var_384_4

					if var_384_4 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_4 + 0
					end
				end

				arg_381_1.text_.text = var_384_2
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011093", "story_v_out_320011.awb") ~= 0 then
					local var_384_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011093", "story_v_out_320011.awb") / 1000

					if var_384_5 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + 0
					end

					if var_384_1.prefab_name ~= "" and arg_381_1.actors_[var_384_1.prefab_name] ~= nil then
						local var_384_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_1.prefab_name].transform, "story_v_out_320011", "320011093", "story_v_out_320011.awb")

						arg_381_1:RecordAudio("320011093", var_384_6)
						arg_381_1:RecordAudio("320011093", var_384_6)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_320011", "320011093", "story_v_out_320011.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_320011", "320011093", "story_v_out_320011.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_7 and arg_381_1.time_ < 0 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play320011094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 320011094
		arg_385_1.duration_ = 7.43

		local var_385_0 = {
			zh = 5.033,
			ja = 7.433
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play320011095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.6

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[1027].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_1 = arg_385_1:GetWordFromCfg(320011094)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.text_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 24 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 24)

				if (24 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 24)) > 0 and var_388_0 < var_388_4 then
					arg_385_1.talkMaxDuration = var_388_4

					if var_388_4 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_4 + 0
					end
				end

				arg_385_1.text_.text = var_388_2
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011094", "story_v_out_320011.awb") ~= 0 then
					local var_388_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011094", "story_v_out_320011.awb") / 1000

					if var_388_5 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + 0
					end

					if var_388_1.prefab_name ~= "" and arg_385_1.actors_[var_388_1.prefab_name] ~= nil then
						local var_388_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_1.prefab_name].transform, "story_v_out_320011", "320011094", "story_v_out_320011.awb")

						arg_385_1:RecordAudio("320011094", var_388_6)
						arg_385_1:RecordAudio("320011094", var_388_6)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_320011", "320011094", "story_v_out_320011.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_320011", "320011094", "story_v_out_320011.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play320011095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 320011095
		arg_389_1.duration_ = 7.3

		local var_389_0 = {
			zh = 7.1,
			ja = 7.3
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
				arg_389_0:Play320011096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0.975

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[1026].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_1 = arg_389_1:GetWordFromCfg(320011095)
				local var_392_2 = arg_389_1:FormatText(var_392_1.content)

				arg_389_1.text_.text = var_392_2

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_4 = 39 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 39)

				if (39 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 39)) > 0 and var_392_0 < var_392_4 then
					arg_389_1.talkMaxDuration = var_392_4

					if var_392_4 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_4 + 0
					end
				end

				arg_389_1.text_.text = var_392_2
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011095", "story_v_out_320011.awb") ~= 0 then
					local var_392_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011095", "story_v_out_320011.awb") / 1000

					if var_392_5 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + 0
					end

					if var_392_1.prefab_name ~= "" and arg_389_1.actors_[var_392_1.prefab_name] ~= nil then
						local var_392_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_1.prefab_name].transform, "story_v_out_320011", "320011095", "story_v_out_320011.awb")

						arg_389_1:RecordAudio("320011095", var_392_6)
						arg_389_1:RecordAudio("320011095", var_392_6)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_320011", "320011095", "story_v_out_320011.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_320011", "320011095", "story_v_out_320011.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_7 and arg_389_1.time_ < 0 + var_392_7 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play320011096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 320011096
		arg_393_1.duration_ = 14.07

		local var_393_0 = {
			zh = 9.9,
			ja = 14.066
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
				arg_393_0:Play320011097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 1.3

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[1026].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_1 = arg_393_1:GetWordFromCfg(320011096)
				local var_396_2 = arg_393_1:FormatText(var_396_1.content)

				arg_393_1.text_.text = var_396_2

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_4 = 52 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 52)

				if (52 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 52)) > 0 and var_396_0 < var_396_4 then
					arg_393_1.talkMaxDuration = var_396_4

					if var_396_4 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_4 + 0
					end
				end

				arg_393_1.text_.text = var_396_2
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011096", "story_v_out_320011.awb") ~= 0 then
					local var_396_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011096", "story_v_out_320011.awb") / 1000

					if var_396_5 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + 0
					end

					if var_396_1.prefab_name ~= "" and arg_393_1.actors_[var_396_1.prefab_name] ~= nil then
						local var_396_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_1.prefab_name].transform, "story_v_out_320011", "320011096", "story_v_out_320011.awb")

						arg_393_1:RecordAudio("320011096", var_396_6)
						arg_393_1:RecordAudio("320011096", var_396_6)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_320011", "320011096", "story_v_out_320011.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_320011", "320011096", "story_v_out_320011.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_7 and arg_393_1.time_ < 0 + var_396_7 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play320011097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 320011097
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play320011098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 1.775

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(320011097).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 71 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 71)

				if (71 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 71)) > 0 and var_400_0 < var_400_3 then
					arg_397_1.talkMaxDuration = var_400_3

					if var_400_3 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_3 + 0
					end
				end

				arg_397_1.text_.text = var_400_1
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_4 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_4

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play320011098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 320011098
		arg_401_1.duration_ = 2.03

		local var_401_0 = {
			zh = 2.033,
			ja = 1.8
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
				arg_401_0:Play320011099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.25

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[1027].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_1 = arg_401_1:GetWordFromCfg(320011098)
				local var_404_2 = arg_401_1:FormatText(var_404_1.content)

				arg_401_1.text_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 10 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 10)

				if (10 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 10)) > 0 and var_404_0 < var_404_4 then
					arg_401_1.talkMaxDuration = var_404_4

					if var_404_4 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_4 + 0
					end
				end

				arg_401_1.text_.text = var_404_2
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011098", "story_v_out_320011.awb") ~= 0 then
					local var_404_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011098", "story_v_out_320011.awb") / 1000

					if var_404_5 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + 0
					end

					if var_404_1.prefab_name ~= "" and arg_401_1.actors_[var_404_1.prefab_name] ~= nil then
						local var_404_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_1.prefab_name].transform, "story_v_out_320011", "320011098", "story_v_out_320011.awb")

						arg_401_1:RecordAudio("320011098", var_404_6)
						arg_401_1:RecordAudio("320011098", var_404_6)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_320011", "320011098", "story_v_out_320011.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_320011", "320011098", "story_v_out_320011.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_7 and arg_401_1.time_ < 0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play320011099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 320011099
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play320011100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 1.4

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(320011099).content)

				arg_405_1.text_.text = var_408_1

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_3 = 56 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 56)

				if (56 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 56)) > 0 and var_408_0 < var_408_3 then
					arg_405_1.talkMaxDuration = var_408_3

					if var_408_3 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_3 + 0
					end
				end

				arg_405_1.text_.text = var_408_1
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_4 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_4

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play320011100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 320011100
		arg_409_1.duration_ = 6.07

		local var_409_0 = {
			zh = 4.8,
			ja = 6.066
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play320011101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0.525

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[1026].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_1 = arg_409_1:GetWordFromCfg(320011100)
				local var_412_2 = arg_409_1:FormatText(var_412_1.content)

				arg_409_1.text_.text = var_412_2

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_4 = 21 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_2) / 21)

				if (21 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_2) / 21)) > 0 and var_412_0 < var_412_4 then
					arg_409_1.talkMaxDuration = var_412_4

					if var_412_4 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_4 + 0
					end
				end

				arg_409_1.text_.text = var_412_2
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011100", "story_v_out_320011.awb") ~= 0 then
					local var_412_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011100", "story_v_out_320011.awb") / 1000

					if var_412_5 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + 0
					end

					if var_412_1.prefab_name ~= "" and arg_409_1.actors_[var_412_1.prefab_name] ~= nil then
						local var_412_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_1.prefab_name].transform, "story_v_out_320011", "320011100", "story_v_out_320011.awb")

						arg_409_1:RecordAudio("320011100", var_412_6)
						arg_409_1:RecordAudio("320011100", var_412_6)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_320011", "320011100", "story_v_out_320011.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_320011", "320011100", "story_v_out_320011.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_7 = math.max(var_412_0, arg_409_1.talkMaxDuration)

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_7 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - 0) / var_412_7

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= 0 + var_412_7 and arg_409_1.time_ < 0 + var_412_7 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play320011101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 320011101
		arg_413_1.duration_ = 1.17

		local var_413_0 = {
			zh = 0.999999999999,
			ja = 1.166
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
				arg_413_0:Play320011102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_416_0 = 0.6

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				local var_416_1, var_416_2 = math.modf((arg_413_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_416_2 * 0.13, var_416_2 * 0.13, var_416_2 * 0.13) + arg_413_1.var_.shakeOldPos
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				manager.ui.mainCamera.transform.localPosition = arg_413_1.var_.shakeOldPos
			end

			local var_416_3 = 0

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_3 + arg_416_0 then
				arg_413_1.allBtn_.enabled = false
			end

			if arg_413_1.time_ >= var_416_3 + 0.6 and arg_413_1.time_ < var_416_3 + 0.6 + arg_416_0 then
				arg_413_1.allBtn_.enabled = true
			end

			local var_416_4 = 0
			local var_416_5 = 0.05

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_4 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[1026].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_6 = arg_413_1:GetWordFromCfg(320011101)
				local var_416_7 = arg_413_1:FormatText(var_416_6.content)

				arg_413_1.text_.text = var_416_7

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_9 = 2 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 2)

				if (2 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 2)) > 0 and var_416_5 < var_416_9 then
					arg_413_1.talkMaxDuration = var_416_9

					if var_416_9 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_9 + var_416_4
					end
				end

				arg_413_1.text_.text = var_416_7
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011101", "story_v_out_320011.awb") ~= 0 then
					local var_416_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011101", "story_v_out_320011.awb") / 1000

					if var_416_10 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_10 + var_416_4
					end

					if var_416_6.prefab_name ~= "" and arg_413_1.actors_[var_416_6.prefab_name] ~= nil then
						local var_416_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_6.prefab_name].transform, "story_v_out_320011", "320011101", "story_v_out_320011.awb")

						arg_413_1:RecordAudio("320011101", var_416_11)
						arg_413_1:RecordAudio("320011101", var_416_11)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_320011", "320011101", "story_v_out_320011.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_320011", "320011101", "story_v_out_320011.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_12 = math.max(var_416_5, arg_413_1.talkMaxDuration)

			if var_416_4 <= arg_413_1.time_ and arg_413_1.time_ < var_416_4 + var_416_12 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_4) / var_416_12

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_4 + var_416_12 and arg_413_1.time_ < var_416_4 + var_416_12 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play320011102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 320011102
		arg_417_1.duration_ = 6

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play320011103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_9000

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_420_0 = 1

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				local var_420_1, var_420_2 = math.modf((arg_417_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_420_2 * 0.13, var_420_2 * 0.13, var_420_2 * 0.13) + arg_417_1.var_.shakeOldPos
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				manager.ui.mainCamera.transform.localPosition = arg_417_1.var_.shakeOldPos
			end

			local var_420_3 = 0

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_3 + arg_420_0 then
				arg_417_1.allBtn_.enabled = false
			end

			if arg_417_1.time_ >= var_420_3 + 1 and arg_417_1.time_ < var_420_3 + 1 + arg_420_0 then
				arg_417_1.allBtn_.enabled = true
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				local var_420_4 = arg_417_1.var_.effectqiangzhan2

				if not arg_417_1.var_.effectqiangzhan2 then
					var_420_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), manager.ui.mainCamera.transform)
					var_420_4.name = "qiangzhan2"
					arg_417_1.var_.effectqiangzhan2 = var_420_4
				else
					var_420_4.transform:SetParent(var_420_9000)
				end

				var_420_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_420_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_417_1.time_ and arg_417_1.time_ <= 2 + arg_420_0 then
				if arg_417_1.var_.effectqiangzhan2 then
					Object.Destroy(arg_417_1.var_.effectqiangzhan2)

					arg_417_1.var_.effectqiangzhan2 = nil
				end
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:AudioAction("play", "effect", "se_story_136", "se_story_136_gun", "")
			end

			if arg_417_1.frameCnt_ <= 1 then
				arg_417_1.dialog_:SetActive(false)
			end

			local var_420_8 = 1
			local var_420_9 = 1.575

			if 1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_8 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0

				arg_417_1.dialog_:SetActive(true)

				arg_417_1.dialogCg_.alpha = 0

				local var_420_10 = LeanTween.value(arg_417_1.dialog_, 0, 1, 0.3)

				var_420_10:setOnUpdate(LuaHelper.FloatAction(function(arg_421_0)
					arg_417_1.dialogCg_.alpha = arg_421_0
				end))
				var_420_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_417_1.dialog_)
					var_420_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_417_1.duration_ = arg_417_1.duration_ + 0.3

				SetActive(arg_417_1.leftNameGo_, false)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_11 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(320011102).content)

				arg_417_1.text_.text = var_420_11

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_13 = 63 <= 0 and var_420_9 or var_420_9 * (utf8.len(var_420_11) / 63)

				if (63 <= 0 and var_420_9 or var_420_9 * (utf8.len(var_420_11) / 63)) > 0 and var_420_9 < var_420_13 then
					arg_417_1.talkMaxDuration = var_420_13
					var_420_8 = var_420_8 + 0.3

					if var_420_13 + var_420_8 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_13 + var_420_8
					end
				end

				arg_417_1.text_.text = var_420_11
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_14 = var_420_8 + 0.3
			local var_420_15 = math.max(var_420_9, arg_417_1.talkMaxDuration)

			if var_420_8 + 0.3 <= arg_417_1.time_ and arg_417_1.time_ < var_420_14 + var_420_15 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_14) / var_420_15

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_14 + var_420_15 and arg_417_1.time_ < var_420_14 + var_420_15 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play320011103 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 320011103
		arg_423_1.duration_ = 8.47

		local var_423_0 = {
			zh = 8.466,
			ja = 5.033
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
				arg_423_0:Play320011104(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0.825

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[1028].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_1 = arg_423_1:GetWordFromCfg(320011103)
				local var_426_2 = arg_423_1:FormatText(var_426_1.content)

				arg_423_1.text_.text = var_426_2

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_4 = 33 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_2) / 33)

				if (33 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_2) / 33)) > 0 and var_426_0 < var_426_4 then
					arg_423_1.talkMaxDuration = var_426_4

					if var_426_4 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_4 + 0
					end
				end

				arg_423_1.text_.text = var_426_2
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011103", "story_v_out_320011.awb") ~= 0 then
					local var_426_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011103", "story_v_out_320011.awb") / 1000

					if var_426_5 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_5 + 0
					end

					if var_426_1.prefab_name ~= "" and arg_423_1.actors_[var_426_1.prefab_name] ~= nil then
						local var_426_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_1.prefab_name].transform, "story_v_out_320011", "320011103", "story_v_out_320011.awb")

						arg_423_1:RecordAudio("320011103", var_426_6)
						arg_423_1:RecordAudio("320011103", var_426_6)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_320011", "320011103", "story_v_out_320011.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_320011", "320011103", "story_v_out_320011.awb")
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
	Play320011104 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 320011104
		arg_427_1.duration_ = 6.1

		local var_427_0 = {
			zh = 4.6,
			ja = 6.1
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
				arg_427_0:Play320011105(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0.475

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[1029].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_1 = arg_427_1:GetWordFromCfg(320011104)
				local var_430_2 = arg_427_1:FormatText(var_430_1.content)

				arg_427_1.text_.text = var_430_2

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_4 = 19 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_2) / 19)

				if (19 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_2) / 19)) > 0 and var_430_0 < var_430_4 then
					arg_427_1.talkMaxDuration = var_430_4

					if var_430_4 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_4 + 0
					end
				end

				arg_427_1.text_.text = var_430_2
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011104", "story_v_out_320011.awb") ~= 0 then
					local var_430_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011104", "story_v_out_320011.awb") / 1000

					if var_430_5 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + 0
					end

					if var_430_1.prefab_name ~= "" and arg_427_1.actors_[var_430_1.prefab_name] ~= nil then
						local var_430_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_1.prefab_name].transform, "story_v_out_320011", "320011104", "story_v_out_320011.awb")

						arg_427_1:RecordAudio("320011104", var_430_6)
						arg_427_1:RecordAudio("320011104", var_430_6)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_320011", "320011104", "story_v_out_320011.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_320011", "320011104", "story_v_out_320011.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_7 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_7 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_7

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_7 and arg_427_1.time_ < 0 + var_430_7 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play320011105 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 320011105
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play320011106(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 1.4

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

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(320011105).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 56 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 56)

				if (56 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 56)) > 0 and var_434_0 < var_434_3 then
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
	Play320011106 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 320011106
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play320011107(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0.3 < arg_435_1.time_ and arg_435_1.time_ <= 0.3 + arg_438_0 then
				arg_435_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			if 0.3 < arg_435_1.time_ and arg_435_1.time_ <= 0.3 + arg_438_0 then
				arg_435_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_438_2 = 0
			local var_438_3 = 1.675

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_2 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_4 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(320011106).content)

				arg_435_1.text_.text = var_438_4

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_6 = 67 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_4) / 67)

				if (67 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_4) / 67)) > 0 and var_438_3 < var_438_6 then
					arg_435_1.talkMaxDuration = var_438_6

					if var_438_6 + var_438_2 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_6 + var_438_2
					end
				end

				arg_435_1.text_.text = var_438_4
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_7 = math.max(var_438_3, arg_435_1.talkMaxDuration)

			if var_438_2 <= arg_435_1.time_ and arg_435_1.time_ < var_438_2 + var_438_7 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_2) / var_438_7

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_2 + var_438_7 and arg_435_1.time_ < var_438_2 + var_438_7 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play320011107 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 320011107
		arg_439_1.duration_ = 8

		local var_439_0 = {
			zh = 7,
			ja = 8
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
				arg_439_0:Play320011108(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 2 < arg_439_1.time_ and arg_439_1.time_ <= 2 + arg_442_0 then
				local var_442_0 = arg_439_1.bgs_.ST0501

				arg_439_1.bgs_.ST0501.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_442_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_442_1 = var_442_0:GetComponent("SpriteRenderer")

				if var_442_1 and var_442_1.sprite then
					local var_442_2 = 2 * (var_442_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_442_0.transform.localScale = Vector3.New(var_442_2 / var_442_1.sprite.bounds.size.y < var_442_2 * manager.ui.mainCameraCom_.aspect / var_442_1.sprite.bounds.size.x and var_442_2 * manager.ui.mainCameraCom_.aspect / var_442_1.sprite.bounds.size.x or var_442_2 / var_442_1.sprite.bounds.size.y, var_442_2 / var_442_1.sprite.bounds.size.y < var_442_2 * manager.ui.mainCameraCom_.aspect / var_442_1.sprite.bounds.size.x and var_442_2 * manager.ui.mainCameraCom_.aspect / var_442_1.sprite.bounds.size.x or var_442_2 / var_442_1.sprite.bounds.size.y, 0)
				end

				for iter_442_0, iter_442_1 in pairs(arg_439_1.bgs_) do
					if iter_442_0 ~= "ST0501" then
						iter_442_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_442_3 = 4

			if 4 < arg_439_1.time_ and arg_439_1.time_ <= var_442_3 + arg_442_0 then
				arg_439_1.allBtn_.enabled = false
			end

			if arg_439_1.time_ >= var_442_3 + 0.3 and arg_439_1.time_ < var_442_3 + 0.3 + arg_442_0 then
				arg_439_1.allBtn_.enabled = true
			end

			local var_442_4 = 0

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_4 + arg_442_0 then
				arg_439_1.mask_.enabled = true
				arg_439_1.mask_.raycastTarget = true

				arg_439_1:SetGaussion(false)
			end

			local var_442_5 = 2

			if var_442_4 <= arg_439_1.time_ and arg_439_1.time_ < var_442_4 + var_442_5 then
				local var_442_6 = Color.New(0, 0, 0)

				var_442_6.a = Mathf.Lerp(0, 1, (arg_439_1.time_ - var_442_4) / var_442_5)
				arg_439_1.mask_.color = var_442_6
			end

			if arg_439_1.time_ >= var_442_4 + var_442_5 and arg_439_1.time_ < var_442_4 + var_442_5 + arg_442_0 then
				local var_442_7 = Color.New(0, 0, 0)

				var_442_7.a = 1
				arg_439_1.mask_.color = var_442_7
			end

			local var_442_8 = 2

			if 2 < arg_439_1.time_ and arg_439_1.time_ <= var_442_8 + arg_442_0 then
				arg_439_1.mask_.enabled = true
				arg_439_1.mask_.raycastTarget = true

				arg_439_1:SetGaussion(false)
			end

			local var_442_9 = 2

			if var_442_8 <= arg_439_1.time_ and arg_439_1.time_ < var_442_8 + var_442_9 then
				local var_442_10 = Color.New(0, 0, 0)

				var_442_10.a = Mathf.Lerp(1, 0, (arg_439_1.time_ - var_442_8) / var_442_9)
				arg_439_1.mask_.color = var_442_10
			end

			if arg_439_1.time_ >= var_442_8 + var_442_9 and arg_439_1.time_ < var_442_8 + var_442_9 + arg_442_0 then
				local var_442_11 = Color.New(0, 0, 0)

				arg_439_1.mask_.enabled = false
				var_442_11.a = 0
				arg_439_1.mask_.color = var_442_11
			end

			local var_442_12 = arg_439_1.actors_["10100ui_story"].transform

			if 3.8 < arg_439_1.time_ and arg_439_1.time_ <= 3.8 + arg_442_0 then
				arg_439_1.var_.moveOldPos10100ui_story = var_442_12.localPosition
			end

			local var_442_13 = 0.001

			if 3.8 <= arg_439_1.time_ and arg_439_1.time_ < 3.8 + var_442_13 then
				var_442_12.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_439_1.time_ - 3.8) / var_442_13)
				var_442_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_442_12.position).x, (manager.ui.mainCamera.transform.position - var_442_12.position).y, (manager.ui.mainCamera.transform.position - var_442_12.position).z)
				var_442_12.localEulerAngles.z = 0
				var_442_12.localEulerAngles.x = 0
				var_442_12.localEulerAngles = var_442_12.localEulerAngles
			end

			if arg_439_1.time_ >= 3.8 + var_442_13 and arg_439_1.time_ < 3.8 + var_442_13 + arg_442_0 then
				var_442_12.localPosition = Vector3.New(0, -1.16, -6.25)
				var_442_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_442_12.position).x, (manager.ui.mainCamera.transform.position - var_442_12.position).y, (manager.ui.mainCamera.transform.position - var_442_12.position).z)
				var_442_12.localEulerAngles.z = 0
				var_442_12.localEulerAngles.x = 0
				var_442_12.localEulerAngles = var_442_12.localEulerAngles
			end

			local var_442_14 = arg_439_1.actors_["10100ui_story"]

			if 3.8 < arg_439_1.time_ and arg_439_1.time_ <= 3.8 + arg_442_0 and not isNil(var_442_14) and arg_439_1.var_.characterEffect10100ui_story == nil then
				arg_439_1.var_.characterEffect10100ui_story = var_442_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_15 = 0.200000002980232

			if 3.8 <= arg_439_1.time_ and arg_439_1.time_ < 3.8 + var_442_15 and not isNil(var_442_14) then
				if arg_439_1.var_.characterEffect10100ui_story and not isNil(var_442_14) then
					arg_439_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= 3.8 + var_442_15 and arg_439_1.time_ < 3.8 + var_442_15 + arg_442_0 and not isNil(var_442_14) and arg_439_1.var_.characterEffect10100ui_story then
				arg_439_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 3.8 < arg_439_1.time_ and arg_439_1.time_ <= 3.8 + arg_442_0 then
				arg_439_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 3.8 < arg_439_1.time_ and arg_439_1.time_ <= 3.8 + arg_442_0 then
				arg_439_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_439_1.frameCnt_ <= 1 then
				arg_439_1.dialog_:SetActive(false)
			end

			local var_442_17 = 4
			local var_442_18 = 0.4

			if 4 < arg_439_1.time_ and arg_439_1.time_ <= var_442_17 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0

				arg_439_1.dialog_:SetActive(true)

				arg_439_1.dialogCg_.alpha = 0

				local var_442_19 = LeanTween.value(arg_439_1.dialog_, 0, 1, 0.3)

				var_442_19:setOnUpdate(LuaHelper.FloatAction(function(arg_443_0)
					arg_439_1.dialogCg_.alpha = arg_443_0
				end))
				var_442_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_439_1.dialog_)
					var_442_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_439_1.duration_ = arg_439_1.duration_ + 0.3

				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_20 = arg_439_1:GetWordFromCfg(320011107)
				local var_442_21 = arg_439_1:FormatText(var_442_20.content)

				arg_439_1.text_.text = var_442_21

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_23 = 16 <= 0 and var_442_18 or var_442_18 * (utf8.len(var_442_21) / 16)

				if (16 <= 0 and var_442_18 or var_442_18 * (utf8.len(var_442_21) / 16)) > 0 and var_442_18 < var_442_23 then
					arg_439_1.talkMaxDuration = var_442_23
					var_442_17 = var_442_17 + 0.3

					if var_442_23 + var_442_17 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_23 + var_442_17
					end
				end

				arg_439_1.text_.text = var_442_21
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011107", "story_v_out_320011.awb") ~= 0 then
					local var_442_24 = manager.audio:GetVoiceLength("story_v_out_320011", "320011107", "story_v_out_320011.awb") / 1000

					if var_442_24 + var_442_17 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_24 + var_442_17
					end

					if var_442_20.prefab_name ~= "" and arg_439_1.actors_[var_442_20.prefab_name] ~= nil then
						local var_442_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_20.prefab_name].transform, "story_v_out_320011", "320011107", "story_v_out_320011.awb")

						arg_439_1:RecordAudio("320011107", var_442_25)
						arg_439_1:RecordAudio("320011107", var_442_25)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_320011", "320011107", "story_v_out_320011.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_320011", "320011107", "story_v_out_320011.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_26 = var_442_17 + 0.3
			local var_442_27 = math.max(var_442_18, arg_439_1.talkMaxDuration)

			if var_442_17 + 0.3 <= arg_439_1.time_ and arg_439_1.time_ < var_442_26 + var_442_27 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_26) / var_442_27

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_26 + var_442_27 and arg_439_1.time_ < var_442_26 + var_442_27 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	Play320011108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 320011108
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play320011109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos10100ui_story = arg_445_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_448_0 = 0.001

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 then
				arg_445_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_445_1.time_ - 0) / var_448_0)
				arg_445_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["10100ui_story"].transform.position).z)
				arg_445_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["10100ui_story"].transform.localEulerAngles = arg_445_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 then
				arg_445_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_445_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["10100ui_story"].transform.position).z)
				arg_445_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["10100ui_story"].transform.localEulerAngles = arg_445_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_448_1 = arg_445_1.actors_["10100ui_story"]

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(var_448_1) and arg_445_1.var_.characterEffect10100ui_story == nil then
				arg_445_1.var_.characterEffect10100ui_story = var_448_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_2 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_2 and not isNil(var_448_1) then
				if arg_445_1.var_.characterEffect10100ui_story and not isNil(var_448_1) then
					arg_445_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_445_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_2)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_2 and arg_445_1.time_ < 0 + var_448_2 + arg_448_0 and not isNil(var_448_1) and arg_445_1.var_.characterEffect10100ui_story then
				arg_445_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_445_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_448_3 = 0
			local var_448_4 = 1.3

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_3 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_5 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(320011108).content)

				arg_445_1.text_.text = var_448_5

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_7 = 52 <= 0 and var_448_4 or var_448_4 * (utf8.len(var_448_5) / 52)

				if (52 <= 0 and var_448_4 or var_448_4 * (utf8.len(var_448_5) / 52)) > 0 and var_448_4 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_3 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_3
					end
				end

				arg_445_1.text_.text = var_448_5
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_8 = math.max(var_448_4, arg_445_1.talkMaxDuration)

			if var_448_3 <= arg_445_1.time_ and arg_445_1.time_ < var_448_3 + var_448_8 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_3) / var_448_8

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_3 + var_448_8 and arg_445_1.time_ < var_448_3 + var_448_8 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play320011109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 320011109
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play320011110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 1.075

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, false)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_1 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(320011109).content)

				arg_449_1.text_.text = var_452_1

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_3 = 43 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 43)

				if (43 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 43)) > 0 and var_452_0 < var_452_3 then
					arg_449_1.talkMaxDuration = var_452_3

					if var_452_3 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_3 + 0
					end
				end

				arg_449_1.text_.text = var_452_1
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_4 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_4 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_4

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_4 and arg_449_1.time_ < 0 + var_452_4 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play320011110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 320011110
		arg_453_1.duration_ = 9.37

		local var_453_0 = {
			zh = 7.1,
			ja = 9.366
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play320011111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0.675

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_1 = arg_453_1:GetWordFromCfg(320011110)
				local var_456_2 = arg_453_1:FormatText(var_456_1.content)

				arg_453_1.text_.text = var_456_2

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 27 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 27)

				if (27 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 27)) > 0 and var_456_0 < var_456_4 then
					arg_453_1.talkMaxDuration = var_456_4

					if var_456_4 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_4 + 0
					end
				end

				arg_453_1.text_.text = var_456_2
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011110", "story_v_out_320011.awb") ~= 0 then
					local var_456_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011110", "story_v_out_320011.awb") / 1000

					if var_456_5 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + 0
					end

					if var_456_1.prefab_name ~= "" and arg_453_1.actors_[var_456_1.prefab_name] ~= nil then
						local var_456_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_1.prefab_name].transform, "story_v_out_320011", "320011110", "story_v_out_320011.awb")

						arg_453_1:RecordAudio("320011110", var_456_6)
						arg_453_1:RecordAudio("320011110", var_456_6)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_320011", "320011110", "story_v_out_320011.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_320011", "320011110", "story_v_out_320011.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_7 and arg_453_1.time_ < 0 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play320011111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 320011111
		arg_457_1.duration_ = 9.5

		local var_457_0 = {
			zh = 6.1,
			ja = 9.5
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play320011112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos10100ui_story = arg_457_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_460_0 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 then
				arg_457_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_457_1.time_ - 0) / var_460_0)
				arg_457_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10100ui_story"].transform.position).z)
				arg_457_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["10100ui_story"].transform.localEulerAngles = arg_457_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 then
				arg_457_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_457_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10100ui_story"].transform.position).z)
				arg_457_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["10100ui_story"].transform.localEulerAngles = arg_457_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_460_1 = arg_457_1.actors_["10100ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect10100ui_story == nil then
				arg_457_1.var_.characterEffect10100ui_story = var_460_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_2 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_2 and not isNil(var_460_1) then
				if arg_457_1.var_.characterEffect10100ui_story and not isNil(var_460_1) then
					arg_457_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_2 and arg_457_1.time_ < 0 + var_460_2 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect10100ui_story then
				arg_457_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action18_1")
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_460_4 = 0
			local var_460_5 = 0.625

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_4 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_6 = arg_457_1:GetWordFromCfg(320011111)
				local var_460_7 = arg_457_1:FormatText(var_460_6.content)

				arg_457_1.text_.text = var_460_7

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_9 = 25 <= 0 and var_460_5 or var_460_5 * (utf8.len(var_460_7) / 25)

				if (25 <= 0 and var_460_5 or var_460_5 * (utf8.len(var_460_7) / 25)) > 0 and var_460_5 < var_460_9 then
					arg_457_1.talkMaxDuration = var_460_9

					if var_460_9 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_9 + var_460_4
					end
				end

				arg_457_1.text_.text = var_460_7
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011111", "story_v_out_320011.awb") ~= 0 then
					local var_460_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011111", "story_v_out_320011.awb") / 1000

					if var_460_10 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_10 + var_460_4
					end

					if var_460_6.prefab_name ~= "" and arg_457_1.actors_[var_460_6.prefab_name] ~= nil then
						local var_460_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_6.prefab_name].transform, "story_v_out_320011", "320011111", "story_v_out_320011.awb")

						arg_457_1:RecordAudio("320011111", var_460_11)
						arg_457_1:RecordAudio("320011111", var_460_11)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_320011", "320011111", "story_v_out_320011.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_320011", "320011111", "story_v_out_320011.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_12 = math.max(var_460_5, arg_457_1.talkMaxDuration)

			if var_460_4 <= arg_457_1.time_ and arg_457_1.time_ < var_460_4 + var_460_12 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_4) / var_460_12

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_4 + var_460_12 and arg_457_1.time_ < var_460_4 + var_460_12 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play320011112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 320011112
		arg_461_1.duration_ = 6.8

		local var_461_0 = {
			zh = 6.8,
			ja = 5.233
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
				arg_461_0:Play320011113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["10100ui_story"]) and arg_461_1.var_.characterEffect10100ui_story == nil then
				arg_461_1.var_.characterEffect10100ui_story = arg_461_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["10100ui_story"]) then
				if arg_461_1.var_.characterEffect10100ui_story and not isNil(arg_461_1.actors_["10100ui_story"]) then
					arg_461_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_461_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_0)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["10100ui_story"]) and arg_461_1.var_.characterEffect10100ui_story then
				arg_461_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_461_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_464_1 = 0
			local var_464_2 = 0.575

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:GetWordFromCfg(320011112)
				local var_464_4 = arg_461_1:FormatText(var_464_3.content)

				arg_461_1.text_.text = var_464_4

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_6 = 23 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_4) / 23)

				if (23 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_4) / 23)) > 0 and var_464_2 < var_464_6 then
					arg_461_1.talkMaxDuration = var_464_6

					if var_464_6 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_6 + var_464_1
					end
				end

				arg_461_1.text_.text = var_464_4
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011112", "story_v_out_320011.awb") ~= 0 then
					local var_464_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011112", "story_v_out_320011.awb") / 1000

					if var_464_7 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_1
					end

					if var_464_3.prefab_name ~= "" and arg_461_1.actors_[var_464_3.prefab_name] ~= nil then
						local var_464_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_3.prefab_name].transform, "story_v_out_320011", "320011112", "story_v_out_320011.awb")

						arg_461_1:RecordAudio("320011112", var_464_8)
						arg_461_1:RecordAudio("320011112", var_464_8)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_320011", "320011112", "story_v_out_320011.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_320011", "320011112", "story_v_out_320011.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_9 = math.max(var_464_2, arg_461_1.talkMaxDuration)

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_9 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_1) / var_464_9

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_1 + var_464_9 and arg_461_1.time_ < var_464_1 + var_464_9 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play320011113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 320011113
		arg_465_1.duration_ = 9.4

		local var_465_0 = {
			zh = 5.433,
			ja = 9.4
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
				arg_465_0:Play320011114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["10100ui_story"]) and arg_465_1.var_.characterEffect10100ui_story == nil then
				arg_465_1.var_.characterEffect10100ui_story = arg_465_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_0 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["10100ui_story"]) then
				if arg_465_1.var_.characterEffect10100ui_story and not isNil(arg_465_1.actors_["10100ui_story"]) then
					arg_465_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["10100ui_story"]) and arg_465_1.var_.characterEffect10100ui_story then
				arg_465_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action18_2")
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_468_2 = 0
			local var_468_3 = 0.725

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_2 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_4 = arg_465_1:GetWordFromCfg(320011113)
				local var_468_5 = arg_465_1:FormatText(var_468_4.content)

				arg_465_1.text_.text = var_468_5

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_7 = 29 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_5) / 29)

				if (29 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_5) / 29)) > 0 and var_468_3 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_2
					end
				end

				arg_465_1.text_.text = var_468_5
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011113", "story_v_out_320011.awb") ~= 0 then
					local var_468_8 = manager.audio:GetVoiceLength("story_v_out_320011", "320011113", "story_v_out_320011.awb") / 1000

					if var_468_8 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_2
					end

					if var_468_4.prefab_name ~= "" and arg_465_1.actors_[var_468_4.prefab_name] ~= nil then
						local var_468_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_4.prefab_name].transform, "story_v_out_320011", "320011113", "story_v_out_320011.awb")

						arg_465_1:RecordAudio("320011113", var_468_9)
						arg_465_1:RecordAudio("320011113", var_468_9)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_320011", "320011113", "story_v_out_320011.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_320011", "320011113", "story_v_out_320011.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_10 = math.max(var_468_3, arg_465_1.talkMaxDuration)

			if var_468_2 <= arg_465_1.time_ and arg_465_1.time_ < var_468_2 + var_468_10 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_2) / var_468_10

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_2 + var_468_10 and arg_465_1.time_ < var_468_2 + var_468_10 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play320011114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 320011114
		arg_469_1.duration_ = 7.7

		local var_469_0 = {
			zh = 4.5,
			ja = 7.7
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play320011115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_472_0 = 0
			local var_472_1 = 0.525

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_2 = arg_469_1:GetWordFromCfg(320011114)
				local var_472_3 = arg_469_1:FormatText(var_472_2.content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 21 <= 0 and var_472_1 or var_472_1 * (utf8.len(var_472_3) / 21)

				if (21 <= 0 and var_472_1 or var_472_1 * (utf8.len(var_472_3) / 21)) > 0 and var_472_1 < var_472_5 then
					arg_469_1.talkMaxDuration = var_472_5

					if var_472_5 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011114", "story_v_out_320011.awb") ~= 0 then
					local var_472_6 = manager.audio:GetVoiceLength("story_v_out_320011", "320011114", "story_v_out_320011.awb") / 1000

					if var_472_6 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_6 + var_472_0
					end

					if var_472_2.prefab_name ~= "" and arg_469_1.actors_[var_472_2.prefab_name] ~= nil then
						local var_472_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_2.prefab_name].transform, "story_v_out_320011", "320011114", "story_v_out_320011.awb")

						arg_469_1:RecordAudio("320011114", var_472_7)
						arg_469_1:RecordAudio("320011114", var_472_7)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_320011", "320011114", "story_v_out_320011.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_320011", "320011114", "story_v_out_320011.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_8 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_8 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_8

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_8 and arg_469_1.time_ < var_472_0 + var_472_8 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play320011115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 320011115
		arg_473_1.duration_ = 6.8

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play320011116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0.983333333333333 < arg_473_1.time_ and arg_473_1.time_ <= 0.983333333333333 + arg_476_0 then
				arg_473_1.var_.moveOldPos10100ui_story = arg_473_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_476_0 = 0.001

			if 0.983333333333333 <= arg_473_1.time_ and arg_473_1.time_ < 0.983333333333333 + var_476_0 then
				arg_473_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_473_1.time_ - 0.983333333333333) / var_476_0)
				arg_473_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["10100ui_story"].transform.position).z)
				arg_473_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["10100ui_story"].transform.localEulerAngles = arg_473_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_473_1.time_ >= 0.983333333333333 + var_476_0 and arg_473_1.time_ < 0.983333333333333 + var_476_0 + arg_476_0 then
				arg_473_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_473_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["10100ui_story"].transform.position).z)
				arg_473_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["10100ui_story"].transform.localEulerAngles = arg_473_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_476_1 = arg_473_1.actors_["10100ui_story"]

			if 0.983333333333333 < arg_473_1.time_ and arg_473_1.time_ <= 0.983333333333333 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect10100ui_story == nil then
				arg_473_1.var_.characterEffect10100ui_story = var_476_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.0166666666666667

			if 0.983333333333333 <= arg_473_1.time_ and arg_473_1.time_ < 0.983333333333333 + var_476_2 and not isNil(var_476_1) then
				if arg_473_1.var_.characterEffect10100ui_story and not isNil(var_476_1) then
					arg_473_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_473_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_473_1.time_ - 0.983333333333333) / var_476_2)
				end
			end

			if arg_473_1.time_ >= 0.983333333333333 + var_476_2 and arg_473_1.time_ < 0.983333333333333 + var_476_2 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect10100ui_story then
				arg_473_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_473_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_476_3 = 0

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_3 + arg_476_0 then
				arg_473_1.mask_.enabled = true
				arg_473_1.mask_.raycastTarget = true

				arg_473_1:SetGaussion(false)
			end

			local var_476_4 = 1

			if var_476_3 <= arg_473_1.time_ and arg_473_1.time_ < var_476_3 + var_476_4 then
				local var_476_5 = Color.New(0, 0, 0)

				var_476_5.a = Mathf.Lerp(0, 1, (arg_473_1.time_ - var_476_3) / var_476_4)
				arg_473_1.mask_.color = var_476_5
			end

			if arg_473_1.time_ >= var_476_3 + var_476_4 and arg_473_1.time_ < var_476_3 + var_476_4 + arg_476_0 then
				local var_476_6 = Color.New(0, 0, 0)

				var_476_6.a = 1
				arg_473_1.mask_.color = var_476_6
			end

			local var_476_7 = 1

			if 1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_7 + arg_476_0 then
				arg_473_1.mask_.enabled = true
				arg_473_1.mask_.raycastTarget = true

				arg_473_1:SetGaussion(false)
			end

			local var_476_8 = 1

			if var_476_7 <= arg_473_1.time_ and arg_473_1.time_ < var_476_7 + var_476_8 then
				local var_476_9 = Color.New(0, 0, 0)

				var_476_9.a = Mathf.Lerp(1, 0, (arg_473_1.time_ - var_476_7) / var_476_8)
				arg_473_1.mask_.color = var_476_9
			end

			if arg_473_1.time_ >= var_476_7 + var_476_8 and arg_473_1.time_ < var_476_7 + var_476_8 + arg_476_0 then
				local var_476_10 = Color.New(0, 0, 0)

				arg_473_1.mask_.enabled = false
				var_476_10.a = 0
				arg_473_1.mask_.color = var_476_10
			end

			if arg_473_1.frameCnt_ <= 1 then
				arg_473_1.dialog_:SetActive(false)
			end

			local var_476_11 = 1.8
			local var_476_12 = 0.7

			if 1.8 < arg_473_1.time_ and arg_473_1.time_ <= var_476_11 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0

				arg_473_1.dialog_:SetActive(true)

				arg_473_1.dialogCg_.alpha = 0

				local var_476_13 = LeanTween.value(arg_473_1.dialog_, 0, 1, 0.3)

				var_476_13:setOnUpdate(LuaHelper.FloatAction(function(arg_477_0)
					arg_473_1.dialogCg_.alpha = arg_477_0
				end))
				var_476_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_473_1.dialog_)
					var_476_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_473_1.duration_ = arg_473_1.duration_ + 0.3

				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_14 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(320011115).content)

				arg_473_1.text_.text = var_476_14

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_16 = 28 <= 0 and var_476_12 or var_476_12 * (utf8.len(var_476_14) / 28)

				if (28 <= 0 and var_476_12 or var_476_12 * (utf8.len(var_476_14) / 28)) > 0 and var_476_12 < var_476_16 then
					arg_473_1.talkMaxDuration = var_476_16
					var_476_11 = var_476_11 + 0.3

					if var_476_16 + var_476_11 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_16 + var_476_11
					end
				end

				arg_473_1.text_.text = var_476_14
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_17 = var_476_11 + 0.3
			local var_476_18 = math.max(var_476_12, arg_473_1.talkMaxDuration)

			if var_476_11 + 0.3 <= arg_473_1.time_ and arg_473_1.time_ < var_476_17 + var_476_18 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_17) / var_476_18

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_17 + var_476_18 and arg_473_1.time_ < var_476_17 + var_476_18 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.983333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play320011116 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 320011116
		arg_479_1.duration_ = 3.47

		local var_479_0 = {
			zh = 1.866,
			ja = 3.466
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
				arg_479_0:Play320011117(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0.175

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_1 = arg_479_1:GetWordFromCfg(320011116)
				local var_482_2 = arg_479_1:FormatText(var_482_1.content)

				arg_479_1.text_.text = var_482_2

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_4 = 7 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_2) / 7)

				if (7 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_2) / 7)) > 0 and var_482_0 < var_482_4 then
					arg_479_1.talkMaxDuration = var_482_4

					if var_482_4 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_4 + 0
					end
				end

				arg_479_1.text_.text = var_482_2
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011116", "story_v_out_320011.awb") ~= 0 then
					local var_482_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011116", "story_v_out_320011.awb") / 1000

					if var_482_5 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_5 + 0
					end

					if var_482_1.prefab_name ~= "" and arg_479_1.actors_[var_482_1.prefab_name] ~= nil then
						local var_482_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_1.prefab_name].transform, "story_v_out_320011", "320011116", "story_v_out_320011.awb")

						arg_479_1:RecordAudio("320011116", var_482_6)
						arg_479_1:RecordAudio("320011116", var_482_6)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_320011", "320011116", "story_v_out_320011.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_320011", "320011116", "story_v_out_320011.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_7 = math.max(var_482_0, arg_479_1.talkMaxDuration)

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_7 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - 0) / var_482_7

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= 0 + var_482_7 and arg_479_1.time_ < 0 + var_482_7 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play320011117 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 320011117
		arg_483_1.duration_ = 6.7

		local var_483_0 = {
			zh = 6.233,
			ja = 6.7
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
				arg_483_0:Play320011118(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.var_.moveOldPos10100ui_story = arg_483_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_486_0 = 0.001

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 then
				arg_483_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_483_1.time_ - 0) / var_486_0)
				arg_483_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10100ui_story"].transform.position).z)
				arg_483_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["10100ui_story"].transform.localEulerAngles = arg_483_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 then
				arg_483_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_483_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10100ui_story"].transform.position).z)
				arg_483_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["10100ui_story"].transform.localEulerAngles = arg_483_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_486_1 = arg_483_1.actors_["10100ui_story"]

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(var_486_1) and arg_483_1.var_.characterEffect10100ui_story == nil then
				arg_483_1.var_.characterEffect10100ui_story = var_486_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_2 = 0.200000002980232

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_2 and not isNil(var_486_1) then
				if arg_483_1.var_.characterEffect10100ui_story and not isNil(var_486_1) then
					arg_483_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= 0 + var_486_2 and arg_483_1.time_ < 0 + var_486_2 + arg_486_0 and not isNil(var_486_1) and arg_483_1.var_.characterEffect10100ui_story then
				arg_483_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_486_4 = 0
			local var_486_5 = 0.6

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_4 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_6 = arg_483_1:GetWordFromCfg(320011117)
				local var_486_7 = arg_483_1:FormatText(var_486_6.content)

				arg_483_1.text_.text = var_486_7

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_9 = 24 <= 0 and var_486_5 or var_486_5 * (utf8.len(var_486_7) / 24)

				if (24 <= 0 and var_486_5 or var_486_5 * (utf8.len(var_486_7) / 24)) > 0 and var_486_5 < var_486_9 then
					arg_483_1.talkMaxDuration = var_486_9

					if var_486_9 + var_486_4 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_9 + var_486_4
					end
				end

				arg_483_1.text_.text = var_486_7
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011117", "story_v_out_320011.awb") ~= 0 then
					local var_486_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011117", "story_v_out_320011.awb") / 1000

					if var_486_10 + var_486_4 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_10 + var_486_4
					end

					if var_486_6.prefab_name ~= "" and arg_483_1.actors_[var_486_6.prefab_name] ~= nil then
						local var_486_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_6.prefab_name].transform, "story_v_out_320011", "320011117", "story_v_out_320011.awb")

						arg_483_1:RecordAudio("320011117", var_486_11)
						arg_483_1:RecordAudio("320011117", var_486_11)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_320011", "320011117", "story_v_out_320011.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_320011", "320011117", "story_v_out_320011.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_12 = math.max(var_486_5, arg_483_1.talkMaxDuration)

			if var_486_4 <= arg_483_1.time_ and arg_483_1.time_ < var_486_4 + var_486_12 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_4) / var_486_12

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_4 + var_486_12 and arg_483_1.time_ < var_486_4 + var_486_12 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_483_1:InitPlayNodeList()
	end,
	Play320011118 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 320011118
		arg_487_1.duration_ = 4.73

		local var_487_0 = {
			zh = 2.3,
			ja = 4.733
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play320011119(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(arg_487_1.actors_["10100ui_story"]) and arg_487_1.var_.characterEffect10100ui_story == nil then
				arg_487_1.var_.characterEffect10100ui_story = arg_487_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_0 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 and not isNil(arg_487_1.actors_["10100ui_story"]) then
				if arg_487_1.var_.characterEffect10100ui_story and not isNil(arg_487_1.actors_["10100ui_story"]) then
					arg_487_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_487_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_487_1.time_ - 0) / var_490_0)
				end
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 and not isNil(arg_487_1.actors_["10100ui_story"]) and arg_487_1.var_.characterEffect10100ui_story then
				arg_487_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_487_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_490_1 = 0
			local var_490_2 = 0.325

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_3 = arg_487_1:GetWordFromCfg(320011118)
				local var_490_4 = arg_487_1:FormatText(var_490_3.content)

				arg_487_1.text_.text = var_490_4

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_6 = 13 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_4) / 13)

				if (13 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_4) / 13)) > 0 and var_490_2 < var_490_6 then
					arg_487_1.talkMaxDuration = var_490_6

					if var_490_6 + var_490_1 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_6 + var_490_1
					end
				end

				arg_487_1.text_.text = var_490_4
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011118", "story_v_out_320011.awb") ~= 0 then
					local var_490_7 = manager.audio:GetVoiceLength("story_v_out_320011", "320011118", "story_v_out_320011.awb") / 1000

					if var_490_7 + var_490_1 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_7 + var_490_1
					end

					if var_490_3.prefab_name ~= "" and arg_487_1.actors_[var_490_3.prefab_name] ~= nil then
						local var_490_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_3.prefab_name].transform, "story_v_out_320011", "320011118", "story_v_out_320011.awb")

						arg_487_1:RecordAudio("320011118", var_490_8)
						arg_487_1:RecordAudio("320011118", var_490_8)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_320011", "320011118", "story_v_out_320011.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_320011", "320011118", "story_v_out_320011.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_9 = math.max(var_490_2, arg_487_1.talkMaxDuration)

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_9 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_1) / var_490_9

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_1 + var_490_9 and arg_487_1.time_ < var_490_1 + var_490_9 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play320011119 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 320011119
		arg_491_1.duration_ = 12.83

		local var_491_0 = {
			zh = 12.833,
			ja = 7.233
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
				arg_491_0:Play320011120(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos10100ui_story = arg_491_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_494_0 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 then
				arg_491_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_491_1.time_ - 0) / var_494_0)
				arg_491_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["10100ui_story"].transform.position).z)
				arg_491_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["10100ui_story"].transform.localEulerAngles = arg_491_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 then
				arg_491_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_491_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["10100ui_story"].transform.position).z)
				arg_491_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["10100ui_story"].transform.localEulerAngles = arg_491_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_494_1 = arg_491_1.actors_["10100ui_story"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_1) and arg_491_1.var_.characterEffect10100ui_story == nil then
				arg_491_1.var_.characterEffect10100ui_story = var_494_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_2 = 0.200000002980232

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_2 and not isNil(var_494_1) then
				if arg_491_1.var_.characterEffect10100ui_story and not isNil(var_494_1) then
					arg_491_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= 0 + var_494_2 and arg_491_1.time_ < 0 + var_494_2 + arg_494_0 and not isNil(var_494_1) and arg_491_1.var_.characterEffect10100ui_story then
				arg_491_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_494_4 = 0
			local var_494_5 = 1.625

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_4 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_6 = arg_491_1:GetWordFromCfg(320011119)
				local var_494_7 = arg_491_1:FormatText(var_494_6.content)

				arg_491_1.text_.text = var_494_7

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_9 = 65 <= 0 and var_494_5 or var_494_5 * (utf8.len(var_494_7) / 65)

				if (65 <= 0 and var_494_5 or var_494_5 * (utf8.len(var_494_7) / 65)) > 0 and var_494_5 < var_494_9 then
					arg_491_1.talkMaxDuration = var_494_9

					if var_494_9 + var_494_4 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_9 + var_494_4
					end
				end

				arg_491_1.text_.text = var_494_7
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011119", "story_v_out_320011.awb") ~= 0 then
					local var_494_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011119", "story_v_out_320011.awb") / 1000

					if var_494_10 + var_494_4 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_10 + var_494_4
					end

					if var_494_6.prefab_name ~= "" and arg_491_1.actors_[var_494_6.prefab_name] ~= nil then
						local var_494_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_6.prefab_name].transform, "story_v_out_320011", "320011119", "story_v_out_320011.awb")

						arg_491_1:RecordAudio("320011119", var_494_11)
						arg_491_1:RecordAudio("320011119", var_494_11)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_320011", "320011119", "story_v_out_320011.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_320011", "320011119", "story_v_out_320011.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_12 = math.max(var_494_5, arg_491_1.talkMaxDuration)

			if var_494_4 <= arg_491_1.time_ and arg_491_1.time_ < var_494_4 + var_494_12 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_4) / var_494_12

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_4 + var_494_12 and arg_491_1.time_ < var_494_4 + var_494_12 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_491_1:InitPlayNodeList()
	end,
	Play320011120 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 320011120
		arg_495_1.duration_ = 3

		local var_495_0 = {
			zh = 1.3,
			ja = 3
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
				arg_495_0:Play320011121(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.125

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_1 = arg_495_1:GetWordFromCfg(320011120)
				local var_498_2 = arg_495_1:FormatText(var_498_1.content)

				arg_495_1.text_.text = var_498_2

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 5 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 5)

				if (5 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 5)) > 0 and var_498_0 < var_498_4 then
					arg_495_1.talkMaxDuration = var_498_4

					if var_498_4 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_4 + 0
					end
				end

				arg_495_1.text_.text = var_498_2
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011120", "story_v_out_320011.awb") ~= 0 then
					local var_498_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011120", "story_v_out_320011.awb") / 1000

					if var_498_5 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + 0
					end

					if var_498_1.prefab_name ~= "" and arg_495_1.actors_[var_498_1.prefab_name] ~= nil then
						local var_498_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_1.prefab_name].transform, "story_v_out_320011", "320011120", "story_v_out_320011.awb")

						arg_495_1:RecordAudio("320011120", var_498_6)
						arg_495_1:RecordAudio("320011120", var_498_6)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_320011", "320011120", "story_v_out_320011.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_320011", "320011120", "story_v_out_320011.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play320011121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 320011121
		arg_499_1.duration_ = 9.8

		local var_499_0 = {
			zh = 6.999999999999,
			ja = 9.799999999999
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
				arg_499_0:Play320011122(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_9000

			if 1.999999999999 < arg_499_1.time_ and arg_499_1.time_ <= 1.999999999999 + arg_502_0 then
				local var_502_0 = arg_499_1.bgs_.L02g

				arg_499_1.bgs_.L02g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_502_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_502_1 = var_502_0:GetComponent("SpriteRenderer")

				if var_502_1 and var_502_1.sprite then
					local var_502_2 = 2 * (var_502_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_502_0.transform.localScale = Vector3.New(var_502_2 / var_502_1.sprite.bounds.size.y < var_502_2 * manager.ui.mainCameraCom_.aspect / var_502_1.sprite.bounds.size.x and var_502_2 * manager.ui.mainCameraCom_.aspect / var_502_1.sprite.bounds.size.x or var_502_2 / var_502_1.sprite.bounds.size.y, var_502_2 / var_502_1.sprite.bounds.size.y < var_502_2 * manager.ui.mainCameraCom_.aspect / var_502_1.sprite.bounds.size.x and var_502_2 * manager.ui.mainCameraCom_.aspect / var_502_1.sprite.bounds.size.x or var_502_2 / var_502_1.sprite.bounds.size.y, 0)
				end

				for iter_502_0, iter_502_1 in pairs(arg_499_1.bgs_) do
					if iter_502_0 ~= "L02g" then
						iter_502_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_502_3 = 3.999999999999

			if 3.999999999999 < arg_499_1.time_ and arg_499_1.time_ <= var_502_3 + arg_502_0 then
				arg_499_1.allBtn_.enabled = false
			end

			if arg_499_1.time_ >= var_502_3 + 0.3 and arg_499_1.time_ < var_502_3 + 0.3 + arg_502_0 then
				arg_499_1.allBtn_.enabled = true
			end

			local var_502_4 = 0

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_4 + arg_502_0 then
				arg_499_1.mask_.enabled = true
				arg_499_1.mask_.raycastTarget = true

				arg_499_1:SetGaussion(false)
			end

			local var_502_5 = 2

			if var_502_4 <= arg_499_1.time_ and arg_499_1.time_ < var_502_4 + var_502_5 then
				local var_502_6 = Color.New(0, 0, 0)

				var_502_6.a = Mathf.Lerp(0, 1, (arg_499_1.time_ - var_502_4) / var_502_5)
				arg_499_1.mask_.color = var_502_6
			end

			if arg_499_1.time_ >= var_502_4 + var_502_5 and arg_499_1.time_ < var_502_4 + var_502_5 + arg_502_0 then
				local var_502_7 = Color.New(0, 0, 0)

				var_502_7.a = 1
				arg_499_1.mask_.color = var_502_7
			end

			local var_502_8 = 2

			if 2 < arg_499_1.time_ and arg_499_1.time_ <= var_502_8 + arg_502_0 then
				arg_499_1.mask_.enabled = true
				arg_499_1.mask_.raycastTarget = true

				arg_499_1:SetGaussion(false)
			end

			local var_502_9 = 2

			if var_502_8 <= arg_499_1.time_ and arg_499_1.time_ < var_502_8 + var_502_9 then
				local var_502_10 = Color.New(0, 0, 0)

				var_502_10.a = Mathf.Lerp(1, 0, (arg_499_1.time_ - var_502_8) / var_502_9)
				arg_499_1.mask_.color = var_502_10
			end

			if arg_499_1.time_ >= var_502_8 + var_502_9 and arg_499_1.time_ < var_502_8 + var_502_9 + arg_502_0 then
				local var_502_11 = Color.New(0, 0, 0)

				arg_499_1.mask_.enabled = false
				var_502_11.a = 0
				arg_499_1.mask_.color = var_502_11
			end

			local var_502_12 = arg_499_1.actors_["10100ui_story"].transform

			if 1.96599999815226 < arg_499_1.time_ and arg_499_1.time_ <= 1.96599999815226 + arg_502_0 then
				arg_499_1.var_.moveOldPos10100ui_story = var_502_12.localPosition
			end

			local var_502_13 = 0.001

			if 1.96599999815226 <= arg_499_1.time_ and arg_499_1.time_ < 1.96599999815226 + var_502_13 then
				var_502_12.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_499_1.time_ - 1.96599999815226) / var_502_13)
				var_502_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_502_12.position).x, (manager.ui.mainCamera.transform.position - var_502_12.position).y, (manager.ui.mainCamera.transform.position - var_502_12.position).z)
				var_502_12.localEulerAngles.z = 0
				var_502_12.localEulerAngles.x = 0
				var_502_12.localEulerAngles = var_502_12.localEulerAngles
			end

			if arg_499_1.time_ >= 1.96599999815226 + var_502_13 and arg_499_1.time_ < 1.96599999815226 + var_502_13 + arg_502_0 then
				var_502_12.localPosition = Vector3.New(0, 100, 0)
				var_502_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_502_12.position).x, (manager.ui.mainCamera.transform.position - var_502_12.position).y, (manager.ui.mainCamera.transform.position - var_502_12.position).z)
				var_502_12.localEulerAngles.z = 0
				var_502_12.localEulerAngles.x = 0
				var_502_12.localEulerAngles = var_502_12.localEulerAngles
			end

			local var_502_14 = arg_499_1.actors_["10100ui_story"]

			if 1.96599999815226 < arg_499_1.time_ and arg_499_1.time_ <= 1.96599999815226 + arg_502_0 and not isNil(var_502_14) and arg_499_1.var_.characterEffect10100ui_story == nil then
				arg_499_1.var_.characterEffect10100ui_story = var_502_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_15 = 0.034000001847744

			if 1.96599999815226 <= arg_499_1.time_ and arg_499_1.time_ < 1.96599999815226 + var_502_15 and not isNil(var_502_14) then
				if arg_499_1.var_.characterEffect10100ui_story and not isNil(var_502_14) then
					arg_499_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_499_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_499_1.time_ - 1.96599999815226) / var_502_15)
				end
			end

			if arg_499_1.time_ >= 1.96599999815226 + var_502_15 and arg_499_1.time_ < 1.96599999815226 + var_502_15 + arg_502_0 and not isNil(var_502_14) and arg_499_1.var_.characterEffect10100ui_story then
				arg_499_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_499_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if 2 < arg_499_1.time_ and arg_499_1.time_ <= 2 + arg_502_0 then
				local var_502_16 = arg_499_1.var_.effectcanpian1

				if not arg_499_1.var_.effectcanpian1 then
					var_502_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning_1"), manager.ui.mainCamera.transform)
					var_502_16.name = "canpian1"
					arg_499_1.var_.effectcanpian1 = var_502_16
				else
					var_502_16.transform:SetParent(var_502_9000)
				end

				var_502_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_502_16.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_502_18 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_502_19 = var_502_16.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_502_2, iter_502_3 in ipairs((var_502_19:ToTable())) do
					iter_502_3.transform.localScale = Vector3.New(iter_502_3.transform.localScale.x / var_502_18 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_502_19 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_502_3.transform.localScale.y / var_502_18, iter_502_3.transform.localScale.z)
				end
			end

			if 1.7 < arg_499_1.time_ and arg_499_1.time_ <= 1.7 + arg_502_0 then
				arg_499_1:AudioAction("play", "effect", "se_story_8", "se_story_8_fire_environment_loop", "")
			end

			if arg_499_1.frameCnt_ <= 1 then
				arg_499_1.dialog_:SetActive(false)
			end

			local var_502_22 = 3.999999999999
			local var_502_23 = 0.35

			if 3.999999999999 < arg_499_1.time_ and arg_499_1.time_ <= var_502_22 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0

				arg_499_1.dialog_:SetActive(true)

				arg_499_1.dialogCg_.alpha = 0

				local var_502_24 = LeanTween.value(arg_499_1.dialog_, 0, 1, 0.3)

				var_502_24:setOnUpdate(LuaHelper.FloatAction(function(arg_503_0)
					arg_499_1.dialogCg_.alpha = arg_503_0
				end))
				var_502_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_499_1.dialog_)
					var_502_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_499_1.duration_ = arg_499_1.duration_ + 0.3

				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[1029].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, true)
				arg_499_1.iconController_:SetSelectedState("hero")

				arg_499_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_499_1.callingController_:SetSelectedState("normal")

				arg_499_1.keyicon_.color = Color.New(1, 1, 1)
				arg_499_1.icon_.color = Color.New(1, 1, 1)

				local var_502_25 = arg_499_1:GetWordFromCfg(320011121)
				local var_502_26 = arg_499_1:FormatText(var_502_25.content)

				arg_499_1.text_.text = var_502_26

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_28 = 14 <= 0 and var_502_23 or var_502_23 * (utf8.len(var_502_26) / 14)

				if (14 <= 0 and var_502_23 or var_502_23 * (utf8.len(var_502_26) / 14)) > 0 and var_502_23 < var_502_28 then
					arg_499_1.talkMaxDuration = var_502_28
					var_502_22 = var_502_22 + 0.3

					if var_502_28 + var_502_22 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_28 + var_502_22
					end
				end

				arg_499_1.text_.text = var_502_26
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011121", "story_v_out_320011.awb") ~= 0 then
					local var_502_29 = manager.audio:GetVoiceLength("story_v_out_320011", "320011121", "story_v_out_320011.awb") / 1000

					if var_502_29 + var_502_22 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_29 + var_502_22
					end

					if var_502_25.prefab_name ~= "" and arg_499_1.actors_[var_502_25.prefab_name] ~= nil then
						local var_502_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_25.prefab_name].transform, "story_v_out_320011", "320011121", "story_v_out_320011.awb")

						arg_499_1:RecordAudio("320011121", var_502_30)
						arg_499_1:RecordAudio("320011121", var_502_30)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_320011", "320011121", "story_v_out_320011.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_320011", "320011121", "story_v_out_320011.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_31 = var_502_22 + 0.3
			local var_502_32 = math.max(var_502_23, arg_499_1.talkMaxDuration)

			if var_502_22 + 0.3 <= arg_499_1.time_ and arg_499_1.time_ < var_502_31 + var_502_32 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_31) / var_502_32

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_31 + var_502_32 and arg_499_1.time_ < var_502_31 + var_502_32 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play320011122 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 320011122
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play320011123(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 1.05

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_1 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(320011122).content)

				arg_505_1.text_.text = var_508_1

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_3 = 42 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 42)

				if (42 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 42)) > 0 and var_508_0 < var_508_3 then
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
	Play320011123 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 320011123
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play320011124(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 1.325

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_1 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(320011123).content)

				arg_509_1.text_.text = var_512_1

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_3 = 53 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 53)

				if (53 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 53)) > 0 and var_512_0 < var_512_3 then
					arg_509_1.talkMaxDuration = var_512_3

					if var_512_3 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_3 + 0
					end
				end

				arg_509_1.text_.text = var_512_1
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_4 = math.max(var_512_0, arg_509_1.talkMaxDuration)

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_4 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - 0) / var_512_4

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= 0 + var_512_4 and arg_509_1.time_ < 0 + var_512_4 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play320011124 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 320011124
		arg_513_1.duration_ = 4.57

		local var_513_0 = {
			zh = 4.5,
			ja = 4.566
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play320011125(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.4

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[1026].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_1 = arg_513_1:GetWordFromCfg(320011124)
				local var_516_2 = arg_513_1:FormatText(var_516_1.content)

				arg_513_1.text_.text = var_516_2

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_4 = 16 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_2) / 16)

				if (16 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_2) / 16)) > 0 and var_516_0 < var_516_4 then
					arg_513_1.talkMaxDuration = var_516_4

					if var_516_4 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_4 + 0
					end
				end

				arg_513_1.text_.text = var_516_2
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011124", "story_v_out_320011.awb") ~= 0 then
					local var_516_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011124", "story_v_out_320011.awb") / 1000

					if var_516_5 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_5 + 0
					end

					if var_516_1.prefab_name ~= "" and arg_513_1.actors_[var_516_1.prefab_name] ~= nil then
						local var_516_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_1.prefab_name].transform, "story_v_out_320011", "320011124", "story_v_out_320011.awb")

						arg_513_1:RecordAudio("320011124", var_516_6)
						arg_513_1:RecordAudio("320011124", var_516_6)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_320011", "320011124", "story_v_out_320011.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_320011", "320011124", "story_v_out_320011.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_7 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_7 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_7

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_7 and arg_513_1.time_ < 0 + var_516_7 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play320011125 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 320011125
		arg_517_1.duration_ = 4.17

		local var_517_0 = {
			zh = 3.5,
			ja = 4.166
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
				arg_517_0:Play320011126(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0.375

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[1026].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_1 = arg_517_1:GetWordFromCfg(320011125)
				local var_520_2 = arg_517_1:FormatText(var_520_1.content)

				arg_517_1.text_.text = var_520_2

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_4 = 15 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 15)

				if (15 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 15)) > 0 and var_520_0 < var_520_4 then
					arg_517_1.talkMaxDuration = var_520_4

					if var_520_4 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_4 + 0
					end
				end

				arg_517_1.text_.text = var_520_2
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011125", "story_v_out_320011.awb") ~= 0 then
					local var_520_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011125", "story_v_out_320011.awb") / 1000

					if var_520_5 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_5 + 0
					end

					if var_520_1.prefab_name ~= "" and arg_517_1.actors_[var_520_1.prefab_name] ~= nil then
						local var_520_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_1.prefab_name].transform, "story_v_out_320011", "320011125", "story_v_out_320011.awb")

						arg_517_1:RecordAudio("320011125", var_520_6)
						arg_517_1:RecordAudio("320011125", var_520_6)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_320011", "320011125", "story_v_out_320011.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_320011", "320011125", "story_v_out_320011.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_7 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_7 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_7

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_7 and arg_517_1.time_ < 0 + var_520_7 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play320011126 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 320011126
		arg_521_1.duration_ = 4.3

		local var_521_0 = {
			zh = 4.3,
			ja = 3.033
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
				arg_521_0:Play320011127(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.475

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[1027].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_1 = arg_521_1:GetWordFromCfg(320011126)
				local var_524_2 = arg_521_1:FormatText(var_524_1.content)

				arg_521_1.text_.text = var_524_2

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_4 = 18 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 18)

				if (18 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 18)) > 0 and var_524_0 < var_524_4 then
					arg_521_1.talkMaxDuration = var_524_4

					if var_524_4 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_4 + 0
					end
				end

				arg_521_1.text_.text = var_524_2
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011126", "story_v_out_320011.awb") ~= 0 then
					local var_524_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011126", "story_v_out_320011.awb") / 1000

					if var_524_5 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + 0
					end

					if var_524_1.prefab_name ~= "" and arg_521_1.actors_[var_524_1.prefab_name] ~= nil then
						local var_524_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_1.prefab_name].transform, "story_v_out_320011", "320011126", "story_v_out_320011.awb")

						arg_521_1:RecordAudio("320011126", var_524_6)
						arg_521_1:RecordAudio("320011126", var_524_6)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_320011", "320011126", "story_v_out_320011.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_320011", "320011126", "story_v_out_320011.awb")
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
	Play320011127 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 320011127
		arg_525_1.duration_ = 4.17

		local var_525_0 = {
			zh = 3.566,
			ja = 4.166
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
				arg_525_0:Play320011128(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0.325

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[1026].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_1 = arg_525_1:GetWordFromCfg(320011127)
				local var_528_2 = arg_525_1:FormatText(var_528_1.content)

				arg_525_1.text_.text = var_528_2

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_4 = 13 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 13)

				if (13 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 13)) > 0 and var_528_0 < var_528_4 then
					arg_525_1.talkMaxDuration = var_528_4

					if var_528_4 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_4 + 0
					end
				end

				arg_525_1.text_.text = var_528_2
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011127", "story_v_out_320011.awb") ~= 0 then
					local var_528_5 = manager.audio:GetVoiceLength("story_v_out_320011", "320011127", "story_v_out_320011.awb") / 1000

					if var_528_5 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_5 + 0
					end

					if var_528_1.prefab_name ~= "" and arg_525_1.actors_[var_528_1.prefab_name] ~= nil then
						local var_528_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_1.prefab_name].transform, "story_v_out_320011", "320011127", "story_v_out_320011.awb")

						arg_525_1:RecordAudio("320011127", var_528_6)
						arg_525_1:RecordAudio("320011127", var_528_6)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_320011", "320011127", "story_v_out_320011.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_320011", "320011127", "story_v_out_320011.awb")
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
	Play320011128 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 320011128
		arg_529_1.duration_ = 9

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play320011129(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if arg_529_1.bgs_.L06h == nil then
				local var_532_0 = Object.Instantiate(arg_529_1.paintGo_)

				var_532_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L06h")
				var_532_0.name = "L06h"
				var_532_0.transform.parent = arg_529_1.stage_.transform
				var_532_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_529_1.bgs_.L06h = var_532_0
			end

			if 2 < arg_529_1.time_ and arg_529_1.time_ <= 2 + arg_532_0 then
				local var_532_1 = arg_529_1.bgs_.L06h

				arg_529_1.bgs_.L06h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_532_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_532_2 = var_532_1:GetComponent("SpriteRenderer")

				if var_532_2 and var_532_2.sprite then
					local var_532_3 = 2 * (var_532_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_532_1.transform.localScale = Vector3.New(var_532_3 / var_532_2.sprite.bounds.size.y < var_532_3 * manager.ui.mainCameraCom_.aspect / var_532_2.sprite.bounds.size.x and var_532_3 * manager.ui.mainCameraCom_.aspect / var_532_2.sprite.bounds.size.x or var_532_3 / var_532_2.sprite.bounds.size.y, var_532_3 / var_532_2.sprite.bounds.size.y < var_532_3 * manager.ui.mainCameraCom_.aspect / var_532_2.sprite.bounds.size.x and var_532_3 * manager.ui.mainCameraCom_.aspect / var_532_2.sprite.bounds.size.x or var_532_3 / var_532_2.sprite.bounds.size.y, 0)
				end

				for iter_532_0, iter_532_1 in pairs(arg_529_1.bgs_) do
					if iter_532_0 ~= "L06h" then
						iter_532_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_532_4 = 4

			if 4 < arg_529_1.time_ and arg_529_1.time_ <= var_532_4 + arg_532_0 then
				arg_529_1.allBtn_.enabled = false
			end

			if arg_529_1.time_ >= var_532_4 + 0.3 and arg_529_1.time_ < var_532_4 + 0.3 + arg_532_0 then
				arg_529_1.allBtn_.enabled = true
			end

			local var_532_5 = 0

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_5 + arg_532_0 then
				arg_529_1.mask_.enabled = true
				arg_529_1.mask_.raycastTarget = true

				arg_529_1:SetGaussion(false)
			end

			local var_532_6 = 2

			if var_532_5 <= arg_529_1.time_ and arg_529_1.time_ < var_532_5 + var_532_6 then
				local var_532_7 = Color.New(0, 0, 0)

				var_532_7.a = Mathf.Lerp(0, 1, (arg_529_1.time_ - var_532_5) / var_532_6)
				arg_529_1.mask_.color = var_532_7
			end

			if arg_529_1.time_ >= var_532_5 + var_532_6 and arg_529_1.time_ < var_532_5 + var_532_6 + arg_532_0 then
				local var_532_8 = Color.New(0, 0, 0)

				var_532_8.a = 1
				arg_529_1.mask_.color = var_532_8
			end

			local var_532_9 = 2

			if 2 < arg_529_1.time_ and arg_529_1.time_ <= var_532_9 + arg_532_0 then
				arg_529_1.mask_.enabled = true
				arg_529_1.mask_.raycastTarget = true

				arg_529_1:SetGaussion(false)
			end

			local var_532_10 = 2

			if var_532_9 <= arg_529_1.time_ and arg_529_1.time_ < var_532_9 + var_532_10 then
				local var_532_11 = Color.New(0, 0, 0)

				var_532_11.a = Mathf.Lerp(1, 0, (arg_529_1.time_ - var_532_9) / var_532_10)
				arg_529_1.mask_.color = var_532_11
			end

			if arg_529_1.time_ >= var_532_9 + var_532_10 and arg_529_1.time_ < var_532_9 + var_532_10 + arg_532_0 then
				local var_532_12 = Color.New(0, 0, 0)

				arg_529_1.mask_.enabled = false
				var_532_12.a = 0
				arg_529_1.mask_.color = var_532_12
			end

			if 1.9 < arg_529_1.time_ and arg_529_1.time_ <= 1.9 + arg_532_0 then
				if arg_529_1.var_.effectcanpian1 then
					Object.Destroy(arg_529_1.var_.effectcanpian1)

					arg_529_1.var_.effectcanpian1 = nil
				end
			end

			if 0.3 < arg_529_1.time_ and arg_529_1.time_ <= 0.3 + arg_532_0 then
				arg_529_1:AudioAction("play", "effect", "se_story_side_1059", "se_story_1059_motorcycle", "")
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:AudioAction("stop", "effect", "se_story_8", "se_story_8_fire_environment_loop", "")
			end

			if arg_529_1.frameCnt_ <= 1 then
				arg_529_1.dialog_:SetActive(false)
			end

			local var_532_16 = 4
			local var_532_17 = 0.65

			if 4 < arg_529_1.time_ and arg_529_1.time_ <= var_532_16 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0

				arg_529_1.dialog_:SetActive(true)

				arg_529_1.dialogCg_.alpha = 0

				local var_532_18 = LeanTween.value(arg_529_1.dialog_, 0, 1, 0.3)

				var_532_18:setOnUpdate(LuaHelper.FloatAction(function(arg_533_0)
					arg_529_1.dialogCg_.alpha = arg_533_0
				end))
				var_532_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_529_1.dialog_)
					var_532_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_529_1.duration_ = arg_529_1.duration_ + 0.3

				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_19 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(320011128).content)

				arg_529_1.text_.text = var_532_19

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_21 = 26 <= 0 and var_532_17 or var_532_17 * (utf8.len(var_532_19) / 26)

				if (26 <= 0 and var_532_17 or var_532_17 * (utf8.len(var_532_19) / 26)) > 0 and var_532_17 < var_532_21 then
					arg_529_1.talkMaxDuration = var_532_21
					var_532_16 = var_532_16 + 0.3

					if var_532_21 + var_532_16 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_21 + var_532_16
					end
				end

				arg_529_1.text_.text = var_532_19
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_22 = var_532_16 + 0.3
			local var_532_23 = math.max(var_532_17, arg_529_1.talkMaxDuration)

			if var_532_16 + 0.3 <= arg_529_1.time_ and arg_529_1.time_ < var_532_22 + var_532_23 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_22) / var_532_23

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_22 + var_532_23 and arg_529_1.time_ < var_532_22 + var_532_23 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play320011129 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 320011129
		arg_535_1.duration_ = 9.83

		local var_535_0 = {
			zh = 6.3,
			ja = 9.833
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
				arg_535_0:Play320011130(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.var_.moveOldPos10100ui_story = arg_535_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_538_0 = 0.001

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 then
				arg_535_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_535_1.time_ - 0) / var_538_0)
				arg_535_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_535_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["10100ui_story"].transform.position).z)
				arg_535_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_535_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_535_1.actors_["10100ui_story"].transform.localEulerAngles = arg_535_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 then
				arg_535_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_535_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_535_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["10100ui_story"].transform.position).z)
				arg_535_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_535_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_535_1.actors_["10100ui_story"].transform.localEulerAngles = arg_535_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_538_1 = arg_535_1.actors_["10100ui_story"]

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(var_538_1) and arg_535_1.var_.characterEffect10100ui_story == nil then
				arg_535_1.var_.characterEffect10100ui_story = var_538_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_2 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_2 and not isNil(var_538_1) then
				if arg_535_1.var_.characterEffect10100ui_story and not isNil(var_538_1) then
					arg_535_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_535_1.time_ >= 0 + var_538_2 and arg_535_1.time_ < 0 + var_538_2 + arg_538_0 and not isNil(var_538_1) and arg_535_1.var_.characterEffect10100ui_story then
				arg_535_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action4420")
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_538_4 = 0
			local var_538_5 = 1

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_4 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_6 = arg_535_1:GetWordFromCfg(320011129)
				local var_538_7 = arg_535_1:FormatText(var_538_6.content)

				arg_535_1.text_.text = var_538_7

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_9 = 40 <= 0 and var_538_5 or var_538_5 * (utf8.len(var_538_7) / 40)

				if (40 <= 0 and var_538_5 or var_538_5 * (utf8.len(var_538_7) / 40)) > 0 and var_538_5 < var_538_9 then
					arg_535_1.talkMaxDuration = var_538_9

					if var_538_9 + var_538_4 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_9 + var_538_4
					end
				end

				arg_535_1.text_.text = var_538_7
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011129", "story_v_out_320011.awb") ~= 0 then
					local var_538_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011129", "story_v_out_320011.awb") / 1000

					if var_538_10 + var_538_4 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_10 + var_538_4
					end

					if var_538_6.prefab_name ~= "" and arg_535_1.actors_[var_538_6.prefab_name] ~= nil then
						local var_538_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_6.prefab_name].transform, "story_v_out_320011", "320011129", "story_v_out_320011.awb")

						arg_535_1:RecordAudio("320011129", var_538_11)
						arg_535_1:RecordAudio("320011129", var_538_11)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_320011", "320011129", "story_v_out_320011.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_320011", "320011129", "story_v_out_320011.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_12 = math.max(var_538_5, arg_535_1.talkMaxDuration)

			if var_538_4 <= arg_535_1.time_ and arg_535_1.time_ < var_538_4 + var_538_12 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_4) / var_538_12

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_4 + var_538_12 and arg_535_1.time_ < var_538_4 + var_538_12 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play320011130 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 320011130
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play320011131(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(arg_539_1.actors_["10100ui_story"]) and arg_539_1.var_.characterEffect10100ui_story == nil then
				arg_539_1.var_.characterEffect10100ui_story = arg_539_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_0 = 0.200000002980232

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 and not isNil(arg_539_1.actors_["10100ui_story"]) then
				if arg_539_1.var_.characterEffect10100ui_story and not isNil(arg_539_1.actors_["10100ui_story"]) then
					arg_539_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_539_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_539_1.time_ - 0) / var_542_0)
				end
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 and not isNil(arg_539_1.actors_["10100ui_story"]) and arg_539_1.var_.characterEffect10100ui_story then
				arg_539_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_539_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_542_1 = arg_539_1.actors_["10100ui_story"].transform

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.var_.moveOldPos10100ui_story = var_542_1.localPosition
			end

			local var_542_2 = 0.001

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_2 then
				var_542_1.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_539_1.time_ - 0) / var_542_2)
				var_542_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_542_1.position).x, (manager.ui.mainCamera.transform.position - var_542_1.position).y, (manager.ui.mainCamera.transform.position - var_542_1.position).z)
				var_542_1.localEulerAngles.z = 0
				var_542_1.localEulerAngles.x = 0
				var_542_1.localEulerAngles = var_542_1.localEulerAngles
			end

			if arg_539_1.time_ >= 0 + var_542_2 and arg_539_1.time_ < 0 + var_542_2 + arg_542_0 then
				var_542_1.localPosition = Vector3.New(0, 100, 0)
				var_542_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_542_1.position).x, (manager.ui.mainCamera.transform.position - var_542_1.position).y, (manager.ui.mainCamera.transform.position - var_542_1.position).z)
				var_542_1.localEulerAngles.z = 0
				var_542_1.localEulerAngles.x = 0
				var_542_1.localEulerAngles = var_542_1.localEulerAngles
			end

			local var_542_3 = 0
			local var_542_4 = 0.9

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_3 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, false)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_5 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(320011130).content)

				arg_539_1.text_.text = var_542_5

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_7 = 36 <= 0 and var_542_4 or var_542_4 * (utf8.len(var_542_5) / 36)

				if (36 <= 0 and var_542_4 or var_542_4 * (utf8.len(var_542_5) / 36)) > 0 and var_542_4 < var_542_7 then
					arg_539_1.talkMaxDuration = var_542_7

					if var_542_7 + var_542_3 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_7 + var_542_3
					end
				end

				arg_539_1.text_.text = var_542_5
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_8 = math.max(var_542_4, arg_539_1.talkMaxDuration)

			if var_542_3 <= arg_539_1.time_ and arg_539_1.time_ < var_542_3 + var_542_8 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_3) / var_542_8

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_3 + var_542_8 and arg_539_1.time_ < var_542_3 + var_542_8 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_539_1:InitPlayNodeList()
	end,
	Play320011131 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 320011131
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play320011132(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0.725

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, false)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_1 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(320011131).content)

				arg_543_1.text_.text = var_546_1

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_3 = 30 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 30)

				if (30 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 30)) > 0 and var_546_0 < var_546_3 then
					arg_543_1.talkMaxDuration = var_546_3

					if var_546_3 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_3 + 0
					end
				end

				arg_543_1.text_.text = var_546_1
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_4 = math.max(var_546_0, arg_543_1.talkMaxDuration)

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_4 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - 0) / var_546_4

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= 0 + var_546_4 and arg_543_1.time_ < 0 + var_546_4 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play320011132 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 320011132
		arg_547_1.duration_ = 2.23

		local var_547_0 = {
			zh = 2,
			ja = 2.233
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
				arg_547_0:Play320011133(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.var_.moveOldPos10100ui_story = arg_547_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_550_0 = 0.001

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 then
				arg_547_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_547_1.time_ - 0) / var_550_0)
				arg_547_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_547_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_547_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_547_1.actors_["10100ui_story"].transform.position).z)
				arg_547_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_547_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_547_1.actors_["10100ui_story"].transform.localEulerAngles = arg_547_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 then
				arg_547_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_547_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_547_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_547_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_547_1.actors_["10100ui_story"].transform.position).z)
				arg_547_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_547_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_547_1.actors_["10100ui_story"].transform.localEulerAngles = arg_547_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_550_1 = arg_547_1.actors_["10100ui_story"]

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(var_550_1) and arg_547_1.var_.characterEffect10100ui_story == nil then
				arg_547_1.var_.characterEffect10100ui_story = var_550_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_2 = 0.200000002980232

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_2 and not isNil(var_550_1) then
				if arg_547_1.var_.characterEffect10100ui_story and not isNil(var_550_1) then
					arg_547_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_547_1.time_ >= 0 + var_550_2 and arg_547_1.time_ < 0 + var_550_2 + arg_550_0 and not isNil(var_550_1) and arg_547_1.var_.characterEffect10100ui_story then
				arg_547_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action20_2")
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_550_4 = 0
			local var_550_5 = 0.15

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_4 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_6 = arg_547_1:GetWordFromCfg(320011132)
				local var_550_7 = arg_547_1:FormatText(var_550_6.content)

				arg_547_1.text_.text = var_550_7

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_9 = 6 <= 0 and var_550_5 or var_550_5 * (utf8.len(var_550_7) / 6)

				if (6 <= 0 and var_550_5 or var_550_5 * (utf8.len(var_550_7) / 6)) > 0 and var_550_5 < var_550_9 then
					arg_547_1.talkMaxDuration = var_550_9

					if var_550_9 + var_550_4 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_9 + var_550_4
					end
				end

				arg_547_1.text_.text = var_550_7
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011132", "story_v_out_320011.awb") ~= 0 then
					local var_550_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011132", "story_v_out_320011.awb") / 1000

					if var_550_10 + var_550_4 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_10 + var_550_4
					end

					if var_550_6.prefab_name ~= "" and arg_547_1.actors_[var_550_6.prefab_name] ~= nil then
						local var_550_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_6.prefab_name].transform, "story_v_out_320011", "320011132", "story_v_out_320011.awb")

						arg_547_1:RecordAudio("320011132", var_550_11)
						arg_547_1:RecordAudio("320011132", var_550_11)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_out_320011", "320011132", "story_v_out_320011.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_out_320011", "320011132", "story_v_out_320011.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_12 = math.max(var_550_5, arg_547_1.talkMaxDuration)

			if var_550_4 <= arg_547_1.time_ and arg_547_1.time_ < var_550_4 + var_550_12 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_4) / var_550_12

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_4 + var_550_12 and arg_547_1.time_ < var_550_4 + var_550_12 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	Play320011133 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 320011133
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play320011134(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 and not isNil(arg_551_1.actors_["10100ui_story"]) and arg_551_1.var_.characterEffect10100ui_story == nil then
				arg_551_1.var_.characterEffect10100ui_story = arg_551_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_0 = 0.200000002980232

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_0 and not isNil(arg_551_1.actors_["10100ui_story"]) then
				if arg_551_1.var_.characterEffect10100ui_story and not isNil(arg_551_1.actors_["10100ui_story"]) then
					arg_551_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_551_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_551_1.time_ - 0) / var_554_0)
				end
			end

			if arg_551_1.time_ >= 0 + var_554_0 and arg_551_1.time_ < 0 + var_554_0 + arg_554_0 and not isNil(arg_551_1.actors_["10100ui_story"]) and arg_551_1.var_.characterEffect10100ui_story then
				arg_551_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_551_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_554_1 = arg_551_1.actors_["10100ui_story"].transform

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.var_.moveOldPos10100ui_story = var_554_1.localPosition
			end

			local var_554_2 = 0.1

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_2 then
				var_554_1.localPosition = Vector3.Lerp(arg_551_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_551_1.time_ - 0) / var_554_2)
				var_554_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_554_1.position).x, (manager.ui.mainCamera.transform.position - var_554_1.position).y, (manager.ui.mainCamera.transform.position - var_554_1.position).z)
				var_554_1.localEulerAngles.z = 0
				var_554_1.localEulerAngles.x = 0
				var_554_1.localEulerAngles = var_554_1.localEulerAngles
			end

			if arg_551_1.time_ >= 0 + var_554_2 and arg_551_1.time_ < 0 + var_554_2 + arg_554_0 then
				var_554_1.localPosition = Vector3.New(0, 100, 0)
				var_554_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_554_1.position).x, (manager.ui.mainCamera.transform.position - var_554_1.position).y, (manager.ui.mainCamera.transform.position - var_554_1.position).z)
				var_554_1.localEulerAngles.z = 0
				var_554_1.localEulerAngles.x = 0
				var_554_1.localEulerAngles = var_554_1.localEulerAngles
			end

			local var_554_3 = 0
			local var_554_4 = 0.575

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_3 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, false)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_5 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(320011133).content)

				arg_551_1.text_.text = var_554_5

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_7 = 23 <= 0 and var_554_4 or var_554_4 * (utf8.len(var_554_5) / 23)

				if (23 <= 0 and var_554_4 or var_554_4 * (utf8.len(var_554_5) / 23)) > 0 and var_554_4 < var_554_7 then
					arg_551_1.talkMaxDuration = var_554_7

					if var_554_7 + var_554_3 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_7 + var_554_3
					end
				end

				arg_551_1.text_.text = var_554_5
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_8 = math.max(var_554_4, arg_551_1.talkMaxDuration)

			if var_554_3 <= arg_551_1.time_ and arg_551_1.time_ < var_554_3 + var_554_8 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_3) / var_554_8

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_3 + var_554_8 and arg_551_1.time_ < var_554_3 + var_554_8 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_551_1:InitPlayNodeList()
	end,
	Play320011134 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 320011134
		arg_555_1.duration_ = 1.43

		local var_555_0 = {
			zh = 1.266,
			ja = 1.433
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play320011135(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_558_0 = 0.6

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 then
				local var_558_1, var_558_2 = math.modf((arg_555_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_558_2 * 0.13, var_558_2 * 0.13, var_558_2 * 0.13) + arg_555_1.var_.shakeOldPos
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 then
				manager.ui.mainCamera.transform.localPosition = arg_555_1.var_.shakeOldPos
			end

			local var_558_3 = 0

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_3 + arg_558_0 then
				arg_555_1.allBtn_.enabled = false
			end

			if arg_555_1.time_ >= var_558_3 + 0.6 and arg_555_1.time_ < var_558_3 + 0.6 + arg_558_0 then
				arg_555_1.allBtn_.enabled = true
			end

			local var_558_4 = 0
			local var_558_5 = 0.225

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_4 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, true)
				arg_555_1.iconController_:SetSelectedState("hero")

				arg_555_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10100")

				arg_555_1.callingController_:SetSelectedState("normal")

				arg_555_1.keyicon_.color = Color.New(1, 1, 1)
				arg_555_1.icon_.color = Color.New(1, 1, 1)

				local var_558_6 = arg_555_1:GetWordFromCfg(320011134)
				local var_558_7 = arg_555_1:FormatText(var_558_6.content)

				arg_555_1.text_.text = var_558_7

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_9 = 9 <= 0 and var_558_5 or var_558_5 * (utf8.len(var_558_7) / 9)

				if (9 <= 0 and var_558_5 or var_558_5 * (utf8.len(var_558_7) / 9)) > 0 and var_558_5 < var_558_9 then
					arg_555_1.talkMaxDuration = var_558_9

					if var_558_9 + var_558_4 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_9 + var_558_4
					end
				end

				arg_555_1.text_.text = var_558_7
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320011", "320011134", "story_v_out_320011.awb") ~= 0 then
					local var_558_10 = manager.audio:GetVoiceLength("story_v_out_320011", "320011134", "story_v_out_320011.awb") / 1000

					if var_558_10 + var_558_4 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_10 + var_558_4
					end

					if var_558_6.prefab_name ~= "" and arg_555_1.actors_[var_558_6.prefab_name] ~= nil then
						local var_558_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_6.prefab_name].transform, "story_v_out_320011", "320011134", "story_v_out_320011.awb")

						arg_555_1:RecordAudio("320011134", var_558_11)
						arg_555_1:RecordAudio("320011134", var_558_11)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_out_320011", "320011134", "story_v_out_320011.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_out_320011", "320011134", "story_v_out_320011.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_12 = math.max(var_558_5, arg_555_1.talkMaxDuration)

			if var_558_4 <= arg_555_1.time_ and arg_555_1.time_ < var_558_4 + var_558_12 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_4) / var_558_12

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_4 + var_558_12 and arg_555_1.time_ < var_558_4 + var_558_12 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play320011135 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 320011135
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play320011136(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.var_.moveOldPos10100ui_story = arg_559_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_562_0 = 0.001

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_0 then
				arg_559_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_559_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_559_1.time_ - 0) / var_562_0)
				arg_559_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_559_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["10100ui_story"].transform.position).z)
				arg_559_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_559_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_559_1.actors_["10100ui_story"].transform.localEulerAngles = arg_559_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_559_1.time_ >= 0 + var_562_0 and arg_559_1.time_ < 0 + var_562_0 + arg_562_0 then
				arg_559_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_559_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_559_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["10100ui_story"].transform.position).z)
				arg_559_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_559_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_559_1.actors_["10100ui_story"].transform.localEulerAngles = arg_559_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_562_1 = arg_559_1.actors_["10100ui_story"]

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 and not isNil(var_562_1) and arg_559_1.var_.characterEffect10100ui_story == nil then
				arg_559_1.var_.characterEffect10100ui_story = var_562_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_2 = 0.200000002980232

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_2 and not isNil(var_562_1) then
				if arg_559_1.var_.characterEffect10100ui_story and not isNil(var_562_1) then
					arg_559_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_559_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_559_1.time_ - 0) / var_562_2)
				end
			end

			if arg_559_1.time_ >= 0 + var_562_2 and arg_559_1.time_ < 0 + var_562_2 + arg_562_0 and not isNil(var_562_1) and arg_559_1.var_.characterEffect10100ui_story then
				arg_559_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_559_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1:AudioAction("play", "music", "se_story_126_01", "se_story_126_01_fastshot", "")

				local var_562_5 = manager.audio:GetAudioName("se_story_126_01", "se_story_126_01_fastshot")

				if "" ~= "" then
					if arg_559_1.bgmTxt_.text ~= var_562_5 and arg_559_1.bgmTxt_.text ~= "" then
						if arg_559_1.bgmTxt2_.text ~= "" then
							arg_559_1.bgmTxt_.text = arg_559_1.bgmTxt2_.text
						end

						arg_559_1.bgmTxt2_.text = var_562_5

						arg_559_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_559_1.bgmTxt_.text = var_562_5
						arg_559_1.bgmTxt2_.text = var_562_5
					end

					if arg_559_1.bgmTimer then
						arg_559_1.bgmTimer:Stop()

						arg_559_1.bgmTimer = nil
					end

					if arg_559_1.settingData.show_music_name == 1 then
						arg_559_1.musicController:SetSelectedState("show")
						arg_559_1.musicAnimator_:Play("open", 0, 0)

						if arg_559_1.settingData.music_time ~= 0 then
							arg_559_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_559_1.settingData.music_time), function()
								if arg_559_1 == nil or isNil(arg_559_1.bgmTxt_) then
									return
								end

								arg_559_1.musicController:SetSelectedState("hide")
								arg_559_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_562_6 = 0
			local var_562_7 = 0.825

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_6 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, false)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_8 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(320011135).content)

				arg_559_1.text_.text = var_562_8

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_10 = 33 <= 0 and var_562_7 or var_562_7 * (utf8.len(var_562_8) / 33)

				if (33 <= 0 and var_562_7 or var_562_7 * (utf8.len(var_562_8) / 33)) > 0 and var_562_7 < var_562_10 then
					arg_559_1.talkMaxDuration = var_562_10

					if var_562_10 + var_562_6 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_10 + var_562_6
					end
				end

				arg_559_1.text_.text = var_562_8
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_11 = math.max(var_562_7, arg_559_1.talkMaxDuration)

			if var_562_6 <= arg_559_1.time_ and arg_559_1.time_ < var_562_6 + var_562_11 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_6) / var_562_11

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_6 + var_562_11 and arg_559_1.time_ < var_562_6 + var_562_11 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_559_1:InitPlayNodeList()
	end,
	Play320011136 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 320011136
		arg_564_1.duration_ = 6

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play320011137(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1.mask_.enabled = true
				arg_564_1.mask_.raycastTarget = true

				arg_564_1:SetGaussion(false)
			end

			local var_567_0 = 1

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_0 then
				local var_567_1 = Color.New(1, 1, 1)

				var_567_1.a = Mathf.Lerp(1, 0, (arg_564_1.time_ - 0) / var_567_0)
				arg_564_1.mask_.color = var_567_1
			end

			if arg_564_1.time_ >= 0 + var_567_0 and arg_564_1.time_ < 0 + var_567_0 + arg_567_0 then
				local var_567_2 = Color.New(1, 1, 1)

				arg_564_1.mask_.enabled = false
				var_567_2.a = 0
				arg_564_1.mask_.color = var_567_2
			end

			if arg_564_1.frameCnt_ <= 1 then
				arg_564_1.dialog_:SetActive(false)
			end

			local var_567_3 = 1
			local var_567_4 = 2.05

			if 1 < arg_564_1.time_ and arg_564_1.time_ <= var_567_3 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0

				arg_564_1.dialog_:SetActive(true)

				arg_564_1.dialogCg_.alpha = 0

				local var_567_5 = LeanTween.value(arg_564_1.dialog_, 0, 1, 0.3)

				var_567_5:setOnUpdate(LuaHelper.FloatAction(function(arg_568_0)
					arg_564_1.dialogCg_.alpha = arg_568_0
				end))
				var_567_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_564_1.dialog_)
					var_567_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_564_1.duration_ = arg_564_1.duration_ + 0.3

				SetActive(arg_564_1.leftNameGo_, false)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_6 = arg_564_1:FormatText(arg_564_1:GetWordFromCfg(320011136).content)

				arg_564_1.text_.text = var_567_6

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_8 = 82 <= 0 and var_567_4 or var_567_4 * (utf8.len(var_567_6) / 82)

				if (82 <= 0 and var_567_4 or var_567_4 * (utf8.len(var_567_6) / 82)) > 0 and var_567_4 < var_567_8 then
					arg_564_1.talkMaxDuration = var_567_8
					var_567_3 = var_567_3 + 0.3

					if var_567_8 + var_567_3 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_8 + var_567_3
					end
				end

				arg_564_1.text_.text = var_567_6
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_9 = var_567_3 + 0.3
			local var_567_10 = math.max(var_567_4, arg_564_1.talkMaxDuration)

			if var_567_3 + 0.3 <= arg_564_1.time_ and arg_564_1.time_ < var_567_9 + var_567_10 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_9) / var_567_10

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_9 + var_567_10 and arg_564_1.time_ < var_567_9 + var_567_10 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play320011137 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 320011137
		arg_570_1.duration_ = 5

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play320011138(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = 1.325

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, false)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_1 = arg_570_1:FormatText(arg_570_1:GetWordFromCfg(320011137).content)

				arg_570_1.text_.text = var_573_1

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_3 = 53 <= 0 and var_573_0 or var_573_0 * (utf8.len(var_573_1) / 53)

				if (53 <= 0 and var_573_0 or var_573_0 * (utf8.len(var_573_1) / 53)) > 0 and var_573_0 < var_573_3 then
					arg_570_1.talkMaxDuration = var_573_3

					if var_573_3 + 0 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_3 + 0
					end
				end

				arg_570_1.text_.text = var_573_1
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)
				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_4 = math.max(var_573_0, arg_570_1.talkMaxDuration)

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_4 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - 0) / var_573_4

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= 0 + var_573_4 and arg_570_1.time_ < 0 + var_573_4 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play320011138 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 320011138
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
			arg_574_1.auto_ = false
		end

		function arg_574_1.playNext_(arg_576_0)
			arg_574_1.onStoryFinished_()
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_9001
			local var_577_9000

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 then
				arg_574_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_577_0 = 0.6

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_0 then
				local var_577_1, var_577_2 = math.modf((arg_574_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_577_2 * 0.13, var_577_2 * 0.13, var_577_2 * 0.13) + arg_574_1.var_.shakeOldPos
			end

			if arg_574_1.time_ >= 0 + var_577_0 and arg_574_1.time_ < 0 + var_577_0 + arg_577_0 then
				manager.ui.mainCamera.transform.localPosition = arg_574_1.var_.shakeOldPos
			end

			local var_577_3 = 0

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_3 + arg_577_0 then
				arg_574_1.allBtn_.enabled = false
			end

			if arg_574_1.time_ >= var_577_3 + 0.6 and arg_574_1.time_ < var_577_3 + 0.6 + arg_577_0 then
				arg_574_1.allBtn_.enabled = true
			end

			if 0.366666666666667 < arg_574_1.time_ and arg_574_1.time_ <= 0.366666666666667 + arg_577_0 then
				local var_577_4 = arg_574_1.var_.effectjupiluoliuxue1

				if not arg_574_1.var_.effectjupiluoliuxue1 then
					var_577_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), manager.ui.mainCamera.transform)
					var_577_4.name = "jupiluoliuxue1"
					arg_574_1.var_.effectjupiluoliuxue1 = var_577_4
				else
					var_577_4.transform:SetParent(var_577_9001)
				end

				var_577_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_577_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.366666666666667 < arg_574_1.time_ and arg_574_1.time_ <= 0.366666666666667 + arg_577_0 then
				local var_577_6 = arg_574_1.var_.effectjupiluoliuxue2

				if not arg_574_1.var_.effectjupiluoliuxue2 then
					var_577_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in_ui"), manager.ui.mainCamera.transform)
					var_577_6.name = "jupiluoliuxue2"
					arg_574_1.var_.effectjupiluoliuxue2 = var_577_6
				else
					var_577_6.transform:SetParent(var_577_9000)
				end

				var_577_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_577_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_577_8 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_577_9 = var_577_6.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_577_0, iter_577_1 in ipairs((var_577_9:ToTable())) do
					iter_577_1.transform.localScale = Vector3.New(iter_577_1.transform.localScale.x / var_577_8 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_577_9 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_577_1.transform.localScale.y / var_577_8, iter_577_1.transform.localScale.z)
				end
			end

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 then
				arg_574_1:AudioAction("play", "music", "se_story", "se_story_explosion", "")

				local var_577_13 = manager.audio:GetAudioName("se_story", "se_story_explosion")

				if "" ~= "" then
					if arg_574_1.bgmTxt_.text ~= var_577_13 and arg_574_1.bgmTxt_.text ~= "" then
						if arg_574_1.bgmTxt2_.text ~= "" then
							arg_574_1.bgmTxt_.text = arg_574_1.bgmTxt2_.text
						end

						arg_574_1.bgmTxt2_.text = var_577_13

						arg_574_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_574_1.bgmTxt_.text = var_577_13
						arg_574_1.bgmTxt2_.text = var_577_13
					end

					if arg_574_1.bgmTimer then
						arg_574_1.bgmTimer:Stop()

						arg_574_1.bgmTimer = nil
					end

					if arg_574_1.settingData.show_music_name == 1 then
						arg_574_1.musicController:SetSelectedState("show")
						arg_574_1.musicAnimator_:Play("open", 0, 0)

						if arg_574_1.settingData.music_time ~= 0 then
							arg_574_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_574_1.settingData.music_time), function()
								if arg_574_1 == nil or isNil(arg_574_1.bgmTxt_) then
									return
								end

								arg_574_1.musicController:SetSelectedState("hide")
								arg_574_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_577_14 = 0
			local var_577_15 = 1.075

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_14 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, false)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_16 = arg_574_1:FormatText(arg_574_1:GetWordFromCfg(320011138).content)

				arg_574_1.text_.text = var_577_16

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_18 = 43 <= 0 and var_577_15 or var_577_15 * (utf8.len(var_577_16) / 43)

				if (43 <= 0 and var_577_15 or var_577_15 * (utf8.len(var_577_16) / 43)) > 0 and var_577_15 < var_577_18 then
					arg_574_1.talkMaxDuration = var_577_18

					if var_577_18 + var_577_14 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_18 + var_577_14
					end
				end

				arg_574_1.text_.text = var_577_16
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_19 = math.max(var_577_15, arg_574_1.talkMaxDuration)

			if var_577_14 <= arg_574_1.time_ and arg_574_1.time_ < var_577_14 + var_577_19 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_14) / var_577_19

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_14 + var_577_19 and arg_574_1.time_ < var_577_14 + var_577_19 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"SofdecAsset/story/story_1032001.usm",
		"TextureConfig/Background/ST0501",
		"TextureConfig/Background/L02g",
		"TextureConfig/Background/L06h"
	},
	voices = {
		"story_v_out_320011.awb"
	},
	skipMarkers = {
		320011001
	}
}
