return {
	Play416011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416011001
		arg_1_1.duration_ = 22.2

		local var_1_0 = {
			zh = 15.4,
			ja = 22.2
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
				arg_1_0:Play416011002(arg_1_1)
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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_138", "se_story_138_carloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_12 = 2
			local var_4_13 = 1.425

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
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

				local var_4_15 = arg_1_1:GetWordFromCfg(416011001)
				local var_4_16 = arg_1_1:FormatText(var_4_15.content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 57 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_16) / 57)

				if (57 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_16) / 57)) > 0 and var_4_13 < var_4_18 then
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

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011001", "story_v_out_416011.awb") ~= 0 then
					local var_4_19 = manager.audio:GetVoiceLength("story_v_out_416011", "416011001", "story_v_out_416011.awb") / 1000

					if var_4_19 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_12
					end

					if var_4_15.prefab_name ~= "" and arg_1_1.actors_[var_4_15.prefab_name] ~= nil then
						local var_4_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_15.prefab_name].transform, "story_v_out_416011", "416011001", "story_v_out_416011.awb")

						arg_1_1:RecordAudio("416011001", var_4_20)
						arg_1_1:RecordAudio("416011001", var_4_20)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416011", "416011001", "story_v_out_416011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416011", "416011001", "story_v_out_416011.awb")
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
	Play416011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 416011002
		arg_8_1.duration_ = 8

		local var_8_0 = {
			zh = 7.3,
			ja = 8
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
				arg_8_0:Play416011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.9

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

				local var_11_1 = arg_8_1:GetWordFromCfg(416011002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 36 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 36)

				if (36 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 36)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011002", "story_v_out_416011.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_416011", "416011002", "story_v_out_416011.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_416011", "416011002", "story_v_out_416011.awb")

						arg_8_1:RecordAudio("416011002", var_11_6)
						arg_8_1:RecordAudio("416011002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_416011", "416011002", "story_v_out_416011.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_416011", "416011002", "story_v_out_416011.awb")
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
	Play416011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 416011003
		arg_12_1.duration_ = 4.83

		local var_12_0 = {
			zh = 3.033,
			ja = 4.833
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
				arg_12_0:Play416011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.325

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

				local var_15_1 = arg_12_1:GetWordFromCfg(416011003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 13 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 13)

				if (13 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 13)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011003", "story_v_out_416011.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_416011", "416011003", "story_v_out_416011.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_416011", "416011003", "story_v_out_416011.awb")

						arg_12_1:RecordAudio("416011003", var_15_6)
						arg_12_1:RecordAudio("416011003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_416011", "416011003", "story_v_out_416011.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_416011", "416011003", "story_v_out_416011.awb")
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
	Play416011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 416011004
		arg_16_1.duration_ = 4.5

		local var_16_0 = {
			zh = 4.5,
			ja = 4.466
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play416011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0.166666666666667 < arg_16_1.time_ and arg_16_1.time_ <= 0.166666666666667 + arg_19_0 then
				arg_16_1:AudioAction("stop", "effect", "se_story_138", "se_story_138_carloop", "")
			end

			if 0.166666666666667 < arg_16_1.time_ and arg_16_1.time_ <= 0.166666666666667 + arg_19_0 then
				arg_16_1:AudioAction("play", "effect", "se_story_138", "se_story_138_carloop_stop", "")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_alarmclock", "")
			end

			local var_19_3 = 0
			local var_19_4 = 0.6

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_3 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[646].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_5 = arg_16_1:GetWordFromCfg(416011004)
				local var_19_6 = arg_16_1:FormatText(var_19_5.content)

				arg_16_1.text_.text = var_19_6

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_8 = 24 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_6) / 24)

				if (24 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_6) / 24)) > 0 and var_19_4 < var_19_8 then
					arg_16_1.talkMaxDuration = var_19_8

					if var_19_8 + var_19_3 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_3
					end
				end

				arg_16_1.text_.text = var_19_6
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011004", "story_v_out_416011.awb") ~= 0 then
					local var_19_9 = manager.audio:GetVoiceLength("story_v_out_416011", "416011004", "story_v_out_416011.awb") / 1000

					if var_19_9 + var_19_3 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_3
					end

					if var_19_5.prefab_name ~= "" and arg_16_1.actors_[var_19_5.prefab_name] ~= nil then
						local var_19_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_5.prefab_name].transform, "story_v_out_416011", "416011004", "story_v_out_416011.awb")

						arg_16_1:RecordAudio("416011004", var_19_10)
						arg_16_1:RecordAudio("416011004", var_19_10)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_416011", "416011004", "story_v_out_416011.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_416011", "416011004", "story_v_out_416011.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_11 = math.max(var_19_4, arg_16_1.talkMaxDuration)

			if var_19_3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_3 + var_19_11 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_3) / var_19_11

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_3 + var_19_11 and arg_16_1.time_ < var_19_3 + var_19_11 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play416011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 416011005
		arg_20_1.duration_ = 7.3

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play416011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 1.3 < arg_20_1.time_ and arg_20_1.time_ <= 1.3 + arg_23_0 then
				local var_23_0 = arg_20_1.bgs_.STblack

				arg_20_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_23_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_1 = var_23_0:GetComponent("SpriteRenderer")

				if var_23_1 and var_23_1.sprite then
					local var_23_2 = 2 * (var_23_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_23_0.transform.localScale = Vector3.New(var_23_2 / var_23_1.sprite.bounds.size.y < var_23_2 * manager.ui.mainCameraCom_.aspect / var_23_1.sprite.bounds.size.x and var_23_2 * manager.ui.mainCameraCom_.aspect / var_23_1.sprite.bounds.size.x or var_23_2 / var_23_1.sprite.bounds.size.y, var_23_2 / var_23_1.sprite.bounds.size.y < var_23_2 * manager.ui.mainCameraCom_.aspect / var_23_1.sprite.bounds.size.x and var_23_2 * manager.ui.mainCameraCom_.aspect / var_23_1.sprite.bounds.size.x or var_23_2 / var_23_1.sprite.bounds.size.y, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "STblack" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_3 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_3 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_4 = 1.3

			if var_23_3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_3 + var_23_4 then
				local var_23_5 = Color.New(0, 0, 0)

				var_23_5.a = Mathf.Lerp(0, 1, (arg_20_1.time_ - var_23_3) / var_23_4)
				arg_20_1.mask_.color = var_23_5
			end

			if arg_20_1.time_ >= var_23_3 + var_23_4 and arg_20_1.time_ < var_23_3 + var_23_4 + arg_23_0 then
				local var_23_6 = Color.New(0, 0, 0)

				var_23_6.a = 1
				arg_20_1.mask_.color = var_23_6
			end

			local var_23_7 = 1.3

			if 1.3 < arg_20_1.time_ and arg_20_1.time_ <= var_23_7 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_8 = 1.33333333333333

			if var_23_7 <= arg_20_1.time_ and arg_20_1.time_ < var_23_7 + var_23_8 then
				local var_23_9 = Color.New(0, 0, 0)

				var_23_9.a = Mathf.Lerp(1, 0, (arg_20_1.time_ - var_23_7) / var_23_8)
				arg_20_1.mask_.color = var_23_9
			end

			if arg_20_1.time_ >= var_23_7 + var_23_8 and arg_20_1.time_ < var_23_7 + var_23_8 + arg_23_0 then
				local var_23_10 = Color.New(0, 0, 0)

				arg_20_1.mask_.enabled = false
				var_23_10.a = 0
				arg_20_1.mask_.color = var_23_10
			end

			if 2.299999999999 < arg_20_1.time_ and arg_20_1.time_ <= 2.299999999999 + arg_23_0 then
				local var_23_11 = arg_20_1.fswbg_.transform:Find("textbox/adapt/content") or arg_20_1.fswbg_.transform:Find("textbox/content")
				local var_23_12 = arg_20_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_23_13 = var_23_11:GetComponent("RectTransform")

				var_23_11:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleLeft
				var_23_13.offsetMin = Vector2.New(0, 0)
				var_23_13.offsetMax = Vector2.New(0, 0)
			end

			if 1.3 < arg_20_1.time_ and arg_20_1.time_ <= 1.3 + arg_23_0 then
				arg_20_1.fswbg_:SetActive(true)
				arg_20_1.dialog_:SetActive(false)

				arg_20_1.fswtw_.percent = 0
				arg_20_1.fswt_.text = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(416011005).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.fswt_)

				arg_20_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_20_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_20_1.fswtw_:SetDirty()

				arg_20_1.typewritterCharCountI18N = 0

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_14 = 2.299999999999

			if 2.299999999999 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1.var_.oldValueTypewriter = arg_20_1.fswtw_.percent

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_15 = 30
			local var_23_16 = 2
			local var_23_17, var_23_18 = arg_20_1:GetPercentByPara(arg_20_1:FormatText(arg_20_1:GetWordFromCfg(416011005).content), 2)

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				local var_23_19 = var_23_15 <= 0 and var_23_16 or var_23_16 * ((var_23_18 - arg_20_1.typewritterCharCountI18N) / var_23_15)

				if (var_23_15 <= 0 and var_23_16 or var_23_16 * ((var_23_18 - arg_20_1.typewritterCharCountI18N) / var_23_15)) > 0 and var_23_16 < var_23_19 then
					arg_20_1.talkMaxDuration = var_23_19

					if var_23_19 + var_23_14 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_19 + var_23_14
					end
				end
			end

			local var_23_20 = math.max(2, arg_20_1.talkMaxDuration)

			if var_23_14 <= arg_20_1.time_ and arg_20_1.time_ < var_23_14 + var_23_20 then
				arg_20_1.fswtw_.percent = Mathf.Lerp(arg_20_1.var_.oldValueTypewriter, var_23_17, (arg_20_1.time_ - var_23_14) / var_23_20)
				arg_20_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_20_1.fswtw_:SetDirty()
			end

			if arg_20_1.time_ >= var_23_14 + var_23_20 and arg_20_1.time_ < var_23_14 + var_23_20 + arg_23_0 then
				arg_20_1.fswtw_.percent = var_23_17

				arg_20_1.fswtw_:SetDirty()
				arg_20_1:ShowNextGo(true)

				arg_20_1.typewritterCharCountI18N = var_23_18
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play416011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 416011006
		arg_24_1.duration_ = 8.77

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play416011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.bgs_.I13g == nil then
				local var_27_0 = Object.Instantiate(arg_24_1.paintGo_)

				var_27_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I13g")
				var_27_0.name = "I13g"
				var_27_0.transform.parent = arg_24_1.stage_.transform
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.bgs_.I13g = var_27_0
			end

			if 1.96666666666667 < arg_24_1.time_ and arg_24_1.time_ <= 1.96666666666667 + arg_27_0 then
				local var_27_1 = arg_24_1.bgs_.I13g

				arg_24_1.bgs_.I13g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_27_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_2 = var_27_1:GetComponent("SpriteRenderer")

				if var_27_2 and var_27_2.sprite then
					local var_27_3 = 2 * (var_27_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_27_1.transform.localScale = Vector3.New(var_27_3 / var_27_2.sprite.bounds.size.y < var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x and var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x or var_27_3 / var_27_2.sprite.bounds.size.y, var_27_3 / var_27_2.sprite.bounds.size.y < var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x and var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x or var_27_3 / var_27_2.sprite.bounds.size.y, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "I13g" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_4 = 0

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_5 = 1.96666666666667

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_5 then
				local var_27_6 = Color.New(0, 0, 0)

				var_27_6.a = Mathf.Lerp(0, 1, (arg_24_1.time_ - var_27_4) / var_27_5)
				arg_24_1.mask_.color = var_27_6
			end

			if arg_24_1.time_ >= var_27_4 + var_27_5 and arg_24_1.time_ < var_27_4 + var_27_5 + arg_27_0 then
				local var_27_7 = Color.New(0, 0, 0)

				var_27_7.a = 1
				arg_24_1.mask_.color = var_27_7
			end

			local var_27_8 = 1.96666666666667

			if 1.96666666666667 < arg_24_1.time_ and arg_24_1.time_ <= var_27_8 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_9 = 1.8

			if var_27_8 <= arg_24_1.time_ and arg_24_1.time_ < var_27_8 + var_27_9 then
				local var_27_10 = Color.New(0, 0, 0)

				var_27_10.a = Mathf.Lerp(1, 0, (arg_24_1.time_ - var_27_8) / var_27_9)
				arg_24_1.mask_.color = var_27_10
			end

			if arg_24_1.time_ >= var_27_8 + var_27_9 and arg_24_1.time_ < var_27_8 + var_27_9 + arg_27_0 then
				local var_27_11 = Color.New(0, 0, 0)

				arg_24_1.mask_.enabled = false
				var_27_11.a = 0
				arg_24_1.mask_.color = var_27_11
			end

			if 1.96666666666667 < arg_24_1.time_ and arg_24_1.time_ <= 1.96666666666667 + arg_27_0 then
				arg_24_1.fswbg_:SetActive(false)
				arg_24_1.dialog_:SetActive(false)
				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_24_1:ShowNextGo(false)
			end

			if 1.98333333333333 < arg_24_1.time_ and arg_24_1.time_ <= 1.98333333333333 + arg_27_0 then
				arg_24_1.fswbg_:SetActive(false)
				arg_24_1.dialog_:SetActive(false)
				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_24_1:ShowNextGo(false)
			end

			if 1.83333333333333 < arg_24_1.time_ and arg_24_1.time_ <= 1.83333333333333 + arg_27_0 then
				arg_24_1:AudioAction("play", "effect", "se_story_side_1080", "se_story_1080_door", "")
			end

			if 1.83333333333333 < arg_24_1.time_ and arg_24_1.time_ <= 1.83333333333333 + arg_27_0 then
				arg_24_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 1.36666666666667 < arg_24_1.time_ and arg_24_1.time_ <= 1.36666666666667 + arg_27_0 then
				arg_24_1:AudioAction("play", "music", "bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1.awb")

				local var_27_16 = manager.audio:GetAudioName("bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1")

				if "" ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_16 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_16

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_16
						arg_24_1.bgmTxt2_.text = var_27_16
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_17 = 3.76666666666667
			local var_27_18 = 1.95

			if 3.76666666666667 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_19 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_19:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_24_1.dialogCg_.alpha = arg_29_0
				end))
				var_27_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_20 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(416011006).content)

				arg_24_1.text_.text = var_27_20

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_22 = 78 <= 0 and var_27_18 or var_27_18 * (utf8.len(var_27_20) / 78)

				if (78 <= 0 and var_27_18 or var_27_18 * (utf8.len(var_27_20) / 78)) > 0 and var_27_18 < var_27_22 then
					arg_24_1.talkMaxDuration = var_27_22
					var_27_17 = var_27_17 + 0.3

					if var_27_22 + var_27_17 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_22 + var_27_17
					end
				end

				arg_24_1.text_.text = var_27_20
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_23 = var_27_17 + 0.3
			local var_27_24 = math.max(var_27_18, arg_24_1.talkMaxDuration)

			if var_27_17 + 0.3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_23 + var_27_24 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_23) / var_27_24

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_23 + var_27_24 and arg_24_1.time_ < var_27_23 + var_27_24 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play416011007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 416011007
		arg_31_1.duration_ = 8.67

		local var_31_0 = {
			zh = 6.933,
			ja = 8.666
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play416011008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if arg_31_1.actors_["1086"] == nil then
				local var_34_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_34_0) then
					local var_34_1 = Object.Instantiate(var_34_0, arg_31_1.canvasGo_.transform)

					var_34_1.transform:SetSiblingIndex(1)

					var_34_1.name = "1086"
					var_34_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_31_1.actors_["1086"] = var_34_1

					if arg_31_1.isInRecall_ then
						for iter_34_0, iter_34_1 in ipairs((var_34_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_34_1.color = arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_34_2 = arg_31_1.actors_["1086"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1086 = var_34_2.localPosition
				var_34_2.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("1086", 3)

				for iter_34_2 = 0, var_34_2.childCount - 1 do
					local var_34_3 = var_34_2:GetChild(iter_34_2)

					if var_34_3.name == "split_1" or not string.find(var_34_3.name, "split") then
						var_34_3.gameObject:SetActive(true)
					else
						var_34_3.gameObject:SetActive(false)
					end
				end
			end

			local var_34_4 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				var_34_2.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_31_1.time_ - 0) / var_34_4)
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				var_34_2.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_34_5 = arg_31_1.actors_["1086"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.actorSpriteComps1086 == nil then
				arg_31_1.var_.actorSpriteComps1086 = var_34_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_6 = 0.125

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_6 and not isNil(var_34_5) then
				if arg_31_1.var_.actorSpriteComps1086 then
					for iter_34_3, iter_34_4 in pairs(arg_31_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_34_4 then
							if arg_31_1.isInRecall_ then
								iter_34_4.color = Color.New(Mathf.Lerp(iter_34_4.color.r, arg_31_1.hightColor1.r, (arg_31_1.time_ - 0) / var_34_6), Mathf.Lerp(iter_34_4.color.g, arg_31_1.hightColor1.g, (arg_31_1.time_ - 0) / var_34_6), (Mathf.Lerp(iter_34_4.color.b, arg_31_1.hightColor1.b, (arg_31_1.time_ - 0) / var_34_6)))
							else
								local var_34_7 = Mathf.Lerp(iter_34_4.color.r, 1, (arg_31_1.time_ - 0) / var_34_6)

								iter_34_4.color = Color.New(var_34_7, var_34_7, var_34_7)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_6 and arg_31_1.time_ < 0 + var_34_6 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.actorSpriteComps1086 then
				for iter_34_5, iter_34_6 in pairs(arg_31_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_34_6 then
						iter_34_6.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_31_1.var_.actorSpriteComps1086 = nil
			end

			local var_34_8 = 0
			local var_34_9 = 0.725

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_10 = arg_31_1:GetWordFromCfg(416011007)
				local var_34_11 = arg_31_1:FormatText(var_34_10.content)

				arg_31_1.text_.text = var_34_11

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_13 = 29 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 29)

				if (29 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 29)) > 0 and var_34_9 < var_34_13 then
					arg_31_1.talkMaxDuration = var_34_13

					if var_34_13 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_13 + var_34_8
					end
				end

				arg_31_1.text_.text = var_34_11
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011007", "story_v_out_416011.awb") ~= 0 then
					local var_34_14 = manager.audio:GetVoiceLength("story_v_out_416011", "416011007", "story_v_out_416011.awb") / 1000

					if var_34_14 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_14 + var_34_8
					end

					if var_34_10.prefab_name ~= "" and arg_31_1.actors_[var_34_10.prefab_name] ~= nil then
						local var_34_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_10.prefab_name].transform, "story_v_out_416011", "416011007", "story_v_out_416011.awb")

						arg_31_1:RecordAudio("416011007", var_34_15)
						arg_31_1:RecordAudio("416011007", var_34_15)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_416011", "416011007", "story_v_out_416011.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_416011", "416011007", "story_v_out_416011.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_16 = math.max(var_34_9, arg_31_1.talkMaxDuration)

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_16 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_8) / var_34_16

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_8 + var_34_16 and arg_31_1.time_ < var_34_8 + var_34_16 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play416011008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 416011008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play416011009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1086"]) and arg_35_1.var_.actorSpriteComps1086 == nil then
				arg_35_1.var_.actorSpriteComps1086 = arg_35_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_0 = 0.125

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1086"]) then
				if arg_35_1.var_.actorSpriteComps1086 then
					for iter_38_0, iter_38_1 in pairs(arg_35_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_38_1 then
							if arg_35_1.isInRecall_ then
								iter_38_1.color = Color.New(Mathf.Lerp(iter_38_1.color.r, arg_35_1.hightColor2.r, (arg_35_1.time_ - 0) / var_38_0), Mathf.Lerp(iter_38_1.color.g, arg_35_1.hightColor2.g, (arg_35_1.time_ - 0) / var_38_0), (Mathf.Lerp(iter_38_1.color.b, arg_35_1.hightColor2.b, (arg_35_1.time_ - 0) / var_38_0)))
							else
								local var_38_1 = Mathf.Lerp(iter_38_1.color.r, 0.5, (arg_35_1.time_ - 0) / var_38_0)

								iter_38_1.color = Color.New(var_38_1, var_38_1, var_38_1)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1086"]) and arg_35_1.var_.actorSpriteComps1086 then
				for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_38_3 then
						iter_38_3.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_35_1.var_.actorSpriteComps1086 = nil
			end

			local var_38_2 = 0
			local var_38_3 = 1.75

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_4 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(416011008).content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_6 = 70 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_4) / 70)

				if (70 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_4) / 70)) > 0 and var_38_3 < var_38_6 then
					arg_35_1.talkMaxDuration = var_38_6

					if var_38_6 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_2
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_3, arg_35_1.talkMaxDuration)

			if var_38_2 <= arg_35_1.time_ and arg_35_1.time_ < var_38_2 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_2) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_2 + var_38_7 and arg_35_1.time_ < var_38_2 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play416011009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 416011009
		arg_39_1.duration_ = 8.83

		local var_39_0 = {
			zh = 5.8,
			ja = 8.833
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play416011010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1086"]) and arg_39_1.var_.actorSpriteComps1086 == nil then
				arg_39_1.var_.actorSpriteComps1086 = arg_39_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_0 = 0.125

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1086"]) then
				if arg_39_1.var_.actorSpriteComps1086 then
					for iter_42_0, iter_42_1 in pairs(arg_39_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_42_1 then
							if arg_39_1.isInRecall_ then
								iter_42_1.color = Color.New(Mathf.Lerp(iter_42_1.color.r, arg_39_1.hightColor1.r, (arg_39_1.time_ - 0) / var_42_0), Mathf.Lerp(iter_42_1.color.g, arg_39_1.hightColor1.g, (arg_39_1.time_ - 0) / var_42_0), (Mathf.Lerp(iter_42_1.color.b, arg_39_1.hightColor1.b, (arg_39_1.time_ - 0) / var_42_0)))
							else
								local var_42_1 = Mathf.Lerp(iter_42_1.color.r, 1, (arg_39_1.time_ - 0) / var_42_0)

								iter_42_1.color = Color.New(var_42_1, var_42_1, var_42_1)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1086"]) and arg_39_1.var_.actorSpriteComps1086 then
				for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_42_3 then
						iter_42_3.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_39_1.var_.actorSpriteComps1086 = nil
			end

			local var_42_2 = arg_39_1.actors_["1086"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1086 = var_42_2.localPosition
				var_42_2.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("1086", 3)

				for iter_42_4 = 0, var_42_2.childCount - 1 do
					local var_42_3 = var_42_2:GetChild(iter_42_4)

					if var_42_3.name == "split_2" or not string.find(var_42_3.name, "split") then
						var_42_3.gameObject:SetActive(true)
					else
						var_42_3.gameObject:SetActive(false)
					end
				end
			end

			local var_42_4 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				var_42_2.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_39_1.time_ - 0) / var_42_4)
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				var_42_2.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_42_5 = 0
			local var_42_6 = 0.65

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_7 = arg_39_1:GetWordFromCfg(416011009)
				local var_42_8 = arg_39_1:FormatText(var_42_7.content)

				arg_39_1.text_.text = var_42_8

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_10 = 26 <= 0 and var_42_6 or var_42_6 * (utf8.len(var_42_8) / 26)

				if (26 <= 0 and var_42_6 or var_42_6 * (utf8.len(var_42_8) / 26)) > 0 and var_42_6 < var_42_10 then
					arg_39_1.talkMaxDuration = var_42_10

					if var_42_10 + var_42_5 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_5
					end
				end

				arg_39_1.text_.text = var_42_8
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011009", "story_v_out_416011.awb") ~= 0 then
					local var_42_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011009", "story_v_out_416011.awb") / 1000

					if var_42_11 + var_42_5 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_11 + var_42_5
					end

					if var_42_7.prefab_name ~= "" and arg_39_1.actors_[var_42_7.prefab_name] ~= nil then
						local var_42_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_7.prefab_name].transform, "story_v_out_416011", "416011009", "story_v_out_416011.awb")

						arg_39_1:RecordAudio("416011009", var_42_12)
						arg_39_1:RecordAudio("416011009", var_42_12)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_416011", "416011009", "story_v_out_416011.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_416011", "416011009", "story_v_out_416011.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_13 = math.max(var_42_6, arg_39_1.talkMaxDuration)

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_13 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_5) / var_42_13

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_5 + var_42_13 and arg_39_1.time_ < var_42_5 + var_42_13 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play416011010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 416011010
		arg_43_1.duration_ = 2.37

		local var_43_0 = {
			zh = 1.1,
			ja = 2.366
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
				arg_43_0:Play416011011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.actors_["10120"] == nil then
				local var_46_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10120")

				if not isNil(var_46_0) then
					local var_46_1 = Object.Instantiate(var_46_0, arg_43_1.canvasGo_.transform)

					var_46_1.transform:SetSiblingIndex(1)

					var_46_1.name = "10120"
					var_46_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_43_1.actors_["10120"] = var_46_1

					if arg_43_1.isInRecall_ then
						for iter_46_0, iter_46_1 in ipairs((var_46_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_46_1.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_46_2 = arg_43_1.actors_["10120"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10120 = var_46_2.localPosition
				var_46_2.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10120", 4)

				for iter_46_2 = 0, var_46_2.childCount - 1 do
					local var_46_3 = var_46_2:GetChild(iter_46_2)

					if var_46_3.name == "" or not string.find(var_46_3.name, "split") then
						var_46_3.gameObject:SetActive(true)
					else
						var_46_3.gameObject:SetActive(false)
					end
				end
			end

			local var_46_4 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				var_46_2.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10120, Vector3.New(390, -260.5, -275), (arg_43_1.time_ - 0) / var_46_4)
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				var_46_2.localPosition = Vector3.New(390, -260.5, -275)
			end

			local var_46_5 = arg_43_1.actors_["10120"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.actorSpriteComps10120 == nil then
				arg_43_1.var_.actorSpriteComps10120 = var_46_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_6 = 0.125

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_6 and not isNil(var_46_5) then
				if arg_43_1.var_.actorSpriteComps10120 then
					for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_46_4 then
							if arg_43_1.isInRecall_ then
								iter_46_4.color = Color.New(Mathf.Lerp(iter_46_4.color.r, arg_43_1.hightColor1.r, (arg_43_1.time_ - 0) / var_46_6), Mathf.Lerp(iter_46_4.color.g, arg_43_1.hightColor1.g, (arg_43_1.time_ - 0) / var_46_6), (Mathf.Lerp(iter_46_4.color.b, arg_43_1.hightColor1.b, (arg_43_1.time_ - 0) / var_46_6)))
							else
								local var_46_7 = Mathf.Lerp(iter_46_4.color.r, 1, (arg_43_1.time_ - 0) / var_46_6)

								iter_46_4.color = Color.New(var_46_7, var_46_7, var_46_7)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_6 and arg_43_1.time_ < 0 + var_46_6 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.actorSpriteComps10120 then
				for iter_46_5, iter_46_6 in pairs(arg_43_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_46_6 then
						iter_46_6.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_43_1.var_.actorSpriteComps10120 = nil
			end

			local var_46_8 = arg_43_1.actors_["1086"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1086 = var_46_8.localPosition
				var_46_8.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1086", 2)

				for iter_46_7 = 0, var_46_8.childCount - 1 do
					local var_46_9 = var_46_8:GetChild(iter_46_7)

					if var_46_9.name == "split_2" or not string.find(var_46_9.name, "split") then
						var_46_9.gameObject:SetActive(true)
					else
						var_46_9.gameObject:SetActive(false)
					end
				end
			end

			local var_46_10 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_10 then
				var_46_8.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_43_1.time_ - 0) / var_46_10)
			end

			if arg_43_1.time_ >= 0 + var_46_10 and arg_43_1.time_ < 0 + var_46_10 + arg_46_0 then
				var_46_8.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_46_11 = arg_43_1.actors_["1086"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_11) and arg_43_1.var_.actorSpriteComps1086 == nil then
				arg_43_1.var_.actorSpriteComps1086 = var_46_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_12 = 0.125

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_12 and not isNil(var_46_11) then
				if arg_43_1.var_.actorSpriteComps1086 then
					for iter_46_8, iter_46_9 in pairs(arg_43_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_46_9 then
							if arg_43_1.isInRecall_ then
								iter_46_9.color = Color.New(Mathf.Lerp(iter_46_9.color.r, arg_43_1.hightColor2.r, (arg_43_1.time_ - 0) / var_46_12), Mathf.Lerp(iter_46_9.color.g, arg_43_1.hightColor2.g, (arg_43_1.time_ - 0) / var_46_12), (Mathf.Lerp(iter_46_9.color.b, arg_43_1.hightColor2.b, (arg_43_1.time_ - 0) / var_46_12)))
							else
								local var_46_13 = Mathf.Lerp(iter_46_9.color.r, 0.5, (arg_43_1.time_ - 0) / var_46_12)

								iter_46_9.color = Color.New(var_46_13, var_46_13, var_46_13)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_12 and arg_43_1.time_ < 0 + var_46_12 + arg_46_0 and not isNil(var_46_11) and arg_43_1.var_.actorSpriteComps1086 then
				for iter_46_10, iter_46_11 in pairs(arg_43_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_46_11 then
						iter_46_11.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_43_1.var_.actorSpriteComps1086 = nil
			end

			local var_46_14 = 0
			local var_46_15 = 0.125

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_14 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[646].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_16 = arg_43_1:GetWordFromCfg(416011010)
				local var_46_17 = arg_43_1:FormatText(var_46_16.content)

				arg_43_1.text_.text = var_46_17

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_19 = 5 <= 0 and var_46_15 or var_46_15 * (utf8.len(var_46_17) / 5)

				if (5 <= 0 and var_46_15 or var_46_15 * (utf8.len(var_46_17) / 5)) > 0 and var_46_15 < var_46_19 then
					arg_43_1.talkMaxDuration = var_46_19

					if var_46_19 + var_46_14 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_19 + var_46_14
					end
				end

				arg_43_1.text_.text = var_46_17
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011010", "story_v_out_416011.awb") ~= 0 then
					local var_46_20 = manager.audio:GetVoiceLength("story_v_out_416011", "416011010", "story_v_out_416011.awb") / 1000

					if var_46_20 + var_46_14 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_20 + var_46_14
					end

					if var_46_16.prefab_name ~= "" and arg_43_1.actors_[var_46_16.prefab_name] ~= nil then
						local var_46_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_16.prefab_name].transform, "story_v_out_416011", "416011010", "story_v_out_416011.awb")

						arg_43_1:RecordAudio("416011010", var_46_21)
						arg_43_1:RecordAudio("416011010", var_46_21)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_416011", "416011010", "story_v_out_416011.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_416011", "416011010", "story_v_out_416011.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_22 = math.max(var_46_15, arg_43_1.talkMaxDuration)

			if var_46_14 <= arg_43_1.time_ and arg_43_1.time_ < var_46_14 + var_46_22 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_14) / var_46_22

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_14 + var_46_22 and arg_43_1.time_ < var_46_14 + var_46_22 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10120",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play416011011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 416011011
		arg_47_1.duration_ = 3.73

		local var_47_0 = {
			zh = 2.466,
			ja = 3.733
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
				arg_47_0:Play416011012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["10120"]) and arg_47_1.var_.actorSpriteComps10120 == nil then
				arg_47_1.var_.actorSpriteComps10120 = arg_47_1.actors_["10120"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_0 = 0.125

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["10120"]) then
				if arg_47_1.var_.actorSpriteComps10120 then
					for iter_50_0, iter_50_1 in pairs(arg_47_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_50_1 then
							if arg_47_1.isInRecall_ then
								iter_50_1.color = Color.New(Mathf.Lerp(iter_50_1.color.r, arg_47_1.hightColor2.r, (arg_47_1.time_ - 0) / var_50_0), Mathf.Lerp(iter_50_1.color.g, arg_47_1.hightColor2.g, (arg_47_1.time_ - 0) / var_50_0), (Mathf.Lerp(iter_50_1.color.b, arg_47_1.hightColor2.b, (arg_47_1.time_ - 0) / var_50_0)))
							else
								local var_50_1 = Mathf.Lerp(iter_50_1.color.r, 0.5, (arg_47_1.time_ - 0) / var_50_0)

								iter_50_1.color = Color.New(var_50_1, var_50_1, var_50_1)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["10120"]) and arg_47_1.var_.actorSpriteComps10120 then
				for iter_50_2, iter_50_3 in pairs(arg_47_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_50_3 then
						iter_50_3.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_47_1.var_.actorSpriteComps10120 = nil
			end

			local var_50_2 = arg_47_1.actors_["1086"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps1086 == nil then
				arg_47_1.var_.actorSpriteComps1086 = var_50_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_3 = 0.125

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.actorSpriteComps1086 then
					for iter_50_4, iter_50_5 in pairs(arg_47_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_50_5 then
							if arg_47_1.isInRecall_ then
								iter_50_5.color = Color.New(Mathf.Lerp(iter_50_5.color.r, arg_47_1.hightColor1.r, (arg_47_1.time_ - 0) / var_50_3), Mathf.Lerp(iter_50_5.color.g, arg_47_1.hightColor1.g, (arg_47_1.time_ - 0) / var_50_3), (Mathf.Lerp(iter_50_5.color.b, arg_47_1.hightColor1.b, (arg_47_1.time_ - 0) / var_50_3)))
							else
								local var_50_4 = Mathf.Lerp(iter_50_5.color.r, 1, (arg_47_1.time_ - 0) / var_50_3)

								iter_50_5.color = Color.New(var_50_4, var_50_4, var_50_4)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps1086 then
				for iter_50_6, iter_50_7 in pairs(arg_47_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_50_7 then
						iter_50_7.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_47_1.var_.actorSpriteComps1086 = nil
			end

			local var_50_5 = arg_47_1.actors_["1086"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1086 = var_50_5.localPosition
				var_50_5.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("1086", 2)

				for iter_50_8 = 0, var_50_5.childCount - 1 do
					local var_50_6 = var_50_5:GetChild(iter_50_8)

					if var_50_6.name == "split_1" or not string.find(var_50_6.name, "split") then
						var_50_6.gameObject:SetActive(true)
					else
						var_50_6.gameObject:SetActive(false)
					end
				end
			end

			local var_50_7 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				var_50_5.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_47_1.time_ - 0) / var_50_7)
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				var_50_5.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_50_8 = 0
			local var_50_9 = 0.25

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:GetWordFromCfg(416011011)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 10 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 10)

				if (10 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 10)) > 0 and var_50_9 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011011", "story_v_out_416011.awb") ~= 0 then
					local var_50_14 = manager.audio:GetVoiceLength("story_v_out_416011", "416011011", "story_v_out_416011.awb") / 1000

					if var_50_14 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_8
					end

					if var_50_10.prefab_name ~= "" and arg_47_1.actors_[var_50_10.prefab_name] ~= nil then
						local var_50_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_10.prefab_name].transform, "story_v_out_416011", "416011011", "story_v_out_416011.awb")

						arg_47_1:RecordAudio("416011011", var_50_15)
						arg_47_1:RecordAudio("416011011", var_50_15)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_416011", "416011011", "story_v_out_416011.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_416011", "416011011", "story_v_out_416011.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_16 and arg_47_1.time_ < var_50_8 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play416011012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 416011012
		arg_51_1.duration_ = 9.97

		local var_51_0 = {
			zh = 5.933,
			ja = 9.966
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
				arg_51_0:Play416011013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["10120"]) and arg_51_1.var_.actorSpriteComps10120 == nil then
				arg_51_1.var_.actorSpriteComps10120 = arg_51_1.actors_["10120"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_0 = 0.125

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["10120"]) then
				if arg_51_1.var_.actorSpriteComps10120 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_54_1 then
							if arg_51_1.isInRecall_ then
								iter_54_1.color = Color.New(Mathf.Lerp(iter_54_1.color.r, arg_51_1.hightColor1.r, (arg_51_1.time_ - 0) / var_54_0), Mathf.Lerp(iter_54_1.color.g, arg_51_1.hightColor1.g, (arg_51_1.time_ - 0) / var_54_0), (Mathf.Lerp(iter_54_1.color.b, arg_51_1.hightColor1.b, (arg_51_1.time_ - 0) / var_54_0)))
							else
								local var_54_1 = Mathf.Lerp(iter_54_1.color.r, 1, (arg_51_1.time_ - 0) / var_54_0)

								iter_54_1.color = Color.New(var_54_1, var_54_1, var_54_1)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["10120"]) and arg_51_1.var_.actorSpriteComps10120 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_54_3 then
						iter_54_3.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_51_1.var_.actorSpriteComps10120 = nil
			end

			local var_54_2 = arg_51_1.actors_["1086"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps1086 == nil then
				arg_51_1.var_.actorSpriteComps1086 = var_54_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_3 = 0.125

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.actorSpriteComps1086 then
					for iter_54_4, iter_54_5 in pairs(arg_51_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_54_5 then
							if arg_51_1.isInRecall_ then
								iter_54_5.color = Color.New(Mathf.Lerp(iter_54_5.color.r, arg_51_1.hightColor2.r, (arg_51_1.time_ - 0) / var_54_3), Mathf.Lerp(iter_54_5.color.g, arg_51_1.hightColor2.g, (arg_51_1.time_ - 0) / var_54_3), (Mathf.Lerp(iter_54_5.color.b, arg_51_1.hightColor2.b, (arg_51_1.time_ - 0) / var_54_3)))
							else
								local var_54_4 = Mathf.Lerp(iter_54_5.color.r, 0.5, (arg_51_1.time_ - 0) / var_54_3)

								iter_54_5.color = Color.New(var_54_4, var_54_4, var_54_4)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps1086 then
				for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_54_7 then
						iter_54_7.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps1086 = nil
			end

			local var_54_5 = 0
			local var_54_6 = 0.9

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[646].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_7 = arg_51_1:GetWordFromCfg(416011012)
				local var_54_8 = arg_51_1:FormatText(var_54_7.content)

				arg_51_1.text_.text = var_54_8

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_10 = 36 <= 0 and var_54_6 or var_54_6 * (utf8.len(var_54_8) / 36)

				if (36 <= 0 and var_54_6 or var_54_6 * (utf8.len(var_54_8) / 36)) > 0 and var_54_6 < var_54_10 then
					arg_51_1.talkMaxDuration = var_54_10

					if var_54_10 + var_54_5 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_5
					end
				end

				arg_51_1.text_.text = var_54_8
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011012", "story_v_out_416011.awb") ~= 0 then
					local var_54_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011012", "story_v_out_416011.awb") / 1000

					if var_54_11 + var_54_5 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_11 + var_54_5
					end

					if var_54_7.prefab_name ~= "" and arg_51_1.actors_[var_54_7.prefab_name] ~= nil then
						local var_54_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_7.prefab_name].transform, "story_v_out_416011", "416011012", "story_v_out_416011.awb")

						arg_51_1:RecordAudio("416011012", var_54_12)
						arg_51_1:RecordAudio("416011012", var_54_12)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_416011", "416011012", "story_v_out_416011.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_416011", "416011012", "story_v_out_416011.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_13 = math.max(var_54_6, arg_51_1.talkMaxDuration)

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_13 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_5) / var_54_13

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_5 + var_54_13 and arg_51_1.time_ < var_54_5 + var_54_13 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play416011013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 416011013
		arg_55_1.duration_ = 10.1

		local var_55_0 = {
			zh = 6.566,
			ja = 10.1
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
				arg_55_0:Play416011014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.9

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[646].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:GetWordFromCfg(416011013)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 36 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 36)

				if (36 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 36)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011013", "story_v_out_416011.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_416011", "416011013", "story_v_out_416011.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_416011", "416011013", "story_v_out_416011.awb")

						arg_55_1:RecordAudio("416011013", var_58_6)
						arg_55_1:RecordAudio("416011013", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_416011", "416011013", "story_v_out_416011.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_416011", "416011013", "story_v_out_416011.awb")
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
	Play416011014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 416011014
		arg_59_1.duration_ = 13.37

		local var_59_0 = {
			zh = 8.666,
			ja = 13.366
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
				arg_59_0:Play416011015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1086"]) and arg_59_1.var_.actorSpriteComps1086 == nil then
				arg_59_1.var_.actorSpriteComps1086 = arg_59_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_0 = 0.125

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1086"]) then
				if arg_59_1.var_.actorSpriteComps1086 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								iter_62_1.color = Color.New(Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor1.r, (arg_59_1.time_ - 0) / var_62_0), Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor1.g, (arg_59_1.time_ - 0) / var_62_0), (Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor1.b, (arg_59_1.time_ - 0) / var_62_0)))
							else
								local var_62_1 = Mathf.Lerp(iter_62_1.color.r, 1, (arg_59_1.time_ - 0) / var_62_0)

								iter_62_1.color = Color.New(var_62_1, var_62_1, var_62_1)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1086"]) and arg_59_1.var_.actorSpriteComps1086 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_62_3 then
						iter_62_3.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_59_1.var_.actorSpriteComps1086 = nil
			end

			local var_62_2 = arg_59_1.actors_["10120"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.actorSpriteComps10120 == nil then
				arg_59_1.var_.actorSpriteComps10120 = var_62_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_3 = 0.125

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_3 and not isNil(var_62_2) then
				if arg_59_1.var_.actorSpriteComps10120 then
					for iter_62_4, iter_62_5 in pairs(arg_59_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_62_5 then
							if arg_59_1.isInRecall_ then
								iter_62_5.color = Color.New(Mathf.Lerp(iter_62_5.color.r, arg_59_1.hightColor2.r, (arg_59_1.time_ - 0) / var_62_3), Mathf.Lerp(iter_62_5.color.g, arg_59_1.hightColor2.g, (arg_59_1.time_ - 0) / var_62_3), (Mathf.Lerp(iter_62_5.color.b, arg_59_1.hightColor2.b, (arg_59_1.time_ - 0) / var_62_3)))
							else
								local var_62_4 = Mathf.Lerp(iter_62_5.color.r, 0.5, (arg_59_1.time_ - 0) / var_62_3)

								iter_62_5.color = Color.New(var_62_4, var_62_4, var_62_4)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_3 and arg_59_1.time_ < 0 + var_62_3 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.actorSpriteComps10120 then
				for iter_62_6, iter_62_7 in pairs(arg_59_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_62_7 then
						iter_62_7.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_59_1.var_.actorSpriteComps10120 = nil
			end

			local var_62_5 = arg_59_1.actors_["1086"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1086 = var_62_5.localPosition
				var_62_5.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("1086", 2)

				for iter_62_8 = 0, var_62_5.childCount - 1 do
					local var_62_6 = var_62_5:GetChild(iter_62_8)

					if var_62_6.name == "split_1" or not string.find(var_62_6.name, "split") then
						var_62_6.gameObject:SetActive(true)
					else
						var_62_6.gameObject:SetActive(false)
					end
				end
			end

			local var_62_7 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				var_62_5.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_59_1.time_ - 0) / var_62_7)
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				var_62_5.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_62_8 = 0
			local var_62_9 = 1.05

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_10 = arg_59_1:GetWordFromCfg(416011014)
				local var_62_11 = arg_59_1:FormatText(var_62_10.content)

				arg_59_1.text_.text = var_62_11

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_13 = 42 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 42)

				if (42 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 42)) > 0 and var_62_9 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_8
					end
				end

				arg_59_1.text_.text = var_62_11
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011014", "story_v_out_416011.awb") ~= 0 then
					local var_62_14 = manager.audio:GetVoiceLength("story_v_out_416011", "416011014", "story_v_out_416011.awb") / 1000

					if var_62_14 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_8
					end

					if var_62_10.prefab_name ~= "" and arg_59_1.actors_[var_62_10.prefab_name] ~= nil then
						local var_62_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_10.prefab_name].transform, "story_v_out_416011", "416011014", "story_v_out_416011.awb")

						arg_59_1:RecordAudio("416011014", var_62_15)
						arg_59_1:RecordAudio("416011014", var_62_15)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_416011", "416011014", "story_v_out_416011.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_416011", "416011014", "story_v_out_416011.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_9, arg_59_1.talkMaxDuration)

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_8) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_8 + var_62_16 and arg_59_1.time_ < var_62_8 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play416011015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 416011015
		arg_63_1.duration_ = 4.87

		local var_63_0 = {
			zh = 3.3,
			ja = 4.866
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
				arg_63_0:Play416011016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["10120"]) and arg_63_1.var_.actorSpriteComps10120 == nil then
				arg_63_1.var_.actorSpriteComps10120 = arg_63_1.actors_["10120"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_0 = 0.125

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["10120"]) then
				if arg_63_1.var_.actorSpriteComps10120 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								iter_66_1.color = Color.New(Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor1.r, (arg_63_1.time_ - 0) / var_66_0), Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor1.g, (arg_63_1.time_ - 0) / var_66_0), (Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor1.b, (arg_63_1.time_ - 0) / var_66_0)))
							else
								local var_66_1 = Mathf.Lerp(iter_66_1.color.r, 1, (arg_63_1.time_ - 0) / var_66_0)

								iter_66_1.color = Color.New(var_66_1, var_66_1, var_66_1)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["10120"]) and arg_63_1.var_.actorSpriteComps10120 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_66_3 then
						iter_66_3.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_63_1.var_.actorSpriteComps10120 = nil
			end

			local var_66_2 = arg_63_1.actors_["1086"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps1086 == nil then
				arg_63_1.var_.actorSpriteComps1086 = var_66_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_3 = 0.125

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.actorSpriteComps1086 then
					for iter_66_4, iter_66_5 in pairs(arg_63_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_66_5 then
							if arg_63_1.isInRecall_ then
								iter_66_5.color = Color.New(Mathf.Lerp(iter_66_5.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 0) / var_66_3), Mathf.Lerp(iter_66_5.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 0) / var_66_3), (Mathf.Lerp(iter_66_5.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 0) / var_66_3)))
							else
								local var_66_4 = Mathf.Lerp(iter_66_5.color.r, 0.5, (arg_63_1.time_ - 0) / var_66_3)

								iter_66_5.color = Color.New(var_66_4, var_66_4, var_66_4)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps1086 then
				for iter_66_6, iter_66_7 in pairs(arg_63_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_66_7 then
						iter_66_7.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps1086 = nil
			end

			local var_66_5 = 0
			local var_66_6 = 0.475

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[646].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_7 = arg_63_1:GetWordFromCfg(416011015)
				local var_66_8 = arg_63_1:FormatText(var_66_7.content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 19 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 19)

				if (19 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 19)) > 0 and var_66_6 < var_66_10 then
					arg_63_1.talkMaxDuration = var_66_10

					if var_66_10 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_5
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011015", "story_v_out_416011.awb") ~= 0 then
					local var_66_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011015", "story_v_out_416011.awb") / 1000

					if var_66_11 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_5
					end

					if var_66_7.prefab_name ~= "" and arg_63_1.actors_[var_66_7.prefab_name] ~= nil then
						local var_66_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_7.prefab_name].transform, "story_v_out_416011", "416011015", "story_v_out_416011.awb")

						arg_63_1:RecordAudio("416011015", var_66_12)
						arg_63_1:RecordAudio("416011015", var_66_12)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_416011", "416011015", "story_v_out_416011.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_416011", "416011015", "story_v_out_416011.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_13 = math.max(var_66_6, arg_63_1.talkMaxDuration)

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_13 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_5) / var_66_13

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_5 + var_66_13 and arg_63_1.time_ < var_66_5 + var_66_13 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play416011016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 416011016
		arg_67_1.duration_ = 10

		local var_67_0 = {
			zh = 4.6,
			ja = 10
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
				arg_67_0:Play416011017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["10120"]) and arg_67_1.var_.actorSpriteComps10120 == nil then
				arg_67_1.var_.actorSpriteComps10120 = arg_67_1.actors_["10120"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_0 = 0.125

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["10120"]) then
				if arg_67_1.var_.actorSpriteComps10120 then
					for iter_70_0, iter_70_1 in pairs(arg_67_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_70_1 then
							if arg_67_1.isInRecall_ then
								iter_70_1.color = Color.New(Mathf.Lerp(iter_70_1.color.r, arg_67_1.hightColor2.r, (arg_67_1.time_ - 0) / var_70_0), Mathf.Lerp(iter_70_1.color.g, arg_67_1.hightColor2.g, (arg_67_1.time_ - 0) / var_70_0), (Mathf.Lerp(iter_70_1.color.b, arg_67_1.hightColor2.b, (arg_67_1.time_ - 0) / var_70_0)))
							else
								local var_70_1 = Mathf.Lerp(iter_70_1.color.r, 0.5, (arg_67_1.time_ - 0) / var_70_0)

								iter_70_1.color = Color.New(var_70_1, var_70_1, var_70_1)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["10120"]) and arg_67_1.var_.actorSpriteComps10120 then
				for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_70_3 then
						iter_70_3.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_67_1.var_.actorSpriteComps10120 = nil
			end

			local var_70_2 = arg_67_1.actors_["1086"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.actorSpriteComps1086 == nil then
				arg_67_1.var_.actorSpriteComps1086 = var_70_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_3 = 0.125

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_3 and not isNil(var_70_2) then
				if arg_67_1.var_.actorSpriteComps1086 then
					for iter_70_4, iter_70_5 in pairs(arg_67_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_70_5 then
							if arg_67_1.isInRecall_ then
								iter_70_5.color = Color.New(Mathf.Lerp(iter_70_5.color.r, arg_67_1.hightColor1.r, (arg_67_1.time_ - 0) / var_70_3), Mathf.Lerp(iter_70_5.color.g, arg_67_1.hightColor1.g, (arg_67_1.time_ - 0) / var_70_3), (Mathf.Lerp(iter_70_5.color.b, arg_67_1.hightColor1.b, (arg_67_1.time_ - 0) / var_70_3)))
							else
								local var_70_4 = Mathf.Lerp(iter_70_5.color.r, 1, (arg_67_1.time_ - 0) / var_70_3)

								iter_70_5.color = Color.New(var_70_4, var_70_4, var_70_4)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_3 and arg_67_1.time_ < 0 + var_70_3 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.actorSpriteComps1086 then
				for iter_70_6, iter_70_7 in pairs(arg_67_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_70_7 then
						iter_70_7.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_67_1.var_.actorSpriteComps1086 = nil
			end

			local var_70_5 = arg_67_1.actors_["1086"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1086 = var_70_5.localPosition
				var_70_5.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1086", 2)

				for iter_70_8 = 0, var_70_5.childCount - 1 do
					local var_70_6 = var_70_5:GetChild(iter_70_8)

					if var_70_6.name == "split_2" or not string.find(var_70_6.name, "split") then
						var_70_6.gameObject:SetActive(true)
					else
						var_70_6.gameObject:SetActive(false)
					end
				end
			end

			local var_70_7 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				var_70_5.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_67_1.time_ - 0) / var_70_7)
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				var_70_5.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_70_8 = 0
			local var_70_9 = 0.55

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_10 = arg_67_1:GetWordFromCfg(416011016)
				local var_70_11 = arg_67_1:FormatText(var_70_10.content)

				arg_67_1.text_.text = var_70_11

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_13 = 22 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_11) / 22)

				if (22 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_11) / 22)) > 0 and var_70_9 < var_70_13 then
					arg_67_1.talkMaxDuration = var_70_13

					if var_70_13 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_8
					end
				end

				arg_67_1.text_.text = var_70_11
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011016", "story_v_out_416011.awb") ~= 0 then
					local var_70_14 = manager.audio:GetVoiceLength("story_v_out_416011", "416011016", "story_v_out_416011.awb") / 1000

					if var_70_14 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_8
					end

					if var_70_10.prefab_name ~= "" and arg_67_1.actors_[var_70_10.prefab_name] ~= nil then
						local var_70_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_10.prefab_name].transform, "story_v_out_416011", "416011016", "story_v_out_416011.awb")

						arg_67_1:RecordAudio("416011016", var_70_15)
						arg_67_1:RecordAudio("416011016", var_70_15)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_416011", "416011016", "story_v_out_416011.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_416011", "416011016", "story_v_out_416011.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_9, arg_67_1.talkMaxDuration)

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_8) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_8 + var_70_16 and arg_67_1.time_ < var_70_8 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play416011017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 416011017
		arg_71_1.duration_ = 7.8

		local var_71_0 = {
			zh = 4.366,
			ja = 7.8
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
				arg_71_0:Play416011018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1086"]) and arg_71_1.var_.actorSpriteComps1086 == nil then
				arg_71_1.var_.actorSpriteComps1086 = arg_71_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_0 = 0.125

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1086"]) then
				if arg_71_1.var_.actorSpriteComps1086 then
					for iter_74_0, iter_74_1 in pairs(arg_71_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_74_1 then
							if arg_71_1.isInRecall_ then
								iter_74_1.color = Color.New(Mathf.Lerp(iter_74_1.color.r, arg_71_1.hightColor2.r, (arg_71_1.time_ - 0) / var_74_0), Mathf.Lerp(iter_74_1.color.g, arg_71_1.hightColor2.g, (arg_71_1.time_ - 0) / var_74_0), (Mathf.Lerp(iter_74_1.color.b, arg_71_1.hightColor2.b, (arg_71_1.time_ - 0) / var_74_0)))
							else
								local var_74_1 = Mathf.Lerp(iter_74_1.color.r, 0.5, (arg_71_1.time_ - 0) / var_74_0)

								iter_74_1.color = Color.New(var_74_1, var_74_1, var_74_1)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1086"]) and arg_71_1.var_.actorSpriteComps1086 then
				for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_74_3 then
						iter_74_3.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_71_1.var_.actorSpriteComps1086 = nil
			end

			local var_74_2 = arg_71_1.actors_["10120"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps10120 == nil then
				arg_71_1.var_.actorSpriteComps10120 = var_74_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_3 = 0.125

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.actorSpriteComps10120 then
					for iter_74_4, iter_74_5 in pairs(arg_71_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_74_5 then
							if arg_71_1.isInRecall_ then
								iter_74_5.color = Color.New(Mathf.Lerp(iter_74_5.color.r, arg_71_1.hightColor1.r, (arg_71_1.time_ - 0) / var_74_3), Mathf.Lerp(iter_74_5.color.g, arg_71_1.hightColor1.g, (arg_71_1.time_ - 0) / var_74_3), (Mathf.Lerp(iter_74_5.color.b, arg_71_1.hightColor1.b, (arg_71_1.time_ - 0) / var_74_3)))
							else
								local var_74_4 = Mathf.Lerp(iter_74_5.color.r, 1, (arg_71_1.time_ - 0) / var_74_3)

								iter_74_5.color = Color.New(var_74_4, var_74_4, var_74_4)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps10120 then
				for iter_74_6, iter_74_7 in pairs(arg_71_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_74_7 then
						iter_74_7.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_71_1.var_.actorSpriteComps10120 = nil
			end

			local var_74_5 = 0
			local var_74_6 = 0.55

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[646].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_7 = arg_71_1:GetWordFromCfg(416011017)
				local var_74_8 = arg_71_1:FormatText(var_74_7.content)

				arg_71_1.text_.text = var_74_8

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 22 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_8) / 22)

				if (22 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_8) / 22)) > 0 and var_74_6 < var_74_10 then
					arg_71_1.talkMaxDuration = var_74_10

					if var_74_10 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_5
					end
				end

				arg_71_1.text_.text = var_74_8
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011017", "story_v_out_416011.awb") ~= 0 then
					local var_74_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011017", "story_v_out_416011.awb") / 1000

					if var_74_11 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_5
					end

					if var_74_7.prefab_name ~= "" and arg_71_1.actors_[var_74_7.prefab_name] ~= nil then
						local var_74_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_7.prefab_name].transform, "story_v_out_416011", "416011017", "story_v_out_416011.awb")

						arg_71_1:RecordAudio("416011017", var_74_12)
						arg_71_1:RecordAudio("416011017", var_74_12)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_416011", "416011017", "story_v_out_416011.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_416011", "416011017", "story_v_out_416011.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_13 = math.max(var_74_6, arg_71_1.talkMaxDuration)

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_13 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_5) / var_74_13

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_5 + var_74_13 and arg_71_1.time_ < var_74_5 + var_74_13 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play416011018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 416011018
		arg_75_1.duration_ = 5.77

		local var_75_0 = {
			zh = 5.766,
			ja = 4.4
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
				arg_75_0:Play416011019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["10120"]) and arg_75_1.var_.actorSpriteComps10120 == nil then
				arg_75_1.var_.actorSpriteComps10120 = arg_75_1.actors_["10120"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_0 = 0.125

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["10120"]) then
				if arg_75_1.var_.actorSpriteComps10120 then
					for iter_78_0, iter_78_1 in pairs(arg_75_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_78_1 then
							if arg_75_1.isInRecall_ then
								iter_78_1.color = Color.New(Mathf.Lerp(iter_78_1.color.r, arg_75_1.hightColor2.r, (arg_75_1.time_ - 0) / var_78_0), Mathf.Lerp(iter_78_1.color.g, arg_75_1.hightColor2.g, (arg_75_1.time_ - 0) / var_78_0), (Mathf.Lerp(iter_78_1.color.b, arg_75_1.hightColor2.b, (arg_75_1.time_ - 0) / var_78_0)))
							else
								local var_78_1 = Mathf.Lerp(iter_78_1.color.r, 0.5, (arg_75_1.time_ - 0) / var_78_0)

								iter_78_1.color = Color.New(var_78_1, var_78_1, var_78_1)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["10120"]) and arg_75_1.var_.actorSpriteComps10120 then
				for iter_78_2, iter_78_3 in pairs(arg_75_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_78_3 then
						iter_78_3.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_75_1.var_.actorSpriteComps10120 = nil
			end

			local var_78_2 = arg_75_1.actors_["1086"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps1086 == nil then
				arg_75_1.var_.actorSpriteComps1086 = var_78_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_3 = 0.125

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.actorSpriteComps1086 then
					for iter_78_4, iter_78_5 in pairs(arg_75_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_78_5 then
							if arg_75_1.isInRecall_ then
								iter_78_5.color = Color.New(Mathf.Lerp(iter_78_5.color.r, arg_75_1.hightColor1.r, (arg_75_1.time_ - 0) / var_78_3), Mathf.Lerp(iter_78_5.color.g, arg_75_1.hightColor1.g, (arg_75_1.time_ - 0) / var_78_3), (Mathf.Lerp(iter_78_5.color.b, arg_75_1.hightColor1.b, (arg_75_1.time_ - 0) / var_78_3)))
							else
								local var_78_4 = Mathf.Lerp(iter_78_5.color.r, 1, (arg_75_1.time_ - 0) / var_78_3)

								iter_78_5.color = Color.New(var_78_4, var_78_4, var_78_4)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps1086 then
				for iter_78_6, iter_78_7 in pairs(arg_75_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_78_7 then
						iter_78_7.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_75_1.var_.actorSpriteComps1086 = nil
			end

			local var_78_5 = 0
			local var_78_6 = 0.6

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_7 = arg_75_1:GetWordFromCfg(416011018)
				local var_78_8 = arg_75_1:FormatText(var_78_7.content)

				arg_75_1.text_.text = var_78_8

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 24 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 24)

				if (24 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 24)) > 0 and var_78_6 < var_78_10 then
					arg_75_1.talkMaxDuration = var_78_10

					if var_78_10 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_5
					end
				end

				arg_75_1.text_.text = var_78_8
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011018", "story_v_out_416011.awb") ~= 0 then
					local var_78_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011018", "story_v_out_416011.awb") / 1000

					if var_78_11 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_11 + var_78_5
					end

					if var_78_7.prefab_name ~= "" and arg_75_1.actors_[var_78_7.prefab_name] ~= nil then
						local var_78_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_7.prefab_name].transform, "story_v_out_416011", "416011018", "story_v_out_416011.awb")

						arg_75_1:RecordAudio("416011018", var_78_12)
						arg_75_1:RecordAudio("416011018", var_78_12)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_416011", "416011018", "story_v_out_416011.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_416011", "416011018", "story_v_out_416011.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_13 = math.max(var_78_6, arg_75_1.talkMaxDuration)

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_13 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_5) / var_78_13

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_5 + var_78_13 and arg_75_1.time_ < var_78_5 + var_78_13 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play416011019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 416011019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play416011020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10120 = arg_79_1.actors_["10120"].transform.localPosition
				arg_79_1.actors_["10120"].transform.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10120", 7)

				for iter_82_0 = 0, arg_79_1.actors_["10120"].transform.childCount - 1 do
					local var_82_0 = arg_79_1.actors_["10120"].transform:GetChild(iter_82_0)

					if var_82_0.name == "" or not string.find(var_82_0.name, "split") then
						var_82_0.gameObject:SetActive(true)
					else
						var_82_0.gameObject:SetActive(false)
					end
				end
			end

			local var_82_1 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 then
				arg_79_1.actors_["10120"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10120, Vector3.New(0, -2000, 0), (arg_79_1.time_ - 0) / var_82_1)
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 then
				arg_79_1.actors_["10120"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_2 = arg_79_1.actors_["1086"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1086 = var_82_2.localPosition
				var_82_2.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1086", 7)

				for iter_82_1 = 0, var_82_2.childCount - 1 do
					local var_82_3 = var_82_2:GetChild(iter_82_1)

					if var_82_3.name == "" or not string.find(var_82_3.name, "split") then
						var_82_3.gameObject:SetActive(true)
					else
						var_82_3.gameObject:SetActive(false)
					end
				end
			end

			local var_82_4 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				var_82_2.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_79_1.time_ - 0) / var_82_4)
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				var_82_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_5 = 0
			local var_82_6 = 1.55

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_7 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(416011019).content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 62 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_7) / 62)

				if (62 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_7) / 62)) > 0 and var_82_6 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_6, arg_79_1.talkMaxDuration)

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_5) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_5 + var_82_10 and arg_79_1.time_ < var_82_5 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10120",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
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
	Play416011020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 416011020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play416011021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:AudioAction("stop", "effect", "se_story_8", "se_story_8_water02_loop", "")
			end

			local var_86_1 = 0
			local var_86_2 = 1.85

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(416011020).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 74 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 74)

				if (74 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 74)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play416011021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 416011021
		arg_87_1.duration_ = 7.03

		local var_87_0 = {
			zh = 6.533,
			ja = 7.033
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
				arg_87_0:Play416011022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1086 = arg_87_1.actors_["1086"].transform.localPosition
				arg_87_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("1086", 3)

				for iter_90_0 = 0, arg_87_1.actors_["1086"].transform.childCount - 1 do
					local var_90_0 = arg_87_1.actors_["1086"].transform:GetChild(iter_90_0)

					if var_90_0.name == "split_1" or not string.find(var_90_0.name, "split") then
						var_90_0.gameObject:SetActive(true)
					else
						var_90_0.gameObject:SetActive(false)
					end
				end
			end

			local var_90_1 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 then
				arg_87_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_87_1.time_ - 0) / var_90_1)
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 then
				arg_87_1.actors_["1086"].transform.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_90_2 = arg_87_1.actors_["1086"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps1086 == nil then
				arg_87_1.var_.actorSpriteComps1086 = var_90_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_3 = 0.125

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 and not isNil(var_90_2) then
				if arg_87_1.var_.actorSpriteComps1086 then
					for iter_90_1, iter_90_2 in pairs(arg_87_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_90_2 then
							if arg_87_1.isInRecall_ then
								iter_90_2.color = Color.New(Mathf.Lerp(iter_90_2.color.r, arg_87_1.hightColor1.r, (arg_87_1.time_ - 0) / var_90_3), Mathf.Lerp(iter_90_2.color.g, arg_87_1.hightColor1.g, (arg_87_1.time_ - 0) / var_90_3), (Mathf.Lerp(iter_90_2.color.b, arg_87_1.hightColor1.b, (arg_87_1.time_ - 0) / var_90_3)))
							else
								local var_90_4 = Mathf.Lerp(iter_90_2.color.r, 1, (arg_87_1.time_ - 0) / var_90_3)

								iter_90_2.color = Color.New(var_90_4, var_90_4, var_90_4)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps1086 then
				for iter_90_3, iter_90_4 in pairs(arg_87_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_90_4 then
						iter_90_4.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_87_1.var_.actorSpriteComps1086 = nil
			end

			local var_90_5 = 0
			local var_90_6 = 0.5

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_7 = arg_87_1:GetWordFromCfg(416011021)
				local var_90_8 = arg_87_1:FormatText(var_90_7.content)

				arg_87_1.text_.text = var_90_8

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_10 = 20 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_8) / 20)

				if (20 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_8) / 20)) > 0 and var_90_6 < var_90_10 then
					arg_87_1.talkMaxDuration = var_90_10

					if var_90_10 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_5
					end
				end

				arg_87_1.text_.text = var_90_8
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011021", "story_v_out_416011.awb") ~= 0 then
					local var_90_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011021", "story_v_out_416011.awb") / 1000

					if var_90_11 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_11 + var_90_5
					end

					if var_90_7.prefab_name ~= "" and arg_87_1.actors_[var_90_7.prefab_name] ~= nil then
						local var_90_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_7.prefab_name].transform, "story_v_out_416011", "416011021", "story_v_out_416011.awb")

						arg_87_1:RecordAudio("416011021", var_90_12)
						arg_87_1:RecordAudio("416011021", var_90_12)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_416011", "416011021", "story_v_out_416011.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_416011", "416011021", "story_v_out_416011.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_13 = math.max(var_90_6, arg_87_1.talkMaxDuration)

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_13 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_5) / var_90_13

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_5 + var_90_13 and arg_87_1.time_ < var_90_5 + var_90_13 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play416011022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 416011022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play416011023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1086 = arg_91_1.actors_["1086"].transform.localPosition
				arg_91_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("1086", 7)

				for iter_94_0 = 0, arg_91_1.actors_["1086"].transform.childCount - 1 do
					local var_94_0 = arg_91_1.actors_["1086"].transform:GetChild(iter_94_0)

					if var_94_0.name == "" or not string.find(var_94_0.name, "split") then
						var_94_0.gameObject:SetActive(true)
					else
						var_94_0.gameObject:SetActive(false)
					end
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_91_1.time_ - 0) / var_94_1)
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["1086"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_94_2 = 0
			local var_94_3 = 1.625

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

				local var_94_4 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(416011022).content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_6 = 65 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_4) / 65)

				if (65 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_4) / 65)) > 0 and var_94_3 < var_94_6 then
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

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play416011023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 416011023
		arg_95_1.duration_ = 2.73

		local var_95_0 = {
			zh = 2.233,
			ja = 2.733
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
				arg_95_0:Play416011024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10120 = arg_95_1.actors_["10120"].transform.localPosition
				arg_95_1.actors_["10120"].transform.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10120", 3)

				for iter_98_0 = 0, arg_95_1.actors_["10120"].transform.childCount - 1 do
					local var_98_0 = arg_95_1.actors_["10120"].transform:GetChild(iter_98_0)

					if var_98_0.name == "" or not string.find(var_98_0.name, "split") then
						var_98_0.gameObject:SetActive(true)
					else
						var_98_0.gameObject:SetActive(false)
					end
				end
			end

			local var_98_1 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 then
				arg_95_1.actors_["10120"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10120, Vector3.New(0, -260.5, -275), (arg_95_1.time_ - 0) / var_98_1)
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 then
				arg_95_1.actors_["10120"].transform.localPosition = Vector3.New(0, -260.5, -275)
			end

			local var_98_2 = arg_95_1.actors_["10120"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.actorSpriteComps10120 == nil then
				arg_95_1.var_.actorSpriteComps10120 = var_98_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_3 = 0.125

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_3 and not isNil(var_98_2) then
				if arg_95_1.var_.actorSpriteComps10120 then
					for iter_98_1, iter_98_2 in pairs(arg_95_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_98_2 then
							if arg_95_1.isInRecall_ then
								iter_98_2.color = Color.New(Mathf.Lerp(iter_98_2.color.r, arg_95_1.hightColor1.r, (arg_95_1.time_ - 0) / var_98_3), Mathf.Lerp(iter_98_2.color.g, arg_95_1.hightColor1.g, (arg_95_1.time_ - 0) / var_98_3), (Mathf.Lerp(iter_98_2.color.b, arg_95_1.hightColor1.b, (arg_95_1.time_ - 0) / var_98_3)))
							else
								local var_98_4 = Mathf.Lerp(iter_98_2.color.r, 1, (arg_95_1.time_ - 0) / var_98_3)

								iter_98_2.color = Color.New(var_98_4, var_98_4, var_98_4)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_3 and arg_95_1.time_ < 0 + var_98_3 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.actorSpriteComps10120 then
				for iter_98_3, iter_98_4 in pairs(arg_95_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_98_4 then
						iter_98_4.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_95_1.var_.actorSpriteComps10120 = nil
			end

			if 1.13333333333333 < arg_95_1.time_ and arg_95_1.time_ <= 1.13333333333333 + arg_98_0 then
				arg_95_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun02", "")
			end

			local var_98_6 = 0
			local var_98_7 = 0.175

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[646].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_8 = arg_95_1:GetWordFromCfg(416011023)
				local var_98_9 = arg_95_1:FormatText(var_98_8.content)

				arg_95_1.text_.text = var_98_9

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 7 <= 0 and var_98_7 or var_98_7 * (utf8.len(var_98_9) / 7)

				if (7 <= 0 and var_98_7 or var_98_7 * (utf8.len(var_98_9) / 7)) > 0 and var_98_7 < var_98_11 then
					arg_95_1.talkMaxDuration = var_98_11

					if var_98_11 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_11 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_9
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011023", "story_v_out_416011.awb") ~= 0 then
					local var_98_12 = manager.audio:GetVoiceLength("story_v_out_416011", "416011023", "story_v_out_416011.awb") / 1000

					if var_98_12 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_12 + var_98_6
					end

					if var_98_8.prefab_name ~= "" and arg_95_1.actors_[var_98_8.prefab_name] ~= nil then
						local var_98_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_8.prefab_name].transform, "story_v_out_416011", "416011023", "story_v_out_416011.awb")

						arg_95_1:RecordAudio("416011023", var_98_13)
						arg_95_1:RecordAudio("416011023", var_98_13)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_416011", "416011023", "story_v_out_416011.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_416011", "416011023", "story_v_out_416011.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_14 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_14 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_14

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_14 and arg_95_1.time_ < var_98_6 + var_98_14 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10120",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play416011024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 416011024
		arg_99_1.duration_ = 7.88

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play416011025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if arg_99_1.bgs_.ST10 == nil then
				local var_102_0 = Object.Instantiate(arg_99_1.paintGo_)

				var_102_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")
				var_102_0.name = "ST10"
				var_102_0.transform.parent = arg_99_1.stage_.transform
				var_102_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.bgs_.ST10 = var_102_0
			end

			if 0.967333333333332 < arg_99_1.time_ and arg_99_1.time_ <= 0.967333333333332 + arg_102_0 then
				local var_102_1 = arg_99_1.bgs_.ST10

				arg_99_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_102_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_2 = var_102_1:GetComponent("SpriteRenderer")

				if var_102_2 and var_102_2.sprite then
					local var_102_3 = 2 * (var_102_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_102_1.transform.localScale = Vector3.New(var_102_3 / var_102_2.sprite.bounds.size.y < var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x and var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x or var_102_3 / var_102_2.sprite.bounds.size.y, var_102_3 / var_102_2.sprite.bounds.size.y < var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x and var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x or var_102_3 / var_102_2.sprite.bounds.size.y, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "ST10" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_4 = 0

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_5 = 0.967333333333333

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_5 then
				local var_102_6 = Color.New(0, 0, 0)

				var_102_6.a = Mathf.Lerp(0, 1, (arg_99_1.time_ - var_102_4) / var_102_5)
				arg_99_1.mask_.color = var_102_6
			end

			if arg_99_1.time_ >= var_102_4 + var_102_5 and arg_99_1.time_ < var_102_4 + var_102_5 + arg_102_0 then
				local var_102_7 = Color.New(0, 0, 0)

				var_102_7.a = 1
				arg_99_1.mask_.color = var_102_7
			end

			local var_102_8 = 0.967333333333332

			if 0.967333333333332 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_9 = 1.91666666666667

			if var_102_8 <= arg_99_1.time_ and arg_99_1.time_ < var_102_8 + var_102_9 then
				local var_102_10 = Color.New(0, 0, 0)

				var_102_10.a = Mathf.Lerp(1, 0, (arg_99_1.time_ - var_102_8) / var_102_9)
				arg_99_1.mask_.color = var_102_10
			end

			if arg_99_1.time_ >= var_102_8 + var_102_9 and arg_99_1.time_ < var_102_8 + var_102_9 + arg_102_0 then
				local var_102_11 = Color.New(0, 0, 0)

				arg_99_1.mask_.enabled = false
				var_102_11.a = 0
				arg_99_1.mask_.color = var_102_11
			end

			local var_102_12 = arg_99_1.actors_["10120"].transform

			if 0.933333333333333 < arg_99_1.time_ and arg_99_1.time_ <= 0.933333333333333 + arg_102_0 then
				arg_99_1.var_.moveOldPos10120 = var_102_12.localPosition
				var_102_12.localScale = Vector3.New(1, 1, 1)

				for iter_102_2 = 0, var_102_12.childCount - 1 do
					local var_102_13 = var_102_12:GetChild(iter_102_2)

					if var_102_13.name == "" or not string.find(var_102_13.name, "split") then
						var_102_13.gameObject:SetActive(true)
					else
						var_102_13.gameObject:SetActive(false)
					end
				end
			end

			local var_102_14 = 0.001

			if 0.933333333333333 <= arg_99_1.time_ and arg_99_1.time_ < 0.933333333333333 + var_102_14 then
				var_102_12.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10120, Vector3.New(0, -2000, 0), (arg_99_1.time_ - 0.933333333333333) / var_102_14)
			end

			if arg_99_1.time_ >= 0.933333333333333 + var_102_14 and arg_99_1.time_ < 0.933333333333333 + var_102_14 + arg_102_0 then
				var_102_12.localPosition = Vector3.New(0, -2000, 0)
			end

			if 4.36666666666667 < arg_99_1.time_ and arg_99_1.time_ <= 4.36666666666667 + arg_102_0 then
				arg_99_1:AudioAction("play", "effect", "se_story_16", "se_story_16_smash02", "")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_102_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_99_1.bgmTxt_.text ~= var_102_18 and arg_99_1.bgmTxt_.text ~= "" then
						if arg_99_1.bgmTxt2_.text ~= "" then
							arg_99_1.bgmTxt_.text = arg_99_1.bgmTxt2_.text
						end

						arg_99_1.bgmTxt2_.text = var_102_18

						arg_99_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_99_1.bgmTxt_.text = var_102_18
						arg_99_1.bgmTxt2_.text = var_102_18
					end

					if arg_99_1.bgmTimer then
						arg_99_1.bgmTimer:Stop()

						arg_99_1.bgmTimer = nil
					end

					if arg_99_1.settingData.show_music_name == 1 then
						arg_99_1.musicController:SetSelectedState("show")
						arg_99_1.musicAnimator_:Play("open", 0, 0)

						if arg_99_1.settingData.music_time ~= 0 then
							arg_99_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_99_1.settingData.music_time), function()
								if arg_99_1 == nil or isNil(arg_99_1.bgmTxt_) then
									return
								end

								arg_99_1.musicController:SetSelectedState("hide")
								arg_99_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1 < arg_99_1.time_ and arg_99_1.time_ <= 1 + arg_102_0 then
				arg_99_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_102_21 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_99_1.bgmTxt_.text ~= var_102_21 and arg_99_1.bgmTxt_.text ~= "" then
						if arg_99_1.bgmTxt2_.text ~= "" then
							arg_99_1.bgmTxt_.text = arg_99_1.bgmTxt2_.text
						end

						arg_99_1.bgmTxt2_.text = var_102_21

						arg_99_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_99_1.bgmTxt_.text = var_102_21
						arg_99_1.bgmTxt2_.text = var_102_21
					end

					if arg_99_1.bgmTimer then
						arg_99_1.bgmTimer:Stop()

						arg_99_1.bgmTimer = nil
					end

					if arg_99_1.settingData.show_music_name == 1 then
						arg_99_1.musicController:SetSelectedState("show")
						arg_99_1.musicAnimator_:Play("open", 0, 0)

						if arg_99_1.settingData.music_time ~= 0 then
							arg_99_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_99_1.settingData.music_time), function()
								if arg_99_1 == nil or isNil(arg_99_1.bgmTxt_) then
									return
								end

								arg_99_1.musicController:SetSelectedState("hide")
								arg_99_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:AudioAction("stop", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:AudioAction("stop", "effect", "se_story_15", "se_story_15_gun02", "")
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_24 = 2.884
			local var_102_25 = 1.85

			if 2.884 < arg_99_1.time_ and arg_99_1.time_ <= var_102_24 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_26 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_26:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_99_1.dialogCg_.alpha = arg_105_0
				end))
				var_102_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_27 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(416011024).content)

				arg_99_1.text_.text = var_102_27

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_29 = 74 <= 0 and var_102_25 or var_102_25 * (utf8.len(var_102_27) / 74)

				if (74 <= 0 and var_102_25 or var_102_25 * (utf8.len(var_102_27) / 74)) > 0 and var_102_25 < var_102_29 then
					arg_99_1.talkMaxDuration = var_102_29
					var_102_24 = var_102_24 + 0.3

					if var_102_29 + var_102_24 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_29 + var_102_24
					end
				end

				arg_99_1.text_.text = var_102_27
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_30 = var_102_24 + 0.3
			local var_102_31 = math.max(var_102_25, arg_99_1.talkMaxDuration)

			if var_102_24 + 0.3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_30 + var_102_31 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_30) / var_102_31

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_30 + var_102_31 and arg_99_1.time_ < var_102_30 + var_102_31 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10120",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.933333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play416011025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 416011025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play416011026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 1.075

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(416011025).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 43 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 43)

				if (43 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 43)) > 0 and var_110_0 < var_110_3 then
					arg_107_1.talkMaxDuration = var_110_3

					if var_110_3 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_3 + 0
					end
				end

				arg_107_1.text_.text = var_110_1
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_4 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_4

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play416011026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416011026
		arg_111_1.duration_ = 9.97

		local var_111_0 = {
			zh = 8.1,
			ja = 9.966
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
				arg_111_0:Play416011027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if arg_111_1.actors_["1033"] == nil then
				local var_114_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_114_0) then
					local var_114_1 = Object.Instantiate(var_114_0, arg_111_1.canvasGo_.transform)

					var_114_1.transform:SetSiblingIndex(1)

					var_114_1.name = "1033"
					var_114_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_111_1.actors_["1033"] = var_114_1

					if arg_111_1.isInRecall_ then
						for iter_114_0, iter_114_1 in ipairs((var_114_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_114_1.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_114_2 = arg_111_1.actors_["1033"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1033 = var_114_2.localPosition
				var_114_2.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("1033", 3)

				for iter_114_2 = 0, var_114_2.childCount - 1 do
					local var_114_3 = var_114_2:GetChild(iter_114_2)

					if var_114_3.name == "split_1" or not string.find(var_114_3.name, "split") then
						var_114_3.gameObject:SetActive(true)
					else
						var_114_3.gameObject:SetActive(false)
					end
				end
			end

			local var_114_4 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				var_114_2.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_111_1.time_ - 0) / var_114_4)
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				var_114_2.localPosition = Vector3.New(0, -420, 0)
			end

			local var_114_5 = arg_111_1.actors_["1033"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.actorSpriteComps1033 == nil then
				arg_111_1.var_.actorSpriteComps1033 = var_114_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_6 = 0.125

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_6 and not isNil(var_114_5) then
				if arg_111_1.var_.actorSpriteComps1033 then
					for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_114_4 then
							if arg_111_1.isInRecall_ then
								iter_114_4.color = Color.New(Mathf.Lerp(iter_114_4.color.r, arg_111_1.hightColor1.r, (arg_111_1.time_ - 0) / var_114_6), Mathf.Lerp(iter_114_4.color.g, arg_111_1.hightColor1.g, (arg_111_1.time_ - 0) / var_114_6), (Mathf.Lerp(iter_114_4.color.b, arg_111_1.hightColor1.b, (arg_111_1.time_ - 0) / var_114_6)))
							else
								local var_114_7 = Mathf.Lerp(iter_114_4.color.r, 1, (arg_111_1.time_ - 0) / var_114_6)

								iter_114_4.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_6 and arg_111_1.time_ < 0 + var_114_6 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.actorSpriteComps1033 then
				for iter_114_5, iter_114_6 in pairs(arg_111_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_114_6 then
						iter_114_6.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps1033 = nil
			end

			local var_114_8 = 0
			local var_114_9 = 1.05

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_10 = arg_111_1:GetWordFromCfg(416011026)
				local var_114_11 = arg_111_1:FormatText(var_114_10.content)

				arg_111_1.text_.text = var_114_11

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_13 = 42 <= 0 and var_114_9 or var_114_9 * (utf8.len(var_114_11) / 42)

				if (42 <= 0 and var_114_9 or var_114_9 * (utf8.len(var_114_11) / 42)) > 0 and var_114_9 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_8
					end
				end

				arg_111_1.text_.text = var_114_11
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011026", "story_v_out_416011.awb") ~= 0 then
					local var_114_14 = manager.audio:GetVoiceLength("story_v_out_416011", "416011026", "story_v_out_416011.awb") / 1000

					if var_114_14 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_8
					end

					if var_114_10.prefab_name ~= "" and arg_111_1.actors_[var_114_10.prefab_name] ~= nil then
						local var_114_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_10.prefab_name].transform, "story_v_out_416011", "416011026", "story_v_out_416011.awb")

						arg_111_1:RecordAudio("416011026", var_114_15)
						arg_111_1:RecordAudio("416011026", var_114_15)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_416011", "416011026", "story_v_out_416011.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_416011", "416011026", "story_v_out_416011.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_9, arg_111_1.talkMaxDuration)

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_8) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_8 + var_114_16 and arg_111_1.time_ < var_114_8 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play416011027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416011027
		arg_115_1.duration_ = 4.07

		local var_115_0 = {
			zh = 4.066,
			ja = 3.533
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
				arg_115_0:Play416011028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1033 = arg_115_1.actors_["1033"].transform.localPosition
				arg_115_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1033", 2)

				for iter_118_0 = 0, arg_115_1.actors_["1033"].transform.childCount - 1 do
					local var_118_0 = arg_115_1.actors_["1033"].transform:GetChild(iter_118_0)

					if var_118_0.name == "" or not string.find(var_118_0.name, "split") then
						var_118_0.gameObject:SetActive(true)
					else
						var_118_0.gameObject:SetActive(false)
					end
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_115_1.time_ - 0) / var_118_1)
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["1033"].transform.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_118_2 = arg_115_1.actors_["1033"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps1033 == nil then
				arg_115_1.var_.actorSpriteComps1033 = var_118_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_3 = 0.125

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.actorSpriteComps1033 then
					for iter_118_1, iter_118_2 in pairs(arg_115_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_118_2 then
							if arg_115_1.isInRecall_ then
								iter_118_2.color = Color.New(Mathf.Lerp(iter_118_2.color.r, arg_115_1.hightColor2.r, (arg_115_1.time_ - 0) / var_118_3), Mathf.Lerp(iter_118_2.color.g, arg_115_1.hightColor2.g, (arg_115_1.time_ - 0) / var_118_3), (Mathf.Lerp(iter_118_2.color.b, arg_115_1.hightColor2.b, (arg_115_1.time_ - 0) / var_118_3)))
							else
								local var_118_4 = Mathf.Lerp(iter_118_2.color.r, 0.5, (arg_115_1.time_ - 0) / var_118_3)

								iter_118_2.color = Color.New(var_118_4, var_118_4, var_118_4)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps1033 then
				for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_118_4 then
						iter_118_4.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps1033 = nil
			end

			local var_118_5 = "1148"

			if arg_115_1.actors_["1148"] == nil then
				local var_118_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_118_6) then
					local var_118_7 = Object.Instantiate(var_118_6, arg_115_1.canvasGo_.transform)

					var_118_7.transform:SetSiblingIndex(1)

					var_118_7.name = var_118_5
					var_118_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_115_1.actors_[var_118_5] = var_118_7

					if arg_115_1.isInRecall_ then
						for iter_118_5, iter_118_6 in ipairs((var_118_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_118_6.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_118_8 = arg_115_1.actors_["1148"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1148 = var_118_8.localPosition
				var_118_8.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1148", 4)

				for iter_118_7 = 0, var_118_8.childCount - 1 do
					local var_118_9 = var_118_8:GetChild(iter_118_7)

					if var_118_9.name == "split_2" or not string.find(var_118_9.name, "split") then
						var_118_9.gameObject:SetActive(true)
					else
						var_118_9.gameObject:SetActive(false)
					end
				end
			end

			local var_118_10 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_10 then
				var_118_8.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_115_1.time_ - 0) / var_118_10)
			end

			if arg_115_1.time_ >= 0 + var_118_10 and arg_115_1.time_ < 0 + var_118_10 + arg_118_0 then
				var_118_8.localPosition = Vector3.New(390, -429, -180)
			end

			local var_118_11 = arg_115_1.actors_["1148"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_11) and arg_115_1.var_.actorSpriteComps1148 == nil then
				arg_115_1.var_.actorSpriteComps1148 = var_118_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_12 = 0.125

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_12 and not isNil(var_118_11) then
				if arg_115_1.var_.actorSpriteComps1148 then
					for iter_118_8, iter_118_9 in pairs(arg_115_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_118_9 then
							if arg_115_1.isInRecall_ then
								iter_118_9.color = Color.New(Mathf.Lerp(iter_118_9.color.r, arg_115_1.hightColor1.r, (arg_115_1.time_ - 0) / var_118_12), Mathf.Lerp(iter_118_9.color.g, arg_115_1.hightColor1.g, (arg_115_1.time_ - 0) / var_118_12), (Mathf.Lerp(iter_118_9.color.b, arg_115_1.hightColor1.b, (arg_115_1.time_ - 0) / var_118_12)))
							else
								local var_118_13 = Mathf.Lerp(iter_118_9.color.r, 1, (arg_115_1.time_ - 0) / var_118_12)

								iter_118_9.color = Color.New(var_118_13, var_118_13, var_118_13)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_12 and arg_115_1.time_ < 0 + var_118_12 + arg_118_0 and not isNil(var_118_11) and arg_115_1.var_.actorSpriteComps1148 then
				for iter_118_10, iter_118_11 in pairs(arg_115_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_118_11 then
						iter_118_11.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps1148 = nil
			end

			local var_118_14 = 0
			local var_118_15 = 0.45

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_16 = arg_115_1:GetWordFromCfg(416011027)
				local var_118_17 = arg_115_1:FormatText(var_118_16.content)

				arg_115_1.text_.text = var_118_17

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_19 = 18 <= 0 and var_118_15 or var_118_15 * (utf8.len(var_118_17) / 18)

				if (18 <= 0 and var_118_15 or var_118_15 * (utf8.len(var_118_17) / 18)) > 0 and var_118_15 < var_118_19 then
					arg_115_1.talkMaxDuration = var_118_19

					if var_118_19 + var_118_14 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_19 + var_118_14
					end
				end

				arg_115_1.text_.text = var_118_17
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011027", "story_v_out_416011.awb") ~= 0 then
					local var_118_20 = manager.audio:GetVoiceLength("story_v_out_416011", "416011027", "story_v_out_416011.awb") / 1000

					if var_118_20 + var_118_14 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_14
					end

					if var_118_16.prefab_name ~= "" and arg_115_1.actors_[var_118_16.prefab_name] ~= nil then
						local var_118_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_16.prefab_name].transform, "story_v_out_416011", "416011027", "story_v_out_416011.awb")

						arg_115_1:RecordAudio("416011027", var_118_21)
						arg_115_1:RecordAudio("416011027", var_118_21)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_416011", "416011027", "story_v_out_416011.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_416011", "416011027", "story_v_out_416011.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_22 = math.max(var_118_15, arg_115_1.talkMaxDuration)

			if var_118_14 <= arg_115_1.time_ and arg_115_1.time_ < var_118_14 + var_118_22 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_14) / var_118_22

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_14 + var_118_22 and arg_115_1.time_ < var_118_14 + var_118_22 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play416011028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416011028
		arg_119_1.duration_ = 9.57

		local var_119_0 = {
			zh = 6.566,
			ja = 9.566
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
				arg_119_0:Play416011029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1033"]) and arg_119_1.var_.actorSpriteComps1033 == nil then
				arg_119_1.var_.actorSpriteComps1033 = arg_119_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_0 = 0.125

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1033"]) then
				if arg_119_1.var_.actorSpriteComps1033 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								iter_122_1.color = Color.New(Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor1.r, (arg_119_1.time_ - 0) / var_122_0), Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor1.g, (arg_119_1.time_ - 0) / var_122_0), (Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor1.b, (arg_119_1.time_ - 0) / var_122_0)))
							else
								local var_122_1 = Mathf.Lerp(iter_122_1.color.r, 1, (arg_119_1.time_ - 0) / var_122_0)

								iter_122_1.color = Color.New(var_122_1, var_122_1, var_122_1)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1033"]) and arg_119_1.var_.actorSpriteComps1033 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_122_3 then
						iter_122_3.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps1033 = nil
			end

			local var_122_2 = arg_119_1.actors_["1148"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps1148 == nil then
				arg_119_1.var_.actorSpriteComps1148 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 0.125

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps1148 then
					for iter_122_4, iter_122_5 in pairs(arg_119_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_122_5 then
							if arg_119_1.isInRecall_ then
								iter_122_5.color = Color.New(Mathf.Lerp(iter_122_5.color.r, arg_119_1.hightColor2.r, (arg_119_1.time_ - 0) / var_122_3), Mathf.Lerp(iter_122_5.color.g, arg_119_1.hightColor2.g, (arg_119_1.time_ - 0) / var_122_3), (Mathf.Lerp(iter_122_5.color.b, arg_119_1.hightColor2.b, (arg_119_1.time_ - 0) / var_122_3)))
							else
								local var_122_4 = Mathf.Lerp(iter_122_5.color.r, 0.5, (arg_119_1.time_ - 0) / var_122_3)

								iter_122_5.color = Color.New(var_122_4, var_122_4, var_122_4)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps1148 then
				for iter_122_6, iter_122_7 in pairs(arg_119_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_122_7 then
						iter_122_7.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_119_1.var_.actorSpriteComps1148 = nil
			end

			local var_122_5 = 0
			local var_122_6 = 0.9

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(416011028)
				local var_122_8 = arg_119_1:FormatText(var_122_7.content)

				arg_119_1.text_.text = var_122_8

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 36 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 36)

				if (36 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 36)) > 0 and var_122_6 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_8
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011028", "story_v_out_416011.awb") ~= 0 then
					local var_122_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011028", "story_v_out_416011.awb") / 1000

					if var_122_11 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_5
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_416011", "416011028", "story_v_out_416011.awb")

						arg_119_1:RecordAudio("416011028", var_122_12)
						arg_119_1:RecordAudio("416011028", var_122_12)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416011", "416011028", "story_v_out_416011.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416011", "416011028", "story_v_out_416011.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_13 = math.max(var_122_6, arg_119_1.talkMaxDuration)

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_13 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_5) / var_122_13

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_5 + var_122_13 and arg_119_1.time_ < var_122_5 + var_122_13 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play416011029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416011029
		arg_123_1.duration_ = 7.23

		local var_123_0 = {
			zh = 4.366,
			ja = 7.233
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play416011030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1033"]) and arg_123_1.var_.actorSpriteComps1033 == nil then
				arg_123_1.var_.actorSpriteComps1033 = arg_123_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_0 = 0.125

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1033"]) then
				if arg_123_1.var_.actorSpriteComps1033 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								iter_126_1.color = Color.New(Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_0), Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_0), (Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_0)))
							else
								local var_126_1 = Mathf.Lerp(iter_126_1.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_0)

								iter_126_1.color = Color.New(var_126_1, var_126_1, var_126_1)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1033"]) and arg_123_1.var_.actorSpriteComps1033 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_126_3 then
						iter_126_3.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps1033 = nil
			end

			local var_126_2 = arg_123_1.actors_["1148"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps1148 == nil then
				arg_123_1.var_.actorSpriteComps1148 = var_126_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_3 = 0.125

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.actorSpriteComps1148 then
					for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_126_5 then
							if arg_123_1.isInRecall_ then
								iter_126_5.color = Color.New(Mathf.Lerp(iter_126_5.color.r, arg_123_1.hightColor1.r, (arg_123_1.time_ - 0) / var_126_3), Mathf.Lerp(iter_126_5.color.g, arg_123_1.hightColor1.g, (arg_123_1.time_ - 0) / var_126_3), (Mathf.Lerp(iter_126_5.color.b, arg_123_1.hightColor1.b, (arg_123_1.time_ - 0) / var_126_3)))
							else
								local var_126_4 = Mathf.Lerp(iter_126_5.color.r, 1, (arg_123_1.time_ - 0) / var_126_3)

								iter_126_5.color = Color.New(var_126_4, var_126_4, var_126_4)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps1148 then
				for iter_126_6, iter_126_7 in pairs(arg_123_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_126_7 then
						iter_126_7.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps1148 = nil
			end

			local var_126_5 = arg_123_1.actors_["1148"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1148 = var_126_5.localPosition
				var_126_5.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1148", 4)

				for iter_126_8 = 0, var_126_5.childCount - 1 do
					local var_126_6 = var_126_5:GetChild(iter_126_8)

					if var_126_6.name == "split_1_1" or not string.find(var_126_6.name, "split") then
						var_126_6.gameObject:SetActive(true)
					else
						var_126_6.gameObject:SetActive(false)
					end
				end
			end

			local var_126_7 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				var_126_5.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_123_1.time_ - 0) / var_126_7)
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				var_126_5.localPosition = Vector3.New(390, -429, -180)
			end

			local var_126_8 = 0
			local var_126_9 = 0.525

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(416011029)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 21 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 21)

				if (21 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 21)) > 0 and var_126_9 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011029", "story_v_out_416011.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_out_416011", "416011029", "story_v_out_416011.awb") / 1000

					if var_126_14 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_8
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_416011", "416011029", "story_v_out_416011.awb")

						arg_123_1:RecordAudio("416011029", var_126_15)
						arg_123_1:RecordAudio("416011029", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_416011", "416011029", "story_v_out_416011.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_416011", "416011029", "story_v_out_416011.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_16 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_16 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_16

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_16 and arg_123_1.time_ < var_126_8 + var_126_16 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play416011030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 416011030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play416011031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1033"]) and arg_127_1.var_.actorSpriteComps1033 == nil then
				arg_127_1.var_.actorSpriteComps1033 = arg_127_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.125

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1033"]) then
				if arg_127_1.var_.actorSpriteComps1033 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								iter_130_1.color = Color.New(Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_0), Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_0), (Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_0)))
							else
								local var_130_1 = Mathf.Lerp(iter_130_1.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_0)

								iter_130_1.color = Color.New(var_130_1, var_130_1, var_130_1)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1033"]) and arg_127_1.var_.actorSpriteComps1033 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps1033 = nil
			end

			local var_130_2 = arg_127_1.actors_["1148"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps1148 == nil then
				arg_127_1.var_.actorSpriteComps1148 = var_130_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_3 = 0.125

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.actorSpriteComps1148 then
					for iter_130_4, iter_130_5 in pairs(arg_127_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_130_5 then
							if arg_127_1.isInRecall_ then
								iter_130_5.color = Color.New(Mathf.Lerp(iter_130_5.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_3), Mathf.Lerp(iter_130_5.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_3), (Mathf.Lerp(iter_130_5.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_3)))
							else
								local var_130_4 = Mathf.Lerp(iter_130_5.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_3)

								iter_130_5.color = Color.New(var_130_4, var_130_4, var_130_4)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps1148 then
				for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_130_7 then
						iter_130_7.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps1148 = nil
			end

			local var_130_5 = 0
			local var_130_6 = 2

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_7 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(416011030).content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 80 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_7) / 80)

				if (80 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_7) / 80)) > 0 and var_130_6 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_6, arg_127_1.talkMaxDuration)

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_5) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_5 + var_130_10 and arg_127_1.time_ < var_130_5 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play416011031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 416011031
		arg_131_1.duration_ = 7.43

		local var_131_0 = {
			zh = 7.3,
			ja = 7.433
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
				arg_131_0:Play416011032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1148"]) and arg_131_1.var_.actorSpriteComps1148 == nil then
				arg_131_1.var_.actorSpriteComps1148 = arg_131_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 0.125

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1148"]) then
				if arg_131_1.var_.actorSpriteComps1148 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								iter_134_1.color = Color.New(Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor1.r, (arg_131_1.time_ - 0) / var_134_0), Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor1.g, (arg_131_1.time_ - 0) / var_134_0), (Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor1.b, (arg_131_1.time_ - 0) / var_134_0)))
							else
								local var_134_1 = Mathf.Lerp(iter_134_1.color.r, 1, (arg_131_1.time_ - 0) / var_134_0)

								iter_134_1.color = Color.New(var_134_1, var_134_1, var_134_1)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1148"]) and arg_131_1.var_.actorSpriteComps1148 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps1148 = nil
			end

			local var_134_2 = arg_131_1.actors_["1148"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1148 = var_134_2.localPosition
				var_134_2.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1148", 4)

				for iter_134_4 = 0, var_134_2.childCount - 1 do
					local var_134_3 = var_134_2:GetChild(iter_134_4)

					if var_134_3.name == "split_2" or not string.find(var_134_3.name, "split") then
						var_134_3.gameObject:SetActive(true)
					else
						var_134_3.gameObject:SetActive(false)
					end
				end
			end

			local var_134_4 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				var_134_2.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_131_1.time_ - 0) / var_134_4)
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				var_134_2.localPosition = Vector3.New(390, -429, -180)
			end

			local var_134_5 = 0
			local var_134_6 = 0.7

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_7 = arg_131_1:GetWordFromCfg(416011031)
				local var_134_8 = arg_131_1:FormatText(var_134_7.content)

				arg_131_1.text_.text = var_134_8

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_10 = 28 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 28)

				if (28 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 28)) > 0 and var_134_6 < var_134_10 then
					arg_131_1.talkMaxDuration = var_134_10

					if var_134_10 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_5
					end
				end

				arg_131_1.text_.text = var_134_8
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011031", "story_v_out_416011.awb") ~= 0 then
					local var_134_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011031", "story_v_out_416011.awb") / 1000

					if var_134_11 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_5
					end

					if var_134_7.prefab_name ~= "" and arg_131_1.actors_[var_134_7.prefab_name] ~= nil then
						local var_134_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_7.prefab_name].transform, "story_v_out_416011", "416011031", "story_v_out_416011.awb")

						arg_131_1:RecordAudio("416011031", var_134_12)
						arg_131_1:RecordAudio("416011031", var_134_12)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_416011", "416011031", "story_v_out_416011.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_416011", "416011031", "story_v_out_416011.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_13 = math.max(var_134_6, arg_131_1.talkMaxDuration)

			if var_134_5 <= arg_131_1.time_ and arg_131_1.time_ < var_134_5 + var_134_13 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_5) / var_134_13

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_5 + var_134_13 and arg_131_1.time_ < var_134_5 + var_134_13 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play416011032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 416011032
		arg_135_1.duration_ = 12.57

		local var_135_0 = {
			zh = 9.6,
			ja = 12.566
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
				arg_135_0:Play416011033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1033 = arg_135_1.actors_["1033"].transform.localPosition
				arg_135_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1033", 2)

				for iter_138_0 = 0, arg_135_1.actors_["1033"].transform.childCount - 1 do
					local var_138_0 = arg_135_1.actors_["1033"].transform:GetChild(iter_138_0)

					if var_138_0.name == "split_6" or not string.find(var_138_0.name, "split") then
						var_138_0.gameObject:SetActive(true)
					else
						var_138_0.gameObject:SetActive(false)
					end
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_135_1.time_ - 0) / var_138_1)
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["1033"].transform.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_138_2 = arg_135_1.actors_["1033"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps1033 == nil then
				arg_135_1.var_.actorSpriteComps1033 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 0.125

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps1033 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								iter_138_2.color = Color.New(Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_3), Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_3), (Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_3)))
							else
								local var_138_4 = Mathf.Lerp(iter_138_2.color.r, 1, (arg_135_1.time_ - 0) / var_138_3)

								iter_138_2.color = Color.New(var_138_4, var_138_4, var_138_4)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps1033 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_138_4 then
						iter_138_4.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps1033 = nil
			end

			local var_138_5 = arg_135_1.actors_["1148"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps1148 == nil then
				arg_135_1.var_.actorSpriteComps1148 = var_138_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_6 = 0.125

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 and not isNil(var_138_5) then
				if arg_135_1.var_.actorSpriteComps1148 then
					for iter_138_5, iter_138_6 in pairs(arg_135_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_138_6 then
							if arg_135_1.isInRecall_ then
								iter_138_6.color = Color.New(Mathf.Lerp(iter_138_6.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_6), Mathf.Lerp(iter_138_6.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_6), (Mathf.Lerp(iter_138_6.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_6)))
							else
								local var_138_7 = Mathf.Lerp(iter_138_6.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_6)

								iter_138_6.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps1148 then
				for iter_138_7, iter_138_8 in pairs(arg_135_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_138_8 then
						iter_138_8.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps1148 = nil
			end

			local var_138_8 = 0
			local var_138_9 = 1.15

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_10 = arg_135_1:GetWordFromCfg(416011032)
				local var_138_11 = arg_135_1:FormatText(var_138_10.content)

				arg_135_1.text_.text = var_138_11

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 46 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 46)

				if (46 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 46)) > 0 and var_138_9 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_11
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011032", "story_v_out_416011.awb") ~= 0 then
					local var_138_14 = manager.audio:GetVoiceLength("story_v_out_416011", "416011032", "story_v_out_416011.awb") / 1000

					if var_138_14 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_8
					end

					if var_138_10.prefab_name ~= "" and arg_135_1.actors_[var_138_10.prefab_name] ~= nil then
						local var_138_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_10.prefab_name].transform, "story_v_out_416011", "416011032", "story_v_out_416011.awb")

						arg_135_1:RecordAudio("416011032", var_138_15)
						arg_135_1:RecordAudio("416011032", var_138_15)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_416011", "416011032", "story_v_out_416011.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_416011", "416011032", "story_v_out_416011.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_9, arg_135_1.talkMaxDuration)

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_8) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_8 + var_138_16 and arg_135_1.time_ < var_138_8 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play416011033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 416011033
		arg_139_1.duration_ = 6.27

		local var_139_0 = {
			zh = 5.266,
			ja = 6.266
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
				arg_139_0:Play416011034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1148 = arg_139_1.actors_["1148"].transform.localPosition
				arg_139_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1148", 4)

				for iter_142_0 = 0, arg_139_1.actors_["1148"].transform.childCount - 1 do
					local var_142_0 = arg_139_1.actors_["1148"].transform:GetChild(iter_142_0)

					if var_142_0.name == "split_6" or not string.find(var_142_0.name, "split") then
						var_142_0.gameObject:SetActive(true)
					else
						var_142_0.gameObject:SetActive(false)
					end
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_139_1.time_ - 0) / var_142_1)
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["1148"].transform.localPosition = Vector3.New(390, -429, -180)
			end

			local var_142_2 = arg_139_1.actors_["1148"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps1148 == nil then
				arg_139_1.var_.actorSpriteComps1148 = var_142_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_3 = 0.125

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.actorSpriteComps1148 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_142_2 then
							if arg_139_1.isInRecall_ then
								iter_142_2.color = Color.New(Mathf.Lerp(iter_142_2.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_3), Mathf.Lerp(iter_142_2.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_3), (Mathf.Lerp(iter_142_2.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_3)))
							else
								local var_142_4 = Mathf.Lerp(iter_142_2.color.r, 1, (arg_139_1.time_ - 0) / var_142_3)

								iter_142_2.color = Color.New(var_142_4, var_142_4, var_142_4)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps1148 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_142_4 then
						iter_142_4.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps1148 = nil
			end

			local var_142_5 = arg_139_1.actors_["1033"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.actorSpriteComps1033 == nil then
				arg_139_1.var_.actorSpriteComps1033 = var_142_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_6 = 0.125

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_6 and not isNil(var_142_5) then
				if arg_139_1.var_.actorSpriteComps1033 then
					for iter_142_5, iter_142_6 in pairs(arg_139_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_142_6 then
							if arg_139_1.isInRecall_ then
								iter_142_6.color = Color.New(Mathf.Lerp(iter_142_6.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_6), Mathf.Lerp(iter_142_6.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_6), (Mathf.Lerp(iter_142_6.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_6)))
							else
								local var_142_7 = Mathf.Lerp(iter_142_6.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_6)

								iter_142_6.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_6 and arg_139_1.time_ < 0 + var_142_6 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.actorSpriteComps1033 then
				for iter_142_7, iter_142_8 in pairs(arg_139_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_142_8 then
						iter_142_8.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps1033 = nil
			end

			local var_142_8 = 0
			local var_142_9 = 0.575

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
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

				local var_142_10 = arg_139_1:GetWordFromCfg(416011033)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 23 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 23)

				if (23 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 23)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011033", "story_v_out_416011.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_416011", "416011033", "story_v_out_416011.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_416011", "416011033", "story_v_out_416011.awb")

						arg_139_1:RecordAudio("416011033", var_142_15)
						arg_139_1:RecordAudio("416011033", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_416011", "416011033", "story_v_out_416011.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_416011", "416011033", "story_v_out_416011.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_16 and arg_139_1.time_ < var_142_8 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play416011034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 416011034
		arg_143_1.duration_ = 10.33

		local var_143_0 = {
			zh = 9.3,
			ja = 10.333
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
				arg_143_0:Play416011035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1148"]) and arg_143_1.var_.actorSpriteComps1148 == nil then
				arg_143_1.var_.actorSpriteComps1148 = arg_143_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_0 = 0.125

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1148"]) then
				if arg_143_1.var_.actorSpriteComps1148 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								iter_146_1.color = Color.New(Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor2.r, (arg_143_1.time_ - 0) / var_146_0), Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor2.g, (arg_143_1.time_ - 0) / var_146_0), (Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor2.b, (arg_143_1.time_ - 0) / var_146_0)))
							else
								local var_146_1 = Mathf.Lerp(iter_146_1.color.r, 0.5, (arg_143_1.time_ - 0) / var_146_0)

								iter_146_1.color = Color.New(var_146_1, var_146_1, var_146_1)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1148"]) and arg_143_1.var_.actorSpriteComps1148 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_146_3 then
						iter_146_3.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_143_1.var_.actorSpriteComps1148 = nil
			end

			local var_146_2 = arg_143_1.actors_["1033"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps1033 == nil then
				arg_143_1.var_.actorSpriteComps1033 = var_146_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_3 = 0.125

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_3 and not isNil(var_146_2) then
				if arg_143_1.var_.actorSpriteComps1033 then
					for iter_146_4, iter_146_5 in pairs(arg_143_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_146_5 then
							if arg_143_1.isInRecall_ then
								iter_146_5.color = Color.New(Mathf.Lerp(iter_146_5.color.r, arg_143_1.hightColor1.r, (arg_143_1.time_ - 0) / var_146_3), Mathf.Lerp(iter_146_5.color.g, arg_143_1.hightColor1.g, (arg_143_1.time_ - 0) / var_146_3), (Mathf.Lerp(iter_146_5.color.b, arg_143_1.hightColor1.b, (arg_143_1.time_ - 0) / var_146_3)))
							else
								local var_146_4 = Mathf.Lerp(iter_146_5.color.r, 1, (arg_143_1.time_ - 0) / var_146_3)

								iter_146_5.color = Color.New(var_146_4, var_146_4, var_146_4)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_3 and arg_143_1.time_ < 0 + var_146_3 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps1033 then
				for iter_146_6, iter_146_7 in pairs(arg_143_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_146_7 then
						iter_146_7.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps1033 = nil
			end

			local var_146_5 = 0
			local var_146_6 = 1.05

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_7 = arg_143_1:GetWordFromCfg(416011034)
				local var_146_8 = arg_143_1:FormatText(var_146_7.content)

				arg_143_1.text_.text = var_146_8

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_10 = 42 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_8) / 42)

				if (42 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_8) / 42)) > 0 and var_146_6 < var_146_10 then
					arg_143_1.talkMaxDuration = var_146_10

					if var_146_10 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_5
					end
				end

				arg_143_1.text_.text = var_146_8
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011034", "story_v_out_416011.awb") ~= 0 then
					local var_146_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011034", "story_v_out_416011.awb") / 1000

					if var_146_11 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_5
					end

					if var_146_7.prefab_name ~= "" and arg_143_1.actors_[var_146_7.prefab_name] ~= nil then
						local var_146_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_7.prefab_name].transform, "story_v_out_416011", "416011034", "story_v_out_416011.awb")

						arg_143_1:RecordAudio("416011034", var_146_12)
						arg_143_1:RecordAudio("416011034", var_146_12)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_416011", "416011034", "story_v_out_416011.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_416011", "416011034", "story_v_out_416011.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_13 = math.max(var_146_6, arg_143_1.talkMaxDuration)

			if var_146_5 <= arg_143_1.time_ and arg_143_1.time_ < var_146_5 + var_146_13 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_5) / var_146_13

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_5 + var_146_13 and arg_143_1.time_ < var_146_5 + var_146_13 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play416011035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 416011035
		arg_147_1.duration_ = 7.97

		local var_147_0 = {
			zh = 6,
			ja = 7.966
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
				arg_147_0:Play416011036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1148"]) and arg_147_1.var_.actorSpriteComps1148 == nil then
				arg_147_1.var_.actorSpriteComps1148 = arg_147_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_0 = 0.125

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1148"]) then
				if arg_147_1.var_.actorSpriteComps1148 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_150_1 then
							if arg_147_1.isInRecall_ then
								iter_150_1.color = Color.New(Mathf.Lerp(iter_150_1.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 0) / var_150_0), Mathf.Lerp(iter_150_1.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 0) / var_150_0), (Mathf.Lerp(iter_150_1.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 0) / var_150_0)))
							else
								local var_150_1 = Mathf.Lerp(iter_150_1.color.r, 1, (arg_147_1.time_ - 0) / var_150_0)

								iter_150_1.color = Color.New(var_150_1, var_150_1, var_150_1)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1148"]) and arg_147_1.var_.actorSpriteComps1148 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_150_3 then
						iter_150_3.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps1148 = nil
			end

			local var_150_2 = arg_147_1.actors_["1033"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps1033 == nil then
				arg_147_1.var_.actorSpriteComps1033 = var_150_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_3 = 0.125

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.actorSpriteComps1033 then
					for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_150_5 then
							if arg_147_1.isInRecall_ then
								iter_150_5.color = Color.New(Mathf.Lerp(iter_150_5.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 0) / var_150_3), Mathf.Lerp(iter_150_5.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 0) / var_150_3), (Mathf.Lerp(iter_150_5.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 0) / var_150_3)))
							else
								local var_150_4 = Mathf.Lerp(iter_150_5.color.r, 0.5, (arg_147_1.time_ - 0) / var_150_3)

								iter_150_5.color = Color.New(var_150_4, var_150_4, var_150_4)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps1033 then
				for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_150_7 then
						iter_150_7.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps1033 = nil
			end

			local var_150_5 = arg_147_1.actors_["1148"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1148 = var_150_5.localPosition
				var_150_5.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1148", 4)

				for iter_150_8 = 0, var_150_5.childCount - 1 do
					local var_150_6 = var_150_5:GetChild(iter_150_8)

					if var_150_6.name == "split_4" or not string.find(var_150_6.name, "split") then
						var_150_6.gameObject:SetActive(true)
					else
						var_150_6.gameObject:SetActive(false)
					end
				end
			end

			local var_150_7 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				var_150_5.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_147_1.time_ - 0) / var_150_7)
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				var_150_5.localPosition = Vector3.New(390, -429, -180)
			end

			local var_150_8 = 0
			local var_150_9 = 0.625

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
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

				local var_150_10 = arg_147_1:GetWordFromCfg(416011035)
				local var_150_11 = arg_147_1:FormatText(var_150_10.content)

				arg_147_1.text_.text = var_150_11

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_13 = 25 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 25)

				if (25 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 25)) > 0 and var_150_9 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_8
					end
				end

				arg_147_1.text_.text = var_150_11
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011035", "story_v_out_416011.awb") ~= 0 then
					local var_150_14 = manager.audio:GetVoiceLength("story_v_out_416011", "416011035", "story_v_out_416011.awb") / 1000

					if var_150_14 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_14 + var_150_8
					end

					if var_150_10.prefab_name ~= "" and arg_147_1.actors_[var_150_10.prefab_name] ~= nil then
						local var_150_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_10.prefab_name].transform, "story_v_out_416011", "416011035", "story_v_out_416011.awb")

						arg_147_1:RecordAudio("416011035", var_150_15)
						arg_147_1:RecordAudio("416011035", var_150_15)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_416011", "416011035", "story_v_out_416011.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_416011", "416011035", "story_v_out_416011.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_16 = math.max(var_150_9, arg_147_1.talkMaxDuration)

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_16 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_8) / var_150_16

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_8 + var_150_16 and arg_147_1.time_ < var_150_8 + var_150_16 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play416011036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 416011036
		arg_151_1.duration_ = 11.4

		local var_151_0 = {
			zh = 6.766,
			ja = 11.4
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
				arg_151_0:Play416011037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1033"]) and arg_151_1.var_.actorSpriteComps1033 == nil then
				arg_151_1.var_.actorSpriteComps1033 = arg_151_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.125

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1033"]) then
				if arg_151_1.var_.actorSpriteComps1033 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1033"]) and arg_151_1.var_.actorSpriteComps1033 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_151_1.var_.actorSpriteComps1033 = nil
			end

			local var_154_2 = arg_151_1.actors_["1148"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps1148 == nil then
				arg_151_1.var_.actorSpriteComps1148 = var_154_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_3 = 0.125

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.actorSpriteComps1148 then
					for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_154_5 then
							if arg_151_1.isInRecall_ then
								iter_154_5.color = Color.New(Mathf.Lerp(iter_154_5.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_3), Mathf.Lerp(iter_154_5.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_3), (Mathf.Lerp(iter_154_5.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_3)))
							else
								local var_154_4 = Mathf.Lerp(iter_154_5.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_3)

								iter_154_5.color = Color.New(var_154_4, var_154_4, var_154_4)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps1148 then
				for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_154_7 then
						iter_154_7.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps1148 = nil
			end

			local var_154_5 = 0
			local var_154_6 = 0.9

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_7 = arg_151_1:GetWordFromCfg(416011036)
				local var_154_8 = arg_151_1:FormatText(var_154_7.content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 36 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 36)

				if (36 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 36)) > 0 and var_154_6 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10

					if var_154_10 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_5
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011036", "story_v_out_416011.awb") ~= 0 then
					local var_154_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011036", "story_v_out_416011.awb") / 1000

					if var_154_11 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_5
					end

					if var_154_7.prefab_name ~= "" and arg_151_1.actors_[var_154_7.prefab_name] ~= nil then
						local var_154_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_7.prefab_name].transform, "story_v_out_416011", "416011036", "story_v_out_416011.awb")

						arg_151_1:RecordAudio("416011036", var_154_12)
						arg_151_1:RecordAudio("416011036", var_154_12)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_416011", "416011036", "story_v_out_416011.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_416011", "416011036", "story_v_out_416011.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_13 = math.max(var_154_6, arg_151_1.talkMaxDuration)

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_13 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_5) / var_154_13

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_5 + var_154_13 and arg_151_1.time_ < var_154_5 + var_154_13 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play416011037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 416011037
		arg_155_1.duration_ = 8.7

		local var_155_0 = {
			zh = 8.7,
			ja = 7.366
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
				arg_155_0:Play416011038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1148"]) and arg_155_1.var_.actorSpriteComps1148 == nil then
				arg_155_1.var_.actorSpriteComps1148 = arg_155_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_0 = 0.125

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1148"]) then
				if arg_155_1.var_.actorSpriteComps1148 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								iter_158_1.color = Color.New(Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_0), Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_0), (Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_0)))
							else
								local var_158_1 = Mathf.Lerp(iter_158_1.color.r, 1, (arg_155_1.time_ - 0) / var_158_0)

								iter_158_1.color = Color.New(var_158_1, var_158_1, var_158_1)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1148"]) and arg_155_1.var_.actorSpriteComps1148 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_158_3 then
						iter_158_3.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps1148 = nil
			end

			local var_158_2 = arg_155_1.actors_["1033"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps1033 == nil then
				arg_155_1.var_.actorSpriteComps1033 = var_158_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_3 = 0.125

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.actorSpriteComps1033 then
					for iter_158_4, iter_158_5 in pairs(arg_155_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_158_5 then
							if arg_155_1.isInRecall_ then
								iter_158_5.color = Color.New(Mathf.Lerp(iter_158_5.color.r, arg_155_1.hightColor2.r, (arg_155_1.time_ - 0) / var_158_3), Mathf.Lerp(iter_158_5.color.g, arg_155_1.hightColor2.g, (arg_155_1.time_ - 0) / var_158_3), (Mathf.Lerp(iter_158_5.color.b, arg_155_1.hightColor2.b, (arg_155_1.time_ - 0) / var_158_3)))
							else
								local var_158_4 = Mathf.Lerp(iter_158_5.color.r, 0.5, (arg_155_1.time_ - 0) / var_158_3)

								iter_158_5.color = Color.New(var_158_4, var_158_4, var_158_4)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps1033 then
				for iter_158_6, iter_158_7 in pairs(arg_155_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_158_7 then
						iter_158_7.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_155_1.var_.actorSpriteComps1033 = nil
			end

			local var_158_5 = arg_155_1.actors_["1148"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1148 = var_158_5.localPosition
				var_158_5.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1148", 4)

				for iter_158_8 = 0, var_158_5.childCount - 1 do
					local var_158_6 = var_158_5:GetChild(iter_158_8)

					if var_158_6.name == "split_4" or not string.find(var_158_6.name, "split") then
						var_158_6.gameObject:SetActive(true)
					else
						var_158_6.gameObject:SetActive(false)
					end
				end
			end

			local var_158_7 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				var_158_5.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_155_1.time_ - 0) / var_158_7)
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				var_158_5.localPosition = Vector3.New(390, -429, -180)
			end

			local var_158_8 = 0
			local var_158_9 = 0.75

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 then
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

				local var_158_10 = arg_155_1:GetWordFromCfg(416011037)
				local var_158_11 = arg_155_1:FormatText(var_158_10.content)

				arg_155_1.text_.text = var_158_11

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_13 = 30 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 30)

				if (30 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 30)) > 0 and var_158_9 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_8
					end
				end

				arg_155_1.text_.text = var_158_11
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011037", "story_v_out_416011.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_out_416011", "416011037", "story_v_out_416011.awb") / 1000

					if var_158_14 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_8
					end

					if var_158_10.prefab_name ~= "" and arg_155_1.actors_[var_158_10.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_10.prefab_name].transform, "story_v_out_416011", "416011037", "story_v_out_416011.awb")

						arg_155_1:RecordAudio("416011037", var_158_15)
						arg_155_1:RecordAudio("416011037", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_416011", "416011037", "story_v_out_416011.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_416011", "416011037", "story_v_out_416011.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_9, arg_155_1.talkMaxDuration)

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_8) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_8 + var_158_16 and arg_155_1.time_ < var_158_8 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416011038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 416011038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play416011039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1148"]) and arg_159_1.var_.actorSpriteComps1148 == nil then
				arg_159_1.var_.actorSpriteComps1148 = arg_159_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_0 = 0.125

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1148"]) then
				if arg_159_1.var_.actorSpriteComps1148 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								iter_162_1.color = Color.New(Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor2.r, (arg_159_1.time_ - 0) / var_162_0), Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor2.g, (arg_159_1.time_ - 0) / var_162_0), (Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor2.b, (arg_159_1.time_ - 0) / var_162_0)))
							else
								local var_162_1 = Mathf.Lerp(iter_162_1.color.r, 0.5, (arg_159_1.time_ - 0) / var_162_0)

								iter_162_1.color = Color.New(var_162_1, var_162_1, var_162_1)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1148"]) and arg_159_1.var_.actorSpriteComps1148 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_162_3 then
						iter_162_3.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_159_1.var_.actorSpriteComps1148 = nil
			end

			local var_162_2 = 0
			local var_162_3 = 1.225

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(416011038).content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_6 = 49 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_4) / 49)

				if (49 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_4) / 49)) > 0 and var_162_3 < var_162_6 then
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
	Play416011039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 416011039
		arg_163_1.duration_ = 8.53

		local var_163_0 = {
			zh = 8.533,
			ja = 8.166
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
				arg_163_0:Play416011040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1148"]) and arg_163_1.var_.actorSpriteComps1148 == nil then
				arg_163_1.var_.actorSpriteComps1148 = arg_163_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 0.125

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1148"]) then
				if arg_163_1.var_.actorSpriteComps1148 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								iter_166_1.color = Color.New(Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_0), Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_0), (Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_0)))
							else
								local var_166_1 = Mathf.Lerp(iter_166_1.color.r, 1, (arg_163_1.time_ - 0) / var_166_0)

								iter_166_1.color = Color.New(var_166_1, var_166_1, var_166_1)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1148"]) and arg_163_1.var_.actorSpriteComps1148 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps1148 = nil
			end

			local var_166_2 = arg_163_1.actors_["1148"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1148 = var_166_2.localPosition
				var_166_2.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1148", 4)

				for iter_166_4 = 0, var_166_2.childCount - 1 do
					local var_166_3 = var_166_2:GetChild(iter_166_4)

					if var_166_3.name == "split_1_1" or not string.find(var_166_3.name, "split") then
						var_166_3.gameObject:SetActive(true)
					else
						var_166_3.gameObject:SetActive(false)
					end
				end
			end

			local var_166_4 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				var_166_2.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_163_1.time_ - 0) / var_166_4)
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				var_166_2.localPosition = Vector3.New(390, -429, -180)
			end

			local var_166_5 = 0
			local var_166_6 = 0.725

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
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

				local var_166_7 = arg_163_1:GetWordFromCfg(416011039)
				local var_166_8 = arg_163_1:FormatText(var_166_7.content)

				arg_163_1.text_.text = var_166_8

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 29 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 29)

				if (29 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 29)) > 0 and var_166_6 < var_166_10 then
					arg_163_1.talkMaxDuration = var_166_10

					if var_166_10 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_8
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011039", "story_v_out_416011.awb") ~= 0 then
					local var_166_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011039", "story_v_out_416011.awb") / 1000

					if var_166_11 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_5
					end

					if var_166_7.prefab_name ~= "" and arg_163_1.actors_[var_166_7.prefab_name] ~= nil then
						local var_166_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_7.prefab_name].transform, "story_v_out_416011", "416011039", "story_v_out_416011.awb")

						arg_163_1:RecordAudio("416011039", var_166_12)
						arg_163_1:RecordAudio("416011039", var_166_12)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_416011", "416011039", "story_v_out_416011.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_416011", "416011039", "story_v_out_416011.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_13 = math.max(var_166_6, arg_163_1.talkMaxDuration)

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_13 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_5) / var_166_13

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_5 + var_166_13 and arg_163_1.time_ < var_166_5 + var_166_13 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play416011040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 416011040
		arg_167_1.duration_ = 8.33

		local var_167_0 = {
			zh = 6.266,
			ja = 8.333
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
				arg_167_0:Play416011041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1148"]) and arg_167_1.var_.actorSpriteComps1148 == nil then
				arg_167_1.var_.actorSpriteComps1148 = arg_167_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.125

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1148"]) then
				if arg_167_1.var_.actorSpriteComps1148 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1148"]) and arg_167_1.var_.actorSpriteComps1148 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps1148 = nil
			end

			local var_170_2 = arg_167_1.actors_["1033"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps1033 == nil then
				arg_167_1.var_.actorSpriteComps1033 = var_170_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_3 = 0.125

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.actorSpriteComps1033 then
					for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_170_5 then
							if arg_167_1.isInRecall_ then
								iter_170_5.color = Color.New(Mathf.Lerp(iter_170_5.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_3), Mathf.Lerp(iter_170_5.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_3), (Mathf.Lerp(iter_170_5.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_3)))
							else
								local var_170_4 = Mathf.Lerp(iter_170_5.color.r, 1, (arg_167_1.time_ - 0) / var_170_3)

								iter_170_5.color = Color.New(var_170_4, var_170_4, var_170_4)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps1033 then
				for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_170_7 then
						iter_170_7.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps1033 = nil
			end

			local var_170_5 = 0
			local var_170_6 = 0.5

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_7 = arg_167_1:GetWordFromCfg(416011040)
				local var_170_8 = arg_167_1:FormatText(var_170_7.content)

				arg_167_1.text_.text = var_170_8

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_10 = 20 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_8) / 20)

				if (20 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_8) / 20)) > 0 and var_170_6 < var_170_10 then
					arg_167_1.talkMaxDuration = var_170_10

					if var_170_10 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_5
					end
				end

				arg_167_1.text_.text = var_170_8
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011040", "story_v_out_416011.awb") ~= 0 then
					local var_170_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011040", "story_v_out_416011.awb") / 1000

					if var_170_11 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_5
					end

					if var_170_7.prefab_name ~= "" and arg_167_1.actors_[var_170_7.prefab_name] ~= nil then
						local var_170_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_7.prefab_name].transform, "story_v_out_416011", "416011040", "story_v_out_416011.awb")

						arg_167_1:RecordAudio("416011040", var_170_12)
						arg_167_1:RecordAudio("416011040", var_170_12)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_416011", "416011040", "story_v_out_416011.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_416011", "416011040", "story_v_out_416011.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_13 = math.max(var_170_6, arg_167_1.talkMaxDuration)

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_13 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_5) / var_170_13

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_5 + var_170_13 and arg_167_1.time_ < var_170_5 + var_170_13 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play416011041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 416011041
		arg_171_1.duration_ = 10.4

		local var_171_0 = {
			zh = 8.2,
			ja = 10.4
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
				arg_171_0:Play416011042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1033"]) and arg_171_1.var_.actorSpriteComps1033 == nil then
				arg_171_1.var_.actorSpriteComps1033 = arg_171_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_0 = 0.125

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1033"]) then
				if arg_171_1.var_.actorSpriteComps1033 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1033"]) and arg_171_1.var_.actorSpriteComps1033 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_174_3 then
						iter_174_3.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_171_1.var_.actorSpriteComps1033 = nil
			end

			local var_174_2 = arg_171_1.actors_["1148"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps1148 == nil then
				arg_171_1.var_.actorSpriteComps1148 = var_174_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_3 = 0.125

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.actorSpriteComps1148 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps1148 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_174_7 then
						iter_174_7.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps1148 = nil
			end

			local var_174_5 = 0
			local var_174_6 = 0.925

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
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

				local var_174_7 = arg_171_1:GetWordFromCfg(416011041)
				local var_174_8 = arg_171_1:FormatText(var_174_7.content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_10 = 37 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 37)

				if (37 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 37)) > 0 and var_174_6 < var_174_10 then
					arg_171_1.talkMaxDuration = var_174_10

					if var_174_10 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011041", "story_v_out_416011.awb") ~= 0 then
					local var_174_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011041", "story_v_out_416011.awb") / 1000

					if var_174_11 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_5
					end

					if var_174_7.prefab_name ~= "" and arg_171_1.actors_[var_174_7.prefab_name] ~= nil then
						local var_174_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_7.prefab_name].transform, "story_v_out_416011", "416011041", "story_v_out_416011.awb")

						arg_171_1:RecordAudio("416011041", var_174_12)
						arg_171_1:RecordAudio("416011041", var_174_12)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_416011", "416011041", "story_v_out_416011.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_416011", "416011041", "story_v_out_416011.awb")
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
	Play416011042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 416011042
		arg_175_1.duration_ = 7.63

		local var_175_0 = {
			zh = 6.6,
			ja = 7.633
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
				arg_175_0:Play416011043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1033"]) and arg_175_1.var_.actorSpriteComps1033 == nil then
				arg_175_1.var_.actorSpriteComps1033 = arg_175_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_0 = 0.125

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1033"]) then
				if arg_175_1.var_.actorSpriteComps1033 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1033"]) and arg_175_1.var_.actorSpriteComps1033 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_178_3 then
						iter_178_3.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps1033 = nil
			end

			local var_178_2 = arg_175_1.actors_["1148"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1148 == nil then
				arg_175_1.var_.actorSpriteComps1148 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 0.125

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps1148 then
					for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1148 then
				for iter_178_6, iter_178_7 in pairs(arg_175_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_178_7 then
						iter_178_7.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps1148 = nil
			end

			local var_178_5 = 0
			local var_178_6 = 0.825

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_7 = arg_175_1:GetWordFromCfg(416011042)
				local var_178_8 = arg_175_1:FormatText(var_178_7.content)

				arg_175_1.text_.text = var_178_8

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_10 = 33 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_8) / 33)

				if (33 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_8) / 33)) > 0 and var_178_6 < var_178_10 then
					arg_175_1.talkMaxDuration = var_178_10

					if var_178_10 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_5
					end
				end

				arg_175_1.text_.text = var_178_8
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011042", "story_v_out_416011.awb") ~= 0 then
					local var_178_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011042", "story_v_out_416011.awb") / 1000

					if var_178_11 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_5
					end

					if var_178_7.prefab_name ~= "" and arg_175_1.actors_[var_178_7.prefab_name] ~= nil then
						local var_178_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_7.prefab_name].transform, "story_v_out_416011", "416011042", "story_v_out_416011.awb")

						arg_175_1:RecordAudio("416011042", var_178_12)
						arg_175_1:RecordAudio("416011042", var_178_12)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_416011", "416011042", "story_v_out_416011.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_416011", "416011042", "story_v_out_416011.awb")
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
	Play416011043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 416011043
		arg_179_1.duration_ = 10.33

		local var_179_0 = {
			zh = 8,
			ja = 10.333
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
				arg_179_0:Play416011044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1033"]) and arg_179_1.var_.actorSpriteComps1033 == nil then
				arg_179_1.var_.actorSpriteComps1033 = arg_179_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.125

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1033"]) then
				if arg_179_1.var_.actorSpriteComps1033 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1033"]) and arg_179_1.var_.actorSpriteComps1033 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps1033 = nil
			end

			local var_182_2 = arg_179_1.actors_["1148"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps1148 == nil then
				arg_179_1.var_.actorSpriteComps1148 = var_182_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_3 = 0.125

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.actorSpriteComps1148 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps1148 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_182_7 then
						iter_182_7.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps1148 = nil
			end

			local var_182_5 = 0
			local var_182_6 = 0.85

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_7 = arg_179_1:GetWordFromCfg(416011043)
				local var_182_8 = arg_179_1:FormatText(var_182_7.content)

				arg_179_1.text_.text = var_182_8

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_10 = 34 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 34)

				if (34 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 34)) > 0 and var_182_6 < var_182_10 then
					arg_179_1.talkMaxDuration = var_182_10

					if var_182_10 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_5
					end
				end

				arg_179_1.text_.text = var_182_8
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011043", "story_v_out_416011.awb") ~= 0 then
					local var_182_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011043", "story_v_out_416011.awb") / 1000

					if var_182_11 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_5
					end

					if var_182_7.prefab_name ~= "" and arg_179_1.actors_[var_182_7.prefab_name] ~= nil then
						local var_182_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_7.prefab_name].transform, "story_v_out_416011", "416011043", "story_v_out_416011.awb")

						arg_179_1:RecordAudio("416011043", var_182_12)
						arg_179_1:RecordAudio("416011043", var_182_12)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_416011", "416011043", "story_v_out_416011.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_416011", "416011043", "story_v_out_416011.awb")
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
	Play416011044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 416011044
		arg_183_1.duration_ = 10.97

		local var_183_0 = {
			zh = 6.466,
			ja = 10.966
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
				arg_183_0:Play416011045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1033"]) and arg_183_1.var_.actorSpriteComps1033 == nil then
				arg_183_1.var_.actorSpriteComps1033 = arg_183_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_0 = 0.125

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1033"]) then
				if arg_183_1.var_.actorSpriteComps1033 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								iter_186_1.color = Color.New(Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 0) / var_186_0), Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 0) / var_186_0), (Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 0) / var_186_0)))
							else
								local var_186_1 = Mathf.Lerp(iter_186_1.color.r, 1, (arg_183_1.time_ - 0) / var_186_0)

								iter_186_1.color = Color.New(var_186_1, var_186_1, var_186_1)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1033"]) and arg_183_1.var_.actorSpriteComps1033 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_186_3 then
						iter_186_3.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps1033 = nil
			end

			local var_186_2 = arg_183_1.actors_["1148"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.actorSpriteComps1148 == nil then
				arg_183_1.var_.actorSpriteComps1148 = var_186_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_3 = 0.125

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_3 and not isNil(var_186_2) then
				if arg_183_1.var_.actorSpriteComps1148 then
					for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_186_5 then
							if arg_183_1.isInRecall_ then
								iter_186_5.color = Color.New(Mathf.Lerp(iter_186_5.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 0) / var_186_3), Mathf.Lerp(iter_186_5.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 0) / var_186_3), (Mathf.Lerp(iter_186_5.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 0) / var_186_3)))
							else
								local var_186_4 = Mathf.Lerp(iter_186_5.color.r, 0.5, (arg_183_1.time_ - 0) / var_186_3)

								iter_186_5.color = Color.New(var_186_4, var_186_4, var_186_4)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_3 and arg_183_1.time_ < 0 + var_186_3 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.actorSpriteComps1148 then
				for iter_186_6, iter_186_7 in pairs(arg_183_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_186_7 then
						iter_186_7.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps1148 = nil
			end

			if 0.666666666666667 < arg_183_1.time_ and arg_183_1.time_ <= 0.666666666666667 + arg_186_0 then
				arg_183_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_alarmclock", "")
			end

			local var_186_6 = 0
			local var_186_7 = 0.95

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_8 = arg_183_1:GetWordFromCfg(416011044)
				local var_186_9 = arg_183_1:FormatText(var_186_8.content)

				arg_183_1.text_.text = var_186_9

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 38 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 38)

				if (38 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 38)) > 0 and var_186_7 < var_186_11 then
					arg_183_1.talkMaxDuration = var_186_11

					if var_186_11 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_11 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_9
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011044", "story_v_out_416011.awb") ~= 0 then
					local var_186_12 = manager.audio:GetVoiceLength("story_v_out_416011", "416011044", "story_v_out_416011.awb") / 1000

					if var_186_12 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_12 + var_186_6
					end

					if var_186_8.prefab_name ~= "" and arg_183_1.actors_[var_186_8.prefab_name] ~= nil then
						local var_186_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_8.prefab_name].transform, "story_v_out_416011", "416011044", "story_v_out_416011.awb")

						arg_183_1:RecordAudio("416011044", var_186_13)
						arg_183_1:RecordAudio("416011044", var_186_13)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_416011", "416011044", "story_v_out_416011.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_416011", "416011044", "story_v_out_416011.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_14 and arg_183_1.time_ < var_186_6 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play416011045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 416011045
		arg_187_1.duration_ = 22.27

		local var_187_0 = {
			zh = 10.533,
			ja = 22.266
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
				arg_187_0:Play416011046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1033 = arg_187_1.actors_["1033"].transform.localPosition
				arg_187_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1033", 2)

				for iter_190_0 = 0, arg_187_1.actors_["1033"].transform.childCount - 1 do
					local var_190_0 = arg_187_1.actors_["1033"].transform:GetChild(iter_190_0)

					if var_190_0.name == "split_6" or not string.find(var_190_0.name, "split") then
						var_190_0.gameObject:SetActive(true)
					else
						var_190_0.gameObject:SetActive(false)
					end
				end
			end

			local var_190_1 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 then
				arg_187_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_187_1.time_ - 0) / var_190_1)
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 then
				arg_187_1.actors_["1033"].transform.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_190_2 = 0
			local var_190_3 = 1.125

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_4 = arg_187_1:GetWordFromCfg(416011045)
				local var_190_5 = arg_187_1:FormatText(var_190_4.content)

				arg_187_1.text_.text = var_190_5

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_7 = 45 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 45)

				if (45 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 45)) > 0 and var_190_3 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_2
					end
				end

				arg_187_1.text_.text = var_190_5
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011045", "story_v_out_416011.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011045", "story_v_out_416011.awb") / 1000

					if var_190_8 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_2
					end

					if var_190_4.prefab_name ~= "" and arg_187_1.actors_[var_190_4.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_4.prefab_name].transform, "story_v_out_416011", "416011045", "story_v_out_416011.awb")

						arg_187_1:RecordAudio("416011045", var_190_9)
						arg_187_1:RecordAudio("416011045", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_416011", "416011045", "story_v_out_416011.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_416011", "416011045", "story_v_out_416011.awb")
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

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play416011046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 416011046
		arg_191_1.duration_ = 8.6

		local var_191_0 = {
			zh = 5.4,
			ja = 8.6
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
				arg_191_0:Play416011047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1033"]) and arg_191_1.var_.actorSpriteComps1033 == nil then
				arg_191_1.var_.actorSpriteComps1033 = arg_191_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_0 = 0.125

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1033"]) then
				if arg_191_1.var_.actorSpriteComps1033 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_194_1 then
							if arg_191_1.isInRecall_ then
								iter_194_1.color = Color.New(Mathf.Lerp(iter_194_1.color.r, arg_191_1.hightColor2.r, (arg_191_1.time_ - 0) / var_194_0), Mathf.Lerp(iter_194_1.color.g, arg_191_1.hightColor2.g, (arg_191_1.time_ - 0) / var_194_0), (Mathf.Lerp(iter_194_1.color.b, arg_191_1.hightColor2.b, (arg_191_1.time_ - 0) / var_194_0)))
							else
								local var_194_1 = Mathf.Lerp(iter_194_1.color.r, 0.5, (arg_191_1.time_ - 0) / var_194_0)

								iter_194_1.color = Color.New(var_194_1, var_194_1, var_194_1)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1033"]) and arg_191_1.var_.actorSpriteComps1033 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_194_3 then
						iter_194_3.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_191_1.var_.actorSpriteComps1033 = nil
			end

			local var_194_2 = arg_191_1.actors_["1148"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps1148 == nil then
				arg_191_1.var_.actorSpriteComps1148 = var_194_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_3 = 0.125

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_3 and not isNil(var_194_2) then
				if arg_191_1.var_.actorSpriteComps1148 then
					for iter_194_4, iter_194_5 in pairs(arg_191_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_194_5 then
							if arg_191_1.isInRecall_ then
								iter_194_5.color = Color.New(Mathf.Lerp(iter_194_5.color.r, arg_191_1.hightColor1.r, (arg_191_1.time_ - 0) / var_194_3), Mathf.Lerp(iter_194_5.color.g, arg_191_1.hightColor1.g, (arg_191_1.time_ - 0) / var_194_3), (Mathf.Lerp(iter_194_5.color.b, arg_191_1.hightColor1.b, (arg_191_1.time_ - 0) / var_194_3)))
							else
								local var_194_4 = Mathf.Lerp(iter_194_5.color.r, 1, (arg_191_1.time_ - 0) / var_194_3)

								iter_194_5.color = Color.New(var_194_4, var_194_4, var_194_4)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_3 and arg_191_1.time_ < 0 + var_194_3 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps1148 then
				for iter_194_6, iter_194_7 in pairs(arg_191_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_194_7 then
						iter_194_7.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_191_1.var_.actorSpriteComps1148 = nil
			end

			local var_194_5 = arg_191_1.actors_["1148"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1148 = var_194_5.localPosition
				var_194_5.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("1148", 4)

				for iter_194_8 = 0, var_194_5.childCount - 1 do
					local var_194_6 = var_194_5:GetChild(iter_194_8)

					if var_194_6.name == "split_1_1" or not string.find(var_194_6.name, "split") then
						var_194_6.gameObject:SetActive(true)
					else
						var_194_6.gameObject:SetActive(false)
					end
				end
			end

			local var_194_7 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				var_194_5.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_191_1.time_ - 0) / var_194_7)
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				var_194_5.localPosition = Vector3.New(390, -429, -180)
			end

			local var_194_8 = 0
			local var_194_9 = 0.55

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_10 = arg_191_1:GetWordFromCfg(416011046)
				local var_194_11 = arg_191_1:FormatText(var_194_10.content)

				arg_191_1.text_.text = var_194_11

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_13 = 22 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 22)

				if (22 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 22)) > 0 and var_194_9 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_8
					end
				end

				arg_191_1.text_.text = var_194_11
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011046", "story_v_out_416011.awb") ~= 0 then
					local var_194_14 = manager.audio:GetVoiceLength("story_v_out_416011", "416011046", "story_v_out_416011.awb") / 1000

					if var_194_14 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_8
					end

					if var_194_10.prefab_name ~= "" and arg_191_1.actors_[var_194_10.prefab_name] ~= nil then
						local var_194_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_10.prefab_name].transform, "story_v_out_416011", "416011046", "story_v_out_416011.awb")

						arg_191_1:RecordAudio("416011046", var_194_15)
						arg_191_1:RecordAudio("416011046", var_194_15)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_416011", "416011046", "story_v_out_416011.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_416011", "416011046", "story_v_out_416011.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_16 = math.max(var_194_9, arg_191_1.talkMaxDuration)

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_16 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_8) / var_194_16

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_8 + var_194_16 and arg_191_1.time_ < var_194_8 + var_194_16 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416011047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 416011047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play416011048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1148"]) and arg_195_1.var_.actorSpriteComps1148 == nil then
				arg_195_1.var_.actorSpriteComps1148 = arg_195_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_0 = 0.125

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1148"]) then
				if arg_195_1.var_.actorSpriteComps1148 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1148"]) and arg_195_1.var_.actorSpriteComps1148 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_198_3 then
						iter_198_3.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps1148 = nil
			end

			local var_198_2 = arg_195_1.actors_["1033"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1033 = var_198_2.localPosition
				var_198_2.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1033", 7)

				for iter_198_4 = 0, var_198_2.childCount - 1 do
					local var_198_3 = var_198_2:GetChild(iter_198_4)

					if var_198_3.name == "" or not string.find(var_198_3.name, "split") then
						var_198_3.gameObject:SetActive(true)
					else
						var_198_3.gameObject:SetActive(false)
					end
				end
			end

			local var_198_4 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				var_198_2.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_195_1.time_ - 0) / var_198_4)
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				var_198_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_5 = arg_195_1.actors_["1148"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1148 = var_198_5.localPosition
				var_198_5.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1148", 7)

				for iter_198_5 = 0, var_198_5.childCount - 1 do
					local var_198_6 = var_198_5:GetChild(iter_198_5)

					if var_198_6.name == "" or not string.find(var_198_6.name, "split") then
						var_198_6.gameObject:SetActive(true)
					else
						var_198_6.gameObject:SetActive(false)
					end
				end
			end

			local var_198_7 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				var_198_5.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_195_1.time_ - 0) / var_198_7)
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				var_198_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_8 = 0
			local var_198_9 = 1.35

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_10 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(416011047).content)

				arg_195_1.text_.text = var_198_10

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_12 = 54 <= 0 and var_198_9 or var_198_9 * (utf8.len(var_198_10) / 54)

				if (54 <= 0 and var_198_9 or var_198_9 * (utf8.len(var_198_10) / 54)) > 0 and var_198_9 < var_198_12 then
					arg_195_1.talkMaxDuration = var_198_12

					if var_198_12 + var_198_8 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_8
					end
				end

				arg_195_1.text_.text = var_198_10
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_13 = math.max(var_198_9, arg_195_1.talkMaxDuration)

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_13 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_8) / var_198_13

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_8 + var_198_13 and arg_195_1.time_ < var_198_8 + var_198_13 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
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
	Play416011048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 416011048
		arg_199_1.duration_ = 9.53

		local var_199_0 = {
			zh = 6.4,
			ja = 9.533
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
				arg_199_0:Play416011049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1033"]) and arg_199_1.var_.actorSpriteComps1033 == nil then
				arg_199_1.var_.actorSpriteComps1033 = arg_199_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_0 = 0.125

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1033"]) then
				if arg_199_1.var_.actorSpriteComps1033 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1033"]) and arg_199_1.var_.actorSpriteComps1033 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_202_3 then
						iter_202_3.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps1033 = nil
			end

			local var_202_2 = arg_199_1.actors_["1033"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1033 = var_202_2.localPosition
				var_202_2.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("1033", 3)

				for iter_202_4 = 0, var_202_2.childCount - 1 do
					local var_202_3 = var_202_2:GetChild(iter_202_4)

					if var_202_3.name == "split_6" or not string.find(var_202_3.name, "split") then
						var_202_3.gameObject:SetActive(true)
					else
						var_202_3.gameObject:SetActive(false)
					end
				end
			end

			local var_202_4 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				var_202_2.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_199_1.time_ - 0) / var_202_4)
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				var_202_2.localPosition = Vector3.New(0, -420, 0)
			end

			local var_202_5 = 0
			local var_202_6 = 0.85

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_7 = arg_199_1:GetWordFromCfg(416011048)
				local var_202_8 = arg_199_1:FormatText(var_202_7.content)

				arg_199_1.text_.text = var_202_8

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 34 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 34)

				if (34 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 34)) > 0 and var_202_6 < var_202_10 then
					arg_199_1.talkMaxDuration = var_202_10

					if var_202_10 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_5
					end
				end

				arg_199_1.text_.text = var_202_8
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011048", "story_v_out_416011.awb") ~= 0 then
					local var_202_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011048", "story_v_out_416011.awb") / 1000

					if var_202_11 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_5
					end

					if var_202_7.prefab_name ~= "" and arg_199_1.actors_[var_202_7.prefab_name] ~= nil then
						local var_202_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_7.prefab_name].transform, "story_v_out_416011", "416011048", "story_v_out_416011.awb")

						arg_199_1:RecordAudio("416011048", var_202_12)
						arg_199_1:RecordAudio("416011048", var_202_12)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_416011", "416011048", "story_v_out_416011.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_416011", "416011048", "story_v_out_416011.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_13 = math.max(var_202_6, arg_199_1.talkMaxDuration)

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_13 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_5) / var_202_13

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_5 + var_202_13 and arg_199_1.time_ < var_202_5 + var_202_13 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play416011049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 416011049
		arg_203_1.duration_ = 7.2

		local var_203_0 = {
			zh = 5.4,
			ja = 7.2
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
				arg_203_0:Play416011050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1033"]) and arg_203_1.var_.actorSpriteComps1033 == nil then
				arg_203_1.var_.actorSpriteComps1033 = arg_203_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_0 = 0.125

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1033"]) then
				if arg_203_1.var_.actorSpriteComps1033 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1033"]) and arg_203_1.var_.actorSpriteComps1033 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_206_3 then
						iter_206_3.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_203_1.var_.actorSpriteComps1033 = nil
			end

			local var_206_2 = arg_203_1.actors_["1148"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps1148 == nil then
				arg_203_1.var_.actorSpriteComps1148 = var_206_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_3 = 0.125

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_3 and not isNil(var_206_2) then
				if arg_203_1.var_.actorSpriteComps1148 then
					for iter_206_4, iter_206_5 in pairs(arg_203_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_203_1.time_ >= 0 + var_206_3 and arg_203_1.time_ < 0 + var_206_3 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps1148 then
				for iter_206_6, iter_206_7 in pairs(arg_203_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_206_7 then
						iter_206_7.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_203_1.var_.actorSpriteComps1148 = nil
			end

			local var_206_5 = arg_203_1.actors_["1148"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1148 = var_206_5.localPosition
				var_206_5.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1148", 4)

				for iter_206_8 = 0, var_206_5.childCount - 1 do
					local var_206_6 = var_206_5:GetChild(iter_206_8)

					if var_206_6.name == "split_4" or not string.find(var_206_6.name, "split") then
						var_206_6.gameObject:SetActive(true)
					else
						var_206_6.gameObject:SetActive(false)
					end
				end
			end

			local var_206_7 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				var_206_5.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1148, Vector3.New(390, -429, -180), (arg_203_1.time_ - 0) / var_206_7)
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				var_206_5.localPosition = Vector3.New(390, -429, -180)
			end

			local var_206_8 = arg_203_1.actors_["1033"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1033 = var_206_8.localPosition
				var_206_8.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1033", 2)

				for iter_206_9 = 0, var_206_8.childCount - 1 do
					local var_206_9 = var_206_8:GetChild(iter_206_9)

					if var_206_9.name == "" or not string.find(var_206_9.name, "split") then
						var_206_9.gameObject:SetActive(true)
					else
						var_206_9.gameObject:SetActive(false)
					end
				end
			end

			local var_206_10 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_10 then
				var_206_8.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_203_1.time_ - 0) / var_206_10)
			end

			if arg_203_1.time_ >= 0 + var_206_10 and arg_203_1.time_ < 0 + var_206_10 + arg_206_0 then
				var_206_8.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_206_11 = 0
			local var_206_12 = 0.475

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_11 + arg_206_0 then
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

				local var_206_13 = arg_203_1:GetWordFromCfg(416011049)
				local var_206_14 = arg_203_1:FormatText(var_206_13.content)

				arg_203_1.text_.text = var_206_14

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_16 = 19 <= 0 and var_206_12 or var_206_12 * (utf8.len(var_206_14) / 19)

				if (19 <= 0 and var_206_12 or var_206_12 * (utf8.len(var_206_14) / 19)) > 0 and var_206_12 < var_206_16 then
					arg_203_1.talkMaxDuration = var_206_16

					if var_206_16 + var_206_11 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_16 + var_206_11
					end
				end

				arg_203_1.text_.text = var_206_14
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011049", "story_v_out_416011.awb") ~= 0 then
					local var_206_17 = manager.audio:GetVoiceLength("story_v_out_416011", "416011049", "story_v_out_416011.awb") / 1000

					if var_206_17 + var_206_11 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_17 + var_206_11
					end

					if var_206_13.prefab_name ~= "" and arg_203_1.actors_[var_206_13.prefab_name] ~= nil then
						local var_206_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_13.prefab_name].transform, "story_v_out_416011", "416011049", "story_v_out_416011.awb")

						arg_203_1:RecordAudio("416011049", var_206_18)
						arg_203_1:RecordAudio("416011049", var_206_18)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_416011", "416011049", "story_v_out_416011.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_416011", "416011049", "story_v_out_416011.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_19 = math.max(var_206_12, arg_203_1.talkMaxDuration)

			if var_206_11 <= arg_203_1.time_ and arg_203_1.time_ < var_206_11 + var_206_19 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_11) / var_206_19

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_11 + var_206_19 and arg_203_1.time_ < var_206_11 + var_206_19 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play416011050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 416011050
		arg_207_1.duration_ = 10.5

		local var_207_0 = {
			zh = 5.2,
			ja = 10.5
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
				arg_207_0:Play416011051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1033"]) and arg_207_1.var_.actorSpriteComps1033 == nil then
				arg_207_1.var_.actorSpriteComps1033 = arg_207_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_0 = 0.125

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1033"]) then
				if arg_207_1.var_.actorSpriteComps1033 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1033"]) and arg_207_1.var_.actorSpriteComps1033 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_210_3 then
						iter_210_3.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_207_1.var_.actorSpriteComps1033 = nil
			end

			local var_210_2 = arg_207_1.actors_["1148"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps1148 == nil then
				arg_207_1.var_.actorSpriteComps1148 = var_210_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_3 = 0.125

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 and not isNil(var_210_2) then
				if arg_207_1.var_.actorSpriteComps1148 then
					for iter_210_4, iter_210_5 in pairs(arg_207_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps1148 then
				for iter_210_6, iter_210_7 in pairs(arg_207_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_210_7 then
						iter_210_7.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_207_1.var_.actorSpriteComps1148 = nil
			end

			local var_210_5 = arg_207_1.actors_["1033"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1033 = var_210_5.localPosition
				var_210_5.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("1033", 2)

				for iter_210_8 = 0, var_210_5.childCount - 1 do
					local var_210_6 = var_210_5:GetChild(iter_210_8)

					if var_210_6.name == "split_6" or not string.find(var_210_6.name, "split") then
						var_210_6.gameObject:SetActive(true)
					else
						var_210_6.gameObject:SetActive(false)
					end
				end
			end

			local var_210_7 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				var_210_5.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_207_1.time_ - 0) / var_210_7)
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				var_210_5.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_210_8 = 0
			local var_210_9 = 0.625

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_10 = arg_207_1:GetWordFromCfg(416011050)
				local var_210_11 = arg_207_1:FormatText(var_210_10.content)

				arg_207_1.text_.text = var_210_11

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_13 = 25 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 25)

				if (25 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 25)) > 0 and var_210_9 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_8
					end
				end

				arg_207_1.text_.text = var_210_11
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011050", "story_v_out_416011.awb") ~= 0 then
					local var_210_14 = manager.audio:GetVoiceLength("story_v_out_416011", "416011050", "story_v_out_416011.awb") / 1000

					if var_210_14 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_14 + var_210_8
					end

					if var_210_10.prefab_name ~= "" and arg_207_1.actors_[var_210_10.prefab_name] ~= nil then
						local var_210_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_10.prefab_name].transform, "story_v_out_416011", "416011050", "story_v_out_416011.awb")

						arg_207_1:RecordAudio("416011050", var_210_15)
						arg_207_1:RecordAudio("416011050", var_210_15)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_416011", "416011050", "story_v_out_416011.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_416011", "416011050", "story_v_out_416011.awb")
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
				actorName = "1033",
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
	Play416011051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 416011051
		arg_211_1.duration_ = 5.4

		local var_211_0 = {
			zh = 5.4,
			ja = 5.066
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
				arg_211_0:Play416011052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1033"]) and arg_211_1.var_.actorSpriteComps1033 == nil then
				arg_211_1.var_.actorSpriteComps1033 = arg_211_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_0 = 0.125

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1033"]) then
				if arg_211_1.var_.actorSpriteComps1033 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								iter_214_1.color = Color.New(Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor2.r, (arg_211_1.time_ - 0) / var_214_0), Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor2.g, (arg_211_1.time_ - 0) / var_214_0), (Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor2.b, (arg_211_1.time_ - 0) / var_214_0)))
							else
								local var_214_1 = Mathf.Lerp(iter_214_1.color.r, 0.5, (arg_211_1.time_ - 0) / var_214_0)

								iter_214_1.color = Color.New(var_214_1, var_214_1, var_214_1)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1033"]) and arg_211_1.var_.actorSpriteComps1033 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_214_3 then
						iter_214_3.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_211_1.var_.actorSpriteComps1033 = nil
			end

			local var_214_2 = arg_211_1.actors_["1148"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.actorSpriteComps1148 == nil then
				arg_211_1.var_.actorSpriteComps1148 = var_214_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_3 = 0.125

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_3 and not isNil(var_214_2) then
				if arg_211_1.var_.actorSpriteComps1148 then
					for iter_214_4, iter_214_5 in pairs(arg_211_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_214_5 then
							if arg_211_1.isInRecall_ then
								iter_214_5.color = Color.New(Mathf.Lerp(iter_214_5.color.r, arg_211_1.hightColor1.r, (arg_211_1.time_ - 0) / var_214_3), Mathf.Lerp(iter_214_5.color.g, arg_211_1.hightColor1.g, (arg_211_1.time_ - 0) / var_214_3), (Mathf.Lerp(iter_214_5.color.b, arg_211_1.hightColor1.b, (arg_211_1.time_ - 0) / var_214_3)))
							else
								local var_214_4 = Mathf.Lerp(iter_214_5.color.r, 1, (arg_211_1.time_ - 0) / var_214_3)

								iter_214_5.color = Color.New(var_214_4, var_214_4, var_214_4)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_3 and arg_211_1.time_ < 0 + var_214_3 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.actorSpriteComps1148 then
				for iter_214_6, iter_214_7 in pairs(arg_211_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_214_7 then
						iter_214_7.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_211_1.var_.actorSpriteComps1148 = nil
			end

			local var_214_5 = 0
			local var_214_6 = 0.525

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
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

				local var_214_7 = arg_211_1:GetWordFromCfg(416011051)
				local var_214_8 = arg_211_1:FormatText(var_214_7.content)

				arg_211_1.text_.text = var_214_8

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_10 = 21 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_8) / 21)

				if (21 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_8) / 21)) > 0 and var_214_6 < var_214_10 then
					arg_211_1.talkMaxDuration = var_214_10

					if var_214_10 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_5
					end
				end

				arg_211_1.text_.text = var_214_8
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011051", "story_v_out_416011.awb") ~= 0 then
					local var_214_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011051", "story_v_out_416011.awb") / 1000

					if var_214_11 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_5
					end

					if var_214_7.prefab_name ~= "" and arg_211_1.actors_[var_214_7.prefab_name] ~= nil then
						local var_214_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_7.prefab_name].transform, "story_v_out_416011", "416011051", "story_v_out_416011.awb")

						arg_211_1:RecordAudio("416011051", var_214_12)
						arg_211_1:RecordAudio("416011051", var_214_12)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_416011", "416011051", "story_v_out_416011.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_416011", "416011051", "story_v_out_416011.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_13 = math.max(var_214_6, arg_211_1.talkMaxDuration)

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_13 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_5) / var_214_13

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_5 + var_214_13 and arg_211_1.time_ < var_214_5 + var_214_13 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play416011052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 416011052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play416011053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1033 = arg_215_1.actors_["1033"].transform.localPosition
				arg_215_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1033", 7)

				for iter_218_0 = 0, arg_215_1.actors_["1033"].transform.childCount - 1 do
					local var_218_0 = arg_215_1.actors_["1033"].transform:GetChild(iter_218_0)

					if var_218_0.name == "" or not string.find(var_218_0.name, "split") then
						var_218_0.gameObject:SetActive(true)
					else
						var_218_0.gameObject:SetActive(false)
					end
				end
			end

			local var_218_1 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_1 then
				arg_215_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_215_1.time_ - 0) / var_218_1)
			end

			if arg_215_1.time_ >= 0 + var_218_1 and arg_215_1.time_ < 0 + var_218_1 + arg_218_0 then
				arg_215_1.actors_["1033"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_218_2 = arg_215_1.actors_["1148"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1148 = var_218_2.localPosition
				var_218_2.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1148", 7)

				for iter_218_1 = 0, var_218_2.childCount - 1 do
					local var_218_3 = var_218_2:GetChild(iter_218_1)

					if var_218_3.name == "" or not string.find(var_218_3.name, "split") then
						var_218_3.gameObject:SetActive(true)
					else
						var_218_3.gameObject:SetActive(false)
					end
				end
			end

			local var_218_4 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				var_218_2.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_215_1.time_ - 0) / var_218_4)
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				var_218_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_218_5 = 0
			local var_218_6 = 1.475

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_7 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(416011052).content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 59 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_7) / 59)

				if (59 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_7) / 59)) > 0 and var_218_6 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_5
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_6, arg_215_1.talkMaxDuration)

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_5) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_5 + var_218_10 and arg_215_1.time_ < var_218_5 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
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
	Play416011053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 416011053
		arg_219_1.duration_ = 10.9

		local var_219_0 = {
			zh = 8.233,
			ja = 10.9
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
				arg_219_0:Play416011054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1148 = arg_219_1.actors_["1148"].transform.localPosition
				arg_219_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("1148", 3)

				for iter_222_0 = 0, arg_219_1.actors_["1148"].transform.childCount - 1 do
					local var_222_0 = arg_219_1.actors_["1148"].transform:GetChild(iter_222_0)

					if var_222_0.name == "" or not string.find(var_222_0.name, "split") then
						var_222_0.gameObject:SetActive(true)
					else
						var_222_0.gameObject:SetActive(false)
					end
				end
			end

			local var_222_1 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_1 then
				arg_219_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_219_1.time_ - 0) / var_222_1)
			end

			if arg_219_1.time_ >= 0 + var_222_1 and arg_219_1.time_ < 0 + var_222_1 + arg_222_0 then
				arg_219_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_222_2 = arg_219_1.actors_["1148"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.actorSpriteComps1148 == nil then
				arg_219_1.var_.actorSpriteComps1148 = var_222_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_3 = 0.125

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_3 and not isNil(var_222_2) then
				if arg_219_1.var_.actorSpriteComps1148 then
					for iter_222_1, iter_222_2 in pairs(arg_219_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_222_2 then
							if arg_219_1.isInRecall_ then
								iter_222_2.color = Color.New(Mathf.Lerp(iter_222_2.color.r, arg_219_1.hightColor1.r, (arg_219_1.time_ - 0) / var_222_3), Mathf.Lerp(iter_222_2.color.g, arg_219_1.hightColor1.g, (arg_219_1.time_ - 0) / var_222_3), (Mathf.Lerp(iter_222_2.color.b, arg_219_1.hightColor1.b, (arg_219_1.time_ - 0) / var_222_3)))
							else
								local var_222_4 = Mathf.Lerp(iter_222_2.color.r, 1, (arg_219_1.time_ - 0) / var_222_3)

								iter_222_2.color = Color.New(var_222_4, var_222_4, var_222_4)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= 0 + var_222_3 and arg_219_1.time_ < 0 + var_222_3 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.actorSpriteComps1148 then
				for iter_222_3, iter_222_4 in pairs(arg_219_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_222_4 then
						iter_222_4.color = arg_219_1.isInRecall_ and (arg_219_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_219_1.var_.actorSpriteComps1148 = nil
			end

			if 0.691 < arg_219_1.time_ and arg_219_1.time_ <= 0.691 + arg_222_0 then
				arg_219_1:AudioAction("play", "effect", "se_story_17", "se_story_17_door_close02", "")
			end

			local var_222_6 = 0
			local var_222_7 = 1.025

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
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

				local var_222_8 = arg_219_1:GetWordFromCfg(416011053)
				local var_222_9 = arg_219_1:FormatText(var_222_8.content)

				arg_219_1.text_.text = var_222_9

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 41 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 41)

				if (41 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 41)) > 0 and var_222_7 < var_222_11 then
					arg_219_1.talkMaxDuration = var_222_11

					if var_222_11 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_11 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_9
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011053", "story_v_out_416011.awb") ~= 0 then
					local var_222_12 = manager.audio:GetVoiceLength("story_v_out_416011", "416011053", "story_v_out_416011.awb") / 1000

					if var_222_12 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_6
					end

					if var_222_8.prefab_name ~= "" and arg_219_1.actors_[var_222_8.prefab_name] ~= nil then
						local var_222_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_8.prefab_name].transform, "story_v_out_416011", "416011053", "story_v_out_416011.awb")

						arg_219_1:RecordAudio("416011053", var_222_13)
						arg_219_1:RecordAudio("416011053", var_222_13)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_416011", "416011053", "story_v_out_416011.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_416011", "416011053", "story_v_out_416011.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_14 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_14

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_14 and arg_219_1.time_ < var_222_6 + var_222_14 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play416011054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 416011054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play416011055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1148 = arg_223_1.actors_["1148"].transform.localPosition
				arg_223_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1148", 7)

				for iter_226_0 = 0, arg_223_1.actors_["1148"].transform.childCount - 1 do
					local var_226_0 = arg_223_1.actors_["1148"].transform:GetChild(iter_226_0)

					if var_226_0.name == "" or not string.find(var_226_0.name, "split") then
						var_226_0.gameObject:SetActive(true)
					else
						var_226_0.gameObject:SetActive(false)
					end
				end
			end

			local var_226_1 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 then
				arg_223_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_223_1.time_ - 0) / var_226_1)
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 then
				arg_223_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_226_2 = 0
			local var_226_3 = 1.35

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_4 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(416011054).content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_6 = 54 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_4) / 54)

				if (54 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_4) / 54)) > 0 and var_226_3 < var_226_6 then
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

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play416011055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 416011055
		arg_227_1.duration_ = 8.67

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play416011056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if arg_227_1.bgs_.I14f == nil then
				local var_230_0 = Object.Instantiate(arg_227_1.paintGo_)

				var_230_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I14f")
				var_230_0.name = "I14f"
				var_230_0.transform.parent = arg_227_1.stage_.transform
				var_230_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.bgs_.I14f = var_230_0
			end

			if 2.03333333333333 < arg_227_1.time_ and arg_227_1.time_ <= 2.03333333333333 + arg_230_0 then
				local var_230_1 = arg_227_1.bgs_.I14f

				arg_227_1.bgs_.I14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_230_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_230_2 = var_230_1:GetComponent("SpriteRenderer")

				if var_230_2 and var_230_2.sprite then
					local var_230_3 = 2 * (var_230_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_230_1.transform.localScale = Vector3.New(var_230_3 / var_230_2.sprite.bounds.size.y < var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x and var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x or var_230_3 / var_230_2.sprite.bounds.size.y, var_230_3 / var_230_2.sprite.bounds.size.y < var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x and var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x or var_230_3 / var_230_2.sprite.bounds.size.y, 0)
				end

				for iter_230_0, iter_230_1 in pairs(arg_227_1.bgs_) do
					if iter_230_0 ~= "I14f" then
						iter_230_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_230_4 = 0

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_5 = 2.03333333333333

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

			local var_230_8 = 2.03333333333333

			if 2.03333333333333 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
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

			if 1.63333333333333 < arg_227_1.time_ and arg_227_1.time_ <= 1.63333333333333 + arg_230_0 then
				arg_227_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_aerobat", "")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_230_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_227_1.bgmTxt_.text ~= var_230_15 and arg_227_1.bgmTxt_.text ~= "" then
						if arg_227_1.bgmTxt2_.text ~= "" then
							arg_227_1.bgmTxt_.text = arg_227_1.bgmTxt2_.text
						end

						arg_227_1.bgmTxt2_.text = var_230_15

						arg_227_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_227_1.bgmTxt_.text = var_230_15
						arg_227_1.bgmTxt2_.text = var_230_15
					end

					if arg_227_1.bgmTimer then
						arg_227_1.bgmTimer:Stop()

						arg_227_1.bgmTimer = nil
					end

					if arg_227_1.settingData.show_music_name == 1 then
						arg_227_1.musicController:SetSelectedState("show")
						arg_227_1.musicAnimator_:Play("open", 0, 0)

						if arg_227_1.settingData.music_time ~= 0 then
							arg_227_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_227_1.settingData.music_time), function()
								if arg_227_1 == nil or isNil(arg_227_1.bgmTxt_) then
									return
								end

								arg_227_1.musicController:SetSelectedState("hide")
								arg_227_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.33333333333333 < arg_227_1.time_ and arg_227_1.time_ <= 1.33333333333333 + arg_230_0 then
				arg_227_1:AudioAction("play", "music", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village.awb")

				local var_230_18 = manager.audio:GetAudioName("bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village")

				if "" ~= "" then
					if arg_227_1.bgmTxt_.text ~= var_230_18 and arg_227_1.bgmTxt_.text ~= "" then
						if arg_227_1.bgmTxt2_.text ~= "" then
							arg_227_1.bgmTxt_.text = arg_227_1.bgmTxt2_.text
						end

						arg_227_1.bgmTxt2_.text = var_230_18

						arg_227_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_227_1.bgmTxt_.text = var_230_18
						arg_227_1.bgmTxt2_.text = var_230_18
					end

					if arg_227_1.bgmTimer then
						arg_227_1.bgmTimer:Stop()

						arg_227_1.bgmTimer = nil
					end

					if arg_227_1.settingData.show_music_name == 1 then
						arg_227_1.musicController:SetSelectedState("show")
						arg_227_1.musicAnimator_:Play("open", 0, 0)

						if arg_227_1.settingData.music_time ~= 0 then
							arg_227_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_227_1.settingData.music_time), function()
								if arg_227_1 == nil or isNil(arg_227_1.bgmTxt_) then
									return
								end

								arg_227_1.musicController:SetSelectedState("hide")
								arg_227_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_227_1.frameCnt_ <= 1 then
				arg_227_1.dialog_:SetActive(false)
			end

			local var_230_19 = 3.66666666666667
			local var_230_20 = 1.675

			if 3.66666666666667 < arg_227_1.time_ and arg_227_1.time_ <= var_230_19 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				arg_227_1.dialog_:SetActive(true)

				arg_227_1.dialogCg_.alpha = 0

				local var_230_21 = LeanTween.value(arg_227_1.dialog_, 0, 1, 0.3)

				var_230_21:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_227_1.dialogCg_.alpha = arg_233_0
				end))
				var_230_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_227_1.dialog_)
					var_230_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_227_1.duration_ = arg_227_1.duration_ + 0.3

				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_22 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(416011055).content)

				arg_227_1.text_.text = var_230_22

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_24 = 67 <= 0 and var_230_20 or var_230_20 * (utf8.len(var_230_22) / 67)

				if (67 <= 0 and var_230_20 or var_230_20 * (utf8.len(var_230_22) / 67)) > 0 and var_230_20 < var_230_24 then
					arg_227_1.talkMaxDuration = var_230_24
					var_230_19 = var_230_19 + 0.3

					if var_230_24 + var_230_19 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_24 + var_230_19
					end
				end

				arg_227_1.text_.text = var_230_22
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_25 = var_230_19 + 0.3
			local var_230_26 = math.max(var_230_20, arg_227_1.talkMaxDuration)

			if var_230_19 + 0.3 <= arg_227_1.time_ and arg_227_1.time_ < var_230_25 + var_230_26 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_25) / var_230_26

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_25 + var_230_26 and arg_227_1.time_ < var_230_25 + var_230_26 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play416011056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416011056
		arg_235_1.duration_ = 4.1

		local var_235_0 = {
			zh = 2.2,
			ja = 4.1
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
				arg_235_0:Play416011057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				if arg_235_1.var_.effect1055 then
					Object.Destroy(arg_235_1.var_.effect1055)

					arg_235_1.var_.effect1055 = nil
				end
			end

			if 0.25 < arg_235_1.time_ and arg_235_1.time_ <= 0.25 + arg_238_0 then
				arg_235_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_aerobat", "")
			end

			local var_238_2 = 0
			local var_238_3 = 0.25

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_6")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_4 = arg_235_1:GetWordFromCfg(416011056)
				local var_238_5 = arg_235_1:FormatText(var_238_4.content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 10 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 10)

				if (10 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 10)) > 0 and var_238_3 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_2
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011056", "story_v_out_416011.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011056", "story_v_out_416011.awb") / 1000

					if var_238_8 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_2
					end

					if var_238_4.prefab_name ~= "" and arg_235_1.actors_[var_238_4.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_4.prefab_name].transform, "story_v_out_416011", "416011056", "story_v_out_416011.awb")

						arg_235_1:RecordAudio("416011056", var_238_9)
						arg_235_1:RecordAudio("416011056", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_416011", "416011056", "story_v_out_416011.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_416011", "416011056", "story_v_out_416011.awb")
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
	Play416011057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416011057
		arg_239_1.duration_ = 6.67

		local var_239_0 = {
			zh = 3.266,
			ja = 6.666
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
				arg_239_0:Play416011058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.35

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_1 = arg_239_1:GetWordFromCfg(416011057)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 14 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 14)

				if (14 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 14)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011057", "story_v_out_416011.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_416011", "416011057", "story_v_out_416011.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_416011", "416011057", "story_v_out_416011.awb")

						arg_239_1:RecordAudio("416011057", var_242_6)
						arg_239_1:RecordAudio("416011057", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_416011", "416011057", "story_v_out_416011.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_416011", "416011057", "story_v_out_416011.awb")
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
	Play416011058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 416011058
		arg_243_1.duration_ = 11.6

		local var_243_0 = {
			zh = 9.233,
			ja = 11.6
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
				arg_243_0:Play416011059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:AudioAction("play", "effect", "se_story_138", "se_story_138_engine", "")
			end

			local var_246_1 = 0
			local var_246_2 = 0.675

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_6")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:GetWordFromCfg(416011058)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_6 = 27 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_4) / 27)

				if (27 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_4) / 27)) > 0 and var_246_2 < var_246_6 then
					arg_243_1.talkMaxDuration = var_246_6

					if var_246_6 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011058", "story_v_out_416011.awb") ~= 0 then
					local var_246_7 = manager.audio:GetVoiceLength("story_v_out_416011", "416011058", "story_v_out_416011.awb") / 1000

					if var_246_7 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_1
					end

					if var_246_3.prefab_name ~= "" and arg_243_1.actors_[var_246_3.prefab_name] ~= nil then
						local var_246_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_3.prefab_name].transform, "story_v_out_416011", "416011058", "story_v_out_416011.awb")

						arg_243_1:RecordAudio("416011058", var_246_8)
						arg_243_1:RecordAudio("416011058", var_246_8)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_416011", "416011058", "story_v_out_416011.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_416011", "416011058", "story_v_out_416011.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_9 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_9 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_9

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_9 and arg_243_1.time_ < var_246_1 + var_246_9 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play416011059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 416011059
		arg_247_1.duration_ = 3.6

		local var_247_0 = {
			zh = 3.066,
			ja = 3.6
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
				arg_247_0:Play416011060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if arg_247_1.actors_["10121"] == nil then
				local var_250_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10121")

				if not isNil(var_250_0) then
					local var_250_1 = Object.Instantiate(var_250_0, arg_247_1.canvasGo_.transform)

					var_250_1.transform:SetSiblingIndex(1)

					var_250_1.name = "10121"
					var_250_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_247_1.actors_["10121"] = var_250_1

					if arg_247_1.isInRecall_ then
						for iter_250_0, iter_250_1 in ipairs((var_250_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_250_1.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_250_2 = arg_247_1.actors_["10121"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10121 = var_250_2.localPosition
				var_250_2.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10121", 3)

				for iter_250_2 = 0, var_250_2.childCount - 1 do
					local var_250_3 = var_250_2:GetChild(iter_250_2)

					if var_250_3.name == "" or not string.find(var_250_3.name, "split") then
						var_250_3.gameObject:SetActive(true)
					else
						var_250_3.gameObject:SetActive(false)
					end
				end
			end

			local var_250_4 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				var_250_2.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10121, Vector3.New(0, -260.5, -275), (arg_247_1.time_ - 0) / var_250_4)
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				var_250_2.localPosition = Vector3.New(0, -260.5, -275)
			end

			local var_250_5 = arg_247_1.actors_["10121"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_5) and arg_247_1.var_.actorSpriteComps10121 == nil then
				arg_247_1.var_.actorSpriteComps10121 = var_250_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_6 = 2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_6 and not isNil(var_250_5) then
				if arg_247_1.var_.actorSpriteComps10121 then
					for iter_250_3, iter_250_4 in pairs(arg_247_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_250_4 then
							if arg_247_1.isInRecall_ then
								iter_250_4.color = Color.New(Mathf.Lerp(iter_250_4.color.r, arg_247_1.hightColor1.r, (arg_247_1.time_ - 0) / var_250_6), Mathf.Lerp(iter_250_4.color.g, arg_247_1.hightColor1.g, (arg_247_1.time_ - 0) / var_250_6), (Mathf.Lerp(iter_250_4.color.b, arg_247_1.hightColor1.b, (arg_247_1.time_ - 0) / var_250_6)))
							else
								local var_250_7 = Mathf.Lerp(iter_250_4.color.r, 1, (arg_247_1.time_ - 0) / var_250_6)

								iter_250_4.color = Color.New(var_250_7, var_250_7, var_250_7)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_6 and arg_247_1.time_ < 0 + var_250_6 + arg_250_0 and not isNil(var_250_5) and arg_247_1.var_.actorSpriteComps10121 then
				for iter_250_5, iter_250_6 in pairs(arg_247_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_250_6 then
						iter_250_6.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_247_1.var_.actorSpriteComps10121 = nil
			end

			local var_250_8 = 0
			local var_250_9 = 0.375

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1081].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_10 = arg_247_1:GetWordFromCfg(416011059)
				local var_250_11 = arg_247_1:FormatText(var_250_10.content)

				arg_247_1.text_.text = var_250_11

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_13 = 15 <= 0 and var_250_9 or var_250_9 * (utf8.len(var_250_11) / 15)

				if (15 <= 0 and var_250_9 or var_250_9 * (utf8.len(var_250_11) / 15)) > 0 and var_250_9 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13

					if var_250_13 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_8
					end
				end

				arg_247_1.text_.text = var_250_11
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011059", "story_v_out_416011.awb") ~= 0 then
					local var_250_14 = manager.audio:GetVoiceLength("story_v_out_416011", "416011059", "story_v_out_416011.awb") / 1000

					if var_250_14 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_14 + var_250_8
					end

					if var_250_10.prefab_name ~= "" and arg_247_1.actors_[var_250_10.prefab_name] ~= nil then
						local var_250_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_10.prefab_name].transform, "story_v_out_416011", "416011059", "story_v_out_416011.awb")

						arg_247_1:RecordAudio("416011059", var_250_15)
						arg_247_1:RecordAudio("416011059", var_250_15)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_416011", "416011059", "story_v_out_416011.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_416011", "416011059", "story_v_out_416011.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_16 = math.max(var_250_9, arg_247_1.talkMaxDuration)

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_16 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_8) / var_250_16

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_8 + var_250_16 and arg_247_1.time_ < var_250_8 + var_250_16 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10121",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play416011060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 416011060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play416011061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["10121"]) and arg_251_1.var_.actorSpriteComps10121 == nil then
				arg_251_1.var_.actorSpriteComps10121 = arg_251_1.actors_["10121"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_0 = 2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["10121"]) then
				if arg_251_1.var_.actorSpriteComps10121 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								iter_254_1.color = Color.New(Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor2.r, (arg_251_1.time_ - 0) / var_254_0), Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor2.g, (arg_251_1.time_ - 0) / var_254_0), (Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor2.b, (arg_251_1.time_ - 0) / var_254_0)))
							else
								local var_254_1 = Mathf.Lerp(iter_254_1.color.r, 0.5, (arg_251_1.time_ - 0) / var_254_0)

								iter_254_1.color = Color.New(var_254_1, var_254_1, var_254_1)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["10121"]) and arg_251_1.var_.actorSpriteComps10121 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_254_3 then
						iter_254_3.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_251_1.var_.actorSpriteComps10121 = nil
			end

			local var_254_2 = 0
			local var_254_3 = 1.7

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

				local var_254_4 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(416011060).content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_6 = 68 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_4) / 68)

				if (68 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_4) / 68)) > 0 and var_254_3 < var_254_6 then
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
	Play416011061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 416011061
		arg_255_1.duration_ = 10.13

		local var_255_0 = {
			zh = 6.166,
			ja = 10.133
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
				arg_255_0:Play416011062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if arg_255_1.actors_["1028"] == nil then
				local var_258_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_258_0) then
					local var_258_1 = Object.Instantiate(var_258_0, arg_255_1.canvasGo_.transform)

					var_258_1.transform:SetSiblingIndex(1)

					var_258_1.name = "1028"
					var_258_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_255_1.actors_["1028"] = var_258_1

					if arg_255_1.isInRecall_ then
						for iter_258_0, iter_258_1 in ipairs((var_258_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_258_1.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_258_2 = arg_255_1.actors_["1028"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1028 = var_258_2.localPosition
				var_258_2.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("1028", 4)

				for iter_258_2 = 0, var_258_2.childCount - 1 do
					local var_258_3 = var_258_2:GetChild(iter_258_2)

					if var_258_3.name == "split_2" or not string.find(var_258_3.name, "split") then
						var_258_3.gameObject:SetActive(true)
					else
						var_258_3.gameObject:SetActive(false)
					end
				end
			end

			local var_258_4 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 then
				var_258_2.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_255_1.time_ - 0) / var_258_4)
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 then
				var_258_2.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_258_5 = arg_255_1.actors_["1028"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_5) and arg_255_1.var_.actorSpriteComps1028 == nil then
				arg_255_1.var_.actorSpriteComps1028 = var_258_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_6 = 0.125

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_6 and not isNil(var_258_5) then
				if arg_255_1.var_.actorSpriteComps1028 then
					for iter_258_3, iter_258_4 in pairs(arg_255_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_258_4 then
							if arg_255_1.isInRecall_ then
								iter_258_4.color = Color.New(Mathf.Lerp(iter_258_4.color.r, arg_255_1.hightColor1.r, (arg_255_1.time_ - 0) / var_258_6), Mathf.Lerp(iter_258_4.color.g, arg_255_1.hightColor1.g, (arg_255_1.time_ - 0) / var_258_6), (Mathf.Lerp(iter_258_4.color.b, arg_255_1.hightColor1.b, (arg_255_1.time_ - 0) / var_258_6)))
							else
								local var_258_7 = Mathf.Lerp(iter_258_4.color.r, 1, (arg_255_1.time_ - 0) / var_258_6)

								iter_258_4.color = Color.New(var_258_7, var_258_7, var_258_7)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_6 and arg_255_1.time_ < 0 + var_258_6 + arg_258_0 and not isNil(var_258_5) and arg_255_1.var_.actorSpriteComps1028 then
				for iter_258_5, iter_258_6 in pairs(arg_255_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_258_6 then
						iter_258_6.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps1028 = nil
			end

			local var_258_8 = arg_255_1.actors_["10121"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos10121 = var_258_8.localPosition
				var_258_8.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("10121", 2)

				for iter_258_7 = 0, var_258_8.childCount - 1 do
					local var_258_9 = var_258_8:GetChild(iter_258_7)

					if var_258_9.name == "" or not string.find(var_258_9.name, "split") then
						var_258_9.gameObject:SetActive(true)
					else
						var_258_9.gameObject:SetActive(false)
					end
				end
			end

			local var_258_10 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_10 then
				var_258_8.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10121, Vector3.New(-390, -260.5, -275), (arg_255_1.time_ - 0) / var_258_10)
			end

			if arg_255_1.time_ >= 0 + var_258_10 and arg_255_1.time_ < 0 + var_258_10 + arg_258_0 then
				var_258_8.localPosition = Vector3.New(-390, -260.5, -275)
			end

			local var_258_11 = arg_255_1.actors_["10121"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_11) and arg_255_1.var_.actorSpriteComps10121 == nil then
				arg_255_1.var_.actorSpriteComps10121 = var_258_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_12 = 2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_12 and not isNil(var_258_11) then
				if arg_255_1.var_.actorSpriteComps10121 then
					for iter_258_8, iter_258_9 in pairs(arg_255_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_258_9 then
							if arg_255_1.isInRecall_ then
								iter_258_9.color = Color.New(Mathf.Lerp(iter_258_9.color.r, arg_255_1.hightColor2.r, (arg_255_1.time_ - 0) / var_258_12), Mathf.Lerp(iter_258_9.color.g, arg_255_1.hightColor2.g, (arg_255_1.time_ - 0) / var_258_12), (Mathf.Lerp(iter_258_9.color.b, arg_255_1.hightColor2.b, (arg_255_1.time_ - 0) / var_258_12)))
							else
								local var_258_13 = Mathf.Lerp(iter_258_9.color.r, 0.5, (arg_255_1.time_ - 0) / var_258_12)

								iter_258_9.color = Color.New(var_258_13, var_258_13, var_258_13)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_12 and arg_255_1.time_ < 0 + var_258_12 + arg_258_0 and not isNil(var_258_11) and arg_255_1.var_.actorSpriteComps10121 then
				for iter_258_10, iter_258_11 in pairs(arg_255_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_258_11 then
						iter_258_11.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_255_1.var_.actorSpriteComps10121 = nil
			end

			local var_258_14 = 0
			local var_258_15 = 0.725

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_14 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_16 = arg_255_1:GetWordFromCfg(416011061)
				local var_258_17 = arg_255_1:FormatText(var_258_16.content)

				arg_255_1.text_.text = var_258_17

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_19 = 29 <= 0 and var_258_15 or var_258_15 * (utf8.len(var_258_17) / 29)

				if (29 <= 0 and var_258_15 or var_258_15 * (utf8.len(var_258_17) / 29)) > 0 and var_258_15 < var_258_19 then
					arg_255_1.talkMaxDuration = var_258_19

					if var_258_19 + var_258_14 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_19 + var_258_14
					end
				end

				arg_255_1.text_.text = var_258_17
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011061", "story_v_out_416011.awb") ~= 0 then
					local var_258_20 = manager.audio:GetVoiceLength("story_v_out_416011", "416011061", "story_v_out_416011.awb") / 1000

					if var_258_20 + var_258_14 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_20 + var_258_14
					end

					if var_258_16.prefab_name ~= "" and arg_255_1.actors_[var_258_16.prefab_name] ~= nil then
						local var_258_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_16.prefab_name].transform, "story_v_out_416011", "416011061", "story_v_out_416011.awb")

						arg_255_1:RecordAudio("416011061", var_258_21)
						arg_255_1:RecordAudio("416011061", var_258_21)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_416011", "416011061", "story_v_out_416011.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_416011", "416011061", "story_v_out_416011.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_22 = math.max(var_258_15, arg_255_1.talkMaxDuration)

			if var_258_14 <= arg_255_1.time_ and arg_255_1.time_ < var_258_14 + var_258_22 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_14) / var_258_22

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_14 + var_258_22 and arg_255_1.time_ < var_258_14 + var_258_22 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10121",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play416011062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 416011062
		arg_259_1.duration_ = 5.17

		local var_259_0 = {
			zh = 3.7,
			ja = 5.166
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
				arg_259_0:Play416011063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1028"]) and arg_259_1.var_.actorSpriteComps1028 == nil then
				arg_259_1.var_.actorSpriteComps1028 = arg_259_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_0 = 0.125

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1028"]) then
				if arg_259_1.var_.actorSpriteComps1028 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								iter_262_1.color = Color.New(Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor2.r, (arg_259_1.time_ - 0) / var_262_0), Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor2.g, (arg_259_1.time_ - 0) / var_262_0), (Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor2.b, (arg_259_1.time_ - 0) / var_262_0)))
							else
								local var_262_1 = Mathf.Lerp(iter_262_1.color.r, 0.5, (arg_259_1.time_ - 0) / var_262_0)

								iter_262_1.color = Color.New(var_262_1, var_262_1, var_262_1)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1028"]) and arg_259_1.var_.actorSpriteComps1028 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_262_3 then
						iter_262_3.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_259_1.var_.actorSpriteComps1028 = nil
			end

			local var_262_2 = arg_259_1.actors_["10121"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.actorSpriteComps10121 == nil then
				arg_259_1.var_.actorSpriteComps10121 = var_262_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_3 = 0.125

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_3 and not isNil(var_262_2) then
				if arg_259_1.var_.actorSpriteComps10121 then
					for iter_262_4, iter_262_5 in pairs(arg_259_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_262_5 then
							if arg_259_1.isInRecall_ then
								iter_262_5.color = Color.New(Mathf.Lerp(iter_262_5.color.r, arg_259_1.hightColor1.r, (arg_259_1.time_ - 0) / var_262_3), Mathf.Lerp(iter_262_5.color.g, arg_259_1.hightColor1.g, (arg_259_1.time_ - 0) / var_262_3), (Mathf.Lerp(iter_262_5.color.b, arg_259_1.hightColor1.b, (arg_259_1.time_ - 0) / var_262_3)))
							else
								local var_262_4 = Mathf.Lerp(iter_262_5.color.r, 1, (arg_259_1.time_ - 0) / var_262_3)

								iter_262_5.color = Color.New(var_262_4, var_262_4, var_262_4)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_3 and arg_259_1.time_ < 0 + var_262_3 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.actorSpriteComps10121 then
				for iter_262_6, iter_262_7 in pairs(arg_259_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_262_7 then
						iter_262_7.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_259_1.var_.actorSpriteComps10121 = nil
			end

			local var_262_5 = 0
			local var_262_6 = 0.4

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[1081].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_7 = arg_259_1:GetWordFromCfg(416011062)
				local var_262_8 = arg_259_1:FormatText(var_262_7.content)

				arg_259_1.text_.text = var_262_8

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_10 = 16 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 16)

				if (16 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 16)) > 0 and var_262_6 < var_262_10 then
					arg_259_1.talkMaxDuration = var_262_10

					if var_262_10 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_5
					end
				end

				arg_259_1.text_.text = var_262_8
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011062", "story_v_out_416011.awb") ~= 0 then
					local var_262_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011062", "story_v_out_416011.awb") / 1000

					if var_262_11 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_11 + var_262_5
					end

					if var_262_7.prefab_name ~= "" and arg_259_1.actors_[var_262_7.prefab_name] ~= nil then
						local var_262_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_7.prefab_name].transform, "story_v_out_416011", "416011062", "story_v_out_416011.awb")

						arg_259_1:RecordAudio("416011062", var_262_12)
						arg_259_1:RecordAudio("416011062", var_262_12)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_416011", "416011062", "story_v_out_416011.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_416011", "416011062", "story_v_out_416011.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_13 = math.max(var_262_6, arg_259_1.talkMaxDuration)

			if var_262_5 <= arg_259_1.time_ and arg_259_1.time_ < var_262_5 + var_262_13 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_5) / var_262_13

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_5 + var_262_13 and arg_259_1.time_ < var_262_5 + var_262_13 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play416011063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 416011063
		arg_263_1.duration_ = 6.5

		local var_263_0 = {
			zh = 3.8,
			ja = 6.5
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
				arg_263_0:Play416011064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1028"]) and arg_263_1.var_.actorSpriteComps1028 == nil then
				arg_263_1.var_.actorSpriteComps1028 = arg_263_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_0 = 0.125

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1028"]) then
				if arg_263_1.var_.actorSpriteComps1028 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								iter_266_1.color = Color.New(Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor1.r, (arg_263_1.time_ - 0) / var_266_0), Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor1.g, (arg_263_1.time_ - 0) / var_266_0), (Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor1.b, (arg_263_1.time_ - 0) / var_266_0)))
							else
								local var_266_1 = Mathf.Lerp(iter_266_1.color.r, 1, (arg_263_1.time_ - 0) / var_266_0)

								iter_266_1.color = Color.New(var_266_1, var_266_1, var_266_1)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1028"]) and arg_263_1.var_.actorSpriteComps1028 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_266_3 then
						iter_266_3.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_263_1.var_.actorSpriteComps1028 = nil
			end

			local var_266_2 = arg_263_1.actors_["10121"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_2) and arg_263_1.var_.actorSpriteComps10121 == nil then
				arg_263_1.var_.actorSpriteComps10121 = var_266_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_3 = 0.125

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_3 and not isNil(var_266_2) then
				if arg_263_1.var_.actorSpriteComps10121 then
					for iter_266_4, iter_266_5 in pairs(arg_263_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_266_5 then
							if arg_263_1.isInRecall_ then
								iter_266_5.color = Color.New(Mathf.Lerp(iter_266_5.color.r, arg_263_1.hightColor2.r, (arg_263_1.time_ - 0) / var_266_3), Mathf.Lerp(iter_266_5.color.g, arg_263_1.hightColor2.g, (arg_263_1.time_ - 0) / var_266_3), (Mathf.Lerp(iter_266_5.color.b, arg_263_1.hightColor2.b, (arg_263_1.time_ - 0) / var_266_3)))
							else
								local var_266_4 = Mathf.Lerp(iter_266_5.color.r, 0.5, (arg_263_1.time_ - 0) / var_266_3)

								iter_266_5.color = Color.New(var_266_4, var_266_4, var_266_4)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_3 and arg_263_1.time_ < 0 + var_266_3 + arg_266_0 and not isNil(var_266_2) and arg_263_1.var_.actorSpriteComps10121 then
				for iter_266_6, iter_266_7 in pairs(arg_263_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_266_7 then
						iter_266_7.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_263_1.var_.actorSpriteComps10121 = nil
			end

			local var_266_5 = 0
			local var_266_6 = 0.45

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_5 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_7 = arg_263_1:GetWordFromCfg(416011063)
				local var_266_8 = arg_263_1:FormatText(var_266_7.content)

				arg_263_1.text_.text = var_266_8

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_10 = 18 <= 0 and var_266_6 or var_266_6 * (utf8.len(var_266_8) / 18)

				if (18 <= 0 and var_266_6 or var_266_6 * (utf8.len(var_266_8) / 18)) > 0 and var_266_6 < var_266_10 then
					arg_263_1.talkMaxDuration = var_266_10

					if var_266_10 + var_266_5 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_5
					end
				end

				arg_263_1.text_.text = var_266_8
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011063", "story_v_out_416011.awb") ~= 0 then
					local var_266_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011063", "story_v_out_416011.awb") / 1000

					if var_266_11 + var_266_5 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_5
					end

					if var_266_7.prefab_name ~= "" and arg_263_1.actors_[var_266_7.prefab_name] ~= nil then
						local var_266_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_7.prefab_name].transform, "story_v_out_416011", "416011063", "story_v_out_416011.awb")

						arg_263_1:RecordAudio("416011063", var_266_12)
						arg_263_1:RecordAudio("416011063", var_266_12)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_416011", "416011063", "story_v_out_416011.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_416011", "416011063", "story_v_out_416011.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_13 = math.max(var_266_6, arg_263_1.talkMaxDuration)

			if var_266_5 <= arg_263_1.time_ and arg_263_1.time_ < var_266_5 + var_266_13 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_5) / var_266_13

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_5 + var_266_13 and arg_263_1.time_ < var_266_5 + var_266_13 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play416011064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 416011064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play416011065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1028"]) and arg_267_1.var_.actorSpriteComps1028 == nil then
				arg_267_1.var_.actorSpriteComps1028 = arg_267_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_0 = 0.125

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1028"]) then
				if arg_267_1.var_.actorSpriteComps1028 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								iter_270_1.color = Color.New(Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor2.r, (arg_267_1.time_ - 0) / var_270_0), Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor2.g, (arg_267_1.time_ - 0) / var_270_0), (Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor2.b, (arg_267_1.time_ - 0) / var_270_0)))
							else
								local var_270_1 = Mathf.Lerp(iter_270_1.color.r, 0.5, (arg_267_1.time_ - 0) / var_270_0)

								iter_270_1.color = Color.New(var_270_1, var_270_1, var_270_1)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1028"]) and arg_267_1.var_.actorSpriteComps1028 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_270_3 then
						iter_270_3.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_267_1.var_.actorSpriteComps1028 = nil
			end

			local var_270_2 = 0
			local var_270_3 = 1.525

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_2 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_4 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(416011064).content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_6 = 61 <= 0 and var_270_3 or var_270_3 * (utf8.len(var_270_4) / 61)

				if (61 <= 0 and var_270_3 or var_270_3 * (utf8.len(var_270_4) / 61)) > 0 and var_270_3 < var_270_6 then
					arg_267_1.talkMaxDuration = var_270_6

					if var_270_6 + var_270_2 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_6 + var_270_2
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_3, arg_267_1.talkMaxDuration)

			if var_270_2 <= arg_267_1.time_ and arg_267_1.time_ < var_270_2 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_2) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_2 + var_270_7 and arg_267_1.time_ < var_270_2 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play416011065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 416011065
		arg_271_1.duration_ = 11.9

		local var_271_0 = {
			zh = 6.466,
			ja = 11.9
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
				arg_271_0:Play416011066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1028"]) and arg_271_1.var_.actorSpriteComps1028 == nil then
				arg_271_1.var_.actorSpriteComps1028 = arg_271_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_0 = 0.125

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1028"]) then
				if arg_271_1.var_.actorSpriteComps1028 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								iter_274_1.color = Color.New(Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor2.r, (arg_271_1.time_ - 0) / var_274_0), Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor2.g, (arg_271_1.time_ - 0) / var_274_0), (Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor2.b, (arg_271_1.time_ - 0) / var_274_0)))
							else
								local var_274_1 = Mathf.Lerp(iter_274_1.color.r, 0.5, (arg_271_1.time_ - 0) / var_274_0)

								iter_274_1.color = Color.New(var_274_1, var_274_1, var_274_1)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1028"]) and arg_271_1.var_.actorSpriteComps1028 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_274_3 then
						iter_274_3.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_271_1.var_.actorSpriteComps1028 = nil
			end

			local var_274_2 = arg_271_1.actors_["10121"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps10121 == nil then
				arg_271_1.var_.actorSpriteComps10121 = var_274_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_3 = 0.125

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_3 and not isNil(var_274_2) then
				if arg_271_1.var_.actorSpriteComps10121 then
					for iter_274_4, iter_274_5 in pairs(arg_271_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_274_5 then
							if arg_271_1.isInRecall_ then
								iter_274_5.color = Color.New(Mathf.Lerp(iter_274_5.color.r, arg_271_1.hightColor1.r, (arg_271_1.time_ - 0) / var_274_3), Mathf.Lerp(iter_274_5.color.g, arg_271_1.hightColor1.g, (arg_271_1.time_ - 0) / var_274_3), (Mathf.Lerp(iter_274_5.color.b, arg_271_1.hightColor1.b, (arg_271_1.time_ - 0) / var_274_3)))
							else
								local var_274_4 = Mathf.Lerp(iter_274_5.color.r, 1, (arg_271_1.time_ - 0) / var_274_3)

								iter_274_5.color = Color.New(var_274_4, var_274_4, var_274_4)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 0 + var_274_3 and arg_271_1.time_ < 0 + var_274_3 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps10121 then
				for iter_274_6, iter_274_7 in pairs(arg_271_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_274_7 then
						iter_274_7.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_271_1.var_.actorSpriteComps10121 = nil
			end

			local var_274_5 = 0
			local var_274_6 = 0.825

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[1081].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_7 = arg_271_1:GetWordFromCfg(416011065)
				local var_274_8 = arg_271_1:FormatText(var_274_7.content)

				arg_271_1.text_.text = var_274_8

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_10 = 33 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 33)

				if (33 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 33)) > 0 and var_274_6 < var_274_10 then
					arg_271_1.talkMaxDuration = var_274_10

					if var_274_10 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_5
					end
				end

				arg_271_1.text_.text = var_274_8
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011065", "story_v_out_416011.awb") ~= 0 then
					local var_274_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011065", "story_v_out_416011.awb") / 1000

					if var_274_11 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_11 + var_274_5
					end

					if var_274_7.prefab_name ~= "" and arg_271_1.actors_[var_274_7.prefab_name] ~= nil then
						local var_274_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_7.prefab_name].transform, "story_v_out_416011", "416011065", "story_v_out_416011.awb")

						arg_271_1:RecordAudio("416011065", var_274_12)
						arg_271_1:RecordAudio("416011065", var_274_12)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_416011", "416011065", "story_v_out_416011.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_416011", "416011065", "story_v_out_416011.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_13 = math.max(var_274_6, arg_271_1.talkMaxDuration)

			if var_274_5 <= arg_271_1.time_ and arg_271_1.time_ < var_274_5 + var_274_13 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_5) / var_274_13

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_5 + var_274_13 and arg_271_1.time_ < var_274_5 + var_274_13 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play416011066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 416011066
		arg_275_1.duration_ = 5.07

		local var_275_0 = {
			zh = 1.8,
			ja = 5.066
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
				arg_275_0:Play416011067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1028"]) and arg_275_1.var_.actorSpriteComps1028 == nil then
				arg_275_1.var_.actorSpriteComps1028 = arg_275_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_0 = 0.125

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1028"]) then
				if arg_275_1.var_.actorSpriteComps1028 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								iter_278_1.color = Color.New(Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor1.r, (arg_275_1.time_ - 0) / var_278_0), Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor1.g, (arg_275_1.time_ - 0) / var_278_0), (Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor1.b, (arg_275_1.time_ - 0) / var_278_0)))
							else
								local var_278_1 = Mathf.Lerp(iter_278_1.color.r, 1, (arg_275_1.time_ - 0) / var_278_0)

								iter_278_1.color = Color.New(var_278_1, var_278_1, var_278_1)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1028"]) and arg_275_1.var_.actorSpriteComps1028 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_278_3 then
						iter_278_3.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_275_1.var_.actorSpriteComps1028 = nil
			end

			local var_278_2 = arg_275_1.actors_["10121"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.actorSpriteComps10121 == nil then
				arg_275_1.var_.actorSpriteComps10121 = var_278_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_3 = 0.125

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_3 and not isNil(var_278_2) then
				if arg_275_1.var_.actorSpriteComps10121 then
					for iter_278_4, iter_278_5 in pairs(arg_275_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_278_5 then
							if arg_275_1.isInRecall_ then
								iter_278_5.color = Color.New(Mathf.Lerp(iter_278_5.color.r, arg_275_1.hightColor2.r, (arg_275_1.time_ - 0) / var_278_3), Mathf.Lerp(iter_278_5.color.g, arg_275_1.hightColor2.g, (arg_275_1.time_ - 0) / var_278_3), (Mathf.Lerp(iter_278_5.color.b, arg_275_1.hightColor2.b, (arg_275_1.time_ - 0) / var_278_3)))
							else
								local var_278_4 = Mathf.Lerp(iter_278_5.color.r, 0.5, (arg_275_1.time_ - 0) / var_278_3)

								iter_278_5.color = Color.New(var_278_4, var_278_4, var_278_4)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_3 and arg_275_1.time_ < 0 + var_278_3 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.actorSpriteComps10121 then
				for iter_278_6, iter_278_7 in pairs(arg_275_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_278_7 then
						iter_278_7.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_275_1.var_.actorSpriteComps10121 = nil
			end

			local var_278_5 = 0
			local var_278_6 = 0.2

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_5 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_7 = arg_275_1:GetWordFromCfg(416011066)
				local var_278_8 = arg_275_1:FormatText(var_278_7.content)

				arg_275_1.text_.text = var_278_8

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_10 = 8 <= 0 and var_278_6 or var_278_6 * (utf8.len(var_278_8) / 8)

				if (8 <= 0 and var_278_6 or var_278_6 * (utf8.len(var_278_8) / 8)) > 0 and var_278_6 < var_278_10 then
					arg_275_1.talkMaxDuration = var_278_10

					if var_278_10 + var_278_5 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_5
					end
				end

				arg_275_1.text_.text = var_278_8
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011066", "story_v_out_416011.awb") ~= 0 then
					local var_278_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011066", "story_v_out_416011.awb") / 1000

					if var_278_11 + var_278_5 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_11 + var_278_5
					end

					if var_278_7.prefab_name ~= "" and arg_275_1.actors_[var_278_7.prefab_name] ~= nil then
						local var_278_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_7.prefab_name].transform, "story_v_out_416011", "416011066", "story_v_out_416011.awb")

						arg_275_1:RecordAudio("416011066", var_278_12)
						arg_275_1:RecordAudio("416011066", var_278_12)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_416011", "416011066", "story_v_out_416011.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_416011", "416011066", "story_v_out_416011.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_13 = math.max(var_278_6, arg_275_1.talkMaxDuration)

			if var_278_5 <= arg_275_1.time_ and arg_275_1.time_ < var_278_5 + var_278_13 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_5) / var_278_13

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_5 + var_278_13 and arg_275_1.time_ < var_278_5 + var_278_13 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play416011067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 416011067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play416011068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1028 = arg_279_1.actors_["1028"].transform.localPosition
				arg_279_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("1028", 7)

				for iter_282_0 = 0, arg_279_1.actors_["1028"].transform.childCount - 1 do
					local var_282_0 = arg_279_1.actors_["1028"].transform:GetChild(iter_282_0)

					if var_282_0.name == "" or not string.find(var_282_0.name, "split") then
						var_282_0.gameObject:SetActive(true)
					else
						var_282_0.gameObject:SetActive(false)
					end
				end
			end

			local var_282_1 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_1 then
				arg_279_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_279_1.time_ - 0) / var_282_1)
			end

			if arg_279_1.time_ >= 0 + var_282_1 and arg_279_1.time_ < 0 + var_282_1 + arg_282_0 then
				arg_279_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_282_2 = arg_279_1.actors_["10121"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos10121 = var_282_2.localPosition
				var_282_2.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("10121", 7)

				for iter_282_1 = 0, var_282_2.childCount - 1 do
					local var_282_3 = var_282_2:GetChild(iter_282_1)

					if var_282_3.name == "" or not string.find(var_282_3.name, "split") then
						var_282_3.gameObject:SetActive(true)
					else
						var_282_3.gameObject:SetActive(false)
					end
				end
			end

			local var_282_4 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				var_282_2.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10121, Vector3.New(0, -2000, 0), (arg_279_1.time_ - 0) / var_282_4)
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				var_282_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_282_5 = 0
			local var_282_6 = 1.9

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_7 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(416011067).content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 76 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_7) / 76)

				if (76 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_7) / 76)) > 0 and var_282_6 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_5
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_10 = math.max(var_282_6, arg_279_1.talkMaxDuration)

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_10 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_5) / var_282_10

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_5 + var_282_10 and arg_279_1.time_ < var_282_5 + var_282_10 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10121",
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
	Play416011068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 416011068
		arg_283_1.duration_ = 5.23

		local var_283_0 = {
			zh = 2.833,
			ja = 5.233
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
				arg_283_0:Play416011069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.275

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_1 = arg_283_1:GetWordFromCfg(416011068)
				local var_286_2 = arg_283_1:FormatText(var_286_1.content)

				arg_283_1.text_.text = var_286_2

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_4 = 11 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 11)

				if (11 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 11)) > 0 and var_286_0 < var_286_4 then
					arg_283_1.talkMaxDuration = var_286_4

					if var_286_4 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_4 + 0
					end
				end

				arg_283_1.text_.text = var_286_2
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011068", "story_v_out_416011.awb") ~= 0 then
					local var_286_5 = manager.audio:GetVoiceLength("story_v_out_416011", "416011068", "story_v_out_416011.awb") / 1000

					if var_286_5 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + 0
					end

					if var_286_1.prefab_name ~= "" and arg_283_1.actors_[var_286_1.prefab_name] ~= nil then
						local var_286_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_1.prefab_name].transform, "story_v_out_416011", "416011068", "story_v_out_416011.awb")

						arg_283_1:RecordAudio("416011068", var_286_6)
						arg_283_1:RecordAudio("416011068", var_286_6)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_416011", "416011068", "story_v_out_416011.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_416011", "416011068", "story_v_out_416011.awb")
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
	Play416011069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 416011069
		arg_287_1.duration_ = 4.1

		local var_287_0 = {
			zh = 4.1,
			ja = 3.533
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
				arg_287_0:Play416011070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1028"]) and arg_287_1.var_.actorSpriteComps1028 == nil then
				arg_287_1.var_.actorSpriteComps1028 = arg_287_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_0 = 0.125

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1028"]) then
				if arg_287_1.var_.actorSpriteComps1028 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								iter_290_1.color = Color.New(Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor1.r, (arg_287_1.time_ - 0) / var_290_0), Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor1.g, (arg_287_1.time_ - 0) / var_290_0), (Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor1.b, (arg_287_1.time_ - 0) / var_290_0)))
							else
								local var_290_1 = Mathf.Lerp(iter_290_1.color.r, 1, (arg_287_1.time_ - 0) / var_290_0)

								iter_290_1.color = Color.New(var_290_1, var_290_1, var_290_1)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1028"]) and arg_287_1.var_.actorSpriteComps1028 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_290_3 then
						iter_290_3.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_287_1.var_.actorSpriteComps1028 = nil
			end

			local var_290_2 = arg_287_1.actors_["1028"].transform

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1028 = var_290_2.localPosition
				var_290_2.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("1028", 3)

				for iter_290_4 = 0, var_290_2.childCount - 1 do
					local var_290_3 = var_290_2:GetChild(iter_290_4)

					if var_290_3.name == "split_6" or not string.find(var_290_3.name, "split") then
						var_290_3.gameObject:SetActive(true)
					else
						var_290_3.gameObject:SetActive(false)
					end
				end
			end

			local var_290_4 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				var_290_2.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_287_1.time_ - 0) / var_290_4)
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				var_290_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_290_5 = 0
			local var_290_6 = 0.375

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_7 = arg_287_1:GetWordFromCfg(416011069)
				local var_290_8 = arg_287_1:FormatText(var_290_7.content)

				arg_287_1.text_.text = var_290_8

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_10 = 15 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_8) / 15)

				if (15 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_8) / 15)) > 0 and var_290_6 < var_290_10 then
					arg_287_1.talkMaxDuration = var_290_10

					if var_290_10 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_5
					end
				end

				arg_287_1.text_.text = var_290_8
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011069", "story_v_out_416011.awb") ~= 0 then
					local var_290_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011069", "story_v_out_416011.awb") / 1000

					if var_290_11 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_11 + var_290_5
					end

					if var_290_7.prefab_name ~= "" and arg_287_1.actors_[var_290_7.prefab_name] ~= nil then
						local var_290_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_7.prefab_name].transform, "story_v_out_416011", "416011069", "story_v_out_416011.awb")

						arg_287_1:RecordAudio("416011069", var_290_12)
						arg_287_1:RecordAudio("416011069", var_290_12)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_416011", "416011069", "story_v_out_416011.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_416011", "416011069", "story_v_out_416011.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_13 = math.max(var_290_6, arg_287_1.talkMaxDuration)

			if var_290_5 <= arg_287_1.time_ and arg_287_1.time_ < var_290_5 + var_290_13 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_5) / var_290_13

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_5 + var_290_13 and arg_287_1.time_ < var_290_5 + var_290_13 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play416011070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 416011070
		arg_291_1.duration_ = 5.2

		local var_291_0 = {
			zh = 3.766,
			ja = 5.2
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
				arg_291_0:Play416011071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1028"]) and arg_291_1.var_.actorSpriteComps1028 == nil then
				arg_291_1.var_.actorSpriteComps1028 = arg_291_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_0 = 0.125

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1028"]) then
				if arg_291_1.var_.actorSpriteComps1028 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								iter_294_1.color = Color.New(Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor2.r, (arg_291_1.time_ - 0) / var_294_0), Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor2.g, (arg_291_1.time_ - 0) / var_294_0), (Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor2.b, (arg_291_1.time_ - 0) / var_294_0)))
							else
								local var_294_1 = Mathf.Lerp(iter_294_1.color.r, 0.5, (arg_291_1.time_ - 0) / var_294_0)

								iter_294_1.color = Color.New(var_294_1, var_294_1, var_294_1)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1028"]) and arg_291_1.var_.actorSpriteComps1028 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_294_3 then
						iter_294_3.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_291_1.var_.actorSpriteComps1028 = nil
			end

			local var_294_2 = 0
			local var_294_3 = 0.375

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_4 = arg_291_1:GetWordFromCfg(416011070)
				local var_294_5 = arg_291_1:FormatText(var_294_4.content)

				arg_291_1.text_.text = var_294_5

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_7 = 15 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_5) / 15)

				if (15 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_5) / 15)) > 0 and var_294_3 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_2
					end
				end

				arg_291_1.text_.text = var_294_5
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011070", "story_v_out_416011.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011070", "story_v_out_416011.awb") / 1000

					if var_294_8 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_2
					end

					if var_294_4.prefab_name ~= "" and arg_291_1.actors_[var_294_4.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_4.prefab_name].transform, "story_v_out_416011", "416011070", "story_v_out_416011.awb")

						arg_291_1:RecordAudio("416011070", var_294_9)
						arg_291_1:RecordAudio("416011070", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_416011", "416011070", "story_v_out_416011.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_416011", "416011070", "story_v_out_416011.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_3, arg_291_1.talkMaxDuration)

			if var_294_2 <= arg_291_1.time_ and arg_291_1.time_ < var_294_2 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_2) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_2 + var_294_10 and arg_291_1.time_ < var_294_2 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play416011071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 416011071
		arg_295_1.duration_ = 7.8

		local var_295_0 = {
			zh = 5,
			ja = 7.8
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
				arg_295_0:Play416011072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["1028"]) and arg_295_1.var_.actorSpriteComps1028 == nil then
				arg_295_1.var_.actorSpriteComps1028 = arg_295_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_0 = 0.125

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["1028"]) then
				if arg_295_1.var_.actorSpriteComps1028 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								iter_298_1.color = Color.New(Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor1.r, (arg_295_1.time_ - 0) / var_298_0), Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor1.g, (arg_295_1.time_ - 0) / var_298_0), (Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor1.b, (arg_295_1.time_ - 0) / var_298_0)))
							else
								local var_298_1 = Mathf.Lerp(iter_298_1.color.r, 1, (arg_295_1.time_ - 0) / var_298_0)

								iter_298_1.color = Color.New(var_298_1, var_298_1, var_298_1)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["1028"]) and arg_295_1.var_.actorSpriteComps1028 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_298_3 then
						iter_298_3.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_295_1.var_.actorSpriteComps1028 = nil
			end

			local var_298_2 = 0
			local var_298_3 = 0.6

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_2 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_4 = arg_295_1:GetWordFromCfg(416011071)
				local var_298_5 = arg_295_1:FormatText(var_298_4.content)

				arg_295_1.text_.text = var_298_5

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_7 = 24 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_5) / 24)

				if (24 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_5) / 24)) > 0 and var_298_3 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_2
					end
				end

				arg_295_1.text_.text = var_298_5
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011071", "story_v_out_416011.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011071", "story_v_out_416011.awb") / 1000

					if var_298_8 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_2
					end

					if var_298_4.prefab_name ~= "" and arg_295_1.actors_[var_298_4.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_4.prefab_name].transform, "story_v_out_416011", "416011071", "story_v_out_416011.awb")

						arg_295_1:RecordAudio("416011071", var_298_9)
						arg_295_1:RecordAudio("416011071", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_416011", "416011071", "story_v_out_416011.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_416011", "416011071", "story_v_out_416011.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_3, arg_295_1.talkMaxDuration)

			if var_298_2 <= arg_295_1.time_ and arg_295_1.time_ < var_298_2 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_2) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_2 + var_298_10 and arg_295_1.time_ < var_298_2 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play416011072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 416011072
		arg_299_1.duration_ = 2.57

		local var_299_0 = {
			zh = 2.333,
			ja = 2.566
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
				arg_299_0:Play416011073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.2

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:GetWordFromCfg(416011072)
				local var_302_2 = arg_299_1:FormatText(var_302_1.content)

				arg_299_1.text_.text = var_302_2

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 8 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 8)

				if (8 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 8)) > 0 and var_302_0 < var_302_4 then
					arg_299_1.talkMaxDuration = var_302_4

					if var_302_4 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_4 + 0
					end
				end

				arg_299_1.text_.text = var_302_2
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011072", "story_v_out_416011.awb") ~= 0 then
					local var_302_5 = manager.audio:GetVoiceLength("story_v_out_416011", "416011072", "story_v_out_416011.awb") / 1000

					if var_302_5 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + 0
					end

					if var_302_1.prefab_name ~= "" and arg_299_1.actors_[var_302_1.prefab_name] ~= nil then
						local var_302_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_1.prefab_name].transform, "story_v_out_416011", "416011072", "story_v_out_416011.awb")

						arg_299_1:RecordAudio("416011072", var_302_6)
						arg_299_1:RecordAudio("416011072", var_302_6)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_416011", "416011072", "story_v_out_416011.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_416011", "416011072", "story_v_out_416011.awb")
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
	Play416011073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 416011073
		arg_303_1.duration_ = 8.97

		local var_303_0 = {
			zh = 4.9,
			ja = 8.966
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
				arg_303_0:Play416011074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1028"]) and arg_303_1.var_.actorSpriteComps1028 == nil then
				arg_303_1.var_.actorSpriteComps1028 = arg_303_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_0 = 0.125

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1028"]) then
				if arg_303_1.var_.actorSpriteComps1028 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								iter_306_1.color = Color.New(Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor2.r, (arg_303_1.time_ - 0) / var_306_0), Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor2.g, (arg_303_1.time_ - 0) / var_306_0), (Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor2.b, (arg_303_1.time_ - 0) / var_306_0)))
							else
								local var_306_1 = Mathf.Lerp(iter_306_1.color.r, 0.5, (arg_303_1.time_ - 0) / var_306_0)

								iter_306_1.color = Color.New(var_306_1, var_306_1, var_306_1)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1028"]) and arg_303_1.var_.actorSpriteComps1028 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_306_3 then
						iter_306_3.color = arg_303_1.isInRecall_ and (arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_303_1.var_.actorSpriteComps1028 = nil
			end

			local var_306_2 = 0
			local var_306_3 = 0.575

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_2 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_4 = arg_303_1:GetWordFromCfg(416011073)
				local var_306_5 = arg_303_1:FormatText(var_306_4.content)

				arg_303_1.text_.text = var_306_5

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_7 = 23 <= 0 and var_306_3 or var_306_3 * (utf8.len(var_306_5) / 23)

				if (23 <= 0 and var_306_3 or var_306_3 * (utf8.len(var_306_5) / 23)) > 0 and var_306_3 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_2 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_2
					end
				end

				arg_303_1.text_.text = var_306_5
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011073", "story_v_out_416011.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011073", "story_v_out_416011.awb") / 1000

					if var_306_8 + var_306_2 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_2
					end

					if var_306_4.prefab_name ~= "" and arg_303_1.actors_[var_306_4.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_4.prefab_name].transform, "story_v_out_416011", "416011073", "story_v_out_416011.awb")

						arg_303_1:RecordAudio("416011073", var_306_9)
						arg_303_1:RecordAudio("416011073", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_416011", "416011073", "story_v_out_416011.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_416011", "416011073", "story_v_out_416011.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_3, arg_303_1.talkMaxDuration)

			if var_306_2 <= arg_303_1.time_ and arg_303_1.time_ < var_306_2 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_2) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_2 + var_306_10 and arg_303_1.time_ < var_306_2 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play416011074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 416011074
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play416011075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1028 = arg_307_1.actors_["1028"].transform.localPosition
				arg_307_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1028", 7)

				for iter_310_0 = 0, arg_307_1.actors_["1028"].transform.childCount - 1 do
					local var_310_0 = arg_307_1.actors_["1028"].transform:GetChild(iter_310_0)

					if var_310_0.name == "" or not string.find(var_310_0.name, "split") then
						var_310_0.gameObject:SetActive(true)
					else
						var_310_0.gameObject:SetActive(false)
					end
				end
			end

			local var_310_1 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_1 then
				arg_307_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_307_1.time_ - 0) / var_310_1)
			end

			if arg_307_1.time_ >= 0 + var_310_1 and arg_307_1.time_ < 0 + var_310_1 + arg_310_0 then
				arg_307_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_310_2 = 0
			local var_310_3 = 1.225

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_4 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(416011074).content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_6 = 49 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_4) / 49)

				if (49 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_4) / 49)) > 0 and var_310_3 < var_310_6 then
					arg_307_1.talkMaxDuration = var_310_6

					if var_310_6 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_6 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_4
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_3, arg_307_1.talkMaxDuration)

			if var_310_2 <= arg_307_1.time_ and arg_307_1.time_ < var_310_2 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_2) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_2 + var_310_7 and arg_307_1.time_ < var_310_2 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
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
	Play416011075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 416011075
		arg_311_1.duration_ = 5.27

		local var_311_0 = {
			zh = 4.266,
			ja = 5.266
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
				arg_311_0:Play416011076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1028"]) and arg_311_1.var_.actorSpriteComps1028 == nil then
				arg_311_1.var_.actorSpriteComps1028 = arg_311_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_0 = 0.125

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1028"]) then
				if arg_311_1.var_.actorSpriteComps1028 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1028"]) and arg_311_1.var_.actorSpriteComps1028 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_314_3 then
						iter_314_3.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_311_1.var_.actorSpriteComps1028 = nil
			end

			local var_314_2 = arg_311_1.actors_["1028"].transform

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos1028 = var_314_2.localPosition
				var_314_2.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("1028", 3)

				for iter_314_4 = 0, var_314_2.childCount - 1 do
					local var_314_3 = var_314_2:GetChild(iter_314_4)

					if var_314_3.name == "split_6" or not string.find(var_314_3.name, "split") then
						var_314_3.gameObject:SetActive(true)
					else
						var_314_3.gameObject:SetActive(false)
					end
				end
			end

			local var_314_4 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				var_314_2.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_311_1.time_ - 0) / var_314_4)
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				var_314_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_314_5 = 0
			local var_314_6 = 0.55

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_7 = arg_311_1:GetWordFromCfg(416011075)
				local var_314_8 = arg_311_1:FormatText(var_314_7.content)

				arg_311_1.text_.text = var_314_8

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_10 = 22 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 22)

				if (22 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 22)) > 0 and var_314_6 < var_314_10 then
					arg_311_1.talkMaxDuration = var_314_10

					if var_314_10 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_5
					end
				end

				arg_311_1.text_.text = var_314_8
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011075", "story_v_out_416011.awb") ~= 0 then
					local var_314_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011075", "story_v_out_416011.awb") / 1000

					if var_314_11 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_11 + var_314_5
					end

					if var_314_7.prefab_name ~= "" and arg_311_1.actors_[var_314_7.prefab_name] ~= nil then
						local var_314_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_7.prefab_name].transform, "story_v_out_416011", "416011075", "story_v_out_416011.awb")

						arg_311_1:RecordAudio("416011075", var_314_12)
						arg_311_1:RecordAudio("416011075", var_314_12)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_416011", "416011075", "story_v_out_416011.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_416011", "416011075", "story_v_out_416011.awb")
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

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play416011076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 416011076
		arg_315_1.duration_ = 10.97

		local var_315_0 = {
			zh = 8.766,
			ja = 10.966
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
				arg_315_0:Play416011077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1028"]) and arg_315_1.var_.actorSpriteComps1028 == nil then
				arg_315_1.var_.actorSpriteComps1028 = arg_315_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_0 = 0.125

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1028"]) then
				if arg_315_1.var_.actorSpriteComps1028 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1028"]) and arg_315_1.var_.actorSpriteComps1028 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_318_3 then
						iter_318_3.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_315_1.var_.actorSpriteComps1028 = nil
			end

			local var_318_2 = 0
			local var_318_3 = 1.05

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_2 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_4 = arg_315_1:GetWordFromCfg(416011076)
				local var_318_5 = arg_315_1:FormatText(var_318_4.content)

				arg_315_1.text_.text = var_318_5

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_7 = 42 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 42)

				if (42 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 42)) > 0 and var_318_3 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_2
					end
				end

				arg_315_1.text_.text = var_318_5
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011076", "story_v_out_416011.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011076", "story_v_out_416011.awb") / 1000

					if var_318_8 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_2
					end

					if var_318_4.prefab_name ~= "" and arg_315_1.actors_[var_318_4.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_4.prefab_name].transform, "story_v_out_416011", "416011076", "story_v_out_416011.awb")

						arg_315_1:RecordAudio("416011076", var_318_9)
						arg_315_1:RecordAudio("416011076", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_416011", "416011076", "story_v_out_416011.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_416011", "416011076", "story_v_out_416011.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_3, arg_315_1.talkMaxDuration)

			if var_318_2 <= arg_315_1.time_ and arg_315_1.time_ < var_318_2 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_2) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_2 + var_318_10 and arg_315_1.time_ < var_318_2 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play416011077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 416011077
		arg_319_1.duration_ = 6.03

		local var_319_0 = {
			zh = 5.566,
			ja = 6.033
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
				arg_319_0:Play416011078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1028"]) and arg_319_1.var_.actorSpriteComps1028 == nil then
				arg_319_1.var_.actorSpriteComps1028 = arg_319_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_0 = 0.125

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1028"]) then
				if arg_319_1.var_.actorSpriteComps1028 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								iter_322_1.color = Color.New(Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor1.r, (arg_319_1.time_ - 0) / var_322_0), Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor1.g, (arg_319_1.time_ - 0) / var_322_0), (Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor1.b, (arg_319_1.time_ - 0) / var_322_0)))
							else
								local var_322_1 = Mathf.Lerp(iter_322_1.color.r, 1, (arg_319_1.time_ - 0) / var_322_0)

								iter_322_1.color = Color.New(var_322_1, var_322_1, var_322_1)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1028"]) and arg_319_1.var_.actorSpriteComps1028 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_322_3 then
						iter_322_3.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_319_1.var_.actorSpriteComps1028 = nil
			end

			local var_322_2 = 0
			local var_322_3 = 0.55

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_2 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_4 = arg_319_1:GetWordFromCfg(416011077)
				local var_322_5 = arg_319_1:FormatText(var_322_4.content)

				arg_319_1.text_.text = var_322_5

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_7 = 22 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_5) / 22)

				if (22 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_5) / 22)) > 0 and var_322_3 < var_322_7 then
					arg_319_1.talkMaxDuration = var_322_7

					if var_322_7 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_7 + var_322_2
					end
				end

				arg_319_1.text_.text = var_322_5
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011077", "story_v_out_416011.awb") ~= 0 then
					local var_322_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011077", "story_v_out_416011.awb") / 1000

					if var_322_8 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_8 + var_322_2
					end

					if var_322_4.prefab_name ~= "" and arg_319_1.actors_[var_322_4.prefab_name] ~= nil then
						local var_322_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_4.prefab_name].transform, "story_v_out_416011", "416011077", "story_v_out_416011.awb")

						arg_319_1:RecordAudio("416011077", var_322_9)
						arg_319_1:RecordAudio("416011077", var_322_9)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_416011", "416011077", "story_v_out_416011.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_416011", "416011077", "story_v_out_416011.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_10 = math.max(var_322_3, arg_319_1.talkMaxDuration)

			if var_322_2 <= arg_319_1.time_ and arg_319_1.time_ < var_322_2 + var_322_10 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_2) / var_322_10

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_2 + var_322_10 and arg_319_1.time_ < var_322_2 + var_322_10 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play416011078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 416011078
		arg_323_1.duration_ = 4.03

		local var_323_0 = {
			zh = 2.133,
			ja = 4.033
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
				arg_323_0:Play416011079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1028 = arg_323_1.actors_["1028"].transform.localPosition
				arg_323_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("1028", 7)

				for iter_326_0 = 0, arg_323_1.actors_["1028"].transform.childCount - 1 do
					local var_326_0 = arg_323_1.actors_["1028"].transform:GetChild(iter_326_0)

					if var_326_0.name == "" or not string.find(var_326_0.name, "split") then
						var_326_0.gameObject:SetActive(true)
					else
						var_326_0.gameObject:SetActive(false)
					end
				end
			end

			local var_326_1 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_1 then
				arg_323_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_323_1.time_ - 0) / var_326_1)
			end

			if arg_323_1.time_ >= 0 + var_326_1 and arg_323_1.time_ < 0 + var_326_1 + arg_326_0 then
				arg_323_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_326_2 = 0
			local var_326_3 = 0.275

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_2 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_4 = arg_323_1:GetWordFromCfg(416011078)
				local var_326_5 = arg_323_1:FormatText(var_326_4.content)

				arg_323_1.text_.text = var_326_5

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_7 = 11 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 11)

				if (11 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 11)) > 0 and var_326_3 < var_326_7 then
					arg_323_1.talkMaxDuration = var_326_7

					if var_326_7 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_7 + var_326_2
					end
				end

				arg_323_1.text_.text = var_326_5
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011078", "story_v_out_416011.awb") ~= 0 then
					local var_326_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011078", "story_v_out_416011.awb") / 1000

					if var_326_8 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_8 + var_326_2
					end

					if var_326_4.prefab_name ~= "" and arg_323_1.actors_[var_326_4.prefab_name] ~= nil then
						local var_326_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_4.prefab_name].transform, "story_v_out_416011", "416011078", "story_v_out_416011.awb")

						arg_323_1:RecordAudio("416011078", var_326_9)
						arg_323_1:RecordAudio("416011078", var_326_9)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_416011", "416011078", "story_v_out_416011.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_416011", "416011078", "story_v_out_416011.awb")
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

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play416011079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 416011079
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play416011080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 1.625

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_1 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(416011079).content)

				arg_327_1.text_.text = var_330_1

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_3 = 65 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_1) / 65)

				if (65 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_1) / 65)) > 0 and var_330_0 < var_330_3 then
					arg_327_1.talkMaxDuration = var_330_3

					if var_330_3 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_3 + 0
					end
				end

				arg_327_1.text_.text = var_330_1
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_4 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_4

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play416011080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 416011080
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play416011081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 1.55

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(416011080).content)

				arg_331_1.text_.text = var_334_1

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_3 = 62 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 62)

				if (62 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 62)) > 0 and var_334_0 < var_334_3 then
					arg_331_1.talkMaxDuration = var_334_3

					if var_334_3 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_3 + 0
					end
				end

				arg_331_1.text_.text = var_334_1
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_4 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_4

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play416011081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 416011081
		arg_335_1.duration_ = 6.43

		local var_335_0 = {
			zh = 3.633,
			ja = 6.433
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
				arg_335_0:Play416011082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if arg_335_1.actors_["10108"] == nil then
				local var_338_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_338_0) then
					local var_338_1 = Object.Instantiate(var_338_0, arg_335_1.canvasGo_.transform)

					var_338_1.transform:SetSiblingIndex(1)

					var_338_1.name = "10108"
					var_338_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_335_1.actors_["10108"] = var_338_1

					if arg_335_1.isInRecall_ then
						for iter_338_0, iter_338_1 in ipairs((var_338_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_338_1.color = arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_338_2 = arg_335_1.actors_["10108"].transform

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos10108 = var_338_2.localPosition
				var_338_2.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("10108", 3)

				for iter_338_2 = 0, var_338_2.childCount - 1 do
					local var_338_3 = var_338_2:GetChild(iter_338_2)

					if var_338_3.name == "split_2" or not string.find(var_338_3.name, "split") then
						var_338_3.gameObject:SetActive(true)
					else
						var_338_3.gameObject:SetActive(false)
					end
				end
			end

			local var_338_4 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				var_338_2.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10108, Vector3.New(0, -399.6, -130), (arg_335_1.time_ - 0) / var_338_4)
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				var_338_2.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_338_5 = arg_335_1.actors_["10108"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_5) and arg_335_1.var_.actorSpriteComps10108 == nil then
				arg_335_1.var_.actorSpriteComps10108 = var_338_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_6 = 0.125

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_6 and not isNil(var_338_5) then
				if arg_335_1.var_.actorSpriteComps10108 then
					for iter_338_3, iter_338_4 in pairs(arg_335_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_338_4 then
							if arg_335_1.isInRecall_ then
								iter_338_4.color = Color.New(Mathf.Lerp(iter_338_4.color.r, arg_335_1.hightColor1.r, (arg_335_1.time_ - 0) / var_338_6), Mathf.Lerp(iter_338_4.color.g, arg_335_1.hightColor1.g, (arg_335_1.time_ - 0) / var_338_6), (Mathf.Lerp(iter_338_4.color.b, arg_335_1.hightColor1.b, (arg_335_1.time_ - 0) / var_338_6)))
							else
								local var_338_7 = Mathf.Lerp(iter_338_4.color.r, 1, (arg_335_1.time_ - 0) / var_338_6)

								iter_338_4.color = Color.New(var_338_7, var_338_7, var_338_7)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_6 and arg_335_1.time_ < 0 + var_338_6 + arg_338_0 and not isNil(var_338_5) and arg_335_1.var_.actorSpriteComps10108 then
				for iter_338_5, iter_338_6 in pairs(arg_335_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_338_6 then
						iter_338_6.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_335_1.var_.actorSpriteComps10108 = nil
			end

			local var_338_8 = 0
			local var_338_9 = 0.25

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_8 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_10 = arg_335_1:GetWordFromCfg(416011081)
				local var_338_11 = arg_335_1:FormatText(var_338_10.content)

				arg_335_1.text_.text = var_338_11

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_13 = 10 <= 0 and var_338_9 or var_338_9 * (utf8.len(var_338_11) / 10)

				if (10 <= 0 and var_338_9 or var_338_9 * (utf8.len(var_338_11) / 10)) > 0 and var_338_9 < var_338_13 then
					arg_335_1.talkMaxDuration = var_338_13

					if var_338_13 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_13 + var_338_8
					end
				end

				arg_335_1.text_.text = var_338_11
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011081", "story_v_out_416011.awb") ~= 0 then
					local var_338_14 = manager.audio:GetVoiceLength("story_v_out_416011", "416011081", "story_v_out_416011.awb") / 1000

					if var_338_14 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_14 + var_338_8
					end

					if var_338_10.prefab_name ~= "" and arg_335_1.actors_[var_338_10.prefab_name] ~= nil then
						local var_338_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_10.prefab_name].transform, "story_v_out_416011", "416011081", "story_v_out_416011.awb")

						arg_335_1:RecordAudio("416011081", var_338_15)
						arg_335_1:RecordAudio("416011081", var_338_15)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_416011", "416011081", "story_v_out_416011.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_416011", "416011081", "story_v_out_416011.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_16 = math.max(var_338_9, arg_335_1.talkMaxDuration)

			if var_338_8 <= arg_335_1.time_ and arg_335_1.time_ < var_338_8 + var_338_16 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_8) / var_338_16

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_8 + var_338_16 and arg_335_1.time_ < var_338_8 + var_338_16 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
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
	Play416011082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 416011082
		arg_339_1.duration_ = 6.3

		local var_339_0 = {
			zh = 4.133,
			ja = 6.3
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
				arg_339_0:Play416011083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos10108 = arg_339_1.actors_["10108"].transform.localPosition
				arg_339_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("10108", 2)

				for iter_342_0 = 0, arg_339_1.actors_["10108"].transform.childCount - 1 do
					local var_342_0 = arg_339_1.actors_["10108"].transform:GetChild(iter_342_0)

					if var_342_0.name == "split_2" or not string.find(var_342_0.name, "split") then
						var_342_0.gameObject:SetActive(true)
					else
						var_342_0.gameObject:SetActive(false)
					end
				end
			end

			local var_342_1 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_1 then
				arg_339_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10108, Vector3.New(-390, -399.6, -130), (arg_339_1.time_ - 0) / var_342_1)
			end

			if arg_339_1.time_ >= 0 + var_342_1 and arg_339_1.time_ < 0 + var_342_1 + arg_342_0 then
				arg_339_1.actors_["10108"].transform.localPosition = Vector3.New(-390, -399.6, -130)
			end

			local var_342_2 = arg_339_1.actors_["1028"].transform

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1028 = var_342_2.localPosition
				var_342_2.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("1028", 4)

				for iter_342_1 = 0, var_342_2.childCount - 1 do
					local var_342_3 = var_342_2:GetChild(iter_342_1)

					if var_342_3.name == "split_6" or not string.find(var_342_3.name, "split") then
						var_342_3.gameObject:SetActive(true)
					else
						var_342_3.gameObject:SetActive(false)
					end
				end
			end

			local var_342_4 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 then
				var_342_2.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_339_1.time_ - 0) / var_342_4)
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 then
				var_342_2.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_342_5 = arg_339_1.actors_["10108"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_5) and arg_339_1.var_.actorSpriteComps10108 == nil then
				arg_339_1.var_.actorSpriteComps10108 = var_342_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_6 = 0.125

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_6 and not isNil(var_342_5) then
				if arg_339_1.var_.actorSpriteComps10108 then
					for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_342_3 then
							if arg_339_1.isInRecall_ then
								iter_342_3.color = Color.New(Mathf.Lerp(iter_342_3.color.r, arg_339_1.hightColor2.r, (arg_339_1.time_ - 0) / var_342_6), Mathf.Lerp(iter_342_3.color.g, arg_339_1.hightColor2.g, (arg_339_1.time_ - 0) / var_342_6), (Mathf.Lerp(iter_342_3.color.b, arg_339_1.hightColor2.b, (arg_339_1.time_ - 0) / var_342_6)))
							else
								local var_342_7 = Mathf.Lerp(iter_342_3.color.r, 0.5, (arg_339_1.time_ - 0) / var_342_6)

								iter_342_3.color = Color.New(var_342_7, var_342_7, var_342_7)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_6 and arg_339_1.time_ < 0 + var_342_6 + arg_342_0 and not isNil(var_342_5) and arg_339_1.var_.actorSpriteComps10108 then
				for iter_342_4, iter_342_5 in pairs(arg_339_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_342_5 then
						iter_342_5.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_339_1.var_.actorSpriteComps10108 = nil
			end

			local var_342_8 = arg_339_1.actors_["1028"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_8) and arg_339_1.var_.actorSpriteComps1028 == nil then
				arg_339_1.var_.actorSpriteComps1028 = var_342_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_9 = 0.125

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_9 and not isNil(var_342_8) then
				if arg_339_1.var_.actorSpriteComps1028 then
					for iter_342_6, iter_342_7 in pairs(arg_339_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_342_7 then
							if arg_339_1.isInRecall_ then
								iter_342_7.color = Color.New(Mathf.Lerp(iter_342_7.color.r, arg_339_1.hightColor1.r, (arg_339_1.time_ - 0) / var_342_9), Mathf.Lerp(iter_342_7.color.g, arg_339_1.hightColor1.g, (arg_339_1.time_ - 0) / var_342_9), (Mathf.Lerp(iter_342_7.color.b, arg_339_1.hightColor1.b, (arg_339_1.time_ - 0) / var_342_9)))
							else
								local var_342_10 = Mathf.Lerp(iter_342_7.color.r, 1, (arg_339_1.time_ - 0) / var_342_9)

								iter_342_7.color = Color.New(var_342_10, var_342_10, var_342_10)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_9 and arg_339_1.time_ < 0 + var_342_9 + arg_342_0 and not isNil(var_342_8) and arg_339_1.var_.actorSpriteComps1028 then
				for iter_342_8, iter_342_9 in pairs(arg_339_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_342_9 then
						iter_342_9.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_339_1.var_.actorSpriteComps1028 = nil
			end

			local var_342_11 = 0
			local var_342_12 = 0.4

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_11 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_13 = arg_339_1:GetWordFromCfg(416011082)
				local var_342_14 = arg_339_1:FormatText(var_342_13.content)

				arg_339_1.text_.text = var_342_14

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_16 = 16 <= 0 and var_342_12 or var_342_12 * (utf8.len(var_342_14) / 16)

				if (16 <= 0 and var_342_12 or var_342_12 * (utf8.len(var_342_14) / 16)) > 0 and var_342_12 < var_342_16 then
					arg_339_1.talkMaxDuration = var_342_16

					if var_342_16 + var_342_11 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_16 + var_342_11
					end
				end

				arg_339_1.text_.text = var_342_14
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011082", "story_v_out_416011.awb") ~= 0 then
					local var_342_17 = manager.audio:GetVoiceLength("story_v_out_416011", "416011082", "story_v_out_416011.awb") / 1000

					if var_342_17 + var_342_11 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_17 + var_342_11
					end

					if var_342_13.prefab_name ~= "" and arg_339_1.actors_[var_342_13.prefab_name] ~= nil then
						local var_342_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_13.prefab_name].transform, "story_v_out_416011", "416011082", "story_v_out_416011.awb")

						arg_339_1:RecordAudio("416011082", var_342_18)
						arg_339_1:RecordAudio("416011082", var_342_18)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_416011", "416011082", "story_v_out_416011.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_416011", "416011082", "story_v_out_416011.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_19 = math.max(var_342_12, arg_339_1.talkMaxDuration)

			if var_342_11 <= arg_339_1.time_ and arg_339_1.time_ < var_342_11 + var_342_19 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_11) / var_342_19

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_11 + var_342_19 and arg_339_1.time_ < var_342_11 + var_342_19 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play416011083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 416011083
		arg_343_1.duration_ = 7.23

		local var_343_0 = {
			zh = 6.733,
			ja = 7.233
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
				arg_343_0:Play416011084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["10108"]) and arg_343_1.var_.actorSpriteComps10108 == nil then
				arg_343_1.var_.actorSpriteComps10108 = arg_343_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_0 = 0.125

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["10108"]) then
				if arg_343_1.var_.actorSpriteComps10108 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								iter_346_1.color = Color.New(Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor1.r, (arg_343_1.time_ - 0) / var_346_0), Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor1.g, (arg_343_1.time_ - 0) / var_346_0), (Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor1.b, (arg_343_1.time_ - 0) / var_346_0)))
							else
								local var_346_1 = Mathf.Lerp(iter_346_1.color.r, 1, (arg_343_1.time_ - 0) / var_346_0)

								iter_346_1.color = Color.New(var_346_1, var_346_1, var_346_1)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["10108"]) and arg_343_1.var_.actorSpriteComps10108 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_346_3 then
						iter_346_3.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_343_1.var_.actorSpriteComps10108 = nil
			end

			local var_346_2 = arg_343_1.actors_["1028"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.actorSpriteComps1028 == nil then
				arg_343_1.var_.actorSpriteComps1028 = var_346_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_3 = 0.125

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_3 and not isNil(var_346_2) then
				if arg_343_1.var_.actorSpriteComps1028 then
					for iter_346_4, iter_346_5 in pairs(arg_343_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_346_5 then
							if arg_343_1.isInRecall_ then
								iter_346_5.color = Color.New(Mathf.Lerp(iter_346_5.color.r, arg_343_1.hightColor2.r, (arg_343_1.time_ - 0) / var_346_3), Mathf.Lerp(iter_346_5.color.g, arg_343_1.hightColor2.g, (arg_343_1.time_ - 0) / var_346_3), (Mathf.Lerp(iter_346_5.color.b, arg_343_1.hightColor2.b, (arg_343_1.time_ - 0) / var_346_3)))
							else
								local var_346_4 = Mathf.Lerp(iter_346_5.color.r, 0.5, (arg_343_1.time_ - 0) / var_346_3)

								iter_346_5.color = Color.New(var_346_4, var_346_4, var_346_4)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_3 and arg_343_1.time_ < 0 + var_346_3 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.actorSpriteComps1028 then
				for iter_346_6, iter_346_7 in pairs(arg_343_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_346_7 then
						iter_346_7.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_343_1.var_.actorSpriteComps1028 = nil
			end

			local var_346_5 = 0
			local var_346_6 = 0.65

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_7 = arg_343_1:GetWordFromCfg(416011083)
				local var_346_8 = arg_343_1:FormatText(var_346_7.content)

				arg_343_1.text_.text = var_346_8

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_10 = 26 <= 0 and var_346_6 or var_346_6 * (utf8.len(var_346_8) / 26)

				if (26 <= 0 and var_346_6 or var_346_6 * (utf8.len(var_346_8) / 26)) > 0 and var_346_6 < var_346_10 then
					arg_343_1.talkMaxDuration = var_346_10

					if var_346_10 + var_346_5 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_10 + var_346_5
					end
				end

				arg_343_1.text_.text = var_346_8
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011083", "story_v_out_416011.awb") ~= 0 then
					local var_346_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011083", "story_v_out_416011.awb") / 1000

					if var_346_11 + var_346_5 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_11 + var_346_5
					end

					if var_346_7.prefab_name ~= "" and arg_343_1.actors_[var_346_7.prefab_name] ~= nil then
						local var_346_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_7.prefab_name].transform, "story_v_out_416011", "416011083", "story_v_out_416011.awb")

						arg_343_1:RecordAudio("416011083", var_346_12)
						arg_343_1:RecordAudio("416011083", var_346_12)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_416011", "416011083", "story_v_out_416011.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_416011", "416011083", "story_v_out_416011.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_13 = math.max(var_346_6, arg_343_1.talkMaxDuration)

			if var_346_5 <= arg_343_1.time_ and arg_343_1.time_ < var_346_5 + var_346_13 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_5) / var_346_13

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_5 + var_346_13 and arg_343_1.time_ < var_346_5 + var_346_13 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play416011084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 416011084
		arg_347_1.duration_ = 4.27

		local var_347_0 = {
			zh = 2.666,
			ja = 4.266
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
				arg_347_0:Play416011085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos10108 = arg_347_1.actors_["10108"].transform.localPosition
				arg_347_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("10108", 2)

				for iter_350_0 = 0, arg_347_1.actors_["10108"].transform.childCount - 1 do
					local var_350_0 = arg_347_1.actors_["10108"].transform:GetChild(iter_350_0)

					if var_350_0.name == "split_1" or not string.find(var_350_0.name, "split") then
						var_350_0.gameObject:SetActive(true)
					else
						var_350_0.gameObject:SetActive(false)
					end
				end
			end

			local var_350_1 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_1 then
				arg_347_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10108, Vector3.New(-390, -399.6, -130), (arg_347_1.time_ - 0) / var_350_1)
			end

			if arg_347_1.time_ >= 0 + var_350_1 and arg_347_1.time_ < 0 + var_350_1 + arg_350_0 then
				arg_347_1.actors_["10108"].transform.localPosition = Vector3.New(-390, -399.6, -130)
			end

			local var_350_2 = 0
			local var_350_3 = 0.2

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_2 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_4 = arg_347_1:GetWordFromCfg(416011084)
				local var_350_5 = arg_347_1:FormatText(var_350_4.content)

				arg_347_1.text_.text = var_350_5

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_7 = 8 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 8)

				if (8 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 8)) > 0 and var_350_3 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_2
					end
				end

				arg_347_1.text_.text = var_350_5
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011084", "story_v_out_416011.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011084", "story_v_out_416011.awb") / 1000

					if var_350_8 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_2
					end

					if var_350_4.prefab_name ~= "" and arg_347_1.actors_[var_350_4.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_4.prefab_name].transform, "story_v_out_416011", "416011084", "story_v_out_416011.awb")

						arg_347_1:RecordAudio("416011084", var_350_9)
						arg_347_1:RecordAudio("416011084", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_416011", "416011084", "story_v_out_416011.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_416011", "416011084", "story_v_out_416011.awb")
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

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play416011085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 416011085
		arg_351_1.duration_ = 8.03

		local var_351_0 = {
			zh = 4.233,
			ja = 8.033
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
				arg_351_0:Play416011086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["10108"]) and arg_351_1.var_.actorSpriteComps10108 == nil then
				arg_351_1.var_.actorSpriteComps10108 = arg_351_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_0 = 0.125

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["10108"]) then
				if arg_351_1.var_.actorSpriteComps10108 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								iter_354_1.color = Color.New(Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor2.r, (arg_351_1.time_ - 0) / var_354_0), Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor2.g, (arg_351_1.time_ - 0) / var_354_0), (Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor2.b, (arg_351_1.time_ - 0) / var_354_0)))
							else
								local var_354_1 = Mathf.Lerp(iter_354_1.color.r, 0.5, (arg_351_1.time_ - 0) / var_354_0)

								iter_354_1.color = Color.New(var_354_1, var_354_1, var_354_1)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["10108"]) and arg_351_1.var_.actorSpriteComps10108 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_354_3 then
						iter_354_3.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_351_1.var_.actorSpriteComps10108 = nil
			end

			local var_354_2 = arg_351_1.actors_["1028"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.actorSpriteComps1028 == nil then
				arg_351_1.var_.actorSpriteComps1028 = var_354_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_3 = 0.125

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_3 and not isNil(var_354_2) then
				if arg_351_1.var_.actorSpriteComps1028 then
					for iter_354_4, iter_354_5 in pairs(arg_351_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_354_5 then
							if arg_351_1.isInRecall_ then
								iter_354_5.color = Color.New(Mathf.Lerp(iter_354_5.color.r, arg_351_1.hightColor1.r, (arg_351_1.time_ - 0) / var_354_3), Mathf.Lerp(iter_354_5.color.g, arg_351_1.hightColor1.g, (arg_351_1.time_ - 0) / var_354_3), (Mathf.Lerp(iter_354_5.color.b, arg_351_1.hightColor1.b, (arg_351_1.time_ - 0) / var_354_3)))
							else
								local var_354_4 = Mathf.Lerp(iter_354_5.color.r, 1, (arg_351_1.time_ - 0) / var_354_3)

								iter_354_5.color = Color.New(var_354_4, var_354_4, var_354_4)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_3 and arg_351_1.time_ < 0 + var_354_3 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.actorSpriteComps1028 then
				for iter_354_6, iter_354_7 in pairs(arg_351_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_354_7 then
						iter_354_7.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_351_1.var_.actorSpriteComps1028 = nil
			end

			local var_354_5 = 0
			local var_354_6 = 0.45

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_7 = arg_351_1:GetWordFromCfg(416011085)
				local var_354_8 = arg_351_1:FormatText(var_354_7.content)

				arg_351_1.text_.text = var_354_8

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_10 = 18 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_8) / 18)

				if (18 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_8) / 18)) > 0 and var_354_6 < var_354_10 then
					arg_351_1.talkMaxDuration = var_354_10

					if var_354_10 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_5
					end
				end

				arg_351_1.text_.text = var_354_8
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011085", "story_v_out_416011.awb") ~= 0 then
					local var_354_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011085", "story_v_out_416011.awb") / 1000

					if var_354_11 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_11 + var_354_5
					end

					if var_354_7.prefab_name ~= "" and arg_351_1.actors_[var_354_7.prefab_name] ~= nil then
						local var_354_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_7.prefab_name].transform, "story_v_out_416011", "416011085", "story_v_out_416011.awb")

						arg_351_1:RecordAudio("416011085", var_354_12)
						arg_351_1:RecordAudio("416011085", var_354_12)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_416011", "416011085", "story_v_out_416011.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_416011", "416011085", "story_v_out_416011.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_13 = math.max(var_354_6, arg_351_1.talkMaxDuration)

			if var_354_5 <= arg_351_1.time_ and arg_351_1.time_ < var_354_5 + var_354_13 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_5) / var_354_13

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_5 + var_354_13 and arg_351_1.time_ < var_354_5 + var_354_13 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play416011086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 416011086
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play416011087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos10108 = arg_355_1.actors_["10108"].transform.localPosition
				arg_355_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10108", 7)

				for iter_358_0 = 0, arg_355_1.actors_["10108"].transform.childCount - 1 do
					local var_358_0 = arg_355_1.actors_["10108"].transform:GetChild(iter_358_0)

					if var_358_0.name == "" or not string.find(var_358_0.name, "split") then
						var_358_0.gameObject:SetActive(true)
					else
						var_358_0.gameObject:SetActive(false)
					end
				end
			end

			local var_358_1 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_1 then
				arg_355_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_355_1.time_ - 0) / var_358_1)
			end

			if arg_355_1.time_ >= 0 + var_358_1 and arg_355_1.time_ < 0 + var_358_1 + arg_358_0 then
				arg_355_1.actors_["10108"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_358_2 = arg_355_1.actors_["1028"].transform

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos1028 = var_358_2.localPosition
				var_358_2.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("1028", 7)

				for iter_358_1 = 0, var_358_2.childCount - 1 do
					local var_358_3 = var_358_2:GetChild(iter_358_1)

					if var_358_3.name == "split_2" or not string.find(var_358_3.name, "split") then
						var_358_3.gameObject:SetActive(true)
					else
						var_358_3.gameObject:SetActive(false)
					end
				end
			end

			local var_358_4 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				var_358_2.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_355_1.time_ - 0) / var_358_4)
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				var_358_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_358_5 = 0
			local var_358_6 = 0.925

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_5 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_7 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(416011086).content)

				arg_355_1.text_.text = var_358_7

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_9 = 37 <= 0 and var_358_6 or var_358_6 * (utf8.len(var_358_7) / 37)

				if (37 <= 0 and var_358_6 or var_358_6 * (utf8.len(var_358_7) / 37)) > 0 and var_358_6 < var_358_9 then
					arg_355_1.talkMaxDuration = var_358_9

					if var_358_9 + var_358_5 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_5
					end
				end

				arg_355_1.text_.text = var_358_7
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_10 = math.max(var_358_6, arg_355_1.talkMaxDuration)

			if var_358_5 <= arg_355_1.time_ and arg_355_1.time_ < var_358_5 + var_358_10 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_5) / var_358_10

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_5 + var_358_10 and arg_355_1.time_ < var_358_5 + var_358_10 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play416011087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 416011087
		arg_359_1.duration_ = 6.33

		local var_359_0 = {
			zh = 4.133,
			ja = 6.333
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
				arg_359_0:Play416011088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["10108"]) and arg_359_1.var_.actorSpriteComps10108 == nil then
				arg_359_1.var_.actorSpriteComps10108 = arg_359_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_0 = 0.125

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["10108"]) then
				if arg_359_1.var_.actorSpriteComps10108 then
					for iter_362_0, iter_362_1 in pairs(arg_359_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_362_1 then
							if arg_359_1.isInRecall_ then
								iter_362_1.color = Color.New(Mathf.Lerp(iter_362_1.color.r, arg_359_1.hightColor1.r, (arg_359_1.time_ - 0) / var_362_0), Mathf.Lerp(iter_362_1.color.g, arg_359_1.hightColor1.g, (arg_359_1.time_ - 0) / var_362_0), (Mathf.Lerp(iter_362_1.color.b, arg_359_1.hightColor1.b, (arg_359_1.time_ - 0) / var_362_0)))
							else
								local var_362_1 = Mathf.Lerp(iter_362_1.color.r, 1, (arg_359_1.time_ - 0) / var_362_0)

								iter_362_1.color = Color.New(var_362_1, var_362_1, var_362_1)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["10108"]) and arg_359_1.var_.actorSpriteComps10108 then
				for iter_362_2, iter_362_3 in pairs(arg_359_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_362_3 then
						iter_362_3.color = arg_359_1.isInRecall_ and (arg_359_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_359_1.var_.actorSpriteComps10108 = nil
			end

			local var_362_2 = arg_359_1.actors_["10108"].transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos10108 = var_362_2.localPosition
				var_362_2.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("10108", 3)

				for iter_362_4 = 0, var_362_2.childCount - 1 do
					local var_362_3 = var_362_2:GetChild(iter_362_4)

					if var_362_3.name == "split_4" or not string.find(var_362_3.name, "split") then
						var_362_3.gameObject:SetActive(true)
					else
						var_362_3.gameObject:SetActive(false)
					end
				end
			end

			local var_362_4 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				var_362_2.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10108, Vector3.New(0, -399.6, -130), (arg_359_1.time_ - 0) / var_362_4)
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				var_362_2.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_362_5 = 0
			local var_362_6 = 0.225

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_5 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_7 = arg_359_1:GetWordFromCfg(416011087)
				local var_362_8 = arg_359_1:FormatText(var_362_7.content)

				arg_359_1.text_.text = var_362_8

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_10 = 9 <= 0 and var_362_6 or var_362_6 * (utf8.len(var_362_8) / 9)

				if (9 <= 0 and var_362_6 or var_362_6 * (utf8.len(var_362_8) / 9)) > 0 and var_362_6 < var_362_10 then
					arg_359_1.talkMaxDuration = var_362_10

					if var_362_10 + var_362_5 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_5
					end
				end

				arg_359_1.text_.text = var_362_8
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011087", "story_v_out_416011.awb") ~= 0 then
					local var_362_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011087", "story_v_out_416011.awb") / 1000

					if var_362_11 + var_362_5 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_11 + var_362_5
					end

					if var_362_7.prefab_name ~= "" and arg_359_1.actors_[var_362_7.prefab_name] ~= nil then
						local var_362_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_7.prefab_name].transform, "story_v_out_416011", "416011087", "story_v_out_416011.awb")

						arg_359_1:RecordAudio("416011087", var_362_12)
						arg_359_1:RecordAudio("416011087", var_362_12)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_416011", "416011087", "story_v_out_416011.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_416011", "416011087", "story_v_out_416011.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_13 = math.max(var_362_6, arg_359_1.talkMaxDuration)

			if var_362_5 <= arg_359_1.time_ and arg_359_1.time_ < var_362_5 + var_362_13 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_5) / var_362_13

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_5 + var_362_13 and arg_359_1.time_ < var_362_5 + var_362_13 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play416011088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 416011088
		arg_363_1.duration_ = 3.57

		local var_363_0 = {
			zh = 3.266,
			ja = 3.566
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
				arg_363_0:Play416011089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["10108"]) and arg_363_1.var_.actorSpriteComps10108 == nil then
				arg_363_1.var_.actorSpriteComps10108 = arg_363_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_0 = 0.125

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["10108"]) then
				if arg_363_1.var_.actorSpriteComps10108 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_366_1 then
							if arg_363_1.isInRecall_ then
								iter_366_1.color = Color.New(Mathf.Lerp(iter_366_1.color.r, arg_363_1.hightColor2.r, (arg_363_1.time_ - 0) / var_366_0), Mathf.Lerp(iter_366_1.color.g, arg_363_1.hightColor2.g, (arg_363_1.time_ - 0) / var_366_0), (Mathf.Lerp(iter_366_1.color.b, arg_363_1.hightColor2.b, (arg_363_1.time_ - 0) / var_366_0)))
							else
								local var_366_1 = Mathf.Lerp(iter_366_1.color.r, 0.5, (arg_363_1.time_ - 0) / var_366_0)

								iter_366_1.color = Color.New(var_366_1, var_366_1, var_366_1)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["10108"]) and arg_363_1.var_.actorSpriteComps10108 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_366_3 then
						iter_366_3.color = arg_363_1.isInRecall_ and (arg_363_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_363_1.var_.actorSpriteComps10108 = nil
			end

			local var_366_2 = arg_363_1.actors_["1028"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_2) and arg_363_1.var_.actorSpriteComps1028 == nil then
				arg_363_1.var_.actorSpriteComps1028 = var_366_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_3 = 0.125

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_3 and not isNil(var_366_2) then
				if arg_363_1.var_.actorSpriteComps1028 then
					for iter_366_4, iter_366_5 in pairs(arg_363_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_366_5 then
							if arg_363_1.isInRecall_ then
								iter_366_5.color = Color.New(Mathf.Lerp(iter_366_5.color.r, arg_363_1.hightColor1.r, (arg_363_1.time_ - 0) / var_366_3), Mathf.Lerp(iter_366_5.color.g, arg_363_1.hightColor1.g, (arg_363_1.time_ - 0) / var_366_3), (Mathf.Lerp(iter_366_5.color.b, arg_363_1.hightColor1.b, (arg_363_1.time_ - 0) / var_366_3)))
							else
								local var_366_4 = Mathf.Lerp(iter_366_5.color.r, 1, (arg_363_1.time_ - 0) / var_366_3)

								iter_366_5.color = Color.New(var_366_4, var_366_4, var_366_4)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= 0 + var_366_3 and arg_363_1.time_ < 0 + var_366_3 + arg_366_0 and not isNil(var_366_2) and arg_363_1.var_.actorSpriteComps1028 then
				for iter_366_6, iter_366_7 in pairs(arg_363_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_366_7 then
						iter_366_7.color = arg_363_1.isInRecall_ and (arg_363_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_363_1.var_.actorSpriteComps1028 = nil
			end

			local var_366_5 = arg_363_1.actors_["10108"].transform

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos10108 = var_366_5.localPosition
				var_366_5.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("10108", 2)

				for iter_366_8 = 0, var_366_5.childCount - 1 do
					local var_366_6 = var_366_5:GetChild(iter_366_8)

					if var_366_6.name == "split_4" or not string.find(var_366_6.name, "split") then
						var_366_6.gameObject:SetActive(true)
					else
						var_366_6.gameObject:SetActive(false)
					end
				end
			end

			local var_366_7 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				var_366_5.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10108, Vector3.New(-390, -399.6, -130), (arg_363_1.time_ - 0) / var_366_7)
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				var_366_5.localPosition = Vector3.New(-390, -399.6, -130)
			end

			local var_366_8 = arg_363_1.actors_["1028"].transform

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1028 = var_366_8.localPosition
				var_366_8.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("1028", 4)

				for iter_366_9 = 0, var_366_8.childCount - 1 do
					local var_366_9 = var_366_8:GetChild(iter_366_9)

					if var_366_9.name == "split_2" or not string.find(var_366_9.name, "split") then
						var_366_9.gameObject:SetActive(true)
					else
						var_366_9.gameObject:SetActive(false)
					end
				end
			end

			local var_366_10 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_10 then
				var_366_8.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_363_1.time_ - 0) / var_366_10)
			end

			if arg_363_1.time_ >= 0 + var_366_10 and arg_363_1.time_ < 0 + var_366_10 + arg_366_0 then
				var_366_8.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_366_11 = 0
			local var_366_12 = 0.375

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_11 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_13 = arg_363_1:GetWordFromCfg(416011088)
				local var_366_14 = arg_363_1:FormatText(var_366_13.content)

				arg_363_1.text_.text = var_366_14

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_16 = 15 <= 0 and var_366_12 or var_366_12 * (utf8.len(var_366_14) / 15)

				if (15 <= 0 and var_366_12 or var_366_12 * (utf8.len(var_366_14) / 15)) > 0 and var_366_12 < var_366_16 then
					arg_363_1.talkMaxDuration = var_366_16

					if var_366_16 + var_366_11 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_16 + var_366_11
					end
				end

				arg_363_1.text_.text = var_366_14
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011088", "story_v_out_416011.awb") ~= 0 then
					local var_366_17 = manager.audio:GetVoiceLength("story_v_out_416011", "416011088", "story_v_out_416011.awb") / 1000

					if var_366_17 + var_366_11 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_17 + var_366_11
					end

					if var_366_13.prefab_name ~= "" and arg_363_1.actors_[var_366_13.prefab_name] ~= nil then
						local var_366_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_13.prefab_name].transform, "story_v_out_416011", "416011088", "story_v_out_416011.awb")

						arg_363_1:RecordAudio("416011088", var_366_18)
						arg_363_1:RecordAudio("416011088", var_366_18)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_416011", "416011088", "story_v_out_416011.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_416011", "416011088", "story_v_out_416011.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_19 = math.max(var_366_12, arg_363_1.talkMaxDuration)

			if var_366_11 <= arg_363_1.time_ and arg_363_1.time_ < var_366_11 + var_366_19 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_11) / var_366_19

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_11 + var_366_19 and arg_363_1.time_ < var_366_11 + var_366_19 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play416011089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 416011089
		arg_367_1.duration_ = 5.7

		local var_367_0 = {
			zh = 5.2,
			ja = 5.7
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
				arg_367_0:Play416011090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1028 = arg_367_1.actors_["1028"].transform.localPosition
				arg_367_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("1028", 4)

				for iter_370_0 = 0, arg_367_1.actors_["1028"].transform.childCount - 1 do
					local var_370_0 = arg_367_1.actors_["1028"].transform:GetChild(iter_370_0)

					if var_370_0.name == "split_4" or not string.find(var_370_0.name, "split") then
						var_370_0.gameObject:SetActive(true)
					else
						var_370_0.gameObject:SetActive(false)
					end
				end
			end

			local var_370_1 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_1 then
				arg_367_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_367_1.time_ - 0) / var_370_1)
			end

			if arg_367_1.time_ >= 0 + var_370_1 and arg_367_1.time_ < 0 + var_370_1 + arg_370_0 then
				arg_367_1.actors_["1028"].transform.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_370_2 = 0
			local var_370_3 = 0.65

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_2 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_4 = arg_367_1:GetWordFromCfg(416011089)
				local var_370_5 = arg_367_1:FormatText(var_370_4.content)

				arg_367_1.text_.text = var_370_5

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_7 = 26 <= 0 and var_370_3 or var_370_3 * (utf8.len(var_370_5) / 26)

				if (26 <= 0 and var_370_3 or var_370_3 * (utf8.len(var_370_5) / 26)) > 0 and var_370_3 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_2 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_2
					end
				end

				arg_367_1.text_.text = var_370_5
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011089", "story_v_out_416011.awb") ~= 0 then
					local var_370_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011089", "story_v_out_416011.awb") / 1000

					if var_370_8 + var_370_2 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_8 + var_370_2
					end

					if var_370_4.prefab_name ~= "" and arg_367_1.actors_[var_370_4.prefab_name] ~= nil then
						local var_370_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_4.prefab_name].transform, "story_v_out_416011", "416011089", "story_v_out_416011.awb")

						arg_367_1:RecordAudio("416011089", var_370_9)
						arg_367_1:RecordAudio("416011089", var_370_9)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_416011", "416011089", "story_v_out_416011.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_416011", "416011089", "story_v_out_416011.awb")
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

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play416011090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 416011090
		arg_371_1.duration_ = 8.03

		local var_371_0 = {
			zh = 7.4,
			ja = 8.033
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
				arg_371_0:Play416011091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["1028"]) and arg_371_1.var_.actorSpriteComps1028 == nil then
				arg_371_1.var_.actorSpriteComps1028 = arg_371_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_0 = 0.125

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["1028"]) then
				if arg_371_1.var_.actorSpriteComps1028 then
					for iter_374_0, iter_374_1 in pairs(arg_371_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_374_1 then
							if arg_371_1.isInRecall_ then
								iter_374_1.color = Color.New(Mathf.Lerp(iter_374_1.color.r, arg_371_1.hightColor2.r, (arg_371_1.time_ - 0) / var_374_0), Mathf.Lerp(iter_374_1.color.g, arg_371_1.hightColor2.g, (arg_371_1.time_ - 0) / var_374_0), (Mathf.Lerp(iter_374_1.color.b, arg_371_1.hightColor2.b, (arg_371_1.time_ - 0) / var_374_0)))
							else
								local var_374_1 = Mathf.Lerp(iter_374_1.color.r, 0.5, (arg_371_1.time_ - 0) / var_374_0)

								iter_374_1.color = Color.New(var_374_1, var_374_1, var_374_1)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["1028"]) and arg_371_1.var_.actorSpriteComps1028 then
				for iter_374_2, iter_374_3 in pairs(arg_371_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_374_3 then
						iter_374_3.color = arg_371_1.isInRecall_ and (arg_371_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_371_1.var_.actorSpriteComps1028 = nil
			end

			local var_374_2 = arg_371_1.actors_["10108"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.actorSpriteComps10108 == nil then
				arg_371_1.var_.actorSpriteComps10108 = var_374_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_3 = 0.125

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_3 and not isNil(var_374_2) then
				if arg_371_1.var_.actorSpriteComps10108 then
					for iter_374_4, iter_374_5 in pairs(arg_371_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_374_5 then
							if arg_371_1.isInRecall_ then
								iter_374_5.color = Color.New(Mathf.Lerp(iter_374_5.color.r, arg_371_1.hightColor1.r, (arg_371_1.time_ - 0) / var_374_3), Mathf.Lerp(iter_374_5.color.g, arg_371_1.hightColor1.g, (arg_371_1.time_ - 0) / var_374_3), (Mathf.Lerp(iter_374_5.color.b, arg_371_1.hightColor1.b, (arg_371_1.time_ - 0) / var_374_3)))
							else
								local var_374_4 = Mathf.Lerp(iter_374_5.color.r, 1, (arg_371_1.time_ - 0) / var_374_3)

								iter_374_5.color = Color.New(var_374_4, var_374_4, var_374_4)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= 0 + var_374_3 and arg_371_1.time_ < 0 + var_374_3 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.actorSpriteComps10108 then
				for iter_374_6, iter_374_7 in pairs(arg_371_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_374_7 then
						iter_374_7.color = arg_371_1.isInRecall_ and (arg_371_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_371_1.var_.actorSpriteComps10108 = nil
			end

			local var_374_5 = 0
			local var_374_6 = 0.6

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_5 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_7 = arg_371_1:GetWordFromCfg(416011090)
				local var_374_8 = arg_371_1:FormatText(var_374_7.content)

				arg_371_1.text_.text = var_374_8

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_10 = 24 <= 0 and var_374_6 or var_374_6 * (utf8.len(var_374_8) / 24)

				if (24 <= 0 and var_374_6 or var_374_6 * (utf8.len(var_374_8) / 24)) > 0 and var_374_6 < var_374_10 then
					arg_371_1.talkMaxDuration = var_374_10

					if var_374_10 + var_374_5 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_10 + var_374_5
					end
				end

				arg_371_1.text_.text = var_374_8
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011090", "story_v_out_416011.awb") ~= 0 then
					local var_374_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011090", "story_v_out_416011.awb") / 1000

					if var_374_11 + var_374_5 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_11 + var_374_5
					end

					if var_374_7.prefab_name ~= "" and arg_371_1.actors_[var_374_7.prefab_name] ~= nil then
						local var_374_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_7.prefab_name].transform, "story_v_out_416011", "416011090", "story_v_out_416011.awb")

						arg_371_1:RecordAudio("416011090", var_374_12)
						arg_371_1:RecordAudio("416011090", var_374_12)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_416011", "416011090", "story_v_out_416011.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_416011", "416011090", "story_v_out_416011.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_13 = math.max(var_374_6, arg_371_1.talkMaxDuration)

			if var_374_5 <= arg_371_1.time_ and arg_371_1.time_ < var_374_5 + var_374_13 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_5) / var_374_13

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_5 + var_374_13 and arg_371_1.time_ < var_374_5 + var_374_13 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play416011091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 416011091
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play416011092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1028 = arg_375_1.actors_["1028"].transform.localPosition
				arg_375_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("1028", 7)

				for iter_378_0 = 0, arg_375_1.actors_["1028"].transform.childCount - 1 do
					local var_378_0 = arg_375_1.actors_["1028"].transform:GetChild(iter_378_0)

					if var_378_0.name == "" or not string.find(var_378_0.name, "split") then
						var_378_0.gameObject:SetActive(true)
					else
						var_378_0.gameObject:SetActive(false)
					end
				end
			end

			local var_378_1 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_1 then
				arg_375_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_375_1.time_ - 0) / var_378_1)
			end

			if arg_375_1.time_ >= 0 + var_378_1 and arg_375_1.time_ < 0 + var_378_1 + arg_378_0 then
				arg_375_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_378_2 = arg_375_1.actors_["10108"].transform

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos10108 = var_378_2.localPosition
				var_378_2.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("10108", 7)

				for iter_378_1 = 0, var_378_2.childCount - 1 do
					local var_378_3 = var_378_2:GetChild(iter_378_1)

					if var_378_3.name == "" or not string.find(var_378_3.name, "split") then
						var_378_3.gameObject:SetActive(true)
					else
						var_378_3.gameObject:SetActive(false)
					end
				end
			end

			local var_378_4 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				var_378_2.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_375_1.time_ - 0) / var_378_4)
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				var_378_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_378_5 = 0
			local var_378_6 = 1.275

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_5 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_7 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(416011091).content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 51 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_7) / 51)

				if (51 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_7) / 51)) > 0 and var_378_6 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_5 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_5
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_10 = math.max(var_378_6, arg_375_1.talkMaxDuration)

			if var_378_5 <= arg_375_1.time_ and arg_375_1.time_ < var_378_5 + var_378_10 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_5) / var_378_10

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_5 + var_378_10 and arg_375_1.time_ < var_378_5 + var_378_10 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play416011092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 416011092
		arg_379_1.duration_ = 4.97

		local var_379_0 = {
			zh = 2.5,
			ja = 4.966
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
				arg_379_0:Play416011093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["10108"]) and arg_379_1.var_.actorSpriteComps10108 == nil then
				arg_379_1.var_.actorSpriteComps10108 = arg_379_1.actors_["10108"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_0 = 0.125

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["10108"]) then
				if arg_379_1.var_.actorSpriteComps10108 then
					for iter_382_0, iter_382_1 in pairs(arg_379_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_382_1 then
							if arg_379_1.isInRecall_ then
								iter_382_1.color = Color.New(Mathf.Lerp(iter_382_1.color.r, arg_379_1.hightColor1.r, (arg_379_1.time_ - 0) / var_382_0), Mathf.Lerp(iter_382_1.color.g, arg_379_1.hightColor1.g, (arg_379_1.time_ - 0) / var_382_0), (Mathf.Lerp(iter_382_1.color.b, arg_379_1.hightColor1.b, (arg_379_1.time_ - 0) / var_382_0)))
							else
								local var_382_1 = Mathf.Lerp(iter_382_1.color.r, 1, (arg_379_1.time_ - 0) / var_382_0)

								iter_382_1.color = Color.New(var_382_1, var_382_1, var_382_1)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["10108"]) and arg_379_1.var_.actorSpriteComps10108 then
				for iter_382_2, iter_382_3 in pairs(arg_379_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_382_3 then
						iter_382_3.color = arg_379_1.isInRecall_ and (arg_379_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_379_1.var_.actorSpriteComps10108 = nil
			end

			local var_382_2 = arg_379_1.actors_["10108"].transform

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos10108 = var_382_2.localPosition
				var_382_2.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("10108", 3)

				for iter_382_4 = 0, var_382_2.childCount - 1 do
					local var_382_3 = var_382_2:GetChild(iter_382_4)

					if var_382_3.name == "split_2" or not string.find(var_382_3.name, "split") then
						var_382_3.gameObject:SetActive(true)
					else
						var_382_3.gameObject:SetActive(false)
					end
				end
			end

			local var_382_4 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_4 then
				var_382_2.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos10108, Vector3.New(0, -399.6, -130), (arg_379_1.time_ - 0) / var_382_4)
			end

			if arg_379_1.time_ >= 0 + var_382_4 and arg_379_1.time_ < 0 + var_382_4 + arg_382_0 then
				var_382_2.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_382_5 = 0
			local var_382_6 = 0.225

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_5 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_7 = arg_379_1:GetWordFromCfg(416011092)
				local var_382_8 = arg_379_1:FormatText(var_382_7.content)

				arg_379_1.text_.text = var_382_8

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_10 = 9 <= 0 and var_382_6 or var_382_6 * (utf8.len(var_382_8) / 9)

				if (9 <= 0 and var_382_6 or var_382_6 * (utf8.len(var_382_8) / 9)) > 0 and var_382_6 < var_382_10 then
					arg_379_1.talkMaxDuration = var_382_10

					if var_382_10 + var_382_5 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_10 + var_382_5
					end
				end

				arg_379_1.text_.text = var_382_8
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011092", "story_v_out_416011.awb") ~= 0 then
					local var_382_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011092", "story_v_out_416011.awb") / 1000

					if var_382_11 + var_382_5 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_11 + var_382_5
					end

					if var_382_7.prefab_name ~= "" and arg_379_1.actors_[var_382_7.prefab_name] ~= nil then
						local var_382_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_7.prefab_name].transform, "story_v_out_416011", "416011092", "story_v_out_416011.awb")

						arg_379_1:RecordAudio("416011092", var_382_12)
						arg_379_1:RecordAudio("416011092", var_382_12)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_416011", "416011092", "story_v_out_416011.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_416011", "416011092", "story_v_out_416011.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_13 = math.max(var_382_6, arg_379_1.talkMaxDuration)

			if var_382_5 <= arg_379_1.time_ and arg_379_1.time_ < var_382_5 + var_382_13 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_5) / var_382_13

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_5 + var_382_13 and arg_379_1.time_ < var_382_5 + var_382_13 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play416011093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 416011093
		arg_383_1.duration_ = 10.3

		local var_383_0 = {
			zh = 9.2,
			ja = 10.3
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
				arg_383_0:Play416011094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if arg_383_1.bgs_.I13f == nil then
				local var_386_0 = Object.Instantiate(arg_383_1.paintGo_)

				var_386_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I13f")
				var_386_0.name = "I13f"
				var_386_0.transform.parent = arg_383_1.stage_.transform
				var_386_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_383_1.bgs_.I13f = var_386_0
			end

			if 2 < arg_383_1.time_ and arg_383_1.time_ <= 2 + arg_386_0 then
				local var_386_1 = arg_383_1.bgs_.I13f

				arg_383_1.bgs_.I13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_386_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_386_2 = var_386_1:GetComponent("SpriteRenderer")

				if var_386_2 and var_386_2.sprite then
					local var_386_3 = 2 * (var_386_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_386_1.transform.localScale = Vector3.New(var_386_3 / var_386_2.sprite.bounds.size.y < var_386_3 * manager.ui.mainCameraCom_.aspect / var_386_2.sprite.bounds.size.x and var_386_3 * manager.ui.mainCameraCom_.aspect / var_386_2.sprite.bounds.size.x or var_386_3 / var_386_2.sprite.bounds.size.y, var_386_3 / var_386_2.sprite.bounds.size.y < var_386_3 * manager.ui.mainCameraCom_.aspect / var_386_2.sprite.bounds.size.x and var_386_3 * manager.ui.mainCameraCom_.aspect / var_386_2.sprite.bounds.size.x or var_386_3 / var_386_2.sprite.bounds.size.y, 0)
				end

				for iter_386_0, iter_386_1 in pairs(arg_383_1.bgs_) do
					if iter_386_0 ~= "I13f" then
						iter_386_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_386_4 = 0

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1.mask_.enabled = true
				arg_383_1.mask_.raycastTarget = true

				arg_383_1:SetGaussion(false)
			end

			local var_386_5 = 2

			if var_386_4 <= arg_383_1.time_ and arg_383_1.time_ < var_386_4 + var_386_5 then
				local var_386_6 = Color.New(0, 0, 0)

				var_386_6.a = Mathf.Lerp(0, 1, (arg_383_1.time_ - var_386_4) / var_386_5)
				arg_383_1.mask_.color = var_386_6
			end

			if arg_383_1.time_ >= var_386_4 + var_386_5 and arg_383_1.time_ < var_386_4 + var_386_5 + arg_386_0 then
				local var_386_7 = Color.New(0, 0, 0)

				var_386_7.a = 1
				arg_383_1.mask_.color = var_386_7
			end

			local var_386_8 = 2

			if 2 < arg_383_1.time_ and arg_383_1.time_ <= var_386_8 + arg_386_0 then
				arg_383_1.mask_.enabled = true
				arg_383_1.mask_.raycastTarget = true

				arg_383_1:SetGaussion(false)
			end

			local var_386_9 = 2

			if var_386_8 <= arg_383_1.time_ and arg_383_1.time_ < var_386_8 + var_386_9 then
				local var_386_10 = Color.New(0, 0, 0)

				var_386_10.a = Mathf.Lerp(1, 0, (arg_383_1.time_ - var_386_8) / var_386_9)
				arg_383_1.mask_.color = var_386_10
			end

			if arg_383_1.time_ >= var_386_8 + var_386_9 and arg_383_1.time_ < var_386_8 + var_386_9 + arg_386_0 then
				local var_386_11 = Color.New(0, 0, 0)

				arg_383_1.mask_.enabled = false
				var_386_11.a = 0
				arg_383_1.mask_.color = var_386_11
			end

			local var_386_12 = arg_383_1.actors_["10108"].transform

			if 1.966 < arg_383_1.time_ and arg_383_1.time_ <= 1.966 + arg_386_0 then
				arg_383_1.var_.moveOldPos10108 = var_386_12.localPosition
				var_386_12.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10108", 7)

				for iter_386_2 = 0, var_386_12.childCount - 1 do
					local var_386_13 = var_386_12:GetChild(iter_386_2)

					if var_386_13.name == "" or not string.find(var_386_13.name, "split") then
						var_386_13.gameObject:SetActive(true)
					else
						var_386_13.gameObject:SetActive(false)
					end
				end
			end

			local var_386_14 = 0.001

			if 1.966 <= arg_383_1.time_ and arg_383_1.time_ < 1.966 + var_386_14 then
				var_386_12.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_383_1.time_ - 1.966) / var_386_14)
			end

			if arg_383_1.time_ >= 1.966 + var_386_14 and arg_383_1.time_ < 1.966 + var_386_14 + arg_386_0 then
				var_386_12.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_386_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_383_1.bgmTxt_.text ~= var_386_17 and arg_383_1.bgmTxt_.text ~= "" then
						if arg_383_1.bgmTxt2_.text ~= "" then
							arg_383_1.bgmTxt_.text = arg_383_1.bgmTxt2_.text
						end

						arg_383_1.bgmTxt2_.text = var_386_17

						arg_383_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_383_1.bgmTxt_.text = var_386_17
						arg_383_1.bgmTxt2_.text = var_386_17
					end

					if arg_383_1.bgmTimer then
						arg_383_1.bgmTimer:Stop()

						arg_383_1.bgmTimer = nil
					end

					if arg_383_1.settingData.show_music_name == 1 then
						arg_383_1.musicController:SetSelectedState("show")
						arg_383_1.musicAnimator_:Play("open", 0, 0)

						if arg_383_1.settingData.music_time ~= 0 then
							arg_383_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_383_1.settingData.music_time), function()
								if arg_383_1 == nil or isNil(arg_383_1.bgmTxt_) then
									return
								end

								arg_383_1.musicController:SetSelectedState("hide")
								arg_383_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_383_1.frameCnt_ <= 1 then
				arg_383_1.dialog_:SetActive(false)
			end

			local var_386_18 = 4
			local var_386_19 = 0.525

			if 4 < arg_383_1.time_ and arg_383_1.time_ <= var_386_18 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				arg_383_1.dialog_:SetActive(true)

				arg_383_1.dialogCg_.alpha = 0

				local var_386_20 = LeanTween.value(arg_383_1.dialog_, 0, 1, 0.3)

				var_386_20:setOnUpdate(LuaHelper.FloatAction(function(arg_388_0)
					arg_383_1.dialogCg_.alpha = arg_388_0
				end))
				var_386_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_383_1.dialog_)
					var_386_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_383_1.duration_ = arg_383_1.duration_ + 0.3

				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_21 = arg_383_1:GetWordFromCfg(416011093)
				local var_386_22 = arg_383_1:FormatText(var_386_21.content)

				arg_383_1.text_.text = var_386_22

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_24 = 21 <= 0 and var_386_19 or var_386_19 * (utf8.len(var_386_22) / 21)

				if (21 <= 0 and var_386_19 or var_386_19 * (utf8.len(var_386_22) / 21)) > 0 and var_386_19 < var_386_24 then
					arg_383_1.talkMaxDuration = var_386_24
					var_386_18 = var_386_18 + 0.3

					if var_386_24 + var_386_18 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_24 + var_386_18
					end
				end

				arg_383_1.text_.text = var_386_22
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011093", "story_v_out_416011.awb") ~= 0 then
					local var_386_25 = manager.audio:GetVoiceLength("story_v_out_416011", "416011093", "story_v_out_416011.awb") / 1000

					if var_386_25 + var_386_18 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_25 + var_386_18
					end

					if var_386_21.prefab_name ~= "" and arg_383_1.actors_[var_386_21.prefab_name] ~= nil then
						local var_386_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_21.prefab_name].transform, "story_v_out_416011", "416011093", "story_v_out_416011.awb")

						arg_383_1:RecordAudio("416011093", var_386_26)
						arg_383_1:RecordAudio("416011093", var_386_26)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_416011", "416011093", "story_v_out_416011.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_416011", "416011093", "story_v_out_416011.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_27 = var_386_18 + 0.3
			local var_386_28 = math.max(var_386_19, arg_383_1.talkMaxDuration)

			if var_386_18 + 0.3 <= arg_383_1.time_ and arg_383_1.time_ < var_386_27 + var_386_28 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_27) / var_386_28

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_27 + var_386_28 and arg_383_1.time_ < var_386_27 + var_386_28 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play416011094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 416011094
		arg_390_1.duration_ = 6.5

		local var_390_0 = {
			zh = 5,
			ja = 6.5
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play416011095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1148 = arg_390_1.actors_["1148"].transform.localPosition
				arg_390_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("1148", 3)

				for iter_393_0 = 0, arg_390_1.actors_["1148"].transform.childCount - 1 do
					local var_393_0 = arg_390_1.actors_["1148"].transform:GetChild(iter_393_0)

					if var_393_0.name == "" or not string.find(var_393_0.name, "split") then
						var_393_0.gameObject:SetActive(true)
					else
						var_393_0.gameObject:SetActive(false)
					end
				end
			end

			local var_393_1 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_1 then
				arg_390_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_390_1.time_ - 0) / var_393_1)
			end

			if arg_390_1.time_ >= 0 + var_393_1 and arg_390_1.time_ < 0 + var_393_1 + arg_393_0 then
				arg_390_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_393_2 = arg_390_1.actors_["1148"]

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(var_393_2) and arg_390_1.var_.actorSpriteComps1148 == nil then
				arg_390_1.var_.actorSpriteComps1148 = var_393_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_3 = 0.125

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_3 and not isNil(var_393_2) then
				if arg_390_1.var_.actorSpriteComps1148 then
					for iter_393_1, iter_393_2 in pairs(arg_390_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_393_2 then
							if arg_390_1.isInRecall_ then
								iter_393_2.color = Color.New(Mathf.Lerp(iter_393_2.color.r, arg_390_1.hightColor1.r, (arg_390_1.time_ - 0) / var_393_3), Mathf.Lerp(iter_393_2.color.g, arg_390_1.hightColor1.g, (arg_390_1.time_ - 0) / var_393_3), (Mathf.Lerp(iter_393_2.color.b, arg_390_1.hightColor1.b, (arg_390_1.time_ - 0) / var_393_3)))
							else
								local var_393_4 = Mathf.Lerp(iter_393_2.color.r, 1, (arg_390_1.time_ - 0) / var_393_3)

								iter_393_2.color = Color.New(var_393_4, var_393_4, var_393_4)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= 0 + var_393_3 and arg_390_1.time_ < 0 + var_393_3 + arg_393_0 and not isNil(var_393_2) and arg_390_1.var_.actorSpriteComps1148 then
				for iter_393_3, iter_393_4 in pairs(arg_390_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_393_4 then
						iter_393_4.color = arg_390_1.isInRecall_ and (arg_390_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_390_1.var_.actorSpriteComps1148 = nil
			end

			local var_393_5 = 0
			local var_393_6 = 0.6

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_5 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_7 = arg_390_1:GetWordFromCfg(416011094)
				local var_393_8 = arg_390_1:FormatText(var_393_7.content)

				arg_390_1.text_.text = var_393_8

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_10 = 24 <= 0 and var_393_6 or var_393_6 * (utf8.len(var_393_8) / 24)

				if (24 <= 0 and var_393_6 or var_393_6 * (utf8.len(var_393_8) / 24)) > 0 and var_393_6 < var_393_10 then
					arg_390_1.talkMaxDuration = var_393_10

					if var_393_10 + var_393_5 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_10 + var_393_5
					end
				end

				arg_390_1.text_.text = var_393_8
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011094", "story_v_out_416011.awb") ~= 0 then
					local var_393_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011094", "story_v_out_416011.awb") / 1000

					if var_393_11 + var_393_5 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_11 + var_393_5
					end

					if var_393_7.prefab_name ~= "" and arg_390_1.actors_[var_393_7.prefab_name] ~= nil then
						local var_393_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_7.prefab_name].transform, "story_v_out_416011", "416011094", "story_v_out_416011.awb")

						arg_390_1:RecordAudio("416011094", var_393_12)
						arg_390_1:RecordAudio("416011094", var_393_12)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_416011", "416011094", "story_v_out_416011.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_416011", "416011094", "story_v_out_416011.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_13 = math.max(var_393_6, arg_390_1.talkMaxDuration)

			if var_393_5 <= arg_390_1.time_ and arg_390_1.time_ < var_393_5 + var_393_13 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_5) / var_393_13

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_5 + var_393_13 and arg_390_1.time_ < var_393_5 + var_393_13 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play416011095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 416011095
		arg_394_1.duration_ = 6.67

		local var_394_0 = {
			zh = 4.5,
			ja = 6.666
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play416011096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.425

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_1 = arg_394_1:GetWordFromCfg(416011095)
				local var_397_2 = arg_394_1:FormatText(var_397_1.content)

				arg_394_1.text_.text = var_397_2

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_4 = 17 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_2) / 17)

				if (17 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_2) / 17)) > 0 and var_397_0 < var_397_4 then
					arg_394_1.talkMaxDuration = var_397_4

					if var_397_4 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_4 + 0
					end
				end

				arg_394_1.text_.text = var_397_2
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011095", "story_v_out_416011.awb") ~= 0 then
					local var_397_5 = manager.audio:GetVoiceLength("story_v_out_416011", "416011095", "story_v_out_416011.awb") / 1000

					if var_397_5 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_5 + 0
					end

					if var_397_1.prefab_name ~= "" and arg_394_1.actors_[var_397_1.prefab_name] ~= nil then
						local var_397_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_1.prefab_name].transform, "story_v_out_416011", "416011095", "story_v_out_416011.awb")

						arg_394_1:RecordAudio("416011095", var_397_6)
						arg_394_1:RecordAudio("416011095", var_397_6)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_416011", "416011095", "story_v_out_416011.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_416011", "416011095", "story_v_out_416011.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_7 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_7 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_7

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_7 and arg_394_1.time_ < 0 + var_397_7 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play416011096 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 416011096
		arg_398_1.duration_ = 4.7

		local var_398_0 = {
			zh = 3.433,
			ja = 4.7
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play416011097(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(arg_398_1.actors_["1148"]) and arg_398_1.var_.actorSpriteComps1148 == nil then
				arg_398_1.var_.actorSpriteComps1148 = arg_398_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_401_0 = 0.125

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 and not isNil(arg_398_1.actors_["1148"]) then
				if arg_398_1.var_.actorSpriteComps1148 then
					for iter_401_0, iter_401_1 in pairs(arg_398_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_401_1 then
							if arg_398_1.isInRecall_ then
								iter_401_1.color = Color.New(Mathf.Lerp(iter_401_1.color.r, arg_398_1.hightColor2.r, (arg_398_1.time_ - 0) / var_401_0), Mathf.Lerp(iter_401_1.color.g, arg_398_1.hightColor2.g, (arg_398_1.time_ - 0) / var_401_0), (Mathf.Lerp(iter_401_1.color.b, arg_398_1.hightColor2.b, (arg_398_1.time_ - 0) / var_401_0)))
							else
								local var_401_1 = Mathf.Lerp(iter_401_1.color.r, 0.5, (arg_398_1.time_ - 0) / var_401_0)

								iter_401_1.color = Color.New(var_401_1, var_401_1, var_401_1)
							end
						end
					end
				end
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 and not isNil(arg_398_1.actors_["1148"]) and arg_398_1.var_.actorSpriteComps1148 then
				for iter_401_2, iter_401_3 in pairs(arg_398_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_401_3 then
						iter_401_3.color = arg_398_1.isInRecall_ and (arg_398_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_398_1.var_.actorSpriteComps1148 = nil
			end

			local var_401_2 = 0
			local var_401_3 = 0.275

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_2 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_4 = arg_398_1:GetWordFromCfg(416011096)
				local var_401_5 = arg_398_1:FormatText(var_401_4.content)

				arg_398_1.text_.text = var_401_5

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_7 = 11 <= 0 and var_401_3 or var_401_3 * (utf8.len(var_401_5) / 11)

				if (11 <= 0 and var_401_3 or var_401_3 * (utf8.len(var_401_5) / 11)) > 0 and var_401_3 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_2 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_2
					end
				end

				arg_398_1.text_.text = var_401_5
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011096", "story_v_out_416011.awb") ~= 0 then
					local var_401_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011096", "story_v_out_416011.awb") / 1000

					if var_401_8 + var_401_2 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_8 + var_401_2
					end

					if var_401_4.prefab_name ~= "" and arg_398_1.actors_[var_401_4.prefab_name] ~= nil then
						local var_401_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_4.prefab_name].transform, "story_v_out_416011", "416011096", "story_v_out_416011.awb")

						arg_398_1:RecordAudio("416011096", var_401_9)
						arg_398_1:RecordAudio("416011096", var_401_9)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_416011", "416011096", "story_v_out_416011.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_416011", "416011096", "story_v_out_416011.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_10 = math.max(var_401_3, arg_398_1.talkMaxDuration)

			if var_401_2 <= arg_398_1.time_ and arg_398_1.time_ < var_401_2 + var_401_10 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_2) / var_401_10

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_2 + var_401_10 and arg_398_1.time_ < var_401_2 + var_401_10 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play416011097 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 416011097
		arg_402_1.duration_ = 3.67

		local var_402_0 = {
			zh = 2.4,
			ja = 3.666
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play416011098(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["1148"]) and arg_402_1.var_.actorSpriteComps1148 == nil then
				arg_402_1.var_.actorSpriteComps1148 = arg_402_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_0 = 0.125

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["1148"]) then
				if arg_402_1.var_.actorSpriteComps1148 then
					for iter_405_0, iter_405_1 in pairs(arg_402_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_405_1 then
							if arg_402_1.isInRecall_ then
								iter_405_1.color = Color.New(Mathf.Lerp(iter_405_1.color.r, arg_402_1.hightColor1.r, (arg_402_1.time_ - 0) / var_405_0), Mathf.Lerp(iter_405_1.color.g, arg_402_1.hightColor1.g, (arg_402_1.time_ - 0) / var_405_0), (Mathf.Lerp(iter_405_1.color.b, arg_402_1.hightColor1.b, (arg_402_1.time_ - 0) / var_405_0)))
							else
								local var_405_1 = Mathf.Lerp(iter_405_1.color.r, 1, (arg_402_1.time_ - 0) / var_405_0)

								iter_405_1.color = Color.New(var_405_1, var_405_1, var_405_1)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["1148"]) and arg_402_1.var_.actorSpriteComps1148 then
				for iter_405_2, iter_405_3 in pairs(arg_402_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_405_3 then
						iter_405_3.color = arg_402_1.isInRecall_ and (arg_402_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_402_1.var_.actorSpriteComps1148 = nil
			end

			local var_405_2 = 0
			local var_405_3 = 0.25

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_2 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_4 = arg_402_1:GetWordFromCfg(416011097)
				local var_405_5 = arg_402_1:FormatText(var_405_4.content)

				arg_402_1.text_.text = var_405_5

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_7 = 10 <= 0 and var_405_3 or var_405_3 * (utf8.len(var_405_5) / 10)

				if (10 <= 0 and var_405_3 or var_405_3 * (utf8.len(var_405_5) / 10)) > 0 and var_405_3 < var_405_7 then
					arg_402_1.talkMaxDuration = var_405_7

					if var_405_7 + var_405_2 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_2
					end
				end

				arg_402_1.text_.text = var_405_5
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011097", "story_v_out_416011.awb") ~= 0 then
					local var_405_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011097", "story_v_out_416011.awb") / 1000

					if var_405_8 + var_405_2 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_8 + var_405_2
					end

					if var_405_4.prefab_name ~= "" and arg_402_1.actors_[var_405_4.prefab_name] ~= nil then
						local var_405_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_4.prefab_name].transform, "story_v_out_416011", "416011097", "story_v_out_416011.awb")

						arg_402_1:RecordAudio("416011097", var_405_9)
						arg_402_1:RecordAudio("416011097", var_405_9)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_416011", "416011097", "story_v_out_416011.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_416011", "416011097", "story_v_out_416011.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_10 = math.max(var_405_3, arg_402_1.talkMaxDuration)

			if var_405_2 <= arg_402_1.time_ and arg_402_1.time_ < var_405_2 + var_405_10 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_2) / var_405_10

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_2 + var_405_10 and arg_402_1.time_ < var_405_2 + var_405_10 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play416011098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 416011098
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play416011099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos1148 = arg_406_1.actors_["1148"].transform.localPosition
				arg_406_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("1148", 7)

				for iter_409_0 = 0, arg_406_1.actors_["1148"].transform.childCount - 1 do
					local var_409_0 = arg_406_1.actors_["1148"].transform:GetChild(iter_409_0)

					if var_409_0.name == "" or not string.find(var_409_0.name, "split") then
						var_409_0.gameObject:SetActive(true)
					else
						var_409_0.gameObject:SetActive(false)
					end
				end
			end

			local var_409_1 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_1 then
				arg_406_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_406_1.time_ - 0) / var_409_1)
			end

			if arg_406_1.time_ >= 0 + var_409_1 and arg_406_1.time_ < 0 + var_409_1 + arg_409_0 then
				arg_406_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			local var_409_3 = 0
			local var_409_4 = 2.075

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_3 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_5 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(416011098).content)

				arg_406_1.text_.text = var_409_5

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_7 = 83 <= 0 and var_409_4 or var_409_4 * (utf8.len(var_409_5) / 83)

				if (83 <= 0 and var_409_4 or var_409_4 * (utf8.len(var_409_5) / 83)) > 0 and var_409_4 < var_409_7 then
					arg_406_1.talkMaxDuration = var_409_7

					if var_409_7 + var_409_3 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_7 + var_409_3
					end
				end

				arg_406_1.text_.text = var_409_5
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_8 = math.max(var_409_4, arg_406_1.talkMaxDuration)

			if var_409_3 <= arg_406_1.time_ and arg_406_1.time_ < var_409_3 + var_409_8 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_3) / var_409_8

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_3 + var_409_8 and arg_406_1.time_ < var_409_3 + var_409_8 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play416011099 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 416011099
		arg_410_1.duration_ = 7.93

		local var_410_0 = {
			zh = 4.933,
			ja = 7.933
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play416011100(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos1148 = arg_410_1.actors_["1148"].transform.localPosition
				arg_410_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("1148", 3)

				for iter_413_0 = 0, arg_410_1.actors_["1148"].transform.childCount - 1 do
					local var_413_0 = arg_410_1.actors_["1148"].transform:GetChild(iter_413_0)

					if var_413_0.name == "" or not string.find(var_413_0.name, "split") then
						var_413_0.gameObject:SetActive(true)
					else
						var_413_0.gameObject:SetActive(false)
					end
				end
			end

			local var_413_1 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_1 then
				arg_410_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_410_1.time_ - 0) / var_413_1)
			end

			if arg_410_1.time_ >= 0 + var_413_1 and arg_410_1.time_ < 0 + var_413_1 + arg_413_0 then
				arg_410_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_413_2 = arg_410_1.actors_["1148"]

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(var_413_2) and arg_410_1.var_.actorSpriteComps1148 == nil then
				arg_410_1.var_.actorSpriteComps1148 = var_413_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_3 = 0.125

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_3 and not isNil(var_413_2) then
				if arg_410_1.var_.actorSpriteComps1148 then
					for iter_413_1, iter_413_2 in pairs(arg_410_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_413_2 then
							if arg_410_1.isInRecall_ then
								iter_413_2.color = Color.New(Mathf.Lerp(iter_413_2.color.r, arg_410_1.hightColor1.r, (arg_410_1.time_ - 0) / var_413_3), Mathf.Lerp(iter_413_2.color.g, arg_410_1.hightColor1.g, (arg_410_1.time_ - 0) / var_413_3), (Mathf.Lerp(iter_413_2.color.b, arg_410_1.hightColor1.b, (arg_410_1.time_ - 0) / var_413_3)))
							else
								local var_413_4 = Mathf.Lerp(iter_413_2.color.r, 1, (arg_410_1.time_ - 0) / var_413_3)

								iter_413_2.color = Color.New(var_413_4, var_413_4, var_413_4)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= 0 + var_413_3 and arg_410_1.time_ < 0 + var_413_3 + arg_413_0 and not isNil(var_413_2) and arg_410_1.var_.actorSpriteComps1148 then
				for iter_413_3, iter_413_4 in pairs(arg_410_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_413_4 then
						iter_413_4.color = arg_410_1.isInRecall_ and (arg_410_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_410_1.var_.actorSpriteComps1148 = nil
			end

			local var_413_5 = 0
			local var_413_6 = 0.5

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_5 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_7 = arg_410_1:GetWordFromCfg(416011099)
				local var_413_8 = arg_410_1:FormatText(var_413_7.content)

				arg_410_1.text_.text = var_413_8

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_10 = 20 <= 0 and var_413_6 or var_413_6 * (utf8.len(var_413_8) / 20)

				if (20 <= 0 and var_413_6 or var_413_6 * (utf8.len(var_413_8) / 20)) > 0 and var_413_6 < var_413_10 then
					arg_410_1.talkMaxDuration = var_413_10

					if var_413_10 + var_413_5 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_10 + var_413_5
					end
				end

				arg_410_1.text_.text = var_413_8
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011099", "story_v_out_416011.awb") ~= 0 then
					local var_413_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011099", "story_v_out_416011.awb") / 1000

					if var_413_11 + var_413_5 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_11 + var_413_5
					end

					if var_413_7.prefab_name ~= "" and arg_410_1.actors_[var_413_7.prefab_name] ~= nil then
						local var_413_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_7.prefab_name].transform, "story_v_out_416011", "416011099", "story_v_out_416011.awb")

						arg_410_1:RecordAudio("416011099", var_413_12)
						arg_410_1:RecordAudio("416011099", var_413_12)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_416011", "416011099", "story_v_out_416011.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_416011", "416011099", "story_v_out_416011.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_13 = math.max(var_413_6, arg_410_1.talkMaxDuration)

			if var_413_5 <= arg_410_1.time_ and arg_410_1.time_ < var_413_5 + var_413_13 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_5) / var_413_13

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_5 + var_413_13 and arg_410_1.time_ < var_413_5 + var_413_13 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play416011100 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 416011100
		arg_414_1.duration_ = 8.6

		local var_414_0 = {
			zh = 8.566,
			ja = 8.6
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play416011101(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.7

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_1 = arg_414_1:GetWordFromCfg(416011100)
				local var_417_2 = arg_414_1:FormatText(var_417_1.content)

				arg_414_1.text_.text = var_417_2

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_4 = 28 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 28)

				if (28 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 28)) > 0 and var_417_0 < var_417_4 then
					arg_414_1.talkMaxDuration = var_417_4

					if var_417_4 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_4 + 0
					end
				end

				arg_414_1.text_.text = var_417_2
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011100", "story_v_out_416011.awb") ~= 0 then
					local var_417_5 = manager.audio:GetVoiceLength("story_v_out_416011", "416011100", "story_v_out_416011.awb") / 1000

					if var_417_5 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_5 + 0
					end

					if var_417_1.prefab_name ~= "" and arg_414_1.actors_[var_417_1.prefab_name] ~= nil then
						local var_417_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_1.prefab_name].transform, "story_v_out_416011", "416011100", "story_v_out_416011.awb")

						arg_414_1:RecordAudio("416011100", var_417_6)
						arg_414_1:RecordAudio("416011100", var_417_6)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_416011", "416011100", "story_v_out_416011.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_416011", "416011100", "story_v_out_416011.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_7 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_7 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_7

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_7 and arg_414_1.time_ < 0 + var_417_7 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play416011101 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 416011101
		arg_418_1.duration_ = 9

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play416011102(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_9000

			if arg_418_1.bgs_.SS1601 == nil then
				local var_421_0 = Object.Instantiate(arg_418_1.paintGo_)

				var_421_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1601")
				var_421_0.name = "SS1601"
				var_421_0.transform.parent = arg_418_1.stage_.transform
				var_421_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_418_1.bgs_.SS1601 = var_421_0
			end

			if 2 < arg_418_1.time_ and arg_418_1.time_ <= 2 + arg_421_0 then
				local var_421_1 = arg_418_1.bgs_.SS1601

				arg_418_1.bgs_.SS1601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_421_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_421_2 = var_421_1:GetComponent("SpriteRenderer")

				if var_421_2 and var_421_2.sprite then
					local var_421_3 = 2 * (var_421_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_421_1.transform.localScale = Vector3.New(var_421_3 / var_421_2.sprite.bounds.size.y < var_421_3 * manager.ui.mainCameraCom_.aspect / var_421_2.sprite.bounds.size.x and var_421_3 * manager.ui.mainCameraCom_.aspect / var_421_2.sprite.bounds.size.x or var_421_3 / var_421_2.sprite.bounds.size.y, var_421_3 / var_421_2.sprite.bounds.size.y < var_421_3 * manager.ui.mainCameraCom_.aspect / var_421_2.sprite.bounds.size.x and var_421_3 * manager.ui.mainCameraCom_.aspect / var_421_2.sprite.bounds.size.x or var_421_3 / var_421_2.sprite.bounds.size.y, 0)
				end

				for iter_421_0, iter_421_1 in pairs(arg_418_1.bgs_) do
					if iter_421_0 ~= "SS1601" then
						iter_421_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_421_4 = 0

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_4 + arg_421_0 then
				arg_418_1.mask_.enabled = true
				arg_418_1.mask_.raycastTarget = true

				arg_418_1:SetGaussion(false)
			end

			local var_421_5 = 2

			if var_421_4 <= arg_418_1.time_ and arg_418_1.time_ < var_421_4 + var_421_5 then
				local var_421_6 = Color.New(0, 0, 0)

				var_421_6.a = Mathf.Lerp(0, 1, (arg_418_1.time_ - var_421_4) / var_421_5)
				arg_418_1.mask_.color = var_421_6
			end

			if arg_418_1.time_ >= var_421_4 + var_421_5 and arg_418_1.time_ < var_421_4 + var_421_5 + arg_421_0 then
				local var_421_7 = Color.New(0, 0, 0)

				var_421_7.a = 1
				arg_418_1.mask_.color = var_421_7
			end

			local var_421_8 = 2

			if 2 < arg_418_1.time_ and arg_418_1.time_ <= var_421_8 + arg_421_0 then
				arg_418_1.mask_.enabled = true
				arg_418_1.mask_.raycastTarget = true

				arg_418_1:SetGaussion(false)
			end

			local var_421_9 = 2

			if var_421_8 <= arg_418_1.time_ and arg_418_1.time_ < var_421_8 + var_421_9 then
				local var_421_10 = Color.New(0, 0, 0)

				var_421_10.a = Mathf.Lerp(1, 0, (arg_418_1.time_ - var_421_8) / var_421_9)
				arg_418_1.mask_.color = var_421_10
			end

			if arg_418_1.time_ >= var_421_8 + var_421_9 and arg_418_1.time_ < var_421_8 + var_421_9 + arg_421_0 then
				local var_421_11 = Color.New(0, 0, 0)

				arg_418_1.mask_.enabled = false
				var_421_11.a = 0
				arg_418_1.mask_.color = var_421_11
			end

			local var_421_12 = arg_418_1.actors_["1148"].transform

			if 1.966 < arg_418_1.time_ and arg_418_1.time_ <= 1.966 + arg_421_0 then
				arg_418_1.var_.moveOldPos1148 = var_421_12.localPosition
				var_421_12.localScale = Vector3.New(1, 1, 1)

				arg_418_1:CheckSpriteTmpPos("1148", 7)

				for iter_421_2 = 0, var_421_12.childCount - 1 do
					local var_421_13 = var_421_12:GetChild(iter_421_2)

					if var_421_13.name == "" or not string.find(var_421_13.name, "split") then
						var_421_13.gameObject:SetActive(true)
					else
						var_421_13.gameObject:SetActive(false)
					end
				end
			end

			local var_421_14 = 0.001

			if 1.966 <= arg_418_1.time_ and arg_418_1.time_ < 1.966 + var_421_14 then
				var_421_12.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_418_1.time_ - 1.966) / var_421_14)
			end

			if arg_418_1.time_ >= 1.966 + var_421_14 and arg_418_1.time_ < 1.966 + var_421_14 + arg_421_0 then
				var_421_12.localPosition = Vector3.New(0, -2000, 0)
			end

			if 2.03333333333333 < arg_418_1.time_ and arg_418_1.time_ <= 2.03333333333333 + arg_421_0 then
				local var_421_15 = arg_418_1.var_.effect1055

				if not arg_418_1.var_.effect1055 then
					var_421_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_mist_keep"), manager.ui.mainCamera.transform)
					var_421_15.name = "1055"
					arg_418_1.var_.effect1055 = var_421_15
				else
					var_421_15.transform:SetParent(var_421_9000)
				end

				var_421_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_421_15.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_421_17 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_421_3, iter_421_4 in ipairs((var_421_15.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_421_4.transform.localScale = Vector3.New(iter_421_4.transform.localScale.x / var_421_17 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_421_4.transform.localScale.y / var_421_17, iter_421_4.transform.localScale.z)
				end
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_421_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_418_1.bgmTxt_.text ~= var_421_21 and arg_418_1.bgmTxt_.text ~= "" then
						if arg_418_1.bgmTxt2_.text ~= "" then
							arg_418_1.bgmTxt_.text = arg_418_1.bgmTxt2_.text
						end

						arg_418_1.bgmTxt2_.text = var_421_21

						arg_418_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_418_1.bgmTxt_.text = var_421_21
						arg_418_1.bgmTxt2_.text = var_421_21
					end

					if arg_418_1.bgmTimer then
						arg_418_1.bgmTimer:Stop()

						arg_418_1.bgmTimer = nil
					end

					if arg_418_1.settingData.show_music_name == 1 then
						arg_418_1.musicController:SetSelectedState("show")
						arg_418_1.musicAnimator_:Play("open", 0, 0)

						if arg_418_1.settingData.music_time ~= 0 then
							arg_418_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_418_1.settingData.music_time), function()
								if arg_418_1 == nil or isNil(arg_418_1.bgmTxt_) then
									return
								end

								arg_418_1.musicController:SetSelectedState("hide")
								arg_418_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.43333333333333 < arg_418_1.time_ and arg_418_1.time_ <= 1.43333333333333 + arg_421_0 then
				arg_418_1:AudioAction("play", "music", "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide.awb")

				local var_421_24 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide")

				if "" ~= "" then
					if arg_418_1.bgmTxt_.text ~= var_421_24 and arg_418_1.bgmTxt_.text ~= "" then
						if arg_418_1.bgmTxt2_.text ~= "" then
							arg_418_1.bgmTxt_.text = arg_418_1.bgmTxt2_.text
						end

						arg_418_1.bgmTxt2_.text = var_421_24

						arg_418_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_418_1.bgmTxt_.text = var_421_24
						arg_418_1.bgmTxt2_.text = var_421_24
					end

					if arg_418_1.bgmTimer then
						arg_418_1.bgmTimer:Stop()

						arg_418_1.bgmTimer = nil
					end

					if arg_418_1.settingData.show_music_name == 1 then
						arg_418_1.musicController:SetSelectedState("show")
						arg_418_1.musicAnimator_:Play("open", 0, 0)

						if arg_418_1.settingData.music_time ~= 0 then
							arg_418_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_418_1.settingData.music_time), function()
								if arg_418_1 == nil or isNil(arg_418_1.bgmTxt_) then
									return
								end

								arg_418_1.musicController:SetSelectedState("hide")
								arg_418_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_418_1.frameCnt_ <= 1 then
				arg_418_1.dialog_:SetActive(false)
			end

			local var_421_25 = 4
			local var_421_26 = 1.625

			if 4 < arg_418_1.time_ and arg_418_1.time_ <= var_421_25 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0

				arg_418_1.dialog_:SetActive(true)

				arg_418_1.dialogCg_.alpha = 0

				local var_421_27 = LeanTween.value(arg_418_1.dialog_, 0, 1, 0.3)

				var_421_27:setOnUpdate(LuaHelper.FloatAction(function(arg_424_0)
					arg_418_1.dialogCg_.alpha = arg_424_0
				end))
				var_421_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_418_1.dialog_)
					var_421_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_418_1.duration_ = arg_418_1.duration_ + 0.3

				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_28 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(416011101).content)

				arg_418_1.text_.text = var_421_28

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_30 = 65 <= 0 and var_421_26 or var_421_26 * (utf8.len(var_421_28) / 65)

				if (65 <= 0 and var_421_26 or var_421_26 * (utf8.len(var_421_28) / 65)) > 0 and var_421_26 < var_421_30 then
					arg_418_1.talkMaxDuration = var_421_30
					var_421_25 = var_421_25 + 0.3

					if var_421_30 + var_421_25 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_30 + var_421_25
					end
				end

				arg_418_1.text_.text = var_421_28
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_31 = var_421_25 + 0.3
			local var_421_32 = math.max(var_421_26, arg_418_1.talkMaxDuration)

			if var_421_25 + 0.3 <= arg_418_1.time_ and arg_418_1.time_ < var_421_31 + var_421_32 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_31) / var_421_32

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_31 + var_421_32 and arg_418_1.time_ < var_421_31 + var_421_32 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_418_1:InitPlayNodeList()
	end,
	Play416011102 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 416011102
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play416011103(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 1.675

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_1 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(416011102).content)

				arg_426_1.text_.text = var_429_1

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_3 = 67 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 67)

				if (67 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 67)) > 0 and var_429_0 < var_429_3 then
					arg_426_1.talkMaxDuration = var_429_3

					if var_429_3 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_3 + 0
					end
				end

				arg_426_1.text_.text = var_429_1
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_4 = math.max(var_429_0, arg_426_1.talkMaxDuration)

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_4 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - 0) / var_429_4

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= 0 + var_429_4 and arg_426_1.time_ < 0 + var_429_4 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play416011103 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 416011103
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play416011104(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 1.05

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_1 = arg_430_1:FormatText(arg_430_1:GetWordFromCfg(416011103).content)

				arg_430_1.text_.text = var_433_1

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_3 = 42 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_1) / 42)

				if (42 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_1) / 42)) > 0 and var_433_0 < var_433_3 then
					arg_430_1.talkMaxDuration = var_433_3

					if var_433_3 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_3 + 0
					end
				end

				arg_430_1.text_.text = var_433_1
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_4 = math.max(var_433_0, arg_430_1.talkMaxDuration)

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_4 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - 0) / var_433_4

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= 0 + var_433_4 and arg_430_1.time_ < 0 + var_433_4 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play416011104 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 416011104
		arg_434_1.duration_ = 7.17

		local var_434_0 = {
			zh = 5.3,
			ja = 7.166
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play416011105(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0.4

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_1 = arg_434_1:GetWordFromCfg(416011104)
				local var_437_2 = arg_434_1:FormatText(var_437_1.content)

				arg_434_1.text_.text = var_437_2

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_4 = 16 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 16)

				if (16 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 16)) > 0 and var_437_0 < var_437_4 then
					arg_434_1.talkMaxDuration = var_437_4

					if var_437_4 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_4 + 0
					end
				end

				arg_434_1.text_.text = var_437_2
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011104", "story_v_out_416011.awb") ~= 0 then
					local var_437_5 = manager.audio:GetVoiceLength("story_v_out_416011", "416011104", "story_v_out_416011.awb") / 1000

					if var_437_5 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_5 + 0
					end

					if var_437_1.prefab_name ~= "" and arg_434_1.actors_[var_437_1.prefab_name] ~= nil then
						local var_437_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_1.prefab_name].transform, "story_v_out_416011", "416011104", "story_v_out_416011.awb")

						arg_434_1:RecordAudio("416011104", var_437_6)
						arg_434_1:RecordAudio("416011104", var_437_6)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_416011", "416011104", "story_v_out_416011.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_416011", "416011104", "story_v_out_416011.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_7 = math.max(var_437_0, arg_434_1.talkMaxDuration)

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_7 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - 0) / var_437_7

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= 0 + var_437_7 and arg_434_1.time_ < 0 + var_437_7 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play416011105 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 416011105
		arg_438_1.duration_ = 2.6

		local var_438_0 = {
			zh = 1.666,
			ja = 2.6
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
				arg_438_0:Play416011106(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.var_.moveOldPos1148 = arg_438_1.actors_["1148"].transform.localPosition
				arg_438_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_438_1:CheckSpriteTmpPos("1148", 3)

				for iter_441_0 = 0, arg_438_1.actors_["1148"].transform.childCount - 1 do
					local var_441_0 = arg_438_1.actors_["1148"].transform:GetChild(iter_441_0)

					if var_441_0.name == "" or not string.find(var_441_0.name, "split") then
						var_441_0.gameObject:SetActive(true)
					else
						var_441_0.gameObject:SetActive(false)
					end
				end
			end

			local var_441_1 = 0.001

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_1 then
				arg_438_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_438_1.time_ - 0) / var_441_1)
			end

			if arg_438_1.time_ >= 0 + var_441_1 and arg_438_1.time_ < 0 + var_441_1 + arg_441_0 then
				arg_438_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_441_2 = arg_438_1.actors_["1148"]

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(var_441_2) and arg_438_1.var_.actorSpriteComps1148 == nil then
				arg_438_1.var_.actorSpriteComps1148 = var_441_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_441_3 = 0.125

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_3 and not isNil(var_441_2) then
				if arg_438_1.var_.actorSpriteComps1148 then
					for iter_441_1, iter_441_2 in pairs(arg_438_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_441_2 then
							if arg_438_1.isInRecall_ then
								iter_441_2.color = Color.New(Mathf.Lerp(iter_441_2.color.r, arg_438_1.hightColor1.r, (arg_438_1.time_ - 0) / var_441_3), Mathf.Lerp(iter_441_2.color.g, arg_438_1.hightColor1.g, (arg_438_1.time_ - 0) / var_441_3), (Mathf.Lerp(iter_441_2.color.b, arg_438_1.hightColor1.b, (arg_438_1.time_ - 0) / var_441_3)))
							else
								local var_441_4 = Mathf.Lerp(iter_441_2.color.r, 1, (arg_438_1.time_ - 0) / var_441_3)

								iter_441_2.color = Color.New(var_441_4, var_441_4, var_441_4)
							end
						end
					end
				end
			end

			if arg_438_1.time_ >= 0 + var_441_3 and arg_438_1.time_ < 0 + var_441_3 + arg_441_0 and not isNil(var_441_2) and arg_438_1.var_.actorSpriteComps1148 then
				for iter_441_3, iter_441_4 in pairs(arg_438_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_441_4 then
						iter_441_4.color = arg_438_1.isInRecall_ and (arg_438_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_438_1.var_.actorSpriteComps1148 = nil
			end

			local var_441_5 = 0
			local var_441_6 = 0.2

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_5 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_7 = arg_438_1:GetWordFromCfg(416011105)
				local var_441_8 = arg_438_1:FormatText(var_441_7.content)

				arg_438_1.text_.text = var_441_8

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_10 = 8 <= 0 and var_441_6 or var_441_6 * (utf8.len(var_441_8) / 8)

				if (8 <= 0 and var_441_6 or var_441_6 * (utf8.len(var_441_8) / 8)) > 0 and var_441_6 < var_441_10 then
					arg_438_1.talkMaxDuration = var_441_10

					if var_441_10 + var_441_5 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_10 + var_441_5
					end
				end

				arg_438_1.text_.text = var_441_8
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011105", "story_v_out_416011.awb") ~= 0 then
					local var_441_11 = manager.audio:GetVoiceLength("story_v_out_416011", "416011105", "story_v_out_416011.awb") / 1000

					if var_441_11 + var_441_5 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_11 + var_441_5
					end

					if var_441_7.prefab_name ~= "" and arg_438_1.actors_[var_441_7.prefab_name] ~= nil then
						local var_441_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_7.prefab_name].transform, "story_v_out_416011", "416011105", "story_v_out_416011.awb")

						arg_438_1:RecordAudio("416011105", var_441_12)
						arg_438_1:RecordAudio("416011105", var_441_12)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_416011", "416011105", "story_v_out_416011.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_416011", "416011105", "story_v_out_416011.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_13 = math.max(var_441_6, arg_438_1.talkMaxDuration)

			if var_441_5 <= arg_438_1.time_ and arg_438_1.time_ < var_441_5 + var_441_13 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_5) / var_441_13

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_5 + var_441_13 and arg_438_1.time_ < var_441_5 + var_441_13 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play416011106 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 416011106
		arg_442_1.duration_ = 3.97

		local var_442_0 = {
			zh = 3.966,
			ja = 2.833
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play416011107(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(arg_442_1.actors_["1148"]) and arg_442_1.var_.actorSpriteComps1148 == nil then
				arg_442_1.var_.actorSpriteComps1148 = arg_442_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_445_0 = 0.125

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 and not isNil(arg_442_1.actors_["1148"]) then
				if arg_442_1.var_.actorSpriteComps1148 then
					for iter_445_0, iter_445_1 in pairs(arg_442_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_445_1 then
							if arg_442_1.isInRecall_ then
								iter_445_1.color = Color.New(Mathf.Lerp(iter_445_1.color.r, arg_442_1.hightColor2.r, (arg_442_1.time_ - 0) / var_445_0), Mathf.Lerp(iter_445_1.color.g, arg_442_1.hightColor2.g, (arg_442_1.time_ - 0) / var_445_0), (Mathf.Lerp(iter_445_1.color.b, arg_442_1.hightColor2.b, (arg_442_1.time_ - 0) / var_445_0)))
							else
								local var_445_1 = Mathf.Lerp(iter_445_1.color.r, 0.5, (arg_442_1.time_ - 0) / var_445_0)

								iter_445_1.color = Color.New(var_445_1, var_445_1, var_445_1)
							end
						end
					end
				end
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 and not isNil(arg_442_1.actors_["1148"]) and arg_442_1.var_.actorSpriteComps1148 then
				for iter_445_2, iter_445_3 in pairs(arg_442_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_445_3 then
						iter_445_3.color = arg_442_1.isInRecall_ and (arg_442_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_442_1.var_.actorSpriteComps1148 = nil
			end

			local var_445_2 = 0
			local var_445_3 = 0.2

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_2 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_4 = arg_442_1:GetWordFromCfg(416011106)
				local var_445_5 = arg_442_1:FormatText(var_445_4.content)

				arg_442_1.text_.text = var_445_5

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_7 = 8 <= 0 and var_445_3 or var_445_3 * (utf8.len(var_445_5) / 8)

				if (8 <= 0 and var_445_3 or var_445_3 * (utf8.len(var_445_5) / 8)) > 0 and var_445_3 < var_445_7 then
					arg_442_1.talkMaxDuration = var_445_7

					if var_445_7 + var_445_2 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_7 + var_445_2
					end
				end

				arg_442_1.text_.text = var_445_5
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011106", "story_v_out_416011.awb") ~= 0 then
					local var_445_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011106", "story_v_out_416011.awb") / 1000

					if var_445_8 + var_445_2 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_8 + var_445_2
					end

					if var_445_4.prefab_name ~= "" and arg_442_1.actors_[var_445_4.prefab_name] ~= nil then
						local var_445_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_4.prefab_name].transform, "story_v_out_416011", "416011106", "story_v_out_416011.awb")

						arg_442_1:RecordAudio("416011106", var_445_9)
						arg_442_1:RecordAudio("416011106", var_445_9)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_416011", "416011106", "story_v_out_416011.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_416011", "416011106", "story_v_out_416011.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_10 = math.max(var_445_3, arg_442_1.talkMaxDuration)

			if var_445_2 <= arg_442_1.time_ and arg_442_1.time_ < var_445_2 + var_445_10 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_2) / var_445_10

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_2 + var_445_10 and arg_442_1.time_ < var_445_2 + var_445_10 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play416011107 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 416011107
		arg_446_1.duration_ = 9.63

		local var_446_0 = {
			zh = 6.6,
			ja = 9.633
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play416011108(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(arg_446_1.actors_["1148"]) and arg_446_1.var_.actorSpriteComps1148 == nil then
				arg_446_1.var_.actorSpriteComps1148 = arg_446_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_0 = 0.125

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 and not isNil(arg_446_1.actors_["1148"]) then
				if arg_446_1.var_.actorSpriteComps1148 then
					for iter_449_0, iter_449_1 in pairs(arg_446_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_449_1 then
							if arg_446_1.isInRecall_ then
								iter_449_1.color = Color.New(Mathf.Lerp(iter_449_1.color.r, arg_446_1.hightColor1.r, (arg_446_1.time_ - 0) / var_449_0), Mathf.Lerp(iter_449_1.color.g, arg_446_1.hightColor1.g, (arg_446_1.time_ - 0) / var_449_0), (Mathf.Lerp(iter_449_1.color.b, arg_446_1.hightColor1.b, (arg_446_1.time_ - 0) / var_449_0)))
							else
								local var_449_1 = Mathf.Lerp(iter_449_1.color.r, 1, (arg_446_1.time_ - 0) / var_449_0)

								iter_449_1.color = Color.New(var_449_1, var_449_1, var_449_1)
							end
						end
					end
				end
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 and not isNil(arg_446_1.actors_["1148"]) and arg_446_1.var_.actorSpriteComps1148 then
				for iter_449_2, iter_449_3 in pairs(arg_446_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_449_3 then
						iter_449_3.color = arg_446_1.isInRecall_ and (arg_446_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_446_1.var_.actorSpriteComps1148 = nil
			end

			local var_449_2 = 0
			local var_449_3 = 0.7

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_2 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_4 = arg_446_1:GetWordFromCfg(416011107)
				local var_449_5 = arg_446_1:FormatText(var_449_4.content)

				arg_446_1.text_.text = var_449_5

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_7 = 28 <= 0 and var_449_3 or var_449_3 * (utf8.len(var_449_5) / 28)

				if (28 <= 0 and var_449_3 or var_449_3 * (utf8.len(var_449_5) / 28)) > 0 and var_449_3 < var_449_7 then
					arg_446_1.talkMaxDuration = var_449_7

					if var_449_7 + var_449_2 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_7 + var_449_2
					end
				end

				arg_446_1.text_.text = var_449_5
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011107", "story_v_out_416011.awb") ~= 0 then
					local var_449_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011107", "story_v_out_416011.awb") / 1000

					if var_449_8 + var_449_2 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_8 + var_449_2
					end

					if var_449_4.prefab_name ~= "" and arg_446_1.actors_[var_449_4.prefab_name] ~= nil then
						local var_449_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_4.prefab_name].transform, "story_v_out_416011", "416011107", "story_v_out_416011.awb")

						arg_446_1:RecordAudio("416011107", var_449_9)
						arg_446_1:RecordAudio("416011107", var_449_9)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_416011", "416011107", "story_v_out_416011.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_416011", "416011107", "story_v_out_416011.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_10 = math.max(var_449_3, arg_446_1.talkMaxDuration)

			if var_449_2 <= arg_446_1.time_ and arg_446_1.time_ < var_449_2 + var_449_10 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_2) / var_449_10

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_2 + var_449_10 and arg_446_1.time_ < var_449_2 + var_449_10 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play416011108 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 416011108
		arg_450_1.duration_ = 9.43

		local var_450_0 = {
			zh = 6.866,
			ja = 9.433
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
				arg_450_0:Play416011109(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(arg_450_1.actors_["1148"]) and arg_450_1.var_.actorSpriteComps1148 == nil then
				arg_450_1.var_.actorSpriteComps1148 = arg_450_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_0 = 0.125

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 and not isNil(arg_450_1.actors_["1148"]) then
				if arg_450_1.var_.actorSpriteComps1148 then
					for iter_453_0, iter_453_1 in pairs(arg_450_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_453_1 then
							if arg_450_1.isInRecall_ then
								iter_453_1.color = Color.New(Mathf.Lerp(iter_453_1.color.r, arg_450_1.hightColor2.r, (arg_450_1.time_ - 0) / var_453_0), Mathf.Lerp(iter_453_1.color.g, arg_450_1.hightColor2.g, (arg_450_1.time_ - 0) / var_453_0), (Mathf.Lerp(iter_453_1.color.b, arg_450_1.hightColor2.b, (arg_450_1.time_ - 0) / var_453_0)))
							else
								local var_453_1 = Mathf.Lerp(iter_453_1.color.r, 0.5, (arg_450_1.time_ - 0) / var_453_0)

								iter_453_1.color = Color.New(var_453_1, var_453_1, var_453_1)
							end
						end
					end
				end
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 and not isNil(arg_450_1.actors_["1148"]) and arg_450_1.var_.actorSpriteComps1148 then
				for iter_453_2, iter_453_3 in pairs(arg_450_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_453_3 then
						iter_453_3.color = arg_450_1.isInRecall_ and (arg_450_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_450_1.var_.actorSpriteComps1148 = nil
			end

			local var_453_2 = 0
			local var_453_3 = 0.65

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_2 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_4 = arg_450_1:GetWordFromCfg(416011108)
				local var_453_5 = arg_450_1:FormatText(var_453_4.content)

				arg_450_1.text_.text = var_453_5

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_7 = 26 <= 0 and var_453_3 or var_453_3 * (utf8.len(var_453_5) / 26)

				if (26 <= 0 and var_453_3 or var_453_3 * (utf8.len(var_453_5) / 26)) > 0 and var_453_3 < var_453_7 then
					arg_450_1.talkMaxDuration = var_453_7

					if var_453_7 + var_453_2 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_7 + var_453_2
					end
				end

				arg_450_1.text_.text = var_453_5
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011108", "story_v_out_416011.awb") ~= 0 then
					local var_453_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011108", "story_v_out_416011.awb") / 1000

					if var_453_8 + var_453_2 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_8 + var_453_2
					end

					if var_453_4.prefab_name ~= "" and arg_450_1.actors_[var_453_4.prefab_name] ~= nil then
						local var_453_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_4.prefab_name].transform, "story_v_out_416011", "416011108", "story_v_out_416011.awb")

						arg_450_1:RecordAudio("416011108", var_453_9)
						arg_450_1:RecordAudio("416011108", var_453_9)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_416011", "416011108", "story_v_out_416011.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_416011", "416011108", "story_v_out_416011.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_10 = math.max(var_453_3, arg_450_1.talkMaxDuration)

			if var_453_2 <= arg_450_1.time_ and arg_450_1.time_ < var_453_2 + var_453_10 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_2) / var_453_10

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_2 + var_453_10 and arg_450_1.time_ < var_453_2 + var_453_10 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play416011109 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 416011109
		arg_454_1.duration_ = 7.5

		local var_454_0 = {
			zh = 3.466,
			ja = 7.5
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play416011110(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(arg_454_1.actors_["1148"]) and arg_454_1.var_.actorSpriteComps1148 == nil then
				arg_454_1.var_.actorSpriteComps1148 = arg_454_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_457_0 = 0.125

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 and not isNil(arg_454_1.actors_["1148"]) then
				if arg_454_1.var_.actorSpriteComps1148 then
					for iter_457_0, iter_457_1 in pairs(arg_454_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_457_1 then
							if arg_454_1.isInRecall_ then
								iter_457_1.color = Color.New(Mathf.Lerp(iter_457_1.color.r, arg_454_1.hightColor1.r, (arg_454_1.time_ - 0) / var_457_0), Mathf.Lerp(iter_457_1.color.g, arg_454_1.hightColor1.g, (arg_454_1.time_ - 0) / var_457_0), (Mathf.Lerp(iter_457_1.color.b, arg_454_1.hightColor1.b, (arg_454_1.time_ - 0) / var_457_0)))
							else
								local var_457_1 = Mathf.Lerp(iter_457_1.color.r, 1, (arg_454_1.time_ - 0) / var_457_0)

								iter_457_1.color = Color.New(var_457_1, var_457_1, var_457_1)
							end
						end
					end
				end
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 and not isNil(arg_454_1.actors_["1148"]) and arg_454_1.var_.actorSpriteComps1148 then
				for iter_457_2, iter_457_3 in pairs(arg_454_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_457_3 then
						iter_457_3.color = arg_454_1.isInRecall_ and (arg_454_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_454_1.var_.actorSpriteComps1148 = nil
			end

			local var_457_2 = 0
			local var_457_3 = 0.425

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_2 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_4 = arg_454_1:GetWordFromCfg(416011109)
				local var_457_5 = arg_454_1:FormatText(var_457_4.content)

				arg_454_1.text_.text = var_457_5

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_7 = 17 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_5) / 17)

				if (17 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_5) / 17)) > 0 and var_457_3 < var_457_7 then
					arg_454_1.talkMaxDuration = var_457_7

					if var_457_7 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_2
					end
				end

				arg_454_1.text_.text = var_457_5
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011109", "story_v_out_416011.awb") ~= 0 then
					local var_457_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011109", "story_v_out_416011.awb") / 1000

					if var_457_8 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_8 + var_457_2
					end

					if var_457_4.prefab_name ~= "" and arg_454_1.actors_[var_457_4.prefab_name] ~= nil then
						local var_457_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_4.prefab_name].transform, "story_v_out_416011", "416011109", "story_v_out_416011.awb")

						arg_454_1:RecordAudio("416011109", var_457_9)
						arg_454_1:RecordAudio("416011109", var_457_9)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_416011", "416011109", "story_v_out_416011.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_416011", "416011109", "story_v_out_416011.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_10 = math.max(var_457_3, arg_454_1.talkMaxDuration)

			if var_457_2 <= arg_454_1.time_ and arg_454_1.time_ < var_457_2 + var_457_10 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_2) / var_457_10

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_2 + var_457_10 and arg_454_1.time_ < var_457_2 + var_457_10 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play416011110 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 416011110
		arg_458_1.duration_ = 5.1

		local var_458_0 = {
			zh = 4.766,
			ja = 5.1
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
				arg_458_0:Play416011111(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 0.575

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_1 = arg_458_1:GetWordFromCfg(416011110)
				local var_461_2 = arg_458_1:FormatText(var_461_1.content)

				arg_458_1.text_.text = var_461_2

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_4 = 23 <= 0 and var_461_0 or var_461_0 * (utf8.len(var_461_2) / 23)

				if (23 <= 0 and var_461_0 or var_461_0 * (utf8.len(var_461_2) / 23)) > 0 and var_461_0 < var_461_4 then
					arg_458_1.talkMaxDuration = var_461_4

					if var_461_4 + 0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_4 + 0
					end
				end

				arg_458_1.text_.text = var_461_2
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011110", "story_v_out_416011.awb") ~= 0 then
					local var_461_5 = manager.audio:GetVoiceLength("story_v_out_416011", "416011110", "story_v_out_416011.awb") / 1000

					if var_461_5 + 0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_5 + 0
					end

					if var_461_1.prefab_name ~= "" and arg_458_1.actors_[var_461_1.prefab_name] ~= nil then
						local var_461_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_1.prefab_name].transform, "story_v_out_416011", "416011110", "story_v_out_416011.awb")

						arg_458_1:RecordAudio("416011110", var_461_6)
						arg_458_1:RecordAudio("416011110", var_461_6)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_416011", "416011110", "story_v_out_416011.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_416011", "416011110", "story_v_out_416011.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_7 = math.max(var_461_0, arg_458_1.talkMaxDuration)

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_7 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - 0) / var_461_7

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= 0 + var_461_7 and arg_458_1.time_ < 0 + var_461_7 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play416011111 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 416011111
		arg_462_1.duration_ = 6.6

		local var_462_0 = {
			zh = 6.6,
			ja = 6.233
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
				arg_462_0:Play416011112(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(arg_462_1.actors_["1148"]) and arg_462_1.var_.actorSpriteComps1148 == nil then
				arg_462_1.var_.actorSpriteComps1148 = arg_462_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_465_0 = 0.125

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 and not isNil(arg_462_1.actors_["1148"]) then
				if arg_462_1.var_.actorSpriteComps1148 then
					for iter_465_0, iter_465_1 in pairs(arg_462_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_465_1 then
							if arg_462_1.isInRecall_ then
								iter_465_1.color = Color.New(Mathf.Lerp(iter_465_1.color.r, arg_462_1.hightColor2.r, (arg_462_1.time_ - 0) / var_465_0), Mathf.Lerp(iter_465_1.color.g, arg_462_1.hightColor2.g, (arg_462_1.time_ - 0) / var_465_0), (Mathf.Lerp(iter_465_1.color.b, arg_462_1.hightColor2.b, (arg_462_1.time_ - 0) / var_465_0)))
							else
								local var_465_1 = Mathf.Lerp(iter_465_1.color.r, 0.5, (arg_462_1.time_ - 0) / var_465_0)

								iter_465_1.color = Color.New(var_465_1, var_465_1, var_465_1)
							end
						end
					end
				end
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 and not isNil(arg_462_1.actors_["1148"]) and arg_462_1.var_.actorSpriteComps1148 then
				for iter_465_2, iter_465_3 in pairs(arg_462_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_465_3 then
						iter_465_3.color = arg_462_1.isInRecall_ and (arg_462_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_462_1.var_.actorSpriteComps1148 = nil
			end

			local var_465_2 = 0
			local var_465_3 = 0.475

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_2 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_4 = arg_462_1:GetWordFromCfg(416011111)
				local var_465_5 = arg_462_1:FormatText(var_465_4.content)

				arg_462_1.text_.text = var_465_5

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_7 = 19 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_5) / 19)

				if (19 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_5) / 19)) > 0 and var_465_3 < var_465_7 then
					arg_462_1.talkMaxDuration = var_465_7

					if var_465_7 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_7 + var_465_2
					end
				end

				arg_462_1.text_.text = var_465_5
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011111", "story_v_out_416011.awb") ~= 0 then
					local var_465_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011111", "story_v_out_416011.awb") / 1000

					if var_465_8 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_8 + var_465_2
					end

					if var_465_4.prefab_name ~= "" and arg_462_1.actors_[var_465_4.prefab_name] ~= nil then
						local var_465_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_4.prefab_name].transform, "story_v_out_416011", "416011111", "story_v_out_416011.awb")

						arg_462_1:RecordAudio("416011111", var_465_9)
						arg_462_1:RecordAudio("416011111", var_465_9)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_416011", "416011111", "story_v_out_416011.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_416011", "416011111", "story_v_out_416011.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_10 = math.max(var_465_3, arg_462_1.talkMaxDuration)

			if var_465_2 <= arg_462_1.time_ and arg_462_1.time_ < var_465_2 + var_465_10 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_2) / var_465_10

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_2 + var_465_10 and arg_462_1.time_ < var_465_2 + var_465_10 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play416011112 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 416011112
		arg_466_1.duration_ = 5.4

		local var_466_0 = {
			zh = 5.4,
			ja = 3.7
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play416011113(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["1148"]) and arg_466_1.var_.actorSpriteComps1148 == nil then
				arg_466_1.var_.actorSpriteComps1148 = arg_466_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_469_0 = 0.125

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["1148"]) then
				if arg_466_1.var_.actorSpriteComps1148 then
					for iter_469_0, iter_469_1 in pairs(arg_466_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_469_1 then
							if arg_466_1.isInRecall_ then
								iter_469_1.color = Color.New(Mathf.Lerp(iter_469_1.color.r, arg_466_1.hightColor1.r, (arg_466_1.time_ - 0) / var_469_0), Mathf.Lerp(iter_469_1.color.g, arg_466_1.hightColor1.g, (arg_466_1.time_ - 0) / var_469_0), (Mathf.Lerp(iter_469_1.color.b, arg_466_1.hightColor1.b, (arg_466_1.time_ - 0) / var_469_0)))
							else
								local var_469_1 = Mathf.Lerp(iter_469_1.color.r, 1, (arg_466_1.time_ - 0) / var_469_0)

								iter_469_1.color = Color.New(var_469_1, var_469_1, var_469_1)
							end
						end
					end
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["1148"]) and arg_466_1.var_.actorSpriteComps1148 then
				for iter_469_2, iter_469_3 in pairs(arg_466_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_469_3 then
						iter_469_3.color = arg_466_1.isInRecall_ and (arg_466_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_466_1.var_.actorSpriteComps1148 = nil
			end

			local var_469_2 = 0
			local var_469_3 = 0.6

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_2 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_4 = arg_466_1:GetWordFromCfg(416011112)
				local var_469_5 = arg_466_1:FormatText(var_469_4.content)

				arg_466_1.text_.text = var_469_5

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_7 = 24 <= 0 and var_469_3 or var_469_3 * (utf8.len(var_469_5) / 24)

				if (24 <= 0 and var_469_3 or var_469_3 * (utf8.len(var_469_5) / 24)) > 0 and var_469_3 < var_469_7 then
					arg_466_1.talkMaxDuration = var_469_7

					if var_469_7 + var_469_2 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_7 + var_469_2
					end
				end

				arg_466_1.text_.text = var_469_5
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011112", "story_v_out_416011.awb") ~= 0 then
					local var_469_8 = manager.audio:GetVoiceLength("story_v_out_416011", "416011112", "story_v_out_416011.awb") / 1000

					if var_469_8 + var_469_2 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_8 + var_469_2
					end

					if var_469_4.prefab_name ~= "" and arg_466_1.actors_[var_469_4.prefab_name] ~= nil then
						local var_469_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_4.prefab_name].transform, "story_v_out_416011", "416011112", "story_v_out_416011.awb")

						arg_466_1:RecordAudio("416011112", var_469_9)
						arg_466_1:RecordAudio("416011112", var_469_9)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_416011", "416011112", "story_v_out_416011.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_416011", "416011112", "story_v_out_416011.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_10 = math.max(var_469_3, arg_466_1.talkMaxDuration)

			if var_469_2 <= arg_466_1.time_ and arg_466_1.time_ < var_469_2 + var_469_10 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_2) / var_469_10

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_2 + var_469_10 and arg_466_1.time_ < var_469_2 + var_469_10 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play416011113 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 416011113
		arg_470_1.duration_ = 5.47

		local var_470_0 = {
			zh = 1.9,
			ja = 5.466
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
				arg_470_0:Play416011114(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0.225

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_1 = arg_470_1:GetWordFromCfg(416011113)
				local var_473_2 = arg_470_1:FormatText(var_473_1.content)

				arg_470_1.text_.text = var_473_2

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_4 = 9 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_2) / 9)

				if (9 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_2) / 9)) > 0 and var_473_0 < var_473_4 then
					arg_470_1.talkMaxDuration = var_473_4

					if var_473_4 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_4 + 0
					end
				end

				arg_470_1.text_.text = var_473_2
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416011", "416011113", "story_v_out_416011.awb") ~= 0 then
					local var_473_5 = manager.audio:GetVoiceLength("story_v_out_416011", "416011113", "story_v_out_416011.awb") / 1000

					if var_473_5 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_5 + 0
					end

					if var_473_1.prefab_name ~= "" and arg_470_1.actors_[var_473_1.prefab_name] ~= nil then
						local var_473_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_1.prefab_name].transform, "story_v_out_416011", "416011113", "story_v_out_416011.awb")

						arg_470_1:RecordAudio("416011113", var_473_6)
						arg_470_1:RecordAudio("416011113", var_473_6)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_416011", "416011113", "story_v_out_416011.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_416011", "416011113", "story_v_out_416011.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_7 = math.max(var_473_0, arg_470_1.talkMaxDuration)

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_7 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - 0) / var_473_7

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= 0 + var_473_7 and arg_470_1.time_ < 0 + var_473_7 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play416011114 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 416011114
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
			arg_474_1.auto_ = false
		end

		function arg_474_1.playNext_(arg_476_0)
			arg_474_1.onStoryFinished_()
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos1148 = arg_474_1.actors_["1148"].transform.localPosition
				arg_474_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_474_1:CheckSpriteTmpPos("1148", 7)

				for iter_477_0 = 0, arg_474_1.actors_["1148"].transform.childCount - 1 do
					local var_477_0 = arg_474_1.actors_["1148"].transform:GetChild(iter_477_0)

					if var_477_0.name == "" or not string.find(var_477_0.name, "split") then
						var_477_0.gameObject:SetActive(true)
					else
						var_477_0.gameObject:SetActive(false)
					end
				end
			end

			local var_477_1 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_1 then
				arg_474_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_474_1.time_ - 0) / var_477_1)
			end

			if arg_474_1.time_ >= 0 + var_477_1 and arg_474_1.time_ < 0 + var_477_1 + arg_477_0 then
				arg_474_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_477_2 = 0
			local var_477_3 = 1

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_2 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_4 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(416011114).content)

				arg_474_1.text_.text = var_477_4

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_6 = 41 <= 0 and var_477_3 or var_477_3 * (utf8.len(var_477_4) / 41)

				if (41 <= 0 and var_477_3 or var_477_3 * (utf8.len(var_477_4) / 41)) > 0 and var_477_3 < var_477_6 then
					arg_474_1.talkMaxDuration = var_477_6

					if var_477_6 + var_477_2 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_6 + var_477_2
					end
				end

				arg_474_1.text_.text = var_477_4
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_7 = math.max(var_477_3, arg_474_1.talkMaxDuration)

			if var_477_2 <= arg_474_1.time_ and arg_474_1.time_ < var_477_2 + var_477_7 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_2) / var_477_7

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_2 + var_477_7 and arg_474_1.time_ < var_477_2 + var_477_7 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I13g",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/I14f",
		"TextureConfig/Background/I13f",
		"TextureConfig/Background/SS1601"
	},
	voices = {
		"story_v_out_416011.awb"
	}
}
