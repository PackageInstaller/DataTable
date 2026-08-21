return {
	Play320292001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320292001
		arg_1_1.duration_ = 6.3

		local var_1_0 = {
			zh = 5.232999999999,
			ja = 6.299999999999
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
				arg_1_0:Play320292002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.STblack

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0
			local var_4_25 = 0.2

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 1.999999999999
			local var_4_31 = 0.375

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_32 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_32:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_33 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_1_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_4_34 = arg_1_1:GetWordFromCfg(320292001)
				local var_4_35 = arg_1_1:FormatText(var_4_34.content)

				arg_1_1.text_.text = var_4_35

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_36 = 15
				local var_4_37 = utf8.len(var_4_35)
				local var_4_38 = var_4_36 <= 0 and var_4_31 or var_4_31 * (var_4_37 / var_4_36)

				if var_4_38 > 0 and var_4_31 < var_4_38 then
					arg_1_1.talkMaxDuration = var_4_38
					var_4_30 = var_4_30 + 0.3

					if var_4_38 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_38 + var_4_30
					end
				end

				arg_1_1.text_.text = var_4_35
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292001", "story_v_out_320292.awb") ~= 0 then
					local var_4_39 = manager.audio:GetVoiceLength("story_v_out_320292", "320292001", "story_v_out_320292.awb") / 1000

					if var_4_39 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_30
					end

					if var_4_34.prefab_name ~= "" and arg_1_1.actors_[var_4_34.prefab_name] ~= nil then
						local var_4_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_34.prefab_name].transform, "story_v_out_320292", "320292001", "story_v_out_320292.awb")

						arg_1_1:RecordAudio("320292001", var_4_40)
						arg_1_1:RecordAudio("320292001", var_4_40)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_320292", "320292001", "story_v_out_320292.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_320292", "320292001", "story_v_out_320292.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_41 = var_4_30 + 0.3
			local var_4_42 = math.max(var_4_31, arg_1_1.talkMaxDuration)

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_41) / var_4_42

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play320292002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 320292002
		arg_8_1.duration_ = 6.83

		local var_8_0 = {
			zh = 4.566,
			ja = 6.833
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
				arg_8_0:Play320292003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.55

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[36].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(320292002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 22
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292002", "story_v_out_320292.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292002", "story_v_out_320292.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_320292", "320292002", "story_v_out_320292.awb")

						arg_8_1:RecordAudio("320292002", var_11_9)
						arg_8_1:RecordAudio("320292002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_320292", "320292002", "story_v_out_320292.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_320292", "320292002", "story_v_out_320292.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_10 and arg_8_1.time_ < var_11_0 + var_11_10 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play320292003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 320292003
		arg_12_1.duration_ = 14.13

		local var_12_0 = {
			zh = 11.633,
			ja = 14.133
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
				arg_12_0:Play320292004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.85

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[36].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(320292003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 34
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292003", "story_v_out_320292.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292003", "story_v_out_320292.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_320292", "320292003", "story_v_out_320292.awb")

						arg_12_1:RecordAudio("320292003", var_15_9)
						arg_12_1:RecordAudio("320292003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_320292", "320292003", "story_v_out_320292.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_320292", "320292003", "story_v_out_320292.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_10 and arg_12_1.time_ < var_15_0 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play320292004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 320292004
		arg_16_1.duration_ = 4.6

		local var_16_0 = {
			zh = 3.033,
			ja = 4.6
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
				arg_16_0:Play320292005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			local var_19_1 = 0.4

			if arg_16_1.time_ >= var_19_0 + var_19_1 and arg_16_1.time_ < var_19_0 + var_19_1 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_2 = 0.4
			local var_19_3 = 0.25

			if var_19_2 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_4 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_4:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
					arg_16_1.dialogCg_.alpha = arg_20_0
				end))
				var_19_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_5 = arg_16_1:FormatText(StoryNameCfg[36].name)

				arg_16_1.leftNameTxt_.text = var_19_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_6 = arg_16_1:GetWordFromCfg(320292004)
				local var_19_7 = arg_16_1:FormatText(var_19_6.content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_8 = 10
				local var_19_9 = utf8.len(var_19_7)
				local var_19_10 = var_19_8 <= 0 and var_19_3 or var_19_3 * (var_19_9 / var_19_8)

				if var_19_10 > 0 and var_19_3 < var_19_10 then
					arg_16_1.talkMaxDuration = var_19_10
					var_19_2 = var_19_2 + 0.3

					if var_19_10 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_7
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292004", "story_v_out_320292.awb") ~= 0 then
					local var_19_11 = manager.audio:GetVoiceLength("story_v_out_320292", "320292004", "story_v_out_320292.awb") / 1000

					if var_19_11 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_11 + var_19_2
					end

					if var_19_6.prefab_name ~= "" and arg_16_1.actors_[var_19_6.prefab_name] ~= nil then
						local var_19_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_6.prefab_name].transform, "story_v_out_320292", "320292004", "story_v_out_320292.awb")

						arg_16_1:RecordAudio("320292004", var_19_12)
						arg_16_1:RecordAudio("320292004", var_19_12)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_320292", "320292004", "story_v_out_320292.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_320292", "320292004", "story_v_out_320292.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_13 = var_19_2 + 0.3
			local var_19_14 = math.max(var_19_3, arg_16_1.talkMaxDuration)

			if var_19_13 <= arg_16_1.time_ and arg_16_1.time_ < var_19_13 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_13) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_13 + var_19_14 and arg_16_1.time_ < var_19_13 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play320292005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 320292005
		arg_22_1.duration_ = 5.46

		local var_22_0 = {
			zh = 4.158333333332,
			ja = 5.458333333332
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
				arg_22_0:Play320292006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = "XS0203"

			if arg_22_1.bgs_[var_25_0] == nil then
				local var_25_1 = Object.Instantiate(arg_22_1.paintGo_)

				var_25_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_25_0)
				var_25_1.name = var_25_0
				var_25_1.transform.parent = arg_22_1.stage_.transform
				var_25_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.bgs_[var_25_0] = var_25_1
			end

			local var_25_2 = 0.833333333332

			if var_25_2 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				local var_25_3 = manager.ui.mainCamera.transform.localPosition
				local var_25_4 = Vector3.New(0, 0, 10) + Vector3.New(var_25_3.x, var_25_3.y, 0)
				local var_25_5 = arg_22_1.bgs_.XS0203

				var_25_5.transform.localPosition = var_25_4
				var_25_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_25_6 = var_25_5:GetComponent("SpriteRenderer")

				if var_25_6 and var_25_6.sprite then
					local var_25_7 = (var_25_5.transform.localPosition - var_25_3).z
					local var_25_8 = manager.ui.mainCameraCom_
					local var_25_9 = 2 * var_25_7 * Mathf.Tan(var_25_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_25_10 = var_25_9 * var_25_8.aspect
					local var_25_11 = var_25_6.sprite.bounds.size.x
					local var_25_12 = var_25_6.sprite.bounds.size.y
					local var_25_13 = var_25_10 / var_25_11
					local var_25_14 = var_25_9 / var_25_12
					local var_25_15 = var_25_14 < var_25_13 and var_25_13 or var_25_14

					var_25_5.transform.localScale = Vector3.New(var_25_15, var_25_15, 0)
				end

				for iter_25_0, iter_25_1 in pairs(arg_22_1.bgs_) do
					if iter_25_0 ~= "XS0203" then
						iter_25_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_25_16 = 2.658333333332

			if var_25_16 < arg_22_1.time_ and arg_22_1.time_ <= var_25_16 + arg_25_0 then
				arg_22_1.allBtn_.enabled = false
			end

			local var_25_17 = 0.3

			if arg_22_1.time_ >= var_25_16 + var_25_17 and arg_22_1.time_ < var_25_16 + var_25_17 + arg_25_0 then
				arg_22_1.allBtn_.enabled = true
			end

			local var_25_18 = 0

			if var_25_18 < arg_22_1.time_ and arg_22_1.time_ <= var_25_18 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_19 = 0.833333333333333

			if var_25_18 <= arg_22_1.time_ and arg_22_1.time_ < var_25_18 + var_25_19 then
				local var_25_20 = (arg_22_1.time_ - var_25_18) / var_25_19
				local var_25_21 = Color.New(0, 0, 0)

				var_25_21.a = Mathf.Lerp(0, 1, var_25_20)
				arg_22_1.mask_.color = var_25_21
			end

			if arg_22_1.time_ >= var_25_18 + var_25_19 and arg_22_1.time_ < var_25_18 + var_25_19 + arg_25_0 then
				local var_25_22 = Color.New(0, 0, 0)

				var_25_22.a = 1
				arg_22_1.mask_.color = var_25_22
			end

			local var_25_23 = 0.833333333333333

			if var_25_23 < arg_22_1.time_ and arg_22_1.time_ <= var_25_23 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_24 = 2

			if var_25_23 <= arg_22_1.time_ and arg_22_1.time_ < var_25_23 + var_25_24 then
				local var_25_25 = (arg_22_1.time_ - var_25_23) / var_25_24
				local var_25_26 = Color.New(0, 0, 0)

				var_25_26.a = Mathf.Lerp(1, 0, var_25_25)
				arg_22_1.mask_.color = var_25_26
			end

			if arg_22_1.time_ >= var_25_23 + var_25_24 and arg_22_1.time_ < var_25_23 + var_25_24 + arg_25_0 then
				local var_25_27 = Color.New(0, 0, 0)
				local var_25_28 = 0

				arg_22_1.mask_.enabled = false
				var_25_27.a = var_25_28
				arg_22_1.mask_.color = var_25_27
			end

			local var_25_29 = 0
			local var_25_30 = 0.2

			if var_25_29 < arg_22_1.time_ and arg_22_1.time_ <= var_25_29 + arg_25_0 then
				local var_25_31 = "play"
				local var_25_32 = "music"

				arg_22_1:AudioAction(var_25_31, var_25_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_25_33 = ""
				local var_25_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_25_34 ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_34 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_34

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_34
						arg_22_1.bgmTxt2_.text = var_25_34
					end

					if arg_22_1.bgmTimer then
						arg_22_1.bgmTimer:Stop()

						arg_22_1.bgmTimer = nil
					end

					if arg_22_1.settingData.show_music_name == 1 then
						arg_22_1.musicController:SetSelectedState("show")
						arg_22_1.musicAnimator_:Play("open", 0, 0)

						if arg_22_1.settingData.music_time ~= 0 then
							arg_22_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_22_1.settingData.music_time), function()
								if arg_22_1 == nil or isNil(arg_22_1.bgmTxt_) then
									return
								end

								arg_22_1.musicController:SetSelectedState("hide")
								arg_22_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_25_35 = 0.333333333333333
			local var_25_36 = 1

			if var_25_35 < arg_22_1.time_ and arg_22_1.time_ <= var_25_35 + arg_25_0 then
				local var_25_37 = "play"
				local var_25_38 = "music"

				arg_22_1:AudioAction(var_25_37, var_25_38, "bgm_activity_3_6_story_biotech", "bgm_activity_3_6_story_biotech", "bgm_activity_3_6_story_biotech.awb")

				local var_25_39 = ""
				local var_25_40 = manager.audio:GetAudioName("bgm_activity_3_6_story_biotech", "bgm_activity_3_6_story_biotech")

				if var_25_40 ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_40 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_40

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_40
						arg_22_1.bgmTxt2_.text = var_25_40
					end

					if arg_22_1.bgmTimer then
						arg_22_1.bgmTimer:Stop()

						arg_22_1.bgmTimer = nil
					end

					if arg_22_1.settingData.show_music_name == 1 then
						arg_22_1.musicController:SetSelectedState("show")
						arg_22_1.musicAnimator_:Play("open", 0, 0)

						if arg_22_1.settingData.music_time ~= 0 then
							arg_22_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_22_1.settingData.music_time), function()
								if arg_22_1 == nil or isNil(arg_22_1.bgmTxt_) then
									return
								end

								arg_22_1.musicController:SetSelectedState("hide")
								arg_22_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_41 = 2.658333333332
			local var_25_42 = 0.175

			if var_25_41 < arg_22_1.time_ and arg_22_1.time_ <= var_25_41 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_43 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_43:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_22_1.dialogCg_.alpha = arg_28_0
				end))
				var_25_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_44 = arg_22_1:FormatText(StoryNameCfg[605].name)

				arg_22_1.leftNameTxt_.text = var_25_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_45 = arg_22_1:GetWordFromCfg(320292005)
				local var_25_46 = arg_22_1:FormatText(var_25_45.content)

				arg_22_1.text_.text = var_25_46

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_47 = 7
				local var_25_48 = utf8.len(var_25_46)
				local var_25_49 = var_25_47 <= 0 and var_25_42 or var_25_42 * (var_25_48 / var_25_47)

				if var_25_49 > 0 and var_25_42 < var_25_49 then
					arg_22_1.talkMaxDuration = var_25_49
					var_25_41 = var_25_41 + 0.3

					if var_25_49 + var_25_41 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_49 + var_25_41
					end
				end

				arg_22_1.text_.text = var_25_46
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292005", "story_v_out_320292.awb") ~= 0 then
					local var_25_50 = manager.audio:GetVoiceLength("story_v_out_320292", "320292005", "story_v_out_320292.awb") / 1000

					if var_25_50 + var_25_41 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_50 + var_25_41
					end

					if var_25_45.prefab_name ~= "" and arg_22_1.actors_[var_25_45.prefab_name] ~= nil then
						local var_25_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_45.prefab_name].transform, "story_v_out_320292", "320292005", "story_v_out_320292.awb")

						arg_22_1:RecordAudio("320292005", var_25_51)
						arg_22_1:RecordAudio("320292005", var_25_51)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_320292", "320292005", "story_v_out_320292.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_320292", "320292005", "story_v_out_320292.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_52 = var_25_41 + 0.3
			local var_25_53 = math.max(var_25_42, arg_22_1.talkMaxDuration)

			if var_25_52 <= arg_22_1.time_ and arg_22_1.time_ < var_25_52 + var_25_53 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_52) / var_25_53

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_52 + var_25_53 and arg_22_1.time_ < var_25_52 + var_25_53 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play320292006 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 320292006
		arg_30_1.duration_ = 6.17

		local var_30_0 = {
			zh = 1.433,
			ja = 6.166
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
				arg_30_0:Play320292007(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 0.2

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_2 = arg_30_1:FormatText(StoryNameCfg[1031].name)

				arg_30_1.leftNameTxt_.text = var_33_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_3 = arg_30_1:GetWordFromCfg(320292006)
				local var_33_4 = arg_30_1:FormatText(var_33_3.content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 8
				local var_33_6 = utf8.len(var_33_4)
				local var_33_7 = var_33_5 <= 0 and var_33_1 or var_33_1 * (var_33_6 / var_33_5)

				if var_33_7 > 0 and var_33_1 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292006", "story_v_out_320292.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292006", "story_v_out_320292.awb") / 1000

					if var_33_8 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_0
					end

					if var_33_3.prefab_name ~= "" and arg_30_1.actors_[var_33_3.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_3.prefab_name].transform, "story_v_out_320292", "320292006", "story_v_out_320292.awb")

						arg_30_1:RecordAudio("320292006", var_33_9)
						arg_30_1:RecordAudio("320292006", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_320292", "320292006", "story_v_out_320292.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_320292", "320292006", "story_v_out_320292.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_10 and arg_30_1.time_ < var_33_0 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play320292007 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 320292007
		arg_34_1.duration_ = 7.47

		local var_34_0 = {
			zh = 5.7,
			ja = 7.466
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
				arg_34_0:Play320292008(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0
			local var_37_1 = 0.675

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_2 = arg_34_1:FormatText(StoryNameCfg[605].name)

				arg_34_1.leftNameTxt_.text = var_37_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_3 = arg_34_1:GetWordFromCfg(320292007)
				local var_37_4 = arg_34_1:FormatText(var_37_3.content)

				arg_34_1.text_.text = var_37_4

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_5 = 27
				local var_37_6 = utf8.len(var_37_4)
				local var_37_7 = var_37_5 <= 0 and var_37_1 or var_37_1 * (var_37_6 / var_37_5)

				if var_37_7 > 0 and var_37_1 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_0
					end
				end

				arg_34_1.text_.text = var_37_4
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292007", "story_v_out_320292.awb") ~= 0 then
					local var_37_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292007", "story_v_out_320292.awb") / 1000

					if var_37_8 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_0
					end

					if var_37_3.prefab_name ~= "" and arg_34_1.actors_[var_37_3.prefab_name] ~= nil then
						local var_37_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_3.prefab_name].transform, "story_v_out_320292", "320292007", "story_v_out_320292.awb")

						arg_34_1:RecordAudio("320292007", var_37_9)
						arg_34_1:RecordAudio("320292007", var_37_9)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_320292", "320292007", "story_v_out_320292.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_320292", "320292007", "story_v_out_320292.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_10 = math.max(var_37_1, arg_34_1.talkMaxDuration)

			if var_37_0 <= arg_34_1.time_ and arg_34_1.time_ < var_37_0 + var_37_10 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_0) / var_37_10

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_0 + var_37_10 and arg_34_1.time_ < var_37_0 + var_37_10 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play320292008 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 320292008
		arg_38_1.duration_ = 10.7

		local var_38_0 = {
			zh = 9.833,
			ja = 10.7
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play320292009(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 1.1

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_2 = arg_38_1:FormatText(StoryNameCfg[1031].name)

				arg_38_1.leftNameTxt_.text = var_41_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_3 = arg_38_1:GetWordFromCfg(320292008)
				local var_41_4 = arg_38_1:FormatText(var_41_3.content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 44
				local var_41_6 = utf8.len(var_41_4)
				local var_41_7 = var_41_5 <= 0 and var_41_1 or var_41_1 * (var_41_6 / var_41_5)

				if var_41_7 > 0 and var_41_1 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_4
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292008", "story_v_out_320292.awb") ~= 0 then
					local var_41_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292008", "story_v_out_320292.awb") / 1000

					if var_41_8 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_8 + var_41_0
					end

					if var_41_3.prefab_name ~= "" and arg_38_1.actors_[var_41_3.prefab_name] ~= nil then
						local var_41_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_3.prefab_name].transform, "story_v_out_320292", "320292008", "story_v_out_320292.awb")

						arg_38_1:RecordAudio("320292008", var_41_9)
						arg_38_1:RecordAudio("320292008", var_41_9)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_320292", "320292008", "story_v_out_320292.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_320292", "320292008", "story_v_out_320292.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_10 and arg_38_1.time_ < var_41_0 + var_41_10 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play320292009 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 320292009
		arg_42_1.duration_ = 5.53

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play320292010(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = manager.ui.mainCamera.transform
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.var_.shakeOldPos = var_45_0.localPosition
			end

			local var_45_2 = 0.533333333333333

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / 0.066
				local var_45_4, var_45_5 = math.modf(var_45_3)

				var_45_0.localPosition = Vector3.New(var_45_5 * 0.13, var_45_5 * 0.13, var_45_5 * 0.13) + arg_42_1.var_.shakeOldPos
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 then
				var_45_0.localPosition = arg_42_1.var_.shakeOldPos
			end

			local var_45_6 = manager.ui.mainCamera.transform
			local var_45_7 = 0.533333333333333

			if var_45_7 < arg_42_1.time_ and arg_42_1.time_ <= var_45_7 + arg_45_0 then
				arg_42_1.var_.shakeOldPos = var_45_6.localPosition
			end

			local var_45_8 = 0.538994865833471

			if var_45_7 <= arg_42_1.time_ and arg_42_1.time_ < var_45_7 + var_45_8 then
				local var_45_9 = (arg_42_1.time_ - var_45_7) / 0.066
				local var_45_10, var_45_11 = math.modf(var_45_9)

				var_45_6.localPosition = Vector3.New(var_45_11 * 0.13, var_45_11 * 0.13, var_45_11 * 0.13) + arg_42_1.var_.shakeOldPos
			end

			if arg_42_1.time_ >= var_45_7 + var_45_8 and arg_42_1.time_ < var_45_7 + var_45_8 + arg_45_0 then
				var_45_6.localPosition = arg_42_1.var_.shakeOldPos
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_12 = 0.533333333333333
			local var_45_13 = 1.2

			if var_45_12 < arg_42_1.time_ and arg_42_1.time_ <= var_45_12 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_14 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_14:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_15 = arg_42_1:GetWordFromCfg(320292009)
				local var_45_16 = arg_42_1:FormatText(var_45_15.content)

				arg_42_1.text_.text = var_45_16

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_17 = 48
				local var_45_18 = utf8.len(var_45_16)
				local var_45_19 = var_45_17 <= 0 and var_45_13 or var_45_13 * (var_45_18 / var_45_17)

				if var_45_19 > 0 and var_45_13 < var_45_19 then
					arg_42_1.talkMaxDuration = var_45_19
					var_45_12 = var_45_12 + 0.3

					if var_45_19 + var_45_12 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_19 + var_45_12
					end
				end

				arg_42_1.text_.text = var_45_16
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_20 = var_45_12 + 0.3
			local var_45_21 = math.max(var_45_13, arg_42_1.talkMaxDuration)

			if var_45_20 <= arg_42_1.time_ and arg_42_1.time_ < var_45_20 + var_45_21 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_20) / var_45_21

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_20 + var_45_21 and arg_42_1.time_ < var_45_20 + var_45_21 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play320292010 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 320292010
		arg_48_1.duration_ = 3.27

		local var_48_0 = {
			zh = 2.8,
			ja = 3.266
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play320292011(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.35

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[605].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(320292010)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 14
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292010", "story_v_out_320292.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292010", "story_v_out_320292.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_320292", "320292010", "story_v_out_320292.awb")

						arg_48_1:RecordAudio("320292010", var_51_9)
						arg_48_1:RecordAudio("320292010", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_320292", "320292010", "story_v_out_320292.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_320292", "320292010", "story_v_out_320292.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play320292011 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 320292011
		arg_52_1.duration_ = 5.97

		local var_52_0 = {
			zh = 5.366,
			ja = 5.966
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play320292012(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.625

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[605].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:GetWordFromCfg(320292011)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 25
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292011", "story_v_out_320292.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292011", "story_v_out_320292.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_320292", "320292011", "story_v_out_320292.awb")

						arg_52_1:RecordAudio("320292011", var_55_9)
						arg_52_1:RecordAudio("320292011", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_320292", "320292011", "story_v_out_320292.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_320292", "320292011", "story_v_out_320292.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_10 and arg_52_1.time_ < var_55_0 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play320292012 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 320292012
		arg_56_1.duration_ = 2.1

		local var_56_0 = {
			zh = 2.066,
			ja = 2.1
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play320292013(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.2

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[1031].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_3 = arg_56_1:GetWordFromCfg(320292012)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 8
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292012", "story_v_out_320292.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292012", "story_v_out_320292.awb") / 1000

					if var_59_8 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_0
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_320292", "320292012", "story_v_out_320292.awb")

						arg_56_1:RecordAudio("320292012", var_59_9)
						arg_56_1:RecordAudio("320292012", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_320292", "320292012", "story_v_out_320292.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_320292", "320292012", "story_v_out_320292.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_10 and arg_56_1.time_ < var_59_0 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play320292013 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 320292013
		arg_60_1.duration_ = 5.7

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play320292014(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = manager.ui.mainCamera.transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				local var_63_2 = arg_60_1.var_.effect777
				local var_63_3
				local var_63_4 = var_63_0

				if not var_63_2 then
					var_63_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_scence_pingmu_niuqu"), var_63_4)
					var_63_2.name = "777"
					arg_60_1.var_.effect777 = var_63_2
				else
					var_63_2.transform:SetParent(var_63_4)
				end

				var_63_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_63_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_63_5 = manager.ui.mainCamera.transform
			local var_63_6 = 0.7

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				local var_63_7 = arg_60_1.var_.effect777

				if var_63_7 then
					Object.Destroy(var_63_7)

					arg_60_1.var_.effect777 = nil
				end
			end

			local var_63_8 = 0
			local var_63_9 = 1

			if var_63_8 < arg_60_1.time_ and arg_60_1.time_ <= var_63_8 + arg_63_0 then
				local var_63_10 = "play"
				local var_63_11 = "effect"

				arg_60_1:AudioAction(var_63_10, var_63_11, "se_story_16", "se_story_16_bullet", "")
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_12 = 0.7
			local var_63_13 = 1.4

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_14 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_14:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_15 = arg_60_1:GetWordFromCfg(320292013)
				local var_63_16 = arg_60_1:FormatText(var_63_15.content)

				arg_60_1.text_.text = var_63_16

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_17 = 56
				local var_63_18 = utf8.len(var_63_16)
				local var_63_19 = var_63_17 <= 0 and var_63_13 or var_63_13 * (var_63_18 / var_63_17)

				if var_63_19 > 0 and var_63_13 < var_63_19 then
					arg_60_1.talkMaxDuration = var_63_19
					var_63_12 = var_63_12 + 0.3

					if var_63_19 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_12
					end
				end

				arg_60_1.text_.text = var_63_16
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_20 = var_63_12 + 0.3
			local var_63_21 = math.max(var_63_13, arg_60_1.talkMaxDuration)

			if var_63_20 <= arg_60_1.time_ and arg_60_1.time_ < var_63_20 + var_63_21 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_20) / var_63_21

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_20 + var_63_21 and arg_60_1.time_ < var_63_20 + var_63_21 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play320292014 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 320292014
		arg_66_1.duration_ = 10.53

		local var_66_0 = {
			zh = 5.9,
			ja = 10.533
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play320292015(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.7

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[1031].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_3 = arg_66_1:GetWordFromCfg(320292014)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 28
				local var_69_6 = utf8.len(var_69_4)
				local var_69_7 = var_69_5 <= 0 and var_69_1 or var_69_1 * (var_69_6 / var_69_5)

				if var_69_7 > 0 and var_69_1 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292014", "story_v_out_320292.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292014", "story_v_out_320292.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_320292", "320292014", "story_v_out_320292.awb")

						arg_66_1:RecordAudio("320292014", var_69_9)
						arg_66_1:RecordAudio("320292014", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_320292", "320292014", "story_v_out_320292.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_320292", "320292014", "story_v_out_320292.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_10 and arg_66_1.time_ < var_69_0 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play320292015 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 320292015
		arg_70_1.duration_ = 4

		local var_70_0 = {
			zh = 1.833,
			ja = 4
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play320292016(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.225

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[1031].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:GetWordFromCfg(320292015)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 9
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292015", "story_v_out_320292.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292015", "story_v_out_320292.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_320292", "320292015", "story_v_out_320292.awb")

						arg_70_1:RecordAudio("320292015", var_73_9)
						arg_70_1:RecordAudio("320292015", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_320292", "320292015", "story_v_out_320292.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_320292", "320292015", "story_v_out_320292.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play320292016 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 320292016
		arg_74_1.duration_ = 1.13

		local var_74_0 = {
			zh = 0.999999999999,
			ja = 1.133
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play320292017(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.15

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[605].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(320292016)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 6
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292016", "story_v_out_320292.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292016", "story_v_out_320292.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_320292", "320292016", "story_v_out_320292.awb")

						arg_74_1:RecordAudio("320292016", var_77_9)
						arg_74_1:RecordAudio("320292016", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_320292", "320292016", "story_v_out_320292.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_320292", "320292016", "story_v_out_320292.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play320292017 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 320292017
		arg_78_1.duration_ = 8

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play320292018(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = "L05g"

			if arg_78_1.bgs_[var_81_0] == nil then
				local var_81_1 = Object.Instantiate(arg_78_1.paintGo_)

				var_81_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_81_0)
				var_81_1.name = var_81_0
				var_81_1.transform.parent = arg_78_1.stage_.transform
				var_81_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.bgs_[var_81_0] = var_81_1
			end

			local var_81_2 = 1

			if var_81_2 < arg_78_1.time_ and arg_78_1.time_ <= var_81_2 + arg_81_0 then
				local var_81_3 = manager.ui.mainCamera.transform.localPosition
				local var_81_4 = Vector3.New(0, 0, 10) + Vector3.New(var_81_3.x, var_81_3.y, 0)
				local var_81_5 = arg_78_1.bgs_.L05g

				var_81_5.transform.localPosition = var_81_4
				var_81_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_6 = var_81_5:GetComponent("SpriteRenderer")

				if var_81_6 and var_81_6.sprite then
					local var_81_7 = (var_81_5.transform.localPosition - var_81_3).z
					local var_81_8 = manager.ui.mainCameraCom_
					local var_81_9 = 2 * var_81_7 * Mathf.Tan(var_81_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_81_10 = var_81_9 * var_81_8.aspect
					local var_81_11 = var_81_6.sprite.bounds.size.x
					local var_81_12 = var_81_6.sprite.bounds.size.y
					local var_81_13 = var_81_10 / var_81_11
					local var_81_14 = var_81_9 / var_81_12
					local var_81_15 = var_81_14 < var_81_13 and var_81_13 or var_81_14

					var_81_5.transform.localScale = Vector3.New(var_81_15, var_81_15, 0)
				end

				for iter_81_0, iter_81_1 in pairs(arg_78_1.bgs_) do
					if iter_81_0 ~= "L05g" then
						iter_81_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_16 = 1

			if var_81_16 < arg_78_1.time_ and arg_78_1.time_ <= var_81_16 + arg_81_0 then
				arg_78_1.allBtn_.enabled = false
			end

			local var_81_17 = 0.3

			if arg_78_1.time_ >= var_81_16 + var_81_17 and arg_78_1.time_ < var_81_16 + var_81_17 + arg_81_0 then
				arg_78_1.allBtn_.enabled = true
			end

			local var_81_18 = 0

			if var_81_18 < arg_78_1.time_ and arg_78_1.time_ <= var_81_18 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_19 = 1

			if var_81_18 <= arg_78_1.time_ and arg_78_1.time_ < var_81_18 + var_81_19 then
				local var_81_20 = (arg_78_1.time_ - var_81_18) / var_81_19
				local var_81_21 = Color.New(1, 1, 1)

				var_81_21.a = Mathf.Lerp(0, 1, var_81_20)
				arg_78_1.mask_.color = var_81_21
			end

			if arg_78_1.time_ >= var_81_18 + var_81_19 and arg_78_1.time_ < var_81_18 + var_81_19 + arg_81_0 then
				local var_81_22 = Color.New(1, 1, 1)

				var_81_22.a = 1
				arg_78_1.mask_.color = var_81_22
			end

			local var_81_23 = 1

			if var_81_23 < arg_78_1.time_ and arg_78_1.time_ <= var_81_23 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_24 = 2

			if var_81_23 <= arg_78_1.time_ and arg_78_1.time_ < var_81_23 + var_81_24 then
				local var_81_25 = (arg_78_1.time_ - var_81_23) / var_81_24
				local var_81_26 = Color.New(1, 1, 1)

				var_81_26.a = Mathf.Lerp(1, 0, var_81_25)
				arg_78_1.mask_.color = var_81_26
			end

			if arg_78_1.time_ >= var_81_23 + var_81_24 and arg_78_1.time_ < var_81_23 + var_81_24 + arg_81_0 then
				local var_81_27 = Color.New(1, 1, 1)
				local var_81_28 = 0

				arg_78_1.mask_.enabled = false
				var_81_27.a = var_81_28
				arg_78_1.mask_.color = var_81_27
			end

			if arg_78_1.frameCnt_ <= 1 then
				arg_78_1.dialog_:SetActive(false)
			end

			local var_81_29 = 3
			local var_81_30 = 1.9

			if var_81_29 < arg_78_1.time_ and arg_78_1.time_ <= var_81_29 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_31 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_31:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_32 = arg_78_1:GetWordFromCfg(320292017)
				local var_81_33 = arg_78_1:FormatText(var_81_32.content)

				arg_78_1.text_.text = var_81_33

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_34 = 76
				local var_81_35 = utf8.len(var_81_33)
				local var_81_36 = var_81_34 <= 0 and var_81_30 or var_81_30 * (var_81_35 / var_81_34)

				if var_81_36 > 0 and var_81_30 < var_81_36 then
					arg_78_1.talkMaxDuration = var_81_36
					var_81_29 = var_81_29 + 0.3

					if var_81_36 + var_81_29 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_36 + var_81_29
					end
				end

				arg_78_1.text_.text = var_81_33
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_37 = var_81_29 + 0.3
			local var_81_38 = math.max(var_81_30, arg_78_1.talkMaxDuration)

			if var_81_37 <= arg_78_1.time_ and arg_78_1.time_ < var_81_37 + var_81_38 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_37) / var_81_38

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_37 + var_81_38 and arg_78_1.time_ < var_81_37 + var_81_38 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play320292018 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 320292018
		arg_84_1.duration_ = 3.73

		local var_84_0 = {
			zh = 2.933,
			ja = 3.733
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play320292019(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = "1156ui_story"

			if arg_84_1.actors_[var_87_0] == nil then
				local var_87_1 = Asset.Load("Char/" .. "1156ui_story")

				if not isNil(var_87_1) then
					local var_87_2 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_84_1.stage_.transform)

					var_87_2.name = var_87_0
					var_87_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_84_1.actors_[var_87_0] = var_87_2

					local var_87_3 = var_87_2:GetComponentInChildren(typeof(CharacterEffect))

					var_87_3.enabled = true

					local var_87_4 = GameObjectTools.GetOrAddComponent(var_87_2, typeof(DynamicBoneHelper))

					if var_87_4 then
						var_87_4:EnableDynamicBone(false)
					end

					arg_84_1:ShowWeapon(var_87_3.transform, false)

					arg_84_1.var_[var_87_0 .. "Animator"] = var_87_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_84_1.var_[var_87_0 .. "Animator"].applyRootMotion = true
					arg_84_1.var_[var_87_0 .. "LipSync"] = var_87_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_87_5 = arg_84_1.actors_["1156ui_story"].transform
			local var_87_6 = 0

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.var_.moveOldPos1156ui_story = var_87_5.localPosition
			end

			local var_87_7 = 0.001

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_7 then
				local var_87_8 = (arg_84_1.time_ - var_87_6) / var_87_7
				local var_87_9 = Vector3.New(0, -1.1, -6.18)

				var_87_5.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1156ui_story, var_87_9, var_87_8)

				local var_87_10 = manager.ui.mainCamera.transform.position - var_87_5.position

				var_87_5.forward = Vector3.New(var_87_10.x, var_87_10.y, var_87_10.z)

				local var_87_11 = var_87_5.localEulerAngles

				var_87_11.z = 0
				var_87_11.x = 0
				var_87_5.localEulerAngles = var_87_11
			end

			if arg_84_1.time_ >= var_87_6 + var_87_7 and arg_84_1.time_ < var_87_6 + var_87_7 + arg_87_0 then
				var_87_5.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_87_12 = manager.ui.mainCamera.transform.position - var_87_5.position

				var_87_5.forward = Vector3.New(var_87_12.x, var_87_12.y, var_87_12.z)

				local var_87_13 = var_87_5.localEulerAngles

				var_87_13.z = 0
				var_87_13.x = 0
				var_87_5.localEulerAngles = var_87_13
			end

			local var_87_14 = arg_84_1.actors_["1156ui_story"]
			local var_87_15 = 0

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 and not isNil(var_87_14) and arg_84_1.var_.characterEffect1156ui_story == nil then
				arg_84_1.var_.characterEffect1156ui_story = var_87_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_16 = 0.200000002980232

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_16 and not isNil(var_87_14) then
				local var_87_17 = (arg_84_1.time_ - var_87_15) / var_87_16

				if arg_84_1.var_.characterEffect1156ui_story and not isNil(var_87_14) then
					arg_84_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_15 + var_87_16 and arg_84_1.time_ < var_87_15 + var_87_16 + arg_87_0 and not isNil(var_87_14) and arg_84_1.var_.characterEffect1156ui_story then
				arg_84_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_87_18 = 0

			if var_87_18 < arg_84_1.time_ and arg_84_1.time_ <= var_87_18 + arg_87_0 then
				arg_84_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action11_1")
			end

			local var_87_19 = 0

			if var_87_19 < arg_84_1.time_ and arg_84_1.time_ <= var_87_19 + arg_87_0 then
				arg_84_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_87_20 = 0
			local var_87_21 = 0.225

			if var_87_20 < arg_84_1.time_ and arg_84_1.time_ <= var_87_20 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_22 = arg_84_1:FormatText(StoryNameCfg[605].name)

				arg_84_1.leftNameTxt_.text = var_87_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_23 = arg_84_1:GetWordFromCfg(320292018)
				local var_87_24 = arg_84_1:FormatText(var_87_23.content)

				arg_84_1.text_.text = var_87_24

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_25 = 9
				local var_87_26 = utf8.len(var_87_24)
				local var_87_27 = var_87_25 <= 0 and var_87_21 or var_87_21 * (var_87_26 / var_87_25)

				if var_87_27 > 0 and var_87_21 < var_87_27 then
					arg_84_1.talkMaxDuration = var_87_27

					if var_87_27 + var_87_20 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_27 + var_87_20
					end
				end

				arg_84_1.text_.text = var_87_24
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292018", "story_v_out_320292.awb") ~= 0 then
					local var_87_28 = manager.audio:GetVoiceLength("story_v_out_320292", "320292018", "story_v_out_320292.awb") / 1000

					if var_87_28 + var_87_20 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_28 + var_87_20
					end

					if var_87_23.prefab_name ~= "" and arg_84_1.actors_[var_87_23.prefab_name] ~= nil then
						local var_87_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_23.prefab_name].transform, "story_v_out_320292", "320292018", "story_v_out_320292.awb")

						arg_84_1:RecordAudio("320292018", var_87_29)
						arg_84_1:RecordAudio("320292018", var_87_29)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_320292", "320292018", "story_v_out_320292.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_320292", "320292018", "story_v_out_320292.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_30 = math.max(var_87_21, arg_84_1.talkMaxDuration)

			if var_87_20 <= arg_84_1.time_ and arg_84_1.time_ < var_87_20 + var_87_30 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_20) / var_87_30

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_20 + var_87_30 and arg_84_1.time_ < var_87_20 + var_87_30 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play320292019 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 320292019
		arg_88_1.duration_ = 6.33

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play320292020(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1156ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos1156ui_story = var_91_0.localPosition
			end

			local var_91_2 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2
				local var_91_4 = Vector3.New(0, 100, 0)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1156ui_story, var_91_4, var_91_3)

				local var_91_5 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_5.x, var_91_5.y, var_91_5.z)

				local var_91_6 = var_91_0.localEulerAngles

				var_91_6.z = 0
				var_91_6.x = 0
				var_91_0.localEulerAngles = var_91_6
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, 100, 0)

				local var_91_7 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_7.x, var_91_7.y, var_91_7.z)

				local var_91_8 = var_91_0.localEulerAngles

				var_91_8.z = 0
				var_91_8.x = 0
				var_91_0.localEulerAngles = var_91_8
			end

			local var_91_9 = arg_88_1.actors_["1156ui_story"]
			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect1156ui_story == nil then
				arg_88_1.var_.characterEffect1156ui_story = var_91_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_11 = 0.200000002980232

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 and not isNil(var_91_9) then
				local var_91_12 = (arg_88_1.time_ - var_91_10) / var_91_11

				if arg_88_1.var_.characterEffect1156ui_story and not isNil(var_91_9) then
					local var_91_13 = Mathf.Lerp(0, 0.5, var_91_12)

					arg_88_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1156ui_story.fillRatio = var_91_13
				end
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect1156ui_story then
				local var_91_14 = 0.5

				arg_88_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1156ui_story.fillRatio = var_91_14
			end

			local var_91_15 = 0.333333333333333
			local var_91_16 = 1

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				local var_91_17 = "play"
				local var_91_18 = "effect"

				arg_88_1:AudioAction(var_91_17, var_91_18, "se_story_16", "se_story_16_fight03", "")
			end

			local var_91_19 = 0.333333333333333

			if var_91_19 < arg_88_1.time_ and arg_88_1.time_ <= var_91_19 + arg_91_0 then
				arg_88_1.var_.shakeOldPos = var_91_0.localPosition
			end

			local var_91_20 = 1

			if var_91_19 <= arg_88_1.time_ and arg_88_1.time_ < var_91_19 + var_91_20 then
				local var_91_21 = (arg_88_1.time_ - var_91_19) / 0.066
				local var_91_22, var_91_23 = math.modf(var_91_21)

				var_91_0.localPosition = Vector3.New(var_91_23 * 0.13, var_91_23 * 0.13, var_91_23 * 0.13) + arg_88_1.var_.shakeOldPos
			end

			if arg_88_1.time_ >= var_91_19 + var_91_20 and arg_88_1.time_ < var_91_19 + var_91_20 + arg_91_0 then
				var_91_0.localPosition = arg_88_1.var_.shakeOldPos
			end

			local var_91_24 = 0

			if var_91_24 < arg_88_1.time_ and arg_88_1.time_ <= var_91_24 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			local var_91_25 = 1.33333333333333

			if arg_88_1.time_ >= var_91_24 + var_91_25 and arg_88_1.time_ < var_91_24 + var_91_25 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			local var_91_26 = 1.33333333333333
			local var_91_27 = 1.4

			if var_91_26 < arg_88_1.time_ and arg_88_1.time_ <= var_91_26 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_28 = arg_88_1:GetWordFromCfg(320292019)
				local var_91_29 = arg_88_1:FormatText(var_91_28.content)

				arg_88_1.text_.text = var_91_29

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_30 = 56
				local var_91_31 = utf8.len(var_91_29)
				local var_91_32 = var_91_30 <= 0 and var_91_27 or var_91_27 * (var_91_31 / var_91_30)

				if var_91_32 > 0 and var_91_27 < var_91_32 then
					arg_88_1.talkMaxDuration = var_91_32

					if var_91_32 + var_91_26 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_32 + var_91_26
					end
				end

				arg_88_1.text_.text = var_91_29
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_33 = math.max(var_91_27, arg_88_1.talkMaxDuration)

			if var_91_26 <= arg_88_1.time_ and arg_88_1.time_ < var_91_26 + var_91_33 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_26) / var_91_33

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_26 + var_91_33 and arg_88_1.time_ < var_91_26 + var_91_33 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	Play320292020 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 320292020
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play320292021(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 1.625

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_2 = arg_92_1:GetWordFromCfg(320292020)
				local var_95_3 = arg_92_1:FormatText(var_95_2.content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 65
				local var_95_5 = utf8.len(var_95_3)
				local var_95_6 = var_95_4 <= 0 and var_95_1 or var_95_1 * (var_95_5 / var_95_4)

				if var_95_6 > 0 and var_95_1 < var_95_6 then
					arg_92_1.talkMaxDuration = var_95_6

					if var_95_6 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_7 and arg_92_1.time_ < var_95_0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play320292021 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 320292021
		arg_96_1.duration_ = 3.03

		local var_96_0 = {
			zh = 3.033,
			ja = 2.833
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play320292022(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.125

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[605].name)

				arg_96_1.leftNameTxt_.text = var_99_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:GetWordFromCfg(320292021)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 5
				local var_99_6 = utf8.len(var_99_4)
				local var_99_7 = var_99_5 <= 0 and var_99_1 or var_99_1 * (var_99_6 / var_99_5)

				if var_99_7 > 0 and var_99_1 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292021", "story_v_out_320292.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292021", "story_v_out_320292.awb") / 1000

					if var_99_8 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_0
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_320292", "320292021", "story_v_out_320292.awb")

						arg_96_1:RecordAudio("320292021", var_99_9)
						arg_96_1:RecordAudio("320292021", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_320292", "320292021", "story_v_out_320292.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_320292", "320292021", "story_v_out_320292.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_10 and arg_96_1.time_ < var_99_0 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play320292022 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 320292022
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play320292023(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = manager.ui.mainCamera.transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				local var_103_2 = arg_100_1.var_.effect985
				local var_103_3
				local var_103_4 = var_103_0

				if not var_103_2 then
					var_103_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), var_103_4)
					var_103_2.name = "985"
					arg_100_1.var_.effect985 = var_103_2
				else
					var_103_2.transform:SetParent(var_103_4)
				end

				var_103_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_103_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_103_5 = manager.ui.mainCameraCom_
				local var_103_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_103_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_103_7 = var_103_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_103_8 = 15
				local var_103_9 = 2 * var_103_8 * Mathf.Tan(var_103_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_103_5.aspect
				local var_103_10 = 1
				local var_103_11 = 1.7777777777777777

				if var_103_11 < var_103_5.aspect then
					var_103_10 = var_103_9 / (2 * var_103_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_103_11)
				end

				for iter_103_0, iter_103_1 in ipairs(var_103_7) do
					local var_103_12 = iter_103_1.transform.localScale

					iter_103_1.transform.localScale = Vector3.New(var_103_12.x / var_103_6 * var_103_10, var_103_12.y / var_103_6, var_103_12.z)
				end
			end

			local var_103_13 = 0.333333333333333
			local var_103_14 = 1

			if var_103_13 < arg_100_1.time_ and arg_100_1.time_ <= var_103_13 + arg_103_0 then
				local var_103_15 = "play"
				local var_103_16 = "effect"

				arg_100_1:AudioAction(var_103_15, var_103_16, "se_story_120_00", "se_story_120_00_gunshot", "")
			end

			local var_103_17 = 0
			local var_103_18 = 1.65

			if var_103_17 < arg_100_1.time_ and arg_100_1.time_ <= var_103_17 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_19 = arg_100_1:GetWordFromCfg(320292022)
				local var_103_20 = arg_100_1:FormatText(var_103_19.content)

				arg_100_1.text_.text = var_103_20

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_21 = 66
				local var_103_22 = utf8.len(var_103_20)
				local var_103_23 = var_103_21 <= 0 and var_103_18 or var_103_18 * (var_103_22 / var_103_21)

				if var_103_23 > 0 and var_103_18 < var_103_23 then
					arg_100_1.talkMaxDuration = var_103_23

					if var_103_23 + var_103_17 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_23 + var_103_17
					end
				end

				arg_100_1.text_.text = var_103_20
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_24 = math.max(var_103_18, arg_100_1.talkMaxDuration)

			if var_103_17 <= arg_100_1.time_ and arg_100_1.time_ < var_103_17 + var_103_24 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_17) / var_103_24

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_17 + var_103_24 and arg_100_1.time_ < var_103_17 + var_103_24 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play320292023 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 320292023
		arg_104_1.duration_ = 2

		local var_104_0 = {
			zh = 1.333,
			ja = 2
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play320292024(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.125

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[605].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(320292023)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 5
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292023", "story_v_out_320292.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292023", "story_v_out_320292.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_320292", "320292023", "story_v_out_320292.awb")

						arg_104_1:RecordAudio("320292023", var_107_9)
						arg_104_1:RecordAudio("320292023", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_320292", "320292023", "story_v_out_320292.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_320292", "320292023", "story_v_out_320292.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_10 and arg_104_1.time_ < var_107_0 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play320292024 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 320292024
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play320292025(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.225

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_2 = arg_108_1:GetWordFromCfg(320292024)
				local var_111_3 = arg_108_1:FormatText(var_111_2.content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 9
				local var_111_5 = utf8.len(var_111_3)
				local var_111_6 = var_111_4 <= 0 and var_111_1 or var_111_1 * (var_111_5 / var_111_4)

				if var_111_6 > 0 and var_111_1 < var_111_6 then
					arg_108_1.talkMaxDuration = var_111_6

					if var_111_6 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_7 and arg_108_1.time_ < var_111_0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play320292025 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 320292025
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play320292026(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 1.3

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_2 = arg_112_1:GetWordFromCfg(320292025)
				local var_115_3 = arg_112_1:FormatText(var_115_2.content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 52
				local var_115_5 = utf8.len(var_115_3)
				local var_115_6 = var_115_4 <= 0 and var_115_1 or var_115_1 * (var_115_5 / var_115_4)

				if var_115_6 > 0 and var_115_1 < var_115_6 then
					arg_112_1.talkMaxDuration = var_115_6

					if var_115_6 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_3
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_7 and arg_112_1.time_ < var_115_0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play320292026 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 320292026
		arg_116_1.duration_ = 4.97

		local var_116_0 = {
			zh = 4.5,
			ja = 4.966
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play320292027(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.25

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[1067].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4043")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:GetWordFromCfg(320292026)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 10
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292026", "story_v_out_320292.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292026", "story_v_out_320292.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_320292", "320292026", "story_v_out_320292.awb")

						arg_116_1:RecordAudio("320292026", var_119_9)
						arg_116_1:RecordAudio("320292026", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_320292", "320292026", "story_v_out_320292.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_320292", "320292026", "story_v_out_320292.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_10 and arg_116_1.time_ < var_119_0 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play320292027 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 320292027
		arg_120_1.duration_ = 5.77

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play320292028(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = manager.ui.mainCamera.transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				local var_123_2 = arg_120_1.var_.effect211
				local var_123_3
				local var_123_4 = var_123_0

				if not var_123_2 then
					var_123_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_123_4)
					var_123_2.name = "211"
					arg_120_1.var_.effect211 = var_123_2
				else
					var_123_2.transform:SetParent(var_123_4)
				end

				var_123_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_123_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_123_5 = manager.ui.mainCamera.transform
			local var_123_6 = 1

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				local var_123_7 = arg_120_1.var_.effect211

				if var_123_7 then
					Object.Destroy(var_123_7)

					arg_120_1.var_.effect211 = nil
				end
			end

			local var_123_8 = manager.ui.mainCamera.transform
			local var_123_9 = 0

			if var_123_9 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 then
				local var_123_10 = arg_120_1.var_.effect985

				if var_123_10 then
					Object.Destroy(var_123_10)

					arg_120_1.var_.effect985 = nil
				end
			end

			if arg_120_1.frameCnt_ <= 1 then
				arg_120_1.dialog_:SetActive(false)
			end

			local var_123_11 = 0.766666666666667
			local var_123_12 = 1.375

			if var_123_11 < arg_120_1.time_ and arg_120_1.time_ <= var_123_11 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0

				arg_120_1.dialog_:SetActive(true)

				arg_120_1.dialogCg_.alpha = 0

				local var_123_13 = LeanTween.value(arg_120_1.dialog_, 0, 1, 0.3)

				var_123_13:setOnUpdate(LuaHelper.FloatAction(function(arg_124_0)
					arg_120_1.dialogCg_.alpha = arg_124_0
				end))
				var_123_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_120_1.dialog_)
					var_123_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_120_1.duration_ = arg_120_1.duration_ + 0.3

				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_14 = arg_120_1:GetWordFromCfg(320292027)
				local var_123_15 = arg_120_1:FormatText(var_123_14.content)

				arg_120_1.text_.text = var_123_15

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_16 = 55
				local var_123_17 = utf8.len(var_123_15)
				local var_123_18 = var_123_16 <= 0 and var_123_12 or var_123_12 * (var_123_17 / var_123_16)

				if var_123_18 > 0 and var_123_12 < var_123_18 then
					arg_120_1.talkMaxDuration = var_123_18
					var_123_11 = var_123_11 + 0.3

					if var_123_18 + var_123_11 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_18 + var_123_11
					end
				end

				arg_120_1.text_.text = var_123_15
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_19 = var_123_11 + 0.3
			local var_123_20 = math.max(var_123_12, arg_120_1.talkMaxDuration)

			if var_123_19 <= arg_120_1.time_ and arg_120_1.time_ < var_123_19 + var_123_20 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_19) / var_123_20

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_19 + var_123_20 and arg_120_1.time_ < var_123_19 + var_123_20 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play320292028 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 320292028
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play320292029(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 1.475

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_2 = arg_126_1:GetWordFromCfg(320292028)
				local var_129_3 = arg_126_1:FormatText(var_129_2.content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 59
				local var_129_5 = utf8.len(var_129_3)
				local var_129_6 = var_129_4 <= 0 and var_129_1 or var_129_1 * (var_129_5 / var_129_4)

				if var_129_6 > 0 and var_129_1 < var_129_6 then
					arg_126_1.talkMaxDuration = var_129_6

					if var_129_6 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_6 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_7 and arg_126_1.time_ < var_129_0 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play320292029 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 320292029
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play320292030(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 1.65

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(320292029)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 66
				local var_133_5 = utf8.len(var_133_3)
				local var_133_6 = var_133_4 <= 0 and var_133_1 or var_133_1 * (var_133_5 / var_133_4)

				if var_133_6 > 0 and var_133_1 < var_133_6 then
					arg_130_1.talkMaxDuration = var_133_6

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_7 and arg_130_1.time_ < var_133_0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play320292030 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 320292030
		arg_134_1.duration_ = 2.97

		local var_134_0 = {
			zh = 2.966,
			ja = 1.3
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play320292031(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 0.225

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_2 = arg_134_1:FormatText(StoryNameCfg[605].name)

				arg_134_1.leftNameTxt_.text = var_137_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:GetWordFromCfg(320292030)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 9
				local var_137_6 = utf8.len(var_137_4)
				local var_137_7 = var_137_5 <= 0 and var_137_1 or var_137_1 * (var_137_6 / var_137_5)

				if var_137_7 > 0 and var_137_1 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292030", "story_v_out_320292.awb") ~= 0 then
					local var_137_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292030", "story_v_out_320292.awb") / 1000

					if var_137_8 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_0
					end

					if var_137_3.prefab_name ~= "" and arg_134_1.actors_[var_137_3.prefab_name] ~= nil then
						local var_137_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_3.prefab_name].transform, "story_v_out_320292", "320292030", "story_v_out_320292.awb")

						arg_134_1:RecordAudio("320292030", var_137_9)
						arg_134_1:RecordAudio("320292030", var_137_9)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_320292", "320292030", "story_v_out_320292.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_320292", "320292030", "story_v_out_320292.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_10 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_10 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_10

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_10 and arg_134_1.time_ < var_137_0 + var_137_10 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play320292031 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 320292031
		arg_138_1.duration_ = 6

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play320292032(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.mask_.enabled = true
				arg_138_1.mask_.raycastTarget = true

				arg_138_1:SetGaussion(false)
			end

			local var_141_1 = 0.333333343267441

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_1 then
				local var_141_2 = (arg_138_1.time_ - var_141_0) / var_141_1
				local var_141_3 = Color.New(1, 1, 1)

				var_141_3.a = Mathf.Lerp(1, 0, var_141_2)
				arg_138_1.mask_.color = var_141_3
			end

			if arg_138_1.time_ >= var_141_0 + var_141_1 and arg_138_1.time_ < var_141_0 + var_141_1 + arg_141_0 then
				local var_141_4 = Color.New(1, 1, 1)
				local var_141_5 = 0

				arg_138_1.mask_.enabled = false
				var_141_4.a = var_141_5
				arg_138_1.mask_.color = var_141_4
			end

			local var_141_6 = 0.333333343267441

			if var_141_6 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.mask_.enabled = true
				arg_138_1.mask_.raycastTarget = true

				arg_138_1:SetGaussion(false)
			end

			local var_141_7 = 0.333333343267441

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_7 then
				local var_141_8 = (arg_138_1.time_ - var_141_6) / var_141_7
				local var_141_9 = Color.New(1, 1, 1)

				var_141_9.a = Mathf.Lerp(1, 0, var_141_8)
				arg_138_1.mask_.color = var_141_9
			end

			if arg_138_1.time_ >= var_141_6 + var_141_7 and arg_138_1.time_ < var_141_6 + var_141_7 + arg_141_0 then
				local var_141_10 = Color.New(1, 1, 1)
				local var_141_11 = 0

				arg_138_1.mask_.enabled = false
				var_141_10.a = var_141_11
				arg_138_1.mask_.color = var_141_10
			end

			local var_141_12 = manager.ui.mainCamera.transform
			local var_141_13 = 0.5

			if var_141_13 < arg_138_1.time_ and arg_138_1.time_ <= var_141_13 + arg_141_0 then
				arg_138_1.var_.shakeOldPos = var_141_12.localPosition
			end

			local var_141_14 = 0.733333333333333

			if var_141_13 <= arg_138_1.time_ and arg_138_1.time_ < var_141_13 + var_141_14 then
				local var_141_15 = (arg_138_1.time_ - var_141_13) / 0.066
				local var_141_16, var_141_17 = math.modf(var_141_15)

				var_141_12.localPosition = Vector3.New(var_141_17 * 0.13, var_141_17 * 0.13, var_141_17 * 0.13) + arg_138_1.var_.shakeOldPos
			end

			if arg_138_1.time_ >= var_141_13 + var_141_14 and arg_138_1.time_ < var_141_13 + var_141_14 + arg_141_0 then
				var_141_12.localPosition = arg_138_1.var_.shakeOldPos
			end

			local var_141_18 = manager.ui.mainCamera.transform
			local var_141_19 = 0

			if var_141_19 < arg_138_1.time_ and arg_138_1.time_ <= var_141_19 + arg_141_0 then
				local var_141_20 = arg_138_1.var_.effect985

				if var_141_20 then
					Object.Destroy(var_141_20)

					arg_138_1.var_.effect985 = nil
				end
			end

			local var_141_21 = 0.333333333333333
			local var_141_22 = 1

			if var_141_21 < arg_138_1.time_ and arg_138_1.time_ <= var_141_21 + arg_141_0 then
				local var_141_23 = "play"
				local var_141_24 = "effect"

				arg_138_1:AudioAction(var_141_23, var_141_24, "se_story_16", "se_story_16_blast", "")
			end

			if arg_138_1.frameCnt_ <= 1 then
				arg_138_1.dialog_:SetActive(false)
			end

			local var_141_25 = 1
			local var_141_26 = 1.525

			if var_141_25 < arg_138_1.time_ and arg_138_1.time_ <= var_141_25 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0

				arg_138_1.dialog_:SetActive(true)

				arg_138_1.dialogCg_.alpha = 0

				local var_141_27 = LeanTween.value(arg_138_1.dialog_, 0, 1, 0.3)

				var_141_27:setOnUpdate(LuaHelper.FloatAction(function(arg_142_0)
					arg_138_1.dialogCg_.alpha = arg_142_0
				end))
				var_141_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_138_1.dialog_)
					var_141_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_138_1.duration_ = arg_138_1.duration_ + 0.3

				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_28 = arg_138_1:GetWordFromCfg(320292031)
				local var_141_29 = arg_138_1:FormatText(var_141_28.content)

				arg_138_1.text_.text = var_141_29

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_30 = 61
				local var_141_31 = utf8.len(var_141_29)
				local var_141_32 = var_141_30 <= 0 and var_141_26 or var_141_26 * (var_141_31 / var_141_30)

				if var_141_32 > 0 and var_141_26 < var_141_32 then
					arg_138_1.talkMaxDuration = var_141_32
					var_141_25 = var_141_25 + 0.3

					if var_141_32 + var_141_25 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_32 + var_141_25
					end
				end

				arg_138_1.text_.text = var_141_29
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_33 = var_141_25 + 0.3
			local var_141_34 = math.max(var_141_26, arg_138_1.talkMaxDuration)

			if var_141_33 <= arg_138_1.time_ and arg_138_1.time_ < var_141_33 + var_141_34 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_33) / var_141_34

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_33 + var_141_34 and arg_138_1.time_ < var_141_33 + var_141_34 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play320292032 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 320292032
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play320292033(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 1.725

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_2 = arg_144_1:GetWordFromCfg(320292032)
				local var_147_3 = arg_144_1:FormatText(var_147_2.content)

				arg_144_1.text_.text = var_147_3

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 69
				local var_147_5 = utf8.len(var_147_3)
				local var_147_6 = var_147_4 <= 0 and var_147_1 or var_147_1 * (var_147_5 / var_147_4)

				if var_147_6 > 0 and var_147_1 < var_147_6 then
					arg_144_1.talkMaxDuration = var_147_6

					if var_147_6 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_6 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_3
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_7 and arg_144_1.time_ < var_147_0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play320292033 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 320292033
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play320292034(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.2
			local var_151_1 = 1

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				local var_151_2 = "play"
				local var_151_3 = "effect"

				arg_148_1:AudioAction(var_151_2, var_151_3, "se_story_side_1148", "se_story_1148_explosion", "")
			end

			local var_151_4 = 0
			local var_151_5 = 0.9

			if var_151_4 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_6 = arg_148_1:GetWordFromCfg(320292033)
				local var_151_7 = arg_148_1:FormatText(var_151_6.content)

				arg_148_1.text_.text = var_151_7

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_8 = 36
				local var_151_9 = utf8.len(var_151_7)
				local var_151_10 = var_151_8 <= 0 and var_151_5 or var_151_5 * (var_151_9 / var_151_8)

				if var_151_10 > 0 and var_151_5 < var_151_10 then
					arg_148_1.talkMaxDuration = var_151_10

					if var_151_10 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_4
					end
				end

				arg_148_1.text_.text = var_151_7
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_11 = math.max(var_151_5, arg_148_1.talkMaxDuration)

			if var_151_4 <= arg_148_1.time_ and arg_148_1.time_ < var_151_4 + var_151_11 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_4) / var_151_11

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_4 + var_151_11 and arg_148_1.time_ < var_151_4 + var_151_11 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play320292034 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 320292034
		arg_152_1.duration_ = 3.2

		local var_152_0 = {
			zh = 2,
			ja = 3.2
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play320292035(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.2

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[1031].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:GetWordFromCfg(320292034)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 8
				local var_155_6 = utf8.len(var_155_4)
				local var_155_7 = var_155_5 <= 0 and var_155_1 or var_155_1 * (var_155_6 / var_155_5)

				if var_155_7 > 0 and var_155_1 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292034", "story_v_out_320292.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292034", "story_v_out_320292.awb") / 1000

					if var_155_8 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_0
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_out_320292", "320292034", "story_v_out_320292.awb")

						arg_152_1:RecordAudio("320292034", var_155_9)
						arg_152_1:RecordAudio("320292034", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_320292", "320292034", "story_v_out_320292.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_320292", "320292034", "story_v_out_320292.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_10 and arg_152_1.time_ < var_155_0 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play320292035 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 320292035
		arg_156_1.duration_ = 5.8

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play320292036(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = manager.ui.mainCamera.transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				local var_159_2 = arg_156_1.var_.effect999
				local var_159_3
				local var_159_4 = var_159_0

				if not var_159_2 then
					var_159_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_159_4)
					var_159_2.name = "999"
					arg_156_1.var_.effect999 = var_159_2
				else
					var_159_2.transform:SetParent(var_159_4)
				end

				var_159_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_159_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_159_5 = manager.ui.mainCamera.transform
			local var_159_6 = 1.36666666666667

			if var_159_6 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				local var_159_7 = arg_156_1.var_.effect999

				if var_159_7 then
					Object.Destroy(var_159_7)

					arg_156_1.var_.effect999 = nil
				end
			end

			local var_159_8 = 0.333333333333333
			local var_159_9 = 1

			if var_159_8 < arg_156_1.time_ and arg_156_1.time_ <= var_159_8 + arg_159_0 then
				local var_159_10 = "play"
				local var_159_11 = "effect"

				arg_156_1:AudioAction(var_159_10, var_159_11, "se_story_16", "se_story_16_wind02", "")
			end

			if arg_156_1.frameCnt_ <= 1 then
				arg_156_1.dialog_:SetActive(false)
			end

			local var_159_12 = 0.8
			local var_159_13 = 0.75

			if var_159_12 < arg_156_1.time_ and arg_156_1.time_ <= var_159_12 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				arg_156_1.dialog_:SetActive(true)

				arg_156_1.dialogCg_.alpha = 0

				local var_159_14 = LeanTween.value(arg_156_1.dialog_, 0, 1, 0.3)

				var_159_14:setOnUpdate(LuaHelper.FloatAction(function(arg_160_0)
					arg_156_1.dialogCg_.alpha = arg_160_0
				end))
				var_159_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_156_1.dialog_)
					var_159_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_156_1.duration_ = arg_156_1.duration_ + 0.3

				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_15 = arg_156_1:GetWordFromCfg(320292035)
				local var_159_16 = arg_156_1:FormatText(var_159_15.content)

				arg_156_1.text_.text = var_159_16

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_17 = 30
				local var_159_18 = utf8.len(var_159_16)
				local var_159_19 = var_159_17 <= 0 and var_159_13 or var_159_13 * (var_159_18 / var_159_17)

				if var_159_19 > 0 and var_159_13 < var_159_19 then
					arg_156_1.talkMaxDuration = var_159_19
					var_159_12 = var_159_12 + 0.3

					if var_159_19 + var_159_12 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_19 + var_159_12
					end
				end

				arg_156_1.text_.text = var_159_16
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_20 = var_159_12 + 0.3
			local var_159_21 = math.max(var_159_13, arg_156_1.talkMaxDuration)

			if var_159_20 <= arg_156_1.time_ and arg_156_1.time_ < var_159_20 + var_159_21 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_20) / var_159_21

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_20 + var_159_21 and arg_156_1.time_ < var_159_20 + var_159_21 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play320292036 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 320292036
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play320292037(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 1.775

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_2 = arg_162_1:GetWordFromCfg(320292036)
				local var_165_3 = arg_162_1:FormatText(var_165_2.content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 71
				local var_165_5 = utf8.len(var_165_3)
				local var_165_6 = var_165_4 <= 0 and var_165_1 or var_165_1 * (var_165_5 / var_165_4)

				if var_165_6 > 0 and var_165_1 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_7 and arg_162_1.time_ < var_165_0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play320292037 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 320292037
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play320292038(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 0.6

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_2 = arg_166_1:GetWordFromCfg(320292037)
				local var_169_3 = arg_166_1:FormatText(var_169_2.content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_4 = 24
				local var_169_5 = utf8.len(var_169_3)
				local var_169_6 = var_169_4 <= 0 and var_169_1 or var_169_1 * (var_169_5 / var_169_4)

				if var_169_6 > 0 and var_169_1 < var_169_6 then
					arg_166_1.talkMaxDuration = var_169_6

					if var_169_6 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_6 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_7 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_7 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_7

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_7 and arg_166_1.time_ < var_169_0 + var_169_7 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play320292038 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 320292038
		arg_170_1.duration_ = 3.9

		local var_170_0 = {
			zh = 3.366,
			ja = 3.9
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play320292039(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 0.275

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_2 = arg_170_1:FormatText(StoryNameCfg[1031].name)

				arg_170_1.leftNameTxt_.text = var_173_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_3 = arg_170_1:GetWordFromCfg(320292038)
				local var_173_4 = arg_170_1:FormatText(var_173_3.content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 11
				local var_173_6 = utf8.len(var_173_4)
				local var_173_7 = var_173_5 <= 0 and var_173_1 or var_173_1 * (var_173_6 / var_173_5)

				if var_173_7 > 0 and var_173_1 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_4
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292038", "story_v_out_320292.awb") ~= 0 then
					local var_173_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292038", "story_v_out_320292.awb") / 1000

					if var_173_8 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_0
					end

					if var_173_3.prefab_name ~= "" and arg_170_1.actors_[var_173_3.prefab_name] ~= nil then
						local var_173_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_3.prefab_name].transform, "story_v_out_320292", "320292038", "story_v_out_320292.awb")

						arg_170_1:RecordAudio("320292038", var_173_9)
						arg_170_1:RecordAudio("320292038", var_173_9)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_320292", "320292038", "story_v_out_320292.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_320292", "320292038", "story_v_out_320292.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_10 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_10 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_10

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_10 and arg_170_1.time_ < var_173_0 + var_173_10 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play320292039 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 320292039
		arg_174_1.duration_ = 5.67

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play320292040(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = manager.ui.mainCamera.transform
			local var_177_1 = 0.266666666666667

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.shakeOldPos = var_177_0.localPosition
			end

			local var_177_2 = 0.633333333333333

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / 0.066
				local var_177_4, var_177_5 = math.modf(var_177_3)

				var_177_0.localPosition = Vector3.New(var_177_5 * 0.13, var_177_5 * 0.13, var_177_5 * 0.13) + arg_174_1.var_.shakeOldPos
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 then
				var_177_0.localPosition = arg_174_1.var_.shakeOldPos
			end

			local var_177_6 = 0

			if var_177_6 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				arg_174_1.mask_.enabled = true
				arg_174_1.mask_.raycastTarget = false

				arg_174_1:SetGaussion(false)
			end

			local var_177_7 = 0.466666666666667

			if var_177_6 <= arg_174_1.time_ and arg_174_1.time_ < var_177_6 + var_177_7 then
				local var_177_8 = (arg_174_1.time_ - var_177_6) / var_177_7
				local var_177_9 = Color.New(0.4150943, 0, 0)

				var_177_9.a = Mathf.Lerp(1, 0, var_177_8)
				arg_174_1.mask_.color = var_177_9
			end

			if arg_174_1.time_ >= var_177_6 + var_177_7 and arg_174_1.time_ < var_177_6 + var_177_7 + arg_177_0 then
				local var_177_10 = Color.New(0.4150943, 0, 0)
				local var_177_11 = 0

				arg_174_1.mask_.enabled = false
				var_177_10.a = var_177_11
				arg_174_1.mask_.color = var_177_10
			end

			local var_177_12 = 0.333333333333333
			local var_177_13 = 1

			if var_177_12 < arg_174_1.time_ and arg_174_1.time_ <= var_177_12 + arg_177_0 then
				local var_177_14 = "play"
				local var_177_15 = "effect"

				arg_174_1:AudioAction(var_177_14, var_177_15, "se_story_130", "se_story_130_gun", "")
			end

			if arg_174_1.frameCnt_ <= 1 then
				arg_174_1.dialog_:SetActive(false)
			end

			local var_177_16 = 0.666666666666667
			local var_177_17 = 1.2

			if var_177_16 < arg_174_1.time_ and arg_174_1.time_ <= var_177_16 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0

				arg_174_1.dialog_:SetActive(true)

				arg_174_1.dialogCg_.alpha = 0

				local var_177_18 = LeanTween.value(arg_174_1.dialog_, 0, 1, 0.3)

				var_177_18:setOnUpdate(LuaHelper.FloatAction(function(arg_178_0)
					arg_174_1.dialogCg_.alpha = arg_178_0
				end))
				var_177_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_174_1.dialog_)
					var_177_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_174_1.duration_ = arg_174_1.duration_ + 0.3

				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_19 = arg_174_1:GetWordFromCfg(320292039)
				local var_177_20 = arg_174_1:FormatText(var_177_19.content)

				arg_174_1.text_.text = var_177_20

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_21 = 48
				local var_177_22 = utf8.len(var_177_20)
				local var_177_23 = var_177_21 <= 0 and var_177_17 or var_177_17 * (var_177_22 / var_177_21)

				if var_177_23 > 0 and var_177_17 < var_177_23 then
					arg_174_1.talkMaxDuration = var_177_23
					var_177_16 = var_177_16 + 0.3

					if var_177_23 + var_177_16 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_23 + var_177_16
					end
				end

				arg_174_1.text_.text = var_177_20
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_24 = var_177_16 + 0.3
			local var_177_25 = math.max(var_177_17, arg_174_1.talkMaxDuration)

			if var_177_24 <= arg_174_1.time_ and arg_174_1.time_ < var_177_24 + var_177_25 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_24) / var_177_25

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_24 + var_177_25 and arg_174_1.time_ < var_177_24 + var_177_25 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play320292040 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 320292040
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play320292041(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0
			local var_183_1 = 1.025

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_2 = arg_180_1:GetWordFromCfg(320292040)
				local var_183_3 = arg_180_1:FormatText(var_183_2.content)

				arg_180_1.text_.text = var_183_3

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_4 = 41
				local var_183_5 = utf8.len(var_183_3)
				local var_183_6 = var_183_4 <= 0 and var_183_1 or var_183_1 * (var_183_5 / var_183_4)

				if var_183_6 > 0 and var_183_1 < var_183_6 then
					arg_180_1.talkMaxDuration = var_183_6

					if var_183_6 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_6 + var_183_0
					end
				end

				arg_180_1.text_.text = var_183_3
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_7 = math.max(var_183_1, arg_180_1.talkMaxDuration)

			if var_183_0 <= arg_180_1.time_ and arg_180_1.time_ < var_183_0 + var_183_7 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_0) / var_183_7

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_0 + var_183_7 and arg_180_1.time_ < var_183_0 + var_183_7 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play320292041 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 320292041
		arg_184_1.duration_ = 3.8

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play320292042(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0
			local var_187_1 = 0.175

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_2 = arg_184_1:FormatText(StoryNameCfg[1067].name)

				arg_184_1.leftNameTxt_.text = var_187_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4043")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_3 = arg_184_1:GetWordFromCfg(320292041)
				local var_187_4 = arg_184_1:FormatText(var_187_3.content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 7
				local var_187_6 = utf8.len(var_187_4)
				local var_187_7 = var_187_5 <= 0 and var_187_1 or var_187_1 * (var_187_6 / var_187_5)

				if var_187_7 > 0 and var_187_1 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_0
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292041", "story_v_out_320292.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292041", "story_v_out_320292.awb") / 1000

					if var_187_8 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_0
					end

					if var_187_3.prefab_name ~= "" and arg_184_1.actors_[var_187_3.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_3.prefab_name].transform, "story_v_out_320292", "320292041", "story_v_out_320292.awb")

						arg_184_1:RecordAudio("320292041", var_187_9)
						arg_184_1:RecordAudio("320292041", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_320292", "320292041", "story_v_out_320292.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_320292", "320292041", "story_v_out_320292.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_1, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_0) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_10 and arg_184_1.time_ < var_187_0 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play320292042 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 320292042
		arg_188_1.duration_ = 6.33

		local var_188_0 = {
			zh = 6.333,
			ja = 5.333
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play320292043(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1156ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos1156ui_story = var_191_0.localPosition
			end

			local var_191_2 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2
				local var_191_4 = Vector3.New(0, -1.1, -6.18)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1156ui_story, var_191_4, var_191_3)

				local var_191_5 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_5.x, var_191_5.y, var_191_5.z)

				local var_191_6 = var_191_0.localEulerAngles

				var_191_6.z = 0
				var_191_6.x = 0
				var_191_0.localEulerAngles = var_191_6
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_191_7 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_7.x, var_191_7.y, var_191_7.z)

				local var_191_8 = var_191_0.localEulerAngles

				var_191_8.z = 0
				var_191_8.x = 0
				var_191_0.localEulerAngles = var_191_8
			end

			local var_191_9 = arg_188_1.actors_["1156ui_story"]
			local var_191_10 = 0

			if var_191_10 < arg_188_1.time_ and arg_188_1.time_ <= var_191_10 + arg_191_0 and not isNil(var_191_9) and arg_188_1.var_.characterEffect1156ui_story == nil then
				arg_188_1.var_.characterEffect1156ui_story = var_191_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_11 = 0.200000002980232

			if var_191_10 <= arg_188_1.time_ and arg_188_1.time_ < var_191_10 + var_191_11 and not isNil(var_191_9) then
				local var_191_12 = (arg_188_1.time_ - var_191_10) / var_191_11

				if arg_188_1.var_.characterEffect1156ui_story and not isNil(var_191_9) then
					arg_188_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_10 + var_191_11 and arg_188_1.time_ < var_191_10 + var_191_11 + arg_191_0 and not isNil(var_191_9) and arg_188_1.var_.characterEffect1156ui_story then
				arg_188_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_191_13 = 0

			if var_191_13 < arg_188_1.time_ and arg_188_1.time_ <= var_191_13 + arg_191_0 then
				arg_188_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action7_1")
			end

			local var_191_14 = 0

			if var_191_14 < arg_188_1.time_ and arg_188_1.time_ <= var_191_14 + arg_191_0 then
				arg_188_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_191_15 = 0
			local var_191_16 = 0.55

			if var_191_15 < arg_188_1.time_ and arg_188_1.time_ <= var_191_15 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_17 = arg_188_1:FormatText(StoryNameCfg[605].name)

				arg_188_1.leftNameTxt_.text = var_191_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_18 = arg_188_1:GetWordFromCfg(320292042)
				local var_191_19 = arg_188_1:FormatText(var_191_18.content)

				arg_188_1.text_.text = var_191_19

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_20 = 22
				local var_191_21 = utf8.len(var_191_19)
				local var_191_22 = var_191_20 <= 0 and var_191_16 or var_191_16 * (var_191_21 / var_191_20)

				if var_191_22 > 0 and var_191_16 < var_191_22 then
					arg_188_1.talkMaxDuration = var_191_22

					if var_191_22 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_22 + var_191_15
					end
				end

				arg_188_1.text_.text = var_191_19
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292042", "story_v_out_320292.awb") ~= 0 then
					local var_191_23 = manager.audio:GetVoiceLength("story_v_out_320292", "320292042", "story_v_out_320292.awb") / 1000

					if var_191_23 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_23 + var_191_15
					end

					if var_191_18.prefab_name ~= "" and arg_188_1.actors_[var_191_18.prefab_name] ~= nil then
						local var_191_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_18.prefab_name].transform, "story_v_out_320292", "320292042", "story_v_out_320292.awb")

						arg_188_1:RecordAudio("320292042", var_191_24)
						arg_188_1:RecordAudio("320292042", var_191_24)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_320292", "320292042", "story_v_out_320292.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_320292", "320292042", "story_v_out_320292.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_25 = math.max(var_191_16, arg_188_1.talkMaxDuration)

			if var_191_15 <= arg_188_1.time_ and arg_188_1.time_ < var_191_15 + var_191_25 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_15) / var_191_25

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_15 + var_191_25 and arg_188_1.time_ < var_191_15 + var_191_25 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
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

		arg_188_1:InitPlayNodeList()
	end,
	Play320292043 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 320292043
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play320292044(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1156ui_story"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos1156ui_story = var_195_0.localPosition
			end

			local var_195_2 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2
				local var_195_4 = Vector3.New(0, 100, 0)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1156ui_story, var_195_4, var_195_3)

				local var_195_5 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_5.x, var_195_5.y, var_195_5.z)

				local var_195_6 = var_195_0.localEulerAngles

				var_195_6.z = 0
				var_195_6.x = 0
				var_195_0.localEulerAngles = var_195_6
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(0, 100, 0)

				local var_195_7 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_7.x, var_195_7.y, var_195_7.z)

				local var_195_8 = var_195_0.localEulerAngles

				var_195_8.z = 0
				var_195_8.x = 0
				var_195_0.localEulerAngles = var_195_8
			end

			local var_195_9 = arg_192_1.actors_["1156ui_story"]
			local var_195_10 = 0

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 and not isNil(var_195_9) and arg_192_1.var_.characterEffect1156ui_story == nil then
				arg_192_1.var_.characterEffect1156ui_story = var_195_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_11 = 0.200000002980232

			if var_195_10 <= arg_192_1.time_ and arg_192_1.time_ < var_195_10 + var_195_11 and not isNil(var_195_9) then
				local var_195_12 = (arg_192_1.time_ - var_195_10) / var_195_11

				if arg_192_1.var_.characterEffect1156ui_story and not isNil(var_195_9) then
					local var_195_13 = Mathf.Lerp(0, 0.5, var_195_12)

					arg_192_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1156ui_story.fillRatio = var_195_13
				end
			end

			if arg_192_1.time_ >= var_195_10 + var_195_11 and arg_192_1.time_ < var_195_10 + var_195_11 + arg_195_0 and not isNil(var_195_9) and arg_192_1.var_.characterEffect1156ui_story then
				local var_195_14 = 0.5

				arg_192_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1156ui_story.fillRatio = var_195_14
			end

			local var_195_15 = 0
			local var_195_16 = 1.475

			if var_195_15 < arg_192_1.time_ and arg_192_1.time_ <= var_195_15 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_17 = arg_192_1:GetWordFromCfg(320292043)
				local var_195_18 = arg_192_1:FormatText(var_195_17.content)

				arg_192_1.text_.text = var_195_18

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_19 = 59
				local var_195_20 = utf8.len(var_195_18)
				local var_195_21 = var_195_19 <= 0 and var_195_16 or var_195_16 * (var_195_20 / var_195_19)

				if var_195_21 > 0 and var_195_16 < var_195_21 then
					arg_192_1.talkMaxDuration = var_195_21

					if var_195_21 + var_195_15 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_21 + var_195_15
					end
				end

				arg_192_1.text_.text = var_195_18
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_22 = math.max(var_195_16, arg_192_1.talkMaxDuration)

			if var_195_15 <= arg_192_1.time_ and arg_192_1.time_ < var_195_15 + var_195_22 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_15) / var_195_22

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_15 + var_195_22 and arg_192_1.time_ < var_195_15 + var_195_22 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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

		arg_192_1:InitPlayNodeList()
	end,
	Play320292044 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 320292044
		arg_196_1.duration_ = 6.77

		local var_196_0 = {
			zh = 5.833,
			ja = 6.766
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play320292045(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.35

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_2 = arg_196_1:FormatText(StoryNameCfg[1031].name)

				arg_196_1.leftNameTxt_.text = var_199_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_3 = arg_196_1:GetWordFromCfg(320292044)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 14
				local var_199_6 = utf8.len(var_199_4)
				local var_199_7 = var_199_5 <= 0 and var_199_1 or var_199_1 * (var_199_6 / var_199_5)

				if var_199_7 > 0 and var_199_1 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292044", "story_v_out_320292.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_out_320292", "320292044", "story_v_out_320292.awb") / 1000

					if var_199_8 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_0
					end

					if var_199_3.prefab_name ~= "" and arg_196_1.actors_[var_199_3.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_3.prefab_name].transform, "story_v_out_320292", "320292044", "story_v_out_320292.awb")

						arg_196_1:RecordAudio("320292044", var_199_9)
						arg_196_1:RecordAudio("320292044", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_320292", "320292044", "story_v_out_320292.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_320292", "320292044", "story_v_out_320292.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_10 and arg_196_1.time_ < var_199_0 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play320292045 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 320292045
		arg_200_1.duration_ = 3.37

		local var_200_0 = {
			zh = 3.366,
			ja = 3.266
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play320292046(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1156ui_story"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos1156ui_story = var_203_0.localPosition
			end

			local var_203_2 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2
				local var_203_4 = Vector3.New(0, -1.1, -6.18)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1156ui_story, var_203_4, var_203_3)

				local var_203_5 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_5.x, var_203_5.y, var_203_5.z)

				local var_203_6 = var_203_0.localEulerAngles

				var_203_6.z = 0
				var_203_6.x = 0
				var_203_0.localEulerAngles = var_203_6
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_203_7 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_7.x, var_203_7.y, var_203_7.z)

				local var_203_8 = var_203_0.localEulerAngles

				var_203_8.z = 0
				var_203_8.x = 0
				var_203_0.localEulerAngles = var_203_8
			end

			local var_203_9 = arg_200_1.actors_["1156ui_story"]
			local var_203_10 = 0

			if var_203_10 < arg_200_1.time_ and arg_200_1.time_ <= var_203_10 + arg_203_0 and not isNil(var_203_9) and arg_200_1.var_.characterEffect1156ui_story == nil then
				arg_200_1.var_.characterEffect1156ui_story = var_203_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_11 = 0.200000002980232

			if var_203_10 <= arg_200_1.time_ and arg_200_1.time_ < var_203_10 + var_203_11 and not isNil(var_203_9) then
				local var_203_12 = (arg_200_1.time_ - var_203_10) / var_203_11

				if arg_200_1.var_.characterEffect1156ui_story and not isNil(var_203_9) then
					arg_200_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_10 + var_203_11 and arg_200_1.time_ < var_203_10 + var_203_11 + arg_203_0 and not isNil(var_203_9) and arg_200_1.var_.characterEffect1156ui_story then
				arg_200_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_203_13 = 0

			if var_203_13 < arg_200_1.time_ and arg_200_1.time_ <= var_203_13 + arg_203_0 then
				arg_200_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156actionlink/1156action472")
			end

			local var_203_14 = 0

			if var_203_14 < arg_200_1.time_ and arg_200_1.time_ <= var_203_14 + arg_203_0 then
				arg_200_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_203_15 = 0
			local var_203_16 = 0.4

			if var_203_15 < arg_200_1.time_ and arg_200_1.time_ <= var_203_15 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_17 = arg_200_1:FormatText(StoryNameCfg[605].name)

				arg_200_1.leftNameTxt_.text = var_203_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_18 = arg_200_1:GetWordFromCfg(320292045)
				local var_203_19 = arg_200_1:FormatText(var_203_18.content)

				arg_200_1.text_.text = var_203_19

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_20 = 16
				local var_203_21 = utf8.len(var_203_19)
				local var_203_22 = var_203_20 <= 0 and var_203_16 or var_203_16 * (var_203_21 / var_203_20)

				if var_203_22 > 0 and var_203_16 < var_203_22 then
					arg_200_1.talkMaxDuration = var_203_22

					if var_203_22 + var_203_15 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_22 + var_203_15
					end
				end

				arg_200_1.text_.text = var_203_19
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320292", "320292045", "story_v_out_320292.awb") ~= 0 then
					local var_203_23 = manager.audio:GetVoiceLength("story_v_out_320292", "320292045", "story_v_out_320292.awb") / 1000

					if var_203_23 + var_203_15 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_23 + var_203_15
					end

					if var_203_18.prefab_name ~= "" and arg_200_1.actors_[var_203_18.prefab_name] ~= nil then
						local var_203_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_18.prefab_name].transform, "story_v_out_320292", "320292045", "story_v_out_320292.awb")

						arg_200_1:RecordAudio("320292045", var_203_24)
						arg_200_1:RecordAudio("320292045", var_203_24)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_320292", "320292045", "story_v_out_320292.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_320292", "320292045", "story_v_out_320292.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_25 = math.max(var_203_16, arg_200_1.talkMaxDuration)

			if var_203_15 <= arg_200_1.time_ and arg_200_1.time_ < var_203_15 + var_203_25 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_15) / var_203_25

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_15 + var_203_25 and arg_200_1.time_ < var_203_15 + var_203_25 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
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

		arg_200_1:InitPlayNodeList()
	end,
	Play320292046 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 320292046
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
			arg_204_1.auto_ = false
		end

		function arg_204_1.playNext_(arg_206_0)
			arg_204_1.onStoryFinished_()
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1156ui_story"].transform
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.var_.moveOldPos1156ui_story = var_207_0.localPosition
			end

			local var_207_2 = 0.001

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2
				local var_207_4 = Vector3.New(0, 100, 0)

				var_207_0.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1156ui_story, var_207_4, var_207_3)

				local var_207_5 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_5.x, var_207_5.y, var_207_5.z)

				local var_207_6 = var_207_0.localEulerAngles

				var_207_6.z = 0
				var_207_6.x = 0
				var_207_0.localEulerAngles = var_207_6
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 then
				var_207_0.localPosition = Vector3.New(0, 100, 0)

				local var_207_7 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_7.x, var_207_7.y, var_207_7.z)

				local var_207_8 = var_207_0.localEulerAngles

				var_207_8.z = 0
				var_207_8.x = 0
				var_207_0.localEulerAngles = var_207_8
			end

			local var_207_9 = 0
			local var_207_10 = 1.175

			if var_207_9 < arg_204_1.time_ and arg_204_1.time_ <= var_207_9 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_11 = arg_204_1:GetWordFromCfg(320292046)
				local var_207_12 = arg_204_1:FormatText(var_207_11.content)

				arg_204_1.text_.text = var_207_12

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_13 = 47
				local var_207_14 = utf8.len(var_207_12)
				local var_207_15 = var_207_13 <= 0 and var_207_10 or var_207_10 * (var_207_14 / var_207_13)

				if var_207_15 > 0 and var_207_10 < var_207_15 then
					arg_204_1.talkMaxDuration = var_207_15

					if var_207_15 + var_207_9 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_15 + var_207_9
					end
				end

				arg_204_1.text_.text = var_207_12
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_16 = math.max(var_207_10, arg_204_1.talkMaxDuration)

			if var_207_9 <= arg_204_1.time_ and arg_204_1.time_ < var_207_9 + var_207_16 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_9) / var_207_16

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_9 + var_207_16 and arg_204_1.time_ < var_207_9 + var_207_16 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
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

		arg_204_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XS0203",
		"TextureConfig/Background/L05g"
	},
	voices = {
		"story_v_out_320292.awb"
	}
}
